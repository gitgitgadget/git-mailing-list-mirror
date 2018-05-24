Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9E81F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034454AbeEXTWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:22:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1034413AbeEXTWR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:22:17 -0400
Received: (qmail 10523 invoked by uid 109); 24 May 2018 19:22:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 May 2018 19:22:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28450 invoked by uid 111); 24 May 2018 19:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 15:22:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 15:22:14 -0400
Date:   Thu, 24 May 2018 15:22:14 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git
 (May 2018, #02; Thu, 17))
Message-ID: <20180524192214.GA21535@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527174618.10589.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 08:40:18PM +0530, Kaartic Sivaraam wrote:

> > On the other hand, I'm not sure this is that big a deal. The point of
> > the deprecation warning is to catch people who are actually trying to
> > use "-l" as "--create-reflog", and that case does not page. The people
> > doing "git branch -l" are actually getting what they want eventually,
> > which is to turn it into "--list". In the interim step where it becomes
> > an unknown option, they'll get a hard error. 
> 
> I just thought we wouldn't want to surprise/confuse users who try to
> use "git branch -l" with the warning message about "create reflog"
> along-side the list of branches. That would just add to the confusion.
> So, I thought we should error out when users do "git branch -l"
> instead. Something like the following should help us prevent "git
> branch -l" from listing branch names and might also prevent the
> confusion.

Yeah, I think that's just a more extreme version of the current plan (it
turns it immediately into a hard error instead of warning for a while).
If we just make the warning easier to see in the paged case, I think
that makes the current plan fine.

I'll wrap up the patch I sent earlier.

-Peff
