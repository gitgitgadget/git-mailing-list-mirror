Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F75C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhK3LuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:50:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:57697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241227AbhK3Ltb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638272764;
        bh=+OlZ8E18J66mhUd6NakADaS/D95CjykQNZqxJ2ATpj8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hj2m5tj9gkgcJDJgDNhY8lxS106D3atCornuTdkxvKahI0ISmEuaKWPw6w8PwhDce
         gqsQZHxQmyC/SM16eNzxV0OlLeqLbBS5CqmvtUioAk44E03gma+ST/xfKtt+Phy0lj
         fpPnXQ1YOwFGszeMi9MkIOHnLiKZwzS0rdVaCe7U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1n7XDY27E8-00X3DI; Tue, 30
 Nov 2021 12:46:04 +0100
Date:   Tue, 30 Nov 2021 12:46:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
In-Reply-To: <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com> <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com> <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet> <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-898605708-1638272764=:63"
X-Provags-ID: V03:K1:RfFF1QjeO+t/IY1N+xSKJSrgVHRvggHoraIuc+8OLf3YxTHEiF/
 5Rr83QNkXWyq21B3lqPu8tD+7yHNpBQtQXPwQpWVMNvoySNNjBGp1YE5LjMRll+BB4pLgyh
 xXtHPy/j2cPG/ZfNvPgXyTsHCmwAN/NVbQN7+GM4YPkbTc1cpjhHwQ3NNbr9lF8nAYKkYDa
 Wb2VUu89GjGtiySxOzIig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZMbp+V+oFWs=:ylEBSeg30SAnlRcp5Hp83s
 caPCXicSKezQQ5rbUQ7jX67HXh/XWv/3d5xtnrGNWsWT4cfMeo52nH+TJQq7HRPv/adc4wP2n
 lbTRVbQcrQ3gCi0z8Hf38OASbfsE8zSeRoCGywNdMCY+vzpWeoLFvwGnGz0X4p+iH4ghf3ges
 YEoxCIMHSF/zY2E8GF2o/5UOLWSCSiw/C0cpUQLuy1lrpQbYANnbBZv5Se2svx3JIQetpxWzK
 +MajXiokpjhIOH0XhM5zrgiRSfNCe50hxqp7+mxOAeEYLAitm/lzMT5els5XgvgHdzNDxOEtP
 pmPQjIMJCuiApHYdZTyyLIIpqqzvxLCh2oQTE4fZPcjYv/PXwz3rMsnLykRzPiPJMg7/anRrI
 jvNal2tj3jz5SkQ37lp18CqgUC7Hr9qssvhZL4mNzw4MuY4O8oaGK0vVvtymI6aKyiYqJ9ztD
 WWhsr1T4Ky2/LLaOObS07tDnL0f1KXRgcQYdASiAGyTWnq5gixfKaisOxiOZlmRDAY+7UAXo+
 CBRssuD1JSrOgdk+0PNLLhJQnWERQbLx3kTtEe6Aurx0ZK5rBGHaEgK0pxU1yrA6kR295rC8m
 MRF60MWSEvFBNj5gADdozIxEiSa+ropymm8/vBHHm3GEz/RABXV8DjCatKY6P5pWElfLqQvzj
 +oGzYAw0C5mtOs59q5FVohlAl6kO0mGtdwXaURsqNI4HH18d3LLmGtLzFcld6T072qHhXFd2w
 XRTuPWNyZisNfAeI0o1Skn/ln1Kir2mkjWr514TsDtA+YapPlSImh0f6C3xI3YxsVTS53HaMo
 MlLpdlwVT0jDkgrKP2bdAqaUvYK7+U/pbmqADHHecsrNw5NNjAdBZ4K4r8C1/jS7jwYUrv4d4
 wHMBdZ+bakrb1CcGEwnJ92q+gQULdtY/dfytpoIyM3T7a2BDeimI4csNZISBsMf5bQWlJqmWL
 0CBQxGmH0MFXBpZ6Mi+hukTpbGKA98mb7VV4dosP8ktm5KNYAJWfMrapYvBxBs9nWfFQtePNI
 OAviTfS+MDeYOEDJ65Pp7L9vD0wyDBewBvPWYrbOYUTc0MXImm5tblJNWFJQCb5PZQKGnN99e
 flIAfSeAPbUlHo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-898605708-1638272764=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 29 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Nov 26 2021, Matthias A=C3=9Fhauer wrote:
>
> > On Fri, 26 Nov 2021, Johannes Schindelin wrote:
> >
> >> Hi,
> >>
> >
> > [...]
> >
> >> One thing I had not thought of earlier: do we really want to do this =
in
> >> every fork of git/git? I know for a fact that microsoft/git has a ver=
y
> >> different workflow upon pushing a tag.
> >>
> >> So maybe we need something like this, too:
> >>
> >>   create-gh-release:
> >> +    if: github.repository =3D=3D 'git/git'
> >>     name: Create a new release or update an existing release in the G=
itHub repository
> >
> > I think you're right. This would have unidesirable side effects if it
> > ran in forks.
>
> Rather than hardcode given repositories, which e.g. for testing the CI
> itself can be bothersome, perhaps a better thing is to put this into the
> existing ci-config? I.e. git/git.git could opt itself in to behavior
> that would be off by default?

You probably missed that the purpose of this workflow is something that
does not make sense in the forks of git.git.

Its purpose is to create releases for all tags that are pushed to the
repository. Most forks of git.git have no business creating releases, and
those that do already have their own processes in place.

As such, the situation is very different from the CI/PR runs that some
contributors might want to restrict to only certain branches in their
forks.

> I don't know how much that matters in this case, but I don't see why
> we'd hardcode repository paths in general since we've got the ci-config.

Integrating it into `ci-config` is not even possible in this instance
because the newly-introduced workflows should only ever run on tags, while
the `ci-config` step is part of a workflow that needs to run on every new
push and PR.

Those are two very, very different things. So even if it would have made
sense to use `ci-config` in the workflow under discussion, it is not
applicable because that step lives in a different workflow that is
triggered for a different set of events.

Ciao,
Johannes

--8323328-898605708-1638272764=:63--
