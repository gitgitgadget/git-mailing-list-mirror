Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28EC43217
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiCYTk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiCYThq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B121C551E
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h16so4982370wmd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TgVyyzQx+jhjmRIkDS0iZCqgyqnaNEg2KAffy6/1bAM=;
        b=ncIOj08jymICF19/X1KKE16oFI6hsESDIVKVr9fnI98M+mJzD9SHo6PESXz8oy7dHR
         sbeWfwRbYZhdRjLSXXLvz8u3aMb/6M/nTuPrIL16i+Ejv26sVsHv3olHYgkGqrPkOvvO
         +4fhZG3aLyg5wSqhs8jFTSPzWbuYJiVbqkTIbTPz7AmRNSGvWS/P9klCViDD8klyTN32
         yZeJnxgOxe6A7S0bkZIid0DCxjEcu53SesNF5QIL8fEYK2cFCo3uQ5L/gWfU3Ay5S5X2
         PjC8ziTwUW0cPgxL1mRUGpjsgcrS4GF9OdfioWIcvnHB0otVSOPt3PpNdgBqydLOOFL7
         xcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TgVyyzQx+jhjmRIkDS0iZCqgyqnaNEg2KAffy6/1bAM=;
        b=l6UB9z4i8wgUARZmE+zT+jC5m5rArMHJsSfrDidmQNm7WGRAHfYSPJldgwpYxQzSZ/
         hPqey2K9kxlYYBbPU/0GKzeOnRAln/V5wd+5+/1TzyyLpUmkqS1XuGGH+UpCeM8gO0+m
         tWW908Iiqv8y4J9Arb0AWFvOx8S2du/vAgyYJMXzmVP6yn9K9x1suDLsttFwFFAF20ja
         ACRchK84PS1Z2Jkr94ZrgkBXMyVDXGjKPXsG354xf/u8OYMox5zYB6DWlI0Ef3SGAYGf
         p68MMaaEYfKqPxpVQuwbCbMxnWo2wBAl2Z3OBlvnsBe677J5us/ofpcB0PxFY7ZGq9xK
         5JwA==
X-Gm-Message-State: AOAM53365Vm/01i+/OCcqtd64zQjM5NJNsQSgFE9ZY/Wgl1Wu6Obwp0S
        62bOrH4U7IQhzFtZTVqpoX0VsQRuQHM=
X-Google-Smtp-Source: ABdhPJwQKHiwrasUaZiQlbl/A1omOqUo5eh6q9agEECy89nsiXCb5u+8FFjxsS77eQ5nBtc1MUQ/Wg==
X-Received: by 2002:a05:600c:252:b0:38c:cd19:fbff with SMTP id 18-20020a05600c025200b0038ccd19fbffmr10264062wmj.65.1648231407305;
        Fri, 25 Mar 2022 11:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n124-20020a1ca482000000b0038c9cf6e296sm7255949wme.14.2022.03.25.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:26 -0700 (PDT)
Message-Id: <a6a39a3306df2602e06cc3d9a755fa247f8d41b0.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:54 +0000
Subject: [PATCH v9 11/30] fsmonitor--daemon: implement 'start' command
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 109 +++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 5591339399a..69dd39121a3 100644
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
 #define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
 static int fsmonitor__announce_startup = 0;
 
@@ -36,6 +40,15 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
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
 	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
 		int is_bool;
 		int i = git_config_bool_or_int(var, value, &is_bool);
@@ -250,7 +263,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(void)
+static int try_to_run_foreground_daemon(int detach_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -270,17 +283,106 @@ static int try_to_run_foreground_daemon(void)
 		fflush(stderr);
 	}
 
+#ifdef GIT_WINDOWS_NATIVE
+	if (detach_console)
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
+		die(_("fsmonitor--daemon is already running '%s'"),
+		    the_repository->worktree);
+
+	if (fsmonitor__announce_startup) {
+		fprintf(stderr, _("starting fsmonitor-daemon in '%s'\n"),
+			the_repository->worktree);
+		fflush(stderr);
+	}
+
+	cp.git_cmd = 1;
+
+	strvec_push(&cp.args, "fsmonitor--daemon");
+	strvec_push(&cp.args, "run");
+	strvec_push(&cp.args, "--detach");
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
+		return error(_("daemon failed to start"));
+
+	case SBGR_TIMEOUT:
+		return error(_("daemon not online yet"));
+
+	case SBGR_DIED:
+		return error(_("daemon terminated"));
+	}
+}
+
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
+	int detach_console = 0;
 
 	struct option options[] = {
+		OPT_BOOL(0, "detach", &detach_console, N_("detach from console")),
 		OPT_INTEGER(0, "ipc-threads",
 			    &fsmonitor__ipc_threads,
 			    N_("use <n> ipc worker threads")),
+		OPT_INTEGER(0, "start-timeout",
+			    &fsmonitor__start_timeout_sec,
+			    N_("max seconds to wait for background daemon startup")),
+
 		OPT_END()
 	};
 
@@ -296,8 +398,11 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	if (!strcmp(subcmd, "start"))
+		return !!try_to_start_background_daemon();
+
 	if (!strcmp(subcmd, "run"))
-		return !!try_to_run_foreground_daemon();
+		return !!try_to_run_foreground_daemon(detach_console);
 
 	if (!strcmp(subcmd, "stop"))
 		return !!do_as_client__send_stop();
-- 
gitgitgadget

