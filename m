Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03208C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08C32073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 11:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dMnR8ndC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLL5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:57:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:57757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBLL5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 06:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581508621;
        bh=qEhdbs0WvhoG7gD56/MtxGd1yO8dP6AmXdZvMmHrJRE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dMnR8ndC8tFpCvrAUCt6asczI8GR4QLSTQV9dq/sWOMPtWzqhZVbajlC9eAPWKsha
         +2pAD4WBKPuPHAUcDWX2JN2KgHyCHpsewfB+4uTu+fcFg34ukjnN6/vEGnpBzcKf21
         AiAiJOFqWy/9NFHW7bloKkGd1LrFIF1oyiT3t5YQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1jcYIZ0NTe-00cCPn; Wed, 12
 Feb 2020 12:57:01 +0100
Date:   Wed, 12 Feb 2020 12:56:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Glenn Strauss via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Glenn Strauss <gstrauss@gluelogic.com>,
        Glenn Strauss <gstrauss@gluelogic.com>
Subject: Re: [PATCH] update git-http-backend doc for lighttpd
In-Reply-To: <pull.546.git.git.1581479550353.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002121255030.3718@tvgsbejvaqbjf.bet>
References: <pull.546.git.git.1581479550353.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k+98AThHRJNjt1kcrpv8rWHzpg+MOL+8xjiMEQCeQWLOpwtJo6Y
 c+vLW8luaK6Y4mtHVB4LTF/8VsRdi7UkDoG6gY3g9Kzxi4PfhgKqxRVtC0HcvzaYY2xzk4F
 mutbDMXn3YB42Y+Vh1y8bWNJWJ9lP4Sl0+iLDWyrZzBM4x3zDE31j+R1GxNu1qg/NxVf29f
 Q+Re36RGKaqzHUCh/esCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ONYCW/Mrlf4=:uS9dFHz3wqOCXRQ3Y+F+ad
 PwR9zR1FCLeOVelwKMlDAVbeYVmQK4dOKpuojJwg5GWr36jAAc1nKgMJA3CIu7A0ebHOqXYoP
 GpGY+Cz9UFd4p925WbniAOd+cg4ka7pWkyla9cnAhZVdFjYa92CoUl+wA4CJkfIP9kffloMtI
 PTuSMEzNzOuMmUgMmhGIbXZbemx287wH4sOMgzeigAIAu4T7QTxA0+fiwIIbc/F9ckAnuuEjU
 D0+AJx6z5+fwcU+4TaRdMSzIrGj0aFD/AAYYPHE3KTH8WPo+d31pW2uasCSqewSzyBb3/W9yX
 xmUA9wQRk7YeqY+3LYSQIh4S3C0EnJOwWGtEbnJA7uT16DKztcrq5vt4YVyKiTi91JfyhWFik
 Jh2NY81IcnR+2bYV6yHk+NxcqGzH0qsUrY62gjVuz2ZInghNNw+5TQwqDrkN/0iYNbLJMom9G
 fQdef8xvd/HD/2F06MJDw4m/tQencZamB45KEYXKSoC9T5YJm8zhGevh0P8k6junA9NospapS
 NldtMqPnqeFoiHnKMjCAGDzIWcv/WSWyh1bjhtx4y1RDOPByycDOyPsbHkKDPRCssBvO6Hnaq
 wALXmi8MvxBKJ+RjFuhzCR0hCe5fumTelaKUvQCDHnAmIZ5A660ns7MbQVbD/OK4fGLHT5Icx
 SSATM8y7PPoefxrjSFspTT7+Ttd5ZwzMc2ipfJfRflCpY4++AyI1lvT3M6C0r7okf/YYGc5ax
 HCHzdPz1TDsxq195qcUeUcQAYkDEKhc+STb8WziIeVE7G1Z9ExaPK58fxe1RNWxxEwb59x6RQ
 ghOAOaeH71umWDA++u5m5Pc88rf51iu7Zbmw2FvQzep/7bH11nsfr1YJa+1ENiRw06+Y9gUbT
 5k+ZQx/KcsFMneYJpMcN09KMUTf/9o48sd1ZVMzNfX5NfTpZPOncJ5xmbay7eRBwj2J+KoF+H
 zrSl/XzDURFuX1t3opc0hANsO5PLDSWiBw736/d9hqQB6B5zb47hUPV7xGcnuO/KoOu+Xs9H/
 gdrCeJff1v++aBU2jR5Dazg+tAiKiZwTPt32fzsQlAp+FS9FTTi2W9eocrYEjgDMvQ7yMAm2n
 rdkHVzJKhvZrQQs+cm6D0RGcM/uFLJwA0wUes0bXy96x3VTb4raatKNslVTEfOGeE1irdSvHt
 3QslsuXdJhxHhCtplgzmPWicFUCEh4gxBqYxpzhu7Nj90DiD5EuGXCAidIJg/CidCq19LXI+L
 8qyvbIfnLMNOHjDqz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 12 Feb 2020, Glenn Strauss via GitGitGadget wrote:

>     [Edited to reflect refined commit. v1 and v2 were originally submitted
>     via submitGit]

For the record: I think only v1 was submitted via submitGit so far:
https://public-inbox.org/git/01020166b80743cd-0b220d55-a283-456b-a3c3-bdea8aafed8a-000000@eu-west-1.amazonses.com/

Ciao,
Johannes
