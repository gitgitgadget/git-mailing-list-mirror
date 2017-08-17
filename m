Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B914C208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 10:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdHQKgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 06:36:20 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:51895 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdHQKgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 06:36:19 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1diI9v-000431-QC; Thu, 17 Aug 2017 12:36:15 +0200
Date:   Thu, 17 Aug 2017 12:36:13 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t5526: fix some broken && chains
Message-ID: <20170817103613.GB52233@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t5526-fetch-submodules.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ce788e9..22a7358 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -193,7 +193,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
-		git config fetch.recurseSubmodules true
+		git config fetch.recurseSubmodules true &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
@@ -218,7 +218,7 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
-		git config fetch.recurseSubmodules true
+		git config fetch.recurseSubmodules true &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	! test -s actual.out &&
@@ -232,7 +232,7 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 			cd submodule &&
 			git config --unset fetch.recurseSubmodules
 		) &&
-		git config --unset fetch.recurseSubmodules
+		git config --unset fetch.recurseSubmodules &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	! test -s actual.out &&
@@ -312,7 +312,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 		) &&
 		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule"
+		git commit -m "new deepsubmodule" &&
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-- 
2.0.0.274.g6b2cd91

