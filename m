Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E4FC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 05:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039D42073D
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 05:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLLFpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:45:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:44774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726775AbfLLFpU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 00:45:20 -0500
Received: (qmail 10388 invoked by uid 109); 12 Dec 2019 05:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Dec 2019 05:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11872 invoked by uid 111); 12 Dec 2019 05:49:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Dec 2019 00:49:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Dec 2019 00:45:18 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/9] ewah/bitmap: introduce bitmap_word_alloc()
Message-ID: <20191212054518.GA1213659@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-4-chriscool@tuxfamily.org>
 <20191209062841.GC40570@coredump.intra.peff.net>
 <CAP8UFD3PwuSyJ0kjiYKo_UbgqzC1hjJS0rkBjhdfuNmC6hvGvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3PwuSyJ0kjiYKo_UbgqzC1hjJS0rkBjhdfuNmC6hvGvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 02:50:40PM +0100, Christian Couder wrote:

> > I wonder if "new_with_world_alloc" or "new_with_size" would make it more
> > obvious that this is also a constructor, though.
> 
> bitmap_new_with_word_alloc() feels a bit verbose to me for such a
> short function, so for now I kept bitmap_word_alloc().

OK, that's fine with me...

> I think that if we really want to use "new" for constructors then a
> better solution would be something like renaming bitmap_new(void) to
> bitmap_new_default(void) and bitmap_word_alloc(size_t word_alloc) to
> bitmap_new(size_t word_alloc).

...but that also would be fine with me.

-Peff
