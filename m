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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E651F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbfJRWK2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390102AbfJRWK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id p30so4101034pgl.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AycKOxNnZzb7SpX4mMXXq7R3gcO6GMYw7CZIwbF9BYw=;
        b=rFQwcJSfXrEztQnKI0CaUnQFrHnQm3/Wa7EXpJE2aQCxpY10xTXdQMX7/5zF5FTXQh
         JEaZArrrWMRlfphecAkKXccnuiHiIE58G/rEiFS99pze0dNDr8iVSNxg4HPscTw5dXNX
         FDJcGTizWgdzTgBhk65IYq5XaqLEWyjU6md/2OvX1fFdryLZWsHCfiHm5b5bIQUX39lN
         5LXWv2ecZfrJ7b33mT95dADdee6P5Ym5JqzxfPWu8ipMpzdigSq7yhkqa8fiWULXWAwa
         CZHQILNwK3ex+DWroQvufOYH+Lrl90CN6jF9T4MQEV5zhK0Yk8TIdz2lN8rwAIYTlm/g
         rmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AycKOxNnZzb7SpX4mMXXq7R3gcO6GMYw7CZIwbF9BYw=;
        b=S3rsJjlYfZIYQ5beNzFASjxg8GXjxD+KBP4jib6baGJ772HYsVv05KjwhvLBv2OAI5
         jdHcrpd5k/rQSBOsy2zXf+AnanEwL2WD2kV9B07oC4pj3IpVHWGcnWTvKdNYGvEDFAI+
         CGwvUsyS50nB0p1MDbrf4KvDYydlY2nSZ4PmqPIGQp2I++D3yW4YDqB1AWJ0dHcy0mue
         e4Zz+ixuNiWCsZdMYdeU0Kyp3SpDANM5vvH1N0ajfpuf7ooHTJMFhNlqfboN34X+/DLb
         o7Ptz3tKWTQ0T8n1/A87VlX7CV9D8+0e8pL/iCyRm7E7Um37SJ9etI3XEjwVL1rjUoZX
         e6kA==
X-Gm-Message-State: APjAAAVRJuZpfGM37i/ixNzx8dp/JePkearPRJ8XXtcOWWGFiUlq8kci
        2yQveV7ySeWvpczYJtwGuYCGjFIU
X-Google-Smtp-Source: APXvYqxxy5/jQORx4GsAKHgTS+SFsOrzeUQ07UQuFjduoZ4MByAl2EGmsOHtjN0MohKyoHzShMjaRA==
X-Received: by 2002:a63:352:: with SMTP id 79mr12581443pgd.232.1571436626257;
        Fri, 18 Oct 2019 15:10:26 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id h1sm8103243pfk.124.2019.10.18.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:23 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/15] t5520: improve test style
Message-ID: <0a569808576de4edad598edcafa9fc9a35b056a6.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
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
2.23.0.897.g0a19638b1e

