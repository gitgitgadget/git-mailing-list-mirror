Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8589C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbdCOUMQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:12:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:44771 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753971AbdCOUMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:12:12 -0400
Received: (qmail 29798 invoked by uid 109); 15 Mar 2017 20:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 20:05:25 +0000
Received: (qmail 22872 invoked by uid 111); 15 Mar 2017 20:05:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:05:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 16:05:21 -0400
Date:   Wed, 15 Mar 2017 16:05:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] minor rev-parse option-parsing cleanups
Message-ID: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened to be looking at these yesterday and got annoyed by the
tangled logic. No bug-fixes, but the result is less repetitive and has
fewer magic numbers.

  [1/3]: rev-parse: use skip_prefix when parsing options
  [2/3]: rev-parse: add helper for parsing "--foo/--foo="
  [3/3]: rev-parse: simplify parsing of ref options

 builtin/rev-parse.c | 109 +++++++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

-Peff
