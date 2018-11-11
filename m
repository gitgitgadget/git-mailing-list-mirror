Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1951F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeKLF7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 00:59:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42265 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKLF7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 00:59:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so726725edp.9
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wOdSj1BfBvvDmCbLLLc36zn5yMtxsoNKyb1IJ9Yhxuk=;
        b=o1NBF0zy/LZxArHgJXrWPQp3pedUxZF45GqwaK+/AmTUMPsxR+vVCfbCdRmnu15tyX
         Ks1gdd5Fp3v+3JKXINmY/okT6/9eQHP4rEeXMouAJ4Agvh04nONWjIbBKv///vG40rkp
         xgyx0yh7GgBd2Eg8qHqzyuOKy1PvjsxZuAwI9H+bi/lcDWDI4cOg6ilumj5wA8egIxfD
         Fh/EAvSIPcs/BBhoVD0VjCn3HbUqdFkhYe7Wi8DcSRwKn5Y1WApeUy87HelPbZrbUz4P
         GeOTFl8PuP3qKst4+qMjWXkH/cuDS309BqrrDOsOKu9uVkI3/tACqDgZJ1bdqxPMNtC0
         JxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wOdSj1BfBvvDmCbLLLc36zn5yMtxsoNKyb1IJ9Yhxuk=;
        b=F/augrCCKTJFV1t9siDKkTnUWhDvMz3TljiwGKi55zth/Z+9p+CBVaOmeo2+52n9kD
         0iHliGk4edbCS/kZi950OPicBHUwYvgvpy5fYXKrp76p78XQPJ5ZjBtwPXhwlufg43YS
         hwDAqzfdxPpVubQbNkw0DvPx08UnUJWHrJOKU05d4XwXqL1k3fbDr/aF/0b5FDx7y9L6
         ASvmeMMOyCUDi5qkWKoTX7RU/mCpHQivMIlgy6z/Fiei+UkAXwGQGS4AiPwR4sNLn8H9
         9IrO8h9IFV2+CqfT2+T7OMCTHyjjPg4CKCgZyS8XaJmBL9ISA5WiJmqlO8m6yHXuYMi7
         7G9Q==
X-Gm-Message-State: AGRZ1gLWP42wLNHmlReSu9zVwPNST1CyVP1AM96ToyxYQBl7mLUTKJHP
        Ft0lU7oXLnGYJKsKPrftTqM=
X-Google-Smtp-Source: AJdET5fZQPa86gFb4Sr+pBr8fSbmCEpLtum3dmx6AWOmXhX98s4TtLKy6B+TYRwJpvfWjGgFDpIXkw==
X-Received: by 2002:a17:906:f108:: with SMTP id gv8-v6mr7551183ejb.173.1541967019610;
        Sun, 11 Nov 2018 12:10:19 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b37-v6sm3744498eda.92.2018.11.11.12.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 12:10:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 03/10] fast-export: use value from correct enum
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com> <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-4-newren@gmail.com> <20181111063636.GC30850@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181111063636.GC30850@sigill.intra.peff.net>
Date:   Sun, 11 Nov 2018 21:10:17 +0100
Message-ID: <87va532x5i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 11 2018, Jeff King wrote:

> On Sat, Nov 10, 2018 at 10:23:05PM -0800, Elijah Newren wrote:
>
>> ABORT and ERROR happen to have the same value, but come from differnt
>> enums.  Use the one from the correct enum.
>
> Yikes. :)
>
> This is a good argument for naming these SIGNED_TAG_ABORT, etc. But this
> is obviously an improvement in the meantime.

In C enum values aren't the types of the enum, but I'd thought someone
would have added a warning for this:

    #include <stdio.h>

    enum { A, B } foo = A;
    enum { C, D } bar = C;

    int main(void)
    {
        switch (foo) {
          case C:
            puts("A");
            break;
          case B:
            puts("B");
            break;
        }
    }

But none of the 4 C compilers (gcc, clang, suncc & xlc) I have warn
about it. Good to know.
