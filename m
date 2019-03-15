Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0F120248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCODVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:21:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726571AbfCODVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:21:05 -0400
Received: (qmail 14553 invoked by uid 109); 15 Mar 2019 03:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:21:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28663 invoked by uid 111); 15 Mar 2019 03:20:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:20:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:19:48 -0400
Date:   Thu, 14 Mar 2019 23:19:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190315031948.GD28943@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
 <20190313193909.GB3400@sigill.intra.peff.net>
 <20190313201854.GA5530@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903141228510.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903141228510.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:31:21PM +0100, Johannes Schindelin wrote:

> > Hmm. I guess it is still an issue in GGG. This thread has identical
> > timestamps on patches 1 and 2 (and my server received them out of order
> > by 2 seconds, so mutt orders them wrong):
> > 
> >   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
> > 
> > I do still think GGG has a more feasible path forward on this particular
> > bug, though.
> 
> Indeed. And it is a bug^Wfeature of GMail, I guess, that it knows better
> and ignores the Date: header of the mbox fed to it.

Heh. So it in fact has the identical problem that submitGit and SES
have. :)

> The only workaround I can think of is to introduce ugly one-second-sleeps.
> I will do that if it proves necessary, but I do have a problem right now
> because my only GitGitGadget reviewer (Stolee) is kinda busy with other
> things for the time being.

I suspect that may be the ultimate solution. Which isn't fantastic, but
at the same time, I doubt anybody would really notice that much. There
are typically delays of seconds to minutes already in delivering email.
Unless somebody has a 200 patch series, but maybe then it is kinder to the
receivers to let it trickle in. ;)

-Peff
