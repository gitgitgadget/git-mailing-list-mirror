Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42EC4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 09:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiLEJXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 04:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiLEJXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 04:23:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6BB489
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 01:23:41 -0800 (PST)
Received: (qmail 7288 invoked by uid 109); 5 Dec 2022 09:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Dec 2022 09:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2285 invoked by uid 111); 5 Dec 2022 09:23:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 04:23:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 04:23:40 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Aonodensetsu <remok99999@gmail.com>, git@vger.kernel.org
Subject: Re: Pro Git book URL on https://git-scm.com/
Message-ID: <Y424nPuHH+/susGO@coredump.intra.peff.net>
References: <CA+vVMe_pUgGSGjapf16QP=DjLC+a1MBt=YBq_SkOM6NUoh2U2A@mail.gmail.com>
 <d9253ae3-9fc4-f426-a737-792bf158bd4e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9253ae3-9fc4-f426-a737-792bf158bd4e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2022 at 01:02:41PM +0100, René Scharfe wrote:

> Am 03.12.22 um 12:23 schrieb Aonodensetsu:
> > The Git documentation has been moved (probably by accident) to
> > https://git-scm.com/book/pl/v1%20z (notice the %20z at the end). This
> > is a bug and makes all redirections fail with a 500 error, since they
> > try to redirect to the correct address.
> 
> I can't find "v1 z" or "v1%20z" neither in the repository for the
> website (https://github.com/git/git-scm.com) nor in the one for the book
> (https://github.com/progit/progit2).  So I'm not sure what's going on
> here, but reporting it as an issue via the website repository should get
> the right people to take a look, I assume.

The book content is added to the sql database by a ruby job. But we
stopped running that job for the v1 (first-edition) book at some point
before 2017. I don't have an exact date, but I removed the generation
code in 495fa431 (drop book.rake, 2017-10-08). We later restored it so
that we could re-import historical versions (say, if the database
crashed and was wiped), but it finally went away in f474e35c (Remove
link to 1st book edition, 2018-11-21).

Frankly, I'm surprised there's any v1 content left, since we've had to
re-build the database from scratch a few times over the years.

-Peff
