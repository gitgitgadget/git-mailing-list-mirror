Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58499C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22361212CC
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbhAEPnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:43:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:48599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbhAEPnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 10:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609861300;
        bh=Pz+h8Vp5GJBmjFLlW4DxxcNxrbv+iUDieT2uzwGAc2g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eiEoUu9JiA4vyATysBg9/6g2QdCKunKeAaC1pm5ZjqUiMXGTlxegeGtGMPiAjajTZ
         IfiyoAMwLG3j7wiw6sdQC4s/GdNhU5c/c7vwz9UL+FsEOawW6elfZC9fdZbPi96Ocg
         8TCYhGPwoamPM/caGctBvXDuJcUNawJp+N/WiMvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1koK8b1epl-009713; Tue, 05
 Jan 2021 16:41:40 +0100
Date:   Tue, 5 Jan 2021 16:41:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ss/submodule-add-in-c, was Re: What's cooking in git.git (Dec 2020,
 #05; Mon, 28)
In-Reply-To: <xmqqeej9g325.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101051640150.2213@tvgsbejvaqbjf.bet>
References: <xmqqeej9g325.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pc9JomLCqeYywZe0489mIq62xS9tIp9uciZyGQiA/bcTcnB//Ef
 hzxXwttHZZuouKdlcezwmP/gM9kVJY7oxnDBON7+qa5JVNxWx+8Iig2M4pmAgUis7FcrJzW
 dDzmqX7LEVkZnjQSZXQ/TPsZDTeCiRvW14Px7FdcbWaRf7s4vMOKH8epQJWgmFtq1v1n2pL
 91zraguHrf43ocEkfu2zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G8WTJGNdQRE=:oNWBJbQMMQ+PpsafcVCqEe
 taZrCXLp/Q1ncHlTypPU5dUwjvTmqO3B2kbLLtcLB2cmj7WFCtL0qbcjkJb4DrkJM/7wLfy1w
 66shijVXSdLRUPWT21fVsgJdZUye0H8xM8P/yfuipqY0yiM5MAjQ1E7zYb8JC95wcVw+8AEWC
 uixmpU/NPRd9LbFidhZdf7FqRLhZldkmsm2c80i5j4WXsL20y2KfaDKRxCwnPoe4Wx+WmoX6P
 AJIg2cp+GQZwxlbqL36yZ1sqBS52k/RxwgUuPZquyKxyCg0MK/n/eJX9m7+UsMZWdwVW269Vg
 RZjlsI17393iGGC1UWg/fubq5OxCg4dIqMmu18Uaxibn7JWrqYKZ4j2ptUsIV45zp5GICb2ZB
 JARGj6B+0+LxB+olbw5PFKvwLBYtxc+n2QCwIcO/xHZQpTIbMzG3jaZOalTGWSLWXB7jNrdzv
 cI5so+YbQX94bSX0kieu71FmZHhIyy3lqtLbVtG3di1XrYQY6nMvLEOgTwXLm3uS4cuncNPDd
 5OSczi4a7M9m1j6C07PjmIQzae48lojLsuuZiHSOAAEOn+wIguWDqUp2sYvvfJPeBDW87NMia
 PhaLUB/5VGl5DQ6yM/Q3e/DSd/ZFzlHCp4w8bh8Awg/UjXQR2M/Kv9HfHpCsxIHitta9Vp6wh
 Bhdav2ewIRhsgXntt9K5zg6isoB3dM6SAI8pHOKOrNN9O4nqA3evf17lQQOZf08v/6AeDD8xu
 8LaMXL2KsP4KH/REG1atAmZv0slrS5ATIS63TTqQa6Dpcn0WvTXvkhq3FRN5+GY9FFTmMj7et
 83Uj1xJmx0eniE+M2AAVpcT+7YfomnlXT//1sjpt4a97Ht7gvy8p4mdFQ/RJznUxtV6LPMKHZ
 cd0kPY1jVzH3YdxNVrljYUoh3Br6XgYVEr/AktBlM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Dec 2020, Junio C Hamano wrote:

> * ss/submodule-add-in-c (2020-12-15) 3 commits
>  . t7400: add test to check 'submodule add' for tracked paths
>  . submodule: port submodule subcommand 'add' from shell to C
>  . dir: change the scope of function 'directory_exists_in_index()'
>
>  "git submodule add" being rewritten in C.
>
>  Expecting a reroll.
>  The patches are split incorrectly; part of 1/3 belongs to 2/3
>  cf. <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
>  It seems to introduce a segfault on 'seen'.
>  cf. <xmqqft3xflw7.fsf@gitster.c.googlers.com>

Maybe nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet would be a
better reference, as I diagnosed this issue and provided a patch that
papers over the issue (hoping that the original contributor would not take
it as-is).

Ciao,
Dscho
