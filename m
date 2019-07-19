Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4851F461
	for <e@80x24.org>; Fri, 19 Jul 2019 12:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGSMx6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 08:53:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:34423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfGSMx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 08:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563540829;
        bh=P+Fnc1wLk1bTXm+JwoboyQweLjBWvOo0xLED3umREuE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XRtxpLsW1tyssRCcS7wpY/z8bsz8C/Pnlevsz9eMSohvkvRFqmsScZNAy1nAI96Jw
         Wj4LS5MFshfrtn3sJm3HElwuUVE8J8c23z8Eiy4CKFbf/7zrK5BwW+wGO1r+0nCdlC
         YRh11qXut/ccNyhyfiZI+b3+SAnEamGZRZxqDG5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRGPP-1i0qyw1Trj-00UYXz; Fri, 19
 Jul 2019 14:53:49 +0200
Date:   Fri, 19 Jul 2019 14:53:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "=?UTF-8?Q?Ren=C3=A9_Scharfe_=3Cl=2Es=2Er=40web=2Ede=3E=2C_SZEDER_?=
        =?UTF-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] clean: show an error message when the path is
 too long
In-Reply-To: <xmqqef2nz5xe.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907191452270.47@tvgsbejvaqbjf.bet>
References: <pull.219.git.gitgitgadget@gmail.com> <pull.219.v2.git.gitgitgadget@gmail.com> <c7b11fe410196c14e142756a036e2bdae5d4bcab.1563442231.git.gitgitgadget@gmail.com> <xmqqef2nz5xe.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gc8ebksbz6N7EBe3pDk4O7gFIa4NV08R6aQsviirFw7UOqd11Td
 Av1coM86UlSm4tFRU+asQ3NjRg54VHXvaVqQD1Yg3M6FxVDm8Wnw7nrSbn/UfOAPR30ZPDN
 sh8Se4su4DFfFerD15W/yYCK+nlhRGxEDSlFL4COEdqk36OEo5izOQdqvVLK4kqtxJi757Q
 oZ9rgbfiA9H92FKbGAVAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MIbaiU3t+Es=:bo3F78nAhg+d6WwldVL3kO
 NZsYrpJwoGtwlrvias8EgOmTQDMAnc0iHsD+1ZnwG9XKKrWVMZC1YeuBdOf1yqeTKw2sUqKEL
 nGzZs6z9nxAData/zgUKtkF9ydNNP7TwwJBT1AOZs3hQmLESBIPykKytB0mJFztcpYhNyIj6Y
 SH5idAmS9zyTIT9i8LsqrKF4s/tFxiQIEJsvw3IO9LpZm5uXI6JkV3f9Oej6aDU6D3SiqI7gF
 yYLAObpZtwRmXiC5WofL1fRAxrKQf3Y9Z4PSGn/8ZkhVcdA/DezZSw4sWOHDJwttpWnnVSaZu
 6M2T4UZ8bb8Jf7be2cay2AWCYfkz6Gfxica1REECgFHFJ7uoWlxu9ZkmBc8FI5RQFQhX3bbSH
 cgxD1NF6ptCk571N2P+0mPhJB54YPy2qNzpE8wH3fULU/bwPFzPxRfW06OWyfkl8ms78sdeFb
 OsZnqxR5OsZcIpfhO6cd5bv5TbSnQEHcQFfW5EcTTHBcIR09qmikvxRNiIoMFpeMJyQ/5Omx8
 m62c56GhJ7DrxrVyWC0Lk/qCK9ojz85cBOTMiSghZIUoPsAnIZm8L8il2+rYZBdCGezRGmBDU
 UIWp30fKIpeRWIWjDebuH7T5YRusF3izMbFLU6lazk4SoaPuv+sDLd+uf64t4gkjUeH53/ELG
 DZoq/LpUypL8WuyYFXTvCZ8bn04b/jNjO7RsL6wjUTa39cV4oJTtPxqnkcSkRpNKWMafbXat8
 Rn4HXsMAEdw+7LhEGaS/294KPnaO/Jlm1CnzBwKQ/v/y5Hz6Nu6qmatQYOZRbxD71whhmAe9F
 1IaP4+GUfQ//MTkV88lzaQvzCRKIXLgQMy7vccXnrYcodiTLijs8vntJEG1922T91fTNYLKNG
 CPXqoUXW0RCx/fqXlPnLM4Fgmq8Ye6Fpuwss9P/Ji3RgdQOnCO+T4ZFD2LVLpHhxQwSadfVPv
 FxLxuscbqjgrcU8it/ACazJV+Hg/V5kcUfMxnRHOXxjN1kfdj4Hsl7BfRuPfOq6i7dBftBdGd
 D8MsPlmSPQfcU4kF2AmL+hG3tZ93b3ioSfszefRPvk5IeylnnzIwPR80f+puZ/cD8Rc8YUXrc
 MG9rWD1YQvX6ZyjS/dxtAuQTtOMQXxoHXc7
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Without an error message when `lstat()` failed, `git clean` would
> > abort without an error message, leaving the user quite puzzled.
>
> Let's drop the first three words ;-)  Sorry for not catching it
> earlier and parrotting the same mistake in my variant yesterday.

You mean the first four words.

> > In particular on Windows, where the default maximum path length is qui=
te
> > small (yet there are ways to circumvent that limit in many cases), it =
is
> > very important that users be given an indication why their command
> > failed because of too long paths when it did.
>
> s/it is very important that users be given/it helps to give users/

If you really feel it important to invalidate my personal style of
expression, sure.

Ciao,
Dscho
