Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D78C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6073060F9B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhJZVvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:51:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:47450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235831AbhJZVvP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:51:15 -0400
Received: (qmail 10706 invoked by uid 109); 26 Oct 2021 21:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 21:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14262 invoked by uid 111); 26 Oct 2021 21:48:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 17:48:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 17:48:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Message-ID: <YXh3v6BPcTAtUMeh@coredump.intra.peff.net>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local>
 <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
 <YXhzh+pW5KvU7MEA@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXhzh+pW5KvU7MEA@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 05:30:47PM -0400, Taylor Blau wrote:

> > Bugs aside, I'd much rather see UNLEAK() annotations than external ones,
> > for all the reasons we introduced UNLEAK() in the first place:
> >
> >   - it keeps the annotations near the code. Yes, that creates conflicts
> >     when the code is changed (or the leak is actually fixed), but that's
> >     a feature. It keeps them from going stale.
> 
> I agree completely. I noted as much in my message here:
> 
>     https://lore.kernel.org/git/YXJAfICQN8s5Gm7s@nand.local/
> 
> but Ævar made it sound like his work would be made much easier without
> the conflict. Since I'm not in any kind of rush to make t5319 leak-free,
> I figured that queueing the parts of that series that wouldn't conflict
> with Ævar's ongoing work would be a net-positive.

Yeah, to be clear, if there's work in progress in an area, then _not_
annotating it (with either method) is perfectly fine with me in the
meantime.

-Peff
