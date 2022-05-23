Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB6C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiEWUNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiEWUND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA435996A2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so22937113wrc.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=ItzCrGHjupDJqWxHyTtFlJkA2g/nxNuJe99k+1Azo76TPhYNJ+Kyi8sgbzEZx8iZDt
         tYiXwts/oKR6qJR717AOBwH/XD64UoU+o6kbaH9VjwiNxIh9nMZkjMobSkDAj5u4rSqT
         kRX4YtPj2+0mc98w5Fqm5qhEncbtmQLudzjngoHMQbh7i8H/UUE9ZlKFAxMJrgOF2zyQ
         kclLBks4U+nn3sCqf8ttFqBpt613aZj/KVg5jOxhemf8Aao/PwhoXhCtHTLATJIFwdTh
         c3aZ+iNjW2pkFpsjG9jQs3DJ0VSD++lJjAWiw4ar2xy/KHP20ZWzrTjOGJHRJPRm/m1d
         GJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Mr17QihlnIGjvFpHWbrLWD1QkouTALYpOtyVyZM0ig=;
        b=U8hXR/RMfk+QzutunmdnkEANworb6aVhnlmJh74KKjwRB51zQ4D7oiCou3W7cZJt2T
         HjDTsy4LjfqhfQLJythN3avL8oM6SHm27kDiOgDbHI8qtMo2BvQTaJUFgCKNqrkYh0Fe
         jUT4Xib8Z2jYzNzT1ynT60rC4inODnJWLupjxPVMn/jM0W/sIwht+ZGWH3WTKKAvrCf8
         IBcpWBcvLCSlSG0RtrLgM79Txj+32vDfTEqfYKiZS8BAzadTt3P/LbpEh3MjGd+wuvHc
         e6AFNd4A/PkVD3tL6V7bGfBcjADvhEz14LC05uRhz/z76y/i+Uic+euzk0b/DQQwgcRN
         MtmQ==
X-Gm-Message-State: AOAM532s3tUj4ZVelqWNye9UoQeiP8un56oOR3z16frZ2V9fJ0r75oev
        DU/jQffuuU16tNzj6x0q3aKCvAv04zw=
X-Google-Smtp-Source: ABdhPJzvWxlbnoijQ+nWfiVHGUhR/IFYZAMEIrM82NWbtWdzuNJs7kY1lnLsB1WELAflru75NZaPLw==
X-Received: by 2002:a05:6000:1882:b0:20f:de1d:9fb9 with SMTP id a2-20020a056000188200b0020fde1d9fb9mr5505180wri.504.1653336780161;
        Mon, 23 May 2022 13:13:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u30-20020adfa19e000000b0020d10a249eesm11256553wru.13.2022.05.23.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:59 -0700 (PDT)
Message-Id: <dc2dfd679312a71ef0613857860b4ad426913471.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:23 +0000
Subject: [PATCH v7 08/30] fsmonitor-settings: remote repos on macOS are
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

