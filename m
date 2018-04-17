Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6911F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeDQSIn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:08:43 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35686 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeDQSIm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:08:42 -0400
Received: by mail-oi0-f51.google.com with SMTP id c15-v6so1282007oic.2
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PTO0xZgK5nJ1LbsKGfcKijZG3BpSmWas09Z+D+FfZyc=;
        b=kWaoFA7Ih1PWU0H7d/nLmMxVu8hN4VsWWAId/3eXhJo8D66uFp5lmr8dMzoXfzUDyU
         r4m0nADhmxkdrJYBMaH/e0rKzDbXVkN9WY+geSR2dVTdyjBg+X1y6ZHeIOfX9X1gXmnR
         i/pVPkxXLP9aTzxbv0ZKBgF4XmaioaBwsu9wXdPKG+JLavh1DjrRTJ9x9XzfWBrUtHKw
         mEezW8V44QftMgVqUTV1VCeZOGXGS8ya1kkU8UBAhZi/HbUW9YnsW6V9K+pVG8jwQx19
         KskwCjhanHH4kKDkYvpw7dRCvlK2MVnpQDBAMf0NWT+u0XXNKeul3qte4uh4UUG31dUB
         pPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PTO0xZgK5nJ1LbsKGfcKijZG3BpSmWas09Z+D+FfZyc=;
        b=fZFzyUmDzqpDGMb6H4xZzDrHbXTDDITYiqgicDvf+pkvkT3sh04Ikz7DreVudpDyB9
         iDrnkIVQTrfExshYNBa2JTeL4yR5YalkwmiKP4pe+5UvtNlZg55QbakEtYMhPKGzcG7I
         faRi4wmjvcuABcVFO1KpA30fZG+3JjxnXTH28km/WolJBA86zAOgSkxWTaSwjWhzImvP
         4ZfUyekrwTtCIa3rbFbrXN7gdhmX129UqoL6r/FndA9IY1L1uuTnxBfWbkLipPsEvFls
         K8Y4DNfxIX7zhxI7i8JQaPp2VGi/TiAbkZPUZTWfBdaj8+Dyo6hgkq4Msn4R/YD4IAJn
         3H2A==
X-Gm-Message-State: ALQs6tBF63IJMqeK+ImgJL6Z6g08LUue0ZEux/bpbfmqbvU4Vqx0/aVo
        qqoDeJvUDUVIF3p3B2SDrPew0fmDKUflZ13VvAA=
X-Google-Smtp-Source: AIpwx48TlwIkJH4edWQNs01STM1m3QNxQeh2g2KI/oOhlD0lfWS529Jwb1yplZMyLx5JyT2juliTBAKSsReM7AR1hds=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr1810530oig.34.1523988521321;
 Tue, 17 Apr 2018 11:08:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.117.17 with HTTP; Tue, 17 Apr 2018 11:08:20 -0700 (PDT)
In-Reply-To: <xmqq604qwqbj.fsf@gitster-ct.c.googlers.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net> <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net> <xmqq604qwqbj.fsf@gitster-ct.c.googlers.com>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Tue, 17 Apr 2018 12:08:20 -0600
Message-ID: <CAE=pOyE5oqtPZLQ7d9EHU3uPC2eG+2_6APFirRvHqywE=4dGpg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> If we just want to add gpgsm support, that's fine, but we should be
>> transparent about that fact and try to avoid making an interface which
>> is at once too generic and not generic enough.

This patch is definitely designed around PGP and CMS, but the config
options were intended to leave room for supporting other tools in the
future. I think allowing a PEM type to be specified makes a lot of
sense for PGP and CMS, but in the future, we can add a
`signingtool.<name>.regex` option. Similarly, the GnuPG specific
command line options and output parsing can be moved into a helper in
the future.

My motivation with this series is not just to "add gpgsm support"
though. I've been working on some other CMS tooling that will be open
source eventually. My goal was to distribute this tool with a wrapper
that emulates the GnuPG interface.

To me, this series feels like a good stepping stone towards more
generalized support for other tooling.

> One thing that makes me somewhat worried is that "add gpgsm support"
> may mean "don't encourage people to use the same PGP like everybody
> else does" and instead promote fragmenting the world.

There are a lot of projects for which PGP doesn't make sense. For
example, many large organizations and government entities don't
operate based on a web of trust, but have established PKI based on
centralized trust. For organizations like this, adopting commit/tag
signing with CMS would be far easier than adopting PGP signing.

There's a chance that 10 different software projects will end up using
10 different signing tools, but I don't see that as a problem if those
tools are well suited to the projects. Developers are already
responsible for learning how to work with the software projects they
contribute to.
