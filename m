Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2978C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FDB613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFBMBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:01:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:39927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhFBMBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 08:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622635188;
        bh=y8ZCvpR0nAxWoX2K9TvROiPIoNtqJdTnH4gEMA4a7Xg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q6ZJXbsp2WwMFobvo+UUMDoqeTtmKuUp0gbsj5ycVbMdOja9VYkwrmGjxXtgq/Mm9
         1tWslAhivZ080cnSQT78LRv4BxkmWaXOENvWzeb5uL3jDnymufXMPSGHVVYYRmdAIW
         edtnsaE2XJOtdPVtp0xqj6wernr00yx/QCd5udd8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1lDhbe2JcM-00b3zs; Wed, 02
 Jun 2021 13:59:48 +0200
Date:   Wed, 2 Jun 2021 13:59:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?Avar_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
In-Reply-To: <xmqqzgwiawm4.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106021358410.55@tvgsbejvaqbjf.bet>
References: <xmqqcztecuy7.fsf@gitster.g> <xmqqzgwiawm4.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ozjM8PEGu0Fioo+yv+ar5l0n+LI+CRh0+TRjjnf2nq8Z7lLoXbG
 kRBgjTQNPBYxSfA0ctNMhiO9SBaGAIWDGyE0tjzwE4aS4Arwm7EzpOluspDrVz5d1vfth1n
 Bs9MBOOXMmJJE3cBGEkovFaG9jymk/bJoQ1xXn3cN1As0Lov7gDkp2grsv/+KXbTAudHKAl
 Y/PqSgrxm9PLreOh/n36Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJ5jGMlAsFs=:xefYODUguToelu9IivTS65
 i0hnZzI/fWMVDxBPJY2mkKJcGzJ2wFJI244/wP+6WgpgK7Qn9P9ouKoaywy5OE13RjqrvS5bX
 WHR+fC1GB6ArgTPSLiYJ/wNueNO/oiv1RB2uSNxx1Ah05AD1MhBuzOlCW4X7CLYvlOTcBzNgz
 rTOhXFQaDl1/7fHTs44PMCXWAI46kHbiKR9bgSf5QO3XoHfMmiZ6tx30C8BG7S1qr+ZdF+NyQ
 4Z3ukZCD8CIB91s8sTJzBtsuMwJSVWKit9x4WZX6XLmf1mnm/jvFLp6Dv7GyXUWILpP3QAeg7
 rExo/s3L21dEGC+MYU457ut1Hk4DQQUi81IUMLmZ3JqHnKTiNYBjXRaLyJgfc1JyXBSW+6Gh/
 8oX542DcYKefTVoQ/RC+Kul72tDNHvcmygen1is/fjdOyGfdC1VvezcFzcZ8TV9z0r2DGAt8N
 fyjvDFPflxbUPPUGDTmzdjxFw7IjKljk0FMFVhgGM0qvkgvGFbWjGVPjQR42JQwu7E8ZtV7hh
 sxlXffrLsPFnD7Iekm3FvarlHokeEJSfKCN46ZHho/sKG0njwJgnr7chm6zxaeoJ1li8sev/E
 f1WlxH3aGEmJisetIObwcbWZW0Whu4CUkT0mBQG13nioQhJAzK4nbLf0JzcLodRndcSrD6+cF
 mTCBR6WBc9M2LCXbyLb4lonxMhIjqRdL7MCjWScBOYofFe0XE6opZE2+pQubm/YmhD2CiwfSd
 dHB1/IJgT5lU5BN+YKDM5YAwHWNodnGyGMEaTj7k6IRv7+2O5UL2b60+AO8DTPY1HA3Twyrbx
 EHTvsybLA7xbU7USdRWSmZ1etzgXvzQjsDS6Js8rSU28DoRoW973I4uHKz+EFeJ6I1Us/Ynft
 mA2Kw/15LxgawvkN8ZZYXij4U5wIKnBchmkbjRTojWruoKYo9g8lq9HaTM1qy/Pj71c3XpKsQ
 DZ5hfrFVmtua8MCbeKKGJPZwXJ7K6emUpFL71luoDFBmRa/S23+e3aezlWL1/mfFLYrDy6s8d
 IjoHRPNEG++TYY2umeY5BqBzsY5BLDGZ8HoGR4h+TgaVfK0Ry8ZgdCHSnXS66moFtV2ouN7qi
 fz/kvKvs13w84L4jwa6n6Er/fgI1ucnr/GX4cEoJiuiLbJMqeEBvf52Cw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 May 2021, Junio C Hamano wrote:

> [CI failed, and was fixed...]
>
> Except that vs-build sometimes fails to download the sdk, that is.

I have a patch series to help with that (at least a little bit), but I am
holding it until after v2.32.0.

Ciao,
Dscho
