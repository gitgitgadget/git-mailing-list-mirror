Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845561F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbfJDAXY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 20:23:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732230AbfJDAXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 20:23:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so2810032pfa.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 17:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyLGtgfPA29gWGYJgTu4sQbHfZW1nfG5IIZHwAKPZ0Y=;
        b=KymIEEOI2pQ80GYGrvmRc4qBb2DbJfMR+Ycn8xD+zqBl3JS1GzRWCc6YkxmXzQ8Dtq
         SHT2MtiHF0Hk3PKnLI+O2E26DN/8Vnr7NkeEByTBMOrV7e9aMN3HVQScu4tCM5Nr1O3r
         LJkkTrBzXs+F26ae6XjimA0fZ8d5oK1uhLBqK6jgiGQ547OTwyI9V1Uh6wuxqUDmVe2L
         MMwVXKbKsEbOtxsemk9sU1y6LYhVFArOym0sxuF1DGPJLMbq4pDfW5fGrXIN1+pRu+GS
         IzGbuT7f8h/6ji+y40CLvEY5WPb2O6r5tc8mHyzTcZWd850J6+MviuALbuH6oOwo72lS
         d64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyLGtgfPA29gWGYJgTu4sQbHfZW1nfG5IIZHwAKPZ0Y=;
        b=pB84CI/U7eZMgn1ofLRwOPLlwfOebN1zuERSLkovca4TFGHYJr5ZdQP0Z7vHXKBddx
         /tJm/g4bE2tHvqs/iNB9TlOhivqodmFm47FpwXogNGNvb9yjufVunPQ1FfhRHQy+6MrL
         H2JH2MMUzCrHGxizci3E7y8ORctQMD+22pPdlUF7I2Gphoo5iJG3e/3UWtqbi4qy15Wd
         K+UJKFz3+mF5I4I0adSTNUHGkhTphC9so3KrwXYhCNVUvGhwSRLjBX5TYAdRCLta8MIQ
         VMWdJUlURr+Jv4hPukIJlGqBTsl6PJRQk+c/k4p469THVWqVQKoisFOUReLlRW3DDEZv
         66jQ==
X-Gm-Message-State: APjAAAUj5gpTTBEo4cRU7DfA1jjYG/EbZXJs4cDXSIPLq+3MrawNZ/jk
        aGPm97+U60zSLyMZh3LeEYbtwaKI
X-Google-Smtp-Source: APXvYqyGUfySrStGQJTPzDNPculeveTaizmFcteoF+kNETJJfgQcuwR6O/B/gtn92C40pXi9MdeAMA==
X-Received: by 2002:a63:1045:: with SMTP id 5mr12292321pgq.165.1570148602299;
        Thu, 03 Oct 2019 17:23:22 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id i6sm5452306pfq.20.2019.10.03.17.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 17:23:21 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:23:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] t4214: explicitly list tags in log
Message-ID: <ad6d89440be6e5a26d107dd7b11bad322df1f0cb.1570148053.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
 <cover.1570148053.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570148053.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
2.23.0.565.g1cc52d20df

