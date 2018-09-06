Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8DB1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeIFXx7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:53:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726031AbeIFXx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:53:59 -0400
Received: (qmail 26453 invoked by uid 109); 6 Sep 2018 19:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:17:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7001 invoked by uid 111); 6 Sep 2018 19:17:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:17:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:17:05 -0400
Date:   Thu, 6 Sep 2018 15:17:05 -0400
From:   Jeff King <peff@peff.net>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
Message-ID: <20180906191704.GA26575@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
 <87pnxqrags.fsf@evledraar.gmail.com>
 <20180906145708.GA1209@sigill.intra.peff.net>
 <dea58ad8-4e2a-955a-8dc6-b93e9592398c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dea58ad8-4e2a-955a-8dc6-b93e9592398c@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 09:05:50PM +0200, Tim Schumacher wrote:

> On 06.09.18 16:57, Jeff King wrote:
> > On Thu, Sep 06, 2018 at 04:01:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > If we don't have some test for these sort of aliasing loops that fails
> > > now, we really should add that in a 1/2 and fix it in this patch in 2/2.
> > 
> > Yes, I'd agree that this is worth adding a test (especially if the
> > output routines get more complex).
> 
> I'll try to come up with a few tests (or one at this point, as we only have
> a solution for internal aliases so far) and put them as 1/2. However, I don't know
> what file I should put those tests into. t0001-init and t1300-config both seem
> to test aliases, but I'm unsure if the new tests should go into one of those
> files or a completely new one that is dedicated to aliases.

Yeah, I don't think there's a good place right now. It probably make
sense to start a new one (t0014-alias, maybe? This seems like a basic
functionality that should come early in the suite).

-Peff
