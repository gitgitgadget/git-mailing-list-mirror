Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF1C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6478B23D1C
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbgLIRhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:37:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:55760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbgLIRhw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 12:37:52 -0500
Received: (qmail 18829 invoked by uid 109); 9 Dec 2020 17:37:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 17:37:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17111 invoked by uid 111); 9 Dec 2020 17:37:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 12:37:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 12:37:09 -0500
From:   Jeff King <peff@peff.net>
To:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Subject: Re: [PATCH] doc: 'T' status code for git status
Message-ID: <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 08:13:36AM +0000, Julien Richard via GitGitGadget wrote:

> From: Julien Richard <julien.richard@ubisoft.com>
> 
> Git status can return 'T' status code which stands for "typechange", fixing the documentation accordingly.

Thanks, this is definitely an omission in the documentation.

I wonder if we need a little more, though. The list here:

> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -197,6 +197,7 @@ codes can be interpreted as follows:
>  * 'R' = renamed
>  * 'C' = copied
>  * 'U' = updated but unmerged
> +* 'T' = type changed
>  
>  Ignored files are not listed, unless `--ignored` option is in effect,
>  in which case `XY` are `!!`.

is followed by a table showing the meaning of those entries in each
slot. Should there be some "T" entries there, too?

I think it could basically show up anywhere that "M" could.

>     Git status can return 'T' status code which stands for "typechange". I
>     can't document more the behavior but it would have helped me a lot to
>     see that line in the documentation so I guess it can help others too.

It is correctly documented in the diff manpage. There we define it as
"change in the type of the file". I'm not sure if that's really making
anything clearer than "type changed". ;)

Perhaps "type changed (e.g., a symbolic link becoming a file)" would be
more descriptive, but I'm not sure it's necessary. (And if so, it
probably would be better placed in the diff documentation).

-Peff
