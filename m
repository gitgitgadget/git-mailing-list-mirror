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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A6C8300B
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD52820782
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="j4cYX7H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbgKWN3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:29:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:60309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgKWM21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 07:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606134502;
        bh=JDemwnidgeVzaCrbAV8C1yfMC7HJLDJtv7LE0Qgr9DE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j4cYX7H4DZLR7ySKRIkuFCMLoQr22cEJIrsWegs3a6q5lVX3BIWw+cGW9KYkil5zA
         HrW7nMLi6MMKqlD8ymO3nXAaN0Nny9cwAl2sCJNDNj1MmcCHGCQygu9EviJETxsB29
         5FLZgL2J1tvveUX3TZUwjzZxljqqc2UcXJX1W/Zo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1kSIqO0IWs-00H37t; Mon, 23
 Nov 2020 13:28:22 +0100
Date:   Mon, 23 Nov 2020 13:28:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqq4klgq10d.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011231326150.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com> <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com> <xmqqft51osnu.fsf@gitster.c.googlers.com> <xmqq4klgq10d.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4E4NonXuSGhXstc0/l6PGfOUtXG1LoJtrH/PfeOHI+KlFW58cPP
 4Uen1/wUkxaZRM/X0Cmp1uMdAjEtXdzOHyo/+LlQvhsN8lropYZTM5EdzAJ7XGVvBN+Ke23
 A28lel4ftroyPh72ikxK9XME0FeWAibTq7GMNWA/lk4PfliwClSy2QFuVLALbKJVNGnAWi7
 j77WFf+ZpLZr2Wk6CGWNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3JzhxPnXpSQ=:2v/Ar8qsE5HjuZKnmoEnEV
 uHIrdH8/rEGBiPM4QcrY8w2jZU5RrEbbWawp2GP9UK0l1QgKo2ZbSqHUu02YYeq5w0+HB7aFL
 L5ISTOtz5zBD7f7WmBGdyV6d2yUQtHmu1h9d3VX0/KxcKs6yO2UnIcoWKPabcWS/hxS6Ql1DY
 T31XY1G3twOmd8SJYx6cJs4fzW0ONxaG3d2jOMp08X3+CwgClX4jMBc6pKliD0pbh1n2vqkXV
 ps3fJQEYWqBh617zuCGARnpXgf+SmRy8m7Xrom9nQBnZmYKkV08RNZ49vHmOt9MEh8e396OoL
 3uEFhVtTT37CoiplFwKrVWxrfkesSwCirRHeSiA4EM5aO2u8kxXFzbG7qPEeEdvnVdPGXMLq5
 IyHJ/vgscFUlCvPXIrzd0sMAV947uVd6dszhULxigknN6JQfru92HvkG7XShTJobaKC9tHlax
 UMFO1x7ugdhXr7deZr05JfiYl2ojBpaQ0QfS2Gtj+5Dh8yC1Ks9ecgoJ/Ut7DPBzCCtv5l+Wn
 OEsEx3un1ugn2Hm81rt2r27CIjubwFgEuH3sLw9pW76/W3ZFYiCom8GzfHuZGbe2fqzmsr2am
 gz9wT9vp4XefcyyTL4vfHPtHdFo9XnS61l9ymh+vZeNZdPaIWrc3phwg4tTWefrlDPVmRYs4I
 zJQdnqIHDRRIkoLRnvc2L1jbxrcqzm/kAVlOGZ3jPtR4d1y2XQPtnmrIpe717W1qtZvWM+VjF
 zPVbcgYKlDkx1UnFGR1Cij9Hork6gL3HsaG6ghlQlt1AM+OzKacHDi8UF8ohke6qssz3Qcjx0
 5Tck1BoBjVSgEOx8u9Cf12UTP6tcrH5uNlGzjiL0njOvJSTMiTNJ3DTmDl4SSMNHsYeI0oxir
 YerIPfixygOurOyOYfyxZ57Sl06e3/C/Wm9EhKtps=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 22 Nov 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +static const char default_branch_name_advice[] =3D N_(
> >> +"Using '%s' as the name for the initial branch. This name is subject=
\n"
> >> +"to change. To configure the name to use as the initial branch name =
in\n"
> >> +"new repositories, or to silence this warning, run:\n"
> >
> > s/new repositories/all of your new repositories/ as that is the
> > whole point of using --global option below.
> >
> >> +"\n"
> >> +"\tgit config --global init.defaultBranch <name>\n"
> >> +);
> >> +
>
> The above may give a valuable lesson to those who want to use one
> branch name across new repositories, but it does not tell those who
> wanted 'trunk' (to match the project, perhaps github.com/cli/cli,
> with which they intend to interact) how to recover from having
> already created the 'master' branch.  We may want to add some text
> to suggest "branch -M" after giving the advice for the permanent
> option.

Good point.

> Also, it is unclear to those who do not have a good <name> in mind
> (or, those who do not care to choose a <name> for themselves), what
> <name> they should give to take the "or to silence this warning"
> part of the advice.

Also a good point.

> It probably is a good idea to rephrase and say
> either:
>
>     ... To configure ... in all your new repositories and squelch
>     this message, run:
>
> 	git config --global init.defaultBranch <name>
>
> or
>
>     ... To configure ... in all your new repositories, run:
>
> 	git config --global init.defaultBranch <name>
>
>     Note that this message won't appear after doing so.

I came up with this, which I intend to submit with v2:

static const char default_branch_name_advice[] =3D N_(
"Using '%s' as the name for the initial branch. This name is subject\n"
"to change. To configure the initial branch name to use in all of your\n"
"new repositories (or to suppress this warning), run:\n"
"\n"
"\tgit config --global init.defaultBranch <name>\n"
"\n"
"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
"can be renamed via this command:\n"
"\n"
"\tgit branch -m <name>\n"
);

Ciao,
Dscho
