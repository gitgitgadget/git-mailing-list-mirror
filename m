Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C96C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiCHWRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350677AbiCHWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520C57B00
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r65so317324wma.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oR97VX81YJBvKrgvIt5LNRhlScrjAiYa/2tKkCcD+ig=;
        b=BU2z4B/vnOuoxJmUYL8Tiwxec5/TTSuI9LILv+QOOdHyHC0F7dzPcsdyVFtutAsNS/
         +oZgo2QEZx3yguckZ5CcNT0cZiyK++jjIB44nXkCFcz/zCupXRyGBwNLecdSc/rckvkg
         aAd1awDG1yZp8UFu1djsOPrg5Hzk0qmjn/DwgB+ZSC9e4XFhZgsml1xDe8iqxo/kPtA7
         0iEMhry9LJaAQ+lxyLKfwYmuursr9lg5FGnrNio8CkLEFUuhJMyTmCgoh15u/8mlTAxV
         i6Kl5vHl/2ktY/2umj4bFrj3MhbgpLXMsxhEmQ3tSGkp5TAmY3rXRmRU8JTHFZVIN3zR
         FSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oR97VX81YJBvKrgvIt5LNRhlScrjAiYa/2tKkCcD+ig=;
        b=6O29pvXdL/nuTkXlnBoxXlwGhUmFW3AdsM6ubQz07EsHxiRktHknFyQVRrYprpJu1A
         Fv6dQUoqhnPYmfdrTxWlfiBDoVlvP2B3sj48Rt3hCKs57KFlFz+Bls3VEswoIcW+wQA/
         kyajDUh7Ozm1CTtHVBBfjfJ3nVfQB0IjLN7hZBOpnnKyz+PVpm9nxZrJsNtfqcnXFZM6
         jS7++VUkhgeSljjj0giLG/OgCs9fBvVepYFpZqWbVyRfnZFwttAWrJNuKlj5mA5AnmJa
         zhIStcGpOzYnehcotuJuS2IcRaO1GnbukL2vgYl7C1RohlVEH/SWc144bAglX6JobeJ1
         KWjA==
X-Gm-Message-State: AOAM530ALu3SKWJTg6AP41EeYytyDwVi/WbvS6138AQrjlyYG8ZwBx++
        DNrF5alzMK+Ph60xCyQXxe4Tpm143+o=
X-Google-Smtp-Source: ABdhPJybwCpVnbdlAPofbxjRgw8XhfGT2iyN2PeWG/bHyB/ys/DZ87SE2yy+3X+nuod701ygKvNxLg==
X-Received: by 2002:a05:600c:154e:b0:381:81d1:8e78 with SMTP id f14-20020a05600c154e00b0038181d18e78mr5394383wmg.51.1646777745114;
        Tue, 08 Mar 2022 14:15:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d49ce000000b001f036a29f42sm75611wrs.116.2022.03.08.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:44 -0800 (PST)
Message-Id: <5387baaf5d78244ff079bdd92b99604d33e957bc.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:14 +0000
Subject: [PATCH v2 14/27] fsmonitor--daemon: rename listener thread related
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
index d5a8fc2ddc2..92c61d5b94d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1219,8 +1219,8 @@ cleanup:
 
 	if (err)
 		return err;
-	if (state->error_code)
-		return state->error_code;
+	if (state->listen_error_code)
+		return state->listen_error_code;
 	return 0;
 }
 
@@ -1235,7 +1235,7 @@ static int fsmonitor_run_daemon(void)
 	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
 	pthread_cond_init(&state.cookies_cond, NULL);
-	state.error_code = 0;
+	state.listen_error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index f9b61b7b1c0..7c81bc7e5bf 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -99,7 +99,7 @@ void FSEventStreamRelease(FSEventStreamRef stream);
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 
-struct fsmonitor_daemon_backend_data
+struct fsm_listen_data
 {
 	CFStringRef cfsr_worktree_path;
 	CFStringRef cfsr_gitdir_path;
@@ -230,7 +230,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     const FSEventStreamEventId event_ids[])
 {
 	struct fsmonitor_daemon_state *state = ctx;
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	char **paths = (char **)event_paths;
 	struct fsmonitor_batch *batch = NULL;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -422,11 +422,11 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
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
@@ -458,18 +458,18 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 failed:
 	error("Unable to create FSEventStream.");
 
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
@@ -479,14 +479,14 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
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
@@ -494,9 +494,9 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
-	data = state->backend_data;
+	data = state->listen_data;
 
 	data->rl = CFRunLoopGetCurrent();
 
@@ -513,7 +513,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:
-		state->error_code = -1;
+		state->listen_error_code = -1;
 		/* fall thru */
 	case FORCE_SHUTDOWN:
 		ipc_server_stop_async(state->ipc_server_data);
@@ -525,7 +525,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	return;
 
 force_error_stop_without_loop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 	ipc_server_stop_async(state->ipc_server_data);
 	return;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 948f0e63915..a7c5d263940 100644
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
@@ -263,7 +263,7 @@ static enum get_relative_result get_relative_longname(
 
 void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 {
-	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
+	SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
 }
 
 static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
@@ -337,7 +337,7 @@ static void destroy_watch(struct one_watch *watch)
 	free(watch);
 }
 
-static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
+static int start_rdcw_watch(struct fsm_listen_data *data,
 			    struct one_watch *watch)
 {
 	DWORD dwNotifyFilter =
@@ -516,7 +516,7 @@ static int process_1_worktree_event(
  */
 static int process_worktree_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_worktree;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -646,7 +646,7 @@ force_shutdown:
  */
 static int process_gitdir_events(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data = state->backend_data;
+	struct fsm_listen_data *data = state->listen_data;
 	struct one_watch *watch = data->watch_gitdir;
 	struct strbuf path = STRBUF_INIT;
 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
@@ -704,11 +704,11 @@ skip_this_path:
 
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
@@ -773,7 +773,7 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 
 force_error_stop:
-	state->error_code = -1;
+	state->listen_error_code = -1;
 
 force_shutdown:
 	/*
@@ -790,7 +790,7 @@ clean_shutdown:
 
 int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 {
-	struct fsmonitor_daemon_backend_data *data;
+	struct fsm_listen_data *data;
 
 	CALLOC_ARRAY(data, 1);
 
@@ -823,7 +823,7 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 		data->nr_listener_handles++;
 	}
 
-	state->backend_data = data;
+	state->listen_data = data;
 	return 0;
 
 failed:
@@ -836,16 +836,16 @@ failed:
 
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

