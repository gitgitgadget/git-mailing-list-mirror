Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8588C1F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeCRJYb (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:24:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46446 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbeCRJY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:24:29 -0400
Received: by mail-qk0-f195.google.com with SMTP id o184so15387476qkd.13
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hjWTa0fopDCOijjUswONAqW40Fow/JA0lk/MndKneq0=;
        b=j528fLaeVOw2UQS4j6RAnqyl6Ri6j93YyFhDkBdl1ExXItom4RaVUFacvCqLIjg7w8
         x2NKwOZU1uIuUeNnbg/4tDZil4I5kKN8QX/KUz/bi3E/HmaWG3219znoWVW7vG7guCOz
         M0qBsU2vyAkQT2C4yLaflfQyhhKJv93ZTAztuHbcsthQbKSnzz9qRjt4Ca4HWDwsb8+e
         9dW4NI7mfMn+ZSrYBFSeXA8Lv4Lfy6YQwIDi0poIzQWNmK6z+uphCxgMzMPZH8gPwaWh
         91zqaMbvMsS2zxcCFpIo5//Fc2Haw6N7Eav48ZCNM5/UeEolSisNprv8cFtLJWa38OD3
         dt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hjWTa0fopDCOijjUswONAqW40Fow/JA0lk/MndKneq0=;
        b=cVjNgTrMxjc6jstz7ykAq1uvNA1grcFHqkXTn64D8gxyfSvG8PyNITtUE+VdpRgaF2
         FJsdYHg5d+tZpeYQxYRvBRpPuk88evbuR9TlwDkBAzoS7J4ACmPS9lBrZjLzi6EBiJUF
         SSf/Sliac2SMgvq3j2Oyd4hehVFcl6GCyf+DaOrrtIXClUrW39HtHuJA6hkYIqDnO79K
         3EIYJsotTM50dmk+SisrovpMlwgC5tPnqv007WpoycfeOUD8Lcl1B6LKm9kuG2lFP6/P
         asrbTJpfol0ky2dLPBdeIBbGu/vW2HKKxd7wgxaElBaxfdJhrU7DnBP3bxv0JBv2O85x
         31kQ==
X-Gm-Message-State: AElRT7GDOETiTja5gtO9N0k/j2zqvV+iGdWgnraaVXdaJhtfZvazLSi0
        aSDvhjYwBQgi+1hepdX0npRj/lCGV1wP6CNFPDM=
X-Google-Smtp-Source: AG47ELsaA/LLEtKcTXoIYd/SLQRf2KizuPCPX4T9LSB4icdVM6QYocz+HgnjwUAdcwJV/vc5Z2EPOUHSLYTIUCS0AYo=
X-Received: by 10.55.120.66 with SMTP id t63mr11825491qkc.42.1521365069119;
 Sun, 18 Mar 2018 02:24:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 02:24:28 -0700 (PDT)
In-Reply-To: <CACsJy8BGZV1hHKNzDaFkt=9zfhzv+GR1JUN-fOcQRk_2+tctZA@mail.gmail.com>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
 <20180318090607.GA26226@flurp.local> <CACsJy8BGZV1hHKNzDaFkt=9zfhzv+GR1JUN-fOcQRk_2+tctZA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 05:24:28 -0400
X-Google-Sender-Auth: YXJbg_KBGH3fOcVAZjNTRvEjCiE
Message-ID: <CAPig+cQoU9pYwp==NyQKj_JYZqHqx3LzqSmQ90d3wmMUZ0qA8g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 5:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Mar 18, 2018 at 10:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On MacOS, "cc -v" output is:
>> --- >8 ---
>> Apple LLVM version 9.0.0 (clang-900.0.39.2)
>> Target: x86_64-apple-darwin16.7.0
>> Thread model: posix
>> InstalledDir: ...
>> --- >8 ---
>
> Does it still build ok for you with your changes squashed in? I think
> the check for clang4/gcc6 and setting -Wextra in config.mak.dev may
> backfire because clang9 probably has a lot more warnings enabled and
> some of them we don't want and cause compile error...

The project does still compile cleanly for me. (And I used "make V=1"
to verify that the new flags are used.)
