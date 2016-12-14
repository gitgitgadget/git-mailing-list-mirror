Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00EE1FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 11:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbcLNLYF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 06:24:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:56292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932242AbcLNLYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 06:24:04 -0500
Received: (qmail 20281 invoked by uid 109); 14 Dec 2016 11:24:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 11:24:03 +0000
Received: (qmail 24079 invoked by uid 111); 14 Dec 2016 11:24:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 06:24:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 06:24:01 -0500
Date:   Wed, 14 Dec 2016 06:24:01 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, stefan.naewe@atlas-elektronik.com,
        gitter.spiros@gmail.com
Subject: Re: [RFC/PATCHv2] Makefile: add cppcheck target
Message-ID: <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <20161214092731.29076-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214092731.29076-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 10:27:31PM +1300, Chris Packham wrote:

> Changes in v2:
> - only run over actual git source files.
> - omit any files in t/

I actually wonder if FIND_SOURCE_FILES should be taking care of the "t/"
thing. I think "make tags" finds tags in t4051/appended1.c, which is
just silly.

> - introduce CPPCHECK_FLAGS which can be overridden in the make command
>   line. This also uses a GNU make-ism to allow CPPCHECK_ADD to specify
>   additional checks to be enabled.

The GNU-ism is fine; we already require GNU make to build.

The patch itself is OK to me, I guess. The interesting part will be
whether people start actually _using_ cppcheck and squelching the false
positives. I'm not sure how I feel about the in-code annotations. I'd
have to see a patch first.

-Peff
