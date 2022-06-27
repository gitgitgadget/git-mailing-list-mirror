Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984ECCA47E
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiF0Sgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiF0Sg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EF186C4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so14260639wrd.8
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=MYsq9ZwngdCVjtsoRabZkP40n3B1MjbtWrNtGhnowQY+D9ApufCBSqdQAjUs23DYGa
         uel8pdWNaDSeyhkI7N5/uFPJXxWXHBsg9vPlts5RMQZGy5EF59045NznkFHF7cMi6bpw
         8igmhb4URTYH+9iLXPzo2IixU7kyu6/sbnvvrxLoZdwYXtCvCOcIrqkpCFo+E2p4pihA
         ZUdJ5EKB0l6l3p05jez1DNQLGSRAq/PIRrd0okOo7C1JJLpBS5860/gV2xsWtO3PRb3i
         B5MX7pmvG902O3ghpp3Ib8iHNpW4Ok10H7kCmeUY99QU6Oc/lcmi1WtFED2poyJM8Y6P
         KUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vJ/hCck+XaBNHDW9f2+pkxNta44cpypydrMCRFEptu8=;
        b=riUQbMZKM4CzxWHpvMnhxcCkX4waMDJblHwQSXABJFGf78Up8K94zifk8i8CgjHZYP
         pde71VkTjbJQ+1m6kHH6Oo6t1d9R9hmaq7AmygCmEZrSMM+P/lOyS93X6d4dJ5lFADfg
         cBYCVvzxhC0baClXfEy2T2G/1veIqNKRic3lPKMQfsb6Ja6giUSddtPDJn81EV6pmuBm
         w9b+pIvW8wo5Ez7ZHtyQ8NS31bz0rsJAYoFRtcR2ogSIMjMIAmvE1QXWJSreqnBQYB2b
         qM6JTeqLZ1t2KSfEYmfX9rQNSItNRIINj9DMdJ2VfUNKGjri8BJ66iGMtDe+JXDS6HUr
         t0Zw==
X-Gm-Message-State: AJIora9JOPcTKNHt8mWUxUjeTCby5bzjsm6mExz4m4Qfzx1qcd9dVhm7
        zm3Yv122gLquEXjA8fOj/iE4bEs4Lsla6Q==
X-Google-Smtp-Source: AGRyM1ttb2Ew8h7+Bk41BamRiTIVFrQNz5ZvBiDeOd62MJ3Fv39ITgu8gK3b8GU/WvQy2zkWWqUkwg==
X-Received: by 2002:a05:6000:1144:b0:21b:8ba7:93f0 with SMTP id d4-20020a056000114400b0021b8ba793f0mr13317487wrx.361.1656354680582;
        Mon, 27 Jun 2022 11:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b0039c811077d3sm13891655wmj.22.2022.06.27.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:19 -0700 (PDT)
Message-Id: <30ddbd7affc83e9b20ecdd66d941f1acc2cbc787.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:02 +0000
Subject: [PATCH v4 01/16] bisect: verify that a bogus option won't try to
 start a bisection
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

We do not want `git bisect --bogus-option` to start a bisection. To
verify that, we look for the tell-tale error message `You need to start
by "git bisect start"` and fail if it was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482fb..6d6e72276ae 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -900,6 +900,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bogus command does not start bisect' '
+	git bisect reset &&
+	test_must_fail git bisect --bisect-terms 1 2 2>out &&
+	! grep "You need to start" out &&
+	test_must_fail git bisect --bisect-terms 2>out &&
+	! grep "You need to start" out &&
+	grep "git bisect.*visualize" out &&
+	git bisect reset
+'
+
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-- 
gitgitgadget

