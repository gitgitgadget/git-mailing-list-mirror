Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE721C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbiFOXf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiFOXfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DC1A077
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so1962108wma.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zDNeHA/m3I9ZBVTe9fpqf5UB3mPXA5PuTEuAdJuXb3E=;
        b=l7d66ux8hIf5SeqNMyR6ppv8xvqF5sSrh6FiwRePAY1M2VELNcqNOtkG+bZkgY1w4l
         VE9MPdW2vlQZ4+0i5jmTUItq9Ew+h+I9HCg4Xqysv79BcVMRXT1ZJmvFO70G+CHjatnh
         MQ1VlXpnJaP5VaDeoqR48bSYcjB9zQymDAMPe3qqOL3i5zPO5/7p8PNbghmJNrd0clLB
         5Yo7bqdFSSkq5XXBsNHtWBIg6IZgl9qz9sHXK0E7PLZDAn8D/w/yLS9gd44MvMRF27Rd
         z7piQsLwud7wgz8W9kKwprUjh6XNui7NZt7Anl/GUKZq1dKu2a0C9L3xwEdC5gjenPtv
         KAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zDNeHA/m3I9ZBVTe9fpqf5UB3mPXA5PuTEuAdJuXb3E=;
        b=1Op1ex01u/3DJDChQIdGOrG65wzQs9Fc4Nq4p39q5Dx+8+j0Cj0A8Uxr6D2M4weAin
         s20LRfU4GcE0Kclg/08dr4ajQymWzJ79wqC//i+01aznlsGWKvShUxJWdhE0WRM0MRKV
         9Teu+bnw8yI96ufwHjm5+SKRrX4UYrW88c8u+CDzK0lG0Cezi8QXznq+hWwwFQLLRe9L
         JiFA5V6FGrUBR5MbmFsQK9+VKEC9TY6CZPFD6aqNJofteZdG5wc/JkgoUb9/7XXh9ioR
         AfpNFZNMA8kE4b9gIwvBtDWJambO2r1uO6XgvDJqlneaq7utJvfL3BX94NfSjlDMFoo1
         KB7w==
X-Gm-Message-State: AJIora8v74DOD2RfaKhqLo9wfWulUWZZhNMqN+792wsf4RrLkBZi8Dly
        tKc08Awdjme/JgtGsLazgwfbeIedJQVJxA==
X-Google-Smtp-Source: AGRyM1sd3F6BtG7EeV/TCcHZ0tX40K74tfVcePi/cuG89qwfjxZ1nTIM2U/oy4ANKoSXiNkw//6FDQ==
X-Received: by 2002:a05:600c:4f95:b0:39c:7bd0:d47d with SMTP id n21-20020a05600c4f9500b0039c7bd0d47dmr1890573wmq.17.1655336152370;
        Wed, 15 Jun 2022 16:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a1c2501000000b0039747cf8354sm294717wml.39.2022.06.15.16.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:51 -0700 (PDT)
Message-Id: <6d409ad45867aa5193c15828614e865e53ac0c57.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:36 +0000
Subject: [PATCH 02/11] fsmonitor: avoid memory leak in
 `fsm_settings__get_incompatible_msg()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsmonitor-settings.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 658cb79da01..464424a1e92 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -202,11 +202,15 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 	case FSMONITOR_REASON_OK:
 		goto done;
 
-	case FSMONITOR_REASON_BARE:
+	case FSMONITOR_REASON_BARE: {
+		char *cwd = xgetcwd();
+
 		strbuf_addf(&msg,
 			    _("bare repository '%s' is incompatible with fsmonitor"),
-			    xgetcwd());
+			    cwd);
+		free(cwd);
 		goto done;
+	}
 
 	case FSMONITOR_REASON_ERROR:
 		strbuf_addf(&msg,
-- 
gitgitgadget

