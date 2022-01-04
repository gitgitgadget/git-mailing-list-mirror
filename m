Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382AEC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiADMYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:24:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:54783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbiADMYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641299041;
        bh=99ippNSGe6QMQfBO688DEcfNAQmYEzwgmDmTNKky1b8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AM0bxbmC0ZA14uw65c9fPZ4aG8XNZ9THIejfQS9Hjae/NsZhkser6lteZ8LpZR82E
         QZSBu6+fbwRJWeDOGre0c5070Z1fdaOX5JKLCPjQpJ0vt4BrLMf5fdPbXz2j5m8pYS
         6NNf7lBYBle5ib1OF+BEs8EZKvg2fdE0uG40sTvQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1mYgMV3fzv-00cUcH; Tue, 04
 Jan 2022 13:24:00 +0100
Date:   Tue, 4 Jan 2022 13:23:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jl/subtree-check-parents-argument-passing-fix, was Re: What's cooking
 in git.git (Jan 2022, #01; Mon, 3)
In-Reply-To: <xmqqsfu4duxl.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201041322090.7076@tvgsbejvaqbjf.bet>
References: <xmqqsfu4duxl.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ObH25lbtF8PTlbo2cPrSZOyJcu9FDz6hk/NJWdXCs7tJRPHJyRk
 Ngn6ipqeG8zP/BwTydu8QQu9odkNiYw8gO4mkdLHyj1MUxsstOY/SOAcBdDrghJ0XxoX4GT
 /4/bw9UfvaewGRDN/n9CBaBbBEbKSmH1bYYwLnqWjGkpo8ERWFBgqhXqFfu5mVQ+t9JS/3z
 UVzXja+P4+TyQ/TwEkAZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSdzjg66qJg=:foSDs87LI7KzmY2Wm2vdQJ
 2uAAwPL6KLSSOaGCdE+FtgGZis9NYE5TNId2UojEYHo5fA4Q3sa78VVXIvRlyf5SCi79G+KH/
 UF8X1EbBlY5t3qhEODf6bxA7cwrlhV6fZRh5DzCE9/+dtfmsMAtXamVzzEfhFLR965k/7z7/1
 UMWscpHFNROT1ncFjwdH4cIMohC7AuVkluVdOPskAbLga++DVALaHMvnNXXyhiURwEfphb58h
 ZFgMfSOwnuI9IMQV4xSNvz67OOBtqtf0QnycEUDsB7ff8VvnRXXk5UmI3jXrsxqrOc8IuXS2D
 MD3TtKlEWPCKRe84VgRdh8fLWMMMPCfcDvUy+MK1rOfzrRXnjgG/rWR8ECsjvECrCm4IgTGFP
 kSlveR+as6qY3HrNW6umSUvU92GctOZ51gnUvTbu3lMTeXxXLOm8saqXXvgmdlv+WXlzn1rV0
 WxoLEMwRisgajrSjOBi/+nOaxnGhCeCgIklia9uMBXsc1xjfZrWNOl6NBI9eOdoGG9Lre8Ae6
 IsIYMuFPoB7q4XNcAn3J1RJ0ci+cJXvCiKxS4nYa0+X0an9iUQKue5YfuC6vl1iBqy+UxP5lW
 KJWttGj6lJm2GGMNhCAbwG9Vlu6pYhc71e69VqKs7lcYJ0JfMkPteslv5oSgksQOCG979GJUT
 CFqd/PoJuxZizrbDTQ+pVeA8tGkpuF7Cd4+dZXeURV2/kwVbPkOqfEU7uAlLnUxIj+1X+JLYB
 sfUYS5UKvGiIqINveP7bWgzP4YEOW3oJdN5Ykxv748waj4QtdA/svNGPuBG3dsQ5/HwzBpC8M
 U+1yD675nlTz1U7zJaHvt6ckNizrAMdtNVZXRqlBZcMqAZKIgh686ti7PdA8WPaAdjv0+tlzC
 kdxpEGP0Nblpsfjevkla6oe5/ikULafPGAgg1KOPKXhEdKyMpuAj+SQRdkD1T48ExEunrE9Es
 /CjHLpkinkTKxjOzXOiSBXTtJgvdk5wvi8c+Ttp/vSM1UhKJ+HAe6r6JAVwsQ461Qg9xEkgQn
 l8lJL5hZHZ6ArxyzAJGJX9GD7vA/uRUICv8BrY7rZDuCX7gnqes/T9zySr6jpDT3KSRXOCANy
 yR3H3+py4b8MGs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 3 Jan 2022, Junio C Hamano wrote:

> * jl/subtree-check-parents-argument-passing-fix (2021-12-05) 1 commit
>  - subtree: fix argument handling in check_parents
>
>  Fix performance-releated bug in "git subtree" (in contrib/).
>
>  Expecting a reroll.
>  cf. <nycvar.QRO.7.76.6.2112072243310.90@tvgsbejvaqbjf.bet>
>  source: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>

James sent a v4 already four weeks ago, I just did not find time to look
at it yet, before today. I offered my thumbs-up in the thread, and now I
am offering it here, too: this patch is ready for prime time.

Ciao,
Dscho
