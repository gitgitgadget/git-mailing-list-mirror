Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D8E200B9
	for <e@80x24.org>; Mon,  7 May 2018 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeEGSir (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 14:38:47 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44213 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeEGSiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 14:38:46 -0400
Received: by mail-vk0-f68.google.com with SMTP id x66-v6so13518589vka.11
        for <git@vger.kernel.org>; Mon, 07 May 2018 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vZ59xrL4Y5cS+Tzw/xs6v9uKB0eSgddRd0TbXdrsyLI=;
        b=gWcFkFS9A0u0mkIlVMz6v/2+qvdtFIX5TLJbaWUuOv9HNIt8nqwhFMc2lw+6RqkFyx
         Xv2/S6x2Ram3I0vkluXgNGGia7EOoQNkp8g43nZUPI9u9PAbhET+rv6L4t77ZlKZg046
         B9b6oL0gZy70IlpO0NN/lF0rLCoZmaBkLlxlpr095+bYLGh6DhKqGDQWZ0V7gBxnbbzv
         7OFXumWXmWRTNeERXcQryjlbsT/4/m1dn2LxaFn4+4z8FLIv/ioeE35KP6MZ2u9yJf+Q
         wXWyr7BQbUotsIxeUC0JQeyHT1vQPv+riOeg1OjuNfItWtDglgIhJ9/8PtCFUlHfB+5v
         TvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vZ59xrL4Y5cS+Tzw/xs6v9uKB0eSgddRd0TbXdrsyLI=;
        b=ufyR+bDDY1L+gD5DPYF0r1xNos6FuB71xE7O9IlkdF44p5MpLQ0ItfOeBg6b6LBmBX
         bWbCWWrhhbPL/uJPFVs3CbdYfFzRiTcCBcHFgOe3s6T5pSGLj1QPl+ObaXtKV9Re6KZY
         2+VcXiN9L5lxRbQWw7sYVKNo/noe8MZQYTrIaCmR3487NKjwz5MHka6tPoEJfPDmc3Cx
         BB14dvbywX+PguYM2Rezx30puIGmVOfCc69MowVQus3GQqIJ/9cv+eEbJb1e+qM0SszG
         jPJnEVUFVIlUMaEnVBPBcUU7lxJ+k0fwAB8fULyHjZ07zTUN9LpZZNPMTHBIjfAh5+Sn
         267w==
X-Gm-Message-State: ALQs6tC5EPVVphXS97zaJQPjufGWfTexnxSAKfAB7b4RWPQaW2WzrjdN
        rfvqOghZhU9+Lfywe1pF/BVSWSgDj19SFzGBKhUV4g==
X-Google-Smtp-Source: AB8JxZp8roSqv878EDFGiTqj2qhkp+3DWsZekaajwHcY5kGwO8WKxRIIOELS/uaD+wYTZN/B0VxbCci87FUOt0bcVYA=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr31951576vkf.76.1525718325366;
 Mon, 07 May 2018 11:38:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 7 May 2018 11:38:44 -0700 (PDT)
In-Reply-To: <20180507175007.30381-1-szeder.dev@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805052141550.77@tvgsbejvaqbjf.bet> <CABPp-BFQ2y1-FuA1wwnvFefjTFxunM4qeFke6icc5vAPs7k8GQ@mail.gmail.com>
 <20180507175007.30381-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 May 2018 11:38:44 -0700
Message-ID: <CABPp-BGGmQsy-MD=0qX1FTj0d5-j-cocz6HCUXWzC4gnW1k9NA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 7, 2018 at 10:50 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> 2) Your completion commands for branch-diff will only complete one
>> revision range, not two.  e.g.
>>     git branch-diff origin/master..my-topic@{2} origin/master..my-top<ta=
b>
>> won't complete "my-topic" as I'd expect.
>
> It does complete two revision ranges, but if you want to look at
> reflogs, then you must escape the opening curly brace.  I'm not sure
> why, but apparently after the unescaped '{' Bash thinks that it's a
> new command, and doesn't even call our completion functions anymore.
> It's not specific to the completion of 'branch-diff', or even to our
> completion script.  I don't think we can do anything about it.

Ah, indeed.  Thanks for the pointer.
