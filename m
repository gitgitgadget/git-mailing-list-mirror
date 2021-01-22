Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8736C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EE323AF8
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbhAVVTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:19:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:35559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730556AbhAVVS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611350209;
        bh=1VQ+Y4INZYvn3PNZkQRrN7fseUjLJUtVOQVGWprIa1Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OFA1+5zY6ea/QhUt4wQw9+1H7MrxeqDS2vQJtOwmVl/tplaxYdF1Etz0ARE2bqvk/
         lypA3gpFIa7qCDJrPBPHsYIQBjzTFUZbw51Lxb/lGt9NTbhLUGvZrB5hDufpK+zsaO
         ytdvzdNwnGPZ8LLp1PQuTmXh3aSK3i8DaBE0C6ug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1lnjlW2YYB-00qgE8; Fri, 22
 Jan 2021 22:16:49 +0100
Date:   Fri, 22 Jan 2021 22:16:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] SKIP_DASHED_BUILT_INS: respect `config.mak`
In-Reply-To: <xmqqft2tc2w7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101221935230.52@tvgsbejvaqbjf.bet>
References: <pull.840.git.1611234585889.gitgitgadget@gmail.com> <xmqqft2tc2w7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KJ24XrysBP9krQJEpO+zS6GevB6i9VkdKv2/tG8QU1zuqTOk5O3
 +TAf5IXDV0Mpj3xI0zdjlNsDIhuOxYXcFGqP4qUO67lK35E6VJqbK0cPXygW3kUAyUH7Lgs
 4R9QaVEzarQxROngZPhX4jFw3j0uqPFp1VriNB4KYEz4zZp+CUDOejEcBgbtmXrP+DPpas+
 ZtojhqDe1KfJHqzayQ6jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QNI1u+hwM8c=:ho2zp4nv9ez9tNsgK9x+FC
 t5N9lqS2Xuo/RBF//TlXYdD7Vp0EKEHtK8IJ1aqNn+Yg9362RPvhw7zJGSt4TL5ECZO0Nk+W6
 Z6HA6K91ZGniUwm8Bo96vep4GKGgHEWcsxrClfAN9qemzLiDE21jtAty8Ng+wVgtuk7DDo3Kz
 QQ+1IAG2IaQFJkNbjrwTWkm1siDVDu2BgpGbEK16nBInhnPxEsDMdq+BZ1xREIfEPy1MIY3rk
 Cg3RmfmR3sZOgeStA8q1cVtqMzHrHdOwoC8d8M8XY78Y/w8AwxiZ407IOO+NjMoQZ1Tr1YAiR
 IwudF75PcaBNRDbMyFnNUiQcFBFpspEO45nVxQpU8f0d6zFPxluJmPM6rItC2/1u3MJoO44Xz
 cZcItJkkolyw3pjiuZMYSi4/AOpZDFYrENv1eNLPJY65nQd0ZIIk9UDnZSd6kOPu2n1R4qQiq
 FyjcfOztXrZcWQVEZXCEV+Pd7B93cfGR0SM+FWhbaR0Mq3cER+dqckXV2RlhksSxxSfZAbKUX
 dzEnQx/MGqc0+TtM9R3UviYqGWWOvG2Le3HYznw5uAhb2jEAsUqG5KfBFhn1b13BckTUFbWVN
 kzWT37wGvwNgVBDsec67uXVnFMVjVmyfU8L2jSgBw80YHeVR69GG9hb/9gnBFz3xy1BNgTrEu
 ARfI0hcTpxbz8WbCMVQwBpy+yxk1OWaRZQL3aQFtA1uZsninrieMxjRwAk7zYsO16QbnE9iJY
 hJtv9qYUPB9lirPPth1HiwFrCk8gxjv20yEvZeVzG8AZAfvOLBPTyCBngDIlGwKBWnlfU1fA3
 inL2t9K0TXF57Brk40Aa/bw9hC7es0TeQ9ejEPJ4/FFdT8A+3X5GcKNGXA+m251REXSgM4oFs
 HYYHKt4BCGF9MCe/WlgVYf0V38vRoaA6OnXsv2zlA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When `SKIP_DASHED_BUILT_INS` is specified in `config.mak`, the dashed
> > form of the built-ins was still generated.
> >
> > By moving the `SKIP_DASHED_BUILT_INS` handling after `config.mak` was
> > read, this can be avoided.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> OK.  So the problem is that the moved block that sets ALL_PROGRAMS,
> ALL_COMMANDS_TO_INSTALL, etc. depends on $(SKIP_DASHED_BUILT_INS),
> and that happens before we "include config.mak".

That matches my understanding, yes.

> That makes sense.  Will apply (I do not know if you want this also
> on the maint tracks and if so which ones---I think it would matter
> if you want to cut a maint release from 2.29.x or 2.30.x tracks).
>
> By the way, I wonder if we can (semi-)automate looking for such a
> mistake in the future.  Does a simple rule like:
>
>     No variable that has "Define X if you want to distim the doshes"
>     at the beginning of the Makefile must be referenced before we
>     include config.mak
>
> work?

That would work, but we do not have a consistent format there. Exhibit A:

	# When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your pla=
tform
	# supports the KERN_PROC BSD sysctl function.

Therefore, automating this check would probably be a bit of a challenge.
The best I could come up with (and which is still not complete) within few
dozen minutes was this:

	terms=3D$(sed -ne '/^#$/{N;s/^#\n# [^ ].*\? \([A-Z][A-Z0-9_]\{4,\}\) .*/\=
1\\|/p}' -e '/GIT-VERSION-FILE/q' Makefile)
	sed -n "/^GIT-VERSION-FILE:/,/^-include config.mak/s/\\($(echo "$terms" |=
 tr -d '\012')NO-MATCH\\)/&/p" Makefile

The only thing that sticks out in this output is that we use SHELL_PATH a
couple times before including config.mak.

And I don't think that this hack of mine can be converted into a robust
check that we'd want to run to verify that the Makefile does not use
constants before they are potentially defined in config.mak,
unfortunately.

Ciao,
Dscho
