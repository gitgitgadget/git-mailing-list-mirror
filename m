Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283BC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952CC206FA
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEEVHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 17:07:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:38412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726350AbgEEVHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 17:07:42 -0400
Received: (qmail 15142 invoked by uid 109); 5 May 2020 21:07:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 21:07:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2603 invoked by uid 111); 5 May 2020 21:07:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 17:07:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 17:07:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to
 use "$x"
Message-ID: <20200505210741.GB645290@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <20200503114351.GA28680@danh.dev>
 <20200504151351.GC11373@coredump.intra.peff.net>
 <xmqqh7wviud9.fsf@gitster.c.googlers.com>
 <20200504160709.GB12842@coredump.intra.peff.net>
 <xmqqr1vy9kv0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1vy9kv0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 01:40:03PM -0700, Junio C Hamano wrote:

> A new entry in the "What's cooking" report has this:
> 
>     * jk/arith-expansion-coding-guidelines (2020-05-04) 1 commit
>      - CodingGuidelines: drop arithmetic expansion advice to use "$x"
> 
>      The coding guideline for shell scripts instructed to refer to a
>      variable with dollar-sign inside airthmetic expansion to work
>      around a bug in old versions of bash, which is a thing of the past.
>      Now we are not forbidden from writing $((var+1)).

s/bash/dash/, I think

> Writing the last sentence made me wonder if we should go one step
> further and actually encourage actively omitting the dollar-sign
> from variable reference instead.

I don't have a strong preference either way. I gave a few reasons to
prefer the dollar-less version in:

  https://lore.kernel.org/git/20200504151351.GC11373@coredump.intra.peff.net/

but I couldn't find a case where the difference really matters in
practice for otherwise-correct code. If we don't care much either way,
I'd just as soon not have a rule. We have enough rules as it is, and I
don't think either is obvious enough that somebody who is used to one
style will get confused by the other.

-Peff
