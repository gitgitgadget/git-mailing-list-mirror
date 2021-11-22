Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6163C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhKVWGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:06:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:34791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhKVWGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637618596;
        bh=GfnZ4+v/aR5nNFik/luuRLSu11uzyxhHrCZ9XcIk4dQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ge4UBeST7XafY7xaKKLvvg3xcXp3KfyOCMM07onDbnksTFvFyw5X540xHf84aXyl/
         9LFDrZsapQQrIiF/9JmJdsaHH9mXOkdldaMIiT5PNZbYtbkatpc3lYfYpEwPzudcfp
         MFdEs4LBDnKAoGJNpOCuxO/5RXVtOYEze9PawLqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1mIibd0e0P-00p5So; Mon, 22
 Nov 2021 23:03:16 +0100
Date:   Mon, 22 Nov 2021 23:03:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99
 supporty
In-Reply-To: <xmqqv90jewwa.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet>
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net> <20211114211622.1465981-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet> <xmqqk0h7423v.fsf@gitster.g> <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
 <xmqq1r38hzi9.fsf@gitster.g> <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com> <xmqq8rxgf254.fsf@gitster.g> <xmqqv90jewwa.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XWYouoaRHfWUZDSdL3rSd5AyORZ35QCdh1M9s7ihSn7jjgXx3jp
 MGjJyoocxuDEVaZzYwxOevYWwOw3aw2ba3F8mjZfZ7z+OG+5R1ZNPSZSaGjXyrkfKt2AqQr
 FeMt/jUAj7HdD/q2scZ4/NhYDdypCxeMP7bUhxZzkaOMjD8y+SGx9GvgC6TjgBVzFYbZzz9
 laMc7mywaZVULMTjf0i3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4TWF1qKGYI=:tI8q8F7VsFA190mgsz4cJe
 nGfCu0zPRdk3ojB6K//PevYnkz8IPhv9gRD4SxfmKMKHpiUU5CVuklOjJI8ZYxzxpn8Dr/zG/
 2NgfonYQw9dNfpbq/vUUep33mSJwzydN2gLvLbAknTeckHjLh9o9tdMtXVrhQsp3sM6W1rmDn
 Yf9B4KJFAnV4KrkYwpeW+3RQaDu7mdQQGYJdBEke9MXeahODogFdRHCOueRoCTBZx/pA9/pkR
 SGMfG0VGoNlYr4iF0D9KNMCnsw7f0v3j4h2IE8lD136CPdlg75EVQk1Fg13S+vsL17LL/oxif
 hpqDdr+NtI54MnPtDxtaD3+W4L0bSUHiHqP5U+cF8mzvRfeFCXpCIkFO+fXbKVz367j9/AVvZ
 dC7Sen051PwN7or7VwErqEtXWqkXR6H4VImy4wbS2Q/ue2hCv0fZV1llOiSnF5QSlvG7XocnD
 Lee8OaiZUStNDvqp2G4Bi2LWlmZLOtpmZaImrSXFUp+b4BlyAYLV89ojPR1nZXY2pKTLiD2m7
 1+6MCZLh7AVS9U0nyxvfMW1vkAIaXyl9/7uqhy0D4hoQ0GLiVKhC5Y6/hpa5Cq2yF0UCtEG4s
 kFT2VcLVZCbzMtCt05Db2QE+O6QvR75DHmUnzx10VuCq2Vgu2x3p5TNU7jNuy8aDkDn2lBVkF
 53jV10dDOSEvVRhd9VneJHH99F6U+oqdGPr8oJpA+HvGdi7juoapBKNor6RamtvZqX46fCaYF
 EOOQs3ROCwTEAVln8QgicVRDdBPwnB5NhlMRQvT/pRuZgYxlnrQt99kHqeNTRHa3rws5I6TCg
 qALESZOxdK49vm8sxSWvg0buhtSKpBnCa0JnAYhw6IetQDXE4A75Lc22OZ3vmqp2NnhtwfxiU
 1W+WzJtp9hWoL2ErgPTGyBF26ndHbqqfqUkyFHRr+L1C3nHY3VHisSnwvSOIvcugghFpsONuz
 xAT0zxJz2L03N9YoXltceTongcE372e44XXPTxUDC6e9yR3x0FSfsAYey7KgQDK7K7kirC7cv
 DNSFu2Bx5ofhUp5OT/usYCy0y9dtTSXi73AlaPv0TGxzi4dPTR/2LFrS4twEb2VawKoHaBkta
 cqeVorXSFYTiD0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Nov 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Carlo Arenas <carenas@gmail.com> writes:
> >
> >> On Mon, Nov 22, 2021 at 9:27 AM Junio C Hamano <gitster@pobox.com> wr=
ote:
> >>
> >>> I had an impression that it was claimed that without this, the other
> >>> weatherbaloon for "for (type var=3D..." would not fly in some of the
> >>> jobs we have at CI?
> >>
> >> It wouldn't if we have a CI job that tests with gcc < 5 but the last
> >> version of that job died with travis-ci.org
> >
> > I was wondering how Dscho's test was not failing, and that is an
> > easy answer to that question ;-)
> >
> > If we wanted to resurrect that CI job, we can always add it in the
> > CI definition anyway, so I am OK with that, too.
>
> But if we were to do so, perhaps we'd want something like what I
> gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
> its place to avoid confusing people.

That sounds like a good course of action to me.

Please note that the MSVC-related adjustment of the `FLEX_ARRAY` block is
still needed, I think.

Ciao,
Dscho

P.S.: In case it was not clear yet, I am in favor of going forward with
the C99 weather balloon. We should try to move in that direction, slowly
and gently, as is our custom.
