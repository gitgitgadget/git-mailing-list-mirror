Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DCF51F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdKKPj6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 10:39:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:53410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751286AbdKKPj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 10:39:57 -0500
Received: (qmail 29866 invoked by uid 109); 11 Nov 2017 15:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Nov 2017 15:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10068 invoked by uid 111); 11 Nov 2017 15:40:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 11 Nov 2017 10:40:09 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Nov 2017 15:39:54 +0000
Date:   Sat, 11 Nov 2017 15:39:54 +0000
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a stylistic preference for a trailing "--" on a command?
Message-ID: <20171111151907.owrbpnn35aepj4ha@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1711100855140.3617@DESKTOP-1GPMCEJ>
 <CAGZ79kavxFA_wBzcSbR8LT4uZGkdv4c07ZMfE4TK0tkooMGg6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kavxFA_wBzcSbR8LT4uZGkdv4c07ZMfE4TK0tkooMGg6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 10:12:39AM -0800, Stefan Beller wrote:

> On Fri, Nov 10, 2017 at 5:57 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   just noticed these examples in "man git-bisect":
> >
> > EXAMPLES
> >   $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
> >   ...
> >   $ git bisect start HEAD origin --    # HEAD is bad, origin is good
> >   ...
> >   $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
> >
> > is there some rationale or stylistic significance to those trailing
> > "--" on those commands? i assume they have no effect, just curious as
> > to why they're there.
> 
> By having the -- there, it is clear that the strings are ref specs and not files
> of such a name. (Who would want to store a file named HEAD~10 in their
> repo?)

Just to be explicit, that makes it not just clear to the user but clear
to Git. Without a "--" there heuristics that kick in. The first section
of the "gitcli" manpage talks about this, though I don't know that we
explicitly document the heuristics anywhere (and I think that is
intentional -- we promise only to try to do what you meant, and scripts
that want exact behavior should use a disambiguating "--").

-Peff
