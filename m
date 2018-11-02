Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322641F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeKBO2e (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:28:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727350AbeKBO2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:28:34 -0400
Received: (qmail 26564 invoked by uid 109); 2 Nov 2018 05:22:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 05:22:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 623 invoked by uid 111); 2 Nov 2018 05:21:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 01:21:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 01:22:39 -0400
Date:   Fri, 2 Nov 2018 01:22:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] mixed bag of -Wunused-parameter bugfixes
Message-ID: <20181102052239.GA19162@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are three minor bug-fixes that can be applied independently. The
common thread is that I found them by looking at the results of
compiling with -Wunused-parameter. In each of these cases, the parameter
_should_ be used, and not doing so was a bug.

  [1/3]: rev-list: handle flags for --indexed-objects
  [2/3]: approxidate: handle pending number for "specials"
  [3/3]: pathspec: handle non-terminated strings with :(attr)

 date.c                   | 60 ++++++++++++++++++++++------------------
 dir.c                    |  7 +++++
 revision.c               | 15 ++++++----
 t/t0006-date.sh          |  1 +
 t/t6000-rev-list-misc.sh |  7 +++++
 5 files changed, 57 insertions(+), 33 deletions(-)

-Peff
