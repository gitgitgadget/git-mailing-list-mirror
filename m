Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785251F461
	for <e@80x24.org>; Wed, 24 Jul 2019 11:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGXLPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 07:15:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:37753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfGXLPE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 07:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563966895;
        bh=9JhNS95bPmBWuC7ERcRoVTHJPxBX+ssQrg1hBgOrk64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gxYERsMDze7R/ivv5PSjAu9KiHM1xB7VykNQfUx+ipYm17jhWIvhURfwg83oc7bgu
         25tC8gnVII17wtrxSGJg3V5x6FQ108GQRBb6gC9Ipo9V/y6YY1cF35HPI6Bgp67Nla
         anXDjnEc8st6oWGA5YRrg20jn6U9HmiLg8+sHIkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS1g6-1hxQF32c3e-00T9w6; Wed, 24
 Jul 2019 13:14:55 +0200
Date:   Wed, 24 Jul 2019 13:14:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Thomas <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
In-Reply-To: <CABPp-BE1=FB3LXAZP+i0Mj2OZQ7kTx2s3S+fZR9Y7EAg8KhqRg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907241308500.21907@tvgsbejvaqbjf.bet>
References: <6e61e65e-53c2-eb49-2197-03fe9796ef1f@gmail.com> <20190723195820.16856-1-rohit.ashiwal265@gmail.com> <CABPp-BE1=FB3LXAZP+i0Mj2OZQ7kTx2s3S+fZR9Y7EAg8KhqRg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dI4lmtzyCtXr2C2uA5D8+tHTim0oEBqfVSOA3cvikuD9q8JpAuM
 ElhgskImW8xeTBFkRW+EBobMe9D31g3QjiLCM2miVJhko0YM8XzGNDPl129ydHoiQgk3GsZ
 ZtRPT7qwaipj9EwGzCdxcPEFzEHYspWrTiRK56gbA6CmmnpN4giWTKG6Me2x2yZypnSBb2P
 dkRQdMsdIEvDFHCiQKkEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IkG2vWgLCxc=:II+0BSDxUYkcb1dWO73NX3
 hHbnsffcN49Y4nA1afZ98G7zyB6PO32kUnrb0L5ZrECJydAKc2ZxbXDmIm1Q+BywoqKNzZU6u
 S97V09A8sNr7UfhnoDfTvA4Y03XcmWcj2wWj4RHBgs0Uf7iO1FY4aHk0FYTtdw9XWFPD9S5QU
 3bvUa/xQYIa8oML0P7tIkW6YykHie7X9wzBFV/H8vk0bmEhVnNwly4ybxlLQICh+GB5bLDbIq
 w3/0J8m+ct6lQWCpA9UgKOV5VgLUsl2TtyTWjnttez6tIB+yVCJkHKPNwV47QvUauyCenMde/
 A6dsD69+Edkgc9/VEV3OQTP8zShV5fAsjCk2YB0Npu9Au5C4yirYksB1JiZtlgTDVzVCgTD/e
 5CmewG9/x+jhP34pASJ7RgyKYNHhGZrF6sg7BgJ6PsHKgFwfSh4iim+sB9I6dwFnIMf7Pq4Rk
 a62hcD9NXFm0tvfU48iWpyqSWbHG2VVbtVTEVOxQSkTVQkgyqJKFoaTtaWubGCzqOsHezrV9q
 WFYPxF5RVpl8K/GETCIvPl5oFilXaLVRGiP9FIMnbteOhSkhLISKxpPqcNelE0pzk2RV+CwTh
 aSlluSEiHCuroO3o6TFGXIP+7u/OyBDO5pvIfGHapKmaGFn0Lmuy7TSk1X06eUb5Hv/o5v0WM
 z9d2OcQmv/Z4nnGaDtOYu5uvmt2xA/SCCpwxkhDfHuq8/xSZpV5lAf8+fSqwjQ7XD2VBWeUS2
 Ap7e6MX8xTd1eKSik/si4zYsV2X3RVxZvF5MfyxQjBqa477WiBTAr8jZbroa+sYOc11C5+Dsg
 3XvmUAlRIHn6uVPxyMEnaXkVf7IAXPWs7u+n6OxFY/e37+JdhT/N0OVAO9t29KAVhuKGP3SYM
 InesZB4C3hlJAKvs3eiLXAoHXnsXUoRMvoo4HQOdgS3UBC6zpszTWXmwGxE3/Y+CWfo7q+GZb
 +A0VwnImnXEzcoQrBWL1mjwvCDuO0OZBQCIfLnewZs5gRHh7RG/j3OGqdFQb0n1MIT2Bz1/ti
 lP57e9WfMMh1G0MOcBudTDFN765o+Kka0wqKelLo3XGOgtuRcEAcImFCettXvhcNnHUdIGvJn
 +xHhL/NLaxKsICVfD2rf8qhJya6p2ys22r1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah & Rohit,

