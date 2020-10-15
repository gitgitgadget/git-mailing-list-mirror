Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09644C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983E6221EB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgJOTGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:06:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:33324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgJOTGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:06:39 -0400
Received: (qmail 24025 invoked by uid 109); 15 Oct 2020 19:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32001 invoked by uid 111); 15 Oct 2020 19:06:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:06:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:06:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
Message-ID: <20201015190638.GC1108210@coredump.intra.peff.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
 <20201015190532.GB1108210@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015190532.GB1108210@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 03:05:32PM -0400, Jeff King wrote:

> Personally I make a branch for almost every patch/series I submit, no
> matter how trivial[1]. And then part of my daily ritual is seeing which

I forgot my footnote. It wasn't very interesting, but to avoid
confusion, it was:

  I very occasionally will not bother to create a branch, but my mental
  checklist for that is always: will I be sad if this patch gets lost in
  the discussion and never applied? And the answer is almost always
  "yes", so I create a branch.

-Peff
