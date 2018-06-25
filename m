Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0901F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeFYSnx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:43:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964886AbeFYSnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:43:52 -0400
Received: (qmail 20509 invoked by uid 109); 25 Jun 2018 18:43:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Jun 2018 18:43:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20910 invoked by uid 111); 25 Jun 2018 18:44:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Jun 2018 14:44:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jun 2018 14:43:50 -0400
Date:   Mon, 25 Jun 2018 14:43:50 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180625184350.GA26688@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 10:49:26AM -0500, Taylor Blau wrote:

> Attached is my third--anticipate the final--re-roll of my series to
> teach 'git grep --column'.

You know when you say that it jinxes it, right? :)

> Since the last time, only a couple of things have changed at Peff's
> suggestions in [1]. The changes are summarized here, and an inter-diff
> is available below:
> 
>   - Change "%zu" to PRIuMAX (and an appropriate cast into uintmax_t). I
>     plan to send a follow-up patch to convert this back to "%zu" to see
>     how people feel about it, but I wanted to keep that out of the
>     present series in order to not hold things up.
> 
>   - Don't short-circuit AND when given --column, since an earlier NOT
>     higher in the tree may cause an AND to be converted into an OR via
>     de Morgan's Law, in which case the problem is reduced to the OR case
>     (and should not have been short-circuited in the first place).
> 
>   - Add a test in t7810 to cover this behavior (i.e., '--not \( -e x
>     --and -e y \)').

Jinxes aside, this interdiff looks good to me.

-Peff
