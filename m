Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0002BC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiEZVti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349121AbiEZVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34197A88A5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so3696330wrc.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=HCNEQJZPATs1iiyvrHkAABQiK3gihyxtli4Iv2y7vsOIXfenjDNARoVlx2gK7pA94z
         yUudR4xnxid3fTdHamD0JCfp5fZ1xbhq+ofb5XcXKCUyLm1KXFQMaw9tT+Fy0KAE3j/W
         02OO6JLUDCphn5y0OiCxdrKi3s44OX2GUHST00J1NexHOfazjKVD/SLEZsZCW/JjNrA4
         4jVht0ZirgxuJ2DQLK5omuTdop36bRmmFKNILunZAvI832gzzH8wCEE4bgYGypvhSc2h
         stlpBVl5HTwfCvJiX2Yu+PonmJIfPtb5WdEsP6d/DQVYxlNAMHIkNzavtOku/g6sxUwR
         ppbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=bbYcXPNowLUL57IVh4o+vP35TNDWaBlS0bDCt9u4nNpC3xIGrpv4gPsY1jkCNQhG/J
         WD14H/P9TN1l8PrfRHP/SQDf0kriZZ2tR6EA6vpgGh7fCqWecUmJNB68vh8iiDW8v9lg
         lsRrS0lGKpqluodXF5gKhJUQxysOijcn2e78oTRom+tM01SWZh976vPiFoVaHJ8EhaQO
         5DA9R/fZnd/UbbvwJIsoEtOxw0Hz0H1nFXx3cfmwK+tda9MduyKuB5tQyV7DRAvrYWMo
         HplRwKWkMA9A8HzZiHVy3IvPKqAWr38D7st0SixE+j4UVGu9hqW5D7GyW32DsNHeIPkp
         wRSA==
X-Gm-Message-State: AOAM533LVkMOfLFrONs8gU2FlepXn2IoYIj8GFjVK9tBtTcQt3I/DZSr
        zzMoBME9HwlzHbsynxMjccumhxQ0OwQ=
X-Google-Smtp-Source: ABdhPJy7ncV39Mkq382062xWiforVJCWHolOQdZ5F61MOE6aRVxzJoXao3FK4V9gKNDdc0CM8jwbhA==
X-Received: by 2002:a5d:64e9:0:b0:20f:dc21:e652 with SMTP id g9-20020a5d64e9000000b0020fdc21e652mr19406577wri.308.1653601754427;
        Thu, 26 May 2022 14:49:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b003942a244f50sm259536wmq.41.2022.05.26.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:13 -0700 (PDT)
Message-Id: <a5c40a4464d8327f091c85da02b1fb01067bdafd.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:03 +0000
Subject: [PATCH v9 09/30] fsmonitor-settings: remote repos on Windows are
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

