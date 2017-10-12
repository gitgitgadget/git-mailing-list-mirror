Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755A820372
	for <e@80x24.org>; Thu, 12 Oct 2017 14:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbdJLOY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 10:24:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751976AbdJLOY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 10:24:27 -0400
Received: (qmail 17614 invoked by uid 109); 12 Oct 2017 14:24:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 14:24:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15975 invoked by uid 111); 12 Oct 2017 14:24:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 10:24:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 10:24:24 -0400
Date:   Thu, 12 Oct 2017 10:24:24 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171012142424.5d76jrwxex24wsxz@sigill.intra.peff.net>
References: <20171009214543.12986-1-me@ikke.info>
 <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
 <20171010140118.quyesljvz44wvfx6@sigill.intra.peff.net>
 <CAN0heSqZn1pqskK-KP=DEW1-Kz=-avX0TUON38Dk_TVKAsBAiQ@mail.gmail.com>
 <20171011045404.GB16800@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171011045404.GB16800@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 06:54:04AM +0200, Kevin Daudt wrote:

> > > Yeah, I didn't think of that with respect to the pager. This is a
> > > regression in v2.14.2, I think.
> > 
> > Yes.
> 
> Though 2.14.2 enabled the pager by default, even before that when
> someone would've enabled the pager theirselves (by setting pager.tag for
> example), it would also shown just a single column.
> 
> I could reproduce it as far as 2.8.3 (I could not test further due to
> libssl incompattibility).

Right, I think it has always been broken. It's just that it became a lot
more widespread with the increased use of the pager.

I specifically wanted to make sure this wasn't a regression in the v2.15
release candidates (since that would mean we'd want to deal with it
before shipping v2.15). It still _would_ be nice to deal with it soon,
but since it's already been in the wild for a bit, it can wait to hit
"maint" in the post-v2.15 cycle.

-Peff
