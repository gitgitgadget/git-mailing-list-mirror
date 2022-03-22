Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16004C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbiCVSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiCVSCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10366637
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so23547383wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TgVyyzQx+jhjmRIkDS0iZCqgyqnaNEg2KAffy6/1bAM=;
        b=mZPKtBfRMbIPeBTJdp1hWDO4odzV215gh4ZntWIJ9zMNTni1jDKmdSRuyxB2H2sKTI
         DdTf27mUFFiTntmVwLv23PW05+g/Ml9X27cT8To3xlxEMIMKeyj0D3Dy8dPmwxg2Qd6p
         WxlA5KLRG2sRbJlosXln+usKYyanjlaz2aLz4PkhqjyKHbYdxP8EUzAu2tBM3nPC5jFI
         h72Py/WJQFIx69UONoBz0IC+j1IfPmMOqZwB6S14I2JiZKNi8a3N+txBZ1KFXb3uUpOW
         jyU2t7OZirzNd5MlWa1CZmQh89epGVnPXGY7FH6Gy2FWL/rhaZHXijzsElEy9+qUa1B0
         SIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TgVyyzQx+jhjmRIkDS0iZCqgyqnaNEg2KAffy6/1bAM=;
        b=keTkOgaOydCe36qAyXI8SlXpmHVFQV1A22cAltfQwVoAsnNvgKL1h0NJKaQGYO5I2a
         9XUNFoKDDBnhu5pBXz1ZVnU1yrkSJjkmbraKI1IPpW4vJppqG9DlvCN63VYeOZ9B22Pa
         SkTAJgcGeAXlIlYjHTnRsWfO73wnKUFEQ0R5s3Ed3iRRakN/BC87KsLUCxjDvO84mDu2
         xZJrmePCyiLHJ7eiHQzkQqz1gdXQ+D9VHw8ppkXKuPJpndsBoQnk6gfuYKtVOHBTsMLa
         5h/yTASzR4k6M59K4IVMdk1IZh32m91utsJAieLqYjbUrTiqalfxQV10MCEbfrp9iAS1
         O4OQ==
X-Gm-Message-State: AOAM5325DKjzzSqtJ+SsHHEnoUxIOEnHrkyNLEgX9XrUFNVGnAP3zgfu
        6uZmP5N5vrX7t74BoUsihnEUbPP9wME=
X-Google-Smtp-Source: ABdhPJwcmA32i153AFqfWecR6eTJLcRL1sLyenYlKHy2IQWEnQEYp1F/VBdlZzzl91sqK22DiCa1bg==
X-Received: by 2002:a5d:588b:0:b0:204:1c1a:965d with SMTP id n11-20020a5d588b000000b002041c1a965dmr7013104wrf.669.1647972032219;
        Tue, 22 Mar 2022 11:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm15991310wru.75.2022.03.22.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:31 -0700 (PDT)
Message-Id: <a6a39a3306df2602e06cc3d9a755fa247f8d41b0.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:52 +0000
Subject: [PATCH v7 11/29] fsmonitor--daemon: implement 'start' command
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

