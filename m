Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A45C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833C62074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXTDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:03:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHXTDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:03:49 -0400
Received: (qmail 23032 invoked by uid 109); 24 Aug 2020 19:03:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 19:03:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16079 invoked by uid 111); 24 Aug 2020 19:03:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 15:03:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 15:03:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Optionally skip linking/copying the built-ins
Message-ID: <20200824190348.GA677706@coredump.intra.peff.net>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
 <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
 <xmqqr1rv50x1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1rv50x1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 11:55:22AM -0700, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Johannes Schindelin (3):
> >   msvc: copy the correct `.pdb` files in the Makefile target `install`
> 
> Thanks---I was wondering what would happen to these files with
> Peff's "trimmed down" topic.  My understanding is that we are still
> waiting for a reroll of that topic but without the "drop all the .pdb"
> step from it.

I hadn't planned to re-roll. My topic corrects the inaccuracies in the
pdb list (both in the first patch, but also removing entries as they
become builtins in the later patches). So it will conflict with Dscho's
first patch here, but the resolution is easy (take his side, since it
replaces the list entirely).

However, I don't mind re-rolling without touching the pdb list at all if
you prefer. It makes the state after my series a little more broken,
but it seems that nobody cares that much, and if we're pretty sure
Dscho's patch will graduate, then it will be moot anyway.

-Peff
