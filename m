Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6CE20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbcJDQVG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:21:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52117 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753912AbcJDQVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:21:06 -0400
Received: (qmail 32453 invoked by uid 109); 4 Oct 2016 16:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 16:21:05 +0000
Received: (qmail 6818 invoked by uid 111); 4 Oct 2016 16:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 12:21:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 12:21:03 -0400
Date:   Tue, 4 Oct 2016 12:21:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
Message-ID: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
 <20161004111845.GA20309@book.hvoigt.net>
 <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
 <xmqq8tu4w0i2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tu4w0i2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 09:19:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As I argued in [1], I think it's not just "this must be cheaper" but
> > "this must not be enabled if submodules are not in use at all".  Most
> > repositories don't have submodules enabled at all, so anything that
> > cause any extra traversal, even of a portion of the history, is going to
> > be a net negative for a lot of people.
> >
> > I think the only sane default is going to be some kind of heuristic that
> > says "submodules are probably in use".
> 
> Why should we even have a default different from today's?  If most
> repositories don't have submodules enabled at all, we can just let
> those working with submodules enabled to toggle their configuration
> and that is an very easy to understand solution, no?

You will not see any complaint from me on that. I was taking for granted
that the current default is inconvenient to submodule users, but I don't
have any experience myself.

-Peff
