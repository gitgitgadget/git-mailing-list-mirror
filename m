Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47499C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbiEZVtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348821AbiEZVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192A9D07A
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j25so3641180wrb.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=eavnVHjZf1ZJXDPZEfbh2Aq2J8+IboZd6Z0lR95AO4hOBwj68Ica7JVlM5UVyJSxko
         EQK/gU3EJ5HsvBKSa2wNwTuvXekBFu912x7A3QJXd48HWja7q7lbD+sgtgeWGGvxrfBJ
         1TJ9+mxxRb8r9TELYKI3YnseUkJNHIccu+DUoMUhjKYsFWJ4hYYbDj4Q512HO96iApg0
         HpITrJPfluo3g36pumSw0yAuw5Lbc0AsdFA8yMf6NyKo4INgzbIRIZZN0bPIhJhlIuAz
         3JJBoMTI+5q/kLNYPIPEOx7NoAispsz4zXna0TJijSQ5uuHVyjAQ4rSENpghYl3jSM6s
         IAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=gxOFlwm5GI+wZh1HYhnJHQg/SI2Qmeg3J6C+OoIXJspxKP4QValXPIpD1ZDIgf/gyR
         GpcEPE1RmV3/9eL3F1ncTQRpcmvZSAAvWmHbpLgfwzegAweQ2FK4cpumyw+cCdv4JRQs
         9RzDBwkpkMvX36ERhjaGImfpfwUpPnRi09Z0P6RrrV9fAWueBsym7rWJ/uTmK8gqYPiG
         a3ydAmeV6WAvTWUh/UiD+T3hBcG5uJ27Q7pOhFZuCrvzNjdGVATdTdEUsOfR7H5mE/Dg
         +9+V0xbkgnt1E1LzrF02HSLgEErvdwNWEc82e44+OoJjeM3K7qaUd9wZ1phnJQyqh7Zx
         NC6A==
X-Gm-Message-State: AOAM531+3c2JJpHBg7oiQ6WXY/wvpZMob7OmfF0LMRGNXtsF7rc/HF+P
        LMPufh4Gj7Fwytx5KhU6zCy3str8UsE=
X-Google-Smtp-Source: ABdhPJzvs8wchwjEEXmcvNpG3WjUVbxlVKCD2j256fyUm28MMP6hAxDKR4wbLgLGmAUEb+KcaNpJ8Q==
X-Received: by 2002:a05:6000:108c:b0:20e:6f3e:d891 with SMTP id y12-20020a056000108c00b0020e6f3ed891mr29977800wrw.38.1653601753146;
        Thu, 26 May 2022 14:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11-20020adff00b000000b0020d0dfcd10asm213405wro.65.2022.05.26.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:12 -0700 (PDT)
Message-Id: <8068b3bebee45056d9b09ab71ac4e9d4b013e0bd.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:02 +0000
Subject: [PATCH v9 08/30] fsmonitor-settings: remote repos on macOS are
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

