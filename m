Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B4C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626FF611B0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFJQdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:33:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhFJQdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:33:01 -0400
Received: (qmail 8375 invoked by uid 109); 10 Jun 2021 16:31:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 16:31:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31819 invoked by uid 111); 10 Jun 2021 16:31:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 12:31:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 12:31:03 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Message-ID: <YMI+R5LFTj7ezlZE@coredump.intra.peff.net>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <60c2373b93140_b25b1208c2@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60c2373b93140_b25b1208c2@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 11:00:59AM -0500, Felipe Contreras wrote:

> > I didn't look too deeply at your example, but I suspect it may be
> > related to the fact that diff3 does not try to minimize the conflicts as
> > much (and then the recursive merge on top of that piles on extra layers
> > of confusion).
> > 
> > There's a lot more discussion in this old thread:
> > 
> >   https://lore.kernel.org/git/20130306150548.GC15375@pengutronix.de/
> 
> Geezus. My patches always end up kicking the hornest nest don't they?
> 
> Maybe it would make sense to revive the zdiff3 patch and attempt to make
> that the default. That would take a lot of time though, so it wasn't as
> easy as just flipping a switch from "merge" to "diff3".

I had that patch in my daily build for several years, and I would
occasionally trigger it when seeing an ugly conflict. IIRC, it
segfaulted on me a few times, but I never tracked down the bug. Just a
caution in case anybody wants to resurrect it.

-Peff
