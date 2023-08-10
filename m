Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B08C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHJAKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJAKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:10:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCCE5F
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:10:21 -0700 (PDT)
Received: (qmail 22202 invoked by uid 109); 10 Aug 2023 00:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Aug 2023 00:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3006 invoked by uid 111); 10 Aug 2023 00:10:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Aug 2023 20:10:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Aug 2023 20:10:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
Message-ID: <20230810001008.GA795985@coredump.intra.peff.net>
References: <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqh6qi1byn.fsf@gitster.g>
 <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
 <xmqqila9p3j8.fsf@gitster.g>
 <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
 <xmqqcz0fnbs8.fsf@gitster.g>
 <xmqqo7jzh9mh.fsf@gitster.g>
 <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
 <xmqqy1ijkezm.fsf@gitster.g>
 <xmqqttt7kcqi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttt7kcqi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 04:38:45PM -0700, Junio C Hamano wrote:

> Locally you should be able to reproduce it by
> 
>     make
>     make -C t test-lint
> 
> before sending your patches out.

This shouldn't be necessary. "make test" is supposed to run test-lint
(and does catch this case for me). Provided you haven't overridden that
by setting TEST_LINT to some more limited set.

-Peff
