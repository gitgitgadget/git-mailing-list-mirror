Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8530C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiDVWin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiDVWh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3D1F8EB9
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h25so6725147wrc.13
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+631vAH8yId4sSjUsOxpbOLsLU18SAIV49OlFTix8VU=;
        b=WRj3YppREhMeKR2SSS03YNJ1lLoXI9ozNjEZ9+ttMikSz6L5+cKwOJR7Zmvb8G4lbn
         MIZQN44B0Nc/yu1ngfObY9Ym+jHp0h+X+sZ2o36tLS21e3TQ4f8+VEDgsow+rnZEhdz1
         ko4iJ6S9uTjKp15BVWB0RfUv8r381z0IjKbUgXyopSM1lKCUCuqiCyiJriBUE4geNMXf
         qtUPR+XdAKEskNBE1u7HkcmGypoKd+rTgoiD5ypxhHnYoAVreHEJDeb8kaKkkDTSrn9J
         uEC417CiI3CTHeTxnB4T1kz/NoSMjXNGSDC4lQKgFr9WXXCROhaagGKMXTwN63FgWdPS
         f9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+631vAH8yId4sSjUsOxpbOLsLU18SAIV49OlFTix8VU=;
        b=cMSW4Yge58aaqHsUzgl6mH+9SsK9CNzeVekA+6suM2qThhXeehgAIcVquLmtye7gcD
         vjTwx6LT24/I9fZl/V5bZJ58lr9YGCR1n3ThkMw4lf9z58741iJg3r+eLcP3F6bgBHb5
         6r7eVnFRBFCaI9dO6Ix5Qq7fKDXHP1gLBoZkP77xEp52lTB0mZ2DmzLcO/CTSdKYPIva
         sRIp1Vn0L05Ww5PL3D+OOTOWXNdK8MlyCsY4e0CUyWDtYvd0vfEdF+4/346ndtweC9he
         VMTgwTerKliaRXJDohXFEo+anjsZCOuEUv2xtecGCBz0wQnfaXnXdjgAk9QepS1gws1W
         igQg==
X-Gm-Message-State: AOAM533KIVvFKXVIHKGX1tUeMyfgZ/InjejR/CEzEtrI9E7dSy1M7CcA
        t1XgDrn0/o8ZWWCj3SWNtqtJfyUP7kU=
X-Google-Smtp-Source: ABdhPJzbDJ4IK8f90cvehYI1W6zgtVY6UIk921V+pAWZwHcE9kSENy7ucdA4XtHm/6p+lwEip8Bzzw==
X-Received: by 2002:a5d:59a9:0:b0:20a:9047:24ac with SMTP id p9-20020a5d59a9000000b0020a904724acmr5480499wrr.396.1650663004452;
        Fri, 22 Apr 2022 14:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a056000178c00b0020aaf8d351bsm2574418wrg.103.2022.04.22.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:04 -0700 (PDT)
Message-Id: <1f5b772d42ae31a897a4966fe88714413826268c.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:34 +0000
Subject: [PATCH v6 08/28] fsmonitor-settings: remote repos on macOS are
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
index 9e483c14513..ed26ddd7ba9 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,8 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_UNTESTED = 0,
 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
 	FSMONITOR_REASON_BARE,
+	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
+	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
 };
 
-- 
gitgitgadget

