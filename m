Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247A71FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 07:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757901AbcLAHTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 02:19:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756538AbcLAHTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 02:19:09 -0500
Received: (qmail 29459 invoked by uid 109); 1 Dec 2016 07:19:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 07:19:08 +0000
Received: (qmail 30072 invoked by uid 111); 1 Dec 2016 07:19:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 02:19:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 02:19:06 -0500
Date:   Thu, 1 Dec 2016 02:19:06 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161201071906.unrerembedeja3wa@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <fa54bb08-4206-ebd5-6808-f7de6cf4b9a2@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa54bb08-4206-ebd5-6808-f7de6cf4b9a2@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 08:09:16AM +0100, Johannes Sixt wrote:

> Am 01.12.2016 um 00:40 schrieb Jeff King:
> > 20813 access("su:b/../.git/modules/su:b/refs", X_OK) = 0
> 
> Side note: where does this weirdness "su:b" come from? (I haven't looked at
> any of the patches, yet, let alone tested.) Colons in file or directory
> names won't work on Windows (in the way one would expect).

It's explicitly used in the test, I assume to check that the recursive
grep is not confused into treating the name as a tree-ish.

I think it would have to either be marked with a prereq on Windows, or
modified to do the whole thing in-index (and use "grep --cached").

-Peff
