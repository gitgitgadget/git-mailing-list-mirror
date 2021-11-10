Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E872C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D6361221
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhKJJiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:38:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:56482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhKJJiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 04:38:21 -0500
Received: (qmail 27378 invoked by uid 109); 10 Nov 2021 09:35:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 09:35:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11608 invoked by uid 111); 10 Nov 2021 09:35:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 04:35:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 04:35:31 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YYuSYz+XFWmBkIiz@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
 <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
 <CAPUEspg+NDJFAVcFs2hhcSTORb0Q-Gjcv0M+5tzqXJuBTvbT+Q@mail.gmail.com>
 <YYuBQ2mUCeEmYoLR@coredump.intra.peff.net>
 <CAPUEspjzs0ZvDGUwp=XYxdHb_t+1yx0C1epaNhhiAn6SsPeidQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspjzs0ZvDGUwp=XYxdHb_t+1yx0C1epaNhhiAn6SsPeidQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 01:15:52AM -0800, Carlo Arenas wrote:

> On Wed, Nov 10, 2021 at 12:22 AM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Nov 10, 2021 at 12:11:12AM -0800, Carlo Arenas wrote:
> >
> > > On Tue, Nov 9, 2021 at 10:02 PM Jeff King <peff@peff.net> wrote:
> > >
> > > >   - we're not really testing the desired behavior, just looking for a
> > > >     known-problem. The segfault may get fixed but we'd still have other
> > > >     bugs.
> > >
> > > This openssh bug was fixed in 8.8 per the release notes; indeed the
> > > fix[1] (which was misapplied but fixed next commit) looks familiar and
> > > it is just a straight up crasher, hence unlikely to cause other
> > > issues.
> >
> > Ah, thanks for digging. I agree that this is a small isolated bug, so
> > the prereq check I showed would be a good test for it.
> >
> > IMHO it's worth doing. It looks like 8.7 is the only affected openssh
> > version, but it is likely to cause confusion right when we release.
> 
> It was discussed[1] before, and I think the plan was to at least
> mention the brokenness with 8.7 in the release notes, but guess I
> dropped the ball by not raising it earlier.

Ah, thanks. I looked in the archive, but assumed any mention would have
been more recent (not realizing that Debian's packaging was simply
lagging the upstream releases by quite a bit).

-Peff
