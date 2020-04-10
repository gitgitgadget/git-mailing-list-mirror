Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729BBC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3035A2082D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QV6T/1AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDJNjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 09:39:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:40073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDJNjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 09:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586525938;
        bh=6BdiT83NaRVibQuq5GoMz2x0Mc/ZgyCIYP8sOL7EJM4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QV6T/1AFcYZr72U8AlkwJqjCd2jtAxbvPs01ub6qvj7NsQwblHxiI5IipauphzhTs
         e9JcxPEU3F/IkOZveeIhUk4xFLO5w3dvxki+fIZSoSEYO84Vra0Bwb1z9GP6flT6gJ
         WirxKLzH7rEWj2kxdE0jjyZW0IO7kHj47Ngw+iao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M4axg-1jOXlU2BGA-001l2a; Fri, 10 Apr 2020 15:38:58 +0200
Date:   Fri, 10 Apr 2020 15:38:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] travis: build and test on Linux with musl libc
 and busybox
In-Reply-To: <xmqqh7xvrncc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004101538190.46@tvgsbejvaqbjf.bet>
References: <cover.1585203294.git.congdanhqx@gmail.com> <cover.1585474409.git.congdanhqx@gmail.com> <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com> <20200401221835.GH2224@szeder.dev> <nycvar.QRO.7.76.6.2004071651060.46@tvgsbejvaqbjf.bet>
 <xmqqh7xvrncc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DrRYp74F/rFxY4vdJp39RT+E3ZCVF75+nWBKFZaCpRZUQ2Cfq95
 UaJV8+c0j5+oRiGP14ytVlBHPev9WIusMHStOagGMGPDxmg8Pb5zQs4AcZ+UfDMpEihOpHh
 nl/dFA0X2sIY7/VbhsP0sf74F9ldJ4dx2gEFw074ujNvCyEv9vVIMjZ9Y2yCozGWP1Mdp2V
 v8M0STclCHbDnfjwuithQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GLjIC0ttMTI=:TFp8fRb7uQB+m2kHpqnPaT
 KZRLF0S65kYlSgVoeUG3nr2PgVdstKCaUfRToJWJepUmNLLZIzWvJQykrVQXZJMMkOhE//7xl
 mQunF+WQwcUw3rJlTOINzZ3o9bpa/6F0bkJl7dHds0nzgID39OthF+SzR8YgYGDZw3uNvq0Nl
 Ecvp/JIoSrtAuRcmGL6FfyXKKthgkcevIopKwnUR8vYe7pcWzhsUWUndtDLMvWDSbw2OSLBJW
 /TdBPJUpYf2HdFw47QF2t7KmcfcPH3NBy3B83iyUEZnt6N+iIya8R6/YJ83qYuxObxTEmy3Gp
 roiVj+LaoZvQb66SaNv8dW8mZlCOoGYb5JjVoqeQ8AcHZT9TMeTd1EPHkGiKQgwLRXUnHZH96
 pRfx/R5E5zUuBnmVmSLcPmqfSTZZEc74bMXTerrzaKQuVwk+iZviW7w1CQCDjeIKgYFgMCkql
 aG7JXBrM4L7lDWgrRtZf+D6hK6UGtG1i2ChFCbcYByftrRR9LIJDIjUN65m0Cp+7eDA3iod+t
 YN6Jt14WlYOS44pAxaMPMy+WWL+rwOUJCpDqMGwce93AtG4KIJwZLr+F9G9UMqmcwxG811EJc
 5qNlNSpnuOAaer+HptqU0S4fqyvFVKluNFwXgu4c6z96irFTqu3zlBqwCq12Z1ZLkmYc8Tahb
 AFRlr1877XQYsVyppRiU3te/IvyuwPGhkP+YIpbJBAgAFu07bkm6sdAUKJLjB+Oupek/LZ4DQ
 Lds+K+IOSVO4y7rLMK0VHFHuWVaulU0nF8sF8BIZXGA6AHqm6WW0KAdgrAr0Hg5PuRBiEU4+X
 mDiI8zgcCiG5wLF9hGK0AUMCa88nyMkwMWBhoyJgMp2GdiI0XGjhbYLHF4wVcuOiOfIjCyRaB
 EqdMvqq4jj/TbCWqNqIW/tOL0U27Ut251zykoVZFAy40yTMeLJ0FZoqmjLNaD4kCvRAuL0Jji
 tlS2i9WNHI+hRrAv9d0Hch+z4CE3+o1SNSS1NsX0YpNigk2+GpdAHlZREKLRnFrCCSIfX9aKP
 gBagLr8/uTShgrjhpegvAN3P8yL/fPqwqexMN33mrXSMvYELC4UxFzAbqAPHBBf244YWjp1hk
 zqfbmhMby4Mv26egMkjLIP52GFS265cV0AywPTKEkSZBSGGUF9Ubn+bDxJVznBMZGJHkHeGjw
 qxTRCqNS0ZJIUJZbTPoOHJqQ6we8bApCeBI+undsN8nm9XN8/uY2tnFv7pVrrq3sPSXfc+C0H
 /CySVRv0e+asmcbut
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Apr 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> The recommended way to build Git is without autoconf and configure.
> >
> > That is news to me.
> >
> > My understanding still is that `make` is the recommended way to build =
Git,
> > and `./configure` is only for those who want to use autoconf.
> >
> > It seems that the `INSTALL` file agrees with my understanding:
>
> Did you misread the sentence you quoted?  It says "without", not
> "with", so I think you two are on the same page.

Yes, I misread it. Thanks for pointing that out.

Ciao,
Dscho
