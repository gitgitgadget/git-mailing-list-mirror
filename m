Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554D81F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFSVC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:02:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:39305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfFSVC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560978168;
        bh=ruYMefqooXyERpDu9rJsyfmtvolK/6s4qqkPiDHy7qA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h63Yjjadna0LBnV9p2PJ0MkWceWhX3XMa01iJ1F9zVk0n0hYJ6LCRXVp06JDzC1jt
         bkn+wCvUjBlRnuXyAjgs70/v3v41Ho9v+YwL0vTEyOFeYj+7CJAc453djIAlBJZLhk
         28GhQvk0UtTIyFrnTPaRx3HVcPRcPelRKYX330AA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1iKALP0k3z-00mImQ; Wed, 19
 Jun 2019 23:02:48 +0200
Date:   Wed, 19 Jun 2019 23:03:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
In-Reply-To: <CAPUEspjJe1n0sTG292YaHU+qBa4yLrEw2G_6Fd1U5Af=f9JRAg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906192300060.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com> <CAPUEspi-G7abt-zuLbw0iuyXN0gtrM_6Vy6d+9f-=6FpRsoV4A@mail.gmail.com> <nycvar.QRO.7.76.6.1906191316210.44@tvgsbejvaqbjf.bet>
 <CAPUEspjJe1n0sTG292YaHU+qBa4yLrEw2G_6Fd1U5Af=f9JRAg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jj1NWJUC7pVFoCVhg/JlgJb5bjpDZU0XtywVDI+uF4iJkaEpKVZ
 Zog5dN1VkGJ7hD342rZUcGh4cPBqp4Q2RECR2/qogm042ZrDtnbH3bmV4kDHGoOrFRi/RBr
 nYbsF67mTZ+0/HGty42lCFlmSzErAgmc72XNdvfbpmj8OEAd4pcy6TMmbpDWMEfrJS2At34
 TdM2MUhx8BCOUfMPe0fpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oQbIt+tJNkM=:UloMWQ6Wa9XzCm0JIQVrR9
 b3rX2Q+ib0osKsM/E3BvzUAjY6s3attKHyAGgOOldln8wVJnoZWfWlhCwKoWldp9E0Afc1cbS
 6oWiKWaKw8itaerHkC+BIaSwe990VZ0UfpcEdLXspNJeJFbFUEZ4TI/bNnM47B0USndbADWUz
 udPiM/vUVnXUe3iuLOVrXIcmJxCCxURX6thehzN+TY58lk7FJ+0b7JbR/MCwEYDQtl+JnJDoH
 e3OmzBvKY9rYUuEhZM5q0EFLJmZJzvRPbaDLrq5yW4XqikaeS3RJWAbn0WIY2T0bXHQ0kpKA7
 Cs8R1yOCGR/RwRhX/ybAdOP0A5pcWcba5CZtGRx6rX0LnaHdPHkHvYep1JP98k0PWtFDT/u9h
 pVI32KaFyhk5OaXvFGnpTqiaAOTBzbCEOcc30eoxyUVfLNxS7dcz1CGzYSXECVQtr1o6fy/VX
 i6b6m6T1CD2HT06dcImobWniFiVuZ7ovgC/oYG6va16YLnt4o2BZlSEQ/8SFYbaZbPs2ww6uY
 auud8qX/VD5yVDa9XK4xpSyDmBQixHfG+ZUj5myzgDITJ0ubXbHAQXrZe3lpSMVrPcinvbCj/
 YR7k19QloI3DjvIgXyIKskig63mh1gb7jPazrpJ1n8k9axVX9XvEFaThjddVaC+SKjcgVNwza
 V+G/QYFVuoZMaq1FessxYukx6iYPNGRntlSVStijnhqSPH/93eWmNL/CK+MOf897R6wXmEDyI
 oapeP0DL7Zy9jS0G7SgZfo9oPUNzmk8Jg7jIOdl+n9wRQ+O/9MC/PWEpoWXBcFu1HdNcygZtM
 7SwKPo/alCM5WyYI3anmFje4fdnXrPcXJ+mqZXXYRTAG6zXHnhJNCDP5VI+py8OiwVu7xstDf
 tUTyN8V1MMEKrv+tq3tCqeRfkZvHQ+mWtfnB0XN04KjwAPtnTWt3WwBv8jCMMELrNIj+QA4rL
 hPxh0+zema9fn8r/CXeCiSDNQJPxymfqV+avW2berGhB94QpGZkoc
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Wed, 19 Jun 2019, Carlo Arenas wrote:

> while those two changes (from DEBUG to DEBUG_$foo) are worth doing in
> their own merit, I am more inclined to consider this as orthogonal
> since by your own description[1] the right name to use would be _DEBUG
> (with a preceding dash) and that would obviously not conflict here.

Well, both `_DEBUG` and `DEBUG` appear to be defined by Visual Studio in
debug mode. So we still need to rename them, and I'd rather rename them
here than in the next patch series (that will (re-)add support to build in
Visual Studio), as I want the command-line MSVC build to also define both
constants.

> the only remaining change then would be to drop the -DDEBUG that gets
> added to your BASIC_CFLAGS

No, for consistency with Visual Studio, I want to keep defining both
`DEBUG` and `_DEBUG`. It's just easier that way, as I won't have to spend
extra cycles to remember that those two ways to build Git are slightly
different, when they shouldn't be.

Thanks,
Dscho

> Carlo
> [1] https://docs.microsoft.com/en-us/cpp/build/reference/md-mt-ld-use-ru=
n-time-library?view=3Dvs-2019
>
>
