Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA1A1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdAYVNe (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:13:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:44777 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdAYVNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:13:33 -0500
Received: (qmail 3243 invoked by uid 109); 25 Jan 2017 21:13:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 21:13:33 +0000
Received: (qmail 15903 invoked by uid 111); 25 Jan 2017 21:13:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 16:13:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 16:13:31 -0500
Date:   Wed, 25 Jan 2017 16:13:31 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retire the `relink` command
Message-ID: <20170125211331.ts4ohigz5z6ugj6q@sigill.intra.peff.net>
References: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 05:58:57PM +0100, Johannes Schindelin wrote:

> Back in the olden days, when all objects were loose and rubber boots were
> made out of wood, it made sense to try to share (immutable) objects
> between repositories.
> 
> Ever since the arrival of pack files, it is but an anachronism.

Yes, this is a good idea. I could _almost_ see its utility if it linked
packfiles, too, but then it is very unlikely that two repos have the
exact same packfile.

> Let's move the script to the contrib/examples/ directory and no longer
> offer it.

I am OK with this, but perhaps we should go even further and just delete
it entirely. The point of contrib/examples is to show people "this is
how you could script plumbing to implement a porcelain". But this script
does not call a single plumbing script. It just looks directly in
objects/, which is probably not something we would want to encourage. :)

-Peff
