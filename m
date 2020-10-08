Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDEAC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C6021D7D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgJHQDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:03:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgJHQDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:03:51 -0400
Received: (qmail 29498 invoked by uid 109); 8 Oct 2020 16:03:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 16:03:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25004 invoked by uid 111); 8 Oct 2020 16:03:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 12:03:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 12:03:50 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
Message-ID: <20201008160350.GB2823778@coredump.intra.peff.net>
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 12:39:26AM -0700, Denton Liu wrote:

>  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
>  	$(FIND) . \
> @@ -998,9 +998,9 @@ LIB_OBJS += sigchain.o
>  LIB_OBJS += split-index.o
>  LIB_OBJS += stable-qsort.o
>  LIB_OBJS += strbuf.o
> -LIB_OBJS += strvec.o
>  LIB_OBJS += streaming.o
>  LIB_OBJS += string-list.o
> +LIB_OBJS += strvec.o
>  LIB_OBJS += sub-process.o
>  LIB_OBJS += submodule-config.o
>  LIB_OBJS += submodule.o
> @@ -1066,15 +1066,15 @@ BUILTIN_OBJS += builtin/checkout-index.o
>  BUILTIN_OBJS += builtin/checkout.o
>  BUILTIN_OBJS += builtin/clean.o
>  BUILTIN_OBJS += builtin/clone.o
> -BUILTIN_OBJS += builtin/credential-cache.o
> -BUILTIN_OBJS += builtin/credential-cache--daemon.o
> -BUILTIN_OBJS += builtin/credential-store.o
>  BUILTIN_OBJS += builtin/column.o
>  BUILTIN_OBJS += builtin/commit-graph.o
>  BUILTIN_OBJS += builtin/commit-tree.o
>  BUILTIN_OBJS += builtin/commit.o
>  BUILTIN_OBJS += builtin/config.o
>  BUILTIN_OBJS += builtin/count-objects.o
> +BUILTIN_OBJS += builtin/credential-cache--daemon.o
> +BUILTIN_OBJS += builtin/credential-cache.o
> +BUILTIN_OBJS += builtin/credential-store.o
>  BUILTIN_OBJS += builtin/credential.o
>  BUILTIN_OBJS += builtin/describe.o
>  BUILTIN_OBJS += builtin/diff-files.o

Wow. Both of these hunks are from me, and I clearly _tried_ to put them
in the right place. I think...maybe I'm just bad at alphabetizing?

Curiously, the only subtle part (ascii "-" versus ".") was wrong in the
original spot I moved it from, so I won't blame myself for that. :)

Anyway, the whole patch looks good to me.

-Peff
