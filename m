Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD3C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiKHOaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiKHO3m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:29:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5451862C8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:27:51 -0800 (PST)
Received: (qmail 7176 invoked by uid 109); 8 Nov 2022 14:27:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 14:27:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4467 invoked by uid 111); 8 Nov 2022 14:27:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 09:27:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 09:27:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: ab/make-bin-wrappers (was: What's cooking in git.git (Nov 2022,
 #01; Thu, 3))
Message-ID: <Y2pnZic1mi205/MQ@coredump.intra.peff.net>
References: <Y2RldUHTwNzmez73@nand.local>
 <221107.86h6zax26k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86h6zax26k.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 03:33:40PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Thu, Nov 03 2022, Taylor Blau wrote:
> 
> > * ab/make-bin-wrappers (2022-10-31) 4 commits
> >  - Makefile: simplify $(test_bindir_programs) rule by splitting it up
> >  - Makefile: rename "test_bindir_programs" variable, pre-declare
> >  - Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
> >  - Makefile: factor sed-powered '#!/bin/sh' munging into a variable
> >
> >  Resolve issues with the bin-wrappers/% rules where "make
> >  bin-wrappers/git" would generate the script but not "git" itself.
> >
> >  Waiting for review.
> >  source: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
> 
> On my end I'm waiting to see what you and/or Jeff think about:
> https://lore.kernel.org/git/221101.86edun5tgn.gmgdl@evledraar.gmail.com/

I don't have any strong opinion on that. I read the v2 cover letter, was
skeptical/confused of the motivation, and didn't go much further.

Your explanation in the linked email is that there are _other_ reasons
to do this refactoring, but I don't have any knowledge there that would
add to the review. My gut is still that building bin-wrappers/foo
doesn't need to depend on foo, but if it's one line, I don't care that
much either way. If it was 50 lines of complicated Makefile refactoring,
then would probably not be worth it.

-Peff
