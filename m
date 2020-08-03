Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7017C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3022C9F
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHCU6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:46846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHCU6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:16 -0400
Received: (qmail 29381 invoked by uid 109); 3 Aug 2020 20:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2020 20:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4906 invoked by uid 111); 3 Aug 2020 20:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 16:58:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 16:58:15 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200803205815.GD2715275@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <xmqqd047wuuh.fsf@gitster.c.googlers.com>
 <87pn87smw3.fsf@osv.gnss.ru>
 <xmqqy2mvve65.fsf@gitster.c.googlers.com>
 <87y2mvqxy6.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2mvqxy6.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 11:25:05PM +0300, Sergey Organov wrote:

> I mean, why introduce --[no-]diff-merges in the first place, if we do
> agree --xxx=(none|...) is where we'd like to end up? I thought the
> answer was "it's too late", but in fact it was an answer to changing
> semantics of -m that I don't think I suggest.

Spelling out the between the lines of my answer a bit more, it was
really: I am happy enough with the topic as-is and do not want to rework
it again. But if _you_ want to do so, I have no problem with it. :)

> As a side-note, my secret hope is for pure "git log -p" to give me diff
> against first parent for all the commits, no matter how many parents
> they happen to have. This desire still sounds like a job for
> configuration option though, rather than, or in addition to,
> --diff-merges or --diff-parents? We well can later introduce a
> config to assume --diff-merges=<config> when no explicit
> --diff-merges=<value> is specified, right?

Yes, I think a config there would be reasonable as long as:

  - we have the command-line options to counteract it when necessary
    (i.e., --diff-parents or your advanced --diff-merges exists, too)

  - it only impacts porcelain "git log", and not plumbing like
    diff-tree.

-Peff
