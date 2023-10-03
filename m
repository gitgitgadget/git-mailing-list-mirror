Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A9E8FDAF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjJCUKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjJCUKw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:10:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348EE9B
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:10:50 -0700 (PDT)
Received: (qmail 14419 invoked by uid 109); 3 Oct 2023 20:10:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14405 invoked by uid 111); 3 Oct 2023 20:10:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:10:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:10:48 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: batch-command wishlist [was: [TOPIC 02/12] Libification Goals
 and Progress]
Message-ID: <20231003201048.GD1562@coredump.intra.peff.net>
References: <20231003005251.M353509@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003005251.M353509@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 12:52:51AM +0000, Eric Wong wrote:

> Not sure if cat-file is the place for it, but a persistent
> process to deal with:
> 
> * `git config -f FILENAME ...' (especially --get-urlmatch --type=FOO)
> * approxidate parsing for other tools[2]
>
> [2] I did recently license the code of a standalone C++ executable
>     as GPL-2+ so I can copy approxidate parsing from git and
>     perhaps figure out enough C++ to use Xapian query parser
>     bindings instead of the hacky `git rev-parse --since=' thing
>     I do.

I know that you asked for a persistent process, but just for reference,
you can hackily access approxidate with:

  git config --type=expiry-date --default='15 days ago' does.not.exist

-Peff
