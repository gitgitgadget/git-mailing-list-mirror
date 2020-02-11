Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D8C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7520848
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgBKTwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:52:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:57840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728049AbgBKTwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:52:00 -0500
Received: (qmail 9430 invoked by uid 109); 11 Feb 2020 19:52:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 19:52:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1453 invoked by uid 111); 11 Feb 2020 20:00:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 15:00:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 14:51:59 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200211195159.GD2127797@coredump.intra.peff.net>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <20200210203725.GA620581@coredump.intra.peff.net>
 <20200210225528.GD190927@google.com>
 <20200211194943.GC2127797@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211194943.GC2127797@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 02:49:43PM -0500, Jeff King wrote:

> On Mon, Feb 10, 2020 at 02:55:28PM -0800, Emily Shaffer wrote:
> 
> > I tend to disagree on both counts. I'd personally rather see something
> > like 'void advise_key(enum advice, char *format, ...)'.
> 
> Yeah, I don't mind that at all. It's mutually exclusive with not making
> people add new enums when they want to add new advice types, but as you
> note we do get some code maintenance benefit by having the variables,
> even if _adding_ a new one is a slightly larger pain.

Thinking on it a bit more, one argument in favor of having enums or
variables or whatever is that we _do_ need a master list of all of the
variables in one spot: the documentation.

So one direction we _could_ go is either generating the enum from the
documentation or vice versa (or generating both from a master list).
That would give us one place to define a new key along with its
description.

-Peff
