Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C79FC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF6D21D46
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgKJTzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:55:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:53260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbgKJTyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:40 -0500
Received: (qmail 8985 invoked by uid 109); 10 Nov 2020 19:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 19:54:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4501 invoked by uid 111); 10 Nov 2020 19:54:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 14:54:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 14:54:39 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 06/21] t4205: add test for trailer in log with
 nonstandard separator
Message-ID: <20201110195439.GC1987088@coredump.intra.peff.net>
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201025212652.3003036-7-anders@0x63.nu>
 <CAP8UFD1nYgqT1k1Mc=Ea3AZkb-TdhPBzXo+N+4nWgYVxEBxzRA@mail.gmail.com>
 <87y2jap4ch.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2jap4ch.fsf@0x63.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 11:12:14PM +0100, Anders Waldenborg wrote:

> > Why is this new test important?
> 
> The test that checks that 'git log --pretty=format:%(trailers)' shows
> the output in the form "Closes: 1234" even if input was "Closes #1234"
> is interesting both because it checks that this behavior is kept intact
> in the patches later in the series which modifies handling of separator
> and because it is a behavior that can be surprising and not well defined
> in documentation and those tend to be the ones that are easiest to
> accidentally break. Maybe the addition of the test should come later in
> the series where the changes that potentially could break it happen.

That makes sense, but should be in the commit message.

I also found the expected output confusing. I thought at first we were
mis-parsing to include part of the subject in the trailer, but it is
just that we put "%s" into the format argument.

> It seems like you stopped reviewing my patch series at patch 06/21. That
> is IMHO just before it starts to get interesting :)  Now I don't know if
> rest of it was rubbish or uninteresting or just there was no time to
> look at it.
> 
> I've updated according to the suggestions, but not sure if I should
> repost the series with just such small adjustments.

Reviewing this has been on my todo list, but I'd just as soon do it from
your latest version. Since it has been a while, it may make sense to
just repost with the fixes, and note in the cover letter that it didn't
get a lot of review yet.

-Peff
