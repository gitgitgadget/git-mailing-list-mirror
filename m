Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A481F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKLXIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47090 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKLXIS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so158800plt.13
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sfETm2vYn9ArY37ZWQp0LfwcF7hc79Ak36KY+CRgJ20=;
        b=Ou4CPijmn4Vn6WdTffsz1JXPOvwOn53EqES4Ypw/Hvng2vd12GE+tGcSTJQz4RSh5T
         bDDJR+7uKqB7swLqfQ4owtKolyhmgJ6buPuTfxvd8tD1pufNWRYtPU32Js3V/IE+CKUD
         6QZtIpaUnYmZ6n/alsAIXmyb5syYeSKTAKucAfrVR6ka722NM4Wc+eZEhPeFPj+uLi5R
         PrX2lAo+BQgY7c4IGO5dC2ZE9H6ObZdD8FnDSo3Vbdo5pKlmJqwAtVwqjisWYk2peWYU
         jHrF+9a4QOtKBraPGgn6za7oQ+t/o00Y7dKnzajlVvtqGHLitASdKzQ6UKKbDgrgI5uN
         dxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sfETm2vYn9ArY37ZWQp0LfwcF7hc79Ak36KY+CRgJ20=;
        b=JxxmhKY98k5do/HwPOUEaqsDyhwSE/pC72ihvU2DXeciv9zhwY0kERdZImXAw8r3Yv
         6LA3ReB9/HXKILSWc8Wisip3Ke1hiQOeMJzaDoPD7MNbGmueu+yh1NYL+XFvfh722Z3U
         17PP+WGRtzs2zfHaS5xCexf1P8ppvQs2/uDp3i57CqKJ9iK2vKGT1P1pZXX906djjydW
         Ebs4pfgR2UVsfYAptLTCy7KQ5y57oHIcq7iv0NB5zwYi6MSKXQ+KXDGXnhV6jjFKvomM
         QQFF/Xijv4DVfH29d42UBBvu8038l82LNmzCgWC1t8GOLeeE/4ViV5d8+fa/4GCjSnaD
         ZPsQ==
X-Gm-Message-State: APjAAAXSRpzZf7qeYYoNG8B+FYN7Cz1CYX/sf05Qgzo7mi57xtkL1mUW
        codrIUgbA9w0SJLAZiMeJ6746u7G
X-Google-Smtp-Source: APXvYqzrh57bHO3H13GL/rpL2M5mNR2GCV/Rp4xabBpMoTarFch3Ao2htJFHOm/QOyWI6vHKquhrXA==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr324603plp.61.1573600096587;
        Tue, 12 Nov 2019 15:08:16 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k32sm179980pje.10.2019.11.12.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 13/14] t5520: remove redundant lines in test cases
Message-ID: <b45c088d20c75f9e58cffd500beda32399071d12.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, the mechanical application of changes left some
duplicate statements in the test case which were not strictly incorrect
but were redundant and possibly misleading. Remove these duplicate
statements so that it is clear that the intent behind the tests are that
the content of the file stays the same throughout the whole test case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c9e4eec004..ef3dbc201a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -147,7 +147,6 @@ test_expect_success 'fail if wildcard spec does not match any refs' '
 	test_cmp expect file &&
 	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>err &&
 	test_i18ngrep "no candidates for merging" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -161,7 +160,6 @@ test_expect_success 'fail if no branches specified with non-default remote' '
 	test_config branch.test.remote origin &&
 	test_must_fail git pull test_remote 2>err &&
 	test_i18ngrep "specify a branch on the command line" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -174,7 +172,6 @@ test_expect_success 'fail if not on a branch' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "not currently on a branch" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -188,7 +185,6 @@ test_expect_success 'fail if no configuration for current branch' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no tracking information" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -202,7 +198,6 @@ test_expect_success 'pull --all: fail if no configuration for current branch' '
 	test_cmp expect file &&
 	test_must_fail git pull --all 2>err &&
 	test_i18ngrep "There is no tracking information" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -215,7 +210,6 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no such ref was fetched" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -685,10 +679,8 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 		git ls-files >actual &&
 		test_cmp expect actual &&
 		test_must_fail git pull --rebase .. master 2>err &&
-		echo staged-file >expect &&
 		git ls-files >actual &&
 		test_cmp expect actual &&
-		echo staged-file >expect &&
 		git show :staged-file >actual &&
 		test_cmp expect actual &&
 		test_i18ngrep "unborn branch with changes added to the index" err
-- 
2.24.0.346.gee0de6d492

