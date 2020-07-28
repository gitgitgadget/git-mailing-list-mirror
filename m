Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4097C433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D866F20774
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgG1VUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:20:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgG1VUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:20:09 -0400
Received: (qmail 30215 invoked by uid 109); 28 Jul 2020 21:20:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 21:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29603 invoked by uid 111); 28 Jul 2020 21:20:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 17:20:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 17:20:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] strvec: rename struct fields
Message-ID: <20200728212008.GA1621333@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202823.GK1021513@coredump.intra.peff.net>
 <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 02:16:24PM -0700, Junio C Hamano wrote:

> > I'm actually not that fond of "items". I almost went with just:
> >
> >   const char **v;
> >
> > as the variable name which contains it usually provides sufficient
> > context. But I worried that people would consider that too inscrutable.
> 
> I'd agree that v[] is a good name.  If it is too short, I can live
> with item[], but not with items[].  Clearly we are mostly accessing
> one element at a time much more often than treating the set as a
> whole, so signaling "there are multiple things in the set" with
> a plural name is much less important than being able to say item[4]
> to name the 4th item in the collection.

I'd worry that "item" versus string_list "items" would be unfriendly
(though I am not opposed to changing string_list to match).

Your "elem" suggestion from elsewhere may be better still, but if you
are OK with "v",  that is my preference. I'll see if anybody else chimes
in, but if not, then I'd probably switch to that. :)

-Peff
