Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60856C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301DD64E4D
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 12:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCOMmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 08:42:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:38127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCOMmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 08:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615812140;
        bh=PjDylN/3GZuJFsZEWNOcuxNmu/LX9JxtZhsqIWeiUyQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NBNhNEQthlNekWlak4P1JEiyV8LANZwNwWhSxyhg7tAgOf3Z7dKzLkyr6/OfAdqRh
         wmOOujjfpm1DKAq2zGJNEXeXg1IV2nAjkB395GeFjj5bHlQ6rRoBoYsz+xFRyPUGh/
         rjxtsrZfrA3RXTe75AycsKt5F78fpRRTvXDxYpFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([213.196.212.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1lveXC1VoE-00hhFJ; Mon, 15
 Mar 2021 13:42:20 +0100
Date:   Mon, 15 Mar 2021 04:43:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2021, #04; Sun, 14)
In-Reply-To: <xmqq35wx2ccy.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2103150436260.50@tvgsbejvaqbjf.bet>
References: <xmqq35wx2ccy.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z1/u6FnROOY5oT5jAoZSrEPqnw0HJdEdLEmJFr3ax3IWJzM91To
 io6Kk85JnVyaRqgWo8sz9wCTJr0eUL7KdUH1x2CIpWtnD3EMk6nmwsUavU5LdpSS4P2iuSC
 Ho/QK3UaeFBZHokx8gUlcOen9p4rRdaSVT/AvB5ufQwLviQbK69trT3YUwiB63+CPOheRMW
 wvLj3n2HLYew966QA+N+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qGhifrHDe7M=:ylK7da/QRm4HjlTBuBWRBY
 Xadf7aXixESfwgYi8sQOgcavNdPQEab8R7WdmlbGiYwMn0Tu0PMaU5kyaJkjCFsCfi+Y0zGhS
 xuC/RQCTdvcmQCR8GvUtWc6xopLS1g/xp1lgxAycYXm+UYGKkZjCl1ejPfaqkX4ocaRexhZtl
 csTbhN451640SUTKpByQ+VRPmlNBEXZjhkalH5Pj6ZVXSoOoILKPkKT3re/L8LK7YoMGrSCkE
 CqfYsS+1NutcjCWgrT+6s7qkBCMLJeEMrPwI6BV7xm+iukj2Spa/BNw3R0RFf4U6SkV0v53th
 bXnf/Zc5tbkdtG3+Sn+6gMmaOgzT7hBLmh6+bbUIPFP8I4ILcoOl2BaqqMNYerZWtnabCS1CN
 0ej2E3NoQkhb0drimygbiLBQj7rRgZSVZbRWHPw3wlXmR1IZ+ZcIIdpEBTssw9l5a/MO/6HFy
 QVNiCZhb7QaoYR87P6IZgyxu7Fr9NCDne3UrFtL3JS5QVNUeV9YUZ4XeOtdD/w+oIdNMVn9xi
 zrJPl8RQTGtLjBsYIkkH0qDANXFvl2XLXdygNoZnWz9nUfIrVdrMyq07OnLf68hopdME2uV3f
 Hft5r82b00jwbM6wer3lOJ1SQqD7StaVrjYFQG3yLIfeGBChzYoWgVZsPQkGR7nfTsp2JbEpZ
 RSKsxOQd4l8NE2XSb9/Rg82AliJSYpJZs/8JQJURO6RYJH4/tmb7okRH8M2hGDWCkmWIM9X9S
 kuI9f0WrkQOCg4cYgPDyqR/pdvy8DCftDAorH7b4Wywf73E9eashWcFV9rvfYuGiSWPPh1H6r
 igdMk0MLpH/1eb+AD3hBfF+PR7T8SYA9+g/5FCjDoIsNksS8d+FZ26t87q4KJ/DhkFijKkKNE
 yhgLK3ECaTIO63rtjyD74NgDadiqPrqhQAMV+1/fQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 14 Mar 2021, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with '-' a=
re
> only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
> with '+' are in 'next'.  The ones marked with '.' do not appear in any o=
f
> the integration branches, but I am still holding onto them.
>
> Git 2.31 final is expected to be tagged on Mar 15, 2021 (monday).

Okay, good.

> [...]
>
> --------------------------------------------------
> [Graduated to 'master']
>
> * jn/mergetool-hideresolved-is-optional (2021-03-13) 2 commits
>   (merged to 'next' on 2021-03-13 at 23f5a25716)
>  + doc: describe mergetool configuration in git-mergetool(1)
>  + mergetool: do not enable hideResolved by default
>
>  Disable the recent mergetool's hideresolved feature by default for
>  backward compatibility and safety.

I do not see this in `master`:
https://github.com/gitster/git/commit/53204061acbf7a03a6ba050f381e0bf9b01e=
3a78
claims that it is in `jch`, `jn/mergetool-hideresolved-is-optional`,
`next` and `seen`, but not in `master`.

> * tb/pack-revindex-on-disk (2021-02-26) 1 commit
>   (merged to 'next' on 2021-03-12 at 7aa348d3b3)
>  + pack-revindex.c: don't close unopened file descriptors
>
>  Fix for a topic in 'master'.

The same here, I cannot seem to find it in the `master` branch.

Thank you for such a smooth -rc phase. Maybe I'm mistaken, but I found it
very uneventful this time. Which is good ;-)

Ciao,
Dscho
