Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A72C4363A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793BF22227
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgJNO5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:57:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:59704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJNO5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 10:57:11 -0400
Received: (qmail 17394 invoked by uid 109); 14 Oct 2020 14:57:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 14:57:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17523 invoked by uid 111); 14 Oct 2020 14:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 10:57:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 10:57:09 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        masayasuzuki@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
Message-ID: <20201014145709.GA12589@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-2-smcallis@google.com>
 <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
 <20201013205841.GA3678071@coredump.intra.peff.net>
 <alpine.DEB.2.20.2010132309250.7554@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2010132309250.7554@tvnag.unkk.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 11:16:58PM +0200, Daniel Stenberg wrote:

> Let me just inject myself here and comment on two curl things.
> 
> >  - when is _FILE going away (or has it already in some versions)?
> 
> It will be kept around *at least* for as long as libcurl supports the
> version 7 API: for the forseeable future. Posssibly decades.

Thanks. That's exactly the level of carefulness I expected from libcurl. :)

So this definitely isn't an urgent change, but given the date that
WRITEDATA was introduced, there's very little downside to using it. So
the argument for the commit message is mostly that it's a readability
improvement.

-Peff
