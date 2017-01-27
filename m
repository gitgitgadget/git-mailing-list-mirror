Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D3B1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbdA0WTH (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:19:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:46110 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdA0WTG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:19:06 -0500
Received: (qmail 985 invoked by uid 109); 27 Jan 2017 22:12:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 22:12:23 +0000
Received: (qmail 5232 invoked by uid 111); 27 Jan 2017 22:12:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:12:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 17:12:21 -0500
Date:   Fri, 27 Jan 2017 17:12:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/1] reset: support the --stdin option
Message-ID: <20170127221221.d53icsq7mdkbqm23@sigill.intra.peff.net>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
 <cover.1485520718.git.johannes.schindelin@gmx.de>
 <3b0bad26045ed175f40f050e15b65cb6a8f2368c.1485520718.git.johannes.schindelin@gmx.de>
 <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
 <xmqqh94kz76v.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh94kz76v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 10:30:48AM -0800, Junio C Hamano wrote:

> > Is it worth clarifying that these are paths, not pathspecs? The word
> > "paths" is used to refer to the pathspecs on the command-line elsewhere
> > in the document.
> 
> If the code forces literal pathspecs, then what the user feeds to
> the command is no longer pathspecs from the user's point of view,
> and I agree that the distinction is important.  
> 
> If the remainder of the documentation is loose in terminology and
> the reason why we were able to get away with it was because we
> consistently used "paths" when we meant "pathspec", these existing
> mention of "paths" have to be tightened, either in this patch or a
> preparatory step patch before this one, because the addition of
> "this thing reads paths not pathspecs" is what makes them ambiguous.

I think a lot of the documentation uses <paths> to refer to pathspecs
(e.g., git-log(1), git-diff(1), etc).  As long as we're consistent with
that convention, I don't think it's that big a deal.

This spot needs a specific mention because it violates the convention.

I don't know if the are other spots where it might be unclear, but I
think we're probably better to tighten those as they come up, rather
than switch to saying "<pathspecs>" everywhere.

That's outside the scope of this series, though, I would think.

-Peff
