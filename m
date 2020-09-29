Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB3C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A645208FE
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kVQLfWKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgI2NEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 09:04:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:47717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgI2NEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601384687;
        bh=HO6PUPPbNpuiPWPKvDNJ5Opy95AFgdrqaWYriGAJroE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kVQLfWKhDLGY4Ap0XueytP1pryJUyWS04HIOZoCbopVKzBGqEWjnQQTh6vLljqSvr
         rQzO8NG3BjXDibNT+kJOE0BC1FAJDP/9LbEXgMoV+cRwKDE+s0Wl2jp5tnLo6ghtMa
         QmfaCSx2MQmu/Vc+VwLs3T+Dq37mb7+rEGz3n5MA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.214.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1ki5Zq0kP7-00ubD6; Tue, 29
 Sep 2020 15:04:47 +0200
Date:   Tue, 29 Sep 2020 14:07:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v3 08/11] cmake (Windows): initialize vcpkg/build
 dependencies automatically
In-Reply-To: <CAKiG+9U2v+HYXU_xGzbAK11fo0zHSR7xGBWPq0=0e2rU-Z5W0g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009291406310.50@tvgsbejvaqbjf.bet>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com> <pull.738.v3.git.1601327357.gitgitgadget@gmail.com> <7c1601c7e351855fd720df05efc44440374792ce.1601327357.git.gitgitgadget@gmail.com>
 <CAKiG+9U2v+HYXU_xGzbAK11fo0zHSR7xGBWPq0=0e2rU-Z5W0g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5ZPesiUfDPFRHybzA6U2Te0KraQ8wxECAo7JhRwmjCA2zXpa5GV
 68DcQNg/Ho45+5zL/Iq+RWL2QWyy2n5mwjRoWOY1U3rPNls15icmZO5WNhBwBCo9ANByYl9
 +X5JWBnUMjWbVtjKIica2uyA+JagwXvhC/H1mPeJ0oaOx+po2ni7jvcUOrej/BsPGK/AXYk
 1VGQ3DTiM5BLFYJl1IgtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBiN7YxpOqY=:XW64vOgkGblH9khJDNleHz
 wSEsjFMrX7bMZ1TDRnIb7lqnEZK8vNcRUtLeYdt1OyCgr6hFnx0YbHV0nzb9zGkTapBsFNTvI
 f6HG+/uREEmaHE2PBs5JDdDL9HwUodukd3lRS0ilUxFCc1EDsoBQ17rEBBgD2wfpqDmleWOYo
 BJnCb2C/j9Rsi6V7ql6OT+/q9Fj7yujtem+3tlfmaS1gcrzCyuk/PcvMXD3oMWKwhko/ctb4q
 oIg4elQRfQNkdGnaxb5vRUJIylch7L/raBjVMzjGO2qhRxPDG6Ty/7hvRtaDo9xGpRnd7ZW4L
 twX53zeO0BON3XDc22XjR1BKHWd/0o+J2C49f4zW8PnpAxEQ34HuC6OEC0/m9C7HLCqLjUua1
 6JRCwk5fRozFS1HhB4yM6NsVxcaO5m0tslPIG3FyTI0BAhx8CnGy3K+QGzZwh4vB2gKBoelMg
 lFbTRekQxWxVufM7bP9Sci22QDrFibHA7i+kYnZOJqjuADsmNdSY7sQcZ2veey+lVaLLWnS2B
 33W1SjLWK+ZCf8L2Dv2czsxzK6J/+Tu24z78311OO3fdBXWCVxQpjqkmiaz1WsJxtr0Le2dIG
 mZ43GtpNPh+ILU3iRV1enxAAd+pVLs3dPr4Wwwq//R9szTxcrv+3lBI7JiqvDcZ6no0pG7/qh
 8S/ya99hq2etu++rdzXonvY/mPf3T5rrlOm08MY0R1xV4//UJK+xSikIiPiu6GI0gtJd4VXAI
 dfUG1dtXMU8OZy0ytQNRID9WJguZ7RR3Qn7+S5oHiGye8wAvUv15bh3tYC99HfYkfZY3EH0Oq
 +lQlEIaOeUkrHXCJMc5Jo/5ytassCK9llS6K6XnaZcjK9e7pnNtI5f2Og4kkrkQuvHH7DkqQS
 1ruXA42I58Gd8Q9dIpFqPzPf4/T7VtE9ypjb9Q/NqQWuS4p6jGPMkrLohZegwXAogynYVwmyu
 CQ6iEbju715rxFABTvvdoOcYFuTqgrURmBzisZ5sPPX+co2nLowNTE+MoTr4OW9q8IFkvhdvQ
 ++nxRt7pK1mmucI5LX7AKFwm0iJHtCKa71yMnshj9JKpVAWL3zTj7Rxte+a7xNqVZEtMQPOKx
 7SO2Ayt9RLZrR8lAn1vuzAJTOTJ4dRS+XzOfVMOGzVf4XxNiX7BvtuwFsffdyWCWPAq9+FP6t
 qA+E1c3DEb7CaDB8Dnj7AjJY0o7Uj921CPmF7vaBGS5sb1do8I/KMrjJ47tl1xyGd/upwWUE4
 RIdIklK+wV/TZz7+eCblDs5hDn4TqqkC5dLl33g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Tue, 29 Sep 2020, Sibi Siddharthan wrote:

> >  if(WIN32)
> >         set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
> > +       if(NOT EXISTS ${VCPKG_DIR})
> > +               message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
>          I think you meant Initializing. (Nitpicking :) )

Aw shucks! Thank you for being thorough,
Dscho
