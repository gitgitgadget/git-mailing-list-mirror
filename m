Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D57A20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdJBTmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:42:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:58130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751062AbdJBTmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:42:10 -0400
Received: (qmail 11667 invoked by uid 109); 2 Oct 2017 19:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 19:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32219 invoked by uid 111); 2 Oct 2017 19:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 15:42:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 15:42:08 -0400
Date:   Mon, 2 Oct 2017 15:42:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom
 parsers
Message-ID: <20171002194208.sfjepr3vsidobb6b@sigill.intra.peff.net>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002161034.44867-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002161034.44867-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 09:10:34AM -0700, Taylor Blau wrote:

> Peff points out that different atom parsers handle the empty
> "sub-argument" list differently. An example of this is the format
> "%(refname:)".
> 
> Since callers often use `string_list_split` (which splits the empty
> string with any delimiter as a 1-ary string_list containing the empty
> string), this makes handling empty sub-argument strings non-ergonomic.
> 
> Let's fix this by assuming that atom parser implementations don't care
> about distinguishing between the empty string "%(refname:)" and no
> sub-arguments "%(refname)".
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c            | 10 +++++++++-
>  t/t6300-for-each-ref.sh |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)

This looks good to me, thanks.

-Peff
