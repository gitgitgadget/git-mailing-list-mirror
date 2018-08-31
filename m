Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B6C1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeHaJpX (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:43173 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHaJpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831053935.YPTN21918.fed1rmfepo202.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:39:35 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id Vhfa1y00N59yGBo01hfarj; Fri, 31 Aug 2018 01:39:34 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090212.5B88D496.002E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=PdaPvmpd c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8
 a=2uv7cLl4RmA0IFqEUEgA:9 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 5D12029A011B;
        Thu, 30 Aug 2018 22:39:34 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 1/3] Change tests from expecting to fail to expecting success.
Date:   Thu, 30 Aug 2018 22:39:19 -0700
Message-Id: <20180831053921.8083-2-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831053921.8083-1-ischis2@cox.net>
References: <20180831053921.8083-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two tests were written which showed failure cases when passing
--procelain or --short.

Change the test to expect success since updates to the wt-status
broken code section is being fixed.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t7501-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 4cae92804..810d4cea7 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -99,12 +99,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
 	git commit -m next -a --dry-run
 '
 
-test_expect_failure '--short with stuff to commit returns ok' '
+test_expect_success '--short with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --short
 '
 
-test_expect_failure '--porcelain with stuff to commit returns ok' '
+test_expect_success '--porcelain with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --porcelain
 '
-- 
2.18.0

