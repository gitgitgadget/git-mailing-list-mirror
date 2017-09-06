Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17FA1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 12:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbdIFMl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 08:41:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:58518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753815AbdIFMl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 08:41:56 -0400
Received: (qmail 16037 invoked by uid 109); 6 Sep 2017 12:41:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 12:41:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21548 invoked by uid 111); 6 Sep 2017 12:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 08:42:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 08:41:53 -0400
Date:   Wed, 6 Sep 2017 08:41:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170906124153.d2kmtes7wmne7xbi@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <xmqqmv6879zh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv6879zh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 12:59:46PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In the long run we may want to drop the "tempfiles must remain forever"
> > rule. This is certainly not the first time it has caused confusion or
> > leaks. And I don't think it's a fundamental issue, just the way the code
> > is written. But in the interim, this fix is probably worth doing.
> 
> I notice you also have a series to rework the "must remain forever"
> on the list, but nevertheless let's take this one first.
> 
> Will queue.

Yes, this will conflict with that series (but the resolution should just
be to throw this one away). I'm fine with taking this in the meantime,
though it's certainly not urgent (my main goal was getting the pre-test
bits of test-lib.sh to run with leak detection on; I don't think this
was actually affecting anybody in the real world).

-Peff
