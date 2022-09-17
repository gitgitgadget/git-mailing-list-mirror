Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD531ECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 01:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIQBMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIQBM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 21:12:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E957D797
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id cc5so28719711wrb.6
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=alSfva7e6YRs0UByuGe9fa7KPvBmAWkX9wWNv9mbrWXQk/GXox1c5b4ZCBtCbc8OBh
         3Z8oyif7JYT8nSPXX3/xtABJ0pI0TYF5tvPP40WR27VR50B9O1nn7M8RtHpJ+tZ96kkJ
         y6Pvk9r2v55H7s93LFfXYU2ejTxiUIJinc2PlAgGvSI9BDqqDUxhxMXCw5H9DO0XyERp
         fGQSxAsKHDoE1AvOtvXyoP85qrs1T5sDZcBpM+r1MCSa3HaCUT8kmOBcLvCL/5PuER/X
         PzTADcBDnJeSRXzTN7LIA6cfWlWGKG1UX/t94TG4nxSBCkNSQsiW3Jt8THsb8bELiRhH
         /ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sn7vsF8saTSOV85OIZnrqZlKAyOg5t4JuZwq78TkGgc=;
        b=5yIY9S9dWWS1YgZ1ggl5Isd00pYUhEMo+8PFk+X7evmc1oHjhfx9piVdZH9d5SW28X
         ZfbMfrt+oNqVOt0X/pTv1WgyP1sMqrJpLansczyFxJkWScsJhOfaPdM+mGj5eXuuN+ZL
         Zg9zRD7WmLIjZA0rL16iWky6Z2vck6W5+UnTWnv7XrB0UW7PUjzp/rsfIoNDmZj9wTUe
         3nSd6J57zXbUuyZVsFKjxwmeXkVkAy89++sg3rUxgUGvTD06wgLYFnydw/5bIuyEaY2M
         f7bHZDbYcoEU7ta/m0Ia2nNAf4c/mFlccjuuEWxPkRYKuFcJItcDnM8pct/eoXQpo/pH
         28VQ==
X-Gm-Message-State: ACrzQf3C4X56egJfkJEYcFMI3evdovXwmuQbyAM4eW4Ns181GBKGo6qZ
        MMPP9mM1qwTOe1OHdONQZYnRtp2UbJU=
X-Google-Smtp-Source: AMsMyM4RrIVOJ8H/pbQgkrCyw1AMs2cyMnjs0/cWodEwyasrhg1wVeLwectv5G3f36UdLESayE9lGw==
X-Received: by 2002:adf:df82:0:b0:228:e2cf:d20f with SMTP id z2-20020adfdf82000000b00228e2cfd20fmr4677540wrl.356.1663377146129;
        Fri, 16 Sep 2022 18:12:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020adff14f000000b0022af1d86e52sm246629wro.1.2022.09.16.18.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:12:25 -0700 (PDT)
Message-Id: <6719ca2b24d07449b8469b94f99e99ede01bce60.1663377141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 01:12:19 +0000
Subject: [PATCH v8 3/5] fsmonitor: avoid socket location check if using hook
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

