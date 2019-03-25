Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622CE202BB
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCYSOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33433 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYSOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so8426711edg.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fSib6Aueo4f2tH0P/GdTW+1ikI+DVkU702AgxIHCrso=;
        b=G1HBaAufCuYZBKAimBVcEEyaTD1ky5k18X9hKNADfEdap2/saaH0BfouPo3GEPieC9
         EVDgvLij/lfJMx/E7BfhKoRSQ/fKGrMwoEIBXj2ArrP/thehx7MnoboBviCyDyP5LKoT
         xH8toi/elFG6XcpvTwZ8eZkqR9El+aS/b0RrNuYwE0bpjh0Y1Ti2rYjzZxbtu5KY3JKY
         96riXh47ZVyzToqz3WWTmhx1Gf2a9JU3PB39ZdcruHxBGHl+1/WL7ZndfDrC+HT7eGhS
         mvOk1IyhN+nWpRGxmK4P5USbwjYrEOm0diYLIwbHXS8H212qnye6alfCJPC/UR6BJ9r5
         2wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fSib6Aueo4f2tH0P/GdTW+1ikI+DVkU702AgxIHCrso=;
        b=BYhfVsjpf47Pcyuh9wXa0ghAcfD/1vSkEv7U4dkkHq1YvCYST7InC2ODCMwcxnOel/
         jBddznD7bUAX90WA66JIgwbbARFBJK099CyeIt/ZtRLDR66hjEtJH7sDl0VHnicYKzBW
         PH+UnMjXgnW6KgrCeBhnWkVuUGVVYVZI69/C1if0Gn8mozbiXx6kBIODX9WhlmV+XISU
         QH8i9nQqSzBBlDxd6qvXsGB0YRqNJ+WdLGOS9uJmoZwCpVYZYn3HqwsI4IEDn4Rbj7X1
         wC0//zyhGJ/bsMfMeMkdKZvYr4Yo4lC0B2BNh4ngBsLYmbmWVqM4+iHZm37X5U9Y4jkz
         rqxQ==
X-Gm-Message-State: APjAAAXyr2s9KyCvwArxR95E01q8O/c2f/2jfrYB4A/qAQGSmBTYbtc5
        Mh+OJuen2i3+CiewMPLUR1C+EzU/
X-Google-Smtp-Source: APXvYqzDm6wbt6Yd9KLCiC6s0yELTTncfFVFys1VD3LWoL9Ezq4LpiHCvR5UAWq9YXej+ljG8wDKLA==
X-Received: by 2002:a50:c251:: with SMTP id t17mr17640543edf.179.1553537658660;
        Mon, 25 Mar 2019 11:14:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm3651457ejl.22.2019.03.25.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:18 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:18 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:09 GMT
Message-Id: <a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/8] tests (rebase): spell out the `--keep-empty` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This test wants to run `git rebase` with the `--keep-empty` option, but
it really only spelled out `--keep` and trusted Git's option parsing to
determine that this was a unique abbreviation of the real option.

However, Denton Liu contributed a patch series in
https://public-inbox.org/git/cover.1553354374.git.liu.denton@gmail.com/
that introduces a new `git rebase` option called `--keep-base`, which
makes this previously unique abbreviation non-unique.

Whether this patch series is accepted or not, it is actually a bad
practice to use abbreviated options in our test suite, because of the
issue that those unique option names are not guaranteed to stay unique
in the future.

So let's just not use abbreviated options in the test suite.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5407-post-rewrite-hook.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index a4a5903cba..7344253bfb 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -131,7 +131,7 @@ test_expect_success 'git rebase -m --skip' '
 test_expect_success 'git rebase with implicit use of interactive backend' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --keep --onto A B &&
+	test_must_fail git rebase --keep-empty --onto A B &&
 	echo C > foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -146,7 +146,7 @@ test_expect_success 'git rebase with implicit use of interactive backend' '
 test_expect_success 'git rebase --skip with implicit use of interactive backend' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --keep --onto A B &&
+	test_must_fail git rebase --keep-empty --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
-- 
gitgitgadget

