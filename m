Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235E11F731
	for <e@80x24.org>; Thu,  1 Aug 2019 02:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHACxo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 22:53:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726125AbfHACxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 22:53:44 -0400
Received: (qmail 23069 invoked by uid 109); 1 Aug 2019 02:53:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 02:53:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24290 invoked by uid 111); 1 Aug 2019 02:55:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 22:55:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 22:53:42 -0400
From:   Jeff King <peff@peff.net>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801025342.GA7102@sigill.intra.peff.net>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <20190801010022.GA6553@sigill.intra.peff.net>
 <CAAOiGNwDV3LNGRVPQN6DgES6raG76u-rW0nBuw=i2oHTibVSPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAOiGNwDV3LNGRVPQN6DgES6raG76u-rW0nBuw=i2oHTibVSPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 08:38:14PM -0500, Ariadne Conill wrote:

> > Something like:
> >
> >   Author: A U Thor <author@example.com>
> >   Original-Author: I M Mailmapped <orig@example.com>
> >
> > gives even more information while leaving the "Author:" line untouched.
> > But in introducing a new line, it may also be breaking somebody.
> 
> It also makes this entire exercise completely moot because not only
> does it deadname the contributor, it discloses that it is deadnaming
> the contributor while also telling you who they are now, which is even
> worse than the current behaviour.  The purpose of this exercise is to
> ensure that users have the *current* contact information of the
> contributor by default, including their current name and e-mail.  My
> entire goal behind transitioning this config default is to ensure that
> git respects *present* identity information by default, while giving
> access to the raw identity data in cases where it makes sense to do so
> (such as historical research or whatever).  I don't really wish for
> git to remind me of my previous identity while browsing through
> historical git logs.  I also don't think most people care about the
> previous identity data of contributors -- in most cases, if you're
> looking up a commit's author, you're doing so because you intend to
> ask them a question about the commit, and so, having the most current
> identity data available is what actually makes sense.

Fair enough. My thinking was just that it would make it clear to
somebody who wasn't expecting the mailmap to be used what was going on:
they would have seen "orig" in the old output, but now they are seeing
"author". But I agree that most people wouldn't even _care_, and the
orig name is just garbage in most cases.

I had been thinking it would be a temporary measure during the
transition period, but it probably isn't even worth the hassle and
confusion it would cause during that period.

By the way, we've been talking mostly about output in this thread. One
thing that did catch me a little by surprise is that "--author", etc,
will now use the mailmap by default, too. Which I think makes perfect
sense, but when looking for my own mailmapped entries to run some
examples on, I was surprised at first that "git log
--author=peff@github.com" didn't find anything.

But aside from experimenting with this mailmap feature, I cannot think
of a single time in the last decade I would have cared about that
distinction (and in fact, most of the time I would be searching for my
own commits by my mailmapped address, and would have preferred they be
found in that group).

-Peff
