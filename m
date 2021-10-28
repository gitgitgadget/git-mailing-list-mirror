Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28AC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AF760F58
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1TW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:22:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:49100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhJ1TWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:22:55 -0400
Received: (qmail 17384 invoked by uid 109); 28 Oct 2021 19:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 19:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8007 invoked by uid 111); 28 Oct 2021 19:20:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 15:20:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 15:20:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] t5310: drop lib-bundle.sh include
Message-ID: <YXr3+yqtXYGgaxnX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit ddfe900612 (test-lib-functions: move function to lib-bitmap.sh,
2021-02-09) meant to include lib-bitmap.sh in t5310, but also includes
lib-bundle.sh. Yet we don't use any of its functions, nor have anything
to do with bundles. This is probably just a typo/copy-paste error, as
lib-bundle.sh was added (correctly) to other scripts in the same series.

Signed-off-by: Jeff King <peff@peff.net>
---
Not really hurting anything, just confusing.

 t/t5310-pack-bitmaps.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 673baa5c3c..dcf03d324a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
 # t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
-- 
2.33.1.1409.g5a89a36363
