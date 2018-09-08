Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1A91F404
	for <e@80x24.org>; Sat,  8 Sep 2018 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIIAlK (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:41:10 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35931 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeIIAlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 20:41:10 -0400
Received: by mail-ed1-f52.google.com with SMTP id f4-v6so13784488edq.3
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+LiIxKNjVpYQeE8jnCE45FsGcJxZSEo5XXNtNCbpk3c=;
        b=OK7aT5xTfMSQGcoLz2h4HTfaxNUTJfYAEDNOGuI6pTQ+phhS7nq7B+hCyIiP7hJBoX
         80HjKPs9Vd65VGQ0fxwJVGMD9gCqK3VeIRPYtSgHqbgn4Tix4LwflohP9dVb7uv0a+EB
         hN1JnGphPj37uftCJec52ghHLNpsBACe66GpbG41wPkH7Jw1uIJV3xqWZR2OBKd0rG+p
         ZZd52fg0AQWFPCr93ttoFqStaeY8wdOLHSz2eD9/fLW3Ao5T/KIPPxr56T+J8vwgEduC
         Q1Mdi/EF6hAZ/QShDFOULTHbsO62ETLNwDdk29InVtymoAms5WdSVCOdb0QrvApWBEGP
         StcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+LiIxKNjVpYQeE8jnCE45FsGcJxZSEo5XXNtNCbpk3c=;
        b=ZZthGCv9isJWxUMV5MCsS+W0NFdMMCFTDd50udApqSucvJDj5ALaEACs4HkT4+qd2K
         4vH7Dor4UEV33vaL6+bxDuIibFhKxlbX11nzaSl7k5eT+guGEClUX5KWP3YncJKiNwXI
         4DG9oXzkPx6yU7lbqXA/Mw/XwXxZpasOEoRId0ivy5BCpy7Pj+4kqxICMU6JZAlzwBLK
         +ToTUMdvADGeC1V9wZgs63KUk6rS/fE2nbPvj0NiC0HUQmdgZhpAGxetbhB1nZnUNaH8
         sID4Ok0xjF6QCPe5ivMpp2r15baZeMTKm2OFo1/KeN0dkDrOEzs5H5OWpqudMEubFEgH
         AyJw==
X-Gm-Message-State: APzg51DEPHW9aSAocBaEoeq27vrLH1ye562pMbP3bg4Zk3jtDUk3TBE6
        +IEe7/sUhiah2tvjXLrSyu0=
X-Google-Smtp-Source: ANB0VdYtB3pHx6aUnACJH6EI3h+O/AFAF30COrSiui0sBtTUR75+G0L5EIm1ebxQHSyQsVYKf9ulLg==
X-Received: by 2002:a50:88a4:: with SMTP id d33-v6mr15103025edd.239.1536436456072;
        Sat, 08 Sep 2018 12:54:16 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f13-v6sm8868921edf.50.2018.09.08.12.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 12:54:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     stas@stason.org, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org> <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
Date:   Sat, 08 Sep 2018 21:54:14 +0200
Message-ID: <87bm97rcih.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 08 2018, Martin Ågren wrote:

> Hi Stas
>
> On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
>> [include]
>>         path = '../.gitconfig'
>>
>> Notice the single quotes around the filename. When this is the case git
>> silently (!) ignores the custom configuration, which is clearly a bug.
>
> Thanks for reporting and describing out your expectations and what you
> observed.
>
> Actually, there is a test explicitly testing that 'missing include files
> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
> (config: add include directive, 2012-02-06).
>
>> The original problem cropped up due to using:
>>
>>  git config --local include.path '../.gitconfig'
>>
>> which on linux stripped the single quotes, but on some windows git bash
>> emulation it kept them.
>
> Huh, I wouldn't have expected them to be kept. You learn something
> new every day...
>
>> What am I suggesting is that git:
>>
>> (1) should complain if it encounters an invalid configuration and not
>> silently ignore it. It took quite some effort and time to figure the
>> culprit.
>
> Sounds reasonable to me, but I might be missing something. I'm cc-ing
> the original author. Maybe he can recall why he made sure it silently
> ignores missing files.
>
>> (2) probably allow the quoted location of the file, but it's much less
>> important, as it's easy to rectify once git gives user #1
>
> I don't think this will work. Allowing quoting for just this one item,
> or for all? Any and all quoting or just at the first and last character?
> What about those config items where quotes might legitimately occur,
> i.e., we'd need some escaping? Actually, something like '.gitconfig'
> *with* *those* *quotes* is a valid filename on my machine.

The reason missing includes are ignored is that the way this is expected
to be used is e.g.:

    [include]
        path ~/.gitconfig.work

Where .gitconfig.work is some configuration you're going to drop into
place on your $dayjob servers, but not on your personal machine, even
though you sync the same ~/.gitconfig everywhere.

A lot of people who use includes rely on this, but I see from this
thread this should be better documented.

If we were to make nonexisting files an error, we'd need something like
an extension of the includeIf syntax added in 3efd0bedc6 ("config: add
conditional include", 2017-03-01) 3efd0bedc6 ("config: add conditional
include", 2017-03-01). I.e.:

    [includeIfcond "test -e ~/.gitconfig.work"]
        path = ~/.gitconfig.work

Or something like that, this is getting increasingly harder to shove
into the *.ini config syntax.
