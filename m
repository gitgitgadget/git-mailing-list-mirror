Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4178EECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 10:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiIGKVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIGKV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 06:21:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912EBB90D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662545916;
        bh=VAmMIKQQTNO4ZRTRYAmGsxeWSJ3qkxY5SsbTkANWdrU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ixCjYUnn++3nXZu80LCKqHSwGumBlMC7zg0v4HNDL8Mb1GD1cks68nckVcXY/8FEh
         ygOkZhLpZBwW+F9bx2bgPgWDPOTt523gPwb3icKyGDg5k9xJGlXPRgkaBrpSHkBLpv
         m2XJha23Fo8PSg1NjrurYlZuFvq30D9sUKuaWLRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1ohdI70oAd-00P7pW; Wed, 07
 Sep 2022 12:18:36 +0200
Date:   Wed, 7 Sep 2022 12:18:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     ZheNing Hu <adlternative@gmail.com>
cc:     Derrick Stolee <derrickstolee@github.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] list-object-filter: introduce depth filter
In-Reply-To: <CAOLTT8S2r1gzyF8YAORuGwian+QwSniAPd8br0xn_P5gPyxpgg@mail.gmail.com>
Message-ID: <o10o218s-2rq4-9n3p-86np-rn79r7qr2139@tzk.qr>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com> <a14028be-2fd2-258d-94f5-c010669de8a6@github.com> <o48053s6-5540-1234-5roq-92q6981r2306@tzk.qr> <CAOLTT8S2r1gzyF8YAORuGwian+QwSniAPd8br0xn_P5gPyxpgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1192269293-1662545916=:189"
X-Provags-ID: V03:K1:8wZDfOteEUQSNcwr+pVxPJypcrL+ksAauaEP7uDKQjGwS8MRPBZ
 sM95y2zAw9Uc2vyvmr4o1BfT8P6v2UcILD6U2pDFz04unJAMkNHTjvz7fENxEC/1mFm+ecb
 XS6TdbKQtniHliYZd3JsLTpQcVPZnqB+oqCg1aq+hkETCdcp7D8Q80BhykMHnzOtZH0CUbT
 WC+rxdtScuPnoeWOYCfwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KnvZpgV8dO0=:09tY7tGxpL576Lk+6fwBX1
 R1RzyirD3EhNCFPNP7utF5YaVfeEcN0fu4Xx8j+jSWLbQ0ZK7Yr3oU8OBaL6hD++Qfje8oWaO
 5TfbjF/XkuqBA+2y7iZIjGwyc6VMoWg2wI5aeGK1HRBo+Fusw55+D8Yuugk/PH85e1YGfb3U1
 gQ/rEq5q+UAfdi+qRXBp0zqxue42pMAdYAytWPxY2osdpYnzQoj+UjsNrC4Yb+zoefXFKQyse
 nJ6+LGaCVzNpNqbmqriKZjv1joschzCxBTXyTBy3zxVpDx3MHIg3tomOrGzqARvTS47YC+l+F
 PFqPPYSJTx+f3wKvgBnf7yAXP/fFnCaxIpSWzbMfRAz3sFd9Tz7du97wEZmThUhn87YcuWgSj
 /fiB+Yp1Vwy377/zc0bA8j1y+5ZHp5sQsDwqSAh/eJr0EPFIDvDaYUeF2rJRMOqXKC7aZTKp7
 5AGVPT0mtv9etZjbm4CLwK4Wl6y9lt0sfRFtlPMCiRC2W7slct4TMYYLlzTqG35MYLFiutqUX
 QhJ8qhxYVifyJvXhs9J+E4RhkQ3LqAv/WMaIJut7y+uJY1a2HXHy0iv0kHZDqkuU4Q9giaOBU
 AY0husKdL1XIwmuBYJ4L8Veq1BscirKBRqfM04LPqcZcTyBlDLB30TYUsZWqcDR7r+gut4fHA
 reL9NpiAdupgo8cA3HgY6z1y3IIsBtwsMXSOT3qjwA0z8eEOdSgwR7ZejIsd/y1Vck3Xd1pJX
 m0KJ/iNYo5gb7lK1Wp7pHh2TQ98GcF2vgPgNfh4vXwzIspDsFYM+d1KftwdrZjSKKPL8WxgFW
 zJa9AjHW3on/wQQZX3u0UXUDzrNofIFchXUIs7zETabKZxRS0RRuvB6xDx4zkOLvD7RDe/71r
 Qc5Tf/iF8+htV6bgyxftfdsi1V08ww+CkfzeksE63deqZUJwvp+3dLAEVHtXd/3o40SCgFtYl
 Wb5b4+MLA5KI9IB7fLxT9nELNdgHGfKdKQHrDgPYKJzzJt1cCMeLZud8QmaO9x4xLcl/cYzQA
 AqKVSXBaDY23dQDWTaIaGTs8BIHo2GaYgdwo3DEkjSe4Mm6waE7S40GagSc72MtBaO2CbWPeP
 LXmZTZGT3K9Ou91val+fVySsnWkiZIYbs+17LzO9DOrZrYPk55yD69KmSRup1grZng9nZl08v
 jvCi+AUT9+ttY6LxnjPKne2SsS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1192269293-1662545916=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ZheNing,

