Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7C01F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbcHPPj6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:39:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:56284 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753398AbcHPPj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:39:57 -0400
Received: (qmail 14843 invoked by uid 109); 16 Aug 2016 15:39:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 15:39:51 +0000
Received: (qmail 27271 invoked by uid 111); 16 Aug 2016 15:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 11:39:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 11:39:48 -0400
Date:	Tue, 16 Aug 2016 11:39:48 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
Message-ID: <20160816153948.emnkazqtwluxwun3@sigill.intra.peff.net>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
 <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
 <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com>
 <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608161502240.4924@virtualbox>
 <20160816145532.nfooqmkaostc2e7t@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608161732390.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608161732390.4924@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 05:37:35PM +0200, Johannes Schindelin wrote:

> > Hrm. I am not sure I agree. At GitHub, for instance, we turn on
> > core.protectNTFS for all repositories because we do want to be a vector
> > for attacks.
> 
> I trust you meant "do *not* want to be a vector for attacks"...

Heh, yes.

> Good point.
> 
> What I meant in my curt language was actually not to use core.protectNTFS
> per se, but the same code path. That is, I would rather have any such
> "cross-platform helping" code in verify_path() rather than
> write_index_as_tree().
> 
> But you are correct, this hypothetical feature (pretty hypothetical,
> indeed, at this point) would have to be configured differently than
> via core.protectNTFS=true.

Ah, OK. Yeah, I don't have any real objection to that. I'm not sure how
easy it would be to check verify_path() for an existing commit (say, as
part of a pre-commit hook, or a pre-receive, or in a CI test). But if it
is not easy, that seems like a problem that can (and should) be fixed
separately.

-Peff
