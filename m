Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA4C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49228611CB
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 02:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhKDCGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:06:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhKDCGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 22:06:04 -0400
Received: (qmail 6535 invoked by uid 109); 4 Nov 2021 02:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 02:03:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27354 invoked by uid 111); 4 Nov 2021 02:03:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 22:03:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 22:03:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
Message-ID: <YYM/bm7cHpJeJoGT@coredump.intra.peff.net>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
 <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
 <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
 <YYJ1rA8F22SSBeNS@coredump.intra.peff.net>
 <xmqqk0hp6sno.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0hp6sno.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 10:44:11AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm happy enough with it. I don't know what the plan is for the -rc
> > period, though. AFAICT the bug is in v2.33.1, so it's not technically a
> > v2.34-rc problem. It could wait for the next maint release.
> 
> Hmph, if it was in v2.33.0 then it is not, but if it was introduced
> between v2.33.0 and v2.33.1, then it is a problem for the current
> cycle, no?

I guess it depends how you consider the cycle. It's in v2.33.1 but not
v2.33.0, so yes, anybody going from v2.33.0 to v2.34.0 will see it as a
regression. I don't have any problem with fixing it for v2.34.0, and I
think the fix Phillip provided is minimally invasive. I just didn't
consider it quite the same as a bug that had never been in a released
version at all (and I know you are often hesitant to throw too much into
the -rc part of the cycle).

-Peff
