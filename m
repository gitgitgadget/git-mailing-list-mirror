Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD9A20248
	for <e@80x24.org>; Thu,  4 Apr 2019 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfDDXWj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:22:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729501AbfDDXWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:22:39 -0400
Received: (qmail 1408 invoked by uid 109); 4 Apr 2019 23:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:22:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20376 invoked by uid 111); 4 Apr 2019 23:23:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:23:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:22:37 -0400
Date:   Thu, 4 Apr 2019 19:22:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/12] t5319: drop useless --buffer from cat-file
Message-ID: <20190404232236.GB21839@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cat-file --buffer option is the default already when using
--batch-all-objects. It doesn't hurt to specify it, but it's nice for
the test scripts to model good usage.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5319-multi-pack-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 42f4d6cd01..8c4d2bd849 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -104,8 +104,8 @@ compare_results_with_midx () {
 		midx_git_two_modes "rev-list --objects --all" &&
 		midx_git_two_modes "log --raw" &&
 		midx_git_two_modes "count-objects --verbose" &&
-		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check" &&
-		midx_git_two_modes "cat-file --batch-all-objects --buffer --batch-check --unordered" sorted
+		midx_git_two_modes "cat-file --batch-all-objects --batch-check" &&
+		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
 	'
 }
 
-- 
2.21.0.714.gd1be1d035b

