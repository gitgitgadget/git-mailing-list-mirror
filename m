Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA161FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755690AbdC1TQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:16:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:53113 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755439AbdC1TQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:16:44 -0400
Received: (qmail 9941 invoked by uid 109); 28 Mar 2017 19:16:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:16:30 +0000
Received: (qmail 5352 invoked by uid 111); 28 Mar 2017 19:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:16:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:16:28 -0400
Date:   Tue, 28 Mar 2017 15:16:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328190732.59486-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 07:07:30PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Version 3 of this patch series simplifies this effort to just turn
> on/off the hash verification using a "core.checksumindex" config variable.
> 
> I've preserved the original checksum validation code so that we can
> force it on in fsck if desired.
> 
> It eliminates the original threading model completely.
> 
> Jeff Hostetler (2):
>   read-cache: core.checksumindex
>   test-core-checksum-index: core.checksumindex test helper
> 
>  Makefile                            |  1 +
>  read-cache.c                        | 12 ++++++
>  t/helper/.gitignore                 |  1 +
>  t/helper/test-core-checksum-index.c | 77 +++++++++++++++++++++++++++++++++++++

Do we still need test-core-checksum-index? Can we just time ls-files or
something in t/perf?

-Peff
