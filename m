Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0EC19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 00:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiGaAYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAYW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 20:24:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3314010
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:24:21 -0700 (PDT)
Received: (qmail 28096 invoked by uid 109); 31 Jul 2022 00:24:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Jul 2022 00:24:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7883 invoked by uid 111); 31 Jul 2022 00:24:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jul 2022 20:24:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jul 2022 20:24:20 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 08:18:48PM -0400, Jeff King wrote:

>     There's also some bits in the sub-thread about limiting HEAD to
>     "refs/heads/", which we couldn't quite do at the time. That might be
>     worth revisiting, but definitely shouldn't hold up your patch.

Hmph, maybe not. The sticking point was topgit, which points HEAD at
refs/top-bases. There's a fork here:

  https://github.com/mackyle/topgit

which has been active in the last 12 months and which still uses that
convention. So maybe people really are still using it.

(Again, neither here nor there for your patch).

-Peff
