Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6FC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7D364FBB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCKCYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:24:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:59762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCKCYa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:24:30 -0500
Received: (qmail 8015 invoked by uid 109); 11 Mar 2021 02:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 02:24:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28557 invoked by uid 111); 11 Mar 2021 02:24:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 21:24:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 21:24:29 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] t7003: test ref rewriting explicitly
Message-ID: <YEl/XRnbu5FBV+PE@coredump.intra.peff.net>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
 <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
 <87wnueh7nu.fsf@evledraar.gmail.com>
 <YEl4eAR+rsayCpfT@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEl4eAR+rsayCpfT@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 01:55:04AM +0000, brian m. carlson wrote:

> On 2021-03-11 at 00:10:29, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Wed, Mar 10 2021, Jeff King wrote:
> > 
> > 
> > I've read it all over, looks good to me.
> > 
> > > Note these all pass currently, but the latter two will fail when run
> > > with GIT_TEST_DEFAULT_HASH=sha256.
> > 
> > I don't know if anyone relies on that. Probably fine to have this as-is.
> 
> Our CI runs that way, and I always use that mode.  Are you saying that
> these will always fail in that mode, or that they will pass at the end
> of the series?

The latter; everything passes at the end. The only thing that is hurt is
if we care about bisecting the tests with GIT_TEST_DEFAULT_HASH set

-Peff
