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
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E991F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKLANr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKLANr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so10572926pgm.6
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZEF7yQf1TrD+4qwNiglZtgpq83q4M2xHHQz+w4GhPQ=;
        b=Ty2L5oWC6nLytohQO3wtNWydWc14Ef0focZLXSfNkL5BCfmwugf4tNiuYw1UyLOy2X
         HPNaKDMg5xAB/JkQqgG6bbYVsvDvoGuQP07IyE1zfQ5pjLsG6iYPg82z4KHldM/vTRQR
         wLRb6AWUkpp6c7s0MJtlT3Y42iz2A8CsPP5AXpWG/SMYpeH6v/4Gtdn0lvOTN+6e5vg+
         GIiFeIGGZEAoYXpVQAjM8BCjZvBf4KsbTIda7jnKb1++cTFBoKNW8P8G0YqPwZv8C+vC
         xOQF6BX/a1Ysem8e5sEVe4yjLl2vaL0c5dpKbi8QJ4W7vqux2BiROo7v9FSaY81rh6O8
         hP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZEF7yQf1TrD+4qwNiglZtgpq83q4M2xHHQz+w4GhPQ=;
        b=sXILYVzWzg/cO7eIPyi8MP+xrU7tS3hfGDv/ZtpQ7+5Rf3cnQjQKqPjgbBDoujjGHs
         EBz2fGs4Bi2gfJDkLB+r1O7I6TQKn78UVkIwgMyEax0xLKw0fe88oo5ENCJgPRGhcSIK
         +GLtQNmIdVvPHSmiZggWqCBgXFWBcPUaNf8JrKDqZpY8dNK9ocN8rPgJt4OO3ifDgGtg
         GrJv/aH7+q2x+7JVqZv9FQoI5XuLtOPB3EcPhWd8PVJ91fzdE+BgTDuxfosMlvP29hxz
         dBQR34YW+7zt7lxLMHdTI8UvAPirS4B9UF1sCDe8zwhgsrwJHjOj2d2vmRoVCMLHcCVM
         mqsg==
X-Gm-Message-State: APjAAAWY5Vqeld+vOq11+PRtagdEAcZ9nxUNKwuE60qYw4JgB8YE4Nuq
        e07JsU9rXyXoeKel0B6iuOzd+FeW
X-Google-Smtp-Source: APXvYqw5hpDj32Fl2Q0Mt18jAtcPI/Qef5MUyVs9QaPwhjInFpVjvSi+B84lk6JKAK9GYASiuTqPFA==
X-Received: by 2002:aa7:8b47:: with SMTP id i7mr9315734pfd.226.1573517626052;
        Mon, 11 Nov 2019 16:13:46 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c13sm18480551pfi.0.2019.11.11.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:45 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/14] t5520: improve test style
Message-ID: <023e0ccc111e81211f65143052e2c145355b95d7.1573517561.git.liu.denton@gmail.com>
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

Improve the test style by removing leading and trailing empty lines
within test cases. Also, reformat multi-line subshells to conform to the
existing style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 88 +++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index cf4cc32fd0..51d6ce8aec 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -538,7 +538,6 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 '
 
 test_expect_success '--rebase with rebased upstream' '
-
 	git remote add -f me . &&
 	git checkout copy &&
 	git tag copy-orig &&
@@ -552,7 +551,6 @@ test_expect_success '--rebase with rebased upstream' '
 	git pull --rebase me copy &&
 	test "conflicting modification" = "$(cat file)" &&
 	test file = "$(cat file2)"
-
 '
 
 test_expect_success '--rebase -f with rebased upstream' '
@@ -564,14 +562,12 @@ test_expect_success '--rebase -f with rebased upstream' '
 '
 
 test_expect_success '--rebase with rebased default upstream' '
-
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git checkout --track -b to-rebase2 me/copy &&
 	git reset --hard to-rebase-orig &&
 	git pull --rebase &&
 	test "conflicting modification" = "$(cat file)" &&
 	test file = "$(cat file2)"
