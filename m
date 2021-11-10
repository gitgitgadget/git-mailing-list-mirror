Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05970C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D507B6115B
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJMmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:42:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:45729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhKJMms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636547985;
        bh=HV0oS4j6wMuBaDHBhVGxeBewpVwSmipARSmOcIslKQ4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J5MK/xk9iYjp5zRudKcfLxrldbp1C9yACiLDF4h/wRbee7tax7lmVqSCksySjNpZ0
         Pf/ESC03ODRyLp6EGxc5RN0U5VuoOXpSYhdGX96QElEz5YIJ5HQaQM96MY8QegZG1j
         XbiMWQAVJcSd7qGR60xtwIrDkqpp9jRvsm9LnBm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1mt0Mt2WB8-009Qng; Wed, 10
 Nov 2021 13:39:45 +0100
Date:   Wed, 10 Nov 2021 13:39:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
In-Reply-To: <xmqqtugl102l.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111101332130.21127@tvgsbejvaqbjf.bet>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>        <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>        <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>        <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
        <211106.86tugpfikn.gmgdl@evledraar.gmail.com>        <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com> <xmqqtugl102l.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IC4dBM+lLBofJpABjc8IUkYxIQpgpHfdWgKoKgqac5/kr+VwDGB
 vXjG7z05GAdDzoBYozPzLBc1r5hV7DyUAS1SJKF8etMLzrXJMX0cr/R+ThgwvfFZG7n2SUi
 cUG8plS4QnAk+7XBJ+bWUFdaqSMBx0GmTrpe1nw3MsXtKEM5AWgIcm3dtS7Hjq9mfToZPiC
 DT0a6NSbl29AbwWSHNxkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9FTne9CPTA=:0+Ugw1x/gsjJe+Fg+x8trw
 GkbNSFj4Hc3dE8ZTQNrgvU0ryFOfmY86qeE6TaA8JYL4bvt+G7zxoAhJhYp6DvQWSQf/NZipE
 pOnQnw4b3xoptM34CLTA2gG5yGq2q4HNJ8KJOt5ehdt7O3/HnYQRXqy+LzArIAEWcf/PZw4tQ
 kheb6QUD4bB3PraIYQRiFHudSWNn0j+6B8KyQdVAj4Ds3XJzCeFEJ/cf0T9KSFFrooAQ528+w
 sSfitWvjETHOTlHiAoS+czU8cFsUhK90YXhNM9cb8X+kERLoDkN7SyUVxK+SM/xsTxs9TlhHF
 lNuaUSGTYp3lrcvMESFZhFMZL9HbD7mHlQx4jNwRN+I/6+nEyoHvEai/dUjUlOtr4mukw5nTN
 790hLomLd3OMjoetwkexfZ5YNGK2hhyoP72n8Lclt13mm4WXxiBFzm0j4tfUyPIkSaMQM5+xE
 NKLRc6T+/Vl/5H4Ysn/tX++b6mhCfUi1UK1nsW1ax+FUYkBo0AFHe1QLpoLeFiU24orJ3gPHe
 GXfnI8jihYOVacvvuXMJtvrY5tWEyYHlC1NiB1fnb5g+IZ+FItyx/jwnDVVWy8feas3O8Chat
 EymgF3+7ifGwomyXabW5PRycOqlkloiVktRyo7eOz/WNZpPvfNS+f0aRmaXxcynuuobTnH2jA
 NLKq1H+OzoK8ypWGHDjKUcAeW7ZoGJv8yL3o4EIOoS8dHMSZcoLDTcHmR3u2Vev3gh7bX3+ZO
 fEZQ+WswmdioiQ2G2yZlaZLAIoyONqOTqmDqUoHUksiHQvaPLRYDNnW/YCjAKzIG4d9d+WO00
 RsZueX/oW4kafoQusR7cMJpGRmjqMm9m8fHLPGgWJ950vrWXk6bqznRnmZBBqN+7KUoeBBS7K
 ELEKM2cGdNjxaKqWBQByNZ6gsE7ZRQMvOoUFiwUdrm/SzU1i7E2sU5JfDd/09DzwEc/dCCBHa
 UuudxPJHCoEXFzgaov8F0zaFmZIvtEeOAK/NmtNLc797oIiYbGaAwfgxIpgSkvEayd4z0+mb1
 Q/xpcVvb+Lp/YOOxeXbZz3sBsyEnXeKvIIafB5XarysWxwLxksuCvSrEsBacidpPyp1CtnXnw
 dKmCR8iCgHw2OU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Nov 2021, Junio C Hamano wrote:

> Allowing to be sloppy while maintaining Makefile feels like a false
> economy, and having to paper it over by adding exceptions and
> forcing developers to learn such ad-hoc rules even more so.

If you ever needed another opinion to back you up on this: I fully agree.

> If we could use "git ls-files" consistently, that may make it
> somewhat safer; you'd at least need to "git add" a new file before
> it gets into the picture.  But it would be impossible, because we
> need to be able to bootstrap Git from a tarball extract.

Indeed, the ability to build from a `.tar` extract is important. That's
why we were careful to use `ls-files` in `LIB_H` and in
`FIND_SOURCE_FILE`, falling back on using `find` if the `ls-files` call
failed.

And to be honest, even `LIB_H` and `FIND_SOURCE_FILE` would quite
potentially better be hard-coded (with a CI check to ensure that they're
up to date).

Ciao,
Dscho
