Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F1C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbiCHWRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350687AbiCHWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2257B27
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i8so240971wrr.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I0DEwYAS/m99+SGTZO7U7pFq7MF2RJupiNoTd3v948U=;
        b=GTJcwX8DUTx+FBq7SeE4laWCDdc7fHRuCXJ4PdSUL0aWOmEzsDbqTVuVk7GwspqRBf
         8KhxhpT0XiHmwh92YNnkV2IxnzM/2+kpRMhugLNgxdPbu/uuhHOnhjstG1hf1VcBNJpP
         RyGpRgrv4F6s8ONu9K5PCoqMOTzUP7pKhZzLTyJJe/bJrNpb43U1z3iV6br+Oev+HgsX
         J9LXnfDSb3okkUz4H0YT64OLmw9U8BufphJc+ERmxOXnYo37u1OhtJK0r8aC3P4P8Oq+
         aV/DYzaPFsWLoZFfv3eEvkljwnyfmpBZHe/wgks6raNCZiCYVB992nzULzSajCM+7V1J
         aBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I0DEwYAS/m99+SGTZO7U7pFq7MF2RJupiNoTd3v948U=;
        b=5bde1FUyub/AUFj8oPed8UtCrej9roIVJocg2rwvt8XlcEP1zs2/n63W90Beb/R36U
         nJuXpSU87wlMmOplc5IntKPcxIomwyO3dKmMVEREn/2ieKGIwm+lPGSu70YQgnNxMHTV
         ewMl76ZndQ/r0X+t7WB4O68ly6o3FZltsohbk4eC/hcTSFSkgYXk95qUB+SoRZkGnhQD
         3Qes5yoF63rYGIAAFEdK+47MccFdXbAZJ6Ms+VIFQKG16LywilnJi4alJhyyZvvu0WTs
         1WUXJA5xxDBVSYA1NT4b0WnmIr96+bAnawRVrCSGZ7lD4de86YXsnaNNie9Ax8uwQvCO
         maxg==
X-Gm-Message-State: AOAM5317kXKSNdZyuLfZLtLvmldXmspZJDPqMoB3AjcYB7gCKy+4juCG
        Kz9XyU17sF2dFDHGmpXR1ux+IGOIO08=
X-Google-Smtp-Source: ABdhPJwhdcT12VqJw1L1o7O991Mt3fjZP1oV7CtVbigifnWjjg0UhfUT7TGaN8k3DZdYVqozSYEcEw==
X-Received: by 2002:a5d:404b:0:b0:1f1:f880:7aca with SMTP id w11-20020a5d404b000000b001f1f8807acamr9300698wrp.179.1646777748179;
        Tue, 08 Mar 2022 14:15:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0038181486018sm64001wmq.40.2022.03.08.14.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:47 -0800 (PST)
Message-Id: <baf8c031a976fc18189df772e1a2bdff1c213e61.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:17 +0000
Subject: [PATCH v2 17/27] fsm-health-win32: force shutdown daemon if worktree
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
index 24fc612bf02..0132ca79305 100644
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
+		die("unhandled case in 'has_worktree_moved': %d",
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

