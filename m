Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE2120986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756016AbcJGOUq (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:20:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbcJGOUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:20:45 -0400
Received: (qmail 29344 invoked by uid 109); 7 Oct 2016 14:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 14:20:44 +0000
Received: (qmail 5686 invoked by uid 111); 7 Oct 2016 14:21:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 10:21:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2016 10:20:42 -0400
Date:   Fri, 7 Oct 2016 10:20:42 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161007142041.7xjqgujma5w6f77h@sigill.intra.peff.net>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <alpine.DEB.2.20.1610071519450.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610071519450.35196@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 04:11:34PM +0200, Johannes Schindelin wrote:

> Possibly a better idea would be to use *another* special symbol, one that
> makes intuitive sense as a modifier, such as:
> 
> 	[alias]
> 		# This works as before
> 		xyz = !pwd
> 		# As does this
> 		stat = -p status
> 		# This, however, is different:
> 		duy = (nocd)!pwd
> 
> This is backwards compatible as "(" is not a part of any Git command, nor
> of a valid alias, nor is it commonly used as part of a git-*
> executable/script.
> 
> It is also kind of a bit more intuitive, I'd wager, and it is also
> extensible to future options we may want to introduce.

I like this much better (like you, I am concerned about things like
"!(foo)" as conflicting with the shell). And I think your "(nocd)!pwd"
example is quite readable.

-Peff
