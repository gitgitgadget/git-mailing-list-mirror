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
	by dcvr.yhbt.net (Postfix) with ESMTP id E63E51F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfJVKUb (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so10371334pfw.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yuqv96I8DjEjL+pOqyR5tndhP7o7H1MzQUYkONRYwjc=;
        b=NCxXiN/u9Wv+btIwvtiy4Q+avl5wU14v0Gptv1O0YoSrMt9oCv2c0LB9ykobKh+lgF
         GM+vCKQA8xJdGXIshhiEskFOCXza+WGN65bhhMO4wz6iKiYDjec+6q49YREMrelLr4q+
         6UlupGU5a9DUW3KX9sCnZrW1uq+06WSHRmUKWiFFaCtg9XX7cH9g5Eg/sLk8i9erb5Kq
         76gO91NaWcKBa/vRnQZH5WXky2ZliNPMr6vKRnolGcjJj/p2YcH0Kvjb7oGZPdueajI1
         CzWA3XePU+90znBzrWBmZEDQ1UE5hHkWVjCVd7uDDUHaqqLx5s8WNK3YxozHRXQeCuaH
         MdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuqv96I8DjEjL+pOqyR5tndhP7o7H1MzQUYkONRYwjc=;
        b=dPTE8SOxAUoivMU4RVMi+B3D31gYMeiJUXm2Zy4DeJt9tS0tEWdScq7Em0Ki+hcYBD
         /P6UPF937XhEv3zQTEi3G3/tAR2hr22ioP4aAEo+lSKjJBPJHEcHhNwhvl5/YkHZEfSM
         hL8FIdxMCQ6Rbg2PazlTgK0h5ol9Zx491KbGEohl+OvpSikAzPXwy0HvEl6a4wC3VLz3
         EkFobZRs6g65xJWsI76p8ErPd/Dq8PQDZ0ytjdBp6jvvXLGc8vsf0lqS/em8hItK4TRR
         RvEjYvVO/IAgSZaprhlQJzGCoDm18CIoXjrb+QhW6Xpr59T805iwWUc9G1VGK0cdIpO9
         SCaQ==
X-Gm-Message-State: APjAAAWfLig88uEoc80V5Oenb4STUqCpTnmHdT9QfqkDAUNj/+16ctAe
        FkrXMDIKAEeGh8a68N4L/K7Ofv8O
X-Google-Smtp-Source: APXvYqxx1iqvqDk8VSLxLo1Yp62H0Itj04Cz1BHqKWYJglJ8u6j/Z8rwtB+Cj0L3DdIeMsDSPHJpgw==
X-Received: by 2002:a63:1f25:: with SMTP id f37mr2959577pgf.50.1571739629222;
        Tue, 22 Oct 2019 03:20:29 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id t13sm19666148pfh.12.2019.10.22.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:28 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:27 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 13/14] t5520: remove redundant lines in test cases
Message-ID: <9db0fc2156ea8fcdf060932967a6ea989922c989.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
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
2.24.0.rc0.197.g0926ab8072

