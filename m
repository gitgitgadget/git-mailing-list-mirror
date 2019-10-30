Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4C11F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJ3UR7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:17:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:34228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726261AbfJ3UR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:17:59 -0400
Received: (qmail 28387 invoked by uid 109); 30 Oct 2019 20:17:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Oct 2019 20:17:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23543 invoked by uid 111); 30 Oct 2019 20:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Oct 2019 16:21:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Oct 2019 16:17:57 -0400
From:   Jeff King <peff@peff.net>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: request: add git grep -o option
Message-ID: <20191030201757.GA29013@sigill.intra.peff.net>
References: <277ee7531df8dfd3249f189b9b298a5d187ec479.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <277ee7531df8dfd3249f189b9b298a5d187ec479.camel@perches.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 12:58:59PM -0700, Joe Perches wrote:

> Instead of duplicating a grep pattern with grep -oh after
> git grep like
> this:
> 
> $ git grep -P '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?' -- '*.[ch]' | \
>   grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?'
> 
> it could be useful to have git grep have the same '-o' option 
> as gnu grep.

Doesn't it already?

  $ git grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?'
  for_each
  for_each
  for_each_abbrev
  for_each_builtin
  for_each_string_list_item
  for_each_ut
  [etc...]

It was new in Git v2.19.

-Peff
