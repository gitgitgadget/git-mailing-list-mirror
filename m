Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF901F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdAZOjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:39:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:45335 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752803AbdAZOjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:39:09 -0500
Received: (qmail 5225 invoked by uid 109); 26 Jan 2017 14:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:39:08 +0000
Received: (qmail 23450 invoked by uid 111); 26 Jan 2017 14:39:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:39:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:39:06 -0500
Date:   Thu, 26 Jan 2017 09:39:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
Message-ID: <20170126143906.j6j64v4cyatwvlik@sigill.intra.peff.net>
References: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701261213060.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701261213060.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 12:16:10PM +0100, Johannes Schindelin wrote:

> We could switch the DEVELOPER option on by default, when gcc or clang is
> used at least. Otherwise the DEVELOPER option (which I like very much)
> would not be able to live up to its full potential.

I'm not sure that is a good idea. The options include -Werror, which is
a good thing for developers to respect. But people using older versions
of compilers, or on systems with slightly different header files, may
see extraneous warnings. It's good to fix those warnings, but it is a
big inconvenience to regular users who just want to build and use git.

You could split the DEVELOPER options into two groups, though, and only
enable when (after verifying that it is indeed gcc/clang in use). But
now who is coming up with complicated fixes for the warning("") issue?
:)

-Peff
