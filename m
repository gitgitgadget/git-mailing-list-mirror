Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C68C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5F613C3
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhEESgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:36:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:45706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhEESgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:36:22 -0400
Received: (qmail 19624 invoked by uid 109); 5 May 2021 18:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 18:35:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12578 invoked by uid 111); 5 May 2021 18:35:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 14:35:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 14:35:23 -0400
From:   Jeff King <peff@peff.net>
To:     Theodor Negrescu <theodor.negrescu@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
Message-ID: <YJLla4gNEMS2yxCv@coredump.intra.peff.net>
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net>
 <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
 <CAEumJaCmcReO4ry7DP14zDg0R5L5QgULZpZmaqBY5g=EQD4U+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEumJaCmcReO4ry7DP14zDg0R5L5QgULZpZmaqBY5g=EQD4U+Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 09:30:21PM +0300, Theodor Negrescu wrote:

> I'm using powershell, but usually ~ works there. Typing "cd ~" would
> work for example.
> Also I tried using the command as an alias and it still didn't work.

I don't know anything about powershell, but generally "cd" is a builtin
to the shell (because it is impacting the shell's environment). So it
may be that powershell "cd" expands "~" itself, but that the shell
doesn't expand it for executed commands.

There are some Windows folks who hang out on this list, so you may get a
better response. But you might also ask in the Git for Windows mailing
list:

  https://groups.google.com/g/git-for-windows

-Peff
