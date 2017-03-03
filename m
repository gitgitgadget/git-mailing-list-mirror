Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF7320133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdCCQ7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:59:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:63012 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbdCCQ6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 11:58:38 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1cdmPp0k5i-007CQd; Fri, 03
 Mar 2017 16:26:11 +0100
Date:   Fri, 3 Mar 2017 16:26:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 8/9] read_early_config(): really discover .git/
In-Reply-To: <20170303050630.mw6asla65prku3vq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031620190.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <921faef822901715fa877d6969255ce00d80b925.1488506615.git.johannes.schindelin@gmx.de> <20170303050630.mw6asla65prku3vq@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kRvEvNp6PUSKVCRzM5DyVny31V13kobvmtaX6sdLGuf5ZsSXjE7
 eMFzIcDA0xy4NlpNySUHqpN2bxOIw8z5vMpIU0NUbrco7GIvAKt0kiOT0qwgL4pEgphdx9O
 ne0QBoGkIH4lBtuoao3oMtiiBFQVSpn7zeJZPU1BzWJT2LdebGHdR2ucPclbokEdOKOUtXE
 Q3PTRYZkUwVepDSSKrl+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yRxd86KMmC4=:LPIJI270CYcitrKm+VYHDU
 DlYSjC/6qHLdHEGQC4vTSe5LSmU40xSHBo+E73npAtnLraot/XvX4w3m4/r46d9/vz/P1veRb
 vUOmJ1bGPuDcGxvR7/UKDAJJDBF8trZGYGJQrj+3ONOE887B2xV7P3KwHouTNhUO34mQP7ll+
 MfrXjAHFfGAPhT4Bax0Z9a0iT8OhGKQY55SOqFg8GGhIK8xFTtdAcwy/E4W2Kk6+srW98itY4
 cMsPouXeS2SrGEMOV5qrKANGUxfMOwXEBJOHo5/K9v9H0e865Fr1gB01DsoQv/s0pgTytp6Ko
 1FqbpEv3I3h6Eq2e7JPJQnkh/lAHUgYOtdaqrrK2u7NVgZGOQrs5/EbuiAub6wDsrqbFcScQP
 TOWMUaTK+3HBVmhtx29Xdasmg1+e9AYPgo9KR3Yq3hVh79mfeKkeTZfdIMg+0Eu8LgPlAcF0u
 sJqI/g8V4d9uzKgrzZ/BXeQnluJISBOf2eUFJly8ioRlTlNW/yl4iL92MejeD8JQlK8vzE+Y9
 52ci1g38moEDFtxu+FnW1E/fRkev0lX8holRXlhxw03j456BcpYH8+Hsb0yl1QKzy+bwEl5e5
 Ems6NzF6WnEtJOX6/Rpaywlglq5KsYWrXMuSa+2GDIOMzHqSU48c3KFLjP002+zfF0uupIm6E
 zka9O+ZKJJQ5EC2klD3qFR6SF+Sd99Bo4KyW+HgoUmKqv9kacANzci4XbUVKYrCTatpD2YYok
 oVz55Fd/Vkw3Vtust2hCVmjfsJ9qUglqAfzI7ZUoVoVSTO/Wqg0NNWLYuKOfE5q4LUG1mu9iw
 uSlxFv6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 3 Mar 2017, Jeff King wrote:

> I think the "dirty hack..." comment in read_early_config() can be
> condensed (or go away) now.

Yes, I made that change in response to a comment you made about an earlier
patch in this series.

> I think we _could_ do away with read_early_config() entirely, and just
> have the regular config code do this lookup when we're not already in a
> repo. But then we'd really need to depend on the "creating_repository"
> flag being managed correctly.

Well, that would be a major design change. I'm not really all that
comfortable with that...

> I think I prefer the idea that a few "early" spots like pager and alias
> config need to use this special function to access the config. That's
> less likely to cause surprises when some config option is picked up
> before we have run setup_git_directory().

Exactly. There is semantic meaning in calling read_early_config() vs
git_config().

> There is one surprising case that I think we need to deal with even now,
> though. If I do:
> 
>   git init repo
>   git -C repo config pager.upload-pack 'echo whoops'
>   git upload-pack repo
>   cd repo && git upload-pack .
> 
> the first one is OK, but the second reads and executes the pager config
> from the repo, even though we usually consider upload-pack to be OK to
> run in an untrusted repo. This _isn't_ a new thing in your patch, but
> just something I noticed while we are here.
> 
> And maybe it is a non-issue. The early-config bits all happen via the
> git wrapper, and normally we use the direct dashed "git-upload-pack" to
> access the other repositories. Certainly I have been known to use "git
> -c ... upload-pack" while debugging various things.
> 
> So I dunno. You really have to jump through some hoops for it to matter,
> but I just wonder if the git wrapper should be special-casing
> upload-pack, too.

While I agree that it may sound surprising, I would like to point out that
there *is* a semantic difference between `git upload-pack repo` and `git
-C repo upload-pack .`: the working directory is different. And given that
so much in Git's operations depend on the working directory, it makes
sense that those two invocations have slightly different semantics, too.

I also agree, obviously, that this is something that would need a separate
patch series to tackle ;-)

Ciao,
Dscho
