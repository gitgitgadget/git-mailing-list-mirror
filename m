Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BEBC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1A5610A2
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbhICPyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:54:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:48461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349740AbhICPyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630684416;
        bh=tb+FUcK56q3dN2NQksfyW/tF5pdT69KbAr1YX7NKsVA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MgoNAtyIHZ6aX0KT2xSDuV1oIuvGZ2+By3ie23R3mSC/8WWp6Mk82M4IT65fHlhS9
         yAR/Z8MCtBZDIphUJJ7IuKAwbyg3tU1fk3pnUYkBlP/uZLPi4EKrbxKsTEO6xjCuMs
         ERuWe3bbraX+kbKOKP65O2nPJ7rPd4sQRxJFXdYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1nE98m0jw4-00s2bP; Fri, 03
 Sep 2021 17:53:36 +0200
Date:   Fri, 3 Sep 2021 17:53:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 11/15] scalar: allow reconfiguring an existing
 enlistment
In-Reply-To: <874kb6xbf9.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109031750291.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <13056f02018542f8143e4933fbe180a0a9f77004.1630359290.git.gitgitgadget@gmail.com> <874kb6xbf9.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1470407212-1630684427=:55"
X-Provags-ID: V03:K1:DKIohC4dKzN/j1VZaaDW6bZ80W1gQxQ36PilRGXBg58HGHAHHnV
 KGPfGzQ5RW7AovGO67gcARMLNONf6NuORd2WpIFSKJgf4K0DsES7wgMsWkr9bRNfxN7OWhe
 rJOmrCtZqpa042gp5ElVJllvPHHJj4rBcJAzH3CuthIqow97a+q0O1qtaBgRkE1M24QxCMt
 RWfWqkqHO7xu03OPCIJfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JIBDYKZgFk4=:hmGqLijCkF5UVa61gqXgWR
 QfnEoaVMvzNlkDx/fPZCY8rqj2v0uiM/unxRCiM4YtHaG2iaytFaoQiKhyEM2Aa+ygv4OBoMk
 azRDOyrEkUhf/PSuktOaKhnzStUsfSBeAJ2KP2P3f1Br2aKjVnwoFn/mLuTx+sFDVOT12e5yE
 v3n//N7Is03boDWJwyCYWhKD1N4ixtHSxFWG3Ke1sbZwxWmd3o7w/SXcNFlLZbWDPgA7hk0OX
 Tjxh3FaHdQb2ac7Upvktudp+PNB2vkSHJP2fI5+4FFMpHJx3cxBfFlAe+YzPITWDNQzBTsmhl
 fBHzDnbKHdkglMKob4yDdK4Ch3Ue1PiUhvWU5mqCYRuqNKceoBdUN8cs6ifALZcuSMoWPVloe
 QDlFCGLJ0JL/YLfM6d3kPkoKyqw2jdzhGBpO9ohjGqGNIAz9x5hhKEDQzcOv+y+D5v24ib50f
 reMXNwWRWTBnBSUuXK6X37kQPz2GD3tOM3CT34r3mcsC4HM7Oxxr+xss78X0ys3ItjJ9lGdFK
 PVnFZnfVAz1hxrDMS466A9UdZwI7PW47LMBSL0rLvIM4ceXHkZK+FaXwwCwQzLZPnVsXX1nVR
 +eSqX3s8oXuMmW2ltY8p+ieM//7QK+q4hb/auAjZITRX/12we++gezc+3VwiiIMkylq7QLrFv
 s16SU3XcTnG711fuS7+a5zbO/1En11A+E3vsjNISs7C7pOfWnLMOJbjRrsllyrDjgkgMhprOw
 tnhCI4u06XeeEXjt/nJGabLVqmjvRNdFOn0SXH8CFZqhdb/PrDoG6ejp3d0TVqpiwG0MnEF9r
 0BNjY6lRFjNgfWMWT7MJ4SM5SviwVOJfWDheKeG73nRdY4zuOG7HBVxpXKKUN9mh+ig41w9I9
 GidHsE9fngpqS8eLu1v2PojhvxKpfE1l1a8+bz2CET6468C0PDcOWxIxvfHyRqnQqj8dfzv9f
 H8K6FrmGaVYZTe2o9nPO5K2pYcuSeARi8LUPdaLEQV2uq40UNUU7TZwul9bSaMGxWUkI2Sl5k
 4rvTqoQaMv6TSF46nTtpJPk3Jx9TAuVMS5mj3LLeQnZ20iohQ7QvOISfD8dFg/aRH7Ggz88XM
 CAsdGJtXpt8ulQf9U3xEhdYvcSncbbjhs5cDFOl8iFB6DkFFrTiJy8U+Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1470407212-1630684427=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 31 Aug 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > This comes in handy during Scalar upgrades, or when config settings we=
re
> > messed up by mistake.
>
> > [...]
> >  		const char *key;
> >  		const char *value;
> > +		int overwrite_on_reconfigure;
>
> If you make this a "keep_on_reconfigure", then ...

I do not think that this would be a better name, or that renaming this
field would do anything except cause more work for me.

>
> >  	} config[] =3D {
> > -		{ "am.keepCR", "true" },
> > -		{ "core.FSCache", "true" },
> > -		{ "core.multiPackIndex", "true" },
> > -		{ "core.preloadIndex", "true" },
> > +		/* Required */
> > +		{ "am.keepCR", "true", 1 },
> > +		{ "core.FSCache", "true", 1 },
> > +		{ "core.multiPackIndex", "true", 1 },
> > +		{ "core.preloadIndex", "true", 1 },
>
> You won't need the churn/boilerplate of adding "1" to everything here,
> but can just change the initial patch to use designated initializers.
>
> That along with a throwaway macro like:
>
> #define SCALAR_CFG_TRUE(k) (.key =3D k, .value =3D "true")
> #define SCALAR_CFG_FALSE(k) (.key =3D k, .value =3D "false")
>
> Might (or might not) make this even easier to eyeball...

To me, it makes things less readable. There is an entire section with the
header `/* Optional */` below, and I want this list to stay as readable as
it is now.

Ciao,
Dscho

--8323328-1470407212-1630684427=:55--
