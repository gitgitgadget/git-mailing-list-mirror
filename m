Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EEB201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdB0J6J (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:58:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34659 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbdB0J6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:58:07 -0500
Received: (qmail 18966 invoked by uid 109); 27 Feb 2017 09:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 09:31:24 +0000
Received: (qmail 22448 invoked by uid 111); 27 Feb 2017 09:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 04:31:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 04:31:22 -0500
Date:   Mon, 27 Feb 2017 04:31:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] interpret_branch_name(): handle auto-namelen for @{-1}
Message-ID: <20170227093122.3jdb2b62hlbbio5r@sigill.intra.peff.net>
References: <20170227092540.ob2oy4qpgfukqwtc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227092540.ob2oy4qpgfukqwtc@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 04:25:40AM -0500, Jeff King wrote:

> However, before we do that auto-namelen magic, we call
> interpret_nth_prior_checkout(), which gets fed the bogus
> "0". This was broken by 8cd4249c4 (interpret_branch_name:
> always respect "namelen" parameter, 2014-01-15).  Though to
> be fair to that commit, it was broken in the _opposite_
> direction before, where we would always treat "name" as a
> string even if a length was passed.

That commit is mine, by the way. More embarrassing than introducing the
bug is that I _noticed_ the problem at the time and wrote a paragraph in
the commit message rationalizing why it was OK, rather than just doing
this trivial fix.

-Peff
