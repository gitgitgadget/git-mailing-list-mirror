Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80542E7E635
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjIZN5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZN5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 09:57:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F80FC
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695736639; x=1696341439; i=johannes.schindelin@gmx.de;
 bh=G6443eET7gZhs6GCV/cE3FvMBkRVzDZ6okcmlYlD6OM=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=L9PxsQbBZyUBJ4YfCUtU+44EtBeyefYLz20kwXiuT57FzDh11ZICYVGMZqCHQrd0p6X5p3S78U7
 FPOW1y647/55+/zfnxXKCP1Wi5jx5d4GmHXpHoYEipWWST+qB2oaE/oACFmRsiiC0SVo9o2moL0+7
 nGfx34K0LISpgjTCO+Q12g1T5LDXB7yMUNODkWLNyME/gLH/W0XBLyDXcI1GFCVsq+ChmS0iqWPWd
 W1tsWEMoBZrgreR1gsVwvRaGuGLDAwrwY25GLK8kz/OlLhPr9MJI36tVLpg4anv07Rkk30iCp734k
 b7lhDhOdhww3a/ePMW77p+xPZBIZu18X0FLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1qypxJ2Eg2-00Ni4o; Tue, 26
 Sep 2023 15:57:19 +0200
Date:   Tue, 26 Sep 2023 15:57:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Add a GitHub workflow to submit builds to Coverity
 Scan
In-Reply-To: <xmqqy1guuq3w.fsf@gitster.g>
Message-ID: <c9858529-1e2b-8a17-a7c2-d07bf300fd09@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com> <xmqqy1guuq3w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OJx8LZcoOFe7RTyBuXSW0MpgIHr0Lc5Dwnm1YYvp6Emla5iDet1
 ZJHW3hiTTGpi/b6uxQhek0Socruc5TKdEdBQhOpikCUllhF9tWBJ1nskZSd9QGRbOYRQYpf
 fDtaZh4z9x1QjWwzANgMfzZju+2+N8GFIax9Zrhkup/SS0JyZUS0VFXKptaTWAm8GPc7+8t
 KhHsP53llWV0baZdcd4/A==
UI-OutboundReport: notjunk:1;M01:P0:27Fvmp75px8=;2kOIY5kUTTtEkGRP9Pv1EnraDHR
 e0kPmXHeWcbrx6w1MEd+k5s1h2+bHD1ho5WQFaup/frB9R/7ZrrDONGYQ9TwFUzEeWAO6lI5R
 lBw1Du+aShuuzZldVRv7D93uy7dHoT50cAd9y4yJGTIl3Bnfq62IOh+eK1PT6C1KKOPWXw2u8
 RleDeB2o6TC+m8VEOtjPOuA+u1Jc2GVpvr0hLk+SrOOa8n9vH9gWdnVbHKkiEJnj6/EoqOL5f
 ZAnva3N9vU4Nf4VTcAwDb0NT3Tvp3h5PMDpt56VgDpoT6sqnw1bOu6YyjO3WdZdtsE5ZobHXF
 tjP7+0D7NmJmEj43RhZG1M74VOv+IcbDnV30IxqBGw/uQ2TN0bEB2KDDSRAwQyaft1TEwdYe1
 ZmVgcEfPDSwJj/l+txM0DVesrtvZ1GtU9qIDPUV3E05XoJqdGaQ/4rPLb0Cqw4LIdIw0Cdi8A
 HfBLzicTY7z/03m+bhM8Bcj6frvKc5EiAbG1nmnDoFBHnTJCzODm/yVHoy8kqAxQDUabGbyD5
 KBs/zWe21W8W4lo0ldDr07ydX3a2ClGgFst4ZcVG01hC7z6QL4yTCnamnSg1hBRieR3hZCHiu
 a4/NMvCyas8i16vgxjIRqz5/kePsmPdJZ7ELO8lzR6INiNFFtF3TZ0l++5quUOL5Vm2aIik3N
 DOtrCihMQaJOV9+YKNi4YnNaDtYckX+lFVwwhYgf14s2OUHUY05F4bjXzQ5sz0DXgM2+X5Hdh
 QPOxhcmsuM5UbTgB/BCiFqsvlQuhvonIGE4a+yXeZO7Z+iMLq3sdVWP20ZMKcylfNe6NczYJl
 ZSU+o6GsLV4mAAdl179AGewTTzVCHoFrBkuITLB9ZxPSllhIoynEv4HjXBn0TxH85A3zyCh2k
 Xmr0h+pqCNoJP6pts9hpiw+nCuEoU/LLESexqJA6uuI1Zjwlmh99cZYw48G2UASb+hEO3X5WW
 g2K0sfbZqSIPi3KKhTbH3Z2wyEs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 25 Sep 2023, Junio C Hamano wrote:

> One thing that caught my eye was the asterisks around "22" that look
> as if they were designed to confuse readers [...]
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > [...]
> >      ++          case $? in
> >      ++          0) ;; # okay
> >      ++          *22*) # 40x, i.e. access denied
> >      ++            echo "::error::incorrect token or project?" >&2
> >       +            exit 1
> >       +            ;;
>
> [...]
>
> Will replace but I may be tempted to edit those asterisks out myself
> while queueing.

D'oh, of course. Thank you,
Johannes
