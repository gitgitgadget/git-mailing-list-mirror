Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D339C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749A420A8B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJPHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:07:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:39626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726009AbgDJPHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:07:53 -0400
Received: (qmail 1828 invoked by uid 109); 10 Apr 2020 15:07:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 15:07:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31839 invoked by uid 111); 10 Apr 2020 15:18:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 11:18:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 11:07:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Refactor code asking the user for input
 interactively
Message-ID: <20200410150753.GA68344@coredump.intra.peff.net>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
 <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
 <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 11:27:50AM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/prompt.h b/prompt.h
> index e04cced030c..e294e93541c 100644
> --- a/prompt.h
> +++ b/prompt.h
> @@ -6,4 +6,6 @@
>  
>  char *git_prompt(const char *prompt, int flags);
>  
> +int git_read_line_interactively(struct strbuf *line);
> +

It might be worth adding some comments discussing why one would use
git_prompt() versus git_read_line_interactively().

Other than that, both patches look good to me. Thanks for calling out
the changed trimming behavior preemptively. I agree it should not be a
big deal either way.

-Peff
