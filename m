Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB6F201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 14:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdKLOWT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 09:22:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:53950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751150AbdKLOWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 09:22:18 -0500
Received: (qmail 31956 invoked by uid 109); 12 Nov 2017 14:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 14:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15049 invoked by uid 111); 12 Nov 2017 14:22:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 09:22:30 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 14:22:04 +0000
Date:   Sun, 12 Nov 2017 14:22:04 +0000
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Haaris <hsed@unimetic.com>, git@vger.kernel.org
Subject: Re: [PATCH] config: added --expiry-date type support
Message-ID: <20171112142204.2nuhh726imqksdug@sigill.intra.peff.net>
References: <0102015fb02bb5be-02c77f83-5a20-4ca1-8bab-5e9519cbd758-000000@eu-west-1.amazonses.com>
 <20171112135553.GA10563@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171112135553.GA10563@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 02:55:53PM +0100, Kevin Daudt wrote:

> What I'm also missing is a motivation on why you added this option,
> which should be part of your commit message. As far as I know, there is
> currently no config setting that expects a date format.

This patch came from submitGit, and there's a bit more at:

  https://github.com/git/git/pull/433

(though obviously that informatoin should go into the commit message).

We do parse expiration dates from config in a few places, like
gc.reflogexpire, etc. There's no way for a script using git-config to do
the same (either adding an option specific to the script, or trying to
do some analysis on gc.reflogexpire).

-Peff