On Tue, 23 Jul 2019, Elijah Newren wrote:

> On Tue, Jul 23, 2019 at 1:01 PM Rohit Ashiwal
> <rohit.ashiwal265@gmail.com> wrote:
> > On Mon, 22 Jul 2019 11:00:40 +0100 Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> > > [...]
> > >
> > > > @@ -489,6 +501,8 @@ int cmd_rebase__interactive(int argc, const ch=
ar **argv, const char *prefix)
> > > >             { OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, =
N_("key-id"),
> > > >                     N_("GPG-sign commits"),
> > > >                     PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > > > +           OPT_BOOL(0, "ignore-whitespace", &opts.ignore_whitespa=
ce,
> > > > +                    N_("ignore changes in whitespace")),
> > >
> > > As with the other patch is this actually going to be used by
> > > rebase--preserve-merges.sh?
> >
> > I added this just for the completness. Is there any discussion on
> > dropping rebase--interactive as command and may be lib'fying it while
> > deprecating rebase--preserve-merges?
>
> preserve-merges is already deprecated, see
> https://public-inbox.org/git/pull.158.git.gitgitgadget@gmail.com/ and
> the output of:
>    git grep deprecated -- '*rebase*'
>
> It's also instructive to take a look at
> https://public-inbox.org/git/xmqqk1rrm8ic.fsf@gitster-ct.c.googlers.com/=
,
> which talks about how git-rebase--preserve-merges.sh came to be; from
> reading that, it looks like the whole point of making
> rebase--preserve-merges.sh a separate script was to avoid the effort
> needed to libify it.  As such, you probably just want to avoid
> breaking it or even changing it at all until it can be deleted.
> Anything that only the preserve-rebases backend uses (such as direct
> invocations of rebase--interactive, according to what Phillip said
> elsewhere in this thread), are probably better left alone as much as
> possible, with us instead documenting that preserve-merges lacks any
> new capabilities you are otherwise adding to rebase.

Indeed, libifying or even as much as enhancing it is a lot of love lost
at this stage.

> Not sure if that answers all your questions, though.

I am sure that Rohit has a lot more questions that are not answered by
this email (maybe even "What is the meaning of life?"), but one
particular (not quite asked) question that I would like to answer here
is: what does it take to actually drop `--preserve-merges`?

To answer that question, I prepared the `drop-rebase-p` branch at
https://github.com/dscho/git/commits/drop-rebase-p, essentially dropping
`git-rebase--preserve--merges.sh` and addressing the fall-out.

The biggest issue seems to be `--rebase-merges`' lack of support for
merge strategies other than the default, recursive merge one. To address
that, I implemented this patch:
https://github.com/dscho/git/commit/afa39b4fbb3ef5a53ccb9ae1f4376be87f5701=
10

There are a couple other patches that need to broken out into their own
patch series, I just did not get to that yet.

Ciao,
Dscho
