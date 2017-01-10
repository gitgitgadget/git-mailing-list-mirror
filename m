Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECF4205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 06:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765162AbdAJG6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 01:58:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:37350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765158AbdAJG6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 01:58:21 -0500
Received: (qmail 21079 invoked by uid 109); 10 Jan 2017 06:58:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 06:58:20 +0000
Received: (qmail 11261 invoked by uid 111); 10 Jan 2017 06:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 01:59:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2017 01:58:16 -0500
Date:   Tue, 10 Jan 2017 01:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
Message-ID: <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-2-hansenr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170110004031.57985-2-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 07:40:30PM -0500, Richard Hansen wrote:

> Document that a relative pathname for diff.orderFile is interpreted as
> relative to the top-level work directory.
> 
> Signed-off-by: Richard Hansen <hansenr@google.com>
> ---
>  Documentation/diff-config.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 58f4bd6af..875212045 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -101,6 +101,8 @@ diff.noprefix::
>  diff.orderFile::
>  	File indicating how to order files within a diff, using
>  	one shell glob pattern per line.
> +	If `diff.orderFile` is a relative pathname, it is treated as
> +	relative to the top of the work tree.
>  	Can be overridden by the '-O' option to linkgit:git-diff[1].

What happens in a bare repository?

I'm guessing it's relative to the top-level of the repository, but we
should probably spell it out.

The other case is --no-index when we are not in a repository at all, but
that should just be relative to the current directory, which isn't
really worth mentioning.

-Peff
