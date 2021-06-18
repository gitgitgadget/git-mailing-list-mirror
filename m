Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B638C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A1D60C41
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhFRNpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:45:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:60883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhFRNpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624023773;
        bh=/xS2EgniSPZ3AaVlZoWend+KhbdW7L45Dv1TyanZrkE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K413XREhUviihT0gOCrrLrgMptfaM7Y64KSfv7hGMYe0yZIGloVR87yl3iR0zw10H
         yDVnBcAUD9tUPniBtA7l4FTQB84Ks/kSCRWXyH082leV3WM/uXHxX2rbdAnxM8rCjT
         lC0RiI8dXweIkN073LqNdSG3ceSs9rxn9Zeikvnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1lSIcB3gCp-00lGgj; Fri, 18
 Jun 2021 15:42:52 +0200
Date:   Fri, 18 Jun 2021 15:42:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 0/3] Make CMake work out of the box
In-Reply-To: <b52d7c45-06dd-a9eb-bc86-e04d2ee16c5e@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2106181540340.57@tvgsbejvaqbjf.bet>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com> <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet> <b52d7c45-06dd-a9eb-bc86-e04d2ee16c5e@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nau4ilrJbb2AQb4W7LWYBl5X6cc+zaoGxRJOzeTwn0bR/nhtR+a
 Z2jPOhPTPzs64XdejhRCSDHq/trYDruRhciJqg3V3bFinhMDEduNzEeE7ak2k+XvKm2Dzsb
 RjXwQAcnG9zhmk4WIIGs9nSK243Wuuip5qbLBBlJA/NKYsIq5JuiMfKXRPInOtY891dt0Uk
 0KDA3za6lMnfg2NV3oxiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xV/3JiP5Qa0=:6nmYrDx5D/JGNplMGqsOVP
 +zPmfSbvB+N9OCgJP5zGOgnTYFCzkbIw7XMzwlGQKDqT/Hdl2tZ7G9YcoI0BpM2gtjU2E1lGm
 V3QPQ+rNrHwpH46FFev79N+yJKurBt/9CElWYmqREMg8ZKwVYrquG5HspTIYvVWfjn78cvTJl
 eWpyIz3YX+IWgp31Lis1rY4sCaCu/qlgQCfx4fZcCh2xdKFJFuc3ehKsBNKUsGv1Q65TFoQt1
 GK3DsmQ8Yzmkty7khQU5Mlpim6aB/aHV6hm2eTL+tv1lR288P4bhVYQZwFWQxP/clTaDHiyJB
 OE61+lixotOJQKCH2JaCikZ91QoFeSP2aTAfrbp32Uldb0JNqJAkRf8946ZWxAimxNcqIs3Qp
 9hfTMwCVuCL5Y3vmf5JaTumD1FABybuXxjbrMVGpA5hra1rVV/SHARCrBsaPhbhwaEJPEzP5+
 xVryMDz4+v+AnzJc9QCiFYFztJrig03oX/hAXOG767zK9fDwRulgRBXGj5KJL1xJG0bRw7EaQ
 WfI0iCFhvmCQsse3BX9CrzPh+yz8ClkYqtdhCpXwOBDhKcUeKFoWmlfTjiXUiIXNOI73yV+vI
 CZil3pdsdo0O1C2nyK8WCqCQhUPTmyZZjSC4pA9TqGAGt4F7dD8naHDqmdpSN9R2pcYo/p8Ut
 UHbE2fNCZXn363VoW3Zq+dhVTy+j/GztTH58Y8QE9Jg2MflEtKqQEKKSqbhFJevlYwH8FIs40
 hG0o28mTVyNKpinbuvjGthZE0GAKK0ioPxk3SxxMoo4R/Iv+FCVDg3iT5dlngi6l1GPiTBxah
 7VpYx8gHyyQ5yI4C3GWaWDiAupX+eXdyBiM8d+AyZBW4Aa7Ypbqa5Oe3kyCrwfpNZc7YlOr58
 U8jPoWWyn9wuShMFY9n2jHP8u7F1MQHmBWBizk+UkkKDh6KlAijuITXhws67eYrVJQJzloesX
 r/8iTCofYDXdXnPIQ40Y8mW6L3wK/y2tHf3vGK0i+HbUN4xEG1l7EzOYpN3t4o3OdBR2c/5wK
 x/WjTd36B0Qr31H8taMFJNNMwhoRxa/aUgIV+ahf/5ohds9/6zkk5Gca5kz0sQxk5uwypjvoA
 hbh67ED9ADEy/C8A8F++wWJ9KkeQczslJ33tavrn8hhejTT2vstMlYaLg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 18 Jun 2021, Philip Oakley wrote:

> On 10/06/2021 10:43, Johannes Schindelin wrote:
> >
> > On Sat, 5 Jun 2021, Bagas Sanjaya wrote:
> >
> >> This focused on improving CMake support, especially on Visual Studio,=
 right?
> >>
> >> Then so we have three ways to build Git:
> >> 1. plain Makefile
> >> 2. ./configure (really just wrapper on top of Makefile)
> >> 3. generate build file with CMake
> >>
> >> If we want to support all of them, it may makes sense to have CI jobs=
 that
> >> perform build with each options above.
> >
> > We already exercise the plain Makefile plenty, and the CMake-based bui=
ld
> > using Windows (in the `vs-build` job in `.github/workflows/main.yml`).
>
> There is one 'gotcha' in the yml (probably historical) in that it
> doesn't actually test the approach/changes that Matt addresses regarding
> my [1].
>
> That is, I'm looking at the 'out of the box' view, while the yml test
> _preloads_ the vcpkg artefacts.

We need to "pre-load" them because building them would add another
whopping 20 minutes to each CI run. And I am not talking total time, but
wall-clock time.

And we're not in the business of testing vcpkg's build.

So I am really not in favor of even thinking about changing this
"pre-loading" strategy.

Ciao,
Dscho