On Sun, 4 Sep 2022, ZheNing Hu wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2022=E5=B9=B49=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 21:48=E5=86=99=E9=81=93=EF=BC=9A
>
> > [...]
> > When you have all the commit and tree objects on the local side,
> > you can enumerate all the blob objects you need in one fell swoop, the=
n
> > fetch them in a single network round trip.
> >
> > When you lack tree objects, or worse, commit objects, this is not true=
.
> > You may very well need to fetch _quite_ a bunch of objects, then inspe=
ct
> > them to find out that you need to fetch more tree/commit objects, and =
then
> > a couple more round trips, before you can enumerate all of the objects=
 you
> > need.
>
> I think this is because the previous design was that you had to fetch
> these missing commits (also trees) and all their ancestors. Maybe we can
> modify git rev-list to make it understand missing commits...

We do have such a modification, and it is called "shallow clone" ;-)

Granted, shallow clones are not a complete solution and turned out to be a
dead end (i.e. that design cannot be extended into anything more useful).
But that approach demonstrates what it would take to implement a logic
whereby Git understands that some commit ranges are missing and should not
be fetched automatically.

> > [...] it is hard to think of a way how the design could result in
> > anything but undesirable behavior, both on the client and the server
> > side.
> >
> > We also have to consider that our experience with large repositories
> > demonstrates that tree and commit objects delta pretty well and are
> > virtually never a concern when cloning. It is always the sheer amount
> > of blob objects that is causing poor user experience when performing
> > non-partial clones of large repositories.
>
> Thanks, I think I understand the problem here. By the way, does it make
> sense to download just some of the commits/trees in some big repository
> which have several million commits/trees?

It probably only makes sense if we can come up with a good idea how to
teach Git the trick to stop downloading so many objects in costly
roundtrips.

But I wonder whether your scenarios are so different from the ones I
encountered, in that commit and tree objects do _not_ delta well on your
side?

If they _do_ delta well, i.e. if it is comparatively cheap to just fetch
them all in one go, it probably makes more sense to just drop the idea of
fetching only some commit/tree objects but not others in a partial clone,
and always fetch all of 'em.

> > Now, I can be totally wrong in my expectation that there is _no_ scena=
rio
> > where cloning with a "partial depth" would cause anything but poor
> > performance. If I am wrong, then there is value in having this feature=
,
> > but since it causes undesirable performance in all cases I can think o=
f,
> > it definitely should be guarded behind an opt-in flag.
>
> Well, now I think this depth filter might be a better fit for git fetch.

I disagree here, because I see all the same challenges as I described for
clones missing entire commit ranges.

> If git checkout or other commands which just need to check
> few commits, and find almost all objects (maybe >=3D 75%) in a
> commit are not local, it can use this depth filter to download them.

If you want a clone that does not show any reasonable commit history
because it does not fetch commit objects on-the-fly, then we already have
such a thing with shallow clones.

The only way to make Git's revision walking logic perform _somewhat_
reasonably would be to teach it to fetch not just a single commit object
when it was asked for, but to somehow pass a desired depth by which to
"unshallow" automatically.

However, such a feature would come with the same undesirable implications
on the server side as shallow clones (fetches into shallow clones are
_really_ expensive on the server side).

Ciao,
Dscho

--8323328-1192269293-1662545916=:189--
