Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD019C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382185AbiDTUqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382154AbiDTUqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03F3CA63
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x18so3896929wrc.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=Dm7uMXHOkqinmHTSSv8nALsR7tJdpjxbQsdCOXL4cd/8RxS5JLaoeXrOALnln1Ya4S
         Y3HukD3508zK8EhY+tojkJn4lrPKxWh5OluXJ4qXx7A5Irf402e/0vGSWcwnOFPwiIE0
         KUejlgV6AKNDNMb0mQJ3cbXfjL3/DsQBH/PJZ3yHMjIhDkcvJaAp56zKX51NP97I0dzT
         DO33vNVXAFcb/qB/lJD8+RSPxYOVkMdb8FwX9nGg36YV6cNqE1eAIXwl+YBmOE7s1CLD
         FyuSq8BsCCzHEOVhZeXGEazwGox1v1gr9LSMc6gUhWb9fvxDEO52GQJSXuY29nIX9x8d
         WbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=mYnm6WH+pDzzIZHcdJT6RW3cVRGULCnfHeIf6nvGPoc7CunPF8RitLl/84tXbY2FxX
         9jxxKCUi5uOXsPyk8D5E9GuJiuJ2Ucc7BjzyguYOxnrwALpSyiGuqs+lC0chbhmL80Rz
         /GzoehyePaV6yljePmTxntu8tIP0G5JOAsZj6YfGhD95QlBGe+HjQEHqVqJafxfvo+Nb
         u5Hoavf8Lmnj5jXO+ecLiIR2Dyhm7mC6HvqM/pC4KCmIRsbqRQfBhXp3Q2xZOKgaCtRg
         OBcZoI2bf51kefHLt18C2fK11HHf4DQqPGltV38wIPniyE9KFtWWjUQ9dL2dIOqFCpsr
         4tpw==
X-Gm-Message-State: AOAM5333VOYNc/uy4Dja4opoCx/KikqCn3oygw4O22/Aa1iYn8VK64TQ
        ezHAdoA28C2OHTIq2SFhQxcZCdFQyBc=
X-Google-Smtp-Source: ABdhPJx+y1+QGWXrqOUWzNlWNvPtrooi2aywjkyR6P8jk71FeamW/kteFXZQ87Ekjeh3Nz8uGDGDKQ==
X-Received: by 2002:adf:8122:0:b0:1e7:b111:3b92 with SMTP id 31-20020adf8122000000b001e7b1113b92mr17029290wrm.695.1650487414179;
        Wed, 20 Apr 2022 13:43:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a056000144b00b0020a9c02f60dsm634166wrx.50.2022.04.20.13.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:33 -0700 (PDT)
Message-Id: <8f1f4840751892708de7f2e4ad14c13649943e25.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:00 +0000
Subject: [PATCH v5 10/28] fsmonitor-settings: NTFS and FAT32 on MacOS are
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

On MacOS mark repos on NTFS or FAT32 volumes as incompatible.

The builtin FSMonitor used Unix domain sockets on MacOS for IPC
with clients.  These sockets are kept in the .git directory.
Unix sockets are not supported by NTFS and FAT32, so the daemon
cannot start up.

Test for this during our compatibility checking so that client
commands do not keep trying to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 20 +++++++++++++++++---
 fsmonitor-settings.c                   |  5 +++++
 fsmonitor-settings.h                   |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index fdd762bf79d..efc732c0f31 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -7,7 +7,7 @@
 #include <sys/mount.h>
 
 /*
- * Remote working directories are problematic for FSMonitor.
+ * [1] Remote working directories are problematic for FSMonitor.
  *
  * The underlying file system on the server machine and/or the remote
  * mount type (NFS, SAMBA, etc.) dictates whether notification events
@@ -40,8 +40,16 @@
  *
  * So (for now at least), mark remote working directories as
  * incompatible.
+ *
+ *
+ * [2] FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ *
  */
-static enum fsmonitor_reason check_remote(struct repository *r)
+static enum fsmonitor_reason check_volume(struct repository *r)
 {
 	struct statfs fs;
 
@@ -60,6 +68,12 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 	if (!(fs.f_flags & MNT_LOCAL))
 		return FSMONITOR_REASON_REMOTE;
 
+	if (!strcmp(fs.f_fstypename, "msdos")) /* aka FAT32 */
+		return FSMONITOR_REASON_NOSOCKETS;
+
+	if (!strcmp(fs.f_fstypename, "ntfs"))
+		return FSMONITOR_REASON_NOSOCKETS;
+
 	return FSMONITOR_REASON_OK;
 }
 
@@ -67,7 +81,7 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_remote(r);
+	reason = check_volume(r);
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 0a1811ff004..60d5eaee497 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -194,6 +194,11 @@ int fsm_settings__error_if_incompatible(struct repository *r)
 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
 		      r->worktree);
 		return 1;
+
+	case FSMONITOR_REASON_NOSOCKETS:
+		error(_("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
+		      r->worktree);
+		return 1;
 	}
 
 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 34391b583b3..23d5676c8c8 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -19,6 +19,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
 	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
+	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
-- 
gitgitgadget

