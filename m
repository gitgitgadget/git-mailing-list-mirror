Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48EE20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfDESFG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:05:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:05:05 -0400
Received: (qmail 11013 invoked by uid 109); 5 Apr 2019 18:05:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:05:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28134 invoked by uid 111); 5 Apr 2019 18:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:05:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:05:03 -0400
Date:   Fri, 5 Apr 2019 14:05:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/13] t5319: drop useless --buffer from cat-file
Message-ID: <20190405180503.GD32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
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
2.21.0.729.g7d31bf3764

