Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1241F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCRJhT (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:37:19 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:43662 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeCRJhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:37:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id g184so15416808qkd.10
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9bGGjru9MwSO61rAkey2TT/D8EUCnLiyf0XcAeJEqB8=;
        b=niW879KJliHa3LwnUaidp7fY6NlaUMI3EEbfBVYtl2u9eC8IWLUUBehb8Pn4ScD4zW
         QxdF6HszeO0QGj5qe8HdKoQ3zOIs0wJ0gchwyRZyGyRc3iIq8FGVU9GCVwHg5lA7upjZ
         +86PmtznUw1XJcQPKaGC9zb6fAfXVNTkMh0Uc30w4LcfXU74ts4tAFM28gjunm/CfoR4
         lbfjmvfC3S81UE07CItfSeDowiEyyTr16tSIq+abAzftPhB6nvnbkrB/Goub847jaxZb
         R8j27VP9r/bC+ySvt4CPwnAOcMEJJK4CfmLJSRQLLtj3uMsEBL0S7oCmj4Q+80Ih698+
         w8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9bGGjru9MwSO61rAkey2TT/D8EUCnLiyf0XcAeJEqB8=;
        b=ajFfh4ke7S0tV8/3S7bGq4fDaH9rn1GJ6V/BxYuG7hvX5SJTyTHuJsP3yixkYTLBxW
         IwMd/4c4v38nFCse5kheJlYOvA67wFGsHbAupFahL/E3fz5RHvT3te8sZCdYJmXWe1go
         zOMO8zN14hinluZvVB71W/lf7eh6zCJwlJYyYnC9D/R/DawKJQ6Cn6UgWQZQKKX2pvYb
         9KMpIgRojbqRQ/ql6dY/o8JWU05/kxprvQRoRqbQG4Xw6cWRif9EO2U7Kokhp6I70+bc
         d2KQoozqBHO6++kW1a47rLA/Ryx0rj9zBJ4xTPJpvcR4JwdqNopzLMf0uxbX4xhs5HuD
         qCaw==
X-Gm-Message-State: AElRT7EgSOnfqTR0qfhF9UsBE7ydRFRz7ART3iuPhQ2wJOCtlNptrfqt
        zbygSlLCcwJICirmUFKNeCD9laRmaL2t5cIpKJE=
X-Google-Smtp-Source: AG47ELvhpwa8II7pfEHllNmq5lguJzB/KfTCoEi5vMcYaEAI4VdmZRMTgvLLJF6E1a917xykkqdttpPOYOuVLMJuJjg=
X-Received: by 10.55.156.79 with SMTP id f76mr11785231qke.36.1521365837906;
 Sun, 18 Mar 2018 02:37:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 02:37:17 -0700 (PDT)
In-Reply-To: <20180318092825.GC29208@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
 <20180318090607.GA26226@flurp.local> <20180318092825.GC29208@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 05:37:17 -0400
X-Google-Sender-Auth: 96gFjpPwuOD3VHaB8zJ8Uq4Z0Y0
Message-ID: <CAPig+cRQXQ_DowS2Dsc1x3TAGJjnWig7P4eYS4kQ+C2piAdSWA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 5:28 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 18, 2018 at 05:06:07AM -0400, Eric Sunshine wrote:
>> On MacOS, "cc -v" output is:
>> --- >8 ---
>> Apple LLVM version 9.0.0 (clang-900.0.39.2)
>> Target: x86_64-apple-darwin16.7.0
>> Thread model: posix
>> InstalledDir: ...
>> --- >8 ---
>
> Is that really way ahead of the clang releases (which are at 7.0,
> AFAIK), or do they use a totally different number scheme?

I have no idea, but from past experience with Apple, I'd guess that
the version number is an Apple invention.

{...goes and researches a bit...}

Indeed, there doesn't seem to be any correlation between what Apple
reports and the actual clang version number[1].

[1]: https://stackoverflow.com/questions/33603027/get-apple-clang-version-and-corresponding-upstream-llvm-version
