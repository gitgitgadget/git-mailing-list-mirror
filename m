Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355AC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D58564DE7
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhA2UbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:31:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:40822 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233328AbhA2U2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:28:43 -0500
Received: (qmail 3708 invoked by uid 109); 29 Jan 2021 20:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 20:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8830 invoked by uid 111); 29 Jan 2021 20:27:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 15:27:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 15:27:55 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] p5303: avoid sed GNU-ism
Message-ID: <YBRvy3s5gnsrIBEB@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
 <xmqqft2ktnpj.fsf@gitster.c.googlers.com>
 <YBRi4v/AeDD/Zc9X@coredump.intra.peff.net>
 <YBRqOI84MkU+HNzt@coredump.intra.peff.net>
 <CAPig+cTc3RGEu4anOmnYBBQxXgB0UL8Z_vJfnV=FoNTOFYEpTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTc3RGEu4anOmnYBBQxXgB0UL8Z_vJfnV=FoNTOFYEpTQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:19:31PM -0500, Eric Sunshine wrote:

> On Fri, Jan 29, 2021 at 3:07 PM Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] p5303: avoid sed GNU-ism
> >
> > Using "1~5" isn't portable. Nobody seems to have noticed, since perhaps
> > people don't tend to run the perf suite on more exotic platforms. Still,
> > it's better to set a good example.
> 
> It's not just exotic platforms on which this can be a problem. BSD
> lineage `sed`, such as stock `sed` on macOS, doesn't understand this
> notation.
> 
> Thanks for eliminating this particular GNU-ism.

OK, then I'm doubly surprised nobody has noticed and complained about
this. :)

-Peff
