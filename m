Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3D71FAA8
	for <e@80x24.org>; Mon, 15 May 2017 07:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758781AbdEOHqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 03:46:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:51718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757293AbdEOHqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 03:46:21 -0400
Received: (qmail 10973 invoked by uid 109); 15 May 2017 07:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 07:46:19 +0000
Received: (qmail 14406 invoked by uid 111); 15 May 2017 07:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:46:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 03:46:17 -0400
Date:   Mon, 15 May 2017 03:46:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] cleanups on top of
 sg/clone-refspec-from-command-line-config
Message-ID: <20170515074617.wsdzogshc4ilnlsb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These three patches replace the DONTMERGE at the tip of
sg/clone-refspec-from-command-line-config. The first one is the
refactoring I posted earlier (and which was in the DONTMERGE), with a
commit message and signoff.

The third one fixes the minor leak I mentioned during the discussion.
And the second fixes some puzzling code I found while trying to write
the third one. :)

  [1/3]: clone: factor out refspec parsing
  [2/3]: remote: drop free_refspecs() function
  [3/3]: clone: use free_refspec() to free refspec list

 builtin/clone.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 remote.c        | 28 ++++++----------------------
 2 files changed, 41 insertions(+), 43 deletions(-)

-Peff
