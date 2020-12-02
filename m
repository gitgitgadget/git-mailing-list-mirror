Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C5C64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F07B217A0
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgLBNNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:13:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:48728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgLBNNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 08:13:34 -0500
Received: (qmail 32648 invoked by uid 109); 2 Dec 2020 13:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 13:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7266 invoked by uid 111); 2 Dec 2020 13:12:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Dec 2020 08:12:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Dec 2020 08:12:53 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] handling 4GB .idx files
Message-ID: <X8eS1Zrqk99AjKkD@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
 <X8aLDlzcNCwP699c@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8aLDlzcNCwP699c@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 01:27:26PM -0500, Taylor Blau wrote:

> I have a sense that probably very few people actually run GIT_TEST_LONG
> regularly, and that that group may vanish entirely if we added a test
> which increased the runtime of the suite by 20x in this mode.

Yeah, and if that's so, then I'm OK with calling it EXPENSIVE and moving
on with our lives. And I guess merging this is one way to find out, if
anybody screams. The stakes are low enough that I don't mind doing that.

> I have mixed feelings about VERY_EXPENSIVE. On one hand, having this
> test checked in so that we can quickly refer back to it in the case of a
> regression is useful. On the other hand, what is it worth to have this
> in-tree if nobody ever runs it? I'm speculating about whether or not
> people would run this, of course.
> 
> My hunch is that anybody who is interested enough to fix regressions in
> this area would be able to refer back to the list archive to dig up this
> thread and recover the script.
> 
> I don't feel strongly, really, but just noting some light objections to
> checking this test into the suite.

Yeah, that about matches my feelings. But if Thomas wants to wrap it up
as a patch, I don't mind seeing what happens (and I think with the
suggestions I gave earlier, it would be in good shape).

-Peff
