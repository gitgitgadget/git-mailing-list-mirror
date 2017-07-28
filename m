Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C0820899
	for <e@80x24.org>; Fri, 28 Jul 2017 00:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbdG1Azf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 20:55:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:51058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751584AbdG1Aze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 20:55:34 -0400
Received: (qmail 32707 invoked by uid 109); 28 Jul 2017 00:55:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jul 2017 00:55:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5507 invoked by uid 111); 28 Jul 2017 00:55:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jul 2017 20:55:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jul 2017 20:55:32 -0400
Date:   Thu, 27 Jul 2017 20:55:32 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: remove unsupported parameter from patch-id
Message-ID: <20170728005532.5q5x2ur5alu2pora@sigill.intra.peff.net>
References: <20170727224616.7216-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170727224616.7216-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2017 at 12:46:16AM +0200, Andreas Heiduk wrote:

> The patch is read from standard input and not from a parameter.
> 
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/git-patch-id.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
> index cf71fba1c..442caff8a 100644
> --- a/Documentation/git-patch-id.txt
> +++ b/Documentation/git-patch-id.txt
> @@ -56,9 +56,6 @@ OPTIONS
>  
>  	This is the default.
>  
> -<patch>::
> -	The diff to create the ID of.
> -

Heh, I think this is a leftover from 33e8fc874 (usage: do not insist
that standard input must come from a file, 2015-10-16).

Before then, the usage at the top said something like:

  git patch-id < <patch>

and this "parameter" made sense. But after, we just talk about stdin in
the text, and mentioning "<patch>" is simply confusing.

I looked through the other documentation touched by 33e8fc874 to see if
there were other cases of this same problem, but I think this is the
only one.

-Peff
