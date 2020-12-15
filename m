Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59DC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A3122D07
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgLOVlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:41:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:33684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgLOVhs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:37:48 -0500
Received: (qmail 17642 invoked by uid 109); 15 Dec 2020 21:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 21:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19887 invoked by uid 111); 15 Dec 2020 21:37:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Dec 2020 16:37:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Dec 2020 16:37:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
Message-ID: <X9ksfyBujBrYWmAW@coredump.intra.peff.net>
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
 <xmqqeejraiw7.fsf@gitster.c.googlers.com>
 <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
 <CABPp-BEnkQahdVJP+rfQho+S_hcS3y-o3cZBUMhU-EQHjJTLOQ@mail.gmail.com>
 <xmqqzh2e7p6l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh2e7p6l.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 01:08:18PM -0800, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > Doh, sorry for the bug.  Yeah, that's the exact fix I'd make.  Junio,
> > do you want to just use the changes you've already got, or would you
> > like me to submit a patch removing these two 'return's?
> 
> Nah, the other half of the reported issue was mine, so let me see if
> I can quickly whip up a two-patch series.

Thanks, both look OK to me. I probably would have kept "return -1" in
the setitimer one, but I doubt it really matters much either way.

-Peff
