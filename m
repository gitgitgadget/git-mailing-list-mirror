Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFD8C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F31D20658
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHLRKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:10:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:56688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLRKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 13:10:39 -0400
Received: (qmail 10527 invoked by uid 109); 12 Aug 2020 17:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 17:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 953 invoked by uid 111); 12 Aug 2020 17:10:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 13:10:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 13:10:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
Message-ID: <20200812171038.GB43566@coredump.intra.peff.net>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com>
 <20200811183258.GB33865@syl.lan>
 <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
 <20200812153705.GC33189@coredump.intra.peff.net>
 <CAPig+cQNvJ02fm82oBtyyxHUqfNk3oAZJW__Lu2Kn0Qt3VaDWw@mail.gmail.com>
 <CAPig+cSzLcVdzjoacm6=7mDAhUn8j06Z0LXo7r1LMC7Dx_2JZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSzLcVdzjoacm6=7mDAhUn8j06Z0LXo7r1LMC7Dx_2JZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 12:39:14PM -0400, Eric Sunshine wrote:

> On Wed, Aug 12, 2020 at 12:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Aug 12, 2020 at 11:37 AM Jeff King <peff@peff.net> wrote:
> > > I don't think this is an error. The program can tell which you meant by
> > > the number of arguments. POSIX lays out some rules here (from "man
> > > 1posix test" on my system, but I'm sure you can find it online):
> >
> > I intentionally didn't focus on or mention POSIX in my response
> > because I wanted to represent the Real World reason why "x$var" is
> > such a common idiom. [...]
> 
> I probably should have done a better job in my original response to
> Taylor to make it clear that I was talking about Real World (even if
> old) rather than POSIX.

Yeah. I guess I'm questioning how current that Real World view is. It
hasn't bitten us yet, though we do seem to do the "x" thing in some
places. And most of our shell code is in the test suite, which sees
pretty tame filenames.

-Peff
