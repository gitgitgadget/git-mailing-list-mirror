Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819261F87F
	for <e@80x24.org>; Wed, 19 Jun 2019 11:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfFSL0B (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 07:26:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:53601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfFSL0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 07:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560943555;
        bh=K93zw/wK5kFFDJRvKdm707+xdBh0QGz+JEYP80nCzoE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FrbTOyCei+MnnQgfwX5yzI9daX1kEjqfwXdA4xflftwGos2tKM+cqdtGW9vLSkDOm
         P6GRSPH5SdqHeoGO3DV/TQf6Y9yTGAiaWCk7arHiYsNaC7+2ltuXkLwdoPjrcX5x9d
         qW72vzhZCkWx2uBashbdFsEWzh/hiWpiDNHMZY9M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuxG5-1idfXP3x8T-0100ol; Wed, 19
 Jun 2019 13:25:55 +0200
Date:   Wed, 19 Jun 2019 13:26:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
In-Reply-To: <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191325130.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com> <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com> <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
 <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iV2U2Asg82tlDynk3CKR7rU7YvYL3rM2AjkmyKJsvLxMI4JA0W/
 29xpLNXRjtJJQPJ8xsOfIvdUQcYIYzD4kSzFVUPoVdiM5T4f8QgeXzI+ekeSzfcf3tg5goB
 o5ivBDek7fc3SAo46wLgxk4jTzJF/pDBU0Soob0WVxrn9nyEc+O6Nkjr4OUx8fuzjo9wgJX
 dAeiJLHiKO9SbZHlfjwWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fvOirMc8aE=:8MnaQeKEqormeBNqQeNrwz
 C80jfCeRlog2WzFRWcU3HK9X4lpzhm/zHvDt7d/hL+/Niybhb+k2yOviiCzkTBuW2zE2ppgIx
 Onw6aq8jjAGNEO2PHu3vN2tuaneD+jVhqK0rbpua3I+LBb9t6d2l+wMTtS4uwYdAwcHc8awRB
 ag4/a7M2xeEJse07moY7dENHs6S7nt5UGHi2rojCmeHASlZUJVs8hW5GGmQ7vC70JofzEOz7F
 XTrhpZ9mECyXEUbOjmauCQc0BOvyIq5sYDZQ1lYKElqKHq3mEIUNvlMJE1DsKWLOk2gamtDFA
 7kQZH01Kt6R5y+kTQ0L7og4ZGalMUEg6v8dewWemwJI4kRj3M/jHcpAO9bxNB6K2gyliGg4Bf
 VUSPef818zFQG1+NHBhXhWzYiB0/CYcQAZIkZXgRuImu+XOAYUxFh98918bI3jyI6ncOw5WGV
 dtiB3MOAN47+h3AUxRTGe02zwMCDEZE1kzmsUsnKNRzrtecf83WKPvV09JZNKa5AbowReOhQs
 R2t43CuNaR4t2rreFkJYaT6AlulhWH0OYN5CGLSzSNTrpezY96k0Ml0Xrc1y7ZaGl++itw04r
 QX27urwRPH71JPI2ahOrHXPecFPPR1jC00gNDrG1ATqcTPASIjUqfMNVLEhJ5UCRjBgxckdYG
 aqdvIrP9qw6NxXJz8PmThzqQ+dzrWgFJ4mM/TlF+3pEkrg5tvad1QBxRVFKysRHUtEE8hpy7+
 nAPiBgx/3sqknKioAZ0LdAm40/yGHFTPskbovuW7QbUrcdeweLlh5bndMBivrwclmgOKdwOIG
 lDqRs/br4kFjjnoSLK8+44heu5G2WdlvRkyjbhKGAtMwyM2QmXCMk4BKfL7ZtR5KG2uz6EjnI
 FMyIT5QM2lzA3M9jUpOrzULzErakiuIBj/dTnH5uIi7D4BJZSbHxepm7rNihjWUOodImyJIug
 YMFc1YPXNRSbQkxHlOknFhQiA7kfw4LKWsKeUd/nNkzhkp4KC9moo
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Hannes,

On Wed, 19 Jun 2019, Eric Sunshine wrote:

> On Wed, Jun 19, 2019 at 2:19 AM Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 19.06.19 um 01:12 schrieb Eric Sunshine:
> > > On Tue, Jun 18, 2019 at 8:24 AM Johannes Schindelin via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > >>         printf ".git\nfatal: Needed a single revision\n" >expect &&
> > >> -       test_cmp expect output.txt
> > >> +       sort <output.txt >output.sorted &&
> > >> +       test_cmp expect output.sorted
> > >
> > > It was quite surprising to see this sorting only 'output' but not
> > > 'expect'. I see now that 'output' is already "sorted" (in that sense=
),
> > > but it feels fragile. More robust would be to sort 'expect' as well:
> > >
> > >     printf ".git\nfatal: Needed a single revision\n" | sort >expect =
&&
> >
> > Following Dscho's recent objection elsewhere that tests tend to check
> > for much more than regressions, wouldn't it be logical to write these =
as
> >
> >         grep -F .git" output.txt &&
> >         test_i18n_grep "Needed a single rev" output.txt
> >
> > without an 'expect' file at all?
>
> I considered suggesting that, as well, as being more obvious and less
> fragile (with the exception that "Needed a single rev" isn't currently
> localizable in builtin/rev-parse.c, so plain 'grep' instead of
> 'test_i18n_grep').

Valid points all around, thank you so much!

The next iteration will have the two `grep`s instead,
Dscho
