Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22293C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2609206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEDXgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:36:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36924 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727982AbgEDXgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:36:35 -0400
Received: (qmail 3644 invoked by uid 109); 4 May 2020 23:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 23:36:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23650 invoked by uid 111); 4 May 2020 23:36:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 19:36:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 19:36:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200504233634.GB39798@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504215824.GC45250@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 03:58:24PM -0600, Taylor Blau wrote:

> Huh; I'm not sure that I'm sold on the idea of a 'for-ci' namespace
> here. In addition to running 'make test' on patches locally before I
> send them, I find it tremendously convenient for GitHub to run them for
> me when I push 'tb/' branches up to 'ttaylorr/git'.
> 
> So, while the above is more-or-less what I'd expect the monitored list
> of branches to look like (at least, ignoring the missing 'for-ci/**'
> bits), I wish that I could also build every branch that I push up to my
> fork.
> 
> Of course, I don't want to maintain a one-patch difference between
> ttaylorr/git@master and git/git@master, so I wonder if we could get a
> little more creative with these rules and actually run Actions on
> *every* branch, but introduce a new first step which stops the rest of
> the actions run (so that in practice we're not running CI on
> non-integration branches in Junio's tree).

I don't understand what that would accomplish. If we ran the actions on
every branch but stopped the run, then you wouldn't get the CI results
you want. What am I missing?

-Peff
