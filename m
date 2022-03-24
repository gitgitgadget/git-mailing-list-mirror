Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0EC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351985AbiCXQyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352183AbiCXQxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2215B0A41
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d7so7482484wrb.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=bmdRaOIHFoGXY8JD4821xHUVJBkkroLOWysXJvHigNmVEgMJlcX8pC/DOzMi4ffT9V
         XJ2Tn5+MvOwHmDGFTzyP+p459Bq8G7J9OG41lNa36JFlBHdt5yZIIE0Z+bAJ/3oh87OH
         t10/WaGCx4ENx5jGpHpOqICEBLq58qsURo4yftWfzvdReE5Mtry5s5mWJrq6sVX0cF2o
         VXeOUlQxk1Z+QcDXnCJ8a+kfbSWeRjEQL1apGgsDiz2M54fMIeMuxU8DxlIYZkuwGbaK
         HyDasscYmnNsFp41qmhV0Rx77dXx9U6FrN9lRhLD59ZFPtzq2TL0Elqsi0GK9pwd/VLD
         GbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=PT2cOoGx2yl+gI+Uv5jsaZerEppNAXHnow9iqy4r2+mkzWYAE7FH7thTBrIz0ZW8ZT
         xdqD4w+UIXve69SV8pzqan8wnXjFKCXcy/sfFKUVU5wpwYLEvAf0x3sHiWg31oLmbtXR
         bPFqEf+tjQnX5v2K2kYVs3Tn2JQIARVNegeG9symumoGolJsE3fYmpQI/9yo9uFAKwwM
         6P67+vgp7LHRoQBZWu40MfbdOYNolBtwvzuuKm/7JN36fJetDE1TCtCFl0S11K62ZGHP
         7q6tHO8lFSpTjqZy6bWe4bSIQd/LxxIFkNUmYFfcRtTMXmD3upRbnolAVCzJDYGleO0l
         43qw==
X-Gm-Message-State: AOAM531fZo3MfFK/030D+LbcFspG/mq0jUYdZfuBDOfu9jmACYO8wwiH
        rkw8ADooB/SieewHGyfVLuuFUrmYsN8=
X-Google-Smtp-Source: ABdhPJyI/3+9bqziB3EVqhR/m/R/cVvQyu9eMfId2bAjynLZAkAAn9kpCRdLuHaKBfyQFfG3GyPTXQ==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr5240396wrb.606.1648140695283;
        Thu, 24 Mar 2022 09:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d6d09000000b00203ecdca5b7sm3387932wrq.33.2022.03.24.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:34 -0700 (PDT)
Message-Id: <b6dfd609adb732d3b50d3189f294831d8e6bb217.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:03 +0000
Subject: [PATCH v4 10/27] fsmonitor-settings: NTFS and FAT32 on MacOS are
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

