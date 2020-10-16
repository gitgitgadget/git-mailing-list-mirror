Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C9C43467
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4295207BC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393438AbgJPUHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:07:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:34776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393212AbgJPUHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:07:45 -0400
Received: (qmail 31591 invoked by uid 109); 16 Oct 2020 20:07:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 20:07:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12341 invoked by uid 111); 16 Oct 2020 20:07:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 16:07:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 16:07:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/3] test-lib: allow selecting tests by substring/glob
 with --run
Message-ID: <20201016200744.GC3355643@coredump.intra.peff.net>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
 <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
 <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
 <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
 <xmqqd01iaqif.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd01iaqif.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 01:02:16PM -0700, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > Given that t/README explicitly shows examples of space-separated lists
> > of numbers, I'm worried we're breaking long-built expectations of
> > other developers by changing IFS here.  Perhaps I could instead add
> > the following paragraph to t/README:
> 
> Unlike something that would affect end-users, I think it is OK to
> break backward compatibility one-way.  If you suddenly forbid spaces
> and force our developers to use comma and nothing else, in muscle
> memory of their fingers and/or in their scripts, in a version merged
> to 'master', as long as their new habit and updated scripts use
> comma consistently, they work fine on 'maint', right?
> 
> If there is no such "works on both sides of the flag day" choice, it
> is a different story, of course, but comma should work fine for us
> in this case.

I was just about to write the same argument. :)

-Peff
