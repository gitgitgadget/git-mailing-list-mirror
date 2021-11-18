Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20EC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012D7611BF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 14:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhKROje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:39:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:42377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233517AbhKROjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 09:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637246167;
        bh=ZI/eAkdnOB68BJxxB8LwDjIj60/QkWXCfVIcZ48pYm8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LxWs3MOdZQx2fVJQG9TT9l9O71E5DgsgIpB03ZMHJ79upJPjwlkc/zlnjDwJZIKws
         l7NvkpFx3ppOSL8ftuaDP2wgybgpWlwktIFuURnFAL5tW2MjEbRAO8XKkeWTTS8FQL
         TrO/b2qJ1YlV0doqW4JUvAQhobiKvnLOXULzlpBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1m9RgI0qNp-00fDVT; Thu, 18
 Nov 2021 15:36:07 +0100
Date:   Thu, 18 Nov 2021 15:36:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
In-Reply-To: <YZWqK38NRjD7aPOG@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2111181529380.11028@tvgsbejvaqbjf.bet>
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com> <YZR0djZbRUicXcQm@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet> <211118.86tuga5o68.gmgdl@evledraar.gmail.com>
 <YZWqK38NRjD7aPOG@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-186997254-1637246167=:11028"
X-Provags-ID: V03:K1:fT5AldwQRufdeLuS4JALOoPrqopXRavGA83JDK7XgYqDDBg8LTv
 5CYksU2X1B1K4OJ1MVCqagowO4VM9axrQtPBhYt0bRsDlPOVlig6VOufpeG18J1QeKAxz2B
 hKfkJ7h5DYwidwYmYvAKQJYnFvPOMVCMbUVJG/UFtH0XiFdyV+mIUTgjADhYOzR141BHIJ4
 ikDUJqwLVD8epC2vjsjgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJEeA+nudCA=:1dAvgCCPpUycHxg8xYuvQa
 Ob4HLqCXspoOqrjW8nJjl17yh+n5QQzjowSUNldyIztBNQ4LcDAlAtn0GRktThGzjAVI5hzG1
 B7ECkEAaa0o9xThGoAED9teE1+SMTF06hJpP0CvoGz19V75FkCqoizgVBSz+mF0h261vx2uS7
 YMctlygDdNPHPL+aYXPJ/+0AyFU5rMTIcY8RrVLCcFkgei3FDlelmMx9cwM260y3Wmd6JNO/l
 fCe6bTiWJ0QfSSBwlvYAVYwJRfzhzh1pWMNBfPvuNwcU4/8PJSiORK1o4yVNpwiK4G5Z+Y1lz
 kb6W0b+9NfIBrYYbME57xa319FWPJEjUutM0d9LGzlDLn/gSebvJ5Q5QKPwIbtdzeTk9nL896
 6fPej1N9LpSiNYur0lbhkF68ntITXeRPm6tiP4JWfrszm0VdhFEDaaZdEwzcubuFzFflUmmx1
 IAe//CF0V2m5WjpUkmtBjz7I47IusPDlMOKYjeZFmXz/62XKxjkUDVXKURALv/03hroDPq7MX
 22ZXVnuOm516ftMczRLAZ5zbgHlxYWTzCGAjXv2iqT8C/3cKi0M6+W5ziVB3/COm9iXLTJ99j
 77FiMeaYZq2AX7p5XqDWV9GE1TxEhedwHV9v7zES1Kd0RSijJVNLADxegXoLH8obie9WwWDlF
 ny+3PLcK7U5YFDJAQh1nY0P4UvsQZ+oloj+y6hWR/YVGlTTWrIIRRuwLqbEPDkDZhl7NjCI6c
 wt4RWIFjOX89qg6O471DarshiWw68wrEWnQqGNK2DOWj5YETNgVmk8Pukw9j+S1vSxfWC3SOT
 gffZm07XciM/pLik9MwIaJiTg43x6xRIO0b8SKUsPbBdXs3XuYz7332KTS3evDqG7UBPr2Mwp
 S/+uYF1MuRyNHol6b088jODVWjfkEsD7z0JRKbVhCU+Q6z7KYHOYZ+3F2aA8VNTNKv46kpY7P
 GnwKo3N5XpsIsRJrUx065rNABnLwQwVQaVJ2FRC5WxQ4gwWjFb5ZxAe6nbVBz9MEHm3PS61zU
 qU87GYOEXkTO1485rCIZEYDElmbW4toKhDird/1UhfzF2x7sNDib2GLlcqv+ixCZEQs5GC/Xu
 cpk5yl/9syrXpM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-186997254-1637246167=:11028
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 18 Nov 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> [Git's CMake-based build] couldn't be configured on Linux system,

That was an explicit decision in
https://lore.kernel.org/git/xmqq1rmcm6md.fsf@gitster.c.googlers.com/:

	Let's not worry about cross-platform and instead stick to Windows
	and nothing else for now to expedite the process.  As long as it
	is advertised as such, nobody would complain that it does not work
	on Linux or macOS.

Ciao,
Dscho

--8323328-186997254-1637246167=:11028--
