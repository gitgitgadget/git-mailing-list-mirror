Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26ABB1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbcHPNHo (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 09:07:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:56183 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932225AbcHPNGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 09:06:52 -0400
Received: (qmail 5975 invoked by uid 109); 16 Aug 2016 13:06:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 13:06:51 +0000
Received: (qmail 26150 invoked by uid 111); 16 Aug 2016 13:06:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 09:06:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 09:06:48 -0400
Date:	Tue, 16 Aug 2016 09:06:48 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ryenus <ryenus@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-parse: respect core.hooksPath in --git-path
Message-ID: <20160816130648.rfkebvmmk2uwfle2@sigill.intra.peff.net>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
 <20160815125006.qdssqgd4rzjw4vi5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608161440290.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608161440290.4924@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 02:42:34PM +0200, Johannes Schindelin wrote:

> > I think you can squash in:
> > 
> > diff --git a/run-command.c b/run-command.c
> [...]
> 
> Good point.
> 
> BTW in light of the discussion we are having elsewhere I just need to
> point out that it was *dramatically* faster for me to edit run-command.c,
> find "hooks/" and adjust the code manually than it would have been to save
> the diff and apply it.
> 
> That's because I do not have advanced tooling on top of email (and I also
> could not handle mutt, so I am stuck with a not-really-scriptable email
> client).
> 
> Just sayin'.

There's a flip side, too. It was faster for me to paste in the diff than
it would have been to create a branch, push it to GitHub, and make a PR
on your PR (and then later remember to deal with my PR and branch so as
not to leave them hanging around cluttering up my fork).

I'm definitely sympathetic to people with less exacting email clients,
but I'm not convinced that the GitHub flow is that great if you don't do
the review there in the first place (and even when you do, it's actually
not that great for suggesting things in patch form).

I wonder if public-inbox could have helped here. I think:

  mid=20160815125006.qdssqgd4rzjw4vi5@sigill.intra.peff.net
  curl http://public-inbox.org/git/$mid/raw | git apply

would work, but the question remains of how you find the right
message-id. You can generally pick it out of the MUA's message headers
manually, though I think some MUAs even make seeing the extended headers
hard. But that's going to be a similar problem with any solution that
isn't your MUA: how do you feed the context of the discussion happening
in one place to another tool.

-Peff
