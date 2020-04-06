Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D68FC2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E532072F
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 20:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFUTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:19:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725933AbgDFUTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 16:19:46 -0400
Received: (qmail 27054 invoked by uid 109); 6 Apr 2020 20:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 20:19:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17456 invoked by uid 111); 6 Apr 2020 20:30:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 16:30:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 16:19:45 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] pull doc: refer to a specific section in 'fetch' doc
Message-ID: <20200406201945.GA1245278@coredump.intra.peff.net>
References: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
 <9c94c2770f0eb1cbb9383cffde7c275d7d3f52c9.1586101819.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c94c2770f0eb1cbb9383cffde7c275d7d3f52c9.1586101819.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 05, 2020 at 03:50:18PM +0000, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> The documentation for the `<refspec>` parameter in the `git fetch`
> documentation refers to the section "CONFIGURED REMOTE-TRACKING
> BRANCHES" in this same documentation page.
> 
> In the `git pull` documentation, let's also refer specifically to this
> section instead of just linking to the `git fetch` documentation.

Makes sense. One thought:

> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 7d3a60f5b93..95ea8499029 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -19,7 +19,8 @@ ifndef::git-pull[]
>  	(see <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> below).
>  endif::git-pull[]
>  ifdef::git-pull[]
> -	(see linkgit:git-fetch[1]).
> +	(see the section "CONFIGURED REMOTE-TRACKING BRANCHES"
> +	in linkgit:git-fetch[1]).
>  endif::git-pull[]

We can hyperlink directly to this section with the CRTB tag (as you can
see in the context above). But I guess we don't have a portable macro to
do so across different manpages. Assuming we'd need something like
linkgit to accomplish, it's best not to hold up this change waiting for
that.

-Peff
