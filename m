Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756FC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759C764DEC
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhA2AuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:50:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:42736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhA2Asc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:48:32 -0500
Received: (qmail 20585 invoked by uid 109); 29 Jan 2021 00:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:47:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4336 invoked by uid 111); 29 Jan 2021 00:47:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:47:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:47:47 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 08/10] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <YBNbM1STgzXxfe0u@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <02550a251de4f477a537968fda921b52586794dc.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02550a251de4f477a537968fda921b52586794dc.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:42PM -0500, Taylor Blau wrote:

> Add a new option that unconditionally enables the pack.writeReverseIndex
> setting in order to run the whole test suite in a mode that generates
> on-disk reverse indexes. Additionally, enable this mode in the second
> run of tests under linux-gcc in 'ci/run-build-and-tests.sh'.
> 
> Once on-disk reverse indexes are proven out over several releases, we
> can change the default value of that configuration to 'true', and drop
> this patch.

Sounds like a good plan.

> diff --git a/pack-revindex.h b/pack-revindex.h
> index 61b2f3ab75..d1a0595e89 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -16,9 +16,12 @@
>   *   can be found
>   */
>  
> +
>  #define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
>  #define RIDX_VERSION 1

Funny stray whitespace.

-Peff
