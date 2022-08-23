Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE46C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiHWTv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiHWTv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:51:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3311465
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bs25so18095378wrb.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=1DXuvdwjfUb9+x0G0jwK0PdicjVVYpDtZrgZUeeuj2k=;
        b=TUDi6klb/EX7+WjOdpdzPqJpxLoG/OXMlf7EkfP/4plgZemnge9xAWdSh5r6a8J6Q4
         wi47GQhUVOdDc/OG4olGI2bfTf61CXHEOBiNvTrdkJ6cn15qO7iOwN2fcJ6+1eElfRp/
         bQsn3jzC9HUL2hfTPn6bUwub51Pg//rZSTon16DUocg9iVf2oTIpQF75OqrWenz98H20
         x9q45y6ZDQG6sd3UxTpBhpCSor7uEe4wczgaOTbsGCb7rwIDdalr6KcP/lXYBAKB6sqE
         xGocyozcnT50DzLSGcwp8eqKBi2NQK2iNhTpXgXu4hXlKrg6+MDklHtCrhiHL7G9bYOv
         D0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=1DXuvdwjfUb9+x0G0jwK0PdicjVVYpDtZrgZUeeuj2k=;
        b=LlfOCMYPbxSeNL6w/OQPpGzw5xbqz7XXhNRJAELE+h2wPtyMYedoRyIqyRqm95qOoE
         TCW8TkJ1zwvwjZfbL+RksswMbUvsl03BBkM71uQRicuV+zS3TQjT3hs8WXAE+oaMKC8D
         mDsGPlZNH81Y3frXPdZ+ZFQOHpYcZnqZARI0LZ4KXKZSfIRjGCL4Z7xzSqedpldAYv/q
         VHlptizk9fN2q3oEasePWztNYx77OL4jhS39SNGvkYszvwBLwUuBMCuA1yaWf2FMhWcR
         OUYYvPHG2IYL+kXgrcmtfhMHzBuYW99DDKbKIcP4VUHG5WegK4Ab/hoLTcdlnGeoAUA1
         xT6A==
X-Gm-Message-State: ACgBeo20fLA8o7CNJpNUnb6tkW+IpXjO5sI5ukLw+/qp51oE7s2uNA6Q
        Cu6Ezi4RQWMlt4aoL/zJvKTRi49yRWU=
X-Google-Smtp-Source: AA6agR4+9KPIMQ17yJXhrOLahtKIi8nXaGzPxPyv4+Mur6PgpIuhUB+md0GyTa/hH94Cp27QeaQZKg==
X-Received: by 2002:adf:f804:0:b0:225:1d9c:c40e with SMTP id s4-20020adff804000000b002251d9cc40emr14016916wrp.486.1661280944193;
        Tue, 23 Aug 2022 11:55:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b0022511d35d5bsm15246737wro.12.2022.08.23.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:55:43 -0700 (PDT)
Message-Id: <f977d140afac8b2d205a66ad4deb1ec1913588fb.1661280941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
References: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
        <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
From:   "edecosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:55:41 +0000
Subject: [PATCH v3 2/2] Check working directory and Unix domain socket file
 for compatability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        edecosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: edecosta <edecosta@mathworks.com>

Perform separate checks for the working directory and Unix domain socket
(UDS) file location. The working directory may be located on a
network-mounted file system if 'fsmonitor.allowRemote' is true. The UDS
file may never be located on a network-mounted file system; additionally
it may not be located on FAT32 or NTFS file systems.

Signed-off-by: edecosta <edecosta@mathworks.com>
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
