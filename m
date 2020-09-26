Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014BC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50E8235FD
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SoQnqOI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIZUdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 16:33:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:49081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIZUdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 16:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601152428;
        bh=Gn8W3Z/CwtJHprkdHe2splCAg0R70WDIM84vAmgbmV0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SoQnqOI1TmzgxUQGhhQWSCxtxZz1o77c/Q0XQcDjkFdaULWMw8+8iEnngTkzDHX/a
         U7yhxyUZdZ5sIJNLwiB36PJzvDy6efvV36sgo2XTkAaD8QpWpwYdfrYRkIV0bhJxn8
         iwfEXqZAc+7RclvEUur68O+oICLEz9SoKMMcnKYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1kivRp2MYf-00llCU; Sat, 26
 Sep 2020 22:33:48 +0200
Date:   Sat, 26 Sep 2020 22:33:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 07/10] cmake (Windows): complain when encountering an
 unknown compiler
In-Reply-To: <CAKiG+9XqJ92rjVczBG9ByVK_KRfJeToO0pFb3RhFpom2ChFE-g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009262232560.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <dddfa3a9b48fa24466a20952d485be1a7f515019.1601044118.git.gitgitgadget@gmail.com> <CAKiG+9XqJ92rjVczBG9ByVK_KRfJeToO0pFb3RhFpom2ChFE-g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tUpUHvRXAsx99L66xAK78oREpYiJVfW4OFkSWf75wtT39kUcz0S
 mu1lZMTk1QyyyteSFuwwt3NzURnOJEzESniiM4nQiqVMmsO8zfWTUDNrkQMSr+FMOQrk8Z7
 J+rLVarTL3ZyIWt+at3Xct0m7/DxICCLH4DnqLl2Es6PeB75WWfxftvEiZIjBncK8qWg6GV
 d6snmc4FnekLvHIauh3cA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GxqiEOWnf3E=:KBNpZ5kjnpfDOPn9UpIPi+
 yKHY0fno1Eu0RwhYoRF+SvqzuZuVfD3ZwbSJzxi4bP17ZLuFzhXJdgpCwPf/g1J8iZnwpSDXM
 T1pZSdX5xZx+jZAHsbYY7NdaF/jNJbcP/9vhvwI3pLzgSiWqyTxrm1voe8TH/iyQ+oLyRcgu5
 UiD1srGnDaB5cOZLaOGhX3er0wHDNieCQ9tMo/9pl+AQtmaylhStotFcKqYh82X49bs1NoLQk
 NnZO75LJeF386qFk/EQLGO6t7Txdd/DQ6rh8IHHXYpQzln1cNfWUr+Hl0iXDCGJMiLGUhwpZd
 IxyG3z233ZNL+ll7hNtp7VkttxhJVWOhZXJAy13sICMZD6IxhXl6Kh/lrQlluSCtMh2Vwfyjj
 pTADBdGsCtxaowmo6GbchqnPwQyKVoTwJnHV+FnmKe7nRlS4GOjbvTdOgNOT9h0xqEuBShqD5
 uLhSe16hZl6AWvpy8b/0AfXIGEZt11zpYcNPoXRvsIFDLQv4QF+/VwrZ/2h44n/6THW+6zljA
 IDs1Jnv4t220qoLB0v5ETL4IzUdu2vEgzZfRnZ+XCM1CYCQfhUJdkwrrIqq5fdHukdMjwMOyZ
 VQBaDRvPZ9DR7785cirOpPiKUuFcVCk3pUZ5iBzuW0jsMcGtcbNm8vok2gIwqzylk/4ME0ECN
 alMlOS1kMacYOrtFPPtbyzj9XQiqH9faSUMlMvs4VEMcNSR6FrsNdPD/xFRBtHB4EQ/7xm1nJ
 hZfYf4H1jt4BWvqlg06ShooBbKsGo6ffIfHBGlyAEhPLZwwtr27CSzC+Qb9WktYOgFD3VP3iF
 o32qzG4NI7IVAGCzp4I3H7hLaJWUy6LXsl7ae3x2vlDYDrrdZ2Tt7fkZPOuvMy7DVkI+W9qbo
 MloKg0/lqiIoHwbtMf0Yf6di7+i66jo+wvM043omQeiQStrtx55J8AWaR0lj+EXJh/qdD6kNw
 grtMleC5F6rtC34kC38lzCxNC4bcL+jJWBeZeZ2adOU60jhFBSiOSTagx3NjMQh0sS39fd4Pt
 fZuT4M9rOL8RYARfvanyJrUW5KfOaaMb1hst0j0F3EwqYI67IAuCFEfcpGXAE+vxeP6Dw3/dQ
 R7qChrE190Y5vyZdi0d2Q6WQQ2F693RLMv3PV7cvieWeXfi7QevbCWo469DvLLmpxIjiH1a68
 zinCCurGWNoymMn/ulOKwR0THtfRWoRcB2IHkyy3EJu0umcuTJXGxqZxiqtw4NMZcVIuagDB4
 H+DvdKrE++aLVUZNEkpHOK5HUW8dzCJAb2e44Xw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Fri, 25 Sep 2020, Sibi Siddharthan wrote:

> On Fri, Sep 25, 2020 at 7:58 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We have some custom handling regarding the link options, which are
> > specific to each compiler.
> >
> > Therefore: let's not just continue without setting the link options wh=
en
> > configuring for a currently unhandled compiler, but error out.
> >
> > Note: for some reason, the `invalidcontinue.obj` trick seems not to wo=
rk
> > in this developer's hands when building Git in Debug mode: the asserti=
on
> > dialog that is supposed to be suppressed still pops up, complaining
> > about the `entry` variable being uninitialized when it is used in
> > `config.c`'s line 1961.
>
> Does this happen when running Git under the Visual Studio debugger?

Whoops. I meant to remove this paragraph after addressing that `run-time
check failure #3` problem.

Will remove it before sending the next iteration.

Thanks,
Dscho

> If so this might help
> _CrtSetReportMode(_CRT_ASSERT,0);
>
> After digging a bit more I found out that _CRTDBG_MODE_DEBUG is
> environment sensitive.
> It depends on how the debugger handles DbgPrintEx().
>
> Thank You,
> Sibi Siddharthan
>
>
