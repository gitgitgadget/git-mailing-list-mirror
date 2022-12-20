Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5BC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiLTJfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiLTJfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 04:35:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419017581
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671528906; bh=eiYaWQaDDMiQSrGOQbWzUVce1jY4xO2P8h8GyPwtWLM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J7ChYCzjhlfz9G0DeiIiCSAxRRFGAQoI/u6GnIbhqVvqsymV9ZA5vQXJZMMcjvvJa
         Ngb42cdvFqvTrnhr7HoheNZtJGpQpoCkejltTDcb42FxGjY/K5eCFr7GEHBatZZ5Ak
         x0a9jkdYuDxy3VTVIobjWbh94sZHefSBqqXNe30FFcH14gqLDsemYIPIMm/stTxazK
         Lz6XF/PKJ7TLfy1MSrv7YiQrK3CwMo9cVzCTo5q3WYBbJIMPAx5hiAOYoCzTn1ePlJ
         fjFwsx+MHoHtXheb/gz2CPa0MpJqQxNYWa32YU0J3PEPD+ASgZpZMDFMm60l6XPSfy
         5KL+0cmYY6Osw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.64.45] ([89.1.213.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1oz4iP2qUV-009kFP; Tue, 20
 Dec 2022 10:35:06 +0100
Date:   Tue, 20 Dec 2022 10:35:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk, peff@peff.net,
        me@ttaylorr.com, phillip.wood123@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ci: only run win+VS build & tests in Git for Windows'
 fork
In-Reply-To: <221219.86zgbjxnqg.gmgdl@evledraar.gmail.com>
Message-ID: <6c26c788-6fa9-da89-700f-f589ea4eba49@gmx.de>
References: <pull.1445.git.1671461414191.gitgitgadget@gmail.com> <221219.86zgbjxnqg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-333628499-1671528906=:3779"
X-Provags-ID: V03:K1:rvPYf0gxh8GF6oNUahExeLc3nKIwBEX18QuZBoch4tTqnhmRxB6
 vtbEKBdu6o9AJ+3/NgXn7iY3d9ZQk3XpFxOnkEuK80/oidjcSRviZUPNAHcmk7yxLUqhdMh
 wFAWO8H6YE0cjFeaeCkZOQpFlIcMR7nK/KcOXMVcxsxJc3UMEtMU1ABSHKnIblVj2lp4Y9X
 jCFerlAUdcJ3jQ5EVCoSA==
UI-OutboundReport: notjunk:1;M01:P0:5Bf9q3V7bWs=;qxY16EOo+1NNaxxnnSZYyp2eB45
 ywJ4PVl6j8dWP9bNbkKHUj5f+VJQKsXIPp0RCTbEFLW3zT8NBmDTKzwqUbOo7POgnTEDL7/XH
 77cVNCsiP4mWfZWwe+3Hee7enoJ+iwOVMss8zopE/aCsawNTCFd/IRKkqoLIAY76QpFWyyFKN
 OpybfVyHpvwPctpiTC8Lah+HyXUQWgPNYnRwk8olMfZz528GMczPA6n9zQEUUbBGvNMIIBR8V
 STyhZptcimJWBhxTbpl02qGio8JK4QZqz2LxrkAAC7H6pcA/X+krYzjdrRR0JbHsRMQMQWlQk
 srIKIZ53+tkOp6ELOAZVNUlzzQQ9HI2Gs9vQK5HXQ4/S+Mn/hUFrrYuKoqAvvNk0Epe60S45/
 pHcUkRejopZ5UsgYxpw2Z+3dhiLV6NSVFSUMvr5VvmtjeIMXThJGZSJaYjGl4L5PTrg7654Ms
 yF0y+AYHlstG6FNTZQKAJ8nY1u7wGcZe41CeJg1spJ3rg3gm3qDwPmS4ParS03007p6hRavia
 EjB+CsPGKAmxd4w+ad3vbby5TE5xNqGYPIEeXg9foRK8l9K73XY3mrRqNgGGDQZwJb/Nuvqnz
 A2drtCMOORvDfi6i39KoslPiWYPY41JPHNES9qLYkbT/jopnHSkM7F2Ro9fTG6xFcSTZpAxWO
 1/daneb5vPtFppDcVuKSyinr40WMzAYkp90vxMmmKIRUD6sM3i2HIBu2CeDIZMrNZX5B74SvP
 AtkXo4nDDUQw2xS37rrU9DXp3iTTHnFPofAHnjJGIZYW63GsR589+bnC4IyvctZSUxY5Q6wI2
 wdPtvRDgPsn6v+taa/+FGYScF1CQchJnTEGL2Gd0WGYwGoa5Sv6WnJGSiPAXmh+uie5OT3jWC
 nEiayBl3jnn30428x/NLtaBhJB+2xpUyLtKWDoYBQ1blV91j2aLuHChieY9Fz6+bh1eomZruM
 upwecw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-333628499-1671528906=:3779
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 19 Dec 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Dec 19 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index e67847a682c..8af3c67f605 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -132,7 +132,7 @@ jobs:
> >    vs-build:
> >      name: win+VS build
> >      needs: ci-config
> > -    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> > +    if: github.event.repository.owner.login =3D=3D 'git-for-windows' =
&& needs.ci-config.outputs.enabled =3D=3D 'yes'
> >      env:
> >        NO_PERL: 1
> >        GIT_CONFIG_PARAMETERS: "'user.name=3DCI' 'user.email=3Dci@git'"
>
> In terms of implementation: I would like this to use ci-config.

I really do not see any value in that.

If you _really_ want to run those tests, you can easily add a commit on
top of your branch.

It's not like you always want to run the win+VS tests on a certain subset
of your branches.

But. A big part of the reason for this patch is to codify that it
is _not_ the responsibility of core Git contributors to take care of these
tests. Trying to do this via the utterly convoluted and under-documented
`ci-config` would only water down this quite clear statement.

> The outstanding "tb/ci-concurrency" topic shows how to do that (and
> tweaks an earlier submission of yours where it was similarly hardcoded).

I fear that the `tb/ci-concurrency` topic is a good example of "death by
committee". Let's put in a collective effort to avoid that here.

> > The purpose of these win+VS jobs is to maintain the CMake-based build
> > of Git, with the target audience being Visual Studio users on Windows
> > who are typically quite unfamiliar with `make` and POSIX shell
>
> I thought the initial purpose of it was to test compiling & testing with
> MSVC rather than GCC?

That might have been the motivation, but there have been preciously few
patches coming in from that side.

So few, in fact, that the question "is it worth spending all of that
energy to run these builds and tests all the time" most likely has to be
answered with a resounding "No".

I can think of just two bugs that were identified in the MSVC builds, one
where we had to change some code to explicitly use a stable sort (which
MSVC would otherwise not have used), and one where we now avoid an
unsigned/signed comparison where MSVC cast the signed value to a
now-insanely-large unsigned, i.e. in the wrong direction.

That's two bugs identified in how many years?

We still can catch those bugs in git-for-windows/git. And avoid some of
the long build times.

> > A very welcome side effect is to reduce the CI build time again, which
> > became alarmingly long as of recent, causing friction on its own.
>
> I think this is a good goal, but what does the "as of recent" refer to
> here? When the ASAN job was introduced?

It's not only `linux-asan`. The overall build time of every single job has
gone up. I picked randomly two runs that were roughly 6 months apart,
https://github.com/git/git/actions/runs/2537915353 and
https://github.com/git/git/actions/runs/3728047162. As an indicator, the
`osx-gcc` job took 35m half a year ago, now it takes 40m. The overall time
went up from 7h40 (which is already _quite_ a cost!) to 8h01.

I don't think that we, collectively, are judicious enough about the
balance between cost and benefit here.

Having said that, there is a silver lining: while the linux-asan job is
new and takes a whopping 44m to complete, the difference between the total
run time 6 months ago and today is less than that, so we must have saved
on _something_, _somewhere_. Or GitHub bought faster hardware.

Ciao,
Johannes

--8323328-333628499-1671528906=:3779--
