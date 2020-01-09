Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C69C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E332077B
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Kt+D5KhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgAIVdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:33:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:45627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIVdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 16:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578605577;
        bh=O+Tb4iskluwuDx5IhIBjNH1lE6duNiPu2Oj2PIbRQw4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kt+D5KhUzFf7l9shwoSIxA6qU2Dg1P1f8BXXc5l4/PCRQMyaKvFkpyuY6zpMg02ws
         wGpoYpzoiOFCng3fYpcDXjhYOrWAX8NTs/ezWPGBFqknL9JOgcRFJC0blrliypuUk8
         rVTeJbUG/k+RWaWjM+oNXP7nccH3N3lbEbJvUNvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MO9zH-1j4prV3fqr-00OWii; Thu, 09
 Jan 2020 22:32:57 +0100
Date:   Thu, 9 Jan 2020 22:32:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/15] rebase: extend the options for handling of
 empty commits
In-Reply-To: <d9d3d360-fc45-a716-4b35-4367c017460e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001092230360.46@tvgsbejvaqbjf.bet>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com> <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <1c2b77e94d63f86590ca934855066eca278f576e.1577217299.git.gitgitgadget@gmail.com> <404424d7-f520-8f89-efef-ca03e66fcd43@gmail.com>
 <CABPp-BEH=9qejeqysHYE+AJ+JPaBympZizq-bx_OjArYFa4xUQ@mail.gmail.com> <d9d3d360-fc45-a716-4b35-4367c017460e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CBVLhz33ZwE04o+3SsWPrRn7AWNApo820mHZYopqSiKL0YxWNtk
 8oRcNEMiRv9zyBwfDASEwzljmUZSiWK8wPz16tuSPUNrtjZB8UFcVoKh+S2/m0RMpYGtjEK
 usdeQNkMMSMdzgByuTSF5ajU0eut7n7Hn4zbsukohyGvN4aVK9mPiFZQqQ+crmTghIHebui
 QjmUhvsAYtUO5Sn4fCxbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hN7BnXYggyU=:SDQw5sIIe4qjcPpr3WMSZT
 OMTmh4ofJA6zsOb0K+DClL2okNY4IIdaqSPHjEnp9/gYpJ210+DuICQulWxSVNtBIlpQT5G/D
 WuBG+6oJ5fhgtuZ56PX/96DqT5+g91V0kyrMHTuZ/TYjzDj5n6gGWYvowemLzrZtTPUfnI4rK
 7GbNL5m/McwCIyf4m3n+AT9omCjdsvVj961lP5UTz0DBHvzkdKhtQfQuAPiZhu7vXBeqDOdSM
 OGo4SHZTuMcgihPQLOsyWtVhoWBoGVBuIfoP7DtOud0tAAhruFH3bsna3qAQu0xZCt+iVoSfF
 3vYLDo7sDkfTLE983hh4T2Std8YHjL/0ayVgTAkaw5pKdMisn6P60VLXcBdFWfRt8p91z/dpn
 RTGlNiKu06uH/DW94kjZR4xMRi1+Q1oInUyN+ikKAn7L7H2fPspERVdc2ycAev4F4HVAuli1C
 RxRPrsNPU0DiNIudsEscNzndnwiZK3t/DDIhQYjtOyqsq8JdCQh9nbOXgetL3cIqfWZ3ZlarX
 DLmT6l08BwLa+zSPGjlx0jcm3MtBbl4f6K1Dm4aOgBcaPy8FYYfho2ZiSEqzbvelPjyO7cRom
 9emJgCiucNzQAMuR+cbKiDMzsmlkxvhoxJhpyNDaECUlzu5/aMhQ/wscyjwbBmMVS5CB7RYdj
 Fk4JYzmXjuLPut63FYZBVHcxoiSDjavMuTyzz2z4+MIU3yyWH3FHQbI8/CiLcLXcWRFt949ZK
 Tu187UON3juw5C0X4VmmlxMh3aMyjych7CyTXCyXzJ1EsuUwJOWZmopWeONzJ8YwRJ+FrggCG
 L3+xy7H1/I8VtTuKCxS1ZZ6ZBU6lDuva3ykQ1OzT2G43yMV9FHAsRSJmMmo0RpRIBgsXCsJIT
 0IboxpSSui8ZxpdZYOxe8xOuiYH/h94RVpJu6VagriU9z8USLveQ2lZH3Aj2MAVTOGXfa2cae
 r19NJHx0AvuxwTiEt5XVVW/l/JGyRQnlPtqZ/r7thF9B9eCuFRL7CCpMOpVNNsC0EbrbAxo+h
 PNAcFvj/pnIjXKC2GHPKuJQxM7G/x3Je7/m/TLEcbJZGIgQJFNP2Uc6ml9hGB9I2DJ0KXl28a
 nv81AdBBkRd5kWZ1vvUiDrTg0689ZwufP1MO4QFLDvuIXe9yx/c6n9xvMvrX8Wv+P43rV34wz
 HLBYyZjJTGaL8NuDipvj1MbyPuKGtDf1870oVVKKHdrdfY+Fd/D1xQc8qFQIDV+2nYTKfCeFy
 6z5sT2/da9hLBW8kFYMuhTReGZAb7JQ0i/CNBnasNAdT90LW1oGnJuHdxqBU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 8 Jan 2020, Phillip Wood wrote:

> On 07/01/2020 19:15, Elijah Newren wrote:
> >
> > On Tue, Jan 7, 2020 at 6:37 AM Phillip Wood <phillip.wood123@gmail.com=
>
> > wrote:
> >
> > > On 24/12/2019 19:54, Elijah Newren via GitGitGadget wrote:
> > >
> > [...]
> > > > @@ -466,7 +494,10 @@ int cmd_rebase__interactive(int argc, const c=
har
> > > > **argv, const char *prefix)
> > > >       struct option options[] =3D {
> > > >               OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forw=
ard"),
> > > >                          REBASE_FORCE),
> > > > -             OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep=
 empty
> > > > commits")),
> > > > +             { OPTION_CALLBACK, 'k', "keep-empty", &options, NULL=
,
> > > > +                     N_("(DEPRECATED) keep empty commits"),
> > > > +                     PARSE_OPT_NOARG | PARSE_OPT_NONEG |
> > > > PARSE_OPT_HIDDEN,
> > >
> > > It is all very well deprecating --keep-empty but suddenly making
> > > '--no-keep-empty' an error goes beyond deprecation. Also I'm not sur=
e
> > > it's worth changing these options as I think the only user is
> > > git-rebase--preserve-merges.sh
> >
> > Side track: Since git-rebase--preserve-merges.sh is deprecated and we
> > want to get rid of it, and rebase-merges exists and is a better
> > implementation of the original idea, can we just translate rebase -p
> > into rebase -r and delete git-rebase--preserve-merges.sh?  (With a few
> > wrinkles, such as telling users in the middle of an existing
> > preserve-merges-rebase that they either need to use an old version of
> > git to continue their rebase or else abort the rebase?)
>
> dscho posted some patches in November or December moving along this path=
, I'm
> not sure what the outcome was. It's a bit complicated by the different t=
odo
> list formats between -p and -r but I think the end game should be to tre=
at -p
> as -r as you suggest.

I sent some patches to switch `git svn` over to `rebase -r`, but that was
only in non-interactive mode.

In interactive mode, the todo lists indeed look too different and I think
we'll just need to wait a year or so and then we can just delete
`git-rebase--preserve-merges.sh`.

Ciao,
Dscho
