Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C601F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeCZOdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:33:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:43288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751714AbeCZOdm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:33:42 -0400
Received: (qmail 30944 invoked by uid 109); 26 Mar 2018 14:33:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 14:33:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19903 invoked by uid 111); 26 Mar 2018 14:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 10:34:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 10:33:40 -0400
Date:   Mon, 26 Mar 2018 10:33:40 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        ethomson@edwardthomson.com
Subject: Re: [RFC 0/1] Tolerate broken headers in `packed-refs` files
Message-ID: <20180326143340.GA23926@sigill.intra.peff.net>
References: <cover.1522062649.git.mhagger@alum.mit.edu>
 <f8d0f3b6-69b3-ba42-c39c-551814caf335@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8d0f3b6-69b3-ba42-c39c-551814caf335@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 09:08:04AM -0400, Derrick Stolee wrote:

> Since most heavily-used tools that didn't spawn Git processes use LibGit2 to
> interact with Git repos, I added Ed Thomson to CC to see if libgit2 could
> ever write these bad header comments.

Ed can probably answer more definitively, but I dug in the libgit2
history a little, and I think it has only ever generated correct
"pack-refs with:" lines.

Ditto for JGit, though there it blames down to 1a6964c82 (Initial JGit
contribution to eclipse.org, 2009-09-29). I didn't dig further into the
historical JGit repository, but I think that's probably far enough to
feel good about it.

-Peff
