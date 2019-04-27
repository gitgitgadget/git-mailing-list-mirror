Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D191F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfD0MCX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:02:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40746 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfD0MCX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:02:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id s4so3001434pfh.7
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uvhKIfcAiPmsH5rHeP8Iv+XIxjA5WOj+rvjTaPMcQm0=;
        b=bKFGO2wGW98ZzYsNcRyXUzdL/lwouhIDN66z1bheI/mA8znfzdbf9UIsNZkgxLrV+O
         Gaoelev9Wzs5q6lfHgyZye2crEmqM0CmTMtpZ3dYNOaH3iwzf9L+4DqZVyrWJOe2i6hi
         ms1utMrbd98VWEbOvqnr0eE/YIq9NQUHG05ymmE3UJV/+BiUkfJHULV4fI1L7P0eglbZ
         pAovBPDOrmPmdSXI95xGxaFK63NhQOkaZxHcixBKy5o5voud5omaTuAbsTxkPMUCp5f4
         dd44GpsYwyWb/59C9DUaCC17Eex/mQv4MXCG1o3+ekoUZcfcgVNv942KBBY9GBnDVb4S
         n3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvhKIfcAiPmsH5rHeP8Iv+XIxjA5WOj+rvjTaPMcQm0=;
        b=rqYZWrtZWdzvekifBebWHPNfhTYLNMN/+4LpDIDqAEiRhFD+SHTaKr3rk4BZvqWP+s
         Eqebv0mCcoGrPXu8DEAZIRi5bsndWjuqDVFU88XguDDKMLHepwj4ZKZJtrgrJoRCdU+T
         pvBEd3OqlbwO3zWs6wNAsYFP6o+EWk42L6YPA509sqKdGAtlbznIGP87tfFl71+6SAy7
         VckDHyeh3jqAzAT4PpuSJ/NiR4QGN0kP9OgkyB9Wwm6LFo+43UK5rQk4+5WbKuJWksVJ
         TO7yjJNZOlQ1KlHL5D2j/WpDpY5mGiwdHXojwzMYc3tGq6VB2seAscMAisVSqwIDOztK
         BEPQ==
X-Gm-Message-State: APjAAAXfKNq3vkl83zPOz4GjbM3UTQOBMetnTd4zJERqun+vUBvQJfgC
        3WIBD136AGQzYcZc7nTYmCGG/FSK
X-Google-Smtp-Source: APXvYqzjF2b6L0VHrKO+dcxaV6Q5Ua39isj6gfKzKtQc2RZ0BOzHNzfClPPE9g35TNV70TJIVghXcw==
X-Received: by 2002:a62:2c89:: with SMTP id s131mr29419527pfs.211.1556366542490;
        Sat, 27 Apr 2019 05:02:22 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.2])
        by smtp.gmail.com with ESMTPSA id f5sm31591912pgo.75.2019.04.27.05.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:02:21 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:02:19 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] t2018: cleanup in current test
Message-ID: <9d04faf29dd61eb04ea292786d72eda0a3832e51.1556366347.git.liu.denton@gmail.com>
References: <cover.1556305561.git.liu.denton@gmail.com>
 <cover.1556366347.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556366347.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, in t2018, if do_checkout failed to create `branch2`, the next
test-case would run `git branch -D branch2` but then fail because it was
expecting `branch2` to exist, even though it doesn't. As a result, an
early failure could cause a cascading failure of tests.

Make test-case responsible for cleaning up their own branches so that
future tests can start with a sane environment.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 43 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index c5014ad9a6..f1c7023e1a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -60,38 +60,40 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 	do_checkout branch2
 '
 
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
-	git checkout branch1 &&
-	git branch -D branch2 &&
-
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 	do_checkout branch2 $HEAD1
 '
 
 test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
 	setup_dirty_unmergeable &&
 	test_must_fail do_checkout branch2 $HEAD1 &&
 	test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -f -b to a new branch with unmergeable changes discards changes' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
+
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
+	test_when_finished "
+		git reset --hard &&
+		git checkout branch1 &&
+		test_might_fail git branch -D branch2" &&
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 &&
@@ -99,27 +101,18 @@ test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
 '
 
 test_expect_success 'checkout -f -b to a new branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
+	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_mergeable
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
-	git reset --hard HEAD &&
-
+	test_when_finished git reset --hard HEAD &&
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
-	git reset --hard HEAD &&
 	git checkout branch1 &&
 	git checkout branch2 &&
 	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
@@ -160,6 +153,7 @@ test_expect_success 'checkout -f -B to an existing branch with unmergeable chang
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
+	test_when_finished git reset --hard &&
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
@@ -168,9 +162,6 @@ test_expect_success 'checkout -B to an existing branch preserves mergeable chang
 '
 
 test_expect_success 'checkout -f -B to an existing branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
-- 
2.21.0.1000.g11cd861522

