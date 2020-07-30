Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B148C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605102082E
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgG3AbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:31:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgG3AbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:08 -0400
Received: (qmail 10860 invoked by uid 109); 30 Jul 2020 00:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2020 00:31:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13190 invoked by uid 111); 30 Jul 2020 00:31:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 20:31:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 20:31:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730003107.GC2996059@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <xmqqv9i6814y.fsf@gitster.c.googlers.com>
 <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
 <20200730001442.GA2996059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730001442.GA2996059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 08:14:42PM -0400, Jeff King wrote:

> I think this will be matching branch names, not fully qualified refs.
> Seems reasonable, but we should be sure to document that.

Also, I guess it would see "HEAD" when we're on a detached HEAD. That's
slightly ambiguous to match, in that you _could_ have refs/heads/HEAD,
but we try to make that hard to do. So it's probably not worth worrying
about.

-Peff
