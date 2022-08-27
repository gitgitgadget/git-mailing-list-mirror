Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F7C0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiH0Mof (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiH0Moc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BCC31374
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu22so4418603wrb.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mUxdgs/oj7+z9X3ltpWKwdv75dd+R2a119akogQaQkk=;
        b=Df/T12AzCli8yOajjykg6sBiy1m4TGEc1ErDSIHlQTJphXlCmb37IOP2IJ3xg7hmIi
         RH84l3qxJHE0Pmd4ny23F7vmjw33ILI10EP4ioxYwTqFQ18FLN4EByIOs0dLaSwG1nyN
         tpkjxWwcgMoP4od2Kxg+GmsaHi0nVA3ahFSCb6ZH0zh3BOY440ytPowBjnMMTzyZdoiY
         Q957E7MudMWPiLzaTJvwwYnana4AyRtcMf11w/ouE6v9fn4jhRZwk2PxDgJBy1yu2sJz
         SzTSwZEWYbj42YMtPt3CtV/TbbgAlkJ5ZxU5IHZi4hPcOUnS1LbncRvmIf6L9aqn2Inm
         JlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mUxdgs/oj7+z9X3ltpWKwdv75dd+R2a119akogQaQkk=;
        b=iGZw0PP5/S1QqRwLPGiyopJlqp4shikquS/p6rV44KxtiqFpKnx2Xnvd+8S28doJSS
         JErl2xZQab7nBG1MdKiZ/4FLshFezsnrsyNnsjl9/kH3mnJkeaKNXwtzDt7mXwYAwV+J
         1RcealnPI1CyUpzyIuczHiqCGAxHkSPtLIgPrQehp885O9New/AKdwy9DbgI063s2yr8
         qZQ9MNpn8edbfSJ9DCAaVwahMRv4qvjZ3CS6086rxCnESVx+lc7nBzs+M5BOsawXTfyQ
         9LQIz0zAJE1q78AjiSb27vG/7+PA7XioggUiZ7nUya/jrKzO2vzhbi4Xvfg3jx4ruPvv
         seBA==
X-Gm-Message-State: ACgBeo3Eeww25zlSYpYwbgYuS4LWiUUsHNv5vqgj5wwa4NzeCuy8rj7w
        Qj01s2H1MrTgUJ8k+Wdp1V9oI3Xk/hA=
X-Google-Smtp-Source: AA6agR7DZ6HVRJcv56s5ovsCqhMSoEGSsWRAmBvCihz2jGtjCOmpxYwQDWnK6mTHfrcHKEh30wvxUQ==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr2111473wrb.622.1661604268970;
        Sat, 27 Aug 2022 05:44:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003a83d5f3678sm1695180wmq.7.2022.08.27.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:28 -0700 (PDT)
Message-Id: <05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:09 +0000
Subject: [PATCH v5 01/16] bisect--helper: retire the --no-log option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Turns out we actually never used it, anyway...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7097750fc6b..2cc69e1eee5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1292,7 +1292,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1316,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
gitgitgadget

