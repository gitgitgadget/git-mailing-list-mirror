Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72AA1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeFGFF6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:05:58 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41295 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeFGFF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:05:57 -0400
Received: by mail-ot0-f193.google.com with SMTP id d19-v6so4476173oti.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N79offoimsq/O4uGjTdslVFNGLUC/4NdPrHknxnYFiM=;
        b=Yfm4h6AEIOr7a9Y+Zkgk/Y4QX/o07QisfRxYXxkr9NEt8wMlRmZJvF/IDV9cqni+/9
         MPr26A4g8UN8p89EbNZ9tcGjbHwlFVeb6EhsFuc6HHEzF8a0a44FqVgV1J/TfTNan5pn
         Ar2DlbdOjehL+cXv0w3gDh/usdBpuDp2MSDJDaL0WmDCY6Q3b3Xtv2VjHSeKH+snnodA
         qaAHES9b5SInnBnymRVZlAlKaiTXPpDuoDV6oYNm3z8FRhEhazjJdFLCgr4rEm/LYg4Y
         q+qF5zlWADMrjnvUNYN50ILr+tSMnSNBOeh2+PU4ymWKmLhc3MHY3yyC1AdZTLcsf46t
         tbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N79offoimsq/O4uGjTdslVFNGLUC/4NdPrHknxnYFiM=;
        b=Ivi+sc/nnH5WdW33FsOkc1C2/XpIWzpUkYkkFzrlmF87i3BHn2+jTYrqIzV8PfzC2o
         g4h0pU0AIz1FCaiDJv2Uvi93shhiAe+8QxjoB1WGd0HKLm5ijaDKMlHMulpCsR0OG8lZ
         WSQ+yGzDsHQG2Xv5dk6A4MpSXj5rZ8y6nRr7rS9Br5dhGBb2zKyTYNYBcM0P5qNNwIxU
         XU7GeHDwOn2j8J9pikOkw62wa86yliejXS4HcdT5YQjf83o7yZ0h5aKlQndkywgld6fY
         qfUFqTSGtQY2A2VF1+NrmJ4N1CNXnimVN8TMK/sgF0Kvm/9lbNg5xwsyJzNU4fTvqXp0
         uuMQ==
X-Gm-Message-State: APt69E1PM+oatMAASYRAkYr30ZpHj16CREL/f7Q3cpopmKbiwbue8luR
        uykjdGCEuHRAO4yU0qbi6BdEwA==
X-Google-Smtp-Source: ADUXVKKUVxxIcmx5sqSfvdimzPWCh3m8FRKGxL5Dozoe4TzCLSmcZyZmAo01klasPBsR1nA7kGuoUg==
X-Received: by 2002:a9d:c41:: with SMTP id 59-v6mr161089otr.255.1528347956386;
        Wed, 06 Jun 2018 22:05:56 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q7-v6sm9704086otq.39.2018.06.06.22.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:05:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] t5407: fix test to cover intended arguments
Date:   Wed,  6 Jun 2018 22:05:50 -0700
Message-Id: <20180607050550.19546-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 8 in t5407 appears to be an accidental exact duplicate of of test 5;
the testcode is identical and has identical repo state, but the test
description is different and suggests that rebase -m followed by rebase
--skip was what was actually supposed to be tested.  Modify the test to
include the -m option.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5407-post-rewrite-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 7a48236e87..9b2a274c71 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -113,7 +113,7 @@ test_expect_success 'git rebase -m' '
 test_expect_success 'git rebase -m --skip' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase -m --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
-- 
2.18.0.rc0.46.g9cee8fce43

