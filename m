Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FBC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiG2RMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiG2RMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:12:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108D6C13B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c22so2864403wmr.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zwo/8FRaAsRfmRY6byv+l42XZPVwXQJhp9yYbuihb90=;
        b=jA48QyIOuaVa59HEXNBJhAA6NLsGjz8KCVhy7+s3F2N5VB0X6nlAp4+YJ29OPpWdYF
         /D0UiYWM0adLsp0Yej/6EDIWbzlZTUqWesR7QTzS1bxHzJsBcmYs1zS/4+HFbFEWBgVP
         Chy2arCY+R4KvBGxDuJeyC4elvrJuVx0Rm3qNfCrFaSBNRS0wVAiXUlNszVE6No0++AS
         ZzSuH6ShF1Ms1CEmUazX0L1QFK1XjU1S7AufirGyw3NSP5rGsz9OsAu7g+uFa2bxfqmJ
         knuve9qON924e4eLGTiCRkZR7e6EMS1alktfhk4fLmMqRnL6ZS3EsA46UFXIGUI5XWP/
         vAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zwo/8FRaAsRfmRY6byv+l42XZPVwXQJhp9yYbuihb90=;
        b=Ce1i57TMCCOYfN+d4ScXLmtG7S7JLezG73FfkM5+SAOuGySN62j/dItvywYDCrRtAE
         krExXGAifivPxvlMiX27v1AUEL/Dj0Y0Kz29+iOhcIAsHvP4xoWndQHKZbH3sDYBlvi5
         kyuHjBPDQFmVlzIR5ZwHBDWZEKZHmuCDR1DXcyhd9Diu4vbjw1sGDIml3pWH2lsy+AAV
         re8ccqsDl+SEvWSkGkUrkYFHq/pFb0CCyv6RPXz7sPkUfhU4Fehtnpe69kypUPkQs6kH
         4BeZbKzj6XhRE64qpAoj5eEn5wcgXPkAuyCCiBXfrtNu83fYmNkW7RGLhtq9qJh1ihpq
         lImw==
X-Gm-Message-State: AJIora/bU4cH0kUS8nZjbyURdD0stvB07/V/xyFtZ5Jp5mNl3WtPzTdl
        I5eQ9PvG9odGNOOuAormaHu9lTa1YXE=
X-Google-Smtp-Source: AGRyM1t5sSIffYXGk+J40JJy8ipmQtt3qtCZ+MSbnu4Z63RaP3KCjr7IUm8e1Rk9zzEkZzFb0cdmQg==
X-Received: by 2002:a05:600c:4e94:b0:3a3:4448:62cc with SMTP id f20-20020a05600c4e9400b003a3444862ccmr3167925wmq.108.1659114731337;
        Fri, 29 Jul 2022 10:12:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d45c2000000b0021e9d98bec4sm4143855wrs.88.2022.07.29.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
Message-Id: <d2e1af0f922ea5316074dd0867c66650161b0ab5.1659114727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
        <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 17:12:07 +0000
Subject: [PATCH v2 2/2] merge-ort: do leave Trace2 region even if checkout
 fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 557ac0350d9 (merge-ort: begin performance work; instrument with
trace2_region_* calls, 2021-01-23), we added Trace2 instrumentation, but
in the error path that returns early, we forgot to tell Trace2 that
we're leaving the region. Let's fix that.

Pointed-out-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e820e45a8e8..eb0296902ad 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3158,6 +3158,7 @@ void merge_switch_to_result(struct merge_options *opt,
 			/* failure to function */
 			result->clean = -1;
 			merge_finalize(opt, result);
+			trace2_region_leave("merge", "checkout", opt->repo);
 			return;
 		}
 		trace2_region_leave("merge", "checkout", opt->repo);
@@ -3169,6 +3170,8 @@ void merge_switch_to_result(struct merge_options *opt,
 			/* failure to function */
 			result->clean = -1;
 			merge_finalize(opt, result);
+			trace2_region_leave("merge", "record_conflicted",
+					    opt->repo);
 			return;
 		}
 		trace2_region_leave("merge", "record_conflicted", opt->repo);
-- 
gitgitgadget
