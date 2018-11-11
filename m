Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F268B1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeKKRQY (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:16:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:47746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727334AbeKKRQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:16:24 -0500
Received: (qmail 2021 invoked by uid 109); 11 Nov 2018 07:28:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:28:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32068 invoked by uid 111); 11 Nov 2018 07:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:27:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:28:35 -0500
Date:   Sun, 11 Nov 2018 02:28:35 -0500
From:   Jeff King <peff@peff.net>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Upcast size_t variables to uintmax_t when printing
Message-ID: <20181111072835.GL30850@sigill.intra.peff.net>
References: <20181111070504.12858-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111070504.12858-1-tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 08:05:04AM +0100, tboegi@web.de wrote:

> From: Torsten Bögershausen <tboegi@web.de>
> 
> When printing variables which contain a size, today "unsigned long"
> is used at many places.
> In order to be able to change the type from "unsigned long" into size_t
> some day in the future, we need to have a way to print 64 bit variables
> on a system that has "unsigned long" defined to be 32 bit, like Win64.
> 
> Upcast all those variables into uintmax_t before they are printed.
> This is to prepare for a bigger change, when "unsigned long"
> will be converted into size_t for variables which may be > 4Gib.

I like the overall direction. I feel a little funny doing this step now,
and not as part of a series to convert individual variables. But I
cannot offhand think of any reason that it would behave badly even if
the other part does not materialize

-Peff
