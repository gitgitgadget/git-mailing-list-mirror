Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E984C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A8461A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhCXT1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:27:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhCXT1U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:27:20 -0400
Received: (qmail 14630 invoked by uid 109); 24 Mar 2021 19:27:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 19:27:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21152 invoked by uid 111); 24 Mar 2021 19:27:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 15:27:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 15:27:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 4/4] Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
Message-ID: <YFuSl6KjOtiqLgFA@coredump.intra.peff.net>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <51b782bb9b6270a0b1f69df8fe9e2e4f5aead2a2.1616414951.git.avarab@gmail.com>
 <9b1a8473-9117-abcd-497f-d217fa03813e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b1a8473-9117-abcd-497f-d217fa03813e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 07:05:12PM +0100, René Scharfe. wrote:

> Am 22.03.21 um 13:11 schrieb Ævar Arnfjörð Bjarmason:
> > Change the "xargs -n X" limit for running spatch from 1 to 8, as
> > suggested by Jeff King[1]. Now that we're not using --all-includes
> > anymore this is going to take much less memory, so bumping the limit
> > should be OK.
> 
> But --all-includes is still used, so does this patch still make sense?

I got similar results on the state before this series (using just
--all-includes). So presumably it holds up. I'm not at all convinced,
though, that this isn't simply unique to my system, or to a version of
spatch.

-Peff
