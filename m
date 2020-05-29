Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC6C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F4020897
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gUogjlA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgE2W3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:29:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:58567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgE2W3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590791385;
        bh=PInr4ajsQ0nHLRnGHZLQk7Wnll/5BXQAO0NYJrMZLrY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gUogjlA6HRFKGFBeNfLzNZHD9Mhlx+8IwuNWCiSFd0D8AqAO9i7pZ5xB/h6MEIIKc
         1Rmqpt13IHwyfc0B1PP9mHkXDHVbRkE5Ky7xYR4wf0GaA3UJ1zbNCfp2/KuFL0QZAJ
         FU5T6OD3yqdwN9qYJdBg0/HD9JLsRoSxgaJS2b3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1jZO7B2WfE-00Tipe; Sat, 30
 May 2020 00:29:45 +0200
Date:   Fri, 29 May 2020 07:56:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
In-Reply-To: <xmqqsgfizmcf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005290748580.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>        <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> <xmqqsgfizmcf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jApOXGm5szsCMRVeSeT7O5JsqZaki+Cmy26XCwnfNYJ/nnhy1dQ
 HynXhCqoAQVG8JDmBOV95cHSZmbGI3uQ8SR5/Yvm3NWhJ+7r3ccemvMMNAgZJsl+DqvU61e
 AUUFFv1zZRW6hwv1+5aS9LqHr/Vl9H3QhfQq4/r4cv0ojwigVDB8ji0AuWSzWb0H4FpoofY
 AZ+XA4PnqIessbF4uyd2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mb8uwlAZGzA=:+s9fkmf1hn0co7ZYldqrxY
 fdVV6cwd4Edii4FFgTYiimW71giYx83XkrHcjI0L127GxhQHmjeTT/iUUiwWut9VV7dl6lvU3
 anZg1sxXIewjBrWPKqxY5KQOxL2ndfalG02jFnGpoxXVvzRiVbG6dfe9SkPj3p0yNXDWKuWQe
 NmRIsH131wVS/YE3J8Su6l0fDlxxabRpaLVKOPuDbcs8HW8A1BHFdQ/vx8v2VO4tiwZ1AlilE
 7zbgT4oOlKJqw/lqDdmvLODJauHBZByg+pun873vrzHQxv2pnIRa2popuBzRJR4Qk7LvOdxy/
 H0vm8VRMF5YN4dwkgUHH5ebsDEuQ0KfkmY9EVoE9UXQYgdJ2yLupgbNjymR1KEB7V7FDfdAmu
 H0Nb4O3v0iwEioW27Ltk50DWAls2X00doqbu4bcVe4GzL+ipITRG+WmfCBmnq0LbcZIzx2yo9
 hmVSAwGG+CzOSNE/Q04FKzAjlN/Gcwm4cGPM7MlLNbfh8S4hToTYAsa3AuvdIxh5yLu+WQXUw
 8gzA+d5Rb+zIh2sti3p791y1pyyirxPfvBtVIMYvBQWB+IxZSitu/ILrlUQpBeeUWqMw76NKj
 J/6yuFJ47V+auomZP+6eADjjHNdchWj8F/x02quC5HQycboMAn7B7VZondhMygDz2943/1AyY
 hHcCqBsMHnFQ1HdUogBtCqd0CHap4tXhC5O/dqTA6my7FuNRQ2ALsqXqThovKU+eIkE259lXe
 pajNvopWlOvl8CDbkIlXvOI5O2rvEG0qtSqt9CuvUMcL0+doH3v3JRItmo/DygrRbM659GIGy
 Gau3sD0Ah601uDvdIT3+EyJQx09sG0sQ843+ZnTpL/tk0EPuBatYnEiMKLOQ/Jnhq+dI1sNAQ
 6phn7Bso1/u8MyXenWVjT5evNXc1CuIL3xF68MyWm4ntLIk1I+h7OkjM1iAwxIEfGDb7aWFR/
 2HBu4S8Jrd9cRZexHPM9MpBsrDBhP3dwy3NhZ2Mn1YfkiUMrB9+yf9hYSMlWe68TuiB/EvhBN
 jBLwUCv/pRtAz8QrGdJ0c5MFzdRHEzGF8kLOL4/74xT+w4eab5AxsmRcK2tkBiJyHiJirXI9p
 rm2wgYhK7MJXHtD6MMoUuNwWWL4lg/brXm4dGJWL7PhWR8Dqbh+c4OmnsudOodo+O0DNwTgRX
 eKhGhqN3mW6ST0prchdl4Md7uC8WdUk0MgDO6Qnx6FNpb4qiwfd3rqEvDAAQuIpicmZc4faC5
 HZGNCUeskszyElcJX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 May 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Dear Git users,
> >
> > On Tue, 26 May 2020, Johannes Schindelin wrote:
> >
> >> I hereby announce that Git for Windows 2.27.0-rc2 is available from:
> >>
> >>     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.w=
indows.1
> >
> > Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if G=
it
> > v2.27.0 is released early enough). It has a (last-minute) bug fix wher=
e
> > the length of symbolic links that is recorded in the Git index is the
> > _actual_ length of the link target, so that `git status` agrees betwee=
n
> > Git for Windows and WSL Git.
> >
> > Unfortunately, that means that every existing checkout that contains
> > symbolic links tracked by Git will report them as changed until `git a=
dd
> > <path-to-symlink>` (or `git add -u`) is called.
>
> So, this is not something "git update-index --refresh" would be able
> to fix?

I just tested this, and no, it does not fix the issue.

The bug in question records the length of _any_ symbolic link as 4096 in
the index, and an `update-index --refresh` with a fixed version of Git
apparently does not update that (the contents did _not_ change, after all)=
.

Ciao,
Dscho

>
> >
> > In cases where users use both Git Bash and another version of Git, thi=
s
> > might cause the problem where one of them will always report the symbo=
lic
> > links as modified in `git status`, but not in `git diff`.
> >
> > Sorry about the late heads-up, I only just realized that this might po=
se a
> > problem. Granted, symbolic links are not all _that_ common on Windows.
> >
> > Ciao,
> > Johannes
>
