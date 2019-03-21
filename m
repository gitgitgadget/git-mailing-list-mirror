Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577DA20248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCUGxr (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUGxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so3557748pgq.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mhhn8/9vG8AfLbuSjBMwFQP0SA6lkwEbsU0fRDZnILY=;
        b=jMUyuQ44i6BaL8w3+Mw7yjMIX5TdMKtAVevw58um07U7mDru1UHGENWgdgQ1fvwNeh
         RY2V0/LBS3pBwtS0qhiheVbSOPc9U4DsgInhrE+FzMksUcEKZ88SD6VyMeJIwRI2nuwI
         MXLp5G0CCTQomsydLcVeRScFbIivkDjXftH2PRs6HWNaTjAEo48c+D587mpeaLDdR47A
         bGbpFAwfGvSUTwhOvrYbOnKNtWzU9LytoYXai1nyRJvwInmj+wYX6brcU1163o9su6Jy
         CHJJDu5sg4PSTyysF+IE6My//LPZ8neCx6395efGdxcRXIqEmyy/fMIXoMGL8XTBC3yY
         /oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mhhn8/9vG8AfLbuSjBMwFQP0SA6lkwEbsU0fRDZnILY=;
        b=O5rCMv/+NY9Yw32WWYp6XDbccybdJg1LExeFsJ6F88n1ceiw5lr13l2sk4QtFun1ve
         gSVfRCRAIDO6Q0dIdZU2HZ0ktDkoRx7pkSQJz2bdEt3u1OHLGkSZtFZirBGq9xjbMYkB
         5IAJN0d1EDiN8a+m+OcdXA54V9gJrGiAFfvFpf9cdfBqYFsFe9eu8JXDxtL2YT/tEY4f
         rj0lb1jPbXoRqcc5wgGhdRxeN9S0uDeyIM11HwVfoTM2iA37S3JokJ9fACIW3CoBIIk0
         EuC/y7U2P9UjMlT5esEgd2pkdWurvNZSH07CKEeOwMNN5OPT3GueHfnnSAAYfmiHdya+
         sngA==
X-Gm-Message-State: APjAAAUD3Wpj3chHX6apUHBulq6bNYoopNfKxFCsbG+ZNOU8poV9wWCT
        YoLgjQ090nNELwpJFOSqWND/6dkCWZ4=
X-Google-Smtp-Source: APXvYqweNyhL3oBjYINpIX+3uKLD1zT/idPesGNrePdN0S3JyDp6g23APV5oVWz11gxr6RzUE7NRmg==
X-Received: by 2002:a63:db07:: with SMTP id e7mr1788059pgg.231.1553151225849;
        Wed, 20 Mar 2019 23:53:45 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 123sm1870943pff.182.2019.03.20.23.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:45 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:43 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 03/11] t7604: clean up style
Message-ID: <61d1c7c907500662a8918e8175b2b96282406fef.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, we had some Git commands which were upstream of the pipe. This
meant that if it produced an error, it would've gone unnoticed. Refactor
to place Git commands on their own.

Also, while we're at it, remove spaces after redirection operators.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7604-merge-custom-message.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 89619cf446..aba1279132 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -16,16 +16,16 @@ create_merge_msgs() {
 }
 
 test_expect_success 'setup' '
-	echo c0 > c0.c &&
+	echo c0 >c0.c &&
 	git add c0.c &&
 	git commit -m c0 &&
 	git tag c0 &&
-	echo c1 > c1.c &&
+	echo c1 >c1.c &&
 	git add c1.c &&
 	git commit -m c1 &&
 	git tag c1 &&
 	git reset --hard c0 &&
-	echo c2 > c2.c &&
+	echo c2 >c2.c &&
 	git add c2.c &&
 	git commit -m c2 &&
 	git tag c2 &&
@@ -36,14 +36,16 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.log actual
 '
 
-- 
2.21.0.512.g57bf1b23e1

