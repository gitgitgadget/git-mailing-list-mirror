Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21DC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiEZVtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbiEZVtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45325E276B
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z15so3626100wrg.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=kfiGZa55IpT0+emmTIHeEAb5E9kGIqvrfjpvMs1/F+NhPlv0xmwP7jMSbyEi95pLXq
         /+jNp29Yshc6icCRl0HLevWnqc3t9FsOlZZtXActUWSyUgF+8K9Joo1mPFx9ubcqCLJ7
         kMgxNm+K2S9f61hNvEm9cdV/tvTQme6eo1V4UkoSQboIbyi3EZ6v1i8bI2Tc6ues6D2S
         tQ7sMgaiv3BNcYI9K8xB/i+eB9Z6gn2d3Q+Fq0JZrkiy5J4G8jvbdvEbvnzwcu1278G0
         T+GOWTnNTrgRWP1aayKnTkk3Jjz3XKTTDlJnjUfhVmG3fig4A910F9loIzVA20MJSVWW
         B+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=kVRLKOSkYgdBcOKMRdF8oUMZjNZVxaPmSF2YPttp8vTrtYni1ssHq7qmzYVWeDEHl7
         9obnQSXw0pUw0XFPATsoiPXHoB3d5Z5Gtl6z2DSsgmYeo+uTHn4iDjjAdI5KxXO0BUyN
         Ch4zD57HlKvG8YW2nsZT9VUZsD+KI73RrolGwDNmq78n3dIq7iRTOoK0ElKCQQDWB5y6
         NXExw9rM1vMYvBGsHdV9usYU59bED+2JYgbAynDkDjyt40daSaj1e7XlCs3beBDPeIC/
         79gFnLIFUp3S35ziv6jg+4puawla+RNQTLTqRjONjGSBPtf6CemRhFGQNmyzllYOGz+y
         /WJQ==
X-Gm-Message-State: AOAM531OqxQqogySoSVNYdbsIWJTWTKhoNCvDfLcHDTKFQWqojMbhBMP
        kp36suBlGKGbApJn8FUBa3sjYaxBQso=
X-Google-Smtp-Source: ABdhPJyil7LkrSZlE834NJ9wbW9O8tzaGv7RSsbB64Bp8c3645de4lCY3m9G0iSwm5/6eRih52MeLw==
X-Received: by 2002:a5d:4a0f:0:b0:20d:766:9d41 with SMTP id m15-20020a5d4a0f000000b0020d07669d41mr33208109wrq.380.1653601755465;
        Thu, 26 May 2022 14:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d64ca000000b0020c5253d8dcsm230765wri.40.2022.05.26.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:15 -0700 (PDT)
Message-Id: <d2569ed32113801ab3bfb969f7790a10fd4478bc.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:04 +0000
Subject: [PATCH v9 10/30] fsmonitor-settings: NTFS and FAT32 on MacOS are
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
 fsmonitor-settings.c                   |  6 ++++++
 fsmonitor-settings.h                   |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

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
index d2fb0141f8e..658cb79da01 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -225,6 +225,12 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 			    _("virtual repository '%s' is incompatible with fsmonitor"),
 			    r->worktree);
 		goto done;
+
+	case FSMONITOR_REASON_NOSOCKETS:
+		strbuf_addf(&msg,
+			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
+			    r->worktree);
+		goto done;
 	}
 
 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index afd1b3874ac..d9c2605197f 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -20,6 +20,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
 	FSMONITOR_REASON_REMOTE,
 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
+	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
 };
 
 void fsm_settings__set_ipc(struct repository *r);
-- 
gitgitgadget

