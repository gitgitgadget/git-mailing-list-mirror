Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807F81F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfD3Wd7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:33:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:40041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfD3Wd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556663630;
        bh=aalvSwoxNze4mUUy1bAcIaRZN+Dt/wskGG9uO+pVRL0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=al5m4cQrzB7NXnclovDmxfAK5jUjivaz61QqZb5RwqaKVErhWgC1xTlWemD6GGvix
         gOT0GWn3KBJpHR2bwqpnAbLKEVEdMj3ROWFSwJI36J6EhRfOFGJ8FzY2RVKcLqIgQ1
         mAurABmHD4fL4rhaBzKI5fcZvtkLnGR1NTEbJQ3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJFBe-1hJwcm0JeE-002q9D; Wed, 01
 May 2019 00:33:50 +0200
Date:   Tue, 30 Apr 2019 18:33:47 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for
 transport
In-Reply-To: <b8e799e2-356d-2a03-faa4-2792ec1b171d@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1904301832500.45@tvgsbejvaqbjf.bet>
References: <pull.137.git.gitgitgadget@gmail.com> <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com> <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com> <nycvar.QRO.7.76.6.1904291916510.45@tvgsbejvaqbjf.bet>
 <b8e799e2-356d-2a03-faa4-2792ec1b171d@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:213daFejnqUXKYjGlwox2IjKeI6+7rep9Gxpk0JhrzYCLrn7SGV
 ve9AUzQ1tGmBcC0hpiIhqYIUnng3MhRosBG/+KFZa5zPAq5Kk4BNuGNqk5WV4L5Is19JgmI
 zpeAMyYcQN5GWNFvD9y6632fwDIUkWOncODLiniwWVCRuGLhVh9NKR64Nncn+xkNuYsgAbe
 miBjJpz8nbzdboDQ8lj7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UkkaHJ5R7Ak=:2IC0KAcQwtvvzSxRATneRR
 yOi3Top9XWImdfnJrIhhXqTJ1naHRI+N7RuPWkkWFbQ7kng+tFjFUlt/mT2S4p21L3m7gcHN2
 HXQwN8MRCcPQL5AbaDy9YDnS/T1NyIRJyIJTqCDIHpZiV9ppvDjwoJXdhLahlfHZVtxqXPQI9
 8ZadqOk5EkzHPjtIDi1evXw6qzSHOVG1C3oxKksYU3b6a1M0IAeUZegN4bR1kEn4Qn1YImx60
 ZKkedpoa2e/LX7y319FyErbIhbMy2Sh2PqwLpfC1hIzfbXPVbmbfRLRlmOr/ueBKP3ztEApok
 MeEvZaBliP2jc8y2vAZjLiv023+Dc6+udAmGSvt60KZqsuC/bqWfK+FXkxdWp9Neu66K0LdQz
 kBMf4g5wBVI0sc/+3hhsPfl+NMJlK3g8LKKY4+GqOFfDbfoFKSG3j6dB2rVnRaFn9txZZDj2w
 zQ42Dk7BsXDGw7XnK7jzSBSvMDtkXeq8O73AJMhRSmgV/MzHlX8RGqfVzl6SKRPo2ShngJhNq
 DTpgxFvvoZbQOLrNEFH9DR0cdFG505CDpEfkRDY28sWjYU2grIEHD8EZA2ZZAbN8FOPx5o5RH
 jpgjg5Q5r0ACxRD5irnJ7BBffjM47mL4q4TbkFSf/lQCKNLdwmW1yYNO37pv9+Xs7+Fk/fg33
 49WABJ9Td3wCwVEo9FVXprVGMwP0W/rA9tBg4t6gCgbhl3v321a4R5R760ye/3cvTg80sdMIl
 vAq9nLTZPuzjG2wc5ONNf9li0PnzLdXhKx8Vu9xCNEqhBvCCAM+GPk0CAlQqkjcCm8pf1+ehn
 vEqQa6R2R6tb+Ew4j/9M94iXd5CosppA2mCKRmkv2pSNp8hmyrBaqZ04q1TaUY8uGiodqEO1p
 vumHxI+faIziJeUJ0Qtj8SccKZv6TyU46v16gcXU/ngJ4Xz9xpCwJsenyAhAb9WBcHUFuPxSl
 OGjY3h5tCzA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 30 Apr 2019, Johannes Sixt wrote:

> Am 30.04.19 um 01:17 schrieb Johannes Schindelin:
> > On Mon, 29 Apr 2019, Eric Sunshine wrote:
> >> On Mon, Apr 29, 2019 at 6:04 PM Thomas Braun via GitGitGadget
> >>> diff --git a/Documentation/config/sendpack.txt b/Documentation/confi=
g/sendpack.txt
> >>> @@ -0,0 +1,5 @@
> >>> +sendpack.sideband::
> >>> +       Allows to disable the side-band-64k capability for send-pack=
 even
> >>> +       when it is advertised by the server. Makes it possible to wo=
rk
> >>> +       around a limitation in the git for windows implementation to=
gether
> >>> +       with the dump git protocol. Defaults to true.
> >>
> >> s/dump/dumb/
> >>
> >> For someone who hasn't read the commit message of this patch, "work
> >> around a limitation in ... git for windows" doesn't mean much. Perhap=
s
> >> this documentation could explain in more precise terms under what
> >> circumstances this option should be used?
> >
> > You're right, this is confusing, especially since Git for Windows 2.x =
does
> > not have that bug.
>
> If there is no bug, why do we need the patch?

I thought you of all people (building with the ancient MSys/MINGW
toolchains) would benefit from it :-)

But if even you don't want it, I'll gladly drop it from Git for Windows'
patches and be done with it.

Ciao,
Dscho
