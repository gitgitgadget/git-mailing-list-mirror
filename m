Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172B51F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfEHLpp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:45:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:50987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfEHLpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557315926;
        bh=a3ldyyWi3XI7kpj4pNMV/2rVEEAPhPXRytTDrNNgiLs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kyXlIQISRwgf7Zt3ayzc/2IFrMIK03Dd6JLI2VFVSiYgtOY3OUMQczX5ojkmef8RJ
         sNwwh9G6xmwzXBh1vtzKmsm8hB43VreCuncjPhF+FyeJnM4G0Q07riZb8JQtalekd3
         02p1hKn67kp7O9/o2zOIDOyNibA8D/oXaqJHpTXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXq3L-1hBx463pJf-00WjaQ; Wed, 08
 May 2019 13:45:26 +0200
Date:   Wed, 8 May 2019 13:45:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as
 unsigned
In-Reply-To: <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
Message-ID: <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <pull.145.v2.git.gitgitgadget@gmail.com> <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com> <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1070412990-1557315926=:44"
X-Provags-ID: V03:K1:VppydjTAPX2Wcfo5ZTlCLZowve0Wh25uh3F2QmNDVvT1+eemlfF
 EZedjxsZJG+tB+oUv9IKTgrSbQC0JOIyvKgfNzoQcjYyfAjqa3RgulHbInM1J1FeN3WMStV
 ZgGOcWO1IY/ykaSXFSszT823VmMtk6nGsOiblUVK/WXC3NDogzQzpOE4r/ajJfYWIKch19c
 g7dpMHkNKxZev1dU7SxuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ay28UV1ygGs=:0Y1kQHtNfaFWJ9iSJbEFQG
 1np3Coj85pYDx7wiWIXLzFo7sPyOjS5jVTr/yJvpBryncie1McrzamRgX/wu8t7q6eT5ilUsQ
 5KHCVm68xsaohP0efde9PFO/Rq7lAhyB33ayTSFAOyTGgEj1JTDR7EvZOcaHmgVw8K963l5FO
 /hrA795GjIXv1rKosgd1Xxj7Yqz0UgyZQ/qiDWUjkFU6PuAlZcjnGGltcxF7KhT+rYSNwK9SS
 tYON77nWPCd2sVtmTl0OrkwyfSTWkH+94ael/nVmRkxcOhRwK6LPMhdp4frxCnnwzpq+BA+/A
 Dt2QKqztuVUyjM1kfM1Y+TguxtY/xgDHnZG93plnua9rrfgM4fQH5G/N5iix8++P734os695j
 Hn9dHQ86QgCt35DffQiKlEFNDPVFcG7gD1llnOs5/JAUOch1nBHBMHLE4eR92sRVFyFkh/KsB
 AGk0hmUojFufkBo2LDpD2mwcAFvhZijkPlF7GxnB9XK9lk0y39ZaHKI7znNpKKswwh4bfoHq8
 pOpuPPteoG7Mq4IlaAHw1VMOnPAJai6J2YByEDeKkRkgyTXafTMY6ygjn4Yg+PvMmqeimSgg6
 PMXfnzgOCfvZ+R6BhSqwbN0f4DZUDwhyovfUZLoW/6Ycn7UNnRF8qXVioZbyKu2SkRoosINHE
 K5eDUdbdGhJUdTQEr0oac3sxzbQ1xhiTW2jymtrBgKmfGbbDFmhpg9FVsv/d0TMhj8pXET6IF
 oIEpVq+yGujCwcZhQtqJwnW5u04nKQ9/zXhwDyVja0bKn5m6HB9k3n16N28+FzqoQQhWNnmWi
 zfxpxYM2/1g17bknUh6OPVTioipBh/IOcc5ctcwfOvZrZGaCR25VQrXhseL9d3UEPw5TEgCcW
 AMEtgnasW/a9drRoHSy+2qjDUCcFFgLscijfbctFeRaY3lSnnJLLyAqXeCFSYwkdSEQ03pn/g
 QKGgIOFhX8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1070412990-1557315926=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Thu, 2 May 2019, Ren=C3=A9 Scharfe wrote:

> Am 27.04.19 um 01:27 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > They really are unsigned, and we are using e.g. BLOCKSIZE as `size_t`
> > parameter to pass to `write_or_die()`.
>
> True, but the compiler converts that value correctly to size_t without
> complaint already, doesn't it?  What am I missing?

Are you talking about a specific compiler? It sure sounds as if you did.

I really do not want to fall into the "you can build Git with *any*
compiler, as long as that compiler happens to be GCC, oh, and as long it
is version X" trap.

We *already* rely on GCC's optimization in way too many places for my
liking, e.g. when we adapted the `hasheq()` code *specifically* to make
GCC's particular optimization strategies to kick in.

Or the way we defined the `SWAP()` macro: it depends on GCC's ability to
see through the veil and out-guess the code, deducing its intent rather
than what it *says* ("Do As I Want, Not As I Say", anyone?). We *do* want
to swap registers when possible (instead of forcing register variables to
be written to memory just for the sake of being swapped, as our code says
rather explicitly).

Essentially, we build a cruise ship of a dependency on GCC here. Which
should not make anybody happy (except maybe the GCC folks).

Let's not make things worse.

Ciao,
Dscho

--8323328-1070412990-1557315926=:44--
