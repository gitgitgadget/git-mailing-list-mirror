Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE1C2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1480221E5
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fT622r0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgIPSRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:17:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:40409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgIPSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600280137;
        bh=CP1EenMKhmUvEUPVQqWdTRxkCZyF8JsOcxYTwZgyrFs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fT622r0zhrNAlFllUt5VPpDqGcZdb0FGmVlLlAiY0E89w/3eAEHtuUuRhgtLQW84b
         +cLCreSQd/kSfynZKCfwZ6vPXq34iT9ocZ18MaWI6EkRaDbVMgSv/pzm8yg7/1Vi6E
         d/ZfTpMOKJM5GVXBnT7MUGjwFsC8MyioWnwVpTCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kEinH1aNS-00EsB5; Wed, 16
 Sep 2020 14:36:41 +0200
Date:   Wed, 16 Sep 2020 14:36:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/7] builtin/push: add option
 "--[no-]force-if-includes"
In-Reply-To: <20200913145413.18351-6-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009161436120.56@tvgsbejvaqbjf.bet>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com> <20200913145413.18351-1-shrinidhi.kaushik@gmail.com> <20200913145413.18351-6-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FREMoWVawWkFhXGscnQhUPub4hudv1BpROqEJWAeuie1HW7QkZG
 tgqrmSoJBwCXbjOwXllgzxTwrqmDGkI+spa9MDWQ72aKImsamFRlShltdPiXtaFaRfRT2mA
 LzCI+GBfD6FoKk8T43gRnOUIY+/tQo+0U1P+ADeLoL+xjd1NUBV4Fkjbbt/+jF0W0IQWOLH
 b7Y5kdTVINmSuz6SAhVEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MFpYIJu8aks=:AtT7HzZzH7HOgXusmpgUTm
 xM9Hsr6SVBQgjzWka1zpZEtAsLUW9rBWEcHFdiAZ4XBmek+XAenmEjuHd88uaSx07h/uyotOs
 gxRJ7YOQyzSr3typmKtI8zP2alhTOe4AUtC0x9NqRTyvjCMXv3ioURhjOqMxmSZvpT25hExPO
 7aS6TOGYdsbVW4Si55+YKdmaf8YWJCIVBAEvCpWzUodKflg1cj2xkB7bvhf+aow0o/FK0khYV
 NdYJBhngIjkKXY/nO9fI1qwopOraUcFoPsR3Ng4xEG7Jd5VPZICqlYfwfJNWwUw/if23Obz9y
 OUWsCCMgF6mMO72D9JiWN6D/b7Y/Ira61Xlp2vD5vBUo1/9vC6Zg8U1OZEMk6JXML3pUNWAkl
 nGGzidEKrceMjsovoG54INHBTeMYP9+C9scJA4e57SyhB6YvlmknCHJDB940V1dYut1VZUPBL
 iMT3ABrhi/CfocQ4IPnqyzgMN42mdpmAldku8i7B9ZgAVoH0JgODAy7g5mv3GWo0tZT6jl+jd
 I6Qxv6WvxrD70a1A0NqZdOdSxBYn03hSEu1aBStSku7/GO+UowGyfvVzYrnj9+NzHIzB5hrCj
 gDHOtA1Zq9/a+A65ip09Y2acACF3vhmz2Lyih/ex6PgbLPGPVnIyjS23lGRLXCFmatJS5os2p
 AqkSn4GuUJK0r4ZMcp2z5PoHjyswJtv0+ypBpDLE6BqInsZyS2brY4V3gadzCa+BS46kFLCma
 wjzw2VFn2SwqXPK/QzfBkP79VpDTIqIFbFnXA9yqHahcVGxk8G3F1yAIkElkv4CKg2MkkAldw
 YtIwP6GHXXgHCNWN1+6HVX8q+BZCfz2yxP6PPQq8BtLzyMV7WCg/R1E6bX50663SLEBr3RIKA
 3Kj+Nuzjq/PQcvlT+UaidB0ARDniWgu8qVirVb/iF6uh97BpoBvYmN3iFLEunB/Vu7KLZoqIK
 jVXJ2YG9voFQFfSaDdx9+8OSTjGARpw0n/53dVMtA2mP2JIPzKXn+kGBv2Bvcpg/zCGcUxCCV
 9oegJ3Fc+ObpBRyVBCUplNScQSc4qipaYoGMSZTpeIa/tc2m/u4qM0ksteu2FKl9g3QrMXtjU
 agJzNu2NfW5aqljkRrS1j9abtOiR77KKcN9kdhExeyLNKo4haJNo5671uFtwOO/lb4+NV7el5
 XlNrY0/PnBny6HPnt0z4UtIqZIVRUbSgRrzQE6nJPvEBIIDKYxqm0T/oH4SSzAGLZ6Fg86HtY
 rwT/Nhn3arwU6Ec+IjB41JVu117mcwEsAZygAJA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Sun, 13 Sep 2020, Srinidhi Kaushik wrote:

> diff --git a/builtin/push.c b/builtin/push.c
> index bc94078e72..d23b4678b4 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -300,6 +300,12 @@ static const char message_advice_ref_needs_force[] =
=3D
>  	   "or update a remote ref to make it point at a non-commit object,\n"
>  	   "without using the '--force' option.\n");
>
> +static const char message_advice_ref_needs_update[] =3D
> +	N_("Updates were rejected because the tip of the remote-tracking\n"
> +	   "branch has been updated since the last checkout. You may want\n"
> +	   "to integrate those changes locally (e.g., 'git rebase ...')\n"

Shouldn't this talk about `git pull` instead of `git rebase`?

Ciao,
Dscho

