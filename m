Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92792C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7731E60FF4
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhGNKQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:16:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:49443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238638AbhGNKQd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 06:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626257618;
        bh=A3EomJx+Ww4HXN3LZJmxs1g7QNOkMRdJzKXeQgh8fdc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jBfHItcj0QyfOzOsN9qPjxUsaRwbezRtFw7wXtJU0OH2LfnafQ+Dp67KQhuOFVbLh
         5WnAzian1fFp79lpDuFH66Mp38dHo2oXupr7zkeRj1oLIBYvJFkKY/cruRYnWAHO7D
         ltvLyw1QzEA+4COuZdDS8gbNoIURbpPXoYvlYJIY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1lVtu40teE-00gVr8; Wed, 14
 Jul 2021 12:13:38 +0200
Date:   Wed, 14 Jul 2021 12:13:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <nycvar.QRO.7.76.6.2107141052350.76@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2107141212140.76@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com> <f305f586-c3ac-a2ef-8769-5468a4c3e539@gmail.com> <nycvar.QRO.7.76.6.2107141052350.76@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1628263651-1626257618=:76"
X-Provags-ID: V03:K1:pPz2xPBvHPEQuOfBRnAylkyVltA82BPTGPozY8zmb48NYGz6Cfi
 egPLgL7oev7WzCc+sRqmXjE4rAOZ/8cparTE9kqs0vPzwMkUk8l7dPCXiV9iVkldRck6Wgm
 hCl5pV/edX3x09tXt+CZqZcQdxYgTtw8CNIXCnzsYgG9tK84dJ6MyTFBcoae+j1sMnKnRX+
 LArxvQ5BmUxQliJJSdseA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+6Ve441Nrs=:GVlHwEHxanQrlOwSgM4WOR
 CB46qEgJCyKt/SKFy7sLXTYXbBXeyhLkre2iKMybk6GrwncGRAB/ybHb4FkEv4x/0uu9q311i
 MVDwXrt/2ujDtd+U+4ldQpTWRe/okWcB5W87rbqsiGgXiEgnWo3tBiCR/thYh1AlH9R2MEGKX
 SgX+tCD4BFOqqYKNTDA80WWPLiNtogO8fHo7gz8l4/trXJ2/5nk+qjEEMq4on197jQuiB6IPQ
 Xw1+2BQWaBOQn6IK5idy0w9q03tPPKdV7bmlvRkMIlLEo3HmUuRfG9OH25JMbSoGnR16+53BU
 B3ZQEMuIqs9lPKBHCVd1UrL5w2sVpvDGisjVpMAT1WxrPRjXiRvYa4vGa0jjW7pau+UCtKW4E
 wOTktTEMZjGrZnDsM3NxU/X1z4/oa87FiS03dpKpj3xpBAU3vv0O13Ujynyefpj/DmgEffUAQ
 PXFjMVKKN99HpLUzr1y1ovODzauDuyWQqWGLs8AnLpZW699Kk0PV2YgHxm7bfiGqXgR8Z6rXH
 5TLoixZzzQQMpS1l4HvGblik5ga0g1GJAyDrzky6xo2gu5wYILIh/ybo15D3xYtoESU/rd3o1
 f6L4gUM2SZ1B7REsF45LauMgtV6GWIXrP8aqrTpUj9SwQ81ZLprRAcnKolBnTDH8JVReEj5lr
 CVs6T3U1V9GvRts954qufN3SXbzFEw1wKf/DlsQ+sNQY9WOIPJ1GEy+VmkcEQx2eLp6jfmiyI
 4U81p0nGx/TVmXETIhHJJRWtl+zpmoRWsA0avE36lHc/ai5cT6rR9cg/9yDS5bmlMH+hVsSSW
 kwyKOd43LP8UrboBc8wEKB8E5hjiYSANYCri/W5mwTuXlA7lgxZ50ZKEEnGJWMjOPUvtMjLny
 SZJL8aIgfC9sqqEuaFmHpsL5tcEUcpsMhUTpqC05va/I2alKLNK5aJkuYDvaPCS/ax/VpyND0
 i17/jfrmNUiJbcGJYNOEqiwmOhHom704aP1r/lNu/t2QPB367VYCxWR5Nku0xEa7WqJgpsYRU
 YyiDFXXqae8yfZYqfglqLjSgA8tB8s1uzQ2Bcj/4SHJpBJiU8iuTVuM18KeBhpUKaRHFh5bIM
 WfqrLVvdpyxbc08zPTlYDMoQmMpbx47RtZE4TYxk2siq9yCmy80z8a60w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1628263651-1626257618=:76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi again,

On Wed, 14 Jul 2021, Johannes Schindelin wrote:

> On Tue, 13 Jul 2021, Philippe Blain wrote:
>
> > Le 2021-07-13 =C3=A0 07:51, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > [...]
> > > +    - name: Download the `sparse` package
> > > +      uses: git-for-windows/get-azure-pipelines-artifact@v0
> > > +      with:
> > > +        repository: git/git
> > > +        definitionId: 10
> > > +        artifact: sparse-20.04
> > > +    - name: Install the `sparse` package
> > > +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
> >
> > Out of curiosity, why is this necessary (as opposed to using
> > the Ubuntu package, i.e. 'sudo apt-get -q -y sparse') ?
>
> This is actually a historical curiosity: years ago, I created an Azure
> Pipeline that builds the `sparse` Debian package for the specific purpos=
e
> of using it in our CI builds (if you care to look at the issue 345 I
> linked above, you will see how long ago that idea was in the making). No=
w,
> the historical curiosity is that back then, there was no current `sparse=
`
> package available for Ubuntu, and Ramsay mentioned that a newer version
> would be required to run `make sparse`.
>
> And when I implemented this patch yesterday, I did not even question thi=
s,
> I was just happy that I had come up with the GitHub Action
> `get-azure-pipelines-artifact` (to help with the `vcpkg` part of our CI
> builds).
>
> I was already writing a detailed paragraph in the commit message to
> explain all that when it occurred to me that two years might make a big
> difference and an up to date `sparse` might be available. And lo and
> behold, this is the case!
>
> Therefore, v2 will no longer jump through that hoop.

*Never mind*

I made a mistake in testing, and Ubuntu-20.04's `sparse` package _is too
old_. So I will reintroduce that hoop even before sending v2.

Ciao,
Dscho

--8323328-1628263651-1626257618=:76--
