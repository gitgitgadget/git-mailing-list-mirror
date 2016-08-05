Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CAE2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934788AbcHEISJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:18:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:55171 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934750AbcHEIR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 04:17:58 -0400
Received: (qmail 11269 invoked by uid 102); 5 Aug 2016 08:18:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 04:18:00 -0400
Received: (qmail 24229 invoked by uid 107); 5 Aug 2016 08:18:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 04:18:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 04:17:55 -0400
Date:	Fri, 5 Aug 2016 04:17:55 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805081754.5tjn7xtly5igdi63@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
 <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
 <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608041706040.5786@virtualbox>
 <20160804180749.foowbsmce72s46ww@sigill.intra.peff.net>
 <xmqq37mk1bnt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37mk1bnt.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 02:12:22PM -0700, Junio C Hamano wrote:

> >   2. Minor fixups noticed by maintainer, fixed while applying.
> 
> This includes different kinds of things:
> 
>     a) Trivially correct fixes given in other people's review.
> 
>     b) Minor fixups by the maintainer, to code.
> 
>     c) Minor fixups by the maintainer, to proposed log message.
> 
>     d) "apply --whitespace=fix" whose result I do not even actively
>        keep track of.
>
> [...]
>
> I think I can
> 
>  * stop taking 2-a).  This is less work for me, but some
>    contributors are leaky and can lose obviously good suggestions,
>    so I am not sure if that is an overall win for the quality of the
>    end product;

Actually, I think the 2-a class is what often saves a re-roll. Somebody
points out a typo in a commit message or a comment, and it quite often
gets picked up by you without having another round-trip to the list.

If you want to save work by not doing so, that's fine with me. But this
is the gamble I was talking about. I think it's actually often less work
to do the fixup than to look at another re-roll (especially with the
"leaky contributor" thing where you have to make sure all fixes were
applied). So it's a win if it saves the re-roll, but sometimes you end
up having to look at the re-roll anyway.

>  * do a separate "SQUASH???" commit and send them out for 2-b).
>    This is a lot more work for a large series, but about the same
>    amount of work (except for "remembering to send them out" part)
>    for a small-ish topic.  A contributor needs to realize that I
>    deal with _all_ the incoming topics, not just from topics from
>    one contributor, and small additional work tends to add up.

I think these are largely the same as 2-a. You are just wearing two
hats, reviewer and maintainer. Which I guess lets you take a shortcut
sometimes (and just fix without mentioning it), but fundamentally the
"gamble" aspect is the same, I think.

-Peff
