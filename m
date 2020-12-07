Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99178C1B087
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7056C238E2
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLGTGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:06:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:55190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGTGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:06:17 -0500
Received: (qmail 8942 invoked by uid 109); 7 Dec 2020 19:05:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:05:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25479 invoked by uid 111); 7 Dec 2020 19:05:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:05:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:05:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X858/2MkKU1Grqby@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
 <xmqq1rg5dyp4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rg5dyp4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 01:54:31PM -0800, Junio C Hamano wrote:

> >> +static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)
> 
> Perhaps the function can make it clear that it expects to be fed a
> sorted array in its name, which would be even better?

The name is already pretty clunky. I'm not thrilled with the idea of
making it even longer. :)

IMHO it's unlikely for somebody to stumble on it and not read the
comment or look at an existing call, if only because the function you'd
probably reach for immediately is more like oid_array_for_each_unique().

-Peff
