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
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C8B1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 20:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIIBD6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 21:03:58 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35211 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeIIBD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 21:03:57 -0400
Received: by mail-ed1-f43.google.com with SMTP id y20-v6so13810793edq.2
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=khmKQs7DGlz5l2HCCknC31XLr0q7LzLbDV8Qb5X3dH0=;
        b=U9eoPAbsYTolHXY76TjqqbpzPlq8MBS+CQwuibxFoZH4eRTrLFkpIay0OumE4hlCIt
         1JdIoWDdZl8f/oa0zZTpEglw8p+EC83wzT+MXOI69033eWdCDcPIJJlAqW4rGLu9LPLO
         jWibepyjTIr+FbhNAiLihGAuAmRPK5zlzLas59V13F5nhV34CEnhVym9HiGSxIrWgOiT
         yTnbGFQ6AaEP3i1h3ck85x75qXxrihEtL91KMoO6L7Ee4M7vTNjg4EP1bK0yEsIPvPHP
         PnRYEDADnJX82W5ZVe5+Ar4hm9owmQBz0vwL+MNXAddNa0J74k1eCz5OoGBDSYnnLRWW
         oLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=khmKQs7DGlz5l2HCCknC31XLr0q7LzLbDV8Qb5X3dH0=;
        b=r/J3pbg/W4n7sXXi2LycXeonVYW/OiKhZHArqCoOVrosEXTD+okzsMlC6ZLQfPlwDl
         2bDMxOWCDWMRmZSviG9XPYUjQY/nefz3IOuOX6+Mf7o3GtvtXtm2wwGQLTRCwkw2KKgD
         tlwD+fHA7PPsQwibWrlfuYrY1oSTKss6QMI7A8KpidZU6cuqEdWn15kYp8GSGkAt4GWH
         7007klwKn12m/5rlze2EzEqwQ2eeeknQx/FeFobORTocWcv834Fknci+kEe7r8gNlEX8
         KhXSRi2BexZ8hNyNi89RqH92eYtF54j4fP+A0RyXKT+Lp+Ev8TortKahIdbS0qbFJaqB
         4Jww==
X-Gm-Message-State: APzg51Ai9ae6CokRI+jX6NG1s1Zc+d0NlwwOBzf/0EILj0GSDpAAymq7
        JsX3EBYD/9lAGyF9NougQHYkCeBk
X-Google-Smtp-Source: ANB0VdY17QFjtZ8NzY0McOWU58W58ywhFIbukxK0owQ9sOUEmm9+66/E3d89bAkLVq2gPHLufES6DQ==
X-Received: by 2002:a50:b824:: with SMTP id j33-v6mr15202783ede.272.1536437819714;
        Sat, 08 Sep 2018 13:16:59 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id n15-v6sm6766764edn.44.2018.09.08.13.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 13:16:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stas Bekman <stas@stason.org>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org> <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com> <87bm97rcih.fsf@evledraar.gmail.com> <c0844b98-0fee-9fbd-fedb-883ed88c3ac6@stason.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c0844b98-0fee-9fbd-fedb-883ed88c3ac6@stason.org>
Date:   Sat, 08 Sep 2018 22:16:56 +0200
Message-ID: <878t4brbgn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 08 2018, Stas Bekman wrote:

> On 2018-09-08 12:54 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Sat, Sep 08 2018, Martin Ågren wrote:
>>
>>> Hi Stas
>>>
>>> On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
>>>> [include]
>>>>         path = '../.gitconfig'
>>>>
>>>> Notice the single quotes around the filename. When this is the case git
>>>> silently (!) ignores the custom configuration, which is clearly a bug.
>>>
>>> Thanks for reporting and describing out your expectations and what you
>>> observed.
>>>
>>> Actually, there is a test explicitly testing that 'missing include files
>>> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
>>> (config: add include directive, 2012-02-06).
>>>
>>>> The original problem cropped up due to using:
>>>>
>>>>  git config --local include.path '../.gitconfig'
>>>>
>>>> which on linux stripped the single quotes, but on some windows git bash
>>>> emulation it kept them.
>>>
>>> Huh, I wouldn't have expected them to be kept. You learn something
>>> new every day...
>>>
>>>> What am I suggesting is that git:
>>>>
>>>> (1) should complain if it encounters an invalid configuration and not
>>>> silently ignore it. It took quite some effort and time to figure the
>>>> culprit.
>>>
>>> Sounds reasonable to me, but I might be missing something. I'm cc-ing
>>> the original author. Maybe he can recall why he made sure it silently
>>> ignores missing files.
>>>
>>>> (2) probably allow the quoted location of the file, but it's much less
>>>> important, as it's easy to rectify once git gives user #1
>>>
>>> I don't think this will work. Allowing quoting for just this one item,
>>> or for all? Any and all quoting or just at the first and last character?
>>> What about those config items where quotes might legitimately occur,
>>> i.e., we'd need some escaping? Actually, something like '.gitconfig'
>>> *with* *those* *quotes* is a valid filename on my machine.
>>
>> The reason missing includes are ignored is that the way this is expected
>> to be used is e.g.:
>>
>>     [include]
>>         path ~/.gitconfig.work
>>
>> Where .gitconfig.work is some configuration you're going to drop into
>> place on your $dayjob servers, but not on your personal machine, even
>> though you sync the same ~/.gitconfig everywhere.
>
> Thank you for clarifying why this is done silently, Ævar. It makes sense
> then.
>
>> If we were to make nonexisting files an error, we'd need something like
>> an extension of the includeIf syntax added in 3efd0bedc6 ("config: add
>> conditional include", 2017-03-01) 3efd0bedc6 ("config: add conditional
>> include", 2017-03-01). I.e.:
>>
>>     [includeIfcond "test -e ~/.gitconfig.work"]
>>         path = ~/.gitconfig.work
>>
>> Or something like that, this is getting increasingly harder to shove
>> into the *.ini config syntax.
>
> This suggestion won't solve the real problem. The real problem is that
> git can't find '.gitconfig' even though it's there, due to single quotes
> around the filepath. So the suggested check will still ignore the
> configuration even if it's there.

...because that's not how the *.ini syntax works. That means to look up
a file called '.gitconfig', as opposed to .gitconfig, ie. one that
actually starts with a single quote. On POSIX systems filenames can
include all bytes except \0, so we need some way to include those.

I've just created a 'foo' file (i.e. one that has a 5-chararcer name,
including single quotes), and including it via git's config works, as
opposed to the filename foo (i.e. the three-character version).

I can see how this is confusing, but we can't have some way to have this
"ignore missing" feature and warn about stuff like 'foo' v.s. "foo"
v.s. foo without carrying some list of quoting constructs deemed to be
confusing, and forbidding includes from files that look like that.

> This also leads me to think what if the include path has spaces in it?
>
>     path = ~/somewhere on my system/.gitconfig.work
>
> most people would assume quotes are needed around the filepath.
