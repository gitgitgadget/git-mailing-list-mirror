Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BB01FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdDPEcP (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:32:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:34210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdDPEcO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:32:14 -0400
Received: (qmail 1639 invoked by uid 109); 16 Apr 2017 04:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 04:32:14 +0000
Received: (qmail 12966 invoked by uid 111); 16 Apr 2017 04:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 00:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 00:32:12 -0400
Date:   Sun, 16 Apr 2017 00:32:12 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] doc/revisions: remove brackets from rev^-n shorthand
Message-ID: <20170416043211.cctkxmjgijk3mtps@sigill.intra.peff.net>
References: <20170416040757.32104-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170416040757.32104-1-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 12:07:57AM -0400, Kyle Meyer wrote:

> Given that other instances of "{...}" in the revision documentation
> represent literal characters of revision specifications, describing
> the rev^-n shorthand as "<rev>^-{<n>}" incorrectly suggests that
> something like "master^-{1}" is an acceptable form.

I wondered at first if this was some weird asciidoc quoting thing. But
no, the curly braces make it through to the rendered version. I agree
they are confusing.

> -The '<rev>{caret}-{<n>}' notation includes '<rev>' but excludes the <n>th
> +The '<rev>{caret}-<n>' notation includes '<rev>' but excludes the <n>th
>  parent (i.e. a shorthand for '<rev>{caret}<n>..<rev>'), with '<n>' = 1 if

This _could_ be:

  <rev>^-[<n>]

to show that the <n> parameter is optional. I think the extra
punctuation in a situation like this just makes things harder to read,
though. The text already mentions the default for <n> and gives an
example that omits it, so I think the paragraph is clear as-is (well,
after your patch removes the confusing "{}").

-Peff
