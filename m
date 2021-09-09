Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954326103E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbhIIVpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:45:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:34685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345868AbhIIVpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631223835;
        bh=F3aEW5rEyes9EZfwvi9YGdqGNGt2DRctLkAjAMRW+bQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GY0DWuwlwAW4DMm+a1a9xTtv55OBPwa42cAwpcXL7lI0z/ysFzvvjs1XOuRWzoAV1
         Eg3sAEBdnj8ZW4GdLEHRrnStdRwe/Vs7A7L3oFKR4TWNPabRtrjbZXlVo2G+RkOLKh
         j92uyPbhZ7Xeok34ZPPXmroGvJE9X1ELaLfmMtdY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1mvarK2Bcv-00btb1; Thu, 09
 Sep 2021 23:43:55 +0200
Date:   Thu, 9 Sep 2021 23:43:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
In-Reply-To: <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109092342110.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com> <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com> <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
 <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-327559348-1631223835=:59"
X-Provags-ID: V03:K1:iwCLg2h9/rlMMzhRF9juaa9UafTcxOUyc3CpmNd7YO3gWdcdPv9
 Sn9AyfCRjuxqUffPYWcf3e7s0VMGADcey3UchzLNtTqJKhj6rP3rZ5qfcxdSIAtEvfiLwzP
 VVDXe8jX9cB7ZIar63WZOlPHadwSYhHZ5QwmngFWumjKSvtWo8L8wkd0qoV8PAQAFy+FRDc
 DxfnTXJRcEZgp9xGBbCJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PwrKUyGtvmo=:9eqEizU0/2XJQqukn6nNiP
 qUAcx6OYwg58Cbrazxm8p/OanepUyf1SceQ687+WLiXtOZKS+OTFV8SLAjM/HkcX86Dt0+iLf
 MLgbKk7wvlr0JGagrxU0lGeKjeFV0MAFXR7yqWNdsSP+ONdcPcDTh2xoPYo2QxRl6psKfgD9M
 V52JCaMcjJ0W4RCT23utgmYlIrlMaYfX6aK/jyxXhxae8G9/csmORTgYPG7EctQXWLpuqEC+G
 9iEwKDQWrwGdu8UU2Qs3pLfm9VGcrBK58Ud/47hj+nCKTG/9Tcedgeg8a26bTTAHBFrk6z4hN
 7KLYg/MOyoSUsHOIwIIgledg+oAbI2AIdqi3bKEe3qgjF2Nl98+c4Ldx16Uw6f8fDkaiVU4v3
 M0uMLhEeFkRUIwYsswXi4sNGWJQ+ms58pebu4keT/0pIm7wYJyH9QnnKa/zALV9fGxss0R6Xw
 FFg62HofdU8sUc/gAX7kZP1dBKbkkAWOfcuQP5fwFy4+B+75/uVBi7hRLHxNZIG8uhfgaZMI8
 GISETiPVG2x9Mjw8n8D2D6NN9TMwl3RvdANUesMoHyB7pWlIzRH/qlXuwL8A66dXD0PdoAbt5
 nx6sb9fvytBzhaG/tyMNlOf6YL7yC1q5pKlOgUmMX/uimsRcQQzNBtuFCEBh5pHmwHGTAVSAg
 i5UK6/E2GgGSixIp+7n+F+I2WpQFQZXn6BP6Bqk2p4PMDmtHf/vpp4U/oU6dCxwbwombzZUNk
 36xjIAAMX+tv+uHvT3DoYp6qvsRDhyELNxmy4XT7g6IlzTuvf+pvhn88vSg+4HvxLqc3GLphk
 9cj21l+cXvs4kTtQjJNcWZBS7F9dKog+W7zydBRWBbSvxorBiG9UnPxEpltXVx/5gTr9NiKk8
 lARj5PJ7gmJMAGYJ7BWp3pCADrflTVQWFXp3nsD2d5oANsdL6cyumk9hJXZoJssEBkkLMCpzF
 qcXdPnN/gx3vLrsUlDMeRzhF0sIn478xfXFzD6r1b/CU/G96jBlI/NK3SgSa2CYC1AmNfYMGK
 3wUvFdr4HWWFuQLfVSipwYwnjVDixQEDUYaEvzi9vy4yKNMjjynpps1hGIhTHRAHZteIxrpW9
 HF1HO/y3tBW0/U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-327559348-1631223835=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, 9 Sep 2021, Philippe Blain wrote:

> Le 2021-09-09 =C3=A0 06:53, Johannes Schindelin a =C3=A9crit=C2=A0:
> >
> > On Wed, 8 Sep 2021, Philippe Blain wrote:
> >
> > > Anyway, I'm not saying that we should not do what this patch is
> > > proposing, but I think caveats such as that should be documented in =
the
> > > commit message, and maybe an audit of other configs that might resul=
ts
> > > in behavioural differences should be done.
> >
> > Since this is already a bug in the `apply` backend, it would be even
> > better to follow-up with a fix, hint, hint, nudge, nudge ;-)
>
> I'm not sure I understand what you are saying.

I am saying that indeed, you found what I consider a bug, but it is
already present in the `apply` backend. And then I am hoping that you
could find the time to fix it ;-)

> The fact that 'rebase' does not pay attention to 'submodule.recurse' is
> not a bug in my opinion, it's just a limitation of the current code...

But the code that spawned `git checkout` _did_ pay attention to the
`submodule.*` settings, no?

Ciao,
Dscho

> Or do you mean something else?
>
> Thanks,
> Philippe.
>
>

--8323328-327559348-1631223835=:59--
