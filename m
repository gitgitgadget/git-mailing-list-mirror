Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362EC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbiEYPBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiEYPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6230AF304
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z17so5788055wmf.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=L3dMoKHVsmU3UjzcQ0qkFXRN+0pFc4Lqmj2ZYHCg/yuwCMOEGjebxkb8QWOP68eVyB
         TlT3NIDCCj4ySncbKBCOx5PM6x9h0Qq2H9vFvEdKws197IYcd5BcGWGmHa1hW5e/i8UO
         xtfCs7wtjVwqglDGV1zaaV2sEhCqtLXrozxKUBmteAjbTlrFVWRS8Q6yjqlFpfBPlJ87
         H4ear2Xktksxw2RjKSeEeY3jogi2JFDnyuWFyNhRrOMHCgi+O+XujAMajFvq3NRolK5v
         frPdnpPB1fKoAaGZUZUe86wuxt0DDSEqX1jmVJy+s7unDMVuC1vI1MvDb5BMHp0ReLkl
         jhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=eOwIJHUs1RM0nknWhRnfSsUdWmvQIxZg1HayQC4TTYSnoppE0kWA8YOfcEG5XDAZOW
         +ebU7R3PuJLm8Q4zKI2oxn9aecuNGI63mcuFzH2CVUOEN5Sl+DLbLYpBl7lubI//VPju
         8PFVUThcoCeSV2ond8c5EiTVebc+yNzTOjaXqExLv/rKJ++tZxvqoCZaPHD8Pn3yAGzr
         8p3gOKWf5YbJ35NmZg16JRH1feIhXY1NEgIEDfAIT5K07PPvz25UMWZAJuNPW99QD/T2
         M3QaZveICBvZ/fYevIQUf0km12s3A/J3+XW4wy2s2P7cUcWhcVlSXdCZq1kYO+nrbWaK
         un+A==
X-Gm-Message-State: AOAM532Ht01ve8+omdBVLmnZhu5MHMvVDluWVZUCn9kkMwTyYjG9Ai8I
        ERP56ZpCC0HOQ7vXK0VTVHhJ4GhG/Zg=
X-Google-Smtp-Source: ABdhPJywjnCsdKwQGYgcFH19lRbeO4O7YWWjnVMA03HkgAz9e0vS8zTfUuTeeu/ws5uOFE8vSS2DnA==
X-Received: by 2002:a05:600c:19ca:b0:394:8dc0:b5c2 with SMTP id u10-20020a05600c19ca00b003948dc0b5c2mr8604739wmq.167.1653490867677;
        Wed, 25 May 2022 08:01:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b0020fe4c5e94csm2475855wrf.19.2022.05.25.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:06 -0700 (PDT)
Message-Id: <dc2dfd679312a71ef0613857860b4ad426913471.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:30 +0000
Subject: [PATCH v8 08/30] fsmonitor-settings: remote repos on macOS are
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

Teach Git to detect remote working directories on macOS and mark them as
incompatible with FSMonitor.

With this, `git fsmonitor--daemon run` will error out with a message
like it does for bare repos.

Client commands, like `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 66 ++++++++++++++++++++++++++
 fsmonitor-settings.c                   | 12 +++++
 fsmonitor-settings.h                   |  2 +
 3 files changed, 80 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 7fce32a3c5b..fdd762bf79d 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -2,8 +2,74 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
+#include <sys/param.h>
+#include <sys/mount.h>
+
+/*
+ * Remote working directories are problematic for FSMonitor.
+ *
+ * The underlying file system on the server machine and/or the remote
+ * mount type (NFS, SAMBA, etc.) dictates whether notification events
+ * are available at all to remote client machines.
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
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * So (for now at least), mark remote working directories as
+ * incompatible.
+ */
+static enum fsmonitor_reason check_remote(struct repository *r)
+{
+	struct statfs fs;
+
+	if (statfs(r->worktree, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 r->worktree, strerror(saved_errno));
+		errno = saved_errno;
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
+
+	if (!(fs.f_flags & MNT_LOCAL))
+		return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
 
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = check_remote(r);
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 600ae165ab1..d2fb0141f8e 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -208,6 +208,18 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 			    xgetcwd());
 		goto done;
 
+	case FSMONITOR_REASON_ERROR:
+		strbuf_addf(&msg,
+			    _("repository '%s' is incompatible with fsmonitor due to errors"),
+			    r->worktree);
+		goto done;
+
+	case FSMONITOR_REASON_REMOTE:
+		strbuf_addf(&msg,
+			    _("remote repository '%s' is incompatible with fsmonitor"),
+			    r->worktree);
+		goto done;
+
 	case FSMONITOR_REASON_VFS4GIT:
 		strbuf_addf(&msg,
 			    _("virtual repository '%s' is incompatible with fsmonitor"),
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a48802cde9c..afd1b3874ac 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,8 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_UNTESTED = 0,
 	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
+	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
-- 
gitgitgadget

