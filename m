Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8FC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC66561131
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhIUD4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:56:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhIUD4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:56:45 -0400
Received: (qmail 3437 invoked by uid 109); 21 Sep 2021 03:55:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:55:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27784 invoked by uid 1000); 21 Sep 2021 03:55:17 -0000
Date:   Mon, 20 Sep 2021 23:55:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
Message-ID: <YUlXpYR6kKiqsXx+@peff.net>
References: <cover.1631980949.git.me@ttaylorr.com>
 <xmqqr1dj9c0b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1dj9c0b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 02:24:04PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > An open question is whether the same should be done for the multi-pack-index
> > command, whose top-level support for `--[no-]progress` was released in v2.32.0
> > with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).
> 
> We do not mind too much about "breaking backward compatibility" by
> removing the mistaken "git multi-pack-index --progress cmd", I would
> say.  It's not like people would type it once every day and removing
> the "support" will break their finger-memory.

Just to play devil's advocate: it is possible that somebody scripted it,
since it is after all a pretty plumbing-ish command.

I do find it somewhat unlikely, though, given how little time it has
been around, how unlike the rest of Git it is, and how odd it seems for
scripts to ask for --progress (though maybe --no-progress is more
likely?).

So I'm OK with it, but I think "finger-memory" is not the whole story.

-Peff
