Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F09C4332B
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECF064E05
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhCRVxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhCRVxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:53:22 -0400
Received: (qmail 1515 invoked by uid 109); 18 Mar 2021 21:53:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Mar 2021 21:53:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25416 invoked by uid 111); 18 Mar 2021 21:53:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Mar 2021 17:53:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Mar 2021 17:53:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH] t: annotate !PTHREADS tests with !FAIL_PREREQS
Message-ID: <YFPL0F4C7mfDazOW@coredump.intra.peff.net>
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
 <YFC33vfLb36pRCO6@nand.local>
 <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
 <YFJCUOCQGKHX2/So@coredump.intra.peff.net>
 <YFKG52H090l/GbP7@coredump.intra.peff.net>
 <xmqqblbgrwkg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblbgrwkg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 02:17:19PM -0700, Junio C Hamano wrote:

> In short, the biggest mistake in the current FAIL_PREREQS design is
> to hook into test_have_prereq while the stated objective only needs
> to futz with the prerequisite given to the test_expect_* functions,
> I would think.

Yeah, that matches my intuition of the problem, too.

-Peff
