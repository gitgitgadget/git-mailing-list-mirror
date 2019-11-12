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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5D81F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKLAON (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:14:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46634 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKLAOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:14:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so11916601pfc.13
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54zxbubQ1lxWOgBGYeA5PrKDyA9vlR3GKD3Z4YvyPwM=;
        b=orx0rY1vsfIcCuLJyxCNahFsPV5Y8Iaszor/fzN3qxcGETMppC1kxvC0hrZ5mSMMr8
         9I13wKJa1/X3VycdvnRr8fLlj4X0kBN9lDpAkv9+nbk2Z3l2tlWlvLv1DBoZ5dPnLUci
         8qJ+6d4OJcmcqnPCYU/uV/x65EA4FBVoLOi0UGKvMXMvQ6jBMMWD2kxIOU4sdzn3KUO3
         +se19wgwAxYyNT2XNHXM4yqmU8dysSVPQMn+casmL31mlQyk2j9LOKVFsWmGp57Wjrjf
         GpWBwRbLJsiIxV6icgwE1iuIcrs5NXyHRZkb/2wfxUkT0UBrETrXY3BPvP14Wb/eXBIV
         D/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54zxbubQ1lxWOgBGYeA5PrKDyA9vlR3GKD3Z4YvyPwM=;
        b=ERoxxPe6DBcReJENzSkx6+BtwO3jI+H/upwcTzyUrMvRcbsiy36elzeVPUw4nFGhu4
         TCwyKiaFxWw1eCJ3Eg9z2Zm+FpmWzMfs9Dd2aIf7nlzqbkM7HbK4+tTOCWX2y22+Hinp
         PU96LqncFOlbm30z8yorTM27pMwxysk6C3PEL6dM/UA873JPXEdtEkoBjZ9Y4eWOihV+
         yebmntOBs9Zgcpa3i5fib9hoFtpgK1k33187bG/2bMhRKKlzaSpBMkc3HEIzZC4uuGzQ
         zTxR9+S2X4r/T4z+44lM7X2ADtwmXN1KMiDFDI874sOa4skGAUNzUIOlonjMmpbL4PhO
         KHsA==
X-Gm-Message-State: APjAAAUx2oK4ulcAJcGLgtQZ4F4bpVqbQFmin+4vEzii16twYzIX4PWq
        ADXYPyRa5vVLw2M/Z6475L1u0Hi8
X-Google-Smtp-Source: APXvYqxItq0jNH33w2VRBmvCyI3V8f8/y+TNklMUO9xpND4FW0qGXqM6YAhRu4MTIOgiZxr/d2Wn2A==
X-Received: by 2002:aa7:8e4a:: with SMTP id d10mr33104981pfr.176.1573517651789;
        Mon, 11 Nov 2019 16:14:11 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id v63sm15622038pfb.181.2019.11.11.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:14:11 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:14:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 13/14] t5520: remove redundant lines in test cases
Message-ID: <7888757bd0cfd13fdf278d10123c47f15cac5f59.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
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
2.24.0.300.g722ba42680

