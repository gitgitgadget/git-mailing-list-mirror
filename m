Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72112C4332F
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiCXQxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352200AbiCXQxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A7B0A43
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so7482574wrd.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7rcq2e2OM4nGjZ+ZqucdxU8VZqK8SlixUVA4duCOPBc=;
        b=hzjaAzSxdRnz7AYeXNEw6dgLoCnn0XpOcUpnt/ETcuHzlPryZo6Q5LdCi1Il93AoIb
         xulwgTDAlP+prTGi7iCFwca13kMfSVhVArMviyyPVWWu0EAV5nnQWEEjTSKnZkiE1Cxp
         Z5DSAalI5I2cqpv9pega781pV91eXsmqapoBKfJ3GWVdNqBW6y7noZj0xuLnBg99AV87
         3Kg2k+rFyvfqLOGL5H/H6mLjCHSUSp7mvj/1YkYKWxBYkeChvPdOhdWdhguc1+ifo0ML
         PMjBkWk3K0DoQ7vOE7M77vol0tJsmzAD+Q48GL/qI9FeEbKnYbGX+So1bnlt5jQ3MbXO
         3Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7rcq2e2OM4nGjZ+ZqucdxU8VZqK8SlixUVA4duCOPBc=;
        b=vgsK+c/hNLm4ZrtOX9NdA+1hiG8C5op1tltXSVKLF0MJoMw95yedApYf9eJsDVA/h/
         Qc1M6ReO9kbq8oc2MpfUwECjwR8J+alaYvQD9xjMUouJcBnJeMxOe3CNrF2pZa4EHD1i
         2oTvIl7h6TDpoJniDHKRGDxOESC4EyNAvtvVFVYkfTy3fHxsstju3hoMO35CRvUuzkqT
         jw1MSZQjVEap6sVWmlPZM0lLBtbPTKJFJabf4PQKW+Zosi3pyEhErjcNdU4o4euUcldx
         8OUMgw+Xg+ohhrPD8NPLnHz2Fy+oFucig0hJpahGw0XtCI4d7F5JrAcPJWSfsrhcWTSo
         C5dQ==
X-Gm-Message-State: AOAM5317nUaC4OWre12445Y9oZaXU9B5nm5ja+E3vs3N9NotAEtTdvyP
        8KacWYAqBoPMaXmrJMSgxCcUlmky5iA=
X-Google-Smtp-Source: ABdhPJyk7/ZPOdPlvLo1w12JXo1OE7nuu5mj+vF5sfAxM1sTv48b6wZCwhggs+WgC86RnUMD/n7h0A==
X-Received: by 2002:a05:6000:168e:b0:204:fe5:a55 with SMTP id y14-20020a056000168e00b002040fe50a55mr5172396wrd.453.1648140699869;
        Thu, 24 Mar 2022 09:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm3679648wrs.73.2022.03.24.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:39 -0700 (PDT)
Message-Id: <4aade7b560a92a2215405001b108cf35101f6809.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:06 +0000
Subject: [PATCH v4 13/27] fsmonitor--daemon: cd out of worktree root
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 50ae3cca575..1b7c757f583 100644
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
index 3f1b68267bd..c43d92b9620 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -402,12 +402,22 @@ static int recv_rdcw_watch(struct one_watch *watch)
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

