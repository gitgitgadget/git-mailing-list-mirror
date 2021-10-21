Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60694C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B946120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJUO1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJUO1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F395C06122A
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m42so903846wms.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7tZJjMAc3V/rH8V47Q4W4BdmV4UxbZzHrR96wmhnFh4=;
        b=YDYhW5VrP8TIhUGJiWoZOCAjcmUoymXv9/dQ3GCWpNPtsD+1aiF7zVxt8LJGUUv9ng
         Ej7+NOJdl71SxORaiLsbAZYu4+qApBIL0w1Qp1SfaXEtFO0CSDDWQv0oyd2oH2JZqpIi
         jqGF6CwiMiM1clcFGRh/yWe4TSoPyYfaGKwTZmqWFqlE86I2O95zjfBWkzEiFgNq8WM7
         zfzNEHTxxNa/Uk/hjo3ESJqMUoIYznOV6WgN+Mr44/U++UGwsDyrHJ+CfH0QyPCSJaSq
         rIvEffbM/Z6YWwShbobYDs2L3AGjZ/LWC4Ti5Wj/iwnDr3at77ZOjcgRW0UfXFZsRj+e
         LqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7tZJjMAc3V/rH8V47Q4W4BdmV4UxbZzHrR96wmhnFh4=;
        b=aCBofeLDDWvYB45OwBvp4MG/RkiAutFa5VXs4IyKW3UUtMlHlOl8viICswkwZomio0
         GC0saiZZDv6gibvL0paj2UQM1frBdka/0PGJ76OmHGkCjaG41tibr/2SqWCahXqpuY4R
         0ydfS95bR+/iztZ8rdxv/fg8Ai/Y/6Umn35W1TZYPM9Gfd+reyxkTM1PMJnu1DDjVFA9
         Hw8+A4oBHyipwrRhIWDnMGA4gytySf8oxcLOhPL8YY34NkW/MVPcV5aZPazStl63G9CD
         a85ph5fhwZl7MsW53a9pk9aaoLsJL6InXIxSTfrSTIOzEddN5EFrA1755nSQ/o+tF60D
         7ckA==
X-Gm-Message-State: AOAM531yWD8XAlXCRDWqonxCz751rKycZGV+4jppcW9ZpodpeJly1394
        E6xhWrsFwvMA5mgHrbsUwEy4Gg/pWA8=
X-Google-Smtp-Source: ABdhPJw9Hm1MUGdA3JbJdezLMLsTNeXvwW8y81Tl+SlNdZCvlivr2emZDTogSWcgQkdO4sz+55+gRw==
X-Received: by 2002:a1c:1d44:: with SMTP id d65mr2165551wmd.29.1634826317952;
        Thu, 21 Oct 2021 07:25:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w26sm5049361wmk.34.2021.10.21.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:17 -0700 (PDT)
Message-Id: <d08c28b549c4835514375b1c457a564eeb336c7d.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:51 +0000
Subject: [PATCH v4 11/29] fsmonitor--daemon: implement 'start' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement 'git fsmonitor--daemon start' command.  This command starts
an instance of 'git fsmonitor--daemon run' in the background using
the new 'start_bg_command()' function.

We avoid the fork-and-call technique on Unix systems in favor of a
fork-and-exec technique.  This gives us more uniform Trace2 child-*
events.  It also makes our usage more consistent with Windows usage.

