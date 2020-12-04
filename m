Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F64CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B3C122CBE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgLDUpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:45:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:52152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgLDUpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:45:13 -0500
Received: (qmail 635 invoked by uid 109); 4 Dec 2020 20:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 20:44:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15680 invoked by uid 111); 4 Dec 2020 20:44:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 15:44:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 15:44:31 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qfr2B0OfaySjPh@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 02:18:45PM -0500, Eric Sunshine wrote:

> > + * Find the next unique oid in the array after position "cur". You
> > + * can use this to iterate over unique elements, like:
> > + *
> > + *   size_t i;
> > + *   oid_array_sort(array);
> > + *   for (i = 0; i < array->nr; i = oid_array_next_unique(array, i))
> > + *     printf("%s", oid_to_hex(array->oids[i]);
> > + *
> > + * Non-unique iteration can just increment with "i++" to visit each element.
> > + */
> 
> Minor: I see that the example code sorts the array first -- which is
> necessary, as explained in the commit message -- but I wonder if it is
> worth calling out explicitly in the prose:
> 
>     Find the next unique oid in the array after position `cur`.
>     The array must be sorted for this to work. You can use
>     this to iterate over unique elements like this:

Thanks, that makes sense; I picked up your wording here.

-Peff
