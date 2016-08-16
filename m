Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D011F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbcHPR1H (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:27:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:56387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbcHPR1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:27:07 -0400
Received: (qmail 20727 invoked by uid 109); 16 Aug 2016 17:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 17:20:25 +0000
Received: (qmail 28653 invoked by uid 111); 16 Aug 2016 17:20:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 13:20:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 13:20:22 -0400
Date:	Tue, 16 Aug 2016 13:20:22 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160816172022.juqvfn5vwt2pdcyd@sigill.intra.peff.net>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:10:42AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > So as a discussion starter:
> > * Should git am skip a patch 00/XX automatically ?
> 
> No.  My preference is to add "--initial-skip=<N>", though.
> 
> When I receive a patch series to reroll another series, I somehow
> know and verify that earlier N patches have not changed, I detach
> the HEAD at the last unchanged commit from the previous round and
> apply the remainder of the new series, so that I can preserve the
> author timestamps of earlier steps from the previous series.  By
> the time I "know and verify" where the first step that was updated,
> I have a full series in a single mbox; having "--initial-skip=<N>"
> would help with that use case, too, and "skipping the first" is a
> narrow special case of giving N=1.

For my workflow, it is not about "initial skip", but rather just "skip
emails that don't have patches in them at all". My MUA makes it easy to
tag a whole thread (or subthread), cover letter and discussion included,
and then dump it all to git-am.

And I think that would be the same for a public-inbox workflow (if it
learns to grab sub-threads; otherwise you end up with earlier iterations
of the series attached to the same thread).

That is solving a different problem than you, though, where you want to
skip actual patches because you know they are unchanged.

-Peff
