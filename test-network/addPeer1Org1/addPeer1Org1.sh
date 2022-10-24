export PATH=${PWD}/../../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
export VERBOSE=false

. ${PWD}/scripts/utils.sh
# . ../../scripts/utils.sh

: ${CONTAINER_CLI:="docker"}
: ${CONTAINER_CLI_COMPOSE:="${CONTAINER_CLI}-compose"}
: ${SYSTEM_PRUNE:="${CONTAINER_CLI} system prune"}

# Get docker sock path from environment variable
SOCK="${DOCKER_HOST:-/var/run/docker.sock}"
DOCKER_SOCK="${SOCK##unix://}"

COMPOSE_FILE_BASE=${PWD}/addPeer1Org1/compose/docker-compose-org1.yaml
COMPOSE_FILE_PEER=${PWD}/addPeer1Org1/compose/docker/docker-compose-org1.yaml

# system prune

# set -x
# DOCKER_SOCK=${SYSTEM_PRUNE}
# { set +x; } 2>/dev/null

set -x
DOCKER_SOCK=${DOCKER_SOCK} ${CONTAINER_CLI_COMPOSE} -f ${COMPOSE_FILE_BASE} -f $COMPOSE_FILE_PEER up -d 2>&1
{ set +x; } 2>/dev/null


## KEEP IN MIND
# dont forget to run the docker system prune command if you are facing like this below issue
# failed to create shim: OCI runtime create failed: container_linux.go:380: starting container process caused: process_linux.go:545: container init caused: rootfs_linux.go:75: mounting "/run/desktop/mnt/host/wsl/docker-desktop-bind-mounts/Ubuntu-18.04/746a3d6b9ee3140817c44b0a4f488e31d077859a430f551996d38f0a36a4483b" to rootfs at "/etc/hyperledger/fabric" caused: mount through procfd: no such file or directory: unknown