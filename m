Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E484C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbiCXQyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352176AbiCXQxH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152BAF1F3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so7460453wrc.13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=gFPv4sZdO5cuzTZjqyOI44lisSX8Yie0rIKF7Md6rk5+Oym2ybR2kOU1j/6Uc6bA1r
         hCb6uj6TzexiyhEBfgYekGOgtENMEPJ/gTsMGidDsDU9YdxEySURbiBU74eM/URJuEYd
         rLlknTR8CRaiJggWuXYkMmN83gvhLzMYYEtXdfSbtbap1fh5jhgnxamcVQrdpDVJu3fr
         gcod7ipkTKf6fH7sZo3PlLbA78Ual6LdJdrZKrqv4VY4k1/hHT1in7d2FUW/Bx1oD1uo
         XBm1SCe2yeXqtrw2njl75kx1eyd7ZM4GsZ4tA6i4ws9nuadwuVQUhC2x7aq7ltDPY7rl
         vXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sjfx7SFJhNxZLXokVMmn8yqRtBoQjZzh8JIwTJB3LAY=;
        b=HzVmv7iKWFBNQLsOMg8gDP6rGYbraSnldLLGruBJmSCKBXq9Tzmit431Lpx9UncuRo
         W0VNxYoYz8aXoVh+NCoWodPwxGNaKTaiPkAjyhQ4ZicWu5J+Gms6AsloDKRqLjZ1S2Gq
         SpGNEPFigDbnjiLLGcR8yWZBvs6SuvfSsFTibtFqc4hRxG/zC9czI8bwz1r5WI1odi1v
         LRUMQ1/HLi5xFCOw4DQukRqdAGMZ5O9sXo/HbEQYzzOQ69YoE6RoY3ZpgH8OeZlntG7C
         hGn2XAQjmpnHARmWuvpFnVIeA1orj3WdVZx6qLbs82pMO3EvRaxWLz8Zirn7Ku/fRdY1
         GlNQ==
X-Gm-Message-State: AOAM532YnPOc/4Pa6+ZIhAq/yOHH1edjNTVDLMidrYKTEtNzRd/BhRW+
        GI75iF5EN5CemFaQze22F+OhsCCGayI=
X-Google-Smtp-Source: ABdhPJyL9hgpM4ivsOl6aVisb6RD9DECu7Lf4Xuppe8gydSyUx2+O0uXDNPhPn48XBQXa5+Fji41TA==
X-Received: by 2002:a5d:6d4f:0:b0:203:f9b5:8c3a with SMTP id k15-20020a5d6d4f000000b00203f9b58c3amr5300543wri.185.1648140693941;
        Thu, 24 Mar 2022 09:51:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t127-20020a1c4685000000b0038c9eee54eesm2533703wma.26.2022.03.24.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:33 -0700 (PDT)
Message-Id: <0297d80388a69bf52e19169ef1ce1b29688e4a94.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:02 +0000
Subject: [PATCH v4 09/27] fsmonitor-settings: remote repos on Windows are
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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

