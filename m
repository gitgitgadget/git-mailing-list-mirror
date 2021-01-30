Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C1CC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A7764E27
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhA3JHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:07:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:41420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233857AbhA3JHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:30 -0500
Received: (qmail 16569 invoked by uid 109); 30 Jan 2021 08:39:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jan 2021 08:39:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23241 invoked by uid 111); 30 Jan 2021 08:39:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jan 2021 03:39:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jan 2021 03:39:22 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 01/10] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YBUbOpsyl2BVqRJQ@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <6f8b70ab276c0579c957c315743fdab63462a605.1611617820.git.me@ttaylorr.com>
 <YBNWXU8xzw0087DC@coredump.intra.peff.net>
 <YBNhgX1urWjnziEZ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNhgX1urWjnziEZ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:14:41PM -0500, Taylor Blau wrote:

> > I dunno. Maybe I am being overly picky. The .idx code already does it
> > like this, and I believe the index (as in .git/index) does, too. We have
> > run into problems (as in b5007211b6 (pack-bitmap: do not use gcc packed
> > attribute, 2014-11-27)), but that was due to a more odd-sized struct, as
> > well as using sizeof().
> 
> How about a set of follow-up patches to address all of these spots at
> the same time? That would allow us to move forward here (which is safe
> to do, as you note), and address all of these instances together
> uniformly.
> 
> Sound good?

That sounds fine to me. TBH, I am probably OK if that cleanup never
happens, as long as nobody finds that it is a problem on there platform.

I do wonder if we should provide more guidance about what is OK and what
is not in CodingGuidelines, but I have a feeling it would end up to
esoteric to be generally useful.

-Peff
