Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0A61F406
	for <e@80x24.org>; Fri, 22 Dec 2017 21:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756679AbdLVV6H (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:58:07 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40139 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbdLVV6G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:58:06 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so23853342wmf.5
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=m2tkGrik1eeEcqC6YNJU6ykdZ9vq9IuJIqxLgsYjNew=;
        b=gHpiwTOQMDI81r3vfuf3XLlFDHHWdoQQibTPqqUt/eC3clo9Da4v0+bkWziE0eNkS9
         PLCDMnTUuhmR3ngL7VyW0WKGFOBpetdoO7U/pDy5+dS/xAdCxttc3PsvlzaUjCunMUdF
         cgUd4W2JFKigHhhuhJF1PODN5eJ/fgvpz4d8chdUcR5/d0DSDfnFA4/pVrMMA0baTV7u
         TNSbsCV1HenxjoRIJ/O2EzKBlQXZiT6Iso6S4gor0b4i0wpNz1G1vCiL4+LhrByMdAc+
         qPM5+edUhH+fFcUAANfsXFm6LNiMfubW6/HCC2QZOcvqlNS6seyAjAZO4vKfPIkBbW0G
         N/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=m2tkGrik1eeEcqC6YNJU6ykdZ9vq9IuJIqxLgsYjNew=;
        b=e+1gxL6qRZEUL+/pNfOS7PbE8OfJLDYJ4XJ+1XjtzqoEq9XyvzIXTH//CacKa3oDz8
         H9iBd49W9gaNcZbTL8D/1YevbDQmMRsGJ5AOTq/O1rcvg8xRhX3u60PrGhjhUEAnbThH
         mz7TdWEjnwgY+u6IGfIgqsh4XFei4bris1O1Ty5IokdlRaa/znCl3a6yz9Izufh7vTVX
         rygwWKgHd8QpvR63bUMUgEkdiiAXIHzuWWoYgRWtYxVxYrqFb+7GKRcj80//5DbHEgU/
         Juo93SAEVQjvhoNzXuq/Wu6jYxDbBVMY2q8AtNa89D/r4dOHlx0xWmwzHQDCMHPwF4AE
         WNsg==
X-Gm-Message-State: AKGB3mL05c3W1ZpttgwsxClLWLCHNT+nXbwEgvMczt/M19omTcI+LNsl
        iI3f4RQbYb0A5PAPhx4Ynt4=
X-Google-Smtp-Source: ACJfBoslyfvxZuf/g5leeoYkCW36uy2ALt+3nwh4A9CuyGya+EWKIxu7fuLbMVbIu7U1YixBKB6M8Q==
X-Received: by 10.80.179.15 with SMTP id q15mr16369305edd.166.1513979884945;
        Fri, 22 Dec 2017 13:58:04 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id j3sm18626074edh.55.2017.12.22.13.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Dec 2017 13:58:03 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eSVKM-0005RX-Rf; Fri, 22 Dec 2017 22:58:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com> <20171222204152.4822-1-avarab@gmail.com> <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 22 Dec 2017 22:58:02 +0100
Message-ID: <87h8sis9w5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 22 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Those options could also support combining with -m, but given what
>> they do I can't think of a good use-case for doing that, so I have not
>> made the more invasive change of splitting up the logic in commit.c to
>> first act on those, and then on -m options.
>>
>> 1. d71b8ba7c9 ("commit: --fixup option for use with rebase
>>    --autosquash", 2010-11-02)
>
> To be fair, when "rebase --autosquash -i" is run (which is why you
> would use --fixup in the first place), the log message of the fixup
> one is used only for locating which one is to be corrected, and the
> contents of the log message is discarded.  So "given what it does",
> I can't think of a good use-case for using --fixup and -m together,
> either.  So "nobody immediately thought of it when it was added" is
> certainly not a reason to later make the combination possible.
>
> But I personally am moderately negative on one of these two imagined
> use cases.
>
>> Add support for supplying the -m option with --fixup. Doing so has
>> errored out ever since --fixup was introduced. Before this, the only
>> way to amend the fixup message while committing was to use --edit and
>> amend it in the editor.
>>
>> The use-case for this feature is one of:
>>
>>  * Leaving a quick note to self when creating a --fixup commit when
>>    it's not self-evident why the commit should be squashed without a
>>    note into another one.
>
> This is probably OK.
>
>>  * (Ab)using the --fixup feature to "fix up" commits that have already
>>    been pushed to a branch that doesn't allow non-fast-forwards,
>>    i.e. just noting "this should have been part of that other commit",
>>    and if the history ever got rewritten in the future the two should
>>    be combined.
>
> This has a smell of the tail wagging the dog.
>
> Perhaps your editor does not have a good integration with external
> commands to allow you to insert a single-liner output from
>
>     git show --date=short -s --pretty='format:%h ("%s", %ad)' "$1"

Since this use-case is talking about pushing a fixup for an already
pushed commit, this is the first thing I put in -m"..." to reduce
ambiguity.

> and that is what you are abusing --fixup for?
>
> It is simply bad practice to leave a log entry that begins with
> !fixup marker that would confuse automated tools like "rebase -i"
> machinery on a commit that you have no intention of squashing into
> another, as it invites mistakes.

    "if the history ever got rewritten in the future the two should be
    combined"

So it's still the intent to squash these, it's just not being done right
now, and even if it never happens it'll be easy to glance at the
relevant commits in log --oneline.

> I do agree with the scenario where you would wish you could take
> back an earlier mistake but you cannot.  But the log for such a
> follow-up fix should be written just like any other follow-up fix
> commit, i.e. describe what was wrong and how the wrongness is
> corrected with the follow-up change.  What was wrong in "which
> commit" is of course important part, but it is a relatively small
> part.

I don't agree that git as a tool should be so opinionated. You can edit
these --fixup messages right now with --edit, and I do. That it doesn't
work with -m"" as it should is a longstanding UI wart.

Tools should be naturally composable without needless arbitrary
limitations.
