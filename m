Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B5DC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D1C2076E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgG2AEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:04:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40734 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgG2AEc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:04:32 -0400
Received: (qmail 31707 invoked by uid 109); 29 Jul 2020 00:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 00:04:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31572 invoked by uid 111); 29 Jul 2020 00:04:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 20:04:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 20:04:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/11] strvec: drop argv_array compatibility layer
Message-ID: <20200729000430.GA1623001@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202709.GJ1021513@coredump.intra.peff.net>
 <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5za7cm8e.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 03:23:45PM -0700, Junio C Hamano wrote:

> It was more painful than I would have thought to merge this topic,
> as we seem to have gained quite a few new calling sites (it shows
> how popular and useful this API is).  Hopefully some of the merge
> conflict resolutions would be resurrected automatically from the
> rerere database ;-)

I'm not too surprised; it made a little chaos with my personal topics,
too. I'm happy to help with resolutions, but it looks like you've
already merged it to "seen", which means the worst of it is mostly over.

I did specifically wait on it until until after a release, but I think
we pretty much always have topics in flight these days. There is no
quiet time. :)

If I swap out the final patch with "s/items/v/" that may cause a
_little_ more trouble, but perhaps not quite as much (only some of the
sites access the fields directly).

-Peff
