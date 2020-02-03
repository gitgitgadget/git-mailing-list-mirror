Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC39C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88EA20658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBCLGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:06:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:51182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727268AbgBCLGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 06:06:17 -0500
Received: (qmail 1983 invoked by uid 109); 3 Feb 2020 11:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 11:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23722 invoked by uid 111); 3 Feb 2020 11:14:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 06:14:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 06:06:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.25 and failed self tests on OS X
Message-ID: <20200203110616.GB4153124@coredump.intra.peff.net>
References: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
 <20200203084356.GB2164@coredump.intra.peff.net>
 <CAH8yC8=-ht7D3CyM-YoJSfW3hueaWVp5WQz2+BJOFMjmt8aDsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=-ht7D3CyM-YoJSfW3hueaWVp5WQz2+BJOFMjmt8aDsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 06:00:18AM -0500, Jeffrey Walton wrote:

> I'm wondering if Perl is the problem. I had to cut-over to OpenSSL 1.1
> due to deprecation of 1.0.2. OpenSSL 1.1 increased Perl requirements,
> so now I have to build Perl, too. Previously I was not building Perl.
> 
> I'm installing Perl 5.30.1, but it is a minimal install. I only
> install Text::Template Test::More (plus whatever else Perl installs on
> its own from cspan). However I could not install HTTP::Daemon
> HTTP::Request. There's some bug in the cspan installer. It gets stuck
> on one package and tries to download/install it over and over again.
> 
> Do you know if Git is using one of Perl's Text:: packages for the test?

I don't see any perl at all in t3902. The failing "setup" test is all
shell, and is literally just doing "echo stuff >$file_with_funny_chars"
in a loop.

-Peff
