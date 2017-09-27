Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D1C2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdI0RHT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:07:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750786AbdI0RHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:07:18 -0400
Received: (qmail 19133 invoked by uid 109); 27 Sep 2017 17:07:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 17:07:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16708 invoked by uid 111); 27 Sep 2017 17:07:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 13:07:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 13:07:16 -0400
Date:   Wed, 27 Sep 2017 13:07:16 -0400
From:   Jeff King <peff@peff.net>
To:     Toni Uebernickel <tuebernickel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 03:23:21PM +0200, Toni Uebernickel wrote:

> Hi there,
> 
> I updated to git version v2.14.2 on macOS using homebrew.
> 
> Since then `git add --patch` and `git stash save --patch` are not
> working anymore. It's just printing the complete diff without ever
> stopping to ask for actions. This results in an unusable state, as the
> whole command option is rendered useless.

What was the previous version that was working? It is possible to bisect
to find the culprit commit?

There weren't any updates to git-add--interactive.perl (the program that
underlies the `--patch` implementation in both cases) in v2.14.2, and
very few even in v2.14.0. Of course the problem may be in one of the
sub-programs it calls.

-Peff
