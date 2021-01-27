Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8C2C433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC060C41
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhA0XRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:17:32 -0500
Received: from out2.migadu.com ([188.165.223.204]:10876 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhA0XLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:11:35 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 18:11:34 EST
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1611788513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qms49YnLX/gdB9jtTZJfxaku9Izj2KUZ+npubEPGVbI=;
        b=JrJCqRyQqDVM4tly083H0ME+1MutCaL4a7lue49nTa+TRlibQxefuUFBhb8N7uOrTxou4o
        mjN3MvlmE88yglfxQZUPfHgo9GqXI17ZZvMhsa5Xtswcf8KORr0zy4T6z+yVeZ8xD69KrQ
        61s3IqAX81bnW9Km5nJCIEJ3ODqTJ4TotImTXhrYOaLZwVZAe33VVGm03aRAzAd6NPZHfr
        VgDQ2eK/pcnwJxSMEM0s6ZUw1k2ybJf0KIG3Y8MOUtIieu2SsItWkyEgy1xhYEqBr59z1X
        GgZ+5B5TTwFbn/w0E6TOId64fPTTkEhyFp9hNin3oIfGkaXL4USfNTQTdB0Dmw==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
In-Reply-To: <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
Date:   Wed, 27 Jan 2021 18:01:51 -0500
Message-ID: <87mtwuvva8.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyle@kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King writes:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 002379056a..1e5826f26d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -222,6 +222,15 @@ ifdef::git-rev-list[]
>  	test the exit status to see if a range of objects is fully
>  	connected (or not).  It is faster than redirecting stdout
>  	to `/dev/null` as the output does not have to be formatted.
> +
> +--disk-usage::
> +	Suppress normal output; instead, print the sum of the bytes used
> +	for on-disk storage by the selected objects. This is equivalent
> +	to piping the output of `rev-list --objects` into
> +	`git cat-file --batch-check='%(objectsize:disk)', except that it

[ Just a drive-by typo comment from a reader not knowledgeable enough to
  review the code change :) ]

The cat-file command is missing its closing quote.
