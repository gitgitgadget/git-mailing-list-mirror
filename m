Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95205C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiBVMMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBVML7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:11:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14151DF20
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645531889;
        bh=g9sTG4rIUye9w+0Bb7LRK7DChi8f0NkA7Yjjq1yIkkI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cXqT33vR5bRuKFSmVPoa3x/6XLNVje3Zi41C4W1nVasdPAUc2jSEmgZEqH4kPB9eL
         7dQalIrOT9VegUq69Bmjr8uOMSg104t3vGh3gFQULX5RXwRoIHSxSQDWrQlCEeCoLE
         CHB1HtzwNJoT+f0npXfninjigCjclyvQXM4RC2G8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1o78IN1Il8-00kzW7; Tue, 22
 Feb 2022 13:11:29 +0100
Date:   Tue, 22 Feb 2022 13:11:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
In-Reply-To: <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221309220.11118@tvgsbejvaqbjf.bet>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet> <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YS3NioYWImJitzg5l5GjV5MgCRli+olw0fvTbta0apOd/YTphJH
 kHTSX6B7kIfr7YSHgkmUFScqckHxLKs30vmvdrU2Au0J9OAg9vcJZA24i8r9T+bdNA3zVr2
 I25yS86iwl6lvl+fcf9j6Hw1Z6Md2itkL4SaPogOLtU76dfKnPJOuCLTmo5zfpeMhOPHYpv
 a/JF6dKDnXQtk+Ur9KceA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:erIoGk1MVy0=:4yWSmyvZQIUA5u3+sbcVSK
 mpO1tewVOPVuJW5HLVDjsDmQFv0Fn1XpNHOx9AHXc/dqmxZ6XKwP4AzerkIftGRKt5n5d4O7t
 2uCuw21N9NzAF5OMLYFaJ7Cvr0SdpPJwhwijntdQ0FmNnIBNzWHgQilp8rUFbVpxBt/PvEuwb
 fAzWHHq3S/m6p0aC1HpBJcOdYNTkEXrkaFvGceZ/07fPYR9g8FI+ytNhue0hXbrfwbM54kcbo
 Ow+2AG5HazpGXr1cb18WWftZekiIAMztHQqHC0zS605LOj42/X6/mL6ptTL2nGcVYI6adGRG1
 kO5YUvLiRjECXxWVpkrZnzvE2zxumzk34UhSO7JmbgjeqyzqCxFMvesIwF5wlkcbDQbLyWBTm
 zLhPPIX+xVbZY8i2O889iTKEQE4UGZ9snQbzrOZJltKnF86GmWdCjNRmCe2QRfo3Qfnsh7mOZ
 CZtDE8QOCAXyn91M+We9sUQEHecz75p+1tr0MpolnPMaHl/kM1fEoNpHHMxbF3dAZMHP+P3Ta
 /kQfWWqTDHcTp6ozGESrWB+ZimodKjPPQY7x/vjIBjLxh5lTzt+jGEPlyRMgkcTjvszPWHZAO
 IiK5P0GyAul2WFVTYZLwnkP5MzSfsVTnqLXV5bBGhZLl1pivD9TYs+NnmPUzhiHDHsEDH9bKF
 CNPlrS0MS4ZTQCZssup/lPCaOxYTzr5Z4u/UdgR7MAZhI/Rm1im9U8Lxg9nFuZ5v0D+N8TupG
 WV1RpqNhAgmauww70f4EwB+98+P7jQafGxI04j3jQnvV8SV0+lhFZR+WdnplEINaZblo5E7lv
 FC1aidTBNTIWSEv45D8b8tRkPXxP0NIt5g+V9coCvQvohyqIAUlNv77qDRsYjVjhyVe247sAK
 Sx/heq73KPAhhcTZG1lRjEWnMAgRGd8+RS8dlyPYwKTGuiU2EhkrsR5Q1Scivr1V7JCW4NnZJ
 otXCYPPNUbB3uM5uUeoHNC1y7OIpWHijZCnBjAUQ4YmFGZIMTuPajjgrBU8sRLZtjB49XO3PG
 JjsZQXs4ZbiMo5Qr3Xzi3+PJzzDyXt4h7Sejc7FNRZDtaJoc3awRBfy5LKOTOgMBhyYkQb1zi
 u3QGM2ILbT2fwY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Feb 2022, Elijah Newren wrote:

> On Mon, Feb 21, 2022 at 12:34 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > In addition to Stolee's feedback...
> >
> > On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
> >
> > > diff --git a/config.c b/config.c
> > > index 2bffa8d4a01..68e877a1d80 100644
> > > --- a/config.c
> > > +++ b/config.c
> > > @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char=
 *var, const char *value, void *cb)
> > >               return 0;
> > >       }
> > >
> > > +     if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
> > > +             core_expect_files_outside_sparse_patterns =3D git_conf=
ig_bool(var, value);
> > > +             return 0;
> > > +     }
> >
> > The `core` section is already quite crowded (for which I am partially
> > responsible, of course).
> >
> > Maybe it would be a good idea to introduce the `sparse` section, using
> > `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree=
 =3D
> > false`?
>
> That's a fair point.  At one point Stolee wanted to change from
> core.sparse* to sparse.* -- but by that point we already had users and
> would have had to deal with a bit of a migration story (and wondering
> what to do if people had both old and new config variables set
> inconsistently).

Right, migration is always hard.

And it's outside of the scope of this here patch series, of course.

> I'm not sure if it's optimal to try to keep the sparse settings
> together (thus put new ones under core), or try to avoid filling core.
> I guess if we moved towards sparse.* now, it might be an easier
> migration story if we only have two options to move.  And besides,
> we're already split between multiple sections with
> extensions.worktreeConfig, core.sparseCheckout{,Cone}, and
> index.sparse already...so maybe adding one more section would be par
> for the course.  ;-)

FWIW as a potential #leftoverbits, we could migrate those to `sparse.*`
where `sparse.*` would take precendence over `core.sparse*` and the usual
deprecation notice would be shown via the `advice` mechanism.

> So, I'm leaning towards sparse.expectFilesOutsideOfPatterns, but I'd
> like to hear Stolee's thoughts too.

Indeed, his opinion weighs more than mine on this matter.

Ciao,
Dscho
