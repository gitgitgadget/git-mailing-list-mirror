Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A17DC433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiCVSCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiCVSCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9266202
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q8so13190822wrc.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=27pKE5W50Xq6AWPWel8FWJuFD8Gh8CWrIgNTdeQM9Z0=;
        b=iCGEJyddh32OzOH+90hVDabOVTUj3BdbSgL1OikPf6is/T5EwEhvV92LvggxigzmDN
         tJyoKGxotFJE6yIo3KuXCkODCU+GSM2c4QPzgo2kI2vCJ68pf2H8ukqtRP0uHL94+c9f
         H6/4B0Cya4Fn9mMaQBEHTzb3NHfNr/ven4XZMl++BSA+539GFqNkNiFH3zdkmIPAKlor
         8T5HMfH6+x6c6XqGYASwxe7U3lXitma7fpoNtkiec4J3XgIWIR3WUvckaj/AxBEkZXFZ
         5fT228r5SamT5k+UX4JWdlGLlYd2L9zqvnr4pJv7F7ce+MVXpv+6IU0/UrRAkDEB8+8R
         uFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=27pKE5W50Xq6AWPWel8FWJuFD8Gh8CWrIgNTdeQM9Z0=;
        b=SoYpJUNEfXrzZQgFtqsrtICU3EMgp7t/EdxdytdCxWoEnt4lCyrM9f+KOZSxJw4imd
         TzIkVufrpmVFcAI3TNIyP7UHmpya3tQKvnG0Th0i8oO5MHFqCiHfVvAOsrGtlqT+EwPo
         tQ4/G4EyMUdGAT82aRyS56tdr30EctPtWhL0EOcg1k+G6/R1RWW1tTdeXTfLIUH3d2T1
         Lbj7PRRlRIrpJTHNqFg0D7XFaIYG4o4qcEQWOdp23b06VF6xk2JXy7nXlDgVClErSsRP
         Lxoyf7uRx9/23lBmTxOMAudU9vejH/FoV+se6IhicGDT7tDWYfh3FaqjYqn/LXKBYBjM
         5kXQ==
X-Gm-Message-State: AOAM531VgD0VlmZ7IM4eqVJs9/tgNVkWGZlMS5zxEBuFW5boDCFQQRQ1
        4PNZMeOaHNL/3/sg9e+58r2cegG9GQ8=
X-Google-Smtp-Source: ABdhPJzXv6iTCXGvgTBVHJcYTc2icrRvLM79+POVerHnigNhww66ZJoFKpoWnaGGI+F/yqCZcvXUGg==
X-Received: by 2002:adf:fe10:0:b0:203:d794:93e6 with SMTP id n16-20020adffe10000000b00203d79493e6mr23416874wrr.588.1647972030989;
        Tue, 22 Mar 2022 11:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm3279092wmh.41.2022.03.22.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:30 -0700 (PDT)
Message-Id: <f07800690eeda000271b05435aa032ba17b35086.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:51 +0000
Subject: [PATCH v7 10/29] fsmonitor--daemon: implement 'run' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement `run` command to try to begin listening for file system events.

This version defines the thread structure with a single fsmonitor_fs_listen
thread to watch for file system events and a simple IPC thread pool to
watch for connection from Git clients over a well-known named pipe or
Unix domain socket.

This commit does not actually do anything yet because the platform
backends are still just stubs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 228 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |  34 ++++++
 2 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 fsmonitor--daemon.h

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 5e3178b8bdd..5591339399a 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -3,16 +3,52 @@
 #include "parse-options.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "compat/fsmonitor/fsm-listen.h"
