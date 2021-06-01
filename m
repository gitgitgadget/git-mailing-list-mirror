Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD263C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C73613AB
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhFAPgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:36:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:43250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233450AbhFAPgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:36:35 -0400
Received: (qmail 28341 invoked by uid 109); 1 Jun 2021 15:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Jun 2021 15:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11475 invoked by uid 111); 1 Jun 2021 15:34:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Jun 2021 11:34:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Jun 2021 11:34:51 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLZTmzvuRpgY935A@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
 <60b509be97423_24d2820856@natae.notmuch>
 <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
 <60b5d4f87f30c_e359f2085e@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b5d4f87f30c_e359f2085e@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 01:34:32AM -0500, Felipe Contreras wrote:

> > > I use ruby to parse binary data from git all the time:
> > > 
> > >         git log --format='%b%x00' |
> > >                 ruby -e 'ARGF.each("\0", chomp: true) { |chunk| p chunk }'
> > 
> > I doubt we'd want to add a ruby dependency to our test suite, but sure,
> > we could do the same thing with perl.
> 
> I don't mean in the final patches, I mean while the patches are
> being developed.
> 
> Once it's clear what the code should do, and how to verify it's doing
> what it's supposed to be doing, we can decide how the test suite should
> verify it.
> 
> Ruby is great for prototyping.

If we are not worried about the test suite, then I would think viewing
the output in "less" would be the simplest way to see that it's doing
the right thing.

-Peff
