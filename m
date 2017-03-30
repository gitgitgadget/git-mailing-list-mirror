Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D9820966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbdC3VWK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:22:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:54432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbdC3VWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:22:09 -0400
Received: (qmail 31450 invoked by uid 109); 30 Mar 2017 21:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 21:22:08 +0000
Received: (qmail 3222 invoked by uid 111); 30 Mar 2017 21:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 17:22:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 17:22:06 -0400
Date:   Thu, 30 Mar 2017 17:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git and PCRE2 vs PCRE?
Message-ID: <20170330212206.42mv7rvwzvakenr3@sigill.intra.peff.net>
References: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 04:59:27PM -0400, Jeffrey Walton wrote:

> Configure has an option for libpcre, but its not clear to me how to
> fine tune it for libpcre2:
> 
> $ ./configure --help | /usr/gnu/bin/grep -A 2 -i pcre
>   --with-libpcre          support Perl-compatible regexes (default is NO)
>                           ARG can be also prefix for libpcre library and
>                           headers
> 
> Is it possible to use PCRE2 with Git? If so, how do I tell Git to use PCRE2?

No, I don't think so. According to the release announcement for pcre2,
the API is not compatible with the original:

  https://lists.exim.org/lurker/message/20150105.162835.0666407a.en.html

So even if you could tweak the build to use it, it would not do the
right thing. Somebody would have to add code for the new library, and
probably have a USE_LIBPCRE2 flag.

I don't know offhand if there are compelling reasons to do that work.

-Peff
