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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3CA1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438437AbfJQXRC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33214 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441744AbfJQXRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so2620404pfl.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AycKOxNnZzb7SpX4mMXXq7R3gcO6GMYw7CZIwbF9BYw=;
        b=sBU2uiqClUKkGECqSGHwE2OORa768pbhVr7PfWT9+Jbvt0PqU9GwFNIst3A+A4Hmag
         PpdHzxwyaqa9LEU3YnY8FCyViOd8QE0446W96eoKK6mYNUQAygbmKxaAP/2vyRx0l30+
         sE5RyZ0DNqDBBbu9JR458O2Ndc8xSAmPzMyfEw26ExraKIY4xm6nhlpvLH7C0Tf98Fs2
         0PTc348eyAjmVzmK8gfNg6QSJgAGdLf998A+O0CDm+w8yoMZtRlBZkBZNUdlnP4XiUe6
         MtxFtG2j6FsQGO+YV3RCgbopNfCMcLA4hA8LOuiHkA8yFx9hSPeO64z7lMr81y8MsKRh
         1Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AycKOxNnZzb7SpX4mMXXq7R3gcO6GMYw7CZIwbF9BYw=;
        b=NFJc61thG7HVxLPG27a4g19ivPExzxlCCLYLEQjjGtb/UKkari418B4F1EdJgk/EJl
         /nsWA20HitWP7iRC+qvY7Y5cW3+vw0HTBpY2boNWZ2TusXQMpGR/ELG/+qSmR4a1hffx
         IG2MtECtUQPc2TUPxT3XLor0nbE+nXJjVYJaa6xmO2SGE7X/P/8xJ0N3uAhSqG56vq1f
         qlSmy0u7HwK2hDiJt1B5kr6/KmVRwc/On9lQAz/M8wwQoNZfxlYMiHmao6+9I03a9iDX
         yo4KpgNIbJnGGJpb4oNOO2wISuTJWo8C0Yp3QNzKYXNkBwkEzLtHtrurs4Dkv+y118lT
         RDsQ==
X-Gm-Message-State: APjAAAUEnYHAepY4VOb4ZLM1ipHqtMZullYerG6fyNc601pRmLTVRmlO
        Qsd0oK4/S5JwLUjWtHruRD6jZHKv
X-Google-Smtp-Source: APXvYqzlefieJeNU/hNg8sOxO5XA5rmCUUyhnFQT9/2mBWgI8wwrbV0jgzuUrIS24BFIA+8lny71jQ==
X-Received: by 2002:a17:90a:d588:: with SMTP id v8mr7188456pju.51.1571354219003;
        Thu, 17 Oct 2019 16:16:59 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id l23sm3536434pjy.12.2019.10.17.16.16.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:16:58 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:16:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 01/12] t5520: improve test style
Message-ID: <cb7fe664ca3d5feaecd2226a8f4aba843e3a05f6.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
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

