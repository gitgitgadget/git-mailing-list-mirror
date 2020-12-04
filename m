Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEF8C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A9622C9D
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLDWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:45:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:46255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLDWpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607121859;
        bh=WYOK1hAxivxlhcvFTOlb02vqiCjam4TCvCAAoUxNuGg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=faxWn3nmTNt2sZijiNnQ44aDC3WGLKvMOvcVrvMimBrJxyFuYmE6Hn/zLx4XwkAMz
         /BPTlWULImSOuzFvHrm8RKQtJIayrSKG63lTqSKYqw0YflNCj1zG0pOGev3A5n336m
         bHokysRmw5T/JaRVgc+7aH/f/kGkPf0b/OsH0s10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1kipdg1mDj-0037SG; Fri, 04
 Dec 2020 23:44:19 +0100
Date:   Fri, 4 Dec 2020 23:44:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: determine list of extra built-ins dynamically
In-Reply-To: <X8qmClPjwYWIoExP@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2012042341270.25979@tvgsbejvaqbjf.bet>
References: <pull.807.git.1607110436367.gitgitgadget@gmail.com> <X8qmClPjwYWIoExP@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+0ctk/utRRpnl+xDok0lMcHJBDdhbQ7YTo9T3NXjKxzIdBvSlqL
 LzKn56kBzHWF+AJnRNUe5H+R+GD6KQCWrEljsnkNsJtPETlD2n18ko/5G9pMKPiO0P4ID7r
 3dIN9qSXdylSqBX1onTFPvZCkBM12W5b8NBJIdCXOed/7qtEPCnH/7CC4sWqVut8SNzKH1j
 q9CbVl18k0bcWtULsNufA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DTsCrzy77UY=:CwD3yZVb58N2NMqw7a0FIy
 UG/ItKp7raP3BjVAEVB8RJAeMfNvRYUCNgPveDa24wlX+x0Eyvn7ve7QTpjurTISDjxAndDGW
 O0/mRNz6yycBO7i7i50u0XlE7dXQrums7/C47dq0L0mtKt2zq37Vf0LxcWd63tIFIueyxNnv4
 MrTspvTvLUYg9VDYxLwuSXTy3s4YgiyDUyO/nOARaC4KipNJdhf//sPcgFV8QWn9C0C00zGrj
 viONjzL77A56biFXHhB/WQg+Q9J023TupMbRSfJXeKvHFslA87jySof7bEZSjgkeRZfqXn/Yp
 WLxvYkKyTaRGS/c/VZOoe5nTSaMC5Wh+EOFNcGzwWIK6pgbKvmb2qvRrs3wMhsg6WXV056DZ2
 z1WVzxdLWqK1krZ2uwbvEepv2QT2AWfUTGGHwXohGmHI1KlHCabKFX/iiLwdJgtdKMvzahJni
 qWF5za8C12ajAlGVwFunkTeVmWQH+GELZt26GByR6fu5/0eOXZg5nIieiiomArBWGS6aYvFzw
 akxmwe9CQ2Pd/OmmhJhT8Nwacm/+4ThY6lLTSGsaPBxLXf16XnUHybzHKhfgB9DNNPrM40eJ9
 zCH5UE9rOFmVzfrydz84+7yUKx5sWT4tJ+FQWaxlYhRFFjR8cF68Z9E/IGwYNKAHw9V/zaxcG
 h6alx5/OKn0SHOcW9ugTlpXhjX3Xw2b+Q3Co0EAEx+QQjxPdDkwPsyCZ381N1Hk5b2tlbYQGQ
 aSopt9I1r9Nn0ONBSItLzdLr4qkzSRrA5SFt6hzZtkCYSmHGbb9HPz727Za4U4y/tgV4gJWIu
 dSl7B4uJfp8koluuL8VmEJ8QDAjMwnD8hR0AWZUfUDmEdOBHHDlYLTKtOOfFDNvrZ//M1143Y
 /X6GyTAPVz8xyNfDt2IuPXmubrgdhd2/4A/0bPrG0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 4 Dec 2020, Jeff King wrote:

> On Fri, Dec 04, 2020 at 07:33:56PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Rather than always play catch-up and adjust `git_builtin_extra`
> > manually, use the `BUILT_INS` definitions in the Makefile as
> > authoritative source and generate `git_builtin_extra` dynamically.
>
> Yay. This is exactly how I'd hoped things would work or the cmake file
> in general. I don't mind following micro-formats within our Makefile to
> keep things easier for the cmake parsing side.

Me, too. I am somewhat embarrassed that I missed the `git_builtin_extra`
list in my review of the CMake patch series...

> >  contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
>
> The implementation looks plausibly correct to me (bearing in mind that
> I've never written cmake).

It is a close copy of the two macros we already use to parse the
`Makefile` for lists of `.o` files and for scripts.

Together with the fact that this patch fixes the CI build of Git for
Windows' `shears/seen` branch (which is a continuously-rebased version of
Git for Windows' `main` branch onto `seen`, plus fixups), I am fairly
confident that it is correct.

Ciao,
Dscho
