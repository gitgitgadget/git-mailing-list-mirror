Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A1C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FE6217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eEGPg0ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgATNvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:51:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:37347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATNvc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 08:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579528285;
        bh=r3GAQy3SBJsknMsm338hVdCS4+aERx4pqwJm3RYMJ4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eEGPg0ZYiu507W2OHeX+NNVkGeaz7UGQM/cdKPZCEnhl+MvXxQy2zQqmZZfTIu1gF
         7DTwLIG+tfcfzcwYR+8/MIhzbpFRf+pMOKmpaexRrTzXgLvQCNggNIblcfdMa7zdA8
         L4PD0n7+ry27xQqFDi7/PO7ZhG1+ob0an0NuZY54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1jK2n839yF-00j5lB; Mon, 20
 Jan 2020 14:51:25 +0100
Date:   Mon, 20 Jan 2020 14:51:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
In-Reply-To: <CAKPyHN0v9eJWXBCmBS6kdPXx5F8CGE_P3hSfb8+vMaPTF9FWug@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001201450050.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com> <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com> <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
 <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com> <nycvar.QRO.7.76.6.2001171428170.46@tvgsbejvaqbjf.bet> <CAKPyHN0qY5odXi2wAv20D4nsNM0r4qO_8JOx9DHiGchJmS8cbw@mail.gmail.com> <nycvar.QRO.7.76.6.2001201221350.46@tvgsbejvaqbjf.bet>
 <CAKPyHN0v9eJWXBCmBS6kdPXx5F8CGE_P3hSfb8+vMaPTF9FWug@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M4LkPiYqxcNLPO2DfKbZ0qNBC/LXc7dDnik9i5nhj72EZWWngRo
 FBUgefvslJL+0FypG9GsJlgvgbADWeTmJEfA7OHe3qh0Sz8BDxJFQvtX6DIoGFOm99BN4gn
 +BsI4K5ANPzzgXhVtUzjxoLpdDnnZjWaTWiBEoGE9+xaRqSOMX0XEbyvkC0/TTdi2oXEs9n
 runA49FbOe9BuIcTvm7dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:44VPAEn8Iyk=:Owa2Gn1YC5vrSr2J7/xoaI
 84MriB5wm7+lTUNUeeV/Mc0I5aC2NFdIQbWcpFUeY8wpA/mhn49qmWN8O6TtEyWYbVFsBU8s8
 6w6nFGgz2GExxtLx6Sdyjtax3XYUoyZveWBMEMXSGuf8bPaxhpglmTA5dgfle5pC+n35n3v52
 4y2h8DqQM5jq5a9zOWAgAV4mYKGiwZWO2oxW0uMAX1oRgLB9uMLEPWMoZwTUzyb1YO6C0zX5z
 H/2KtYKkCFg2ebGkFldKDMoVfHokjv9QrQaDRZzCQqftzxzHy5kRYYof05zKoyYU4ulXHeNQ+
 WJub/RjmVmf5mTQLPsF+l8Gf+ZKLjf1P9/GJxnjK85ajZC0kuwGTJVH8By9Ax25hpjTXmnsOz
 GXjjYRVRG6ZwhEJ+ESmexyE4pUcGgrmlwJ+dpf62L6Emr9FCDb7PpF1XS2J2l186612Nbe/rB
 71Jlx+nSYbQcSbAVXEhvnaRcINzEadx2BsdVk1eJ2EnfQZG3NkHBpDHsjryurJkfNXXJTSCWD
 haMFjgZLTts1ChI14Qg01RSdaZN9ehN5k5y1ZpJ+Hp5AOv6sc4iLmqJGvpUZSHFcQD7WNbGe0
 nhNPqX0D0zoBNxwabzJOwTXAvDvZJAM5IMbvq0scxWHsPqza6mvargW3CvaeOh3qItmcZnmdd
 SY+XXfaB88p5fmBBmY8e+FapjfYK61uJJJq8UinzPk/iEiLBiI3ljzppHmYI0mSuKUz6vWjyF
 IA2hQv9ulmEmkVvqFZMoqOI56q4HnVqMOZWZLFZhEjSBm8mGZWKhSLy9OxmQq6jKIBOuDc4gB
 237Y5m6BH0yb/PxASKvRDfJBvMI63gUaQnbIaDxEfVnkIMkePrkzwN/dKpHDPM4bba1gWpzbw
 q45S0yeTYcbapbdu+uQvsT6UKI5QXY71waNzLjMdcK1BMXBzLtSZcKUs/V2Obj31YiEV3zrSF
 ztX0MY1nZ0wA0sOWVa1auDuiiQyIx96HgMtpiMzKXGN3Nj0EVcxX+0p8kmyWs4o8MNU6SHoUz
 ZvqXpXd/YBaNQ+WWolG/1e0/P5kGBS9hdO0Uz8AHTM1PahAfNB0j/d8/yiq+WPdnH5EulPjOQ
 z8A5t3YxBKW31cGLsN+OtwRtqOIuS55aEq13qIwj3nWD4aFn8gk75LRmoi4qfXwjngrea5DkG
 hffSWlwUGuNJj6EZiyZT8GjJHGPAmAV/X+MlygOQevAK08CojFh10lnWmtvxdGPAyvlfR3NA1
 jk2KPBts+PlnJJtyI199D3z30hUWglewivGbWQ6SYapiSuHjDXLZliqmKNB4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Mon, 20 Jan 2020, Bert Wesarg wrote:

> On Mon, Jan 20, 2020 at 12:25 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Bert,
> >
> > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> >
> > > On Fri, Jan 17, 2020 at 2:30 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> > > >
> > > > > On Fri, Jan 17, 2020 at 12:50 PM Johannes Schindelin
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > AFAIU, the value of remote.pushDefault wont be renamed yet. So y=
ou
> > > > > suggest to issue a warning in case remote.pushDefault is X. But =
as X
> > > > > does not exists anymore after the rename, the value of
> > > > > remote.pushDefault is invalid. So why not rename it too?
> > > >
> > > > If this setting was usually a repository-specific one, I would sug=
gest to
> > > > change its value, too. But it is my understanding that this might =
be set
> > > > in `~/.gitconfig` more often than not, so I recommend a warning in=
stead.
> > >
> > > than why not rename it, if its a repository-specific setting and war=
n
> > > if it is a global one? If this is detectable at all.
> >
> > Sure, but you might need to re-parse the config to detect that (and yo=
u
> > have to use `git_config_from_file()` to make sure that you know that y=
ou
> > are looking at the repository config and not at anything else).
>
> I found current_config_scope() which serves the purpose for me.
> Anything wrong with this approach?

I guess you could go for that, even if it is not exactly elegant (and not
thread-safe, but who cares about that in `git remote`...). It would also
do way more work than you need.

If I were to implement this, I would definitely go for
`git_config_from_file(git_path("index"), ...)`.

Ciao,
Dscho
