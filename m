Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E6C1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeLQT7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 14:59:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:44086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732626AbeLQT7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 14:59:21 -0500
Received: (qmail 17925 invoked by uid 109); 17 Dec 2018 19:59:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 19:59:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6149 invoked by uid 111); 17 Dec 2018 19:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 14:58:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 14:59:19 -0500
Date:   Mon, 17 Dec 2018 14:59:19 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181217195919.GB10673@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <87mup81i3x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mup81i3x.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 12:08:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Also, parts of the v2 code, e.g. this in 685fbd3291 ("fetch-pack:
> perform a fetch using v2", 2018-03-15):
> 
> 	/* v2 supports these by default */
> 	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
> 
> Seem to have intended to turn on allowReachableSHA1InWant, not
> allowAnySHA1InWant, but apparently that's what we're doing?

That I don't know. Maybe Brandon can answer what the intent was.

I agree that turning on the reachability check would make it behavior
more or less the same as v0 (at some additional cost to walk the refs
again, but v0 smart-http already had to do that).

-Peff
