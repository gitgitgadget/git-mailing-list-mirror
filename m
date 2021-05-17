Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF6C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E45611BD
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhEQL4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 07:56:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhEQL4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 07:56:53 -0400
Received: (qmail 5174 invoked by uid 109); 17 May 2021 11:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 11:55:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28545 invoked by uid 111); 17 May 2021 11:55:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 07:55:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 07:55:35 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Message-ID: <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a245a927c62_126333208ea@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 05:30:01AM -0500, Felipe Contreras wrote:

> > As there is no need to spell out HEAD, `master..` would be a better
> > example.
> 
> I don't think so. The description said _starting_ and _ending_ points...
> `master..` has no ending point.
> 
> If we must not use @, then I would rather use `master..mybranch`, or
> something like that. HEAD seems like a technical accident. But of course
> I would prefer HEAD to nothing, because at least it qualifies as an
> ending point.

I agree that if the purpose is to be illustrative, using shortcuts like
"an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
you need to have "revision range" defined, there is a good chance that
you don't know about shortcuts like "@" either.

So I would prefer something more explicit (whether it's "mybranch" or
"end" or "HEAD" or whatever).

In a more fleshed-out description it might be nice to casually introduce
such shortcuts to let the user pick them up naturally, but in a
one-liner like a glossary entry, I think clarity is the most important
thing.

> > Especially since most people are downstream consumers, I'd
> > suggest using `origin..` or `@{u}..` here.
> 
> Nobody uses "origin" (what does that even mean?), [...]

I guess I'm "nobody" then, because I use it all the time.

The example in Documentation/rev-list-description.txt (which feeds into
the git-log and git-rev-list manpages) uses "origin..HEAD", as well.

IMHO it is a pretty reasonable example, but the examples in
gitrevisions(7) use made up "r1..r2", and that seems perfectly readable,
as well.

-Peff
