Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119CA202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 06:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdJUG2t (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 02:28:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:59782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750961AbdJUG2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 02:28:48 -0400
Received: (qmail 10205 invoked by uid 109); 21 Oct 2017 06:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 06:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22705 invoked by uid 111); 21 Oct 2017 06:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 02:28:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 02:28:46 -0400
Date:   Sat, 21 Oct 2017 02:28:46 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v2 2/2] mark git stash push deprecated in the man page
Message-ID: <20171021062846.s6rzo2hxmeqigk3e@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
 <20171019183304.26748-1-t.gummerer@gmail.com>
 <20171019183304.26748-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019183304.26748-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 07:33:04PM +0100, Thomas Gummerer wrote:

> 'git stash push' fixes a historical wart in the interface of 'git stash
> save'.  As 'git stash push' has all functionality of 'git stash save',
> with a nicer, more consistent user interface deprecate 'git stash
> save'.  To do this, remove it from the synopsis of the man page, and
> move it to a separate section, stating that it is deprecated.

This looks fine.

> @@ -87,6 +84,10 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
>  The `--patch` option implies `--keep-index`.  You can use
>  `--no-keep-index` to override this.
>  
> +save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> +
> +	This option is deprecated in favour of 'git stash push'.
> +

We could possibly go into more detail, like:

  It differs from "stash push" in that it cannot take pathspecs, and any
  non-option arguments form the message.

or something. Since we don't want people to use it, it probably doesn't
matter much. I just wondered if people would peer at the (long) synopsis
line trying to figure out how it's different.

-Peff
