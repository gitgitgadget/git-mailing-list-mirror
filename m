Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914691F404
	for <e@80x24.org>; Fri, 31 Aug 2018 00:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeHaE7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 00:59:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:34942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbeHaE7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 00:59:18 -0400
Received: (qmail 19842 invoked by uid 109); 31 Aug 2018 00:54:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 00:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2066 invoked by uid 111); 31 Aug 2018 00:54:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 20:54:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 20:54:26 -0400
Date:   Thu, 30 Aug 2018 20:54:26 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
Message-ID: <20180831005426.GA2858@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180830075431.GF11944@sigill.intra.peff.net>
 <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
 <20180830194634.GE19685@sigill.intra.peff.net>
 <xmqqva7r4nof.fsf@gitster-ct.c.googlers.com>
 <c9d51d68-c7ae-64f9-b3e9-a72f33c5afc3@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9d51d68-c7ae-64f9-b3e9-a72f33c5afc3@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 12:49:39AM +0100, Ramsay Jones wrote:

> On 30/08/18 21:14, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> >> I suppose so. I don't think I've _ever_ used distclean, and I only
> >> rarely use "clean" (a testament to our Makefile's efforts to accurately
> >> track dependencies). I'd usually use "git clean" when I want something
> >> pristine (because I don't want to trust the Makefile at all).
> > 
> > I do not trust "git clean" all that much, and pre-cleaning with
> > "make distclean" and then running "git clean -x" has become my bad
> > habit.  I jump around quite a bit during the day, which would end up
> > littering the working tree with *.o files that are only known to one
> > but not both of {maint,pu}/Makefile's distclean rules.  I even do
> > "for i in pu maint master next; do git checkout $i; make distclean; done"
> > sometimes before running "git clean -x" ;-)
> > 
> 
> 'git clean -x' always removes _way_ more than I want it
> to - in particular, I lost my config.mak more than once.

Heh. I have done that, too, but fortunately mine is a symlink to a copy
that is held in a git repository. ;)

-Peff
