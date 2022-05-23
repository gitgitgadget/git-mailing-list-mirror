Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B5C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiEWUOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiEWUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9FABF43
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r23so22935717wrr.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pg+pIfJCewJfl3Uu7fv/1CMTNHr8lfgpM21Z9LQ/57U=;
        b=e0qE35wZ+TT1DzjRpkVZVkAURgpzkVOPyI2+1FIb3WhAmAKfzJT5tqFAowgGRdC3KP
         vRN0jAuGYRXeYc+Sus62Mj4IdRNSOHbkSaEuuJZQzLKa3lSHzsP+x0GJLIs7qGWp4V7T
         QBt1izPEQUQPkO+qMKltPhsPyLar57GiyAbDjJUmvm8b6hnKns3slNpuCu7x+rp6lQEa
         hnHEYHg07mXPCpFwjgxPUFcag82ju8WMj+b5sAH1wMJB2/EBEJK7dH6CCE2Y4LHm71FA
         Z+ca4g56enAp51d1H0E524fX5CLvLjxVNTQu5yMeSFKCTGN6kJDSNbTl9Zsc967bbiXP
         54kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pg+pIfJCewJfl3Uu7fv/1CMTNHr8lfgpM21Z9LQ/57U=;
        b=rmrnfKKmPxH9MPNQIreJubmaoVbS19psQq20VwTy6S89/uWpGOTUXJ33jBtLkWef4n
         ZA7uQqWJRE0UuyJv7gRh5euVa3kaYPNtuW4uGArNR5qPPLtC+fWdCj/+meylnXsbUtT1
         t38Y1jcavV6drJj3F0ssWnalfXgtBqLIu1WJEN7gZxTSsrfPau/sJUk0yWGflf4YVA7W
         IpTT0xS5tVA5x+i9cyGfHr4rorkbXJTTSeYLs3h429lWj6MpzWEyEnw5IXx9JezqBmAk
         6BHiiZ6R1ELL86b37BPk0Vi07dxlBnLEv6qvl8C2N1LXZXTU5MSMMCRell3MMf8EiEW+
         wKzw==
X-Gm-Message-State: AOAM5333Ku7ccVfIQ2onAKYXpIdcqm57szb0ii6MxJNxdwo/99Hbo95J
        lHRPt2PItOWK3QNSQ+yadR4oVU1Ulug=
X-Google-Smtp-Source: ABdhPJxvu3A0KgY49Go4AHdjbMjY8aB7Hq98J9rZzZEYlwShZ578W158NrZ9D1GxAJoYjovxCWZwww==
X-Received: by 2002:adf:f152:0:b0:20d:740:beba with SMTP id y18-20020adff152000000b0020d0740bebamr20579385wro.512.1653336791638;
        Mon, 23 May 2022 13:13:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az39-20020a05600c602700b003942a244f54sm134297wmb.45.2022.05.23.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:11 -0700 (PDT)
Message-Id: <7cf1be5f8e2c644a5bce9eb4484de2f6c82af359.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:33 +0000
Subject: [PATCH v7 18/30] fsm-health-win32: force shutdown daemon if worktree
 root moves
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

Force shutdown fsmonitor daemon if the worktree root directory
is moved, renamed, or deleted.

Use Windows low-level GetFileInformationByHandle() to get and
compare the Windows system unique ID for the directory with a
cached version when we started up.  This lets us detect the
case where someone renames the directory that we are watching
and then creates a new directory with the original pathname.

This is important because we are listening to a named pipe for
requests and they are stored in the Named Pipe File System (NPFS)
which a kernel-resident pseudo filesystem not associated with
the actual NTFS directory.

For example, if the daemon was watching "~/foo/", it would have
a directory-watch handle on that directory and a named-pipe
handle for "//./pipe/...foo".  Moving the directory to "~/bar/"
does not invalidate the directory handle.  (So the daemon would
actually be watching "~/bar" but listening on "//./pipe/...foo".
If the user then does "git init ~/foo" and causes another daemon
to start, the first daemon will still have ownership of the pipe
and the second daemon instance will fail to start.  "git status"
clients in "~/foo" will ask "//./pipe/...foo" about changes and
the first daemon instance will tell them about "~/bar".

This commit causes the first daemon to shutdown if the system unique
ID for "~/foo" changes (changes from what it was when the daemon
started).  Shutdown occurs after a periodic poll.  After the
first daemon exits and releases the lock on the named pipe,
subsequent Git commands may cause another daemon to be started
on "~/foo".  Similarly, a subsequent Git command may cause another
daemon to be started on "~/bar".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-health-win32.c | 143 ++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 24fc612bf02..2ea08c1d4e8 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -29,8 +29,150 @@ struct fsm_health_data
 	HANDLE hHandles[1]; /* the array does not own these handles */
 #define HEALTH_SHUTDOWN 0
 	int nr_handles; /* number of active event handles */
+
+	struct wt_moved
+	{
+		wchar_t wpath[MAX_PATH + 1];
+		BY_HANDLE_FILE_INFORMATION bhfi;
+	} wt_moved;
 };
 
