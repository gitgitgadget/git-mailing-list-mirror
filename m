Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9CA202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 12:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbdCIMRQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 07:17:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:41215 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdCIMRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 07:17:14 -0500
Received: (qmail 14595 invoked by uid 109); 9 Mar 2017 12:16:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 12:16:23 +0000
Received: (qmail 364 invoked by uid 111); 9 Mar 2017 12:16:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:16:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 07:16:20 -0500
Date:   Thu, 9 Mar 2017 07:16:20 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
Message-ID: <20170309121620.rld6scydqru72nbk@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de>
 <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703071314180.3767@virtualbox>
 <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
 <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
 <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net>
 <xmqqinnj1jb6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703091243260.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703091243260.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 12:51:06PM +0100, Johannes Schindelin wrote:

> On Wed, 8 Mar 2017, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > >> Or are you discussing a more general issue, iow, anything that can
> > >> work without repository (i.e. those who do _gently version of the
> > >> setup and act on *nongit_ok) should pretend as if there were no
> > >> (broken) repository and take the "no we are not in a repository"
> > >> codepath?
> > >
> > > Yes, exactly.  It would have been less confusing if I picked something
> > > that passed nongit_ok. Like hash-object:
> 
> ... or like testing the early config directly?

I was trying to demonstrate that the problem existed already without
your patch series.

> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: [PATCH] t1309: document cases where we would want early config not to
>  die()
> 
> Jeff King came up with a couple examples that demonstrate how the new
> read_early_config() that looks harder for the current .git/ directory
> could die() in an undesirable way.
> 
> Let's add those cases to the test script, to document what we would like
> to happen when early config encounters problems.

Yep, these all look fine.

-Peff
