Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607B6202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdB1Wd2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:33:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:36120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdB1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:33:28 -0500
Received: (qmail 28862 invoked by uid 109); 28 Feb 2017 22:33:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 22:33:27 +0000
Received: (qmail 32192 invoked by uid 111); 28 Feb 2017 22:33:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 17:33:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 17:33:25 -0500
Date:   Tue, 28 Feb 2017 17:33:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
Message-ID: <20170228223325.vabdrwas2qn52gup@sigill.intra.peff.net>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
 <20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net>
 <xmqqh93ehrxx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh93ehrxx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 02:27:22PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... We can certainly stick with it for now (it's awkward if you
> > really do have an entry on Jan 1 1970, but other than that it's an OK
> > marker). I agree that the most negatively value is probably a saner
> > choice, but we can switch to it after the dust settles.
> 
> I was trying to suggest that we should strive to switch to the most
> negative or whatever the most implausible value in the new range
> (and leave it as a possible bug to be fixed if we missed a place
> that still used "0 is impossible") while doing the ulong to time_t
> (or timestamp_t that is i64).  
> 
> "safer in the short term" wasn't meant to be "let's not spend time
> to do quality work".  As long as we are switching, we should follow
> it through.

Sure, I'd be much happier to see it done now. I just didn't want to pile
on the requirements to the point that step 1 doesn't get done. But I
haven't even looked at the code changes needed for time_t. I suspect
Dscho has a better feel for it at this point.

-Peff
