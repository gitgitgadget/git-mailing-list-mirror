Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA761F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfKGSvx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39193 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfKGSvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so2135558plk.6
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nyJkNi2RC8Uc+UwszCOT+m7gidyiW2BU1hwxpru8MBM=;
        b=ohQLsBzKjHeMPpci/jLkd6nMyWbas2/uCHsaH4nur4hrwRXQ4HF7E2GvJed8kRPeLE
         fSWgnQn/9CTybgJSqCC7dDtDDYuHBqnjjdgEeLJkOMoKLScYIHH1gYAXxSnZ2Jekr71F
         a82WNBmUSjr6yATpQ4/hclAwhKwAHQCjhQDDK8wrljDqw4s9saNaJHYB3PpkWFhay5aZ
         ja4wXuhDixh6/m6azPpubjtsFzyEUTAzx+mhfLSezGWDtudWfB0Il7mKFRPFKNNRSWzt
         QkxdiHQiC8eISlSDiu3XJnNf7nC46UsRgb+3AS1OLTEhkr5LYP7+miWd7jk5+RnGIIN2
         YUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nyJkNi2RC8Uc+UwszCOT+m7gidyiW2BU1hwxpru8MBM=;
        b=mfBxldiy6yoO5bXqDR3iDM4fBgpmdBt9hxTLmwvDmtuMNhYoz2DiFecHyLq6RFfVYa
         xB+mivUr7O7HD1gHtk0zM1dzrqPxyReS1WoFnvujbLbVGbbSYwdgVJ8s+fxPwsglm3Md
         GX8xJjJprwvkV5jGypoFFfm1vg3BQDzKNa9TQaUsdqJuIIZRv516ycw8rQDeEi5BQY3C
         WxiDn1Rurio1J8fQ9UhVmteYKErVRB/LRjEOSjMYxCI1ZHm/wEUWJhcXxYGx47pfPfjl
         pJx6Pgp7CWgt6kHjdEjlJSNdwC8nRnP5VFc+Ig/KFx6OX7Vert+7THe22sOEu+0dMRAg
         l3ow==
X-Gm-Message-State: APjAAAXaFy/DJ+ynoQBLaWTXlR6jyCxsKJE1nJATUW0wk4xi+voQ1son
        VzUEhgiws2eQmP9G4EB61bfM6Ee1
X-Google-Smtp-Source: APXvYqwe8RIIB+jx/vTx9ZhkGn/R8mrSNWWlB57slvpKUBFmgmNXmwUlxyfuqPfM0cvthtsqFYWrEQ==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr5347147pld.248.1573152712081;
        Thu, 07 Nov 2019 10:51:52 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h8sm9664262pjp.1.2019.11.07.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:51 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/14] t5520: remove redundant lines in test cases
Message-ID: <d08e34b02119564dbcffc43d3d7cc7561973acfd.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
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
2.24.0.rc2.262.g2d07a97ef5

