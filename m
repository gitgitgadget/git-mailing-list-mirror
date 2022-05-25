Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963EC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiEYPCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D3AF338
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so30521671wra.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fniMHDevgS+sy0VW9Irk7dpFWcke4CVDxXVC7jIjUKc=;
        b=a5dL8AyZifYhFA94jPAzaFI+mj76+2U6xSr4dYQzMPci+71c99h88AfB3ijpoRGUo/
         IZc7c952hm0N0JNIVS1Y4yPTwq3LtdFO0iTAmVtYg0RcQ6gS4bDrotkaJsEI7XBnUvFM
         T0qOErIUEhbEMcckeR4BLOsWg6LHtrh03V6/TVG/4MWn4bjKd5w06Eud8NyHY/TmO+9A
         5cOidOZW4nJGgQ+v6AbWYBa4LWdHuQNDTc4Td9n1QCXUjQGmi4MzAEu6b55zM7uDIsSr
         yxARWyYgYZXrDOPc9fVxqmm64dwhD/3Zifonf6g8wJ/c1MaDvS/MC9ihisOQ5CUWr+fi
         lCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fniMHDevgS+sy0VW9Irk7dpFWcke4CVDxXVC7jIjUKc=;
        b=r5HzXIO5wGN1s6Otz4srzjechxROBE6T4vy/udZke7endM+L7M3V6dPzOBVRmssO26
         bzqRYfmtUA+67XwPoyf6NML3f5gvA4gZTsi1fKPRn4pUhyRiYexMwH95SP/6bzFR1e1Q
         U311Gh8n1YQiWcNTXQkLap6yO8jr9ssTooFL8Pw2dgcVqY+HbF1CmKwRtLSB3yYFuGns
         GwCZaGIz/dG4TmvcWCbLX53ekeqFhll0+4KxcU5cftVJW7njKZvqH2iX58abmW12pen5
         ICpF1yHJT2uHb4E/k7sf+bwPC2UrhbSGsjN+jkYvzf7Ius6ILfWSgymfqpQ022un19Z0
         SoVg==
X-Gm-Message-State: AOAM531tRV7t7wcr3ks8Ltkrg09BZYiqY8kfKkbyXGFJ2k4mzf5yVhBh
        zj63t4T6F8Pq0q5sCeQ0FcPg/isWAHM=
X-Google-Smtp-Source: ABdhPJwpKawi76+W0OvRXYWHN+/Q5upP3fNPc+SFRE49ahVEHo9r8anucjtgZDCg1zBzK93bP3Ma/w==
X-Received: by 2002:a05:6000:1b8d:b0:20c:d372:f07c with SMTP id r13-20020a0560001b8d00b0020cd372f07cmr27837202wru.607.1653490875555;
        Wed, 25 May 2022 08:01:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003976fbfbf00sm1980805wms.30.2022.05.25.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:15 -0700 (PDT)
Message-Id: <427dec412a559bffab789126ff8fe34eaef346fd.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:35 +0000
Subject: [PATCH v8 13/30] fsmonitor--daemon: cd out of worktree root
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

