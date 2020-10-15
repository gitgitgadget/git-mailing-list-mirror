Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F74C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E311821D7F
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgJOQH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:07:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:32824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbgJOQH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:07:26 -0400
Received: (qmail 23008 invoked by uid 109); 15 Oct 2020 16:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 16:07:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29702 invoked by uid 111); 15 Oct 2020 16:07:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 12:07:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 12:07:25 -0400
From:   Jeff King <peff@peff.net>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
Message-ID: <20201015160725.GA1104947@coredump.intra.peff.net>
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 12:49:20PM +0000, Nipunn Koorapati via GitGitGadget wrote:

> diff --git a/dir.c b/dir.c
> index 78387110e6..4c79c4f0e1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1040,9 +1040,9 @@ static int add_patterns_from_buffer(char *buf, size_t size,
>   * an index if 'istate' is non-null), parse it and store the
>   * exclude rules in "pl".
>   *
> - * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> + * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill

Makes sense. This changed as part of 4b33e60201 (dir: convert struct
sha1_stat to use object_id, 2018-01-28). Perhaps it would likewise make
sense to stop saying "SHA-1" here, and just say "hash" (or even "object
id", though TBH I think the fact that the hash is the same as an
object-id is largely an implementation detail).

-Peff
