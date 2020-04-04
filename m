Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B0C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4CC206D4
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 15:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDPUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:20:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726112AbgDDPUd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 11:20:33 -0400
Received: (qmail 5666 invoked by uid 109); 4 Apr 2020 15:20:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Apr 2020 15:20:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29847 invoked by uid 111); 4 Apr 2020 15:30:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Apr 2020 11:30:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Apr 2020 11:20:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josep Torra <n770galaxy@gmail.com>, git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200404152032.GC679473@coredump.intra.peff.net>
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
 <20200403185804.GA659704@coredump.intra.peff.net>
 <20200403193644.GA662633@coredump.intra.peff.net>
 <xmqq8sjcz6pd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sjcz6pd.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 12:53:50PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I guess it's this:
> >
> >   https://code.launchpad.net/launchpad
> >
> > but I can't find any trace of the "Parameters must have values" error
> > message in there. It looks like it builds on dulwich, but I can't find
> > the message there either. So I'm at a loss.
> 
> Let me apologize in advance for a totally useless distraction, but
> nevertheless I found it funny.  My search engine found
> 
>     https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19780010630.pdf
> 
> when I asked
> 
>     launchpad "parameters must have values"

Heh, wow. I knew vaguely what to expect from the URL, but was quite
pleased to see a PDF full of scanned FORTRAN code. I have a new
appreciation for working with our newfangled "C" code.

I also searched for that error but didn't come up with much. It seems to
be common in some AWS workflows. I wonder if it's just coincidence, or
if launchpad's git:// support is somehow just proxying to a service run
through AWS.

I think the next step is to report it to launchpad folks and let them
figure it out. I opened a bug there:

  https://bugs.launchpad.net/launchpad/+bug/1870804

-Peff
