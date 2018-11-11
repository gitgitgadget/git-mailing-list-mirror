Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB351F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeKKQVl (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:21:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:47544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727307AbeKKQVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:21:41 -0500
Received: (qmail 31874 invoked by uid 109); 11 Nov 2018 06:34:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 06:34:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31732 invoked by uid 111); 11 Nov 2018 06:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 01:33:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 01:33:59 -0500
Date:   Sun, 11 Nov 2018 01:33:59 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 01/10] git-fast-import.txt: fix documentation for --quiet
 option
Message-ID: <20181111063359.GA30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-2-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:03PM -0800, Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-fast-import.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index e81117d27f..7ab97745a6 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -40,9 +40,10 @@ OPTIONS
>  	not contain the old commit).
>  
>  --quiet::
> -	Disable all non-fatal output, making fast-import silent when it
> -	is successful.  This option disables the output shown by
> -	--stats.
> +	Disable the output shown by --stats, making fast-import usually
> +	be silent when it is successful.  However, if the import stream
> +	has directives intended to show user output (e.g. `progress`
> +	directives), the corresponding messages will still be shown.

Makes sense. I think one could argue that it should disable those
messages, too, but probably the right answer is that the export side
should be told to be `--quiet` as well.

-Peff
