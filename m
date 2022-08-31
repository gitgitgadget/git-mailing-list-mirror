Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92752ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiHaQJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHaQJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:09:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F7DB0880
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e20so18880231wri.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=3xkCrUGmHxE0Vlh7KaT9kiu2RtYJf6DDPSmtM4ZuucI=;
        b=c59XG0/H/r60WoWBvmnTwse3yFrJAgZGHVWv2JLMME2hzFlw03aSRuxrEL4J8Nkw9B
         sHPVgDp+v1mDDwmsAmziH6snt/LthXfc8L9ozNtJKqZCgZsXfgxIp8wToUhz7ESrWHga
         uFXZLQNhvNttU4mLlDvBwzSzW2i/2JkYXf7pAc5O3FEjMwLp3rKm+OirbeodUX545f04
         tBsmoH5MVJTgxtgxrKTmcBlwVIVVGrcvXvvACvjTyviRvG84LRGvHG8HTrlef/4jl8dD
         1pNZLubwVt60/5/t/AnAJ7BT0dBYTxShSPChxFgYTmwJryfEUN/+SVR0g9JBHeVvhdW2
         NUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=3xkCrUGmHxE0Vlh7KaT9kiu2RtYJf6DDPSmtM4ZuucI=;
        b=zt8O3bL1iePWZJNs4M3zpr1OLPvQEyI7nw42tjsJ85vaLXX2ZXWPY/9CB0IfqlMUqs
         lRf8KEuMypltZ/zVFdFn3ENdXIgd1KcgadkZLsZjDpNSE583bUyjJZGoPvyTHxZkNngc
         3eE+pTcQACMHUt6d2jRV+G8O1MFCZROs+NPevJuc89STtA2WsVjwbwkho9KH3PjiODuW
         PpFs9kGmOxPaGtkwm5uBPeXwOomP9ukrDHDUbj4vDrVGDcwdr9yrEhrIu2e/DY/F1I8h
         O/Vtxf4MWiqemrMXH2xlZFhsNonQ2ojQo6JUBozk1GQ2QaMYtRIq6EmTjM9mMzF9PuGt
         48TQ==
X-Gm-Message-State: ACgBeo0OReMR98RwfKFjc+Mphzlg1lzHQ/vAbUcpMTzN2cRNdMYVvQpN
        wtk7Pk5AefmWQGWdm8e22VlNY2I3qzI=
X-Google-Smtp-Source: AA6agR45eGgAhlILdfrSEZ6Z6Szx3QmXEK6OnvyCr4a7sSfn+uTYg9wXXGvcZNirk4x84D2WigaRXQ==
X-Received: by 2002:adf:f6cb:0:b0:220:7859:7bf with SMTP id y11-20020adff6cb000000b00220785907bfmr11693195wrp.683.1661962152263;
        Wed, 31 Aug 2022 09:09:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b002205cbc1c74sm12405331wrz.101.2022.08.31.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:09:11 -0700 (PDT)
Message-Id: <a3110f1e25a19da5791aa1675a82556d95469248.1661962145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:09:03 +0000
Subject: [PATCH v4 3/4] fsmonitor: ensure filesystem and unix socket
 filesystem are compatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Perform separate checks for the working directory and Unix domain socket
(UDS) file location. The working directory may be located on a
network-mounted file system if 'fsmonitor.allowRemote' is true. The UDS
file may never be located on a network-mounted file system; additionally
it may not be located on FAT32 or NTFS file systems.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index efc732c0f31..dc79538607f 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -3,11 +3,12 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include <sys/param.h>
 #include <sys/mount.h>
 
 /*
- * [1] Remote working directories are problematic for FSMonitor.
+ * Remote working directories are problematic for FSMonitor.
  *
  * The underlying file system on the server machine and/or the remote
  * mount type (NFS, SAMBA, etc.) dictates whether notification events
@@ -27,26 +28,8 @@
  * In theory, the above issues need to be addressed whether we are
  * using the Hook or IPC API.
  *
- * For the builtin FSMonitor, we create the Unix domain socket for the
- * IPC in the .git directory.  If the working directory is remote,
- * then the socket will be created on the remote file system.  This
- * can fail if the remote file system does not support UDS file types
- * (e.g. smbfs to a Windows server) or if the remote kernel does not
- * allow a non-local process to bind() the socket.  (These problems
- * could be fixed by moving the UDS out of the .git directory and to a
- * well-known local directory on the client machine, but care should
- * be taken to ensure that $HOME is actually local and not a managed
- * file share.)
- *
  * So (for now at least), mark remote working directories as
- * incompatible.
- *
- *
- * [2] FAT32 and NTFS working directories are problematic too.
- *
- * The builtin FSMonitor uses a Unix domain socket in the .git
- * directory for IPC.  These Windows drive formats do not support
- * Unix domain sockets, so mark them as incompatible for the daemon.
+ * incompatible unless fsmonitor.allowRemote is true.
  *
  */
 static enum fsmonitor_reason check_volume(struct repository *r)
@@ -65,6 +48,51 @@ static enum fsmonitor_reason check_volume(struct repository *r)
 			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
 			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
 
+	if (!(fs.f_flags & MNT_LOCAL)
+		&& (fsm_settings__get_allow_remote(r) < 1))
+			return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
+
+/*
+ * For the builtin FSMonitor, we create the Unix domain socket (UDS)
+ * for the IPC in the .git directory by default or $HOME if
+ * fsmonitor.allowRemote is true.  If the directory is remote,
+ * then the socket will be created on the remote file system. This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.
+ *
+ * Therefore remote UDS locations are marked as incompatible.
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * These Windows drive formats do not support Unix domain sockets, so
+ * mark them as incompatible for the location of the UDS file.
+ *
+ */
+static enum fsmonitor_reason check_uds_volume(void)
+{
+	struct statfs fs;
+	struct strbuf path = STRBUF_INIT;
+	const char *ipc_path = fsmonitor_ipc__get_path();
+	strbuf_add(&path, ipc_path, strlen(ipc_path));
+
+	if (statfs(dirname(path.buf), &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path.buf, strerror(saved_errno));
+		errno = saved_errno;
+		strbuf_release(&path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 path.buf, fs.f_type, fs.f_flags, fs.f_fstypename);
+	strbuf_release(&path);
+
 	if (!(fs.f_flags & MNT_LOCAL))
 		return FSMONITOR_REASON_REMOTE;
 
@@ -85,5 +113,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
+	reason = check_uds_volume();
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
-- 
gitgitgadget

