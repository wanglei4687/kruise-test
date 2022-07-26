MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

.PHONY: up
up:
	@kind create cluster
	@kubectl create ns kruise
	@helm repo add openkruise https://openkruise.github.io/charts/
	@helm repo update
	@helm install kruise openkruise/kruise --version 1.2.0 -n kruise


.PHONY: rm
rm:
	@helm uninstall kruise -n kruise


.PHONY: check
check:
	@kubectl get po -n kruise -o wide

.PHONY: watch
watch:
	@watch kubectl get po -n kruise -o wide

.PHON: dc
dc:
	@kubectl apply -f cloneset.yml -n kruise

.PHONY: down
down:
	@kind delete cluster
