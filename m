Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5600FC4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCF5613AD
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFDTyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:54:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:46476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhFDTys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 15:54:48 -0400
Received: (qmail 11266 invoked by uid 109); 4 Jun 2021 19:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Jun 2021 19:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5621 invoked by uid 111); 4 Jun 2021 19:53:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Jun 2021 15:53:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Jun 2021 15:53:00 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed
 stuff
Message-ID: <YLqEnEJgQANm1SCD@coredump.intra.peff.net>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
 <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
 <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
 <YLpWbLkaqVYqTrGL@coredump.intra.peff.net>
 <c9d596f3-cfc9-4bb7-1008-4873dafd8270@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9d596f3-cfc9-4bb7-1008-4873dafd8270@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 02:42:03PM -0400, Derrick Stolee wrote:

> > Whether "Acked-by" happens after the author signs off or not is
> > debatable. Obviously it happens after the version of the patch that is
> > sent out. But if you re-send with an Acked-by, is the signoff your one
> > from before that happened first, or a new one that happened as you sent
> > out the patch? Perhaps a question for the philosophers. ;)
> 
> I guess I was just interpreting that the "Acked-by" was part of
> the content you created, and hence it should be covered by the
> sign-off. I can imagine that if Junio added it, then it would be
> after your sign-off but before his.

FWIW, that's how I interpret it, too. I was curious how it looks for my
own patches, which is easy-ish to dig up with:

  git log --author=peff --grep=Acked-by --format='%H%n%(trailers)'

They're mostly after my signoff there, but I think that's because I very
rarely add in the Ack, and mostly Junio does it (likewise for
Reviewed-by).

My workflow is maybe a little different than others, too, in that I very
rarely signoff patches in my repo, but add it via "format-patch -s" when
sending them out (so naturally it would come after anything I had
typed).

> > Anyway, I think it is perfectly fine either way (as your numbers
> > indicate).
> 
> I agree. I didn't mean to make a big deal of it.

It was a little bit of an interesting diversion, though. :)

-Peff
