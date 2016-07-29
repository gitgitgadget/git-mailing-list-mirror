Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15141F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbcG2Wts (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:49:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51408 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750903AbcG2Wtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 18:49:47 -0400
Received: (qmail 18483 invoked by uid 102); 29 Jul 2016 22:49:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:49:48 -0400
Received: (qmail 6302 invoked by uid 107); 29 Jul 2016 22:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:50:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 18:49:44 -0400
Date:	Fri, 29 Jul 2016 18:49:44 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729224944.GA23242@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
 <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
 <20160729223134.GA22591@sigill.intra.peff.net>
 <xmqqwpk4kqr4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpk4kqr4.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 03:45:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > TBH, I'm not sure anybody cares that much between the three. Even before
> > user.useConfigOnly, this could be an issue on machines where the ident
> > could not be auto-configured, and it seems like nobody ran across it.
> > It's only the funny interaction with pull.rebase that makes it likely to
> > come up, so as long as that code path is fixed (one way or another), I
> > doubt anybody would bring it up again.
> 
> Yup, I do not think the choice among the three would make all that
> much difference in practice.  If I really have to pick one of them,
> I think the one in your message I am responding to would make the
> most sense.
> 
> The one I sent, which I wrote as a response to some end-user request
> on the list back then, has been sitting on 'pu' for quite a while
> because I didn't see a real use or positive support for it, and the
> only reason why I sent it is because this might be that one
> real use it wanted to see.

BTW, I didn't actually test yours, but if we do go that route I suspect
you can reuse the tests I posted by just replacing "git rebase" with
"git pull --rebase=<true|preserve> . master".

> > In some ways this is less convenient, but in some ways it is
> > more so; the user can then manually commit or even "git
> > rebase --continue" after setting up their ident (or
> > providing it as a one-off on the command line).
> 
> Yup, that is the controvercial bit, and I suspect Dscho's original
> was siding for the "set up ident first, as you will need it anyway
> eventually", so I'll let others with viewpoints different from us to
> chime in first before picking it up.

Very sensible. Thanks.

-Peff
