Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D923C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C318613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFCVKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 17:10:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:45526 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 17:10:09 -0400
Received: (qmail 6803 invoked by uid 109); 3 Jun 2021 21:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 21:08:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29388 invoked by uid 111); 3 Jun 2021 21:08:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 17:08:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 17:08:23 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Message-ID: <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
 <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
 <60b93a264cb7_39da0420855@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b93a264cb7_39da0420855@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 03:23:02PM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > Preemptively finding portability problems may save work in the long
> > term. And people may even be using Git on AIX and just ignoring test
> > failures, or they have GNU coreutils installed anyway, etc. But it would
> > also save work if we can ignore platforms that nobody uses.
> 
> I agree, but the Git project is overly preoccupied (IMO) with
> hypothetical issues some hypothetical users might have in some
> hypothetical situations, and that is used as a rationale to block changes
> that would improve the experience of the vast majority of users.
> 
> This is not a hypothetical issue, and yet you are suggesting to
> discount it?
> 
> I don't disagree, but this is not consistent.

I don't think they're the same issue at all. One is: we have millions of
users, and this change may affect some of them negatively, so we may
want to err on the side of caution. The other is: this has been
accidentally broken for four years and nobody complained, so perhaps
nobody is actually using it.

You may also note that I did in fact produce a patch.

-Peff
