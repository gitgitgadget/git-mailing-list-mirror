Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3D220705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbcIEVwS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:52:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:38477 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932217AbcIEVwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:52:16 -0400
Received: (qmail 7956 invoked by uid 109); 5 Sep 2016 21:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:52:16 +0000
Received: (qmail 22332 invoked by uid 111); 5 Sep 2016 21:52:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:52:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:52:14 -0400
Date:   Mon, 5 Sep 2016 17:52:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] t5305: drop "dry-run" of unpack-objects
Message-ID: <20160905215213.apdmh7nubqxokcxw@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For each test we do a dry-run of unpack-objects, followed by
a real run, followed by confirming that it contained the
objects we expected. The dry-run is telling us nothing, as
any errors it encounters would be found in the real run.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5305-include-tag.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 6018404..787fc83 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -37,7 +37,6 @@ test_expect_success 'unpack objects' '
 		GIT_DIR=clone.git &&
 		export GIT_DIR &&
 		git init &&
-		git unpack-objects -n <test-1-${packname_1}.pack &&
 		git unpack-objects <test-1-${packname_1}.pack
 	)
 '
@@ -64,7 +63,6 @@ test_expect_success 'unpack objects' '
 		GIT_DIR=clone.git &&
 		export GIT_DIR &&
 		git init &&
-		git unpack-objects -n <test-2-${packname_1}.pack &&
 		git unpack-objects <test-2-${packname_1}.pack
 	)
 '
-- 
2.10.0.rc2.154.gb4a4b8b

