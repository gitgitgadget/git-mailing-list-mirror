Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64AC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07D620C56
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YMyuagoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWRK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:10:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:60045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWRK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 13:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600881044;
        bh=7w1LdICN+64p83BHNLQ+aoJNlg+qiLmjrWa8Ejn/nXI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YMyuagojiK/cfx+AhO+W7ABTpiCvBvbEX6e8DJSDQ6zOSXGZBJPvg9TKeOOkfWGP4
         AVzCo/YXYxWBXoEzQ/PtAWLfmbgF+PIvvNreUudadAvSqPJEym6NVOdVKbkogZCU9c
         mOEFs8j85RQRQGOCe0z/3aDVHPfHn4FAuqFMxL64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1kCMrc2xgO-008sql; Wed, 23
 Sep 2020 19:10:44 +0200
Date:   Wed, 23 Sep 2020 15:08:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqqr1qud9zl.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009231502430.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet> <xmqqft7fnlxr.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009201914330.5061@tvgsbejvaqbjf.bet>
 <xmqqr1qud9zl.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AaAKO66Yhbbr3PzzeFlYlMmpTxD7QytaMwmwQcEUq0+unkMhauf
 tobsRpJ982EsF+J6hMzXhMjn5jAwjuOcHlZfwaTjF+465EyygRiwypZDYB4nFsRuvahS6sv
 ZjV6mha+jo8OndghSyNk8R9ivg/RlLA5WrvlBF5gPeYKpHJfjo3cB5Xn8CjnjIwyiInT6dC
 YpoP8O8CCkiVjzsL3DezQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JT/yoXmzmcM=:fZOzzXo4rI7seY6j/DCZMW
 GUavjNykR7w9ksZGGpTwKsj5xK7GG55cltEBzk37Ycb2ek7SAEi5h7zck60BgQJ6q2w2BrdJX
 8WiI7KyVYPRmI+8w7qp2GJ2Ob8rwJs1KgpUyUtAJlt88wS58M7I0S78oPCexHF3+A9ZW////I
 tft8v3ob7qzT2U6b9XbshZvgX50qnSDVF2XyMhHRlLyRokrYth9gqICBrzvr7+OL0UB+f3Yc3
 Z0i4FCxHM5xuLP62UQDK1vuUyYai3PRw+RdyJi0rQE/cJMJX9+l6q3bkBD3a/kJLLOUuN4MQY
 HFZUTUlwJd6Msb7FeY0wL0zaHH1DYmfPlMsH1QkmKhMRbV0EA8/Ta0yDj9sW7qtYWeICV2fzY
 MJzSvnhOqNCbfKu6WMHzekOq3dEsA+5flJYibYPXVMqk7ZernR28f59tl1fR1BuTailnp1FyV
 QRYNY/adeM+/L3PgRxwzpfIJ8n4ULsCn1PiXTbnJ9NodCWrEKxewiAsSLMzCXFYzuk6oHcyob
 KI2ksq4ltXqk8x4Xyslv3+8J9+tCj4NHM6WEVo6w0b8+4yQLHm9KoueXUbzuMLVlddzaLfbH2
 xRfGsBSEhYwmo+MMsCcA8mLuT2YpZBCrWSwYe0Y6cg4ta1HA6Ml7TYePDfLhNsHHq/C1ydVPc
 NxUd9Wpv8JJN+VLEg9v+K2+3ge5EID5g3y7KBDc0gLiYLws8E1AkQS0STpKwxnbnKrTPQcdbe
 1zYBLFCs/C/cQqOnBJhlJehjJRhutBuBKPVD5mYXHFNWxKS+IC34pEVAPeX1pDO3ybHWL8NE2
 VIuzcqath4dbH4Fp5i6KuHTZ9/U4ghjsYCiN+BNKBJy7Y+3S+9ixGnMeTWG0QICOK30u0e518
 b+9lA8gUYPoFFyjeYnGvJMAELHWQqfG1o+9Pb3cmwcVluOECHMQNXic9StbrGj1Sq8ni/vsyN
 Q4GRV2ii/p17mFdeMiQOSbOwMLG5eBkLOEts9+oOmzUyJ2E98eeN9TKkwzILqcocGCnKzbwMf
 S5EKWMx/GwSM4Wbw8gI5Gt6gWjAJR3+YZ3YeExlriTd38AZgrMItI5Azd5vPM5fEXUim2pjGv
 4twyjrEYy3Xa7L2MUnst+6xtNz+U3H+wkQ+q+cnFqArlcIflV4MzdWb06nUCoyZuCQjge/HUA
 +k5QOcggQLqjgoLwtCQvzEWf89c8yuBLxO7RPi6hX6w1+mkRW3KCDKTgAnMzABoo4Skty1Nt6
 Df+qZ1T6svVE72gUDF3kUmkM7eFONWGwTS/XjPw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> What I am hearing here is that people with CMake & VS use "git clean
> >> -dfx" when they want to go back to the pristine state, unlike those
> >> who use "make distclean", and there is nothing to adjust for newly
> >> discovered crufts we are leaving on the filesystem.
> >
> > Yes, that is my understanding.
>
> I do not know if you have read other messages in the thread,

I did.

> but my current understanding of what we learned in this thread [*1*] is
> that those who use CMake, especially in a tree like ours that has its
> own Makefiles, (sh|w)ould create a throw-away directory and run build
> there, so even "git clean -dxf" is not part of their "clean" procedure.

Well, our CMake support does not extend to generating Makefiles: we
specifically target only Windows withour CMake support, and since there is
no need to help developers who already use the Git for Windows SDK or
Cygwin, we really focus only on supporting Visual Studio.

In that respect, I think that all that talk about Makefiles isn't quite
spot on.

In any case, `git clean -dfx` strikes me as a perfectly acceptable
equivalent of `make clean` when no `make` is available, as is the case in
Visual Studio's case.

Ciao,
Dscho

> [Footnote]
>
> *1* https://lore.kernel.org/git/20200919004030.GB1837@danh.dev/
>
