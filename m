Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65501F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeAEVug (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:50:36 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:40460 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbeAEVuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:50:35 -0500
Received: by mail-oi0-f43.google.com with SMTP id w125so3972075oie.7
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=kinN8iurUszCR8SeOGIfMYYUmaZWBA3BWqZZP1TBAls=;
        b=NL9g4NXurPABvKwEooszMieA/amxjBuF6tgY6B1k7hw4E2c8Yec/wJBWVWkBJWlTpf
         pgyDePJSWRVXAk0k2vBEQD6EdnDMOPnbXcyrTuxPk/cZ7KwcRr8q2WUJbO/MANAw6U5L
         7oRxkEGNuLGh8B/x9YU7jsCXvbZxZZCAnxKT1ofc8/A2mPesaYkpmhD4mkgdfGAQCweI
         1PWZUMIH1msJ7QZcLlgQM4rwFTE/5oxBRh0NhzJ5IWQU4TP7OUbC2Fsh3JJLKP46FF7M
         8ImJiZo9EHPB77IauczFyFvOpdrMcghdXok/0KzUVWQWQFisNAvE80QRiOBapA1IKZP0
         x+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=kinN8iurUszCR8SeOGIfMYYUmaZWBA3BWqZZP1TBAls=;
        b=U2mLzOmwcSpNSgYiHtZHxYQoMIeSofkW2sr2K+cNDr9O/I98uxxrbIsQf2/vWQlyhX
         kPSiBBpdS3QBCSMIENrN6oJEM8/w+IMXeD1YQgjTUOFhq5QZQSEL2+fI803qS/Y61+Dn
         c7waEJ1ysnilvXEhDgLGfd1Q65CPy9VlFiEjZfSmT8i9S1GE8AkD29or6kJuwSlPXfTY
         m3CRgONDtEb0x9XankfPmxJts2C1aGkQR0wzCGvcPTmyD6g7tbaz1t5Lox9XRQZmJaan
         e3O9pqt96kExpxE8lE8wxNUaUhpvmCsYmvYTv2fBuCPbrGJe2m13QcmIHwNpmUAVAKYw
         o6kg==
X-Gm-Message-State: AKGB3mJP7T1Zw3IZ3HD2rJTEs8hnUFnt7zypMCZfWz3a47zUEhOaXtY1
        ufbHyYMykkcYWTJOgWkhC+kCRW+KaBivbB6JWU9KbQ==
X-Google-Smtp-Source: ACJfBouAZbKnQm3Wd4piTaeyAp03OhFr0pHzGRDEcbcOgC5rEIDjLyKnRPYc6D9R/7B+tBp+/mm0gaBxNYIQBeQwYIg=
X-Received: by 10.202.175.209 with SMTP id y200mr2217503oie.148.1515189035076;
 Fri, 05 Jan 2018 13:50:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.32.133 with HTTP; Fri, 5 Jan 2018 13:50:34 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801052240440.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012254380.6482@virtualbox> <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com>
 <CAKbB5OxFTycBVhzyow9Op2M=HcBWKhLEii-putehS0ONNw=W=A@mail.gmail.com> <nycvar.QRO.7.76.6.1801052240440.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
From:   Matthew Orres <matthew.orres@gmail.com>
Date:   Fri, 5 Jan 2018 16:50:34 -0500
Message-ID: <CAKbB5OwoO22vA3r9J9WAgzxGGScyDE7xM+msGCU_qn2XHU+nbQ@mail.gmail.com>
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
To:     Johannes Schindelin <schindelin@wisc.edu>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beautiful!

Pulled down that commit, was able to build and can confirm the issue
is fixed in git gui!

This has been a thorn in my side, so I appreciate your help! I look
forward to it being included in the next release for git in Homebrew!
:)

On Fri, Jan 5, 2018 at 4:41 PM, Johannes Schindelin <schindelin@wisc.edu> wrote:
> Hi Matthew,
>
> On Fri, 5 Jan 2018, Matthew Orres wrote:
>
>> builtin/checkout.c:24:10: fatal error: 'fscache.h' file not found
>> #include "fscache.h"
>>          ^~~~~~~~~~~
>> 1 error generated.
>
> I already had pushed a fix for this, have you re-pulled?
>
> Ciao,
> Johannes
