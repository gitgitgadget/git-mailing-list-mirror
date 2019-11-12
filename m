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
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1EC1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLXHx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44414 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so151300pfn.11
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uCJDZfL0o4fiYRT9cIjyvvZpPBDXEPSkUHe1nBg2vTU=;
        b=uI5WLFoI0bNHu3rOACPBVbxj2NHFAKLM+enR6AIW2FsmoQlRC0T78vkLGlTP317JQ7
         CiIYkbQ8xZ/GHXKDKATydKmzPLzYdSR64Q+MSV5YNx4KVP0CMsq7WCebUSWMbWNlftgp
         WOZQoZluhYT5bzlPBTA0xxPdJA/JSAKMIfPV8n3sz+u8A6fGt+ho9B6jJjg5j8+xaYf0
         D2m10L9mC5ZpYDzwCTf3ZyNMtGPatp1yFFTE+N7jxe0ghMP0iDyCb075L7bvoU0cMbqU
         RXZVTklbwSm0val9j55lHqhZ3h37q1QBZhRbKm2Plqgag6VpZF0OhmmFj6yVRNVGAnlp
         Gevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCJDZfL0o4fiYRT9cIjyvvZpPBDXEPSkUHe1nBg2vTU=;
        b=JPBUG0abZZR5QvtqEkVL8Vl1ysl6M+scd+kmrqNdnKns73qTfzQGk3AoCRUOrM00or
         2I09DjnyXEloFR96IPWcjtO8E600kEzUaft9zc89hA6dmBhnnLVdrgGoIiIGv7m++TNq
         IOL5I5QlrqLgmfuIgtBAxcv26J39frTiQxxFEdWW3AQs7wzLWpM1ed0Jjn7LKgwTQR5Z
         RF71AHW3Cjf+041zbdWQ7ldV6o6PaLLlN/1tFA/qoOwYUIhvuPZgRVzAZarqjUKLG3ix
         A2nxcd8S+vP8WF3hSsHkGRKZQNMvTbANKvvvbmu+Q31W8ZQ/F7pqdtanSfN8VYcoHW0v
         mQTQ==
X-Gm-Message-State: APjAAAW+XlVC2wJDXhfBF9UBI1jw9Irn87v9Eazlx5Sdg7KiVyOLdPa5
        wHrCbqz1mufisn9hGI1CYP8/qzPQ
X-Google-Smtp-Source: APXvYqwcKh+QwLBmRGU5ZJirrna+CFaoakHcMlUaYD5kstKeajSUM1PWiAxt4FIHcOntwjEnvwlkcg==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr395792pjc.3.1573600070120;
        Tue, 12 Nov 2019 15:07:50 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id r5sm16240pfh.179.2019.11.12.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:49 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 02/14] t5520: improve test style
Message-ID: <aa3f2e33958be1ab684b3a185e5c5467d2f978f0.1573595985.git.liu.denton@gmail.com>
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
2.24.0.346.gee0de6d492

