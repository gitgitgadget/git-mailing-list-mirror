Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F9420305
	for <e@80x24.org>; Thu, 18 Apr 2019 09:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfDRJ76 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:59:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:43795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733049AbfDRJ76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555581589;
        bh=nb2HIdYkFUQPP2QPOd8V1Tp7XDJ3ENmYA9skozI9uHc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j7tTVl9MMdsnPLxeoLooueMLWvPx5yKjugrpeCV3f6MQCtkkGHdVMNGN6bdTNAmYi
         5JzXDYQDZHsZ25Lop1WxcvyD8/nqSUuZKBxjsTXGcnXhF0gniYMB22RkG5yBHp8oJf
         JxPXbde8l5CGlUIL+rNwv2pQoSp03A6QwT3KS7Oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLi1v-1hHsud3EvL-000v3z; Thu, 18
 Apr 2019 11:59:48 +0200
Date:   Thu, 18 Apr 2019 11:59:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org, rappazzo@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] worktree: update is_bare heuristics
In-Reply-To: <xmqqo954gira.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181157010.46@tvgsbejvaqbjf.bet>
References: <20190417212128.52475-1-jonathantanmy@google.com> <xmqqo954gira.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QdaE0gkH5rrBhEg7LZ+3Zncy0j8p9yV8uShcvsyE4dieVX0F9Lp
 D9TJKmuRTkpVMHjFm0jLIWVLJNOwWaqBUF7arYTn4icNPbCNcc3tngd02ER3IRXscg+eDus
 HxFe1Kjvi2Umtk6nj+vZ1ikV5PpqbC1vGJvfQhc/viKxEvSvBVA2LwDM3Qr4nwWlDNjZrRJ
 XQLEdm25iMD95N6WHt7pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JD6eu5yf8lc=:Kbn5Gjv7zwTHo5QHf4PTTb
 sy8PwsTsUJ7a6k/IczNo22UN73y5heLTvBsWhzC75HuNsunA4TONvKpwvJwWoVn2+IxD7Lwih
 tw9olYysTrk/9ksKUDDblyVStrMs7hJi0XGHjto2LVXq7Ver85uKZRs0PPCWFS517nWKa3kpM
 +MLX92ZcFju454kazjCPuNwKZYNOGP7GWg8EnSaey3rltIy0S8/IKgBHdt+t6dgKkjdzdSbmm
 7498DTn1uIegneYodtY321zjZDcFCy+OJKeZn8x9/cWb9oZPjFiLJUSEuDwUYf+rSgnSZq+Te
 IQN9GPqi55/S55f/fexxXkT1nCtm+npPctbtlbbV6/A1/KpIl25hVNmbmvX12+waNnF+gAax0
 gbW9Ts3VA5Dwc2TJB5ZZYhkz60d8wJKIyUvdhiD9nPAGltjq5rKZVmoHRu8TKTVS3IcJKQnVv
 RdEZ2iCYrepcJ5Ej/xDNQJBRAlTQAjOzYPJVFPwxHFnEQK+riOEoOBLZy0ciEm2vM8UcMCZHC
 faTA7bUiELp0crYuub787/hX8yfkeBsYBJulLnsosvm54rosAtKRJZmD9EKFLpymG4qRH124D
 LKcE0JwT/gAInRCbasYHATUFT5qdheyKEI6Q+huhumzTXKzjOnZCp/DWO+8KJWSXUUNtr0TOG
 fILTdK7K/3zy+4LPZEkhPUA2lkM9Mol+h+waD44ffwdhOW4J7txeZ2D4VZCTEHTofF/GcTDed
 ZQq8vZ0wQ1LoSSFdAElYxwWuxTMPLRdyMjj6ZpjzJY4ia7aAJ30P6hshhCyk/O03vPBBInQwr
 4FVBtnApwKxK01oMRqASNmr6Ch8vunt/mzG9IsG6nr6js1J7dknwe+O3JGPl/7oGQ8MqbyVLA
 dUXDZrjGR4lvHuz5aus8qrHMvPiRyPGb3wD65ThOw2QlZ1KhmR0yzp1SamitLd6AYUkoXeZIm
 WnA3tNSvB0A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Apr 2019, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > When "git branch -D <name>" is run, Git usually first checks if that
> > branch is currently checked out. But this check is not performed if th=
e
> > Git directory of that repository is not at "<repo>/.git", which is the
> > case if that repository is a submodule that has its Git directory stor=
ed
> > as "super/.git/modules/<repo>", for example.
> >
> > This is because get_main_worktree() in worktree.c sets is_bare on a
> > worktree only using the heuristic that a repo is bare if the worktree'=
s
> > path ends in "/.git", and not bare otherwise. This is_bare code was
> > introduced in 92718b7438 ("worktree: add details to the worktree
> > struct", 2015-10-08), following a pre-core.bare heuristic. This patch
> > does 2 things:
> >
> >  - Teach get_main_worktree() to use is_bare_repository() instead,
> >    introduced in 7d1864ce67 ("Introduce is_bare_repository() and
> >    core.bare configuration variable", 2007-01-07) and updated in
> >    e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
> >    the "git branch -D <name>" problem described above. However...
> >
> >  - If a repository has core.bare=3D1 but the "git" command is being ru=
n
> >    from one of its added worktrees, is_bare_repository() returns false
> >    (which is fine, since there is a worktree available). However,
> >    commands like "git worktree list" currently distinguish between a
> >    repository that has core.bare=3D1 but has a worktree available, and=
 a
> >    repository that is truly non-bare (core.bare=3D0). To preserve this
> >    distinction, also check core.bare when setting is_bare. If
> >    core.bare=3D1, trust it, and otherwise, use is_bare_repository().
>
> I am not sure if the latter is worth keeping, but the former
> definitely is a huge improvement, I would imagine.

I think that both are improvements, with the former definitely being the
more impactful one.

> Somebody did "git branch -D <that-branch>" by accident in a submodule
> checkout, or something?

/me shudders at the thought of it

The patch makes tons of sense to me.

Thank you,
Dscho
