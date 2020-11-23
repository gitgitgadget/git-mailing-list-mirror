Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7EEC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3513520721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lnHmaKfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgKWUqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:46:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:46193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbgKWUqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606164371;
        bh=Vr1GlnwysCRwn51SwzpeRKjNbjPBA5QzULrQ0YbAhKU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lnHmaKfFaT5jaxnj/rBj0vb7XDhoWmhqkNGhK4ZWVlZf3NeVaruKVruXnAl+Xe1ud
         OxIAxhIP/cRw8Air16fTQcW83n4tKt6EGdipWcI3nwaxMeYaxX0Xh4Yh6wmxhkydPP
         1ReCr//dfpd7IDuRJVF/bmbFn0k151ez2x+LzO8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1kUwOO0WNX-00E2TH; Mon, 23
 Nov 2020 21:46:11 +0100
Date:   Mon, 23 Nov 2020 21:46:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqqv9dvor27.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011232136191.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com> <xmqqft51osnu.fsf@gitster.c.googlers.com> <xmqq4klgq10d.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011231326150.56@tvgsbejvaqbjf.bet> <xmqqv9dvor27.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1+KPwJGv19OHZn5S7uGhqGkgAuiV9LhILlf0vl7kRGp56WfTkfz
 wCJ5JPIb/kO2c7E3JWWTkoGvmBU+5JOLr3QamyY3z+WI2MmKGX62XTbRAbHrViqjSOVQ5pu
 cyM3HQd4eekH7C+ZJQekooahkLc1lcbh1uRwhumhn74sUjqeXlBrVxE0Z6AuWk77aAxSml8
 JWjbS5IQ+3TolehgTtywg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTU9YgFTiko=:2lcNF4seUTfxvJE+FLcCCB
 4Umi/+RFwsmFau71JLuUOQH7h0OKDXNUOd4gwVmhj5A0xBaVADWR4Ji39k5hbqRS/IIjYC0Ox
 aYrDPbGfwOmh0ILhRqbjS9L5WnJb3Wub0LcOJ1t6uEQJrj34aljai4iLBH8KjEeIdjX+/YtHa
 bD6LUnG5c9m5c6JcQ7ykpPCpmfMusqlTCtrqQjWYfqr4Zqny3KJ3j5aoNJVEc2qvNDvj1CuKG
 /WH7+tHfbkckJzbv6WN8NpWPqcms0ZJ+E3gb9p27r7Usbdct2b/Pf4QTc7ilCjtGa+CrjSqIW
 aM/L0/dIXe3R48kIf8Y1DC0b4YMhdtz+0ekiwu9j1pM+lCfuFHFuV00CNmmED84YRrJTSIGp9
 iYlFSUlTnbFpIC1VGKrjTzahV6vPnzo/lF7cXKDj9mczhDUcAI+7vyXMJgPglIx5kEI2fXvl3
 PXSM3emBz2PV6iY2emd1qEFC9o6UTCAKZ4mzKPdg2EBbymGhfZpR+IoQUDVZRFMZRNEp96H2L
 UaNhBU9NkIxYhwICcRei47BojTbWZjYFFQ8CCGj/2IcI50gQ/c3lfSkORMUCwLS5b6bdNcFHY
 AHwoyqo9jI+igsFOaU2ljS401xoI+ly99pN/2PQHBFP8iFCnHXQDhCSEpikYpGIXXZFK/bHqW
 vNA95r6K7hJjP/ddO+aMQYDIdLwBdJwG3nEc28mrA1aa24vj1Pqtu0I/cCDNCfRa/mZa/A934
 gMPOI5PynyE2bDcetP6AHVzUOJoCDEK5H690UIUVDsVIbTPBjKu/1/zKaKuKYBKlqjsLr/lSa
 yKPIjhqjOiAmpUardrBYDV31WHFCsbNwTpsrZaZUPbySLF/lrdmYBZLVYGDrGaVhXOSDp1VVK
 ieztiz+PeFx3ce1m0imgGeHkfssOfrIUA/In+tGLc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> The above may give a valuable lesson to those who want to use one
> >> branch name across new repositories, but it does not tell those who
> >> wanted 'trunk' (to match the project, perhaps github.com/cli/cli,
> >> with which they intend to interact) how to recover from having
> >> already created the 'master' branch.  We may want to add some text
> >> to suggest "branch -M" after giving the advice for the permanent
> >> option.
> >
> > Good point.
> >
> >> Also, it is unclear to those who do not have a good <name> in mind
> >> (or, those who do not care to choose a <name> for themselves), what
> >> <name> they should give to take the "or to silence this warning"
> >> part of the advice.
> >
> > Also a good point.
>
> > I came up with this, which I intend to submit with v2:
> >
> > static const char default_branch_name_advice[] =3D N_(
> > "Using '%s' as the name for the initial branch. This name is subject\n=
"
> > "to change. To configure the initial branch name to use in all of your=
\n"
> > "new repositories (or to suppress this warning), run:\n"
>
> The same issue around "to suppress" is here, though.

Hmm. I would like to believe that readers understand that setting it to
_any_ name would suppress this warning.

> > "\n"
> > "\tgit config --global init.defaultBranch <name>\n"
> > "\n"
> > "Common names are 'main', 'trunk' and 'development'. The initial branc=
h\n"
> > "can be renamed via this command:\n"
> > "\n"
> > "\tgit branch -m <name>\n"
>
> It is very likely that the users are on an unborn branch when they
> see this message and "git branch -m/-M <name>" does not work.  We'd
> probably want to update "git branch" to allow renaming the current
> branch that is unborn.

Ouch, good point, I had not even realized that that does not work. In v2,
I will include a patch that lets it work.

> In the meantime, you could do "git checkout --orphan <name>" here,
> but once <name> exists as a branch that would not work, so...

Careful. We should start thinking about phasing out either `checkout` or
`switch`. The latter was intended to supersede the former with respect to
working on branches, so I would think of phasing out `checkout` and favor
`switch` instead.

That issue aside, `git switch --orphan <name>` is not necessarily a good
UI here. Its documentation talks about creating a new branch, deleting all
tracked files. While it is technically still correct that this command,
when run on an unborn branch, does the same as renaming said branch, it is
highly unintuitive to think about it that way. ("I don't want to create a
new branch, I want to rename the current one! And whoa, delete tracked
files? I don't want to delete _any_ files! What do you mean: there aren't
any tracked files, so none are deleted? Why do you talk about deleting
files, then?")

So in the interest of _reducing_ confusion, I would really, really,
_really_ like to avoid mentioning that command in this advice.

It really is much better to make `git branch -m <name>` work in this
scenario.

Ciao,
Dscho

>
>
> > );
> >
> > Ciao,
> > Dscho
>
