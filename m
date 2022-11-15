Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC2C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKOR0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiKOR02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:26:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289326125
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:26:26 -0800 (PST)
Received: (qmail 18610 invoked by uid 109); 15 Nov 2022 17:26:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Nov 2022 17:26:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23706 invoked by uid 111); 15 Nov 2022 17:26:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Nov 2022 12:26:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Nov 2022 12:26:25 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3PLwW7krP0eJS6+@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
 <Y27KL0Yg7nzdQ+HC@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y27KL0Yg7nzdQ+HC@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 05:18:23PM -0500, Taylor Blau wrote:

> On Fri, Nov 11, 2022 at 07:49:49AM +0100, Patrick Steinhardt wrote:
> > Patrick Steinhardt (7):
> >   refs: fix memory leak when parsing hideRefs config
> >   refs: get rid of global list of hidden refs
> >   revision: move together exclusion-related functions
> >   revision: introduce struct to handle exclusions
> >   revision: add new parameter to exclude hidden refs
> >   rev-parse: add `--exclude-hidden=` option
> >   receive-pack: only use visible refs for connectivity check
> 
> The new version is looking pretty good to my eyes, though I would like
> to hear from Peff, too, since he caught a few things that I missed in
> the previous rounds.

This looks good to me, too. There's a typo (s/seciton/section/) in the
commit message of patch 6, but definitely not worth a re-roll. :)

I admit I didn't think _too_ deeply about the interaction with
namespaces, and whether there are any corner cases. I was happy to see
the tests there, and I assume in writing them that Patrick matched how
receive-pack, etc, behave.

-Peff
