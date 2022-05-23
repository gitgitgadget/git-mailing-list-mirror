Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2BC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiEWUOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiEWUNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1FA7770
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso245508wmp.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fniMHDevgS+sy0VW9Irk7dpFWcke4CVDxXVC7jIjUKc=;
        b=JIMQoG4KQ8T0OyekcbBhawzgJbQKIZ6bJ+MqFoGGqD2AUQVzQwD++yzrK8bsNmOnrI
         5/OcY2WIv5ipD5VPyZy2kmQBL4X/11czqWXWO/MrMrZMLFS2/TTd9vR1uGVsMa37yOed
         6aqhx6t7H0SYOar2XASk1Jgwxc0cmD+/WEPERrwDixZGGmUxr01ygFjTtxtcnAKjlhWk
         JVZIqvho+d84PXtHH6Jw1B9Zr/q9w/C+NzaROYFnMIDmiK/tOP7yLJUveXi5teZu5lyC
         XubOJ8+lRVTcQDBNuBRozVG5r2O9mdY0Oj7k07Bk5iyGcYQ2ETrOGd0UybG0/LEGcPxe
         u9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fniMHDevgS+sy0VW9Irk7dpFWcke4CVDxXVC7jIjUKc=;
        b=dn6W3ZTv1WdaBLdaR4PyUoT/TMCOHYHhT5ZJk9AY3N5QRmzE8XzLc0ndfLnQr0n/Ze
         YYIH4QOx3JbVfZ9Q6K6wLJkXZkTbC2feCOijeoiaGJ4343XNlGdMsqOsCxid+aAk+X7O
         0N0yIoZ7o4TKtM55vpnLSvnOclWSen0/p60nWgJJFhXYsS3gog8aj6tZt9M5MDm4gI31
         bLm2VuiF8zoHHC70FgdazoxNWK7dM3xQzRzZxWtlOMEcpd/OiqKIB/xKzCm/eBVU7IXa
         OwaOfNq5zqwf5xFr1ipd3n7wtzHy9tU7pp/1c1W9AgueTsj+Lt2W1FSHu044pEA6fFS7
         1Asw==
X-Gm-Message-State: AOAM5332fPjeCvJRGaND8eYvg+dccbMZzf3AlZBaPlfEVByi5PrPY+OS
        H7EYZNBCvYf2OCEvUEsd8Q1TW98FfXo=
X-Google-Smtp-Source: ABdhPJwkI574mpiJdZgxYAtW9DLdiL817wwlvCpLskkk7BaBZDuLI6OkixhDMabnGoTHrF0f5XqPcQ==
X-Received: by 2002:a05:600c:3641:b0:38e:4b2f:330 with SMTP id y1-20020a05600c364100b0038e4b2f0330mr639230wmq.180.1653336785918;
        Mon, 23 May 2022 13:13:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020adfc788000000b0020fcc655e4asm6982702wrg.5.2022.05.23.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:05 -0700 (PDT)
Message-Id: <427dec412a559bffab789126ff8fe34eaef346fd.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:28 +0000
Subject: [PATCH v7 13/30] fsmonitor--daemon: cd out of worktree root
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

Teach the fsmonitor--daemon to CD outside of the worktree
before starting up.

The common Git startup mechanism causes the CWD of the daemon process
to be in the root of the worktree.  On Windows, this causes the daemon
process to hold a locked handle on the CWD and prevents other
processes from moving or deleting the worktree while the daemon is
running.

CD to HOME before entering main event loops.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c         | 32 +++++++++++++++++++++++++++--
 compat/fsmonitor/fsm-listen-win32.c | 22 ++++++++++++++------
 fsmonitor--daemon.h                 |  1 +
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 66b78a0353f..db297649daf 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1181,11 +1181,11 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * before we need it.
 	 */
 	if (ipc_server_run_async(&state->ipc_server_data,
-				 fsmonitor_ipc__get_path(), &ipc_opts,
+				 state->path_ipc.buf, &ipc_opts,
 				 handle_client, state))
 		return error_errno(
 			_("could not start IPC thread pool on '%s'"),
-			fsmonitor_ipc__get_path());
+			state->path_ipc.buf);
 
 	/*
 	 * Start the fsmonitor listener thread to collect filesystem
@@ -1220,6 +1220,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 static int fsmonitor_run_daemon(void)
 {
 	struct fsmonitor_daemon_state state;
+	const char *home;
 	int err;
 
 	memset(&state, 0, sizeof(state));
@@ -1289,6 +1290,15 @@ static int fsmonitor_run_daemon(void)
 
 	strbuf_addch(&state.path_cookie_prefix, '/');
 
+	/*
+	 * We create a named-pipe or unix domain socket inside of the
+	 * ".git" directory.  (Well, on Windows, we base our named
+	 * pipe in the NPFS on the absolute path of the git
+	 * directory.)
+	 */
+	strbuf_init(&state.path_ipc, 0);
+	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1298,6 +1308,23 @@ static int fsmonitor_run_daemon(void)
 		goto done;
 	}
 
+	/*
+	 * CD out of the worktree root directory.
+	 *
+	 * The common Git startup mechanism causes our CWD to be the
+	 * root of the worktree.  On Windows, this causes our process
+	 * to hold a locked handle on the CWD.  This prevents the
+	 * worktree from being moved or deleted while the daemon is
+	 * running.
+	 *
+	 * We assume that our FS and IPC listener threads have either
+	 * opened all of the handles that they need or will do
+	 * everything using absolute paths.
+	 */
+	home = getenv("HOME");
+	if (home && *home && chdir(home))
+		die_errno(_("could not cd home '%s'"), home);
+
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
@@ -1310,6 +1337,7 @@ done:
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
 	strbuf_release(&state.path_cookie_prefix);
+	strbuf_release(&state.path_ipc);
 
 	return err;
 }
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 0a86aea3f7e..7f48306df53 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -424,12 +424,22 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	}
 
 	/*
-	 * NEEDSWORK: If an external <gitdir> is deleted, the above
-	 * returns an error.  I'm not sure that there's anything that
-	 * we can do here other than failing -- the <worktree>/.git
-	 * link file would be broken anyway.  We might try to check
-	 * for that and return a better error message, but I'm not
-	 * sure it is worth it.
+	 * GetOverlappedResult() fails if the watched directory is
+	 * deleted while we were waiting for an overlapped IO to
+	 * complete.  The documentation did not list specific errors,
+	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
+	 * testing.
+	 *
+	 * Note that we only get notificaiton events for events
+	 * *within* the directory, not *on* the directory itself.
+	 * (These might be properies of the parent directory, for
+	 * example).
+	 *
+	 * NEEDSWORK: We might try to check for the deleted directory
+	 * case and return a better error message, but I'm not sure it
+	 * is worth it.
+	 *
+	 * Shutdown if we get any error.
 	 */
 
 	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index bd09fffc176..223c2131b58 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -54,6 +54,7 @@ struct fsmonitor_daemon_state {
 	struct fsmonitor_daemon_backend_data *backend_data;
 
 	struct ipc_server_data *ipc_server_data;
+	struct strbuf path_ipc;
 };
 
 /*
-- 
gitgitgadget

