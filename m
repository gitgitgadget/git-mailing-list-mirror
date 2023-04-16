Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE115C77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDPLV6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 16 Apr 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDPLV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 07:21:57 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5E101
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 04:21:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a67:f400:7c1f:33d9:d72e:3424])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id E032E12A03A1;
        Sun, 16 Apr 2023 13:21:51 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CABPp-BGM3NkQssYXKK+eeNm6qm7Jt6wXQp8AuXJRuVBThiwkXw@mail.gmail.com>
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu> <20230416054735.3386065-1-newren@gmail.com> <CABPp-BGM3NkQssYXKK+eeNm6qm7Jt6wXQp8AuXJRuVBThiwkXw@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
From:   Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
To:     Elijah Newren <newren@gmail.com>
Message-ID: <168164411112.5089.3765337809252656175.git@grubix.eu>
Date:   Sun, 16 Apr 2023 13:21:51 +0200
User-Agent: alot/0.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren venit, vidit, dixit 2023-04-16 07:51:03:
> On Sat, Apr 15, 2023 at 10:47 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Sat, Apr 15, 2023 at 4:06 AM Michael J Gruber <git@grubix.eu> wrote:
> > >
> <snip>
> > > A real fix will identify a proper common header file (I couldn't) or
> > > create a new one.
> >
> > I've got a patch that does precisely this that I just submitted as
> > part of my follow-on to the en/header-split-cache-h series.  I've included
> > that patch below in case Junio wants to advance it faster than the rest of
> > that series.
> 
> Link to other follow-up series I took this patch from:
> https://lore.kernel.org/git/003548de707f57cb9908b6dfbdf42954f668ee43.1681614206.git.gitgitgadget@gmail.com/

Thanks, protocol.h looks like a good place. I wasn't sure whether
daemon.c wants to include it, but I'm fine with it.

The change which broke git protocol hit me basically at the same time at
which I upgraded my system (F37->F38) which made the first analysis
interesting ... Anyway, it's "released" on next only, and the fix is
simple, thus not urgent. git.git/next works nicely on Fedora 38 by the
way, no surprises with tool chain upgrades so far.

Apparantly, we don't test this protocol, and almost all our next users
don't use it either ;)

Cheers
Michael
