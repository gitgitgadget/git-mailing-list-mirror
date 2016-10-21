Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF87920986
	for <e@80x24.org>; Fri, 21 Oct 2016 10:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754850AbcJUKsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 06:48:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:60570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753751AbcJUKsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 06:48:15 -0400
Received: (qmail 17858 invoked by uid 109); 21 Oct 2016 10:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 10:48:14 +0000
Received: (qmail 1932 invoked by uid 111); 21 Oct 2016 10:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 06:48:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 06:48:12 -0400
Date:   Fri, 21 Oct 2016 06:48:12 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: [PATCH 3/3] travis: use --verbose-log test option
Message-ID: <20161021104812.b5mk2s3ve2iotv3j@sigill.intra.peff.net>
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because we run the tests via "prove", the output from
"--verbose" may interfere with our TAP output. Using
"--verbose-log" solves this while letting us retain our
on-disk log.

Signed-off-by: Jeff King <peff@peff.net>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 37a1e1fb6d..9a65514d82 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -31,7 +31,7 @@ env:
     - LINUX_GIT_LFS_VERSION="1.2.0"
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-    - GIT_TEST_OPTS="--verbose --tee"
+    - GIT_TEST_OPTS="--verbose-log"
     - GIT_TEST_HTTPD=true
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
-- 
2.10.1.776.ge0e381e
