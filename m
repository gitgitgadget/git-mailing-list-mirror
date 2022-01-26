Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E7C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 12:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiAZMDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:03:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:60691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbiAZMDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 07:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643198578;
        bh=tEV/R55a5mzCRtkkZDQRb3yUu4nhk+bvdRCrCZVDTG0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iVmBI/4JWraz2EbVKqyhgV1+FCp8ehmwcTLe5A2OUlJegoVsU4jzCtCXbeaixoEkd
         9kTgPabhM0FFaydcDwn/us1VAFmHsDODYBZIHvfFUeQ6omLs+vvJlcOfU2Y1Xf4th7
         Su3jYlHeFu4DYU03m6eENaphXGAsqykbx5XMjvRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1mzzge26k6-00Dphq; Wed, 26
 Jan 2022 13:02:58 +0100
Date:   Wed, 26 Jan 2022 13:02:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side
 merges")
In-Reply-To: <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201261250380.6842@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r7n/Evw2ychLzvhvLlllcE9KReDINoEmmrGSOAiOmcWKOsIEYLK
 oCKNmWUqg3ZjiG5VdZAD17qnI3aqawMN43SFIMUquHDCNcMobRSObkFdxqbAIbLznCb+5nO
 xfNuKAVWg+JiFAJJ9/bK6z6Xbrs5gOveR2WS9ZX3+8uCM5ksdFlV4liUqeQaXsAM/Pny9xz
 GJdmWfHhS5gSYU0V3wMpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t2lvpjxw6C0=:mEkXz8lGuqDUI/fkmJjZ7Z
 iashsX5qqG2Ek4zBT1v1zotN87WNa/TL+bI7r3kTcvDJ2PxpErNnJssC7uiAYOeud3Wf+3hXn
 +rUFOFHWR5Xg1Fx6iYh+w1dwHoiHOzXTLEsGTAes0NAl0cw7U8zY4c19yVsr2QdcawdvTvUI0
 jB173b+AbfUH1hRU5fDiBbsW3jlg5fT978OK2TyLTHf7tPSmRP2C46okeqNRS1OEe/GV/FVee
 Karu5jD81bEHZTfOy248lm4DUC0HsoO7f93BOkIlGNxQdK4fYhztfixWgbnYJlqs8wGbgaTPE
 R+bcrrd9Y2DYdu1D+Kqw+k70Kx9W5gLvFZa5wXk+rFkn+1puarriNhJTdIhO+TK7fQuE+CGQO
 4ZiAjrIUtQHUxi5xW94uvj8DwaUdkX3u3x5FQvoEJ1b/qfrjX7VPMtRZ5w3RnLPX5ffpnWTAO
 kUnqZXJTEcEv3hSNrg6Mg38hnWFtJFul3acpm6ZLB8A7SSDyngvLkPJGTqEG3+yWrpdNJDBoi
 JulpjCpHyLGYY4v/bGknPP5rBH97Zg/jgGP7rBaj6OB0sxyIwsi2bh09ZP2jqmDhjv75gzDbN
 6mzGdaJ2IbsX9Xw/7C/bS/UPtfNPSejm4wJc5NtBSjM2gn7La64HT/tp03C1uYwCFE1vXxCYP
 1jPl5/GrBeTj7WJts49Tve0nVq3LP/+v51dQSjvxGE8KH6tJafTc3s63GqOCizHsteCA4f5da
 EPeLWk0pjjNyFEVDTyH2jU9uEsL889VVLsu1dT/QDem4HQUGMqFcBdkyiIE2UizAvd3EnApLw
 vLwfJeUqAKFBbpbUHFgGCrWlDap0bVKG1F90o+U/pvmyQWzIhjlwM65LUXzw6jUvmBMGoCMga
 6n+ewk4l0NNug05nou0mEh+e2pugpmy/qeYImWOwCzv7OaN1syoiQL1K8xQK+8k59WyXrOgyF
 dRdSPNsZphNCQBqq3EKm9010BLMObVofa2lgvZcTUDHYj1u0Yczp5oQIfE9LBCcrJBrnRTMZr
 P6wxUGrNR8jaFzfhtAhz2vA1YhQ4kFOUPscLjkzrJSWyWT/EGvkAGyFve8gp/UHp8eDLyRk1h
 Vy7lOXqTMPGrJo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 26 Jan 2022, Christian Couder wrote:

> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> >  * Accept an optional --trivial-merge option to get old style merge-tr=
ee
> >    behavior
> >  * Allow both --write-tree and --trivial-merge to be omitted since we =
can
> >    deduce which from number of arguments
>
> I still think that it might be simpler and cleaner to leave 'git
> merge-tree' alone for now, and just add a new command named for
> example 'git write-merge-tree'.

That would assume that the original `git merge-tree` implementation was
useful. That notion has been thoroughly refuted in the meantime, though.

I am really opposed to introducing a new command here. Elijah took the
best approach we can take here: save the `merge-tree` command by teaching
it to do something useful.

> Later we can always add flags to 'git merge-tree' or add 'git
> trivial-merge-tree' as an alias for 'git merge-tree', and eventually
> slowly switch 'git merge-tree' to mean only 'git write-merge-tree' if
> that's where we want to go.

I suggested before, and seem to need to repeat again, that we need to let
ourselves be guided less by hypothetical scenarios, and more by actual,
concrete use cases where the revamped `merge-tree` command is useful.

And since I already provided some feedback based on my work from working
on a server-side backend, I am fairly certain that we already have a
pretty good idea where we want to go.

> > Stuff intentionally NOT included, but which others seemed to feel stro=
ngly
> > about; they'd need to convince me more on these:
> >
> >  * Any form of diff output[1]
>
> It's not a big issue for me to not include them right now as long as
> it's possible to add cli options later that add them.

But why? That _so_ smells like a hypothetical scenario.

We do not need the diffs. It is highly unlikely that the server-side wants
to have diffs, and if a user does want the diffs, it is very, very easy to
generate them by chaining low-level commands.

So there is absolutely no need for `git merge-tree` to produce diffs.

> The reason is that I think in many cases when there are conflicts, the
> conflicts will be small and the user will want to see them. So it would
> be simpler to just have an option to show any conflict right away,
> rather than have the user launch another command (a diff-tree against
> which tree and with which options?).

That assumes that server-side merge UIs will present merge conflicts in
the form of diffs containing merge conflict markers. Which I don't think
will happen, like, ever.

In short: I completely disagree that we should introduce a new command,
and I also completely disagree that the `merge-tree` command should output
any diffs.

I do agree that we need to be mindful of what we actually need, and in
that regard, I reiterate that we need to let concrete use cases guide us.
As part of GitLab, you might be in an excellent position to look at
GitLab's concrete server-side needs when it comes to use `git merge-tree`
to perform merges.

Ciao,
Dscho
