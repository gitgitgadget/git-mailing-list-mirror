Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885E820193
	for <e@80x24.org>; Wed,  2 Nov 2016 19:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbcKBT4T (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 15:56:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755923AbcKBT4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 15:56:18 -0400
Received: (qmail 14499 invoked by uid 109); 2 Nov 2016 19:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 19:56:18 +0000
Received: (qmail 5588 invoked by uid 111); 2 Nov 2016 19:56:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 15:56:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 15:56:16 -0400
Date:   Wed, 2 Nov 2016 15:56:16 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] disallow symlinks for .gitignore and .gitattributes
Message-ID: <20161102195615.3muvgr2q2lnn7sg4@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <CAGZ79kY195Bff5bUVm44Bx7+XzDDehYbRxgdii4s040pQXRRSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY195Bff5bUVm44Bx7+XzDDehYbRxgdii4s040pQXRRSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 12:46:28PM -0700, Stefan Beller wrote:

> On Wed, Nov 2, 2016 at 6:04 AM, Jeff King <peff@peff.net> wrote:
> 
> >
> >  attr.c                | 58 ++++++++++++++++++++++++++++++++-------------------
> 
> $ git diff --stat origin/master..origin/sb/attr  |grep attr.c
>  attr.c                                             |  531 +-
> 
> From a cursory read of your series this may result in a merge
> conflict, but would be
> easily fixable (changed signature of functions that clash).

Yeah, I knew you guys were doing some refactoring of the attribute code
elsewhere, but hadn't actually seen how bad the damage was. I just did
the merge with sb/attr, though, and the conflicts are quite trivial
(mostly s/1/flags/ in bootstrap_attr_stack()).

I'm happy to re-roll on a different base if sb/attr graduates first, but
I suspect Junio can just resolve the conflicts at merge time.

-Peff
