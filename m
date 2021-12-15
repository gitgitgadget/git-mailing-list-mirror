Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717DDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 17:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhLORRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:17:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:52524 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235266AbhLORRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 12:17:30 -0500
Received: (qmail 17979 invoked by uid 109); 15 Dec 2021 17:17:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Dec 2021 17:17:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6706 invoked by uid 111); 15 Dec 2021 17:17:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Dec 2021 12:17:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Dec 2021 12:17:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
Message-ID: <YbojKafkC/JcX4d1@coredump.intra.peff.net>
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
 <20211212163207.GA3400@szeder.dev>
 <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
 <20211212201441.GB3400@szeder.dev>
 <xmqqo85kcp99.fsf@gitster.g>
 <YbjJuh4dVijL7jw4@coredump.intra.peff.net>
 <xmqqh7b994tw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7b994tw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 09:05:15AM -0800, Junio C Hamano wrote:

> Still.  I wonder if keeping BASH_XTRACEFD helps developers, when
> they need to diagnose a new breakage?  If their new test fails only
> in the "dash -x" run but not "bash -x" at the CI, for example?

I have done that, but usually only after realizing that "./t1234-foo.sh"
passes and "./t1234-foo.sh -x" does not. So I think just tweaking use of
"-x" would be the main tool.

-Peff
