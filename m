Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234581F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeCUFrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:47:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeCUFrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:47:47 -0400
Received: (qmail 29039 invoked by uid 109); 21 Mar 2018 05:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6910 invoked by uid 111); 21 Mar 2018 05:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:48:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:47:45 -0400
Date:   Wed, 21 Mar 2018 01:47:45 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/7] diff-highlight: correct test graph diagram
Message-ID: <20180321054744.GA14016@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We actually branch "A" off of "D". The sample "--graph"
output is right, but the left-to-right diagram is
misleading. Let's fix it.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 3b43dbed74..bf62f036c7 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -52,8 +52,8 @@ test_strip_patch_header () {
 # dh_test_setup_history generates a contrived graph such that we have at least
 # 1 nesting (E) and 2 nestings (F).
 #
-#	      A branch
-#	     /
+#	  A branch
+#	 /
 #	D---E---F master
 #
 #	git log --all --graph
-- 
2.17.0.rc0.402.ged0b3fd1ee

