Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97BC51F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJRPII (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:08:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:44470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726131AbeJRPII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 11:08:08 -0400
Received: (qmail 17619 invoked by uid 109); 18 Oct 2018 07:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 07:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27699 invoked by uid 111); 18 Oct 2018 07:07:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 03:07:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 03:08:32 -0400
Date:   Thu, 18 Oct 2018 03:08:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wunused-function
Message-ID: <20181018070831.GA29542@sigill.intra.peff.net>
References: <20181018070522.GA29499@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181018070522.GA29499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 03:05:22AM -0400, Jeff King wrote:

> diff --git a/config.mak.dev b/config.mak.dev
> index 92d268137f..bbeeff44fe 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -34,7 +34,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
>  CFLAGS += -Wno-empty-body
>  CFLAGS += -Wno-missing-field-initializers
>  CFLAGS += -Wno-sign-compare
> -CFLAGS += -Wno-unused-function
>  CFLAGS += -Wno-unused-parameter

By the way, I wondered how close we were to being able to use
-Wunused-parameter. The answer is "not very".

However, I've been digging into the results, and it does find a number
of bugs. I'm 168 (rough) patches deep right now, and I have it compiling
cleanly. Most of those are just annotations, but I'll start posting
fixes as I organize and clean them up.

-Peff
