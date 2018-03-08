Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB201F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbeCHXMP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:12:15 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38163 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHXMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:12:14 -0500
Received: by mail-wr0-f196.google.com with SMTP id n7so7311250wrn.5
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A6h0Pppi9ctCQOg7aqZAJKe4lsJFAh6Ofgi/UMC2x3Y=;
        b=P6BjfO3uEAV8Tz45qYp6gYGMqPTD5L/B4GXi8RH8ShkLbqWoqyBNIhteH4/7SSxOt9
         vDZKoR55N7ynfoy9yUJt/Obp+kcoeBDNIKiwxrMgNnBS86d1R0kv41vb42TiW2dnF/ZP
         08xhm/usuEPQJ4D5qSGWkIt7eASuNuYluv9s3Cf7VygA6hGRnlyPSwbtBHngTO974qbY
         hK/DAcuRzYC31xMvqnbiNnmoIho9BzUXJXAQjLKmrBu7OAaHnlwncpm527BD6ED2lG/z
         4hNQOWIQMyoeiE1wHijDmw5Yzfkypj5rwPVoU6sv2F+Ok4Ctw69JAKeYiQdgD8OIzkvQ
         pGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A6h0Pppi9ctCQOg7aqZAJKe4lsJFAh6Ofgi/UMC2x3Y=;
        b=jp52JUkEUyHwFudsIoMGlCIjQGT0Q33BgmQg4TQfST7X4MRCbcXngnBY3BKO/i52H8
         gmDpnts9uBwiDylnZi66PY6Nmc6iDh6VTu/+AACoKgCX1HBEimgCRz5RWlvVQUDWkDHY
         rbFqabOolFn1XESZt2Cl0HxfFKdwRxqzRpnHu4c/6V0XLm2GWvLPsHquSYK6EIei9PwE
         4PpqbElIBzJqXtEF00h+I9xO3HsgedHoyVBrRoddFLqIVqg97rCDE+9LqG2VKCCL+e5r
         DewhrBR4fbvZj7AATOTcsaYKtXvF77J15ntkC/KnCFy1JnHjSg3K5U1mSDPpZscNdmJJ
         D0nQ==
X-Gm-Message-State: APf1xPArAkdj+6TM8d/PtJCKMiyy/JshN1Fpp8mVepqNswEM3pqfRJyh
        brXrAcF/fAeCYP+J9Hn3X40=
X-Google-Smtp-Source: AG47ELtAdquMnCyMFIb+8YmQpurQL7Qma8cMdF6bZ36SdCwJ/Y8xi0q4fZElm6WqEjuKjap+0EnBiQ==
X-Received: by 10.223.143.101 with SMTP id p92mr23558316wrb.241.1520550733178;
        Thu, 08 Mar 2018 15:12:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s125sm2093wmf.4.2018.03.08.15.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 15:12:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     lars.schneider@autodesk.com,
        Git Mailing List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-4-lars.schneider@autodesk.com>
        <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com>
Date:   Thu, 08 Mar 2018 15:12:11 -0800
In-Reply-To: <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 8 Mar 2018 07:31:52 +0700")
Message-ID: <xmqq4llq88ms.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>  extern int starts_with(const char *str, const char *prefix);
>> +extern int startscase_with(const char *str, const char *prefix);
>
> This name is a bit hard to read. Boost [1] goes with istarts_with. I
> wonder if it's better. If not I guess either starts_with_case or
> starts_case_with will improve readability.

starts_with_case() sounds quite strange even though
starts_with_icase() may make it clear that it is "a variant of
starts_with() function that ignores case".  I dunno.
dir.c::cmp_icase() takes the _icase suffix for not quite the way
that is consistent with that understanding, though.

