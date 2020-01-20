Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F73C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8F2207E0
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 11:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HWmtJJaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgATLZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:25:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:60593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATLZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 06:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579519525;
        bh=AGqdR4sH4/XrWHh+jgn07HvURVDcfMOeaDu3Mxe3jFY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HWmtJJaHAWCP8tKl+aqVNiWVh+ah1ruVwWaVzstHpNMJiXfIOD2o3lnYoTkyUCpUS
         tXj40fSJM9c1lFMOEg4r+LhI+K2aUMEP/JTljqzGa7okiS/fx/7+5XZ+dVJsuhF2VS
         4KA+LwyCgRR9ZrIKnyvA0lQ2WwFbZw8K9pqQ+1Rs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1ilY9h3Wmb-00CSVI; Mon, 20
 Jan 2020 12:25:24 +0100
Date:   Mon, 20 Jan 2020 12:25:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
In-Reply-To: <CAKPyHN0qY5odXi2wAv20D4nsNM0r4qO_8JOx9DHiGchJmS8cbw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001201221350.46@tvgsbejvaqbjf.bet>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com> <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com> <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet>
 <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com> <nycvar.QRO.7.76.6.2001171428170.46@tvgsbejvaqbjf.bet> <CAKPyHN0qY5odXi2wAv20D4nsNM0r4qO_8JOx9DHiGchJmS8cbw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lnmAwxtQ/3vV4h7DS1ON3BGeoe6q5DAvs7WSk2JxKXmK49wqUqq
 w1l0lNbftIa33A0Q5n5lq4XNQUV15FXcRtfVRmavwWrJS+0FocG7+wJwB3r/P6Z7tDtARrZ
 kvvpwL/wN3Rhhv7u+Q/DwoEDkuxUtc+1GiKwS4fSLAERdtDbBUL/edrJCmhw2HvjecpdxxP
 zn3YRL/RIP4Bj5+PhrCLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vsEXVgwUgfc=:kZIy2U6zoHWRxnrPAw4oWu
 zrrGtAepXoqPKJkCpDLUBmXsho3GuU9NFJZ3J4K+uUaQ0SGJgZI86IGgThW3qGru5ocOwvUVo
 8XhdP87YjnaDouzbrJcOo2vLMxbKk23nm//xV0hyiSAIfny5gsOwpiTvztGDWEQLy3UUUlzmG
 CJBY4VnJ6qFFtxH0BsqTbzh+L1GwhuK4nhWOUSBWxEQ5r1qNh2kJ6qgC6lYJcEvCHj6YPId2Z
 rSELVS8WOFA57U/SdLvsRYsZCrysGOJYto16rUrkLZTlo9wHr8bt2TJ7N/jXggOogvImYUykZ
 7RblEa8FOw1A+OIW4HSF50iQ/UuNw3tgUn1tm38o7x+t511VuhdqHMLkguCrivVxTzhkZ8qTw
 aA6jSCsaZZhJtDuxIUGY4Pl8bPxLd/VbIGMERRYmoUOK98L/I0HZQSqFm6G9a6ZrbfRWnOEAf
 nYaekgNMfdM0AjkdNcHDr93fAcHxT/QTUwS0H45z5qgVIAx8+2OtUIRITsWGJjeP3KUmLVW1P
 4XoApAB+IiKED+UlMcfEtN0RYhW5HKblat03wteBnzuJ6vHueHrS9Nd0zERbmvM2McPd4ZQd1
 WF34G0FQpZ1AFnsm3d5th5OWuR8rQANetLbnF4955mCSpeWS1n61kHGnjGUtRpxdl1nAS7FRv
 JsimtQPeYwvgLhv76mVF9mD9vCJvE5VVFJK5ykcaRZBc6i8El+bK9F8uo9MSXVQWwNO+ONzgE
 mtK6bsqK5tHRuMlcozaDH/6CqGxDiTGOlQDwceSlb1cj2tMmD+DJbiopDF2/Z39mH4E7sZVz5
 BMbJW7WtFYAQuSXPrMYo5tuRXt58C+6Xe1HiWo78biRJ8XL2hJhqSqmL6tZeb5Y06RmIpRoKV
 GKaBnh6Pr/0GJ6cIpz6mNZ0AaAj4SbQVHUFzI/fVW+AMKPrBlW9U0IAsBd2ZQB0Eaq+H0HBef
 eabMGtK0TlW4hSVNEM3Fjn6yixkQi286hdQkck5REhJnuKSWD/ut5eqfeHJckoH9JW45ihRtZ
 rP8kxSw29+z+gBHzYCafiztOxvWjMKtn3ZQpnPmM6wtwUBVehxAj6cfo1K4gm9Sz8ePSF2DGi
 YSYZe4Pq/ePxW7z0W0XMSaX8jLxo9XBO/y1xRVfdsR+Uc5r9wyxaxmbAgiMLHgAzXqHRD1SKT
 WVXhWZ7oF90BGxBGsGrZIEcEeKxa8LtzbKSVNYgXOZ+CaqGMqNfsSjZkdcYaL0WitevS2TkjF
 yAqtL++Gn1SU1/OJ60Z5EF6xr3OfvSyKc1bZ5hdOx6wcx5/x9oXvmqMYyI+w=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Fri, 17 Jan 2020, Bert Wesarg wrote:

> On Fri, Jan 17, 2020 at 2:30 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> >
> > > On Fri, Jan 17, 2020 at 12:50 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> > > >
> > > > > When renaming a remote with
> > > > >
> > > > >     git remote rename X Y
> > > > >
> > > > > Git already renames any config values from
> > > > >
> > > > >     branch.<name>.remote =3D X
> > > > >
> > > > > to
> > > > >
> > > > >     branch.<name>.remote =3D Y
> > > > >
> > > > > As branch.<name>.pushRemote also names a remote, it now also ren=
ames
> > > > > these config values from
> > > > >
> > > > >     branch.<name>.pushRemote =3D X
> > > > >
> > > > > to
> > > > >
> > > > >     branch.<name>.pushRemote =3D Y
> > > >
> > > > Should we warn if remote.pushDefault =3D X?
> > >
> > > AFAIU, the value of remote.pushDefault wont be renamed yet. So you
> > > suggest to issue a warning in case remote.pushDefault is X. But as X
> > > does not exists anymore after the rename, the value of
> > > remote.pushDefault is invalid. So why not rename it too?
> >
> > If this setting was usually a repository-specific one, I would suggest=
 to
> > change its value, too. But it is my understanding that this might be s=
et
> > in `~/.gitconfig` more often than not, so I recommend a warning instea=
d.
>
> than why not rename it, if its a repository-specific setting and warn
> if it is a global one? If this is detectable at all.

Sure, but you might need to re-parse the config to detect that (and you
have to use `git_config_from_file()` to make sure that you know that you
are looking at the repository config and not at anything else).

Ciao,
Dscho
