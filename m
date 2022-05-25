Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A37C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiEYPBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F135AF333
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t13so11327304wrg.9
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=AOUDZZwEGjYQ8JJI/xjSQX23V4Zh/1qWk7EiQQFS42/qVHsM0JHuzmyhDn406tg3N0
         vIusrc3kYKiySa4t8kz/3xUMVaCkxiO3y3U3r9JJx2x5mJhHvzhm8lb1IhjINnO64ZR7
         1fOn1eKkqPwBIygyIOxVk56s5cT7pK6SK8QAWSZ4J1g+6TtIYvCzJ1E6e3MlCf6vRK2A
         iOMisf8DZXPQXjzKwZZobWAmy4XWkkAIdlmEWPpEC8CfK/uIHzXfrGCNvertyMRoqOBs
         6xLfGZLa8JO0aZPnfLt0ZJG9dFjtt6xgsOdbKi9fsDd9VkD/LGGrHlckwODwEgVfUDVI
         Mm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gagmQdnkju4spnOwYIMQ8SdkJsvAj1+kX3+WK6gVByM=;
        b=OSkUL2ddd89EsULfTLpkFK7SUJ9Khou0eD6XFx8aC6QZ0owRT/oxb0BiNztyn2gYAK
         JN/3lZBAPyq6ENswTz0UUsDZi0GpUrSS7HRlTQNTnA10lLL9x4H4xEFDdz+gCubTS6Hm
         rY/2uRl+v+mxOkY9hGIuQtvsHYFz1o9l4mt+Skw61W6P3+MJKNX1xLDfRL5ketdsfZOF
         i2ypjwFTNukl27iGcRv05i6D3IMpo8RIZB02Tu6th5c6x+Za6LOfDZ51ueu4YrtScl/7
         uJmLK6gnZhvg0lTxx+0V5XWcdRoPsd1zJQqs6cHSXfu9QrkQKzjH3oGwLmVFb+YMEjlu
         d64w==
X-Gm-Message-State: AOAM533QmtI48IBv3kEiOxfliK69+CPwu+UP092vl4JLqjGp3WTa1P8T
        IiIAAIsGVYcDmx/GNmEKU/lFMdm4g8I=
X-Google-Smtp-Source: ABdhPJxfEqsJ+8k6lyInVTAd7X8YuCNsI5tqGw+7DhHX5l9IvSem+xX34PZ6CeWeDmMQf4jpnttgaQ==
X-Received: by 2002:adf:ebc6:0:b0:20d:e8e:4df5 with SMTP id v6-20020adfebc6000000b0020d0e8e4df5mr26609360wrn.117.1653490871569;
        Wed, 25 May 2022 08:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0020e68218048sm2256722wrt.93.2022.05.25.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:10 -0700 (PDT)
Message-Id: <9a12cc78b5d16a05d4ed76cdb2a1f634ed32ef8a.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:32 +0000
Subject: [PATCH v8 10/30] fsmonitor-settings: NTFS and FAT32 on MacOS are
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

