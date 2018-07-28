Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEEEF1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 09:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeG1K0d (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 06:26:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:33998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726173AbeG1K0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 06:26:32 -0400
Received: (qmail 8229 invoked by uid 109); 28 Jul 2018 09:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Jul 2018 09:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1956 invoked by uid 111); 28 Jul 2018 09:00:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 28 Jul 2018 05:00:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2018 05:00:45 -0400
Date:   Sat, 28 Jul 2018 05:00:45 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
Message-ID: <20180728090044.GA16454@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org>
 <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
 <20180724095843.GB3578@sigill.intra.peff.net>
 <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
 <20180727131333.GC18599@sigill.intra.peff.net>
 <CAGZ79kYK3QkaSEinuq_Js5thVgY2-MyrN60W-Dws1p4eK73hHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYK3QkaSEinuq_Js5thVgY2-MyrN60W-Dws1p4eK73hHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 10:22:09AM -0700, Stefan Beller wrote:

> > That would solve the problem that fetching torvalds/linux from GitHub
> > yields a bigger pack than fetching it from kernel.org. But again, it's
> > making that root fork weirdly magical. People who fetch solely from
> > other forks won't get any benefit (and may even see worse packs).
> 
> Thanks for the explanation.
> I think this discussion just hints at me being dense reading the
> documentation. After all I like the concept.

I actually think it hints that the documentation in the commits
themselves is not adequate. :)

-Peff
