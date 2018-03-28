Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA7F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeC1WVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46869 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeC1WVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so1788844pfe.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSHqSdeJXcufyfsmCMnhBEtc8SaQfWkmlp3luE+Jl1I=;
        b=srRheOEFHt2LbDa+1/cSTLlezKK4cYvia+mz+eSWOPLYtufVcSUYmd20ewgiw7nV64
         CIVxJ21Nmf/8o2eCaVfw7XfNexujPEKegQ+v2AfMTZTW1J1+PX4x1FiITUvqydG8hb6J
         kPx6UK13SYP8w1XetflOnDO2VXRTSNNbywdykCopbtqdLwZXZfXxrvgbXx7rtoV1PTku
         NYTu6rHG8o42TYUz7spxpKl5QDb2UO5FZL1hSeK9sqW6CnM58aViiJzmoALsagg+Miud
         oVEvP3rtvZhYgjjKpjmdEN6Ym15jivQj0gwFK13lTPTYsK/roFRn5Z1+NL5aPz570gKY
         uZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSHqSdeJXcufyfsmCMnhBEtc8SaQfWkmlp3luE+Jl1I=;
        b=WXQTH6xaWzXdU8Whgy5387TpTCvINPtq9Ws7pimDd3DUv20dt0MHWSqXtDq8pTCEVE
         0w4dGJU6FEThXyGwMd4ng5jvQiz3A8Ih9+bhf6GOHNIdWNU6OO7yqfHmpvkPZjfJyGnC
         kh5CDEOWK3W8NNxmJpF/eoSNyhbECArlSieASK09luAaYmFMvHU/eauEJlxJJi4MERkS
         CBv047oONbI6Zx852vlZ7FTWJCiAwjKOqqoPCH5xQtSmQJ4K2/bMjsrbkZEpyaol0kXe
         i1l79oH8qcpkFNjpbV3BYht9Ema7kUgUDWh7utdOvkl+Zov4RpQVMF7akg3TBFYqF4de
         bBGg==
X-Gm-Message-State: AElRT7EPVfMbqw5QSObaN8gANOOS3yW78zxelQ2wGnEuvjQap6o47eOH
        pbRbgu6NhLgTcbZuL+J/LPLokx0=
X-Google-Smtp-Source: AIpwx4/Z7FEaX9VXnbDa35o+t2A+8k+1w9dZycsUQEyXbk/cWzX0nN1f9MB9WVGKEkQh6RkBs/X6Ug==
X-Received: by 10.98.200.130 with SMTP id i2mr4262221pfk.221.1522275702659;
        Wed, 28 Mar 2018 15:21:42 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id e23sm8801907pfi.76.2018.03.28.15.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 15:21:42 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 1/5] stash: improve option parsing test coverage
Date:   Wed, 28 Mar 2018 15:21:25 -0700
Message-Id: <20180328222129.22192-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328222129.22192-1-joel@teichroeb.net>
References: <20180328222129.22192-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many paramerters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aefde7b17..8a666c60c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -84,6 +84,17 @@ test_expect_success 'apply stashed changes (including index)' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'giving too many ref agruments does nothing' '
+
+	for type in apply drop pop show "branch stash-branch"
+	do
+		test-chmtime =123456789 file &&
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many" err &&
+		test 123456789 = $(test-chmtime -v +0 file | sed 's/[^0-9].*$//') || return 1
+	done
+'
+
 test_expect_success 'unstashing in a subdirectory' '
 	git reset --hard HEAD &&
 	mkdir subdir &&
@@ -479,6 +490,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.16.2

