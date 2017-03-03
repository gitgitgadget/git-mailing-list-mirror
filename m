Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57ADA20279
	for <e@80x24.org>; Fri,  3 Mar 2017 05:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdCCFup (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 00:50:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:37683 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdCCFun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 00:50:43 -0500
Received: (qmail 1631 invoked by uid 109); 3 Mar 2017 04:51:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:51:51 +0000
Received: (qmail 24707 invoked by uid 111); 3 Mar 2017 04:51:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 23:51:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 23:51:48 -0500
Date:   Thu, 2 Mar 2017 23:51:48 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 7/9] read_early_config(): avoid .git/config hack when
 unneeded
Message-ID: <20170303045148.uzltelasbodvgys4@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <db619060d18df21f3259653a52cd79f704b34566.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db619060d18df21f3259653a52cd79f704b34566.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:28AM +0100, Johannes Schindelin wrote:

> So far, we only look whether the startup_info claims to have seen a
> git_dir.
> 
> However, do_git_config_sequence() (and consequently the
> git_config_with_options() call used by read_early_config() asks the
> have_git_dir() function whether we have a .git/ directory, which in turn
> also looks at git_dir and at the environment variable GIT_DIR. And when
> this is the case, the repository config is handled already, so we do not
> have to do that again explicitly.
> 
> Let's just use the same function, have_git_dir(), to determine whether we
> have to handle .git/config explicitly.

Good, this makes sense.

-Peff
