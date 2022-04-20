Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF890C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382174AbiDTUqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382127AbiDTUqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80F3BFB0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m14so3860506wrb.6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=CNWW6UCxIwoeBVVJFQxyjOqdpmsTHUdQ6F0G8WfYYGdvMlrAjyyi0Dqa9osKXrWfIS
         YRn9fZbyQVAmzJCC42b1mh97KRiRXc45dk7BjFbEorQTWLidJ/QNREleL6+gUSLmf4tK
         wUcB7vdxeQCRqNhXrR3Pw8qW+JKVr9krlfXgcjr8r0qCX/AqNX/m/aM78FwwhViMGcDx
         4CObwiBQcVo1XvvLumku/BBaVvUgQnMv3wpASQzhMYFLQAcUc71FOuEW4A2ly+cxPpEk
         CZjayexPbZKYoipw8sGnyBVHZYBIUEyZx2dM8hPU+w8oi1JXAafojwgG6SjQgmqfE5Pm
         169Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=H/KSOWdI37j3VkB6BSYBSUq+zmKB5xDhoOFCNdn1j0q7RMpOprJ4bpm9wFqOl/M33U
         d5xmvZRPpu9kJms6cRLSRhjIDbgvkE176g98Zm97X90qf5PpfF15y4InhuF7w1ctDpCc
         vc0hJgUVg2MvHTfQvmKeQNUvAo7bYAFNwNyeDEV3nHumwguoqh6gretnrli+Pqae2WwB
         w9k+rxhK5HDYZny/3PqNC2k8bzyDjdSUt0XGO/E5A20kwysFiN/vopcahPtFmRhDdj8S
         1NSfBeAmJI/VP329BD7PviVB+1vp5sBxam+YAJT3tCr2gTjjeA3a9mwSE4SM0MoVftI0
         RTvw==
X-Gm-Message-State: AOAM532iMoYXUFoUb5UGbNRrP/ZJjTr99UQeWUPC0fjqf8jCZzJEYWzX
        JQzNT5EqLZTh4pxHBRShL5ntYo9kNTU=
X-Google-Smtp-Source: ABdhPJyESJ+j4xWr6d02aitY2Zulkjtd35WPvbG3PWFiFANdlGcJCBBtngjG13K+fg7852aPByl6Tg==
X-Received: by 2002:adf:f2cb:0:b0:20a:77c2:3958 with SMTP id d11-20020adff2cb000000b0020a77c23958mr16440071wrp.589.1650487412811;
        Wed, 20 Apr 2022 13:43:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce354sm725576wrc.76.2022.04.20.13.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:32 -0700 (PDT)
Message-Id: <a3cc4b3b16dc93c5c4378733a1f45f6a1a78be4a.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:59 +0000
Subject: [PATCH v5 09/28] fsmonitor-settings: remote repos on Windows are
 incompatible
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

Teach Git to detect remote working directories on Windows and mark them as
incompatible with FSMonitor.

With this `git fsmonitor--daemon run` will error out with a message like it
does for bare repos.

Client commands, such as `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index ee78bba38e3..907655720bb 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
 
 /*
  * VFS for Git is incompatible with FSMonitor.
@@ -23,6 +24,103 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Remote working directories are problematic for FSMonitor.
+ *
+ * The underlying file system on the server machine and/or the remote
+ * mount type dictates whether notification events are available at
+ * all to remote client machines.
+ *
+ * Kernel differences between the server and client machines also
+ * dictate the how (buffering, frequency, de-dup) the events are
+ * delivered to client machine processes.
+ *
+ * A client machine (such as a laptop) may choose to suspend/resume
+ * and it is unclear (without lots of testing) whether the watcher can
+ * resync after a resume.  We might be able to treat this as a normal
+ * "events were dropped by the kernel" event and do our normal "flush
+ * and resync" --or-- we might need to close the existing (zombie?)
+ * notification fd and create a new one.
+ *
+ * In theory, the above issues need to be addressed whether we are
+ * using the Hook or IPC API.
+ *
+ * So (for now at least), mark remote working directories as
+ * incompatible.
+ *
+ * Notes for testing:
+ *
+ * (a) Windows allows a network share to be mapped to a drive letter.
+ *     (This is the normal method to access it.)
+ *
+ *     $ NET USE Z: \\server\share
+ *     $ git -C Z:/repo status
+ *
+ * (b) Windows allows a network share to be referenced WITHOUT mapping
+ *     it to drive letter.
+ *
+ *     $ NET USE \\server\share\dir
+ *     $ git -C //server/share/repo status
+ *
+ * (c) Windows allows "SUBST" to create a fake drive mapping to an
+ *     arbitrary path (which may be remote)
+ *
+ *     $ SUBST Q: Z:\repo
+ *     $ git -C Q:/ status
+ *
+ * (d) Windows allows a directory symlink to be created on a local
+ *     file system that points to a remote repo.
+ *
+ *     $ mklink /d ./link //server/share/repo
+ *     $ git -C ./link status
+ */
+static enum fsmonitor_reason check_remote(struct repository *r)
+{
+	wchar_t wpath[MAX_PATH];
+	wchar_t wfullpath[MAX_PATH];
+	size_t wlen;
+	UINT driveType;
+
+	/*
+	 * Do everything in wide chars because the drive letter might be
+	 * a multi-byte sequence.  See win32_has_dos_drive_prefix().
+	 */
+	if (xutftowcs_path(wpath, r->worktree) < 0)
+		return FSMONITOR_REASON_ERROR;
+
+	/*
+	 * GetDriveTypeW() requires a final slash.  We assume that the
+	 * worktree pathname points to an actual directory.
+	 */
+	wlen = wcslen(wpath);
+	if (wpath[wlen - 1] != L'\\' && wpath[wlen - 1] != L'/') {
+		wpath[wlen++] = L'\\';
+		wpath[wlen] = 0;
+	}
+
+	/*
+	 * Normalize the path.  If nothing else, this converts forward
+	 * slashes to backslashes.  This is essential to get GetDriveTypeW()
+	 * correctly handle some UNC "\\server\share\..." paths.
+	 */
+	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL))
+		return FSMONITOR_REASON_ERROR;
+
+	driveType = GetDriveTypeW(wfullpath);
+	trace_printf_key(&trace_fsmonitor,
+			 "DriveType '%s' L'%ls' (%u)",
+			 r->worktree, wfullpath, driveType);
+
+	if (driveType == DRIVE_REMOTE) {
+		trace_printf_key(&trace_fsmonitor,
+				 "check_remote('%s') true",
+				 r->worktree);
+		return FSMONITOR_REASON_REMOTE;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
@@ -31,5 +129,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
+	reason = check_remote(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
-- 
gitgitgadget

