Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5717C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DE223EF2
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgLKLHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:07:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:54537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388605AbgLKLG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607684723;
        bh=RMORzVlNPeNuDGgcdj7puidmREEBEJS7BsGj5CjJTAs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hz9HXsN4p3QSelo6vyFaSL5BAKzTNsfCMqe4jIZP5tLECSHh6I748AzSr5r3i6bWQ
         xHB6au1k06YMm6C+/cdI6DTLLw4XPgvnmJyqOnlnq4h0oYW+Ts8YBekXPXIPFuaQNe
         yrnyjqiATjFTvef9GJuDY2+JM1ZXW4/cOa3vIf3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.214.172]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1kZsQr0ILK-00VMSP; Fri, 11
 Dec 2020 12:05:23 +0100
Date:   Fri, 11 Dec 2020 01:47:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqq360dqgpa.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012110145200.25979@tvgsbejvaqbjf.bet>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com> <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com> <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com> <CAMP44s0mEsfmc7gT6Yv10_nt8d=HrbETmnwNNqxVmRGdHSOHYw@mail.gmail.com>
 <xmqq360dqgpa.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d/9Dg7DoRkgBlkBmcQGL/53VJ/g+qfgkTXZ+jClpJPydyobB4Oj
 v+1VKUhuQ0zALKKHBJIBrvp1z6CH9NWCitNrQYv0zjW2fzEzWL7ML72O+BBUM/tiSPmtmUv
 r0Pbk7rSgL/LQ/lYv0xnb7tW8alS/xCH20IUOsUvyiXGqeh7Lc7yDWaSa46f15VSnzLNbvG
 rmsTMJacw0Ox3LlgAmK3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KhJzOk/0CEo=:gTvVMOTW+FTMP5lDhLqNdD
 6pAqbvKuor/DsxVd+A6nyTnsylSneq766jw3021xGwkPKXXPKMO7GueW1XooLUO7Yp+H2z7vH
 oHonWAeY/xLVXmzLHjwCmCzDKmE5QBYDB4YqYbmaCuSRV4pfUWIJIgQXKRY0OHkgXMrpZK3xu
 YYOzbCJCc6xDFl45Y2/3qQgObXPHoTkZn1oKlRDOzhCraIrStuixwQXk16EwraxXcDTd1tMEq
 93R704+8JaCkErhpKLGYSs5IYxv2eVwDO0YD4zJpzEsfld2C/W4RWtOdsrqjp+e8GFS+X+Mlp
 7BHktG2iIAgarOtfS9b0+NE1WY5ei5jluzhMZz5saEGl1W8RVDOv4oU44u1od5nrU0aZBZWYn
 DL1vIaStSsahyJsdJvuPzrRSyMvTfZUMHMCfh4kG1bFLLHA8Osyv4vT0XPpJ3Bpwzd8cE4jqW
 8Vg9uSX56AJEOWnMVjOhatbNQ5FRSEFtEWRGFClTNuq90Uunelfd7mXM/PjrJ46X56YVnq4Ab
 bOQCO5z1+/2GXsVRtVmEyEh5BDyKWXLstRWQsPRTw8yz9tIb0CC5qCh4AEF9ML/vx9KnbzmmA
 o8CQhgbt1ZZcAW4elydLoJnE+crhwrxRkYPFHjPvOYyjisYn1JVUSftV9UUk2TqKiTEOTrDrM
 FbsAIFWZJZF3TdQJywLn/GGO9F/6HMactUQQFu/7tiOefR3bDHTHiGEbD6+brQ04VnTUtJKqr
 XMsGP7dJBtQJFBMLlWqsSUCHJmahXbzZMs2cGa7HCFIXJTs1RtBNHSqT3raj6XGbCH67Um39f
 JL4h8idgXdzUPqCCIsST97GGNRJ5PKzCk+G8XcvmEUOoEsqcxKgd7Xwc8o4gGdqZoDFroA3cX
 pVKbkIXLk1iuwH0C8phYVfdcnWdCxMfnIAsxU9UNw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Dec 2020, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> >> +static const char default_branch_name_advice[] =3D N_(
> >> +"Using '%s' as the name for the initial branch. This default branch =
name\n"
> >> +"is subject to change. To configure the initial branch name to use i=
n all\n"
> >> +"of your new repositories, which will suppress this warning, call:\n=
"
> >> +"\n"
> >> +"\tgit config --global init.defaultBranch <name>\n"
> >> +"\n"
> >> +"Common names are 'main', 'trunk' and 'development'. The initial bra=
nch\n"
> >
> > This is disingenuous; the most common name is "master"... by far. In a
> > couple years this might change, but not right now.
> >
> > If you don't want to mention "master", then don't mention "common
> > names" that are not really the most common names.
>
> Names commonly chosen by those who want to move away from 'master'
> are...

"those who want to move away" sounds a bit too non-committal for my
liking. So I changed it to:

	Names commonly chosen instead of 'master' are 'main', 'trunk'
	and 'development'.

While at it, I also improved the next sentence:

	 The just-created branch can be renamed via this command:

Ciao,
Dscho
