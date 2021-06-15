Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D6C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960876143D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFOLZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:55982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhFOLZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:25:59 -0400
Received: (qmail 7619 invoked by uid 109); 15 Jun 2021 11:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 11:23:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13832 invoked by uid 111); 15 Jun 2021 11:23:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 07:23:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 07:23:53 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Message-ID: <YMiNyVUjeLrWt9iH@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
 <60c715dd9939e_436208f3@natae.notmuch>
 <8735tk22if.fsf@evledraar.gmail.com>
 <YMdm5XayUfp4/atY@coredump.intra.peff.net>
 <87r1h4z8k0.fsf@evledraar.gmail.com>
 <YMiKlmY3B/1cDrr8@coredump.intra.peff.net>
 <3caba1f7-026d-827e-d97a-8b5708dd9765@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3caba1f7-026d-827e-d97a-8b5708dd9765@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 06:21:00PM +0700, Bagas Sanjaya wrote:

> On 15/06/21 18.10, Jeff King wrote:
> > I think it's just that the aggregation script was never meant to signal
> > to "make". In a regular "make test" (not using prove), each individual
> > test script is a dependency than can fail on its own. That means a
> > failure of any of them will signal "make" to fail the overall operation.
> > 
> Only one failure can trigger FTBFS when make test, right?

I'm not sure I understand what your question means. I know that "FTBFS"
means "failed to build from source", but that is not a term we use in
the Git project. So if you are asking whether "make test" will exit
non-zero if a single test fails, then yes.

If you're asking whether a Debian package would consider that an FTBFS,
then probably yes, but it depends on whether they run the tests.

-Peff
