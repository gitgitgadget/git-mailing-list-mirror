Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E358C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 06:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD360F9D
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 06:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1G6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 02:58:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:45911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1G6r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 02:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635404163;
        bh=5sUODwoBPDN7ThmFM+RkroGQPOIF/3x3/Z2AQMJwLnk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DGCg02cNDz3/0KOfKjtaa9REo8GkMAmj5iR2sw4BvRGdAow0enVzXzZkpp46acHMU
         Z1fh24dV0MAzAdHpDBTn0ZDVZhXOcJPhu+t2qz7cGgOUuNCmSA2n7IsT36iX/XI+bM
         7d+WwMZsAPS842oRCoIkMw7ssWhYkhcmq8B9FyJM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.185]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1n90Qc0nv7-00gHHT; Thu, 28
 Oct 2021 08:56:03 +0200
Date:   Thu, 28 Oct 2021 08:56:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Discussion] The architecture of Scalar (and others) within
 Git
In-Reply-To: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110280852200.56@tvgsbejvaqbjf.bet>
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:et4rlMWsH1YOAfIWrXpWIFtUk9/GGsBp/nj814nXeCKQvA0zEhB
 We8UV6j/PNgT6AJkk8HK5uspSu6DmMGb2Fip0HpFULPToWYPfGDIuz+fACgIndnKrFzXB+c
 R1vLaHhotiN/fP0JCLj5jMMhrT8ItC/RsGHZUhFwmmNjA+JoMpm6FeXoEegU+ffULgyXO1J
 ciI4GFm2qMKE2IM4+Kq5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:azWvQtQNGLU=:zTr8vyJlQc2320iaOs4McB
 N6Zr2Nnc8FSxrnVsYh+O2zo/OfswgXtqy+5y2DUDq5cH8d/HySb62/g1784itnch6O3bCAGpA
 0X/KX3Pi2Rk9URdSVtPk0jcp4Pqs25Un13GnbpwNaPmZFqEGM7IXtnOlGj3xfLROdDFTZ3Csj
 IVlm7A73fA5km6qcyQRclcSK8kxAoE95cGqFO1NtCj99k/3aGrR5rh/fYsgKUqB07BxpuYowO
 GRQ27XwC3zeEQfHW7jo/BgDGRVdRrQmqij+7t/DjlTYTlL2spbqo1usOt2SH1dReNEpIW8Vfx
 FLv8MHg6nFeyRVTe/f5+e8ppRK9T/ItEUnI/P39p59RFX0nu89PPii0q3qGLDCvdbglQwa54z
 V48qFzZR7HZu0aRFEJK0fQgK+9eth13GcXTDiG+B86zvL5B7q20f3lrOSdYgFuMsnv5PyukWD
 g/hwGSoJDxtucvPqFON94XLOOY1TJG0WpQpY/IdwnzuKD3Y80aRNUk9SXoL5th57QnEzAN80/
 MIOLiBagTpwnPlBWa7mjl1DFwGSoaSkazCdjgFLn2wh+5b/P3QD6OvwuFK50ACZg6430Dec1z
 X4pOLMdTe68gUtkvkHZqiphcLuyTDUmqLeUK9eevnvtQgcKQfa86qGSm0PJaJtn6Zx2uKx/7J
 HqDFqgkPZtGbls90WxDIsKBIDpY/3HycX/N7YljkEi05gXxKI4c+bGJPqs6Fv77ty552mvC5F
 gXaR8HXQ7jigKeEIn1sXLKAxbXhuGnTZQyqqExqc/DY4pO2qY3z36NLIFqHdFa2YWRwcmK3e8
 xys9zrBkH5wpqK2srkP3TIJaxz7tF3Tdb31wr7ssNhF9JdPcB8gTeDfgDve/o2v/U+wFC8TgC
 N33k3Qt9iSR0AQbBF4QhMlMAOKkG0CVT4hvO3ivsXfBju3+uo1SKk8W/jp63o4rJl8mh75P5d
 W0x4cLeizOjNtugkYVU+CZiUk78lCgId8SuDY/Gxjk7AdeW98aWVcRsfpjkQ1E5ctH/WAaKx3
 tUufMuU2z46Sf7+NS2PKiJCO6+uMG8+rG8NQPx1+9hWM+jN8ZR4VzR+rkaVP736Vco5D2I0qY
 mzP4rzIEtReTzY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 27 Oct 2021, Derrick Stolee wrote:

> [...]
> Options for preferred end state
> -------------------------------
>
> Let's get into some concrete proposals for the location of the Scalar CL=
I
> within the Git codebase. These are ordered based on increasing
> responsibility on the Git community: the first option should minimize
> community responsibility and maximize responsibility on the Scalar
> maintainers. We will discuss the pros and cons of each option after full=
y
> describing each of them.
>
> [...]

Thank you so much for summarizing all of that!

I have voiced my opinion before, so I won't bore you with a rerun of that
show. Now, I am eager to sit back and listen to other informed opinions,
opinions I have not heard yet. In particular Junio's... :-)

Ciao,
Dscho