On Windows, teach 'git fsmonitor--daemon run' to optionally call
'FreeConsole()' to release handles to the inherited Win32 console
(despite being passed invalid handles for stdin/out/err).  Without
this, command prompts and powershell terminal windows could hang
in "exit" until the last background child process exited or released
their Win32 console handle.  (This was not seen with git-bash shells
because they don't have a Win32 console attached to them.)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 107 +++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b5ebd1eca33..8988440b7c1 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -9,6 +9,7 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon start [<options>]"),
 	N_("git fsmonitor--daemon run [<options>]"),
 	N_("git fsmonitor--daemon stop"),
 	N_("git fsmonitor--daemon status"),
@@ -22,6 +23,9 @@ static const char * const builtin_fsmonitor__daemon_usage[] = {
 #define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
 static int fsmonitor__ipc_threads = 8;
 
+#define FSMONITOR__START_TIMEOUT "fsmonitor.starttimeout"
+static int fsmonitor__start_timeout_sec = 60;
+
 static int fsmonitor_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
@@ -33,6 +37,15 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
+		int i = git_config_int(var, value);
+		if (i < 0)
+			return error(_("value of '%s' out of range: %d"),
+				     FSMONITOR__START_TIMEOUT, i);
+		fsmonitor__start_timeout_sec = i;
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -237,7 +250,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(void)
+static int try_to_run_foreground_daemon(int free_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -255,17 +268,104 @@ static int try_to_run_foreground_daemon(void)
 	       the_repository->worktree);
 	fflush(stdout);
 
+#ifdef GIT_WINDOWS_NATIVE
+	if (free_console)
+		FreeConsole();
+#endif
+
 	return !!fsmonitor_run_daemon();
 }
 
+static start_bg_wait_cb bg_wait_cb;
+
+static int bg_wait_cb(const struct child_process *cp, void *cb_data)
+{
+	enum ipc_active_state s = fsmonitor_ipc__get_state();
+
+	switch (s) {
+	case IPC_STATE__LISTENING:
+		/* child is "ready" */
+		return 0;
+
+	case IPC_STATE__NOT_LISTENING:
+	case IPC_STATE__PATH_NOT_FOUND:
+		/* give child more time */
+		return 1;
+
+	default:
+	case IPC_STATE__INVALID_PATH:
+	case IPC_STATE__OTHER_ERROR:
+		/* all the time in world won't help */
+		return -1;
+	}
+}
+
+static int try_to_start_background_daemon(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	enum start_bg_result sbgr;
+
+	/*
+	 * Before we try to create a background daemon process, see
+	 * if a daemon process is already listening.  This makes it
+	 * easier for us to report an already-listening error to the
+	 * console, since our spawn/daemon can only report the success
+	 * of creating the background process (and not whether it
+	 * immediately exited).
+	 */
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		die("fsmonitor--daemon is already running '%s'",
+		    the_repository->worktree);
+
+	printf(_("starting fsmonitor-daemon in '%s'\n"),
+	       the_repository->worktree);
+	fflush(stdout);
+
+	cp.git_cmd = 1;
+
+	strvec_push(&cp.args, "fsmonitor--daemon");
+	strvec_push(&cp.args, "run");
+	strvec_push(&cp.args, "--free-console");
+	strvec_pushf(&cp.args, "--ipc-threads=%d", fsmonitor__ipc_threads);
+
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.no_stderr = 1;
+
+	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
+				fsmonitor__start_timeout_sec);
+
+	switch (sbgr) {
+	case SBGR_READY:
+		return 0;
+
+	default:
+	case SBGR_ERROR:
+	case SBGR_CB_ERROR:
+		return error("daemon failed to start");
+
+	case SBGR_TIMEOUT:
+		return error("daemon not online yet");
+
+	case SBGR_DIED:
+		return error("daemon terminated");
+	}
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
+	int free_console = 0;
 
 	struct option options[] = {
+		OPT_BOOL(0, "free-console", &free_console, N_("free console")),
 		OPT_INTEGER(0, "ipc-threads",
 			    &fsmonitor__ipc_threads,
 			    N_("use <n> ipc worker threads")),
+		OPT_INTEGER(0, "start-timeout",
+			    &fsmonitor__start_timeout_sec,
+			    N_("Max seconds to wait for background daemon startup")),
+
 		OPT_END()
 	};
 
@@ -281,8 +381,11 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	if (!strcmp(subcmd, "start"))
+		return !!try_to_start_background_daemon();
+
 	if (!strcmp(subcmd, "run"))
-		return !!try_to_run_foreground_daemon();
+		return !!try_to_run_foreground_daemon(free_console);
 
 	if (!strcmp(subcmd, "stop"))
 		return !!do_as_client__send_stop();
-- 
gitgitgadget

