Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71882C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517952465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLSRvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:51:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:50394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726897AbfLSRvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:51:16 -0500
Received: (qmail 25440 invoked by uid 109); 19 Dec 2019 17:51:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Dec 2019 17:51:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5855 invoked by uid 111); 19 Dec 2019 17:55:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Dec 2019 12:55:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Dec 2019 12:51:15 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t4015: improve coverage of function context test
Message-ID: <20191219175115.GA677976@coredump.intra.peff.net>
References: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
 <86fbb0fd-6b77-5d11-69cd-f0994a8ed759@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86fbb0fd-6b77-5d11-69cd-f0994a8ed759@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 06:35:43PM +0100, René Scharfe wrote:

> Add a test that includes an actual function line in the test file to
> check if context is expanded to include the whole function, and add an
> ignored change before function context to check if that one stays hidden
> while the originally ignored change within function context is shown.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: René Scharfe <l.s.r@web.de>

Thanks, the patch looks good.

Maybe worth noting in the commit message why there are two tests.
Something like:

  This differs from the existing test, which is concerned with the case
  where there is no function line at all in the file (and we might look
  past the beginning of the file).

-Peff