-
 '
 
 test_expect_success 'rebased upstream + fetch + pull --rebase' '
@@ -588,7 +584,6 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 '
 
 test_expect_success 'pull --rebase dies early with dirty working directory' '
-
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
 	COPY="$(git rev-parse --verify me/copy)" &&
@@ -603,16 +598,16 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	git checkout HEAD -- file &&
 	git pull &&
 	test "$COPY" != "$(git rev-parse --verify me/copy)"
-
 '
 
 test_expect_success 'pull --rebase works on branch yet to be born' '
 	git rev-parse master >expect &&
 	mkdir empty_repo &&
-	(cd empty_repo &&
-	 git init &&
-	 git pull --rebase .. master &&
-	 git rev-parse HEAD >../actual
+	(
+		cd empty_repo &&
+		git init &&
+		git pull --rebase .. master &&
+		git rev-parse HEAD >../actual
 	) &&
 	test_cmp expect actual
 '
@@ -646,58 +641,65 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
-	(cd src &&
-	 git init &&
-	 printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > stuff &&
-	 git add stuff &&
-	 git commit -m "Initial revision"
+	(
+		cd src &&
+		git init &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > stuff &&
+		git add stuff &&
+		git commit -m "Initial revision"
 	) &&
 	git clone src dst &&
-	(cd src &&
-	 modify s/5/43/ stuff &&
-	 git commit -a -m "5->43" &&
-	 modify s/6/42/ stuff &&
-	 git commit -a -m "Make it bigger"
+	(
+		cd src &&
+		modify s/5/43/ stuff &&
+		git commit -a -m "5->43" &&
+		modify s/6/42/ stuff &&
+		git commit -a -m "Make it bigger"
 	) &&
-	(cd dst &&
-	 modify s/5/43/ stuff &&
-	 git commit -a -m "Independent discovery of 5->43"
+	(
+		cd dst &&
+		modify s/5/43/ stuff &&
+		git commit -a -m "Independent discovery of 5->43"
 	)
 '
 
 test_expect_success 'git pull --rebase detects upstreamed changes' '
-	(cd dst &&
-	 git pull --rebase &&
-	 test -z "$(git ls-files -u)"
+	(
+		cd dst &&
+		git pull --rebase &&
+		test -z "$(git ls-files -u)"
 	)
 '
 
 test_expect_success 'setup for avoiding reapplying old patches' '
-	(cd dst &&
-	 test_might_fail git rebase --abort &&
-	 git reset --hard origin/master
+	(
+		cd dst &&
+		test_might_fail git rebase --abort &&
+		git reset --hard origin/master
 	) &&
 	git clone --bare src src-replace.git &&
 	rm -rf src &&
 	mv src-replace.git src &&
-	(cd dst &&
-	 modify s/2/22/ stuff &&
-	 git commit -a -m "Change 2" &&
-	 modify s/3/33/ stuff &&
-	 git commit -a -m "Change 3" &&
-	 modify s/4/44/ stuff &&
-	 git commit -a -m "Change 4" &&
-	 git push &&
-
-	 modify s/44/55/ stuff &&
-	 git commit --amend -a -m "Modified Change 4"
+	(
+		cd dst &&
+		modify s/2/22/ stuff &&
+		git commit -a -m "Change 2" &&
+		modify s/3/33/ stuff &&
+		git commit -a -m "Change 3" &&
+		modify s/4/44/ stuff &&
+		git commit -a -m "Change 4" &&
+		git push &&
+
+		modify s/44/55/ stuff &&
+		git commit --amend -a -m "Modified Change 4"
 	)
 '
 
 test_expect_success 'git pull --rebase does not reapply old patches' '
-	(cd dst &&
-	 test_must_fail git pull --rebase &&
-	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	(
+		cd dst &&
+		test_must_fail git pull --rebase &&
+		test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
 	)
 '
 
-- 
2.24.0.300.g722ba42680