+/*
+ * Lookup the system unique ID for the path.  This is as close as
+ * we get to an inode number, but this also contains volume info,
+ * so it is a little stronger.
+ */
+static int lookup_bhfi(wchar_t *wpath,
+		       BY_HANDLE_FILE_INFORMATION *bhfi)
+{
+	DWORD desired_access = FILE_LIST_DIRECTORY;
+	DWORD share_mode =
+		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
+	HANDLE hDir;
+
+	hDir = CreateFileW(wpath, desired_access, share_mode, NULL,
+			   OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hDir == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] health thread could not open '%ls'"),
+		      GetLastError(), wpath);
+		return -1;
+	}
+
+	if (!GetFileInformationByHandle(hDir, bhfi)) {
+		error(_("[GLE %ld] health thread getting BHFI for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(hDir);
+		return -1;
+	}
+
+	CloseHandle(hDir);
+	return 0;
+}
+
+/*
+ * Compare the relevant fields from two system unique IDs.
+ * We use this to see if two different handles to the same
+ * path actually refer to the same *instance* of the file
+ * or directory.
+ */
+static int bhfi_eq(const BY_HANDLE_FILE_INFORMATION *bhfi_1,
+		   const BY_HANDLE_FILE_INFORMATION *bhfi_2)
+{
+	return (bhfi_1->dwVolumeSerialNumber == bhfi_2->dwVolumeSerialNumber &&
+		bhfi_1->nFileIndexHigh == bhfi_2->nFileIndexHigh &&
+		bhfi_1->nFileIndexLow == bhfi_2->nFileIndexLow);
+}
+
+/*
+ * Shutdown if the original worktree root directory been deleted,
+ * moved, or renamed?
+ *
+ * Since the main thread did a "chdir(getenv($HOME))" and our CWD
+ * is not in the worktree root directory and because the listener
+ * thread added FILE_SHARE_DELETE to the watch handle, it is possible
+ * for the root directory to be moved or deleted while we are still
+ * watching it.  We want to detect that here and force a shutdown.
+ *
+ * Granted, a delete MAY cause some operations to fail, such as
+ * GetOverlappedResult(), but it is not guaranteed.  And because
+ * ReadDirectoryChangesW() only reports on changes *WITHIN* the
+ * directory, not changes *ON* the directory, our watch will not
+ * receive a delete event for it.
+ *
+ * A move/rename of the worktree root will also not generate an event.
+ * And since the listener thread already has an open handle, it may
+ * continue to receive events for events within the directory.
+ * However, the pathname of the named-pipe was constructed using the
+ * original location of the worktree root.  (Remember named-pipes are
+ * stored in the NPFS and not in the actual file system.)  Clients
+ * trying to talk to the worktree after the move/rename will not
+ * reach our daemon process, since we're still listening on the
+ * pipe with original path.
+ *
+ * Furthermore, if the user does something like:
+ *
+ *   $ mv repo repo.old
+ *   $ git init repo
+ *
+ * A new daemon cannot be started in the new instance of "repo"
+ * because the named-pipe is still being used by the daemon on
+ * the original instance.
+ *
+ * So, detect move/rename/delete and shutdown.  This should also
+ * handle unsafe drive removal.
+ *
+ * We use the file system unique ID to distinguish the original
+ * directory instance from a new instance and force a shutdown
+ * if the unique ID changes.
+ *
+ * Since a worktree move/rename/delete/unmount doesn't happen
+ * that often (and we can't get an immediate event anyway), we
+ * use a timeout and periodically poll it.
+ */
+static int has_worktree_moved(struct fsmonitor_daemon_state *state,
+			      enum interval_fn_ctx ctx)
+{
+	struct fsm_health_data *data = state->health_data;
+	BY_HANDLE_FILE_INFORMATION bhfi;
+	int r;
+
+	switch (ctx) {
+	case CTX_TERM:
+		return 0;
+
+	case CTX_INIT:
+		if (xutftowcs_path(data->wt_moved.wpath,
+				   state->path_worktree_watch.buf) < 0) {
+			error(_("could not convert to wide characters: '%s'"),
+			      state->path_worktree_watch.buf);
+			return -1;
+		}
+
+		/*
+		 * On the first call we lookup the unique sequence ID for
+		 * the worktree root directory.
+		 */
+		return lookup_bhfi(data->wt_moved.wpath, &data->wt_moved.bhfi);
+
+	case CTX_TIMER:
+		r = lookup_bhfi(data->wt_moved.wpath, &bhfi);
+		if (r)
+			return r;
+		if (!bhfi_eq(&data->wt_moved.bhfi, &bhfi)) {
+			error(_("BHFI changed '%ls'"), data->wt_moved.wpath);
+			return -1;
+		}
+		return 0;
+
+	default:
+		die(_("unhandled case in 'has_worktree_moved': %d"),
+		    (int)ctx);
+	}
+
+	return 0;
+}
+
+
 int fsm_health__ctor(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_health_data *data;
@@ -64,6 +206,7 @@ void fsm_health__dtor(struct fsmonitor_daemon_state *state)
  * A table of the polling functions.
  */
 static interval_fn *table[] = {
+	has_worktree_moved,
 	NULL, /* must be last */
 };
 
-- 
gitgitgadget