+#include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon run [<options>]"),
 	N_("git fsmonitor--daemon stop"),
 	N_("git fsmonitor--daemon status"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Global state loaded from config.
+ */
+#define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
+static int fsmonitor__ipc_threads = 8;
+
+#define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
+static int fsmonitor__announce_startup = 0;
+
+static int fsmonitor_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
+		int i = git_config_int(var, value);
+		if (i < 1)
+			return error(_("value of '%s' out of range: %d"),
+				     FSMONITOR__IPC_THREADS, i);
+		fsmonitor__ipc_threads = i;
+		return 0;
+	}
+
+	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
+		int is_bool;
+		int i = git_config_bool_or_int(var, value, &is_bool);
+		if (i < 0)
+			return error(_("value of '%s' not bool or int: %d"),
+				     var, i);
+		fsmonitor__announce_startup = i;
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 /*
  * Acting as a CLIENT.
  *
@@ -57,15 +93,198 @@ static int do_as_client__status(void)
 	}
 }
 
+static ipc_server_application_cb handle_client;
+
+static int handle_client(void *data,
+			 const char *command, size_t command_len,
+			 ipc_server_reply_cb *reply,
+			 struct ipc_server_reply_data *reply_data)
+{
+	/* struct fsmonitor_daemon_state *state = data; */
+	int result;
+
+	/*
+	 * The Simple IPC API now supports {char*, len} arguments, but
+	 * FSMonitor always uses proper null-terminated strings, so
+	 * we can ignore the command_len argument.  (Trust, but verify.)
+	 */
+	if (command_len != strlen(command))
+		BUG("FSMonitor assumes text messages");
+
+	trace2_region_enter("fsmonitor", "handle_client", the_repository);
+	trace2_data_string("fsmonitor", the_repository, "request", command);
+
+	result = 0; /* TODO Do something here. */
+
+	trace2_region_leave("fsmonitor", "handle_client", the_repository);
+
+	return result;
+}
+
+static void *fsm_listen__thread_proc(void *_state)
+{
+	struct fsmonitor_daemon_state *state = _state;
+
+	trace2_thread_start("fsm-listen");
+
+	trace_printf_key(&trace_fsmonitor, "Watching: worktree '%s'",
+			 state->path_worktree_watch.buf);
+	if (state->nr_paths_watching > 1)
+		trace_printf_key(&trace_fsmonitor, "Watching: gitdir '%s'",
+				 state->path_gitdir_watch.buf);
+
+	fsm_listen__loop(state);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
+{
+	struct ipc_server_opts ipc_opts = {
+		.nr_threads = fsmonitor__ipc_threads,
+
+		/*
+		 * We know that there are no other active threads yet,
+		 * so we can let the IPC layer temporarily chdir() if
+		 * it needs to when creating the server side of the
+		 * Unix domain socket.
+		 */
+		.uds_disallow_chdir = 0
+	};
+
+	/*
+	 * Start the IPC thread pool before the we've started the file
+	 * system event listener thread so that we have the IPC handle
+	 * before we need it.
+	 */
+	if (ipc_server_run_async(&state->ipc_server_data,
+				 fsmonitor_ipc__get_path(), &ipc_opts,
+				 handle_client, state))
+		return error_errno(
+			_("could not start IPC thread pool on '%s'"),
+			fsmonitor_ipc__get_path());
+
+	/*
+	 * Start the fsmonitor listener thread to collect filesystem
+	 * events.
+	 */
+	if (pthread_create(&state->listener_thread, NULL,
+			   fsm_listen__thread_proc, state) < 0) {
+		ipc_server_stop_async(state->ipc_server_data);
+		ipc_server_await(state->ipc_server_data);
+
+		return error(_("could not start fsmonitor listener thread"));
+	}
+
+	/*
+	 * The daemon is now fully functional in background threads.
+	 * Wait for the IPC thread pool to shutdown (whether by client
+	 * request or from filesystem activity).
+	 */
+	ipc_server_await(state->ipc_server_data);
+
+	/*
+	 * The fsmonitor listener thread may have received a shutdown
+	 * event from the IPC thread pool, but it doesn't hurt to tell
+	 * it again.  And wait for it to shutdown.
+	 */
+	fsm_listen__stop_async(state);
+	pthread_join(state->listener_thread, NULL);
+
+	return state->error_code;
+}
+
+static int fsmonitor_run_daemon(void)
+{
+	struct fsmonitor_daemon_state state;
+	int err;
+
+	memset(&state, 0, sizeof(state));
+
+	pthread_mutex_init(&state.main_lock, NULL);
+	state.error_code = 0;
+	state.current_token_data = NULL;
+
+	/* Prepare to (recursively) watch the <worktree-root> directory. */
+	strbuf_init(&state.path_worktree_watch, 0);
+	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
+	state.nr_paths_watching = 1;
+
+	/*
+	 * We create and delete cookie files somewhere inside the .git
+	 * directory to help us keep sync with the file system.  If
+	 * ".git" is not a directory, then <gitdir> is not inside the
+	 * cone of <worktree-root>, so set up a second watch to watch
+	 * the <gitdir> so that we get events for the cookie files.
+	 */
+	strbuf_init(&state.path_gitdir_watch, 0);
+	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
+	strbuf_addstr(&state.path_gitdir_watch, "/.git");
+	if (!is_directory(state.path_gitdir_watch.buf)) {
+		strbuf_reset(&state.path_gitdir_watch);
+		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
+		state.nr_paths_watching = 2;
+	}
+
+	/*
+	 * Confirm that we can create platform-specific resources for the
+	 * filesystem listener before we bother starting all the threads.
+	 */
+	if (fsm_listen__ctor(&state)) {
+		err = error(_("could not initialize listener thread"));
+		goto done;
+	}
+
+	err = fsmonitor_run_daemon_1(&state);
+
+done:
+	pthread_mutex_destroy(&state.main_lock);
+	fsm_listen__dtor(&state);
+
+	ipc_server_free(state.ipc_server_data);
+
+	strbuf_release(&state.path_worktree_watch);
+	strbuf_release(&state.path_gitdir_watch);
+
+	return err;
+}
+
+static int try_to_run_foreground_daemon(void)
+{
+	/*
+	 * Technically, we don't need to probe for an existing daemon
+	 * process, since we could just call `fsmonitor_run_daemon()`
+	 * and let it fail if the pipe/socket is busy.
+	 *
+	 * However, this method gives us a nicer error message for a
+	 * common error case.
+	 */
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		die(_("fsmonitor--daemon is already running '%s'"),
+		    the_repository->worktree);
+
+	if (fsmonitor__announce_startup) {
+		fprintf(stderr, _("running fsmonitor-daemon in '%s'\n"),
+			the_repository->worktree);
+		fflush(stderr);
+	}
+
+	return !!fsmonitor_run_daemon();
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
 
 	struct option options[] = {
+		OPT_INTEGER(0, "ipc-threads",
+			    &fsmonitor__ipc_threads,
+			    N_("use <n> ipc worker threads")),
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(fsmonitor_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_fsmonitor__daemon_usage, 0);
@@ -73,6 +292,13 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
 	subcmd = argv[0];
 
+	if (fsmonitor__ipc_threads < 1)
+		die(_("invalid 'ipc-threads' value (%d)"),
+		    fsmonitor__ipc_threads);
+
+	if (!strcmp(subcmd, "run"))
+		return !!try_to_run_foreground_daemon();
+
 	if (!strcmp(subcmd, "stop"))
 		return !!do_as_client__send_stop();
 
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
new file mode 100644
index 00000000000..3009c1a83de
--- /dev/null
+++ b/fsmonitor--daemon.h
@@ -0,0 +1,34 @@
+#ifndef FSMONITOR_DAEMON_H
+#define FSMONITOR_DAEMON_H
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+#include "cache.h"
+#include "dir.h"
+#include "run-command.h"
+#include "simple-ipc.h"
+#include "thread-utils.h"
+
+struct fsmonitor_batch;
+struct fsmonitor_token_data;
+
+struct fsmonitor_daemon_backend_data; /* opaque platform-specific data */
+
+struct fsmonitor_daemon_state {
+	pthread_t listener_thread;
+	pthread_mutex_t main_lock;
+
+	struct strbuf path_worktree_watch;
+	struct strbuf path_gitdir_watch;
+	int nr_paths_watching;
+
+	struct fsmonitor_token_data *current_token_data;
+
+	int error_code;
+	struct fsmonitor_daemon_backend_data *backend_data;
+
+	struct ipc_server_data *ipc_server_data;
+};
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSMONITOR_DAEMON_H */
-- 
gitgitgadget

