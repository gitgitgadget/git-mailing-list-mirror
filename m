Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63CC47425
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741F3610E7
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 16:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFDQho (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:37:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:46268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDQhn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 12:37:43 -0400
Received: (qmail 10517 invoked by uid 109); 4 Jun 2021 16:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Jun 2021 16:35:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3729 invoked by uid 111); 4 Jun 2021 16:35:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Jun 2021 12:35:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Jun 2021 12:35:56 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed
 stuff
Message-ID: <YLpWbLkaqVYqTrGL@coredump.intra.peff.net>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
 <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
 <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 08:48:21AM -0700, Elijah Newren wrote:

> > >           Signed-off-by: Elijah Newren <newren@gmail.com>
> > >      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
> >
> > I believe the sign-off should always be the last thing in
> > the message. Perhaps Junio is willing to fix this without a
> > re-roll?
> 
> Interesting, this is the first I've ever heard of such a requirement,
> and I've submitted patches this way numerous times and have seen
> others do it.  A quick search through git.git history says there are
> 5133 commits that place such trailers before the author's
> Signed-off-by, and 1175 that place them after.  While the former is
> clearly more common, and some of the latter could have been Junio
> adding trailers while applying the patches, there still seem like
> plenty of counter-examples suggesting that there is no rule here.

I don't think there's a hard rule here. The usual advice (which I also
didn't find documented from a quick grep, but hopefully is kind of
intuitive) is that trailers should be chronological.

So if you picked up a patch from person X who signed off, then you
modified and signed off the result, then Junio signed off after
applying, we'd expect that chain of custody to be represented by reading
top to bottom. And that's what happens if you use "am -s", "commit -s",
etc.

Whether "Acked-by" happens after the author signs off or not is
debatable. Obviously it happens after the version of the patch that is
sent out. But if you re-send with an Acked-by, is the signoff your one
from before that happened first, or a new one that happened as you sent
out the patch? Perhaps a question for the philosophers. ;)

Anyway, I think it is perfectly fine either way (as your numbers
indicate).

-Peff
