Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E71C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915452065D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKJAb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:31:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:52240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKJAb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:31:28 -0500
Received: (qmail 5215 invoked by uid 109); 10 Nov 2020 00:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 00:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29327 invoked by uid 111); 10 Nov 2020 00:31:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 19:31:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 19:31:27 -0500
From:   Jeff King <peff@peff.net>
To:     Daniel Gurney <dgurney99@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
Message-ID: <20201110003127.GA1268480@coredump.intra.peff.net>
References: <20201107234751.10661-1-dgurney99@gmail.com>
 <20201108095739.23144-1-dgurney99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201108095739.23144-1-dgurney99@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 08, 2020 at 11:57:41AM +0200, Daniel Gurney wrote:

> Modern MSVC or Windows versions don't support big-endian, so it's
> unnecessary to consider architectures when using it.

This made me wonder if we support any non-modern versions (which would
be negatively impacted).

From the earlier thread at [1], it sounds like probably not, but I
wonder if we can offer a stronger argument there (or just define
"modern" a little more clearly).

-Peff

[1] https://lore.kernel.org/git/20201107224747.GF6252@camp.crustytoothpaste.net/
