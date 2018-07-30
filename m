Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB12A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbeG3Un1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:43:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43758 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731766AbeG3Un0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:43:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17-v6so3309500pgv.10
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlNvbadIQp33UzKRtKSxNtOBbwWnpaXrvkT8+LcE60Y=;
        b=pPDEUygEk3shvGyaSa4claQOeEJv4yyNAgc84GVewif8O6Sz971uCWuHGK3FWaxNfj
         eTAeJ5wAx214UpQvmVBxOncZIUyhGnosd7beB8ueeJmB9Y3Hbg0Jbe9gIjz8rirM/QF+
         wBSGdLh/hm6sPQaimh272quPGPZkYwxissVysuh8aFoQN2guW2wmJjmqTsoG/56DU0bP
         oHHBFl/iEQEUaf0pRTBTnl/KyNktK8ss4LfrSJkd0KyeOb+KBsZQQ0lIOKRDsFQkImOQ
         0Q0HKDtD7qG9NnNardXgosc/CTApS2pw5C1Dmvid4Ww7GJXeel2+GepLacyUi1YUJQcu
         Ohkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlNvbadIQp33UzKRtKSxNtOBbwWnpaXrvkT8+LcE60Y=;
        b=gtOEKJCiA3HYiG2+bxY6Oocj9piPzkxCHq9eUHD/li9xt0dWXNapheli+tNsOW5KyJ
         at1k0vLhfoxZ3zmF4xJ+/UQuUytohTQdWg1D9RqsiIxv7DBWQCiLSCDmoB5TSZCgMNAK
         PCs8BHTYtB6ch2yVvmLpdvEQWW2fpV28M/j+aqjpHeCR1aAF+lqR2cIDBxcH4Z0gPnN8
         5Ah3l0CDbQMRh6rQ9A9OQBdDDl8+iQ0NHBWbSINfrZd/YBiriODOGTPXW5HzOigi+XCf
         d7ioYvqs7B9uHY/vxNKl9sH1Zpb8nLCMIHY0RW9O0V2+cHM81/+Q7caTUPWcjzwX2/JE
         0HzQ==
X-Gm-Message-State: AOUpUlFEHnn97hDldSVwuqW2pS2yKkuz9aNi7Je+GSrRxgvTjmp1K/6x
        cnZf8Qg2aFbzBu+ATj+4hM4=
X-Google-Smtp-Source: AAOMgpeYNssQ3wYZ2eHbswhcMP1lW63UNITI5BA4nURA9uahC9E8febSMzYKU75pX9X00p3wxEQ/0g==
X-Received: by 2002:a63:ba43:: with SMTP id l3-v6mr16918779pgu.295.1532977623917;
        Mon, 30 Jul 2018 12:07:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g63-v6sm17022288pfc.77.2018.07.30.12.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:07:03 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:07:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] subtree test: add missing && to &&-chain
Message-ID: <20180730190702.GC156463@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
 <20180730190612.GB156463@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730190612.GB156463@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detected using t/chainlint.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index d05c613c97..e6a28f2c3e 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -708,7 +708,7 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 	test_create_commit "$subtree_test_count/sub proj" sub1 &&
 	(
 		cd "$subtree_test_count" &&
-		git config log.date relative
+		git config log.date relative &&
 		git fetch ./"sub proj" master &&
 		git subtree add --prefix="sub dir" FETCH_HEAD
 	) &&
-- 
2.18.0.345.g5c9ce644c3-goog

