Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A246E208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdHTJSK (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:18:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:43946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752696AbdHTJSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:18:09 -0400
Received: (qmail 25801 invoked by uid 109); 20 Aug 2017 09:18:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 09:18:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12854 invoked by uid 111); 20 Aug 2017 09:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 05:18:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 05:18:07 -0400
Date:   Sun, 20 Aug 2017 05:18:07 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: Please fix the useless email prompts
Message-ID: <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
 <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 02:02:09PM -0400, Jeffrey Walton wrote:

> > Hasn't this been asked and answered already?
> >
> >     https://public-inbox.org/git/CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com/
> 
> Its 2017. I'd like the tools to work for me instead of me working for the tools.

Ironically, Git used to behave as you requested in 2005. After being
bombarded with complaints about how Git was too lax in creating commits
with bogus ident information, we changed it in 2012. So I don't think
"it's 2017" carries any weight as an argument.

There are numerous discussions in the archive on this. But my
recollection is that the conclusion is:

  - stricter ident checking on balance saves more headaches than it
    causes, just in terms of numbers

  - the headaches solved by stricter checking are hard to fix (because
    you unknowingly bake cruft into commit objects, and fixing that
    requires a history rewrite)

  - the headaches caused by stricter checking are easy to fix (they're
    obvious when they happen, and "git -c" lets you provide a dummy
    value to override).

We can revisit any of those conclusions, but I'd want to see a
thoughtful discussion of the tradeoffs raised in past rounds, not just
"the current behavior is inconvenient for me".

-Peff
