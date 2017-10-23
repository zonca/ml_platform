FROM ivukotic/ml_base:latest

LABEL maintainer Ilija Vukotic <ivukotic@cern.ch>

##############################
# Python 2 packages
##############################

RUN pip2 --no-cache-dir install \
        h5py \
        tables \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        Pillow \
        scipy \
        sklearn \
        qtpy \
        seaborn \
        tensorflow-gpu \
        keras \
        elasticsearch \
        gym \
        JSAnimation
RUN python2 -m ipykernel.kernelspec

#############################
# Python 3 packages
#############################

RUN pip3 --no-cache-dir install \
        h5py \
        tables \
        ipykernel \
        jupyter \
        notebook \
        matplotlib \
        numpy \
        pandas \
        Pillow \
        scipy \
        sklearn \
        qtpy \
        seaborn \
        tensorflow-gpu \
        keras \
        elasticsearch \
        gym \
        tensorflow-gpu \
        keras \
        elasticsearch \
        gym \
        JSAnimation
RUN python3 -m ipykernel.kernelspec

# jupyterhub support
RUN pip3 --no-cache-dir install jupyterhub==0.8.0 jupyterlab
# activate lab
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

COPY environment /environment
COPY exec        /.exec
COPY run         /.run
COPY shell       /.shell

RUN chmod 755 .exec .run .shell

RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

CMD ["jupyterhub-singleuser"]
