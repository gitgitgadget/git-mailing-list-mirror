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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0553E1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKGSv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37089 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKGSvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id p13so2144199pll.4
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vtUUygPqWJ5q1kM8GB+SS/tMDtJ3ywFWxQG91RjhgHM=;
        b=NY/rqDLvkGETHyZHTkKOi4szPptDXffFAtRsXv8BG606RiDhUmdcA/aSOu8zVAXk/1
         t83aU7mRwH/sJUPw39FZLoE5VjhL1c1Bp2e6gdIovuC9UrdrduxNTT1iuOGdeeU/GIbs
         07VcTZvQBU3HkmJIJkDVhcEdKzt20ggXXa3ck7g9qNQfN2DPnIpjYuWhDPP7tI8nYePs
         dOpZ7cQfNOIHr5LX2MMYCrYE/RT2LHRKKvs6VAoYJ3atzVvIgmZ4v9XuM+yxspeST3ga
         lk583kgVmSiESOSjT1Tj3CTmuSfe7nF0p7ny2GOFiNmOopNjAhxKc1jqja5JURTCa7dY
         cO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vtUUygPqWJ5q1kM8GB+SS/tMDtJ3ywFWxQG91RjhgHM=;
        b=JhsVnQ9vc0Z+MxtrG7TrxFy3ENuh01vas7amOhReW9bJbLYomaIwZs56ZYSs+vOxgL
         XlkYKPJ2A0p6/yV/Gta8u2lrC2690bge5tspqXZHukIpOLUUcc5KWwMrphhbOKBbtzs2
         YGeB3tBoMHYN5ISJ3UcZaEvt5rZIFTy9hVlJlpb0caeK+LBQ7189GywaeQhy+XSk+A/t
         kjjToSpChT09MjUnsY/NRLnB8IKPsWOadQq3GJjhrqU19tp6sTWW++LIrMLuYJJP0OHw
         kMtDBLKlHjswM3do1zJ4vT8iegPvKuVNpJsTRrmcPKc7PGIyrozkDfh0hXV1E0vyKfXy
         1OKQ==
X-Gm-Message-State: APjAAAUvpTRvQOkD/RwHrThs4SA+0g+jK40KndNyS5j4vp20Erzam2o3
        u6yOCH3l/rOUcHUtqFS3fY8wXjNs
X-Google-Smtp-Source: APXvYqyBgUuVMRQW6Z7xh5K6b0RolMyUAq5h/685LwE/b19PdnSJOrcGP1uz+qrNwm4acKD66oVl7A==
X-Received: by 2002:a17:90b:438b:: with SMTP id in11mr7163997pjb.129.1573152683817;
        Thu, 07 Nov 2019 10:51:23 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a34sm5523107pgl.56.2019.11.07.10.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:23 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/14] t5520: improve test style
Message-ID: <b1dbe78f5d13785c436abddf50ea513f3050fe89.1573152599.git.liu.denton@gmail.com>
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
2.24.0.rc2.262.g2d07a97ef5

