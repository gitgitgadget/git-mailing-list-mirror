Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422B520899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbdHNU0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:26:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:57333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdHNU0w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:26:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M82zV-1dLqr940zh-00vcDa; Mon, 14
 Aug 2017 22:26:47 +0200
Date:   Mon, 14 Aug 2017 22:26:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] win32: plug memory leak on realloc() failure in
 syslog()
In-Reply-To: <245410ce-1f4c-f2a9-fd8d-98ff2d2c0335@web.de>
Message-ID: <alpine.DEB.2.21.1.1708142225330.19382@virtualbox>
References: <245410ce-1f4c-f2a9-fd8d-98ff2d2c0335@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-682565032-1502742406=:19382"
X-Provags-ID: V03:K0:dfRJWhUOU7cIPmqfA9m44UScW5TVXdmBz6eQaSovNrwUXsibJlQ
 OhhKNr0e+zJdjlPcFdmGFJ5YIFfzK7dF3J2N93CdVhL3buGSrpcC/D6n9LIftAgKFDshHzI
 rUoIeNO2sH05OqBxq+0QLKtoYOpy74nEnKLkhYmsBSstCls3p/FjvY2RkgQorKDt6+isqwK
 xdcorWUHRhh7cuLXp8VAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lb1I362fgvc=:N3bGFOM4aMepixCaiSV04Z
 HcTyZSH+YIpd0BM1WSlZ3l6l3rbm7iTm3HQTcWTt9Sk2JPz5LCWilf0hjz3Vhd/e2EV2kanjX
 TTINfXjiIhgLcEtVqCKnYxmmKVLoYjmddq6+X0w4skmxAfWxb+4MuWXZhuZXfPDc3M5hLgu5s
 6AfufPN1K270Mfa4enyAL2oJb7N1JNiC6yG9UWOqFO2GU6eR4KQO38a4OmJ2WkNbTW0m8Jk2X
 ++HZt6UwHNitkxXo7azTlTJ1y78MTwD8oAbPGBRcuvP7jXsBbI5m8TiSwl5MZv5nVbGz1xPoc
 hxn2LLycDWsyCZARgTFv3lYPwk+KgJKces+erAyJsfjDvWD2FWAW6K2LwnWLsIpFwEJihMalx
 v45H/JNITyPlc7ndEgKliW0gqBdKCcb6S/HmBJRel8davezbgAc4nTd99Fg8q0a5bNbMD78tH
 LEtDpNzJKZDfSxQJ8c4MdVcfAoG6pshmQis5UO0IdpS0GLhKOYW/KNhoLdPdYi4/P1IwBIHsC
 RJQg3grOYBotRdQW/vaJ4fbAQDqV/OjRh35mD9eJ0cjZcK092Kl8D2vT3RS4Ts/yNIEbWHrBb
 QL4jK4tswFc40AuodxANqf1BXUyb1HfhEQPzT4X592NNgaYrQhON15yEVkHFEe6NPYm5e7+oQ
 F8er8VROMt2g8aBhBHNanzDYlj0VO2g1UNtnWEx72D7nbEGUfTxAoMpLPuM0MLKmflLlo/hcQ
 sRShydMQcJK1p/OVF7NJuy4izAAqbLUNJ1dhxe3LoC/9O9edhnx424/2Xexi8t5Rxzp/cizav
 tI0KPf0+umNNgGnu+EPYXHyP6hQtWQeZ8VXsyrnaivljcp3Ti4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-682565032-1502742406=:19382
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Thu, 10 Aug 2017, Ren=C3=A9 Scharfe wrote:

> If realloc() fails then the original buffer is still valid.  Free it
> before exiting the function.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

The subject had me worried for a second... The realloc() fails so rarely
that I, for one, have never encountered that problem.

Still, it is a correct fix for a real bug.

Thanks,
Dscho
--8323329-682565032-1502742406=:19382--
