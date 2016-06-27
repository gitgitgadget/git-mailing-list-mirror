Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87F32018A
	for <e@80x24.org>; Mon, 27 Jun 2016 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcF0TRY (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 15:17:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:33612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751639AbcF0TRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 15:17:23 -0400
Received: (qmail 3503 invoked by uid 102); 27 Jun 2016 19:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:17:23 -0400
Received: (qmail 12473 invoked by uid 107); 27 Jun 2016 19:17:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 15:17:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 15:17:21 -0400
Date:	Mon, 27 Jun 2016 15:17:21 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
Message-ID: <20160627191720.GE9594@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net>
 <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
 <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 09:49:06AM -0700, Stefan Beller wrote:

> Quite a while ago, when I started doing code reviews professionally, I
> wondered if the code review procedure can be semi-automated, as
> automation helps keeping the error rate low. By that I mean having a
> check list which I can check off each point for each patch. That seems
> to be very good in theory, but when trying it I was finding myself
> doing a lot of unneeded work as some points of such a check list just
> do not apply for a specific patch. So I did not follow through with
> that.

I have wondered, too, if we could have better tooling to help us with
reviews. But one of the things I really _like_ about doing reviews for
git (versus other projects) is that doing review via email is
unconstrained. The primary recipient is human, and I can format and say
whatever I like in the way that best communicates to the human, without
worrying about fitting my comments into a pre-made form.

That being said, I suspect one could go a long way by picking out basic
patterns from emailed responses. For example, you could imagine a system
that makes a todo list of review comments (one comment per response to a
quoted section) and associates them with given bits of the code (by
seeing what's in the quoted section). That todo list can become a
checklist when sending out the next revision, or could even be used
interactively to see what happened to each code spot (did you fix it?
How? In which commit?). That would help reviewers, but also would help
submitters send out the cover letter for the next version (by reminding
them what to mention).

Of course, none of that would have helped my comment, which was in a
"PS" several emails deep in a discussion thread. ;)

-Peff
