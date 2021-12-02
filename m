Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53F3C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbhLBPBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:01:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:50469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347191AbhLBPBN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638457061;
        bh=+NUBas3trjEMO4cY305xQWnCZJiesOo0/JtWRD2PUsc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=js4Sh8V7JHsc4iQ9L2egXM1SK+9NeqsTHf6Wq3jhsPxjcHEIup+zXLd+VOMGdkuLj
         Ic/vAq0N4m8lkVR6eFeiGSDlGdSSzKjGc+Eae8gqiewvMr0cL8tP9O8vxhhb/HxstX
         N88cnx52md5pBIOgcTeSRUczvvMfk/NMRP4zW/Iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1nFG472GXa-00MYjl; Thu, 02
 Dec 2021 15:57:41 +0100
Date:   Thu, 2 Dec 2021 15:57:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] t2016: require the PERL prereq only when necessary
In-Reply-To: <xmqqlf14ynco.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112021555020.63@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <a0cf71031781b481b092d0f501bc4d78376543f3.1638281655.git.gitgitgadget@gmail.com> <xmqqlf14ynco.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PTP8BM4yNJoJv8P04O4VmcK3l/pozGrzkW6k+nrczAY4st/S3dZ
 uttmOSX0l0zryCQoyc6B46p3KCWvNyUhJqMQoB4oygdcWGKVtLrUl2LbdK6oOogh3xc14I4
 k1FkCREiCFE6hgq+3f2HnyL530SS+lvfVBpHBkt8Q/FWvL4hDEMMonFcBHdVspMt5zbC6WW
 T89RPudeErgkS7QHbu/kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3PPyTAoxh34=:FyX5l9/33Xu/Y4sZfnLF3W
 STp/ujQ6Nv35rxLLghApME7pEIiV2BRFR5OX9kY8cwqpWY5LUswrItbPRWctdJtbPELzVinAx
 s5dFhab7Q3RVFz1RQNxXxm0WqglMYz749tDuaQdv+8vv6S0wiKRC1NLtkj0SvDJ5TL5K6wdN3
 KeIQrMePk9JQclwH+KU3n3jz2pRVSpHk8MyeCaWggIzysG7g9azFl9m6gWJ+sBrtZrBwIDWH5
 IlvSJsKI+OcmXXVl6PYHw5tK6vA1GcHspuGlcT4vVXuKFeUSvCOBAk+1JADJoycpvLJsj140g
 vT92De7EAu0LWA9etu5zI6yzBk7GMRoaPHLuYLGUKhJI5au8AK/ow2hB60Jm+RW8kLZ1wTXKT
 /5zbC+5DcJuSxEU55It/Lz3h9suJiKUyiOox+xS9sZIbRwuK/fZzaX8dGLhmH8dKlwUiqQ9Qw
 QpMwX5r7PrxYM/axA/EOC5CPVhRg12Ug+s4Dq5uuEaG7cXe1q/EzrnEZu5eFGupfceu5nkrr1
 nGXtE1mfljjoFajzzw/YBHu2ButdPpK4HNox85dY1Q5YEyMCksCj9IBC0TBfXuAsg5+Drxgf8
 M0zkmBO0kUVakroIvF9SC0vABTKtbewmGurALIrHn/q/Gv50n3SNWahvXBxobSDC0YwsezXrI
 k6oBwYjJQtvslWKLVpJmKD8Ln6gwZ2VAoXWVHRhKHPWEXhv3/x0WnH9kIizsDvXAkaGk+DuFY
 zhfFXioqvz9CUsi39gQxz4sNuyLVOWWO1CGfI9zwgDvsJ3ynolAVCUUSIdR80FYwSTtJBTVpy
 4mfAnSnXGu6aXEvx/pKFAfhbUENrOUZzsOq6/GweGGu6j4VTCJRkF1Lc9PhhK+y1/qLdZnFV0
 Me2rGmG12UGmkFsja6n+izEyeychfdghi7eAZwxReOHhlNn1Eur7imUk6ZolwRfeOSRSoAy53
 9Ta8YxFng4R5c8I1E6ahG8njDsg1W0yviU4Jnusr5lUD99tjYdLoPtSsYXnu/ZvX/6c7cuBpC
 9VQ/tGBtxDkNr+pvevAw9w+a0+voPZ2XYqn5rLH33g55tyzVXDxQIoYeAgZkbA0blm602VRCw
 pMPtWfQY7W1rpc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Dec 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The scripted version of the interactive mode of `git add` still requir=
es
> > Perl, but the built-in version does not. Let's only require the PERL
> > prereq if testing the scripted version.
> >
> > This addresses a long-standing NEEDSWORK added in 35166b1fb54 (t2016:
> > add a NEEDSWORK about the PERL prerequisite, 2020-10-07).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t2016-checkout-patch.sh | 42 ++++++++++++++++++++------------------=
-
> >  1 file changed, 22 insertions(+), 20 deletions(-)
>
> Good.  I suspect there may not be too many developers who lack PERL
> prerequisite around here, so it is not like the built-in version was
> not sufficiently tested in developers' environment without this
> patch, but it is nice to see us move in this direction.  Of course,
> when we remove the non-builtin version, we'd further be able to lose
> these prerequisites.

It is probably true that few developers miss the Perl prerequisite, in
particular given that you cannot even run Git's tests without having a
working Perl.

However, we have seen time and time again that developers do not really
run the test suite. For some, it takes way too long time (for some, 10
minutes is too long, but I remember that Jeff Hostetler reported a 5h
running time, and let's not forget about Cygwin and NonStop) and others
simply won't bother. So my focus lies more with the CI/PR builds. And
there, Windows specifically runs with NO_PERL. And you guessed it, to save
time.

Ciao,
Dscho
