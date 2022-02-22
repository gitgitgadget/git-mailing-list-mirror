Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5F1C4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiBVQa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiBVQay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6940166E27
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az13-20020a05600c600d00b003808a3380faso2358839wmb.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7429hhfNkiW/qxWbha+VARTUnOlAfrXqdV83gmgZ41o=;
        b=KoS9NN/SFrlD4P1cKAAt42YV5XlzqCiJlXqaLsu6hbvN1jRbjElE01Dgkl++I/hcej
         /1Fu/HnPlIgXTT+MoKtXvz/SWyu4/Go9nGX336OY6SVQovOa88OY68g29+MDXp90rXzL
         wjPhAwrH6vPZ37l6i04tIWQkvaNPUUFg7ETUwFGxY9R2oDZbYieif0bvH0S4eOVNdgMk
         WLEGVQCrN7JSAoSw+iNdL0rONBDgVhC/3y/SQIMhaK51VcLwpKsX3kxO1HrpZTaqWcCf
         gqg20sIZlSUJ2gJsh6qMRmLzw2DHSKXOTm+5Cnen7kp8fCe6WxuURZ4TSiwF8nRyGRCU
         CIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7429hhfNkiW/qxWbha+VARTUnOlAfrXqdV83gmgZ41o=;
        b=Tim27fhHqI0ZVazuSpPwXQtZVZ8p8XXGDa2ypHRCIIrGCoMEIdmvD3H+asaVduplky
         ui2O0cdf1dIltbh/ESfKddf7X9XLx4HJEgPL7hQ8UVLorOJS6ar+NQew0Fu536w4WHht
         b8mOqMJmWBu5cJoBmEG54oEn+hcwYwDw0wj060nfiQAZ1uWzC27ZHFZ60zG7Wc08vaeq
         qkDn5TaRkHHaQaRxzZEGPdFkMJp39H88wYzsiRe788clMYTztfICDdf/j/G+RcnjBnzf
         VJQiksGSagtenlBeD8UbKt5quHL2XosGm/vcSGrnBOv01ggcZ4XemlAGOQWmSD/KdRtW
         hlYg==
X-Gm-Message-State: AOAM530E9l1U7u3mjGSBeNnVNFNzDAecwVvzKD6khw5q3aBar5on2gu5
        CoI0HBHnUzyGAHHF8n+MzTW9vjzDpxM=
X-Google-Smtp-Source: ABdhPJyFIrrexcsDBFa5qhrx/i/NBXqTtIxElYJpwrK/FluoukKWRDSjbJpzV6gxTIfbhnp7hhKUCA==
X-Received: by 2002:a05:600c:1d28:b0:37c:a9d:d39f with SMTP id l40-20020a05600c1d2800b0037c0a9dd39fmr4037829wms.172.1645547427338;
        Tue, 22 Feb 2022 08:30:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm2408410wrm.100.2022.02.22.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:27 -0800 (PST)
Message-Id: <88d7173c86bbec7416cb43c408339c24ed015dce.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:12 +0000
Subject: [PATCH v2 03/14] bisect--helper: retire the --no-log option
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
index ba6d90635a5..71a6f8f5192 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1182,7 +1182,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1206,8 +1206,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
gitgitgadget

