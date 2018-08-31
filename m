Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407711F404
	for <e@80x24.org>; Fri, 31 Aug 2018 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHaX42 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 19:56:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727501AbeHaX42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 19:56:28 -0400
Received: (qmail 29937 invoked by uid 109); 31 Aug 2018 19:47:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 19:47:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8207 invoked by uid 111); 31 Aug 2018 19:47:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 15:47:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 15:47:27 -0400
Date:   Fri, 31 Aug 2018 15:47:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
Message-ID: <20180831194727.GA5120@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
 <20180830070932.GB15420@sigill.intra.peff.net>
 <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
 <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 08:33:26AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Would "echo base >base" give us 5-byte long base even on Windows?
> >
> > Please note that Unix shell scripting is a foreign thing on Windows. As
> > such, there is not really any "native" shell we can use [*1*], and
> 
> Yeah, I know that; otherwise I wouldn't have asked.  Because ...
> 
> > therefore we use MSYS2's Bash which outputs Unix line endings.
> 
> ... I didn't know what MSYS folks chose, and/or if you have chosen
> to tweak their choice, and/or if you switched to somebody else's shell
> (e.g. busybox) and/or you chose to tweak what they do out of the box,
> it was worth asking and getting yes/no question.  You do not have to
> tell me why I should be asking.
> 
> So instead of typing 3 lines, you can just say "yes we use echo that
> emulates Unix".

I actually found Dscho's response much more informative than a simple
yes/no.

At any rate, it sounds like we are probably OK with echo, but I think it
is still worth doing the defensive patch-on-top that I posted.

-Peff
