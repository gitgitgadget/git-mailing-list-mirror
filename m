Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C341F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeGWOlC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:41:02 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39511 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeGWOlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:41:02 -0400
Received: by mail-pf1-f174.google.com with SMTP id j8-v6so102801pff.6
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BVqya7UcrLFit/JTmd/Xs+U5X7JfM5ZnmD99d751/eo=;
        b=AuhLiBNo6Nlsgj8CrBPVEZlVbovv4BLmXefoCxNroUcYuFhVSjD4G/xlnXQso2lgww
         mUR515tMm5WsZfMbnLUTiXq25ZpH48DmiAnZIpOE4x0d7TtdM0ElSVhibx50UcXG0Ts8
         OZoR3KdW3laTJHpl8Dg1PtJOudT38uwRViib0VnHLqbxjN47O0GGv4JBqd1Neiwft0ea
         RCDvomKiZjPwtiRphrkFe+cbHLgM2U5NKKF5pYNwusEExz7UdEbYaUK2kaT6sPnpm2nk
         lbX86RuhNlSErvprceuO3O/g0D3H9dzhzlsI30CH2CtI+MJ/Q7hNALj8ibrFTJizUGlQ
         up+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BVqya7UcrLFit/JTmd/Xs+U5X7JfM5ZnmD99d751/eo=;
        b=RUcv1AUYA1eJTGHEDeruDTlUNqtfiuDGGgdodAhRp6HdcSI8kUWR/uvq9MKE0YGrR3
         DKUbd5xiu3Tt0js7kbea0R/xTAlKJLxZVVq9jFcXWLJR/7HkdOO5Efb0SpUOryK2mXwu
         COX2Ezp7kuPmXEiBZOX9RZfEmfmPuBZ+JoS138BkJJ1Ny2HUwbMZ/C1NM1KnvXhbeRFt
         dwiR3bL65A+O7SX3Kvj3yOGB/PHkae3uZjYeLcBNiM/Cl+zuNOZEV9YZqnryGOLTaNm9
         bF+QmPf+XdXhSIYhqhW58jzvLm+hpRM6vGVHklpfkufj7JUduuBXtO0FUSzF7IPcD4Pa
         LM9w==
X-Gm-Message-State: AOUpUlHHzkwBemaoUVGXX1kfZrH1DP51nKq47Q0DMlo6MPhb1Cktcs6u
        j5v0VaXVtmCgIvSx9QY081wdsXPl
X-Google-Smtp-Source: AAOMgpeLSAeyWOgPZgeH2kck9sOO1PZDh6hkFSuXPqUpUODcTAcZdRHq4zKHTrKnRrCdN7HzDLxuzA==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr12328997pgw.132.1532353183104;
        Mon, 23 Jul 2018 06:39:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id i25-v6sm7718177pfi.150.2018.07.23.06.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:39:42 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:39:42 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:39:39 GMT
Message-Id: <78f7a5e4baae162d1dff18701a25903b304adf9e.1532353179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.12.git.gitgitgadget@gmail.com>
References: <pull.12.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t7406: avoid failures solely due to timing issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Regression tests are automated tests which try to ensure a specific
behavior. The idea is: if the test case fails, the behavior indicated in
the test case's title regressed.

If a regression test that fails, even occasionally, for any reason other
than to indicate the particular regression(s) it tries to catch, it is
less useful than when it really only fails when there is a bug in the
(non-test) code that needs to be fixed.

In the instance of the test case "submodule update --init --recursive
from subdirectory" of the script t7406-submodule-update.sh, the exact
output of a recursive clone is compared with a pre-generated one. And
this is a racy test because the structure of the submodules only
guarantees a *partial* order. The 'none' and the 'rebasing' submodules
*can* be cloned in any order, which means that a mismatch with the
hard-coded order does not necessarily indicate a bug in the tested code.

See for example:
https://git-for-windows.visualstudio.com/git/_build/results?buildId=14035&view=logs

To prevent such false positives from unnecessarily costing time when
investigating test failures, let's take the exact order of the lines out
of the equation by sorting them before comparing them.

This test script seems not to have any more test cases that try to
verify any specific order in which recursive clones process the
submodules, therefore this is the only test case that is changed in this
manner.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7406-submodule-update.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9e0d31700..4937ebb67 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -115,17 +115,17 @@ Submodule path '../super/submodule': checked out '$submodulesha1'
 EOF
 
 cat <<EOF >expect2
+Cloning into '$pwd/recursivesuper/super/merging'...
+Cloning into '$pwd/recursivesuper/super/none'...
+Cloning into '$pwd/recursivesuper/super/rebasing'...
+Cloning into '$pwd/recursivesuper/super/submodule'...
 Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
 Submodule 'none' ($pwd/none) registered for path '../super/none'
 Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
 Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
-Cloning into '$pwd/recursivesuper/super/merging'...
 done.
-Cloning into '$pwd/recursivesuper/super/none'...
 done.
-Cloning into '$pwd/recursivesuper/super/rebasing'...
 done.
-Cloning into '$pwd/recursivesuper/super/submodule'...
 done.
 EOF
 
@@ -137,7 +137,8 @@ test_expect_success 'submodule update --init --recursive from subdirectory' '
 	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
 	test_i18ncmp expect actual &&
-	test_i18ncmp expect2 actual2
+	sort actual2 >actual2.sorted &&
+	test_i18ncmp expect2 actual2.sorted
 '
 
 cat <<EOF >expect2
-- 
gitgitgadget
