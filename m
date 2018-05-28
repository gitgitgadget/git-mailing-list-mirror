Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D361F51C
	for <e@80x24.org>; Mon, 28 May 2018 09:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeE1Jho (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:37:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:54496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754090AbeE1Jhm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:37:42 -0400
Received: (qmail 22199 invoked by uid 109); 28 May 2018 09:37:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 May 2018 09:37:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20770 invoked by uid 111); 28 May 2018 09:37:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 May 2018 05:37:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2018 05:37:40 -0400
Date:   Mon, 28 May 2018 05:37:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] minor show-index modernizations
Message-ID: <20180528093740.GA6902@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While recommending show-index to somebody today, I noticed that it has a
few ancient warts. This series turns it into a builtin and fixes the
documentation. I suspect it could do with some more modernization and
friendliness, like:

  - re-using the existing packfile.c code instead of re-implementing
    index-reading (though the packfile code would definitely need some
    refactoring to make this work)

  - it could probably handle arguments as files instead of requiring
    stdin redirection

I'll leave those for now, as they're not worth the effort to me at this
point. But everybody who _doesn't_ use the command benefits from making
it a builtin, so it seems like an easy win.

  [1/2]: make show-index a builtin
  [2/2]: show-index: update documentation for index v2

 Documentation/git-show-index.txt     | 22 ++++++++++++++++------
 Makefile                             |  2 +-
 builtin.h                            |  1 +
 show-index.c => builtin/show-index.c |  2 +-
 git.c                                |  1 +
 5 files changed, 20 insertions(+), 8 deletions(-)
 rename show-index.c => builtin/show-index.c (96%)

-Peff
