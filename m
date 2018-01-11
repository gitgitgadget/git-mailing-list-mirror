Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5445F1F406
	for <e@80x24.org>; Thu, 11 Jan 2018 10:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeAKKtR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 05:49:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933298AbeAKKtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 05:49:16 -0500
Received: (qmail 28809 invoked by uid 109); 11 Jan 2018 10:49:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 10:49:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21979 invoked by uid 111); 11 Jan 2018 10:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 05:49:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 05:49:14 -0500
Date:   Thu, 11 Jan 2018 05:49:14 -0500
From:   Jeff King <peff@peff.net>
To:     "Andreas G. Schacker" <andreas.schacker@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
Message-ID: <20180111104914.GA5897@sigill.intra.peff.net>
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109153034.22970-1-andreas.schacker@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 09, 2018 at 04:30:34PM +0100, Andreas G. Schacker wrote:

> Earlier versions of `git read-tree` required the `--prefix` option value
> to end with a slash. This restriction was eventually lifted without a
> corresponding amendment to the documentation.

Makes sense.

> ---prefix=<prefix>/::
> +--prefix=<prefix>::
>  	Keep the current index contents, and read the contents
>  	of the named tree-ish under the directory at `<prefix>`.
>  	The command will refuse to overwrite entries that already
> -	existed in the original index file. Note that the `<prefix>/`
> -	value must end with a slash.
> +	existed in the original index file.

Is it worth mentioning in the new world order that the slash is not
implied? I.e., that you probably do want to say "--prefix=foo/" if you
want the subdirectory "foo", but do not want to match "foobar"?

-Peff
