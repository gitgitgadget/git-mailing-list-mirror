Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB60C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiKIOEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKIOEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:04:11 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB012D0B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:04:10 -0800 (PST)
Received: (qmail 12559 invoked by uid 109); 9 Nov 2022 14:04:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Nov 2022 14:04:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14948 invoked by uid 111); 9 Nov 2022 14:04:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Nov 2022 09:04:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Nov 2022 09:04:09 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: ab/make-bin-wrappers (was: What's cooking in git.git (Nov 2022,
 #01; Thu, 3))
Message-ID: <Y2uzWbl3M235Jlu+@coredump.intra.peff.net>
References: <Y2RldUHTwNzmez73@nand.local>
 <221107.86h6zax26k.gmgdl@evledraar.gmail.com>
 <Y2pnZic1mi205/MQ@coredump.intra.peff.net>
 <Y2rPrNz6BD6DlRcO@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2rPrNz6BD6DlRcO@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 04:52:44PM -0500, Taylor Blau wrote:

> > I don't have any strong opinion on that. I read the v2 cover letter, was
> > skeptical/confused of the motivation, and didn't go much further.
> >
> > Your explanation in the linked email is that there are _other_ reasons
> > to do this refactoring, but I don't have any knowledge there that would
> > add to the review. My gut is still that building bin-wrappers/foo
> > doesn't need to depend on foo, but if it's one line, I don't care that
> > much either way. If it was 50 lines of complicated Makefile refactoring,
> > then would probably not be worth it.
> 
> Isn't this topic exactly the latter? IOW:
> 
>     $ git diff --stat master...ab/make-bin-wrappers
>      Makefile | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
>      1 file changed, 52 insertions(+), 20 deletions(-)
> 
> ...maybe that was exactly your point ;-).

Sorry, I perhaps could have made the last sentence more clear as:

  If it was 50 lines of complicated Makefile refactoring _just_ to have
  "make bin-wrappers/foo" depend on "foo", it would not be worth it. But
  if it is doing something else, it might be. I don't have a strong
  opinion because I haven't (and don't want to have) looked into that
  "something else".

-Peff
