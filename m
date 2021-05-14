Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDCC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E12613C8
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhENFbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 01:31:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhENFbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 01:31:21 -0400
Received: (qmail 16844 invoked by uid 109); 14 May 2021 05:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 May 2021 05:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30480 invoked by uid 111); 14 May 2021 05:30:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 May 2021 01:30:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 May 2021 01:30:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
Message-ID: <YJ4K4UXh6sva5I4H@coredump.intra.peff.net>
References: <cover.1620928059.git.martin.agren@gmail.com>
 <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 08:17:42PM +0200, Martin Ågren wrote:

> -. A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
> -  value and store it in dstref" in fetch and push operations.
> +. A colon `:` is used as in `srcref:dstref` to mean "use the value
> +  of `srcref` and store it in `dstref`" in fetch and push operations.
>    It may also be used to select a specific object such as with
> -  'git cat-file': "git cat-file blob v1.3.3:refs.c".
> +  'git cat-file': `git cat-file blob v1.3.3:refs.c`.

I'd perhaps write:

  `srcref`'s value...

but I'm a little afraid to see how it is handled by the various parsers
(I'd write it because it does look OK in most markdown parsers I've
used).

That said, I think in this case "value of `srcref`" is actually an
improvement to the text (but I wouldn't say the same of the earlier
patches, which feel like they are making things clunkier).

-Peff
