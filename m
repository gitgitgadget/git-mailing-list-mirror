Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F8EECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIPTx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIPTxm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 15:53:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2AB774C
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so37654928wrp.11
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=ntauRzsQeEb9e1MLpboZ/vfiFgzMYkeahnpX4im6KEbeid9HkkdolJ/vHrcAqfh3gR
         jgGW389J4aGz3E0kRtAY2LLSDKY6HLE68J/OmmFsLU7iCShOZ9jwmTS1MktL5PdeuoMC
         497Fclm1lU7C+fK+BDESqtIcLfGwUs95bS52ULWbFU9ra8yEpfbXn0Be3v7roMMdnbkd
         utG6rXMk0xrJpuBgWem7J9EkfXUHFlhqAQbUtB3RkpVioQaRgi7NUXu/xUQv9BGfUWWI
         AjEGsyG8AT535bWXgdJymtOPeb0LQl3G94pcoYTcJioE2q8UU4kcUzdAK7mhnzMkqo2N
         vwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=xuW+TwJ9uWCr0FybvczkE0GfPKt0I0CgHHkjM2GayjGAdhnYA/tCeVFlrFMYMRmPYQ
         1cUdNpsOdbvDhG9Z+vsTyT6RX5O66ngLc/KioDfMSUnXLCS73vaK7G4r4YVvxMW4UwEU
         TxUVYYi8Sij7n58wBp9XqkSmrKmBHBA/rgOPKiNNnhbKIRImhd833LJWOR/FvEwMk0BD
         tEtuRZ1zm787da7CHtkgH2MIiXa7D3ronS+1YpV0nYsUe/5AymZ3KQ5gdUrSgIQYhVqJ
         91FLttQs4B0gYA9UzfbDGtzanYu341bHb9U80He0C5TJI8Au8EdRa/lSuOrWEz4jvMUH
         8E+Q==
X-Gm-Message-State: ACrzQf18w0Q9vhgMLWw7rXtO2796wXemaC+ZhmrzPea4J/pyODdl1s5v
        7G1mmVV35jKmlkLBl4yyDIuHWRfPR6s=
X-Google-Smtp-Source: AMsMyM6qaZtseVkojUsM6rDKYf5gSlbLEpTk6jUbWqaPHK+d+ZhGePLOCKoCkYEs8m/aMuFTHfFxHQ==
X-Received: by 2002:a5d:4306:0:b0:228:8c9a:7daa with SMTP id h6-20020a5d4306000000b002288c9a7daamr3757475wrq.555.1663358019492;
        Fri, 16 Sep 2022 12:53:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k128-20020a1ca186000000b003a5ffec0b91sm3063563wme.30.2022.09.16.12.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:53:39 -0700 (PDT)
Message-Id: <5518d2f3e03e5e3ea121827cc0c148b481f353f3.1663358014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 19:53:31 +0000
Subject: [PATCH v7 3/6] fsmonitor: avoid socket location check if using hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If monitoring is done via fsmonitor hook rather than IPC there is no
need to check if the location of the Unix Domain socket (UDS) file is
on a remote filesystem.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 10 ++++++----
 compat/fsmonitor/fsm-settings-win32.c  |  2 +-
 fsmonitor-settings.c                   |  8 ++++----
 fsmonitor-settings.h                   |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 681d8bf963e..40da2d3b533 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -49,13 +49,15 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
-	reason = check_uds_volume(r);
-	if (reason != FSMONITOR_REASON_OK)
-		return reason;
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
 
 	return FSMONITOR_REASON_OK;
 }
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index d88b06ae610..a8af31b71de 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -25,7 +25,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
 	enum fsmonitor_reason reason;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index d288cbad479..531a1b6f956 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -60,7 +60,7 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 }
 #endif
 
-static enum fsmonitor_reason check_for_incompatible(struct repository *r)
+static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
 {
 	if (!r->worktree) {
 		/*
@@ -77,7 +77,7 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 		reason = check_remote(r);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
-		reason = fsm_os__incompatible(r);
+		reason = fsm_os__incompatible(r, ipc);
 		if (reason != FSMONITOR_REASON_OK)
 			return reason;
 	}
@@ -162,7 +162,7 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 
 void fsm_settings__set_ipc(struct repository *r)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 1);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
@@ -185,7 +185,7 @@ void fsm_settings__set_ipc(struct repository *r)
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
-	enum fsmonitor_reason reason = check_for_incompatible(r);
+	enum fsmonitor_reason reason = check_for_incompatible(r, 0);
 
 	if (reason != FSMONITOR_REASON_OK) {
 		fsm_settings__set_incompatible(r, reason);
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index d9c2605197f..0721617b95a 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -48,7 +48,7 @@ struct fsmonitor_settings;
  * fsm_os__* routines should considered private to fsm_settings__
  * routines.
  */
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc);
 #endif /* HAVE_FSMONITOR_OS_SETTINGS */
 
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

