Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB46202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdJCNt5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:49:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751398AbdJCNt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:49:57 -0400
Received: (qmail 29981 invoked by uid 109); 3 Oct 2017 13:49:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8074 invoked by uid 111); 3 Oct 2017 13:49:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:49:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:49:54 -0400
Date:   Tue, 3 Oct 2017 09:49:54 -0400
From:   Jeff King <peff@peff.net>
To:     rpjday@crashcourse.ca
Cc:     git@vger.kernel.org
Subject: Re: "man git-config", "--list" option misleadingly refers to "config
 file" (singular)
Message-ID: <20171003134954.cptlpaipmiulfgug@sigill.intra.peff.net>
References: <20171003063434.Horde.nbQwMWrv0wS_naxhawU5YlG@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003063434.Horde.nbQwMWrv0wS_naxhawU5YlG@crashcourse.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 06:34:34AM -0400, rpjday@crashcourse.ca wrote:

>   (i suppose that if i'm going to continue whining about stuff, i might
> as well clone the git source and start submitting patches.)

Yes, please. :)

>   in "man git-config":
> 
>     -l
>     --list
>           List all variables set in config file, along with their values.
>                                            ^^^^
> 
> except that, AIUI, "git config --list" will list the combination of all
> config values in (if it exists) /etc/gitconfig, then the user's global
> settings, and finally the repo's config settings if one happens to be
> in a working directory, so technically, it lists the contents of *all* of
> the config files (plural), no?

It does that by default, or it lists the contents of a specific file if
given (either by --file, or with --system, --global, or --local).

So I agree it's not quite accurate, but you probably want some phrasing
that leaves this unsaid (the actual rules are described earlier in the
description section). Maybe just refer to it as the "config source" or
something?

-Peff
