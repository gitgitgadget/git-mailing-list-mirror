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
	by dcvr.yhbt.net (Postfix) with ESMTP id F03D01F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbfIYK1L (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42420 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfIYK1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id q12so3119129pff.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGAhU3kD5XPE6fsMJ+L8wLQ/5x3cAZFMMrNjDg1iWe0=;
        b=dTwSxxIfLLYetiAX7LWYfwGtIc+iK0uXMjossLM74KYa9rtSxucyOxuEioMffH4ai3
         v8e148ywAH7KXRCqpkRpPqum81hr0KhGYzAXjln+dYCf20rIff1vDUIMbO0aqG4eLtHy
         rHsZL4udMozH3YUQyGvbHMtDdLQM3qf51sGRmJaSUyNw71YutghzHaRpDOPUIjvMgmUO
         f8K4xnvlMKtgZrV2eC0rAke8k1xwsAziMFQlTmFsblZCdPURTy+RGTJe+D1P5mlWVHAu
         aJgnkzKh86uc2h21Uo6eSXz9ZDbQRKhicbbh+NcZGFcsg7XKt79c/MephhWa5BalTsXq
         u8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGAhU3kD5XPE6fsMJ+L8wLQ/5x3cAZFMMrNjDg1iWe0=;
        b=siYd7PiywfC01tVIlfphXdf+MqCxvngoqlpVuIrYCYDDadUQOxKIg2pxYmalz9Y7qT
         mlO+FgCxxXDCGCaTJP8sbUqenJ5tTcIzNadqvjsYPdIkZ29W7Z3qPoQnvtWNNTHN3hpR
         vYTcKpxWRQOBi7zkoJAnDVyxhgN60lsuurejarvRkZv+MqdIzFSXec8xDmYTxvV92l5C
         0vMf+IPQLOVKOa5wsvVfa/U2SPBHYHv33W41kqjg/zJMynqQ/epzAR5J9rqBlY3CmcX8
         bCKNfNxCLBV2YJWFMg4uYLILs39v+G970kt+tl/6z0irW+0jtSpr/WZRJ0hiPUIUkAWb
         TVXw==
X-Gm-Message-State: APjAAAXJfVtkwwIxCe3WDV9iMfFjlAwI199kuJpzsGjsDvhfe1TzHkip
        nBvibDNJG039RSASpWUAjOaOcesJ
X-Google-Smtp-Source: APXvYqzvH8d+c6Mwt3jrAAJtDljQgbnAZZwxBQnYcgHajJJFXiYVb0zODu37uY4bGYWDKGo+yg8PgA==
X-Received: by 2002:a63:b95a:: with SMTP id v26mr7932711pgo.244.1569407229666;
        Wed, 25 Sep 2019 03:27:09 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id k8sm4072821pgm.14.2019.09.25.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:27:09 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:27:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 4/5] t4214: explicitly list tags in log
Message-ID: <ad6d89440be6e5a26d107dd7b11bad322df1f0cb.1569407150.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future test case, we will be extending the commit graph. As a
result, explicitly list the tags that will generate the graph so that
when future additions are made, the current graph illustrations won't be
affected.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 16776e347c..097151da39 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -33,7 +33,7 @@ test_expect_success 'log --graph with tricky octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
+	git log --color=never --graph --date-order --pretty=tformat:%s left octopus-merge >actual.raw &&
 	sed "s/ *\$//" actual.raw >actual &&
 	test_cmp expect.uncolored actual
 '
@@ -54,7 +54,7 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
+	git log --color=always --graph --date-order --pretty=tformat:%s left octopus-merge >actual.colors.raw &&
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
@@ -75,7 +75,7 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s merge >actual.raw &&
+	git log --color=never --graph --date-order --pretty=tformat:%s octopus-merge >actual.raw &&
 	sed "s/ *\$//" actual.raw >actual &&
 	test_cmp expect.uncolored actual
 '
@@ -94,7 +94,7 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	* initial
 	EOF
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s merge >actual.colors.raw &&
+	git log --color=always --graph --date-order --pretty=tformat:%s octopus-merge >actual.colors.raw &&
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
-- 
2.23.0.248.g3a9dd8fb08

