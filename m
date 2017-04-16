Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1881320A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755605AbdDPGoW (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:44:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34337 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755332AbdDPGoU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 02:44:20 -0400
Received: (qmail 9681 invoked by uid 109); 16 Apr 2017 06:44:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 06:44:18 +0000
Received: (qmail 15416 invoked by uid 111); 16 Apr 2017 06:44:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 02:44:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 02:44:17 -0400
Date:   Sun, 16 Apr 2017 02:44:17 -0400
From:   Jeff King <peff@peff.net>
To:     Stephen Kent <smkent@smkent.net>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: Configurable branch colors in git status
 --short --branch
Message-ID: <20170416064416.mzspd5ix2ynvwqnk@sigill.intra.peff.net>
References: <201704555989224.827bd36f789cd969c3667696308d4@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201704555989224.827bd36f789cd969c3667696308d4@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 01:00:51PM -0700, Stephen Kent wrote:

> It would be nice if the branch, remote tracking branch, and branch commit
> comparison count colors in git status --short --branch were configurable
> like the other git status colors.

That seems like a reasonable thing to want.

I think the infrastructure is all there, and it would just need an
update to builtin/commit.c:parse_status_slot() to map the color.status.*
names into the {LOCAL,REMOTE}_BRANCH enum values.

Want to try your hand at a patch?

-Peff
