Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC3C433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiEWUOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiEWUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4345DA8897
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k30so22890850wrd.5
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s9t9Q4XW0lz3tr2ylEFcAfk51tlgxAPR8T+Lhple8cM=;
        b=aATnghopVY3Nm0alaE3x0t++K8GdYxpPWe+xeB09iwYFE69FRchXkZOEsikvKpZNC0
         gFcvNQeEOJsU3BPD9u4WbVP2i20bIMapTfihABawac7p6PEpHubWsHSBkTbKncWn81JZ
         ZhfAPEtuEAEKziHeR9E7gL+CtsJx30Imu+FVnOw8SC5jCb1EEoAK8ScXfbBO6Pks4zgq
         Q+4p+nWfRetfKiWUHiz1IWcj/s05yDDXa6VvZ68RR2UCGcCTe/+DTw/S1dk3lRRpccgx
         SHgBTjK6iHhyMMVd1JIVzGa4h2ePJgI7POVZU+Uqy+8x4oujwM/RU5y7K35YQ/GXbmKp
         6IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s9t9Q4XW0lz3tr2ylEFcAfk51tlgxAPR8T+Lhple8cM=;
        b=PfexR3qHQApgii60AJxuSECzeICTkZV+1LnNI2uBa2+eX8uCG1Pv6gO6WI3elo8N2c
         3/4BokQV8Aw3olpoaRAUTzZlxuCO2gp+OLVq6pPhJF+9CHsLBmLf11kcPeqASZlbHzMJ
         AvTgrGBoXD+vLw0bF/ljB6SqpZ/g50pROvAfJEm+u5QvU5zpovy2Y30ihpJppJ1P1Fmz
         2+YbL611vZR8MeS2WPfbm7zsv+Fytu3NWtDfOxirx6PetqVKfQiKTAHL8KqpfdKoZtuY
         MrTUDZTCIY3xHTbOWB2AVxgfvDrCM3ocawtpwHmfJv0lpIs7GaJVb1AbL71Yf92XM/aH
         9C2g==
X-Gm-Message-State: AOAM532tG3EdUCbWHLGNUk/OBm8agEHUc9dPLqauwHORBoeTIdjF72uG
        MssKbP/XbiJGNwZSEQS5g1w53Rj7zac=
X-Google-Smtp-Source: ABdhPJz9bzPNAWmp5YUON8HInpLfJ20xcET0vhikrK/jAbvZY1zyviuyIalGbZ2yeDO7h4eHXLYEOw==
X-Received: by 2002:a05:6000:1565:b0:20e:651d:7ff4 with SMTP id 5-20020a056000156500b0020e651d7ff4mr20742084wrz.641.1653336788106;
        Mon, 23 May 2022 13:13:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003974d9d088fsm197218wmb.30.2022.05.23.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:07 -0700 (PDT)
Message-Id: <594e0ae243de868ff18f94aafc4358d5801b88c5.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:30 +0000
Subject: [PATCH v7 15/30] fsmonitor--daemon: rename listener thread related
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

