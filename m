Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DE4C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 21:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiKJVfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiKJVfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 16:35:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970B167ED
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:35:50 -0800 (PST)
Received: (qmail 25515 invoked by uid 109); 10 Nov 2022 21:35:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Nov 2022 21:35:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29935 invoked by uid 111); 10 Nov 2022 21:35:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Nov 2022 16:35:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Nov 2022 16:35:49 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #02; Tue, 8)
Message-ID: <Y21utWxpsmXEkeIS@coredump.intra.peff.net>
References: <Y2riRSL+NprJt278@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2riRSL+NprJt278@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 06:12:05PM -0500, Taylor Blau wrote:

> * jk/ref-filter-parsing-bugs (2022-11-02) 2 commits
>   (merged to 'next' on 2022-11-03 at 92c1a50548)
>  + ref-filter: fix parsing of signatures with CRLF and no body
>  + ref-filter: fix parsing of signatures without blank lines
> 
>  Various tests exercising the transfer.credentialsInUrl configuration
>  are taught to avoid making requests which require resolving localhost
>  to reduce CI-flakiness.
>  source: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>

Hmm, this seems like the wrong description. It matches
jk/avoid-localhost, which was merged earlier.

Unfortunately, I think it has now been baked into the history via
15df8418a5 (Merge branch 'jk/ref-filter-parsing-bugs', 2022-11-08). But
it might be worth trying to puzzle out how it happened (some problem
invoking Junio's maintainer scripts, or good old fashioned human
error?).

> * tb/branch-delete-detached (2022-11-01) 1 commit
>  - branch: gracefully handle '-d' on detached HEAD
> 
>  'git branch -d' is taught to ignore failures to resolve HEAD when
>  detached.
> 
>  Expecting a reroll.
>  source: <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>

It looks like you picked up my re-roll here already, from:

  https://lore.kernel.org/git/Y2H%2F1S3G+KeeEN%2Fl@coredump.intra.peff.net/

-Peff
