Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FEBC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33E420862
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cSd6r5nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfKYOZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:25:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:56287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfKYOZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574691905;
        bh=nOLbeE0J5DoviHqRw2RYT4a48ORcE7LT16W/rCEXzIA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cSd6r5nOu0sxDSfcAoG5OGwI6XB6idg89Va/4lfNuYFT8djvD8eykIpUtq+u7XADy
         DOXrmx2CWOgIu0OHf4pLTaz6W3I8M0BWurHi4QDSUI/pKZJ/eQedgEHRVXW/XvwsPG
         ss/EnEsRA8PJHJN/GM5Pa2Coclf1AMRUg2t8T+D0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1hjL4H2ySS-00s4OQ; Mon, 25
 Nov 2019 15:25:05 +0100
Date:   Mon, 25 Nov 2019 15:24:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch
 mode
In-Reply-To: <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oyT1la3/z5JN9l33zEuwOd6IoHoo52XVxOxTQl2roTAXJclVeab
 ZJL096NfHL1bTLd4jCC1e3EEHGlqFiBbzBQ/Pt1Q1bUnxRULodvZOAkPhOSFaoYYCLTvms5
 /pRRslRyi/aCBw9z3DZpu5Ak53XhufgfDBqwWJQzK0Pi616NWl6GdZ7sOUbhzEQJ88swSSE
 LVKVk8t5IEGSBNtsUMsmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6W+SYTvK78=:4kiozmpe464T81oelfzH8b
 Q7wC1/Cs2dA+8ogKqW3hTU+PGEKoCTjNvlSIq3uwJaEJ3a+ceLZZF++J1ZdorKElNedxQvNvo
 pwzTgeG0LJc9twk0NQjQ1/Umi6jjM0tdGlP7Ae0Pac3YHA/GJKUcRTiBzbtyPPoupepjFjEdZ
 3Q0Tml8QIjO0Jw/e0EU1eSg4mtEmIGycxFZme8gXtAtGvZEIwJxo0+2dcXoyJhrLqiq+tsKMo
 96dGlUjFkPKhDmgjY9ZJXGUPR0Ml/XE5lMOYqcW5J7On85NfCcTOfUSK/DMlVYdaO6pIN2q/V
 hm2UN6XnZbHRDj8/O6JFBJQaoKo5/vavsX5ivU1XDmN8K1KrD8uGgjWjtjO2LdYdV8t7P9rVu
 LU/YkxKJLaVfhJo1x0YDOgQbkaE42kcEsc2Mu5DzxF6v35jT+C50eus/VGo9qSJ7ZN6tXJ93P
 mDtb8a4IIKVz3u6Dv2S/3NWC6s1Ai0Gw6ghgGJCSJfxGORuuBsTMKcIbtxn/HDbBxq4O/fX+t
 /eoLU/U4RjUUOz4EfjctZjzwM9KghxxAXQixsUAmKrE3YBVStC/JmOrx0U0wKmH+EaJFPRfcv
 A7Bxc76ETRb+xokpjaOfiE6dP/xGIPdyklmMzDEJT4oHgFim8JdfDXnWMRwmkvcnhCWux7SH9
 pBLPMlrNjd9dC2XxNbpL3HzyV7vKEdru8CYE/nKGnG38Ydxpbmi+ItzEA1tY4L9VD5vapezOU
 MefhUPeSr79Gqz9YJXNcOHJqETvI5VLsSPmr3fpty3wjDafDKp4pu6lwQ8hWV8PSkLJhSNXrG
 DK1vg1X1PTYFLH58OrbXbukzkPAzQpxJHK88eb9yW4AX7L9eljgw6/ILPxrTq2wiHApEICWWw
 BZ9BEDsMAlS6gJORM5X7nsGgAOYTGa4/vxzeTpIN9qZhadSFtUjXTiUE36yDqMgRoPYKjitqc
 ym8v53s3N0Sq+wakRox2fk2fYOSPciZOgpbHMeww8LlXkVJbRrNSlpp8q0oCd1CtjG062jXvG
 EsyDr7X3B/VVV2ozDrhsa9/vbPRVOZOe8w2zAijEkpTtorZ8HdJXkc7xiLiblmAKYrVMBdBUr
 n84m0TSoKE11GH3na/NpWotj05Dy57+bNJW9KNCmZKblZqYq1Ao+SitP7j3J6D5Owq+YeauHQ
 b8LgfGvuk8WvLRUpJiXEW9ydCouyGanL6wc48Q684MSmSqQQkvRiWLMNVmqWmmB4mgeR69jjn
 m4G6wq26f347RTAV/EIF1ENILw4ThQeFv5B14Nmq2WdFCkCYawg9iNDTjJNc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 24 Nov 2019, Junio C Hamano wrote:

> "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The refresh command is called from git-add--interactive to ensure that=
 git's
> > view of the worktree is up-to-date. This is necessary for most command=
s
> > which use git-add--interactive, as they are interacting with the workt=
ree,
> > however it's not necessary for git-reset, which exclusively operates o=
n the
> > index. This patch skips the refresh call when performing a git-reset -=
p,
> > which can improve performance on large repositories which have out-of-=
date,
> > or no, caches of the current worktree state.
> >
> > I chose to use the existing FILTER property of the flavour to make thi=
s
> > decision. A separate REFRESH property could be added instead.
>
> Hmph, I wonder why this was sent my way.  How does GGG determine
> whom to send patches to?  I, like other reviewers, prefer not to see
> earlier rounds of patches sent directly to me unless they are about
> areas that I am mostly responsible for (other patches I'll see them
> and review them on the copies sent to the mailing list anyway).
>
> CC'ing Dscho who has stakes in keeping the scripted "add -i" frozen,
> while he is rewriting it in C.

Thanks for pinging me!

As it were, I was aware of this effort, and I am quite happy about it (and
of course I will adjust my patch series accordingly).

Thank you,
Dscho

>
> Thanks.
>
> >
> > Nika Layzell (1):
> >   add--interactive: skip index refresh in reset patch mode
> >
> >  git-add--interactive.perl | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >
> > base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-475%=
2Fmystor%2Findex-only-refresh-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-475/mys=
tor/index-only-refresh-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/475
>
