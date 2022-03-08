Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD96C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350707AbiCHWRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350727AbiCHWRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:17:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D4583A8
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so221511wrg.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ckbNLnLtLBb+cunwvS4Wd9AD0GNuyCgcxOjizu4gyUo=;
        b=iksnshXPPmFLAp5HwfoUJCF3YhYBS7BuVPIpgChUiKEBRspjFzuT9E0PVSJzGEgJQT
         NgVLVqmw3+XwPBNAq+TAzhZRDU2C/7HOweO6NWqsHZd44LX7LRxwkZEvFy/6OjacbEEg
         V4wonuxRQrGiJ2Zm9zSU7TFZlJuFGz3Q+vQcDkPtm+paEsQNupT3WWnbfOwg+59x5uS0
         +FiNz1RS5N/vaiA0h8yl1CjvdXGdt4QLAC4mF2srUJ5tXchwEFrqMdvl2wSicAvaw8yY
         ZqItOLxUOhe/U33DyTXFJ+Kf4en/Zvd9Ey5hLx8aZOaY/GqCbPjl7sa1SlnPugk+zExi
         YcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ckbNLnLtLBb+cunwvS4Wd9AD0GNuyCgcxOjizu4gyUo=;
        b=k9LWxNFw0T173vjxSuIQupt2xN1UFcjbGkgKEOhKgdlkpbUpySdB3npt+dW1XcF9sN
         CGMwkbFBFJjUZJQK4LlKQ60vg0h3CR1S+etzYauZwpK2fZ/afoBM3zYXUiZNint+FXZ3
         lFTviSSYAi+1Ie5Fm7qe8WOSu0flAFOAFEhslqF5ydvsRPLb9jtCxXewFZvtSEJRe5DB
         0/iIXHK5R13kjyteWYFn3gKL35CMndLXuSklfMCKPVFy5JfQUJth8zrTy73TLXCmStqL
         yOET+xCtgaQf93rBFzsSB+98DVS6rjZ0vzHypZWuiEwJWazR9DRcDZCXtA/ma1RJ3Ylq
         lSaQ==
X-Gm-Message-State: AOAM532waS8uQmbjUOzxZBER050htHbaWaqkuL9YkQWeRZcGxVixyTHR
        MEd+jNLbuZVrCmGIDjgVGsprxrMTqng=
X-Google-Smtp-Source: ABdhPJwyrK80nxTLx/H6EOiElp1zJhlmOol8noo1NokbrVLfylFqMdWf3DudD4H+FuTxr+YiZE8RoA==
X-Received: by 2002:a5d:66c5:0:b0:1f1:d7e3:7068 with SMTP id k5-20020a5d66c5000000b001f1d7e37068mr13459825wrw.410.1646777757266;
        Tue, 08 Mar 2022 14:15:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020adf9d8b000000b001f063deef80sm84709wre.86.2022.03.08.14.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:56 -0800 (PST)
Message-Id: <e3e01677d9338310c3731e9fc02a9e7fd6af0032.1646777728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:27 +0000
Subject: [PATCH v2 27/27] fsmonitor-settings: NTFS and FAT32 on MacOS are
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
 fsmonitor-settings.c                   |  3 +++
 fsmonitor-settings.h                   |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

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
index 7ff3f98964d..5734c93baf9 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -186,6 +186,9 @@ const char *fsm_settings__get_reason_msg(struct repository *r)
 
 	case FSMONITOR_REASON_VFS4GIT:
 		return _("virtual repos are incompatible with fsmonitor");
+
+	case FSMONITOR_REASON_NOSOCKETS:
+		return _("repo filesystem does not support Unix sockets");
 	}
 
 	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 6aa9a00379b..af792313413 100644
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
