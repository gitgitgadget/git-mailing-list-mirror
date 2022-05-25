Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbiEYPB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBDAFAF3
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k30so30497972wrd.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s9t9Q4XW0lz3tr2ylEFcAfk51tlgxAPR8T+Lhple8cM=;
        b=JAPUpCLPBqt2auBv6VAUnPMr7AS7scweo6M6XC+rlSdWn4UrmYpsf7JAk2BkzIpxd/
         RC1A+8JeNFJ8cfH1MXzEmgKDB6HHaxJtabpnui4R0NvLsY5HtSClSceP+0YrG6ymyvbz
         sL/wa7XPQmcz9rvyttf0GnKO7NC9Rj0J14Q/1rzfksjAzFL8V0WWrCqIZVqHI9EdspNW
         JmyyTj+ZelGeCFEzrL9bs9I9VtoEOsuAWD+GruJvnktMwM0dWHLsPdNe7zPEWNNl3a5s
         KAcAH/odIy76DxakQKXnJYax6B0kEWVhYWjdTTh+dx+sUsIhHxnECWzgv4gilLynUTuV
         oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s9t9Q4XW0lz3tr2ylEFcAfk51tlgxAPR8T+Lhple8cM=;
        b=Pyz0ZlCwhRNtsmIqeQEWUk2/WUoCEHN/FuHgmzrXZzY8Pt3/2qUC56X05sNpJBNrLL
         MY5VrIdK16RcARE1YnYobnEK4YeCbfDRq79aYxSYpSetFhUaczrRHFykT9Y0pHt7zaR1
         HLqSmSVz/BsoYcAAYbswb2o+ZS+9HNevrrZ4YsvSYuoihiUKVmZdWm5S3mhUPqv0n0xY
         A1uRRfxgUDvoJv6aNHHZumCbkhBTNHkR0ZxQS/X7mYlzu3WaNQ9yVKrcFzG3QhhA8Y2V
         5H/Jfv6m/I766s+igAb3jK4AEXdhgySbd+eBRsX3YbpZzJEs4fnwGiDbt5c2h231WAdJ
         T8oQ==
X-Gm-Message-State: AOAM5322n+a4mSDRC7nA+mq+ZMwNjSLw/e/SbJpQAW+4oRSnsjm8G6Or
        Rio0VnfFktc6p6l5ih6rLN90kXG99fA=
X-Google-Smtp-Source: ABdhPJzLGmobocR7bW7hf+mUYMSO1a6xYSxU1Q/Sl7HI4zALVKjtKRh5Tb2gaPDYMpYKfg6lNRH7Tg==
X-Received: by 2002:adf:9bd9:0:b0:210:53f:c945 with SMTP id e25-20020adf9bd9000000b00210053fc945mr513710wrc.240.1653490878145;
        Wed, 25 May 2022 08:01:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c414800b0039740903c39sm2476229wmm.7.2022.05.25.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:17 -0700 (PDT)
Message-Id: <594e0ae243de868ff18f94aafc4358d5801b88c5.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:37 +0000
Subject: [PATCH v8 15/30] fsmonitor--daemon: rename listener thread related
 variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Rename platform-specific listener thread related variables
and data types as we prepare to add another backend thread
type.

[] `struct fsmonitor_daemon_backend_data` becomes `struct fsm_listen_data`
[] `state->backend_data` becomes `state->listen_data`
[] `state->error_code` becomes `state->listen_error_code`

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c          |  6 +++---
 compat/fsmonitor/fsm-listen-darwin.c | 30 ++++++++++++++--------------
 compat/fsmonitor/fsm-listen-win32.c  | 28 +++++++++++++-------------
 compat/fsmonitor/fsm-listen.h        |  2 +-
 fsmonitor--daemon.h                  |  6 +++---
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 90fa9d09efb..b2f578b239a 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1225,8 +1225,8 @@ cleanup:
 
 	if (err)
 		return err;
-	if (state->error_code)
-		return state->error_code;
+	if (state->listen_error_code)
+		return state->listen_error_code;
 	return 0;
 }
 
@@ -1241,7 +1241,7 @@ static int fsmonitor_run_daemon(void)
 	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
 	pthread_cond_init(&state.cookies_cond, NULL);
-	state.error_code = 0;
+	state.listen_error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 14105f45c18..07113205a61 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -27,7 +27,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 
-struct fsmonitor_daemon_backend_data
+struct fsm_listen_data
 {
 	CFStringRef cfsr_worktree_path;
 	CFStringRef cfsr_gitdir_path;
@@ -158,7 +158,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     const FSEventStreamEventId event_ids[])
 {
 	struct fsmonitor_daemon_state *state = ctx;
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	char **paths = (char **)event_paths;
 	struct fsmonitor_batch *batch = NULL;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -350,11 +350,11 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		NULL,
 		NULL
 	};
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 	const void *dir_array[2];
 
 	CALLOC_ARRAY(data, 1);
