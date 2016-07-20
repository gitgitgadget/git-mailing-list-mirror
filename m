Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EEE1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbcGTNbg (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:31:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:47455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752079AbcGTNbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:31:35 -0400
Received: (qmail 9511 invoked by uid 102); 20 Jul 2016 13:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:31:34 -0400
Received: (qmail 20553 invoked by uid 107); 20 Jul 2016 13:31:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:31:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:31:31 -0600
Date:	Wed, 20 Jul 2016 07:31:31 -0600
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
Message-ID: <20160720133130.GA19122@sigill.intra.peff.net>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox>
 <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
 <alpine.DEB.2.20.1607161507250.28832@virtualbox>
 <20160716150835.GA24374@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607161834420.28832@virtualbox>
 <20160716164747.GA24933@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607171003010.28832@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607171003010.28832@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 10:15:55AM +0200, Johannes Schindelin wrote:

> FWIW I am slightly less worried about the conditional includes (it is
> already a horrible mess to figure out too-long include chains now, before
> having conditional includes, for example). I am slightly more worried
> about eventually needing to introduce support for something like
> 
> 	[if-gitdir(...):section]
> 		thisSettingIsConditional = ...
> 
> or even
> 
> 	[if (worktree==...):section]
> 		anotherConditional = ...
> 
> and then having two incompatible conditional constructs, one generic, the
> other one specific to [include].
> 
> In other words, if we already introduce a conditional construct, I'd
> rather have one that could easily be used for other conditions/sections
> when (and if) needed.

I had assumed we would resist introducing anything like that, simply
because of backwards compatibility issues with the syntax. But I admit
that was just an assumption in my head; future compatibility with
reality is not guaranteed. :)

-Peff
