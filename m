Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5338361B4C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhKOPai (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:30:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:59080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235326AbhKOPae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:34 -0500
Received: (qmail 13236 invoked by uid 109); 15 Nov 2021 15:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 15:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11746 invoked by uid 111); 15 Nov 2021 15:27:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 10:27:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 10:27:36 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YZJ8aDNVentnbalp@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
 <xmqqwnlemwcy.fsf@gitster.g>
 <YY17rBFIdDl+H47I@coredump.intra.peff.net>
 <YZJ3hZkX9YjNBAdk@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZJ3hZkX9YjNBAdk@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 04:06:45PM +0100, Patrick Steinhardt wrote:

> Sorry, but I'm currently completely loaded with work and thus didn't
> find the capacity to have a deeper look yet and will probably not find
> the time for a few more days. So the earliest I can have a look at this
> is probably beginning next week.
> 
> With that in mind, I'm happy to have this change reverted for now, as it
> is...

Thanks for chiming in (and again, sorry for bringing this up so late in
the cycle).

> > > We probably should revert this step as it can affect correctness in
> > > a big way, but I wonder if the other steps in the same series, or
> > > other topic that came later, rely on it.
> > 
> > I looked them over, and I think this is pretty independent (with the
> > exception of the refactoring of the no_walk/unsorted flags, but
> > obviously that had to come first).
> 
> .. completely independent of the other patches in this series and can be
> reverted on its own. Only question is whether we also want to revert the
> patch introducing this option in the first place given that it would end
> up without a user afterwards.

It looks like Junio queued a revert of the whole patch in a7df4f52af
(Revert "connected: do not sort input revisions", 2021-11-11), which is
on "master". So I think we should have a clean slate to look at this in
the next cycle.

-Peff
