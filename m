Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB787C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D12610A4
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJLV5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:57:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235541AbhJLV5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:57:43 -0400
Received: (qmail 1802 invoked by uid 109); 12 Oct 2021 21:55:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:55:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18471 invoked by uid 111); 12 Oct 2021 21:55:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:55:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:55:40 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Alex Waite <alex@waite.eu>,
        git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWYEXFkbg1LiVUfn@coredump.intra.peff.net>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
 <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 09:48:33PM +0000, brian m. carlson wrote:

> I am also not eager to see additional bug reports for this case that
> will need to be fixed under the precedent that we accepted a patch to
> fix it before.  If there's a concern that rejecting these hostnames
> altogether would break existing users, then we can just do nothing, and
> tell users that their syntax is not valid and they need to fix their
> hostnames.  This rule has been documented since before ISO standardized
> C, so it shouldn't be new to anyone deploying systems or DNS.
> 
> So I'm fine with doing nothing, or rejecting these hostnames, but not
> allowing more lenient syntax, because it will probably be broken
> somewhere and we (or someone else in the ecosystem) will have to deal
> with it again down the line.

FWIW, I'm fine with doing nothing. But it will still come back further
down the line, because it _does_ work most of the way, and has for a
long time.

-Peff
