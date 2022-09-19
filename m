Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6918ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISTiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiISTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B515A1A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so793867wrm.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=mKYz/+Mc6RSXeMQfmDrlxY77Wd46woczq2pCinVhqK/OFjoB78XDFwNYXKOSbJ/Yma
         Z++sAZUus210D8KlLV0XPgutQv/ztveAJ/djUxQN/ki73Kgyh9Ir4jfQMQ1rTA5uQAAU
         +OjTNYruWms98hXxrvEEaUq8eQIJX2YAe+E8B7AiS2g1spOksAy3WVbnxzD+J/yt5vWN
         aFlFFKFmcwEywIXnfFYtq18yqR0JhmNbWkCugYy+Sq4OUGTQb3zM1fis0FqMCyWfIQre
         IlarmQpiuauUuaJQ42GbMv33Sswa/ccnrVxdlmk1G5afFD6M/IdbmZdDWjOYO95AAI27
         0lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=dKbHJwKxCfEd1MFxAw2rVa8ViNj8tFgi/NbeZuiFG1YWGR9zI0jhxEigflW2OS/ofN
         F1t4fGQZaY7q7lC7AiRedktJmiLFXULcsrs3MRzlGlnafJ9KQsn/xxCDsWsGiZeNT9Yr
         viV2zSB1eoEmJt8SBgatbpVrAB79Op/ABAsOP9H5FfxUd+jThWWXxUNAPu1A4Rb+YmNY
         Ly7qGUo3+6yFqa08OopmCASgUC+UfxoZJ01YPSD/iO4A0rwxC24jjnQ1kuZaibC5cfoj
         abkkroK0wCcnxtAePVJ9fkTmoEmzZiMO2fRgSHcUm0B3wQ40o8jteistbRfjRceLmK+2
         1GZw==
X-Gm-Message-State: ACrzQf0cq1gIZWPqz33JgIF0iZ2tyCBjyTgvH2cDLNrFINtjAvrIt2Rq
        ljRHJ8lM/3m1n5stSRXrDhmAGJK92Xc=
X-Google-Smtp-Source: AMsMyM4il3cwNNSLSzXJlHvESIx42jMC/UAvSnVTtoOpLh44RbQozbNO1amymrj+qhK5bHeMJ/8PZw==
X-Received: by 2002:a05:6000:1548:b0:22a:c113:c9d0 with SMTP id 8-20020a056000154800b0022ac113c9d0mr12201728wry.653.1663616281457;
        Mon, 19 Sep 2022 12:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4242000000b00224f7c1328dsm14621162wrr.67.2022.09.19.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:38:00 -0700 (PDT)
Message-Id: <6ddd922917a144f2339af47b9f5c17c122c1ebbd.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:54 +0000
Subject: [PATCH v9 3/6] fsmonitor: avoid socket location check if using hook
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

