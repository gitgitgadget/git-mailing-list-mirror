Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BFC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiF0Sgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiF0Sg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE28F186DD
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so10314522wrh.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=003autOeS1xarsExmzbXFgnmDohyRCBEa/jqh+zG+G0=;
        b=jcIrbgNxh8nhD1MUpiL20plY0ReAIHyzrjtViEcx2PcVNSCTdDlpUlQflqrhoJMHsc
         t32SxDeeDhc3j8KCJPJzcy6yYYEeWln+1rPwN1KcZqzqg0KzWK3iQ6sWtF5ANzakqpsU
         BFQvbMDICFSrl0TLD64KVwhVHMRqDGyrRfg+tbqxCci4XI/0WX7+QJ2z7hcVJpirZBmX
         CFeUwO0/v8qX2sc6wAPV1gNAleXZd7td7w4dZYZdjKt6A4QnnYQZ0Fhc4zPjDbZyyf3d
         e4C0du+Pz9qgSGYwsEGa+yCoSgQUmBUXFV1l/DxIvNpEmyFG2o0uOHshlcfrFJ6k+x0G
         v9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=003autOeS1xarsExmzbXFgnmDohyRCBEa/jqh+zG+G0=;
        b=KSaNnVX9pxJhsJKQ8e7e/hGWQ/dlMhP/nsXDcsffyX8Nthi792Dt2azNbs3CbfNnul
         1xjweyg78DWDA13HzJkgQqHS7gGtJk+OpGmHh03eOqsZtxUOD41paZnjZqDgvFfPSnY/
         7BAA0pCzDzQtLnp9zgFjJX+XHZKOPyaTvH2OlS9VO/uN7VhYX7sazbzO+Z8MOK151HwZ
         IeSOqg7APKSF3N3mh4zizLMbJD1ChXfMWtZ7iwoyBcSPyWRDNkL9nqTCXzpUnEbpdK8S
         /whEjT7RnCtkEVIeePpzCwPJZmKt08+Zy0xYzf75ezobKAORgTNqpAmt4EvisSE8Tm9M
         3giQ==
X-Gm-Message-State: AJIora8rI9hfASptLTMJTR+15AjcnW8yeCjT5veNpyhI/Sa/V2jPL3kU
        shJka92BUV2txwsqvYwOZGcnYUguHkY8hQ==
X-Google-Smtp-Source: AGRyM1sXfI40xYdSvtDPVORZX05p4lSXeyAf3WOY3w7IUQg0Pu1vJJOvEZACtLMZ5z7qdqNBmyt0mA==
X-Received: by 2002:a5d:6ac4:0:b0:21a:3cc5:295 with SMTP id u4-20020a5d6ac4000000b0021a3cc50295mr13319368wrw.630.1656354684216;
        Mon, 27 Jun 2022 11:31:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c500e00b003a03564a005sm16171285wmr.10.2022.06.27.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:23 -0700 (PDT)
Message-Id: <5bfaf0334c32a5cf71c19c72c7ca65253d460607.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:05 +0000
Subject: [PATCH v4 04/16] bisect--helper: retire the --no-log option
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
index 2345c9f773e..8cfe3926dc7 100644
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

