Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED3C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiCVSZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiCVSY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88F15FEC
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h23so24021632wrb.8
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=drdUne9vXfWX3YoU+6pCEAj2TYWwqZYPHGbc4I/QN8IPD3cyh2MAD+tHSanaLdMxYV
         OPc9st1XBeJBJksVqAGhwgHmZLPFykVO/cHdnI/KWK+Y2muJCluCSgf3eSA0msjzx3K9
         ne7R8ZOQSJxidH7L6v5JRRnvBKhTQzdTTZ3uGXX5q/gLgJMyUWwQLMigNR69LHVTTor1
         cYVh32mlb941XvOrKO7WdA9g64NPw+Absu/7dyilElqOwIJuvBn49mMzFa4VVxbFVRxt
         QhGI1vK3ho42+3s8nepLDTODb8oSAy6X+9P0w+uUdgG2O+7qUc61Vd5eCPcxnYJrxKwW
         9cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KKDUtqfcz4RAKt3TKC0Ge43bGODedopwH2p3XKXOALk=;
        b=L8HhMA73ybunwzDFLrzC7uZmO5gi61eH22cJLaG5aiQLUKW+7DCsNqn4051mE8/r12
         xZH0RzuahzVB93f3FzT6pwZvRK1yngEwUxe9dEC5YLB1tISeQmWOqVO+asbhm+xlOTXB
         /Zm5aYcY1O8z9Y/f+AUs52ftdccQz28eL9R156mQKbGwbhpDnbZTODKbcRegqUcZ811T
         +9rCLPf/Dz4kxR2vD9ByJVTEkCwF0Q26gHbh30awaJVt8AGwXf8XWJTViT0fT39IHFME
         sFROO+g+NJRwNHGIukrgwovLzfLPperPOTdbk0iYd/PwgJGy2ocLsCFlRk90IEae6kFs
         2DgQ==
X-Gm-Message-State: AOAM5319hviKFQYUwC8fbRuatdL+0StsODRdL6Q0yil+NgWQA+ek0Mj5
        bLPfGect1gbyxqgP/CRuYZMHwx7WvRs=
X-Google-Smtp-Source: ABdhPJzG/eTYX76qdtuHwVUiAX7SI/d3OFh4fKJW76D22sO3PbaMmifnJe0coHfqEKXf+DSVcF/56g==
X-Received: by 2002:adf:d4c2:0:b0:203:da50:12c5 with SMTP id w2-20020adfd4c2000000b00203da5012c5mr24026732wrk.100.1647973408155;
        Tue, 22 Mar 2022 11:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h188-20020a1c21c5000000b0038c6c37efc3sm2374468wmh.12.2022.03.22.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:27 -0700 (PDT)
Message-Id: <6715143724586bd53de5070c61dba30dd8fe2bf8.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:43 +0000
Subject: [PATCH v3 10/27] fsmonitor-settings: NTFS and FAT32 on MacOS are
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

