Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CFE200B9
	for <e@80x24.org>; Sat,  5 May 2018 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbeEEGPf (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 02:15:35 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:44397 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeEEGPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 02:15:34 -0400
Received: by mail-oi0-f54.google.com with SMTP id e80-v6so20989479oig.11
        for <git@vger.kernel.org>; Fri, 04 May 2018 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i5H6X+khK7jQqWP4QxSMU9Xn9hfArPF8XHnM1gtE+i0=;
        b=EWT6avW7Iix5b1V+i/SnzDg6YxEJTwhVpcrlvxOWTJiJbsDSfEzS+OY8ASRMR78+OQ
         8RcooLOz6GBfc1+RHY3aCAXw18S9vTSrO+a3rqVukA9sUtJwCK30TYt3bf+8TjpB4grL
         ZQguZ1Tj8XgChXOMhe/sEuLr0fnFjFVvib3jbqTvwjnSms6uAVqeMb5xRQW3zYg19bT7
         anhyzl2krOydwb1WJY/u+7pMVIp3YH6fk0jE+ebyw4w/7DQo1LJ1hELgQbaUFOMJydrm
         Ag1lc50c+KLqRS+IuN2mANBFzEX+Ml/29jC1OElpmMJoiKnbAX1hUQjPkAsKqpQTiYbb
         /Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i5H6X+khK7jQqWP4QxSMU9Xn9hfArPF8XHnM1gtE+i0=;
        b=aKCCIXl0EfQ+A+loZql8MdhJI5n3j9yA2ASEynNK60Ns3b5lycynhvLYSaFJNlv1bl
         3oEVsFv/fPrWJe60KeHOtpBVuB3vPTFqeVk5brFQb62jUEkB3+FruppDWgSMM99Ubutf
         8W1yfcH+EWU9M83kL5lnag8GG27IrdsM2j4Eoh7TItC/Q7UFPRD102KU+cn+BrCtbZIH
         CR9NN6X4EqdPodErAYmYV6O8Xa42FeqY6gPjvE5vud/XOdioZNA8QsbwFz4YX42MzsKF
         oB0h9/k2IzykJmW8r9AVMH0RcfuXr4VeJihJWHgZoUb8c7cVJXLWHeUyO84RDiOrR10X
         nyNg==
X-Gm-Message-State: ALQs6tDrMMpfSfoaJUNpAq922yTtaCWx+VpkL4BqPd9Tljwz1fXG4iAi
        U+r7tTEVFQ1BL9e6E6p18zYwih3+lk71VaZEn74=
X-Google-Smtp-Source: AB8JxZqhsbpG5noWKMCTaDGQcMb9PD6dQ51s4LvcLbqpIBDssmekTTWMbzPMaWPL3h3TNxozlMbtj/LlDqqe71lxUys=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr19328363oii.216.1525500933708;
 Fri, 04 May 2018 23:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 4 May 2018 23:15:03 -0700 (PDT)
In-Reply-To: <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1525488108.git.me@ttaylorr.com>
 <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 5 May 2018 08:15:03 +0200
Message-ID: <CACsJy8BdJ0=gWZQVfSqy-vjtZVT4uZNzRaPYxRYxx2WNzaLodw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 4:43 AM, Taylor Blau <me@ttaylorr.com> wrote:
> Teach 'git-grep(1)' a new option, '--column', to show the column
> number of the first match on a non-context line.

Why? Or put it another way, what is this option used for? Only
git-jump? (which should also be mentioned here if true)

>
> For example:
>
>   $ git grep -n --column foo | head -n3
>   .clang-format:51:14:# myFunction(foo, bar, baz);
>   .clang-format:64:7:# int foo();
>   .clang-format:75:8:# void foo()
>
-- 
Duy
