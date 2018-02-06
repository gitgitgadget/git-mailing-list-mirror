Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD4A1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 08:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBFInW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 03:43:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:41900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751835AbeBFInV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 03:43:21 -0500
Received: (qmail 23578 invoked by uid 109); 6 Feb 2018 08:43:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 08:43:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16154 invoked by uid 111); 6 Feb 2018 08:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 03:44:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 03:43:19 -0500
Date:   Tue, 6 Feb 2018 03:43:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/2] t0205: drop redundant test
Message-ID: <20180206084318.GA26329@sigill.intra.peff.net>
References: <20180206084226.GA26237@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206084226.GA26237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check that a shell variable is non-empty, and then we
check that it's equal to a particular value. Just checking
the latter covers both cases.

I suspect the original was trying to give better output when
the test fails, but using "-x" covers that these days.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0205-gettext-poison.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index 2361590d54..438e778d6a 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -7,10 +7,6 @@ test_description='Gettext Shell poison'
 
 . ./lib-gettext.sh
 
-test_expect_success GETTEXT_POISON "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
-    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
-'
-
 test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
 '
-- 
2.16.1.273.gc07cfcd8c9

