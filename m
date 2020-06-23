Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3001DC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB972084D
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hTit3Jr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgFWTUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:20:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:32939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733220AbgFWTUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592939997;
        bh=ASMZ7i62jF/GJM6gcUAs7IqBlZicejzwDhwqLoG9g6Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hTit3Jr+xo1yJo1dZXKCdLs0TPjW0HLjhblzIicfKpxAsJxc5yatzske+wH5SIsMN
         G+UBnxnDT0kuN9pmXpgWKY/P4QtaxoNbC2V53/HHJ9qm8vzl8a47Qu9ebydtNiA+W5
         7yNuVBMdS/CBRKd/ihmPZoVA4BWALX6JxF2iHnRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1jKcjP0mVu-00XZMz; Tue, 23
 Jun 2020 21:19:57 +0200
Date:   Tue, 23 Jun 2020 21:19:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
In-Reply-To: <xmqqr1ugw97e.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006232118220.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com> <xmqqr1ugw97e.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UT4jnjxwc5uetQpVl21zzJV2IzKfE0KJt8m0Lu1m1mLp9SvjY5U
 ckOOz9b/HYtVN8x5gaKoB9cUNDlAJQAcfz3E0gZ+SwHeFQCLrf+9bInVRU10BV1xEJSLQ09
 X2PbEq6iqtbs89Q7pO+GoS5RzNWHZKrNrFZVPUwC7iSoGL1tfDZRMDfOU1IDxhoG/1wxfrG
 MXwlLdlcBRzDiVMLX7hyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A5zxzwIlQJg=:UPqEWFdDjqMQlcw7EjvaSg
 PkO8ul6WQVY6608ASVbLyaN0fjONwdzDOYRye0/AIfhSihAcL+IwMYykwHeuCF1b6BIc3ZwBr
 qOYobaO6ZAPhgc998YpgEgt5cokaKq0wmAVPj9em/hgSQAtKeXGFeGxj/smVVuBudjBU7KK57
 f9bxCflBXiNG35Jb2rsZVfeYL+UFzA4vW07iFVhCwmuBsnOOANC2D3vtKXxoKXv837bIlvcOi
 nAZevlsOmEtBmfnXqq0LLRgP7qGOQQN3Y9EzH8/GEIu+ki1/Sgo3GfDzzTJuAA+qJ70S+ToGi
 4uXbK0HO46BahCH73sgN4Tym9U+MfQ/cw02bxgevcBr3AnKikBu8WExoVWfsGfZAJKyF2jw5O
 gK8CgjmCFzJrtADtCMBA+ckJYyVHKJmOtia+rDm1RxNRs91Q+rXa6eRxiQ+kJ6R2n/Tw5602R
 9s1U0JhAMu+ZA3xHF9W+erFA1aewomN6QcZgpRiNEhEgA2lBGDhWOehr+6XEGquFeQzyz2jjR
 Y7jrnWT7uIXtXL1SZX9LUAZZn2t+RJSbmj2e/Z1Jh6tk9sRTzOUilcyX8bU15+f9n1Sg0W5pr
 FUK5AvpD5JUURUZIDUx0ocu5PP2sQfh4DUJFNf0ARdh5Y81jEsDAFY5wb7824pzoQ5MxQy6UK
 dBEVhQSPbHlHAh8r+FX8I0qiHs0CKfONu9Cn/96wJN/C9xIAM6apNUuiL1KfOopca5SUzr6BM
 EjTQBJjv0U/zrB44e/oar1tL1lJJkriaLpFLehGaZnUdMQSH+/yjgq3PRy3mOvCf/0JRFZko0
 98Y+lH1/2uNnyCRbPQVmMfVzM/i1wXnakw/o9zQjDhvLMbNiLENA3Dp8Q1DIEJxGrsshMO7C4
 RHrhMZ9HvRsfj5EY3dOPLKiO7R75oPMwmukZ8lt/OS+s57RFc6lk/hSIpGj4qjMrlvln3Kw0V
 W0eOcGTizg5RBT8FJs9bekAe6c4bPaiBlxBDLjE+RhAA/MSBijFEK3jweFmSW9tTaIKZEx/if
 RA/RFAX1D3ew0NXqUr0V5pRTj/KYYQeeqotYVzi8q42/6J+3627f68Nr8HgrQNJ6yygtt2PeU
 pfH3unSx3F38bSABGxU43ALOY7IrSYvAmGabPXVgqLNMXQzwLv8Ab+8cIXPgPGnt7i9nH5SoR
 Be3c9HuwZXqOzl11hpKKa4Pq1ck55X4jiW6sXqH/oIGB+6A2VmdBmWpPcATjB4UMCES0CPvr8
 wJ7Y3j3rtlO+RIWtF35AdSuo0EQBuBFLM6x0LoA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> > index 72d32bd73b1..43f4f829242 100644
> > --- a/fmt-merge-msg.c
> > +++ b/fmt-merge-msg.c
> > @@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out=
,
> >  				const char *current_branch)
> >  {
> >  	int i =3D 0;
> > -	char *sep =3D "";
> > +	char *sep =3D "", *main_branch;
> >
> >  	strbuf_addstr(out, "Merge ");
> >  	for (i =3D 0; i < srcs.nr; i++) {
> > @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *o=
ut,
> >  			strbuf_addf(out, " of %s", srcs.items[i].string);
> >  	}
> >
> > -	if (!strcmp("master", current_branch))
> > +	main_branch =3D git_main_branch_name();
> > +	if (!strcmp(main_branch, current_branch))
> >  		strbuf_addch(out, '\n');
> >  	else
> >  		strbuf_addf(out, " into %s\n", current_branch);
> > +	free(main_branch);
>
> While you are at it, taking
>
> https://lore.kernel.org/git/20200614211500.GA22505@dcvr/
>
> and the response to it into consideration, I'd suggest we should
> support the case where the user says "no single branch is special
> here" by configuring it to an empty string.

Together with Peff's comments, I think we're even further than that: v3 of
this patch series will completely drop `core.mainBranch` and not
special-case *any* branch in `fmt-merge-msg`.

There is still merit in Hannes Sixt's wish to be able to turn off the
`into <branch>` suffix, but that is orthogonal to the purpose of this here
patch series.

Ciao,
Dscho

>
> > +core.mainBranch::
> > +	The name of the main (or: primary) branch in the current repository.
> > +	For historical reasons, `master` is used as the fall-back for this
> > +	setting.
>
> As to the naming of the configuration variable and the actual
> fall-back value, I would strongly suggest making them DIFFERNT
> (i.e. separate the concept from an actual value).
>
> An instruction
>
>     ... oh, if you want to do so, you can set the core.mainBranch
>     configuration variable to 'main'
>
> sounds strange than
>
>     ... oh, if you want to do so, you can set the core.primaryBranch
>     configuration variable to 'main'
>
> at least to me, and since I am OK with your choice of 'main' as the
> replacement for 'master', a separate word would be more appropriate
> for the variable name.
>
>
