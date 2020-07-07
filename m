Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24040C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0715720708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 05:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGGFCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:02:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:50530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGFCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 01:02:48 -0400
Received: (qmail 16036 invoked by uid 109); 7 Jul 2020 05:02:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 05:02:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23535 invoked by uid 111); 7 Jul 2020 05:02:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 01:02:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 01:02:47 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 0/2] Add support for %(contents:size) in ref-filter
Message-ID: <20200707050247.GA105016@coredump.intra.peff.net>
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702140845.24945-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:08:43PM +0200, Christian Couder wrote:

> This is version 2 of a very small patch series to teach ref-filter
> about %(contents:size).
> 
> Version 1 consisted on a single patch which is available here:
> 
> https://lore.kernel.org/git/20200701132308.16691-1-chriscool@tuxfamily.org/
> 
> As suggested by Peff, I added a preparatory patch (1/2) to clean up
> the documentation about the %(contents:XXXX) format specifiers.

Thanks, I think it looks much nicer.

> The other difference with V1 is that there are more tests in patch
> 2/2. These new tests required a small helper function to be
> introduced.

I'm still not sure why %(objectsize) isn't sufficient here. Is there
some use case that's served by %(contents:size) that it wouldn't work
for? Or are we just trying to make it more discoverable when you're
looking at the contents already?

-Peff
