FROM ultralytics/yolov5:latest


ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ARG GPU=False
ARG CAMERA=TEST

# env for model
ENV MODEL_TYPE=yolov5s
ENV CAMERA_ADDR=$CAMERA
ENV RECORDING_MINUTES=1
ENV CATEGORY_NAME=0,16
ENV SHOW_FPS=True
ENV GPU_ON=$GPU
# ENV debug=True
ENV OUTPUT_LOG_PATH=/workspace

#TODO VOLUMENS

# Copy the requirements to model
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Copy the rest of the application code to the working directory
COPY . .


# Expose the port the app runs on
EXPOSE 8000

# Run the FastAPI application with uvicorn
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]