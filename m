Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCDCC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FA321655
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507578AbgJ0HYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:38290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgJ0HYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:24:46 -0400
Received: (qmail 14335 invoked by uid 109); 27 Oct 2020 07:24:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:24:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15080 invoked by uid 111); 27 Oct 2020 07:24:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:24:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:24:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     VenomVendor <info@venomvendor.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
Message-ID: <20201027072445.GF3005508@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
 <20201023072630.GA2918369@coredump.intra.peff.net>
 <xmqqft60gbci.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft60gbci.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 10:12:45AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > By the way, I wondered why we needed to do this parsing at all. The
> > patch below does this in a much simpler way. It's a little bit ugly, I
> > think, because we have to call getenv() ourselves. But that's the way
> > fmt_ident() has always worked. We could probably improve that now that
> > it takes a whose_ident flag (before that, it had no idea if we wanted
> > author or committer ident).
> >
> > This is on top of the fixes (but we'd perhaps just want to do those on
> > 'maint' as the minimal fix).
> 
> This could be the nicest step in the whole series, but let's leave
> it out of the branch meant for 'maint'.

I think that's sensible. Looks like you queued it separately already, so
thank you. :)

-Peff
