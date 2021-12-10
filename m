Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD5C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhLJWwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:52:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:37351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhLJWwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639176541;
        bh=wuKG9b9w+MGNt+ueL/fmNC3JrvJyyfX3CsgkhOsxnwU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZG+21qpTqSyhy4evj9lH8oZGtCypMo9j79df1Rh7ENCH/XjcDEbJO/TcX2LN4YN0U
         gIAyQsjqcTikyQ9z1ZGpsSQ2BPOKdp/EBJ0Mfp38Myndh56OFa2hXhcEnd+ITfRes/
         JXWPt8B6ut5Gn+eQzYD+pJYYbVL2WFtSzL5LK0h8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1mR6tu0rfr-01690W; Fri, 10
 Dec 2021 23:49:01 +0100
Date:   Fri, 10 Dec 2021 23:48:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        chooglen@google.com, emilyshaffer@google.com, avarab@gmail.com
Subject: Re: [PATCH v5 0/2] branch: inherit tracking configs
In-Reply-To: <xmqq4k7k8cz3.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112102344370.90@tvgsbejvaqbjf.bet>
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com> <cover.1638859949.git.steadmon@google.com> <xmqq4k7k8cz3.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YVKjx+MGQjR84t1z7ac5fZOykx3zj7KiPCjumowqU5mrA0GoxON
 Jnwg7N8quV8qae2/LmnMoXeaXPrpwW19Ya9EUwjyRN94MSrTInJ7ovWUIxhTpAWtYknrCHM
 6dTCMyKUyKCG6XCFW4S9W3kqmkt9j7ot4EwCX+r6kqqmuFLl5bnYv/2hw0xagcHHItaGJhT
 55ZKUvR2nfrRE6LCJdqJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hpskn/oDrYk=:0Bumf/WkLUFusoGDn2AcXV
 uxZjDRKzJabYmL1mKXh+3fZbxqy+3DF1ylNYUYfFgTmvafo+EV4icOb3lMnl79OwfQBQSwbJa
 q50Fs+zkJgURu2vFZtZwqbOC1/JTAhCZsqGPOvvdFriNMTj/ftvac1gkz5vt/5+Bq0XZwpvLY
 BiUt7sh9o2Dm8XwwN6RZkcf5jk0RcfxTvGY6xYwhTNE4IuQKNZd8YYWJME/gpjNKjgEIpBnwT
 u1B19pevuqDy59LgVXqgyS0T6lN3Lock1DQB/wZsJGib48snavPFNYOG5J5HwawA1llrX9BEn
 Q2VO83Gf6wCX3YJh8v6ty+2TqNV6DStnBJxqFiBir2Qzpg4Ja7yf6bqxCH4xZg2sD8+2qA+o5
 xtUJmgcjPpwAfmzVU8wyNBWMBcXOwlLiz4KnbfMIN2OVTKdC2Ow6m1Y4yfJptbnHEwpxgJPC5
 UV9d4WwjNRNSZP79nx90gXmMAV9d5Tr5oW7h5qAm9JjKrBt0oBTFKO+f9Stu2dMZORMtYipge
 Ei/hmoNxAl65IIT+8RQFlSpKXOjaSAvKQqwNZkHEiMkJhs9EUXun1TYC4FlI2Sy4UMFfYGzYI
 QRAjywl4M68LlbFaFr0axbfoiHVgCXWHFnrozHzZORjVi3L4RZVz+Kh/iV68tnxVTHezIRMKk
 ZYB7nfFb+sBdFT+TkEL5mFUfW7+jTEYfPvdU3apgHNfvH1x2GuM+x+58ru+EMQ62ynfu9bCTY
 ZOFvR6P/EWdxu1ky5ZO3hU470QNdyG7KtYZZ2rLCyMN/MFxSPgS5ldFPsO1LfD+e+BO/wChTG
 9dalxWsj8tIFGC16hgGn9BEpaQhfoZmr5n54eki49lMM3PCpG69S6lMUN1ddR0oLDcOfUL1Ub
 kR8zIN4ZR0oZ6hg7qThra7ImBILOm44GesdpOQM6rDk7Oc5b8olx/kQpqg9nM6dZdqfqqIrAV
 B+kxoldi6kzCw2soTL64xsyCmO2Qz92rtu87RjLOedwLyXIJTEbdfapNuuYNGpyV7BXxMno3X
 5vMQ+5P7I7jT+0T4+vgdO70sOaGk/dquFMGFjGKSb6TtOqIkUyqOq7nEctbeLhzTnr7T0oeZU
 Hws9LY47rREZ1I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 7 Dec 2021, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
>
> > I've addressed feedback from V4. Since 2/3 reviewers seemed to (at lea=
st
> > slightly) prefer handling multiple upstream branches in the existing
> > tracking setup, I've gone that direction rather than repurposing the
> > branch copy code. None of the other issues were controversial.
> >
> > In this version, I'd appreciate feedback mainly on patch 1:
> > * Is the combination of `git_config_set_gently()` +
> >   `git_config_set_multivar_gently() the best way to write multiple
> >   config entries for the same key?
>
> IIRC git_config_set_*() is Dscho's brainchild.  If he is available
> to comment, it may be a valuable input.

The `git_config_set_multivar_gently()` function was really only intended
to add one key/value pair.

Currently, there is no function to add multiple key/value pairs, and while
it is slightly wasteful to lock the config multiple times to write a bunch
of key/value pairs, it is not the worst in the world for a small use case
like this one.

So yes, for the moment I would go with the suggested design.

One thing you might want to do is to avoid the extra
`git_config_set_gently()` before the `for` loop, simply by passing `i =3D=
=3D 0
? 0 : CONFIG_FLAGS_MULTI_REPLACE` as `flags` parameter to the multivar
version of the function.

But that would optimize for code size rather than for readability, and I
would actually prefer the more verbose version.

Ciao,
Dscho
