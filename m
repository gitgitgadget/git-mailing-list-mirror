Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC190C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B222D21734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRRVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:21:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRRVe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:21:34 -0400
Received: (qmail 11072 invoked by uid 109); 18 Sep 2020 17:21:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 17:21:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23045 invoked by uid 111); 18 Sep 2020 17:21:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 13:21:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 13:21:33 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918172133.GC183026@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
 <20200918171950.GA183026@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918171950.GA183026@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 01:19:50PM -0400, Jeff King wrote:

> Getting back to the overall feature, this is definitely something that
> has come up before. The last I know of is:
> 
>   https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
> 
> which everybody seemed to like the direction of; I suspect the original
> author (cc'd) just never got around to it again. Compared to this
> approach, it uses a command-line option to avoid dereferencing symlinks.
> That puts an extra burden on the caller to pass the option, but it's way
> less magical; you could drop all of the "does this look like a symlink
> to a pipe" heuristics. It would also be much easier to test. ;)

Of course I forgot to add the cc. +cc brian.
