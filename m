Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE1C433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiDVWjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiDVWiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E51F9E2A
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so5803876wmq.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pg+pIfJCewJfl3Uu7fv/1CMTNHr8lfgpM21Z9LQ/57U=;
        b=jTcELQ+N08IIHyMtiU+5bzEGZ5iI4fPBqlFiui5mgS/fIiAcB/E4eq9pQAXjz+s9HS
         hRzqLBO2iAohg0//TI8PEYWjZ0h3XgZ8LizzFwS4cLRnRpHAoszYVHvCr2IVoxQFJ7/U
         zwA9KfVUK9znbTzAsKLuEHMvW+m7mIG2dbuywmDfLlAkwNnqHDwYhzbp+PR71yIWvMly
         eANsllNPMQda/Teb32GlC5e6FuDDdJ+eJatrMGhQzuIfAs5nC3fD74MyiEBiC4hGLXz5
         lBvwXrYWzO84gSCs+sUfju2eOngeL2zrMNcFolPwC6QVs3K2rYAUnOaQCFdpQxg1CQjR
         Ow2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pg+pIfJCewJfl3Uu7fv/1CMTNHr8lfgpM21Z9LQ/57U=;
        b=Anh22ohKSWwDBt3+st8ld8x4w94ksrF+DKkg2JLGfpI6yRegAjhQXyhUK/nSUMMMSy
         wmZRMj+Ke0Mcaz6/TYPhdhl8McGmM4T0VWTDjI4bkyHOpcZxQkJEByXi1wIC0e+X28Vm
         peCF9YzOvMHtjeZDi0TRSrv1wQvsaVq7hKrXJCeKX7rudgQpQoPEfk9gSFZcttJqtSQ8
         8esCwjFwKdTSapQZ7jePm1w3yj7FVgtXLOCCDSYpoqviyrZ2dWbiRf3Aq5PDjkSsm/9t
         2a0gBIOW9CzhYNCrQUVmjm7umgTqLizzieDkJ5ADL17g6WVS+TYXXvK2skGZbezHmVnv
         bq9g==
X-Gm-Message-State: AOAM533dhBV89GD82BaDAU0vwSach2U9lxR+5wSemNTpNZVX1drOaPsl
        v2hJY78yxbB0eVtzXMMzMyCGvNzlv2Q=
X-Google-Smtp-Source: ABdhPJyyND02Gz9O1+wW1UQfavU0muv7QjiZtTjFDYxJig7wW8WLcOZ3BbN+91qjKZM2ZlFVGiiHiQ==
X-Received: by 2002:a1c:7710:0:b0:38e:b248:6000 with SMTP id t16-20020a1c7710000000b0038eb2486000mr15238427wmi.39.1650663015236;
        Fri, 22 Apr 2022 14:30:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9-20020a056000154900b0020a849e1c41sm3330989wry.13.2022.04.22.14.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:14 -0700 (PDT)
Message-Id: <b06edd995eac126769bf970bc894debd4eb3452d.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:44 +0000
Subject: [PATCH v6 18/28] fsm-health-win32: force shutdown daemon if worktree
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

