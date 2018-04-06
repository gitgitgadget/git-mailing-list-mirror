Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C466B1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFVrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:47:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:56606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752014AbeDFVrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:47:41 -0400
Received: (qmail 30098 invoked by uid 109); 6 Apr 2018 21:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30212 invoked by uid 111); 6 Apr 2018 21:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:48:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:47:39 -0400
Date:   Fri, 6 Apr 2018 17:47:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v8 00/15] nd/pack-objects-pack-struct updates
Message-ID: <20180406214739.GG7870@sigill.intra.peff.net>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 12:02:56PM +0200, Nguyễn Thái Ngọc Duy wrote:

> v8 changes
> 
> - prefer BUG() over die()
> - do "1U <<" instead of "1 << " to avoid undefined behavior with
>   signed shifting.
> - add more comments based on Jeff's feedback
> - plug a leak in try_delta() when delta_size is too large
> - be kind and set depth/cache_max_small_delta_size to max limit
>   instead of dying when the user gives a value over limit
> - make travis execute pack-objects uncommon code
> - use git_env_*() instead of manually handling getenv() values
> - fallback code for when a new pack is added when pack-objects is
>   running
> - Compressed cached delta size limit is increased from 64k to 1MB
> - Cached delta size limit is decreased from 2G to 1MB

I ran out of time to give this a very careful review, and I'm trying to
clear my plate before going offline for a few weeks. I did look at the
interdiff and it seemed sane.

So I think going forward, you can at least consider my objections
retracted. I don't promise this iteration is bug-free, but I think
you've addressed all my earlier issues. :)

Thanks.

-Peff
