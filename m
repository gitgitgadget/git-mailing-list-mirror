Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097CF1FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdEaSrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:47:01 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33480 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaSq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:46:59 -0400
Received: by mail-io0-f177.google.com with SMTP id p24so21588733ioi.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRAmClO6t2IAdIduI1TrZYr+t9A9ePaIEzQb8BHifZ0=;
        b=a1tt4vijHJo45/pKYAdB2yB912kf/RikWVz4e0bj/PgCG02pd6Kp2bp7H+gS5bgueg
         8E2mhWtMIpAZitSRv9vJuIZfCb9wVtHAHfQW7vrsvSYn9CR2jQS7CuSworiXTP6aQlWe
         izxfYh0bjtJLVtyEZPGdGmqF6QvPfXRckt1Ny6/Xf6AbdTlmW9X9l6ooqQN0nHAE2BmF
         rCXvTF402k8waYkcXbBzFsvZ7hxi/bkGnEsnKhkjy+3Y5f0luFSq38a184Ll2wOE6fzF
         +NCwimNiERFc/zCUprDQcecKsXj6I9q6kZXlFPD0lrvWsw48Wm6MyFUwL/eqIF78nkLK
         AzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRAmClO6t2IAdIduI1TrZYr+t9A9ePaIEzQb8BHifZ0=;
        b=XklZh2HvFTqvvkZvE8yWJyDzFWd7UXX8Og9dyxoE+uYQVrLbdJulQTBX5rO7G+xnwo
         PSBga2PaW9bpzmr0aRvyadBEFVEXdmzPBtQTZYgeSDPnnBOERptC+ip2TFczjURYIXy1
         YwUzJGRdwuYaoYaxqgC43KFUC02i+RlR3xPf2qThoNAW1DDXZ4PfpSe8QHyYvhN77t0o
         ft47s5ekOxk0MIjSsTuR8AnUdeaU8tKtgqtyRd8mGWkA3OsHdB0SPlUAoJkwnnAnAVQn
         +UTFXG9sH08ZeFQD9xDNWDmVb3P5T6ONs8sW1k1aWRillzBmpjUBPgmwRpdwUFJwjh4n
         qsfQ==
X-Gm-Message-State: AODbwcA/5abZP2+4XQSR9wD+BZKKkBG45JeAdjedHkU7QM9a9b2Z3LLQ
        tEEBmuPO5KFEgbU3c0wK9q3jtcMvIA==
X-Received: by 10.107.178.12 with SMTP id b12mr22774627iof.50.1496256418967;
 Wed, 31 May 2017 11:46:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 11:46:38 -0700 (PDT)
In-Reply-To: <CACBZZX6h1qEC5Drt0LzNLh=_ZXFTHjGCa=DDbhLUMtK9KjPjCg@mail.gmail.com>
References: <cover.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031508.24838-1-liambeguin@gmail.com> <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
 <alpine.DEB.2.21.1.1705291247000.3610@virtualbox> <CACBZZX4avOKJjWVSBSewNFMWyRj3FzHC2Onw3aWLf1F_MYi+Gg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705301635440.3610@virtualbox> <CACBZZX6h1qEC5Drt0LzNLh=_ZXFTHjGCa=DDbhLUMtK9KjPjCg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 20:46:38 +0200
Message-ID: <CACBZZX5tyWY0k6m=7HcZJZanDmrzAQX+3mVDQx-jzqV_Wr_tMQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase -i
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:22 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, May 30, 2017 at 5:44 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> pu does not build for me:
>>
>> 2017-05-30T11:38:50.0089681Z libgit.a(grep.o): In function `pcre1match':
>> 2017-05-30T11:38:50.0289250Z .../grep.c:411: undefined reference to `__i=
mp_pcre_jit_exec'
>> 2017-05-30T11:38:50.0329160Z collect2.exe: error: ld returned 1 exit
>> status
>
> Ouch, looks like I've missed some spot in my pcre1 jit series. What's
> the PCRE version you have? This is somehow doing the wrong thing with
> this bit in grep.h:
>
>     #include <pcre.h>
>     #ifdef PCRE_CONFIG_JIT
>     #if PCRE_MAJOR >=3D 8 && PCRE_MINOR >=3D 32
>     #define GIT_PCRE1_USE_JIT
>     [...]

I've found what the problem is myself. I'll submit a new version of
the series that fixes this.