-	state->backend_data = data;
+	state->listen_data = data;
 
 	data->cfsr_worktree_path = CFStringCreateWithCString(
 		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
@@ -386,18 +386,18 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 failed:
 	error(_("Unable to create FSEventStream."));
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 	return -1;
 }
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	if (!state || !state->backend_data)
+	if (!state || !state->listen_data)
 		return;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	if (data->stream) {
 		if (data->stream_started)
@@ -407,14 +407,14 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 }
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	data = state->backend_data;
+	data = state->listen_data;
 	data->shutdown_style = SHUTDOWN_EVENT;
 
 	CFRunLoopStop(data->rl);
@@ -422,9 +422,9 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	data->rl = CFRunLoopGetCurrent();
 
@@ -441,7 +441,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:
-		state->error_code = -1;
+		state->listen_error_code = -1;
 		/* fall thru */
 	case FORCE_SHUTDOWN:
 		ipc_server_stop_async(state->ipc_server_data);
@@ -453,7 +453,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	return;
 
 force_error_stop_without_loop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 	ipc_server_stop_async(state->ipc_server_data);
 	return;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 7f48306df53..2943632c771 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -54,7 +54,7 @@ struct one_watch
 	wchar_t dotgit_shortname[16]; /* for 8.3 name */
 };
 
-struct fsmonitor_daemon_backend_data
+struct fsm_listen_data
 {
 	struct one_watch *watch_worktree;
 	struct one_watch *watch_gitdir;
@@ -284,7 +284,7 @@ static enum get_relative_result get_relative_longname(
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
-	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
+	SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
 }
 
 static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
@@ -359,7 +359,7 @@ static void destroy_watch(struct one_watch *watch)
 	free(watch);
 }
 
-static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
+static int start_rdcw_watch(struct fsm_listen_data *data,
 			    struct one_watch *watch)
 {
 	DWORD dwNotifyFilter =
@@ -538,7 +538,7 @@ static int process_1_worktree_event(
  */
 static int process_worktree_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_worktree;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -669,7 +669,7 @@ force_shutdown:
  */
 static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_gitdir;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -727,11 +727,11 @@ skip_this_path:
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	DWORD dwWait;
 	int result;
 
-	state->error_code = 0;
+	state->listen_error_code = 0;
 
 	if (start_rdcw_watch(data, data->watch_worktree) == -1)
 		goto force_error_stop;
@@ -796,7 +796,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 
 force_error_stop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 
 force_shutdown:
 	/*
@@ -813,7 +813,7 @@ clean_shutdown:
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
 	CALLOC_ARRAY(data, 1);
 
@@ -846,7 +846,7 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		data->nr_listener_handles++;
 	}
 
-	state->backend_data = data;
+	state->listen_data = data;
 	return 0;
 
 failed:
@@ -859,16 +859,16 @@ failed:
 
 void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	if (!state || !state->backend_data)
+	if (!state || !state->listen_data)
 		return;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	CloseHandle(data->hEventShutdown);
 	destroy_watch(data->watch_worktree);
 	destroy_watch(data->watch_gitdir);
 
-	FREE_AND_NULL(state->backend_data);
+	FREE_AND_NULL(state->listen_data);
 }
diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.h
index f0539349baf..41650bf8972 100644
--- a/compat/fsmonitor/fsm-listen.h
+++ b/compat/fsmonitor/fsm-listen.h
@@ -33,7 +33,7 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state);
  * do so if the listener thread receives a normal shutdown signal from
  * the IPC layer.)
  *
- * It should set `state->error_code` to -1 if the daemon should exit
+ * It should set `state->listen_error_code` to -1 if the daemon should exit
  * with an error.
  */
 void fsm_listen__loop(struct fsmonitor_daemon_state *state);
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 223c2131b58..2c6fa1a5d91 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -33,7 +33,7 @@ void fsmonitor_batch__free_list(struct fsmonitor_batch *batch);
  */
 void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const char *path);
 
-struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
+struct fsm_listen_data; /* opaque platform-specific data for listener thread */
 
 struct fsmonitor_daemon_state {
 	pthread_t listener_thread;
@@ -50,8 +50,8 @@ struct fsmonitor_daemon_state {
 	int cookie_seq;
 	struct hashmap cookies;
 
-	int error_code;
-	struct fsmonitor_daemon_backend_data *backend_data;
+	int listen_error_code;
+	struct fsm_listen_data *listen_data;
 
 	struct ipc_server_data *ipc_server_data;
 	struct strbuf path_ipc;
-- 
gitgitgadget

