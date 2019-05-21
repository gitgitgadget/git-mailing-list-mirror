Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD451F462
	for <e@80x24.org>; Tue, 21 May 2019 11:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEULYu (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 07:24:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40413 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEULYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 07:24:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id j12so28855681eds.7
        for <git@vger.kernel.org>; Tue, 21 May 2019 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Q4+m0X0O8+OcD8TKB6PDJ2OJ5lXZdA93xUegE/4vHPw=;
        b=Uqr7+azTakai9IWXdZYnvRL2fK3mngnVL2XrJosqPMmFF0+1AvBv4PPB2rhMf/5dTQ
         acjpX6TVAnz1wjR2jG8p2kodHXEL60GeTs2r6kIzfnphYwnPVHlAkhRCHNKd9UqUGdVW
         nJBBp/oQy/nQc5/XvW2vw0uKubHcQOtFHG3JmYkgV9lyny+zJwrZlVvbe5xuPNpRu8N7
         mn64VV+2bfo3QxeHFEiv13tESgsD+8In10+JaXlcf3L2EWfFJBG3t2mhWf7vEluEkdqw
         jUb+Xgm5P7YtDf5thkrWOmoGgXIAAqkTEUHJgfUJr4/eelkMYC1/O1Mb/GHGapDOOr7N
         ON4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Q4+m0X0O8+OcD8TKB6PDJ2OJ5lXZdA93xUegE/4vHPw=;
        b=LsZOHqrC2enGPJ020ZG3ihUtuRakLWmxmFSOsLzImziGIb/HSfMm/SXNuCbSHEBN9B
         0Ih0j/YAacuFqf+/dyhRzgLFENWOC+Bngq9Q565sc3K9H5wvcsUYJ3rgmf+L1hCNnBbh
         qTs4uc2LBcQ9LO418TGKNS0PbmYABPgqFbaYv23Lbi0hmBQigvrufqWRnBrY1wovpAmI
         fMhsIRw93Jv0AITqstTYGbbLwodURYyHlpieR+QeSaSzJlNIWi2MRIzA7ua0AdBCKhjO
         223LLX/cBfmk+i/rI019FUikNmIexC5t6qBfo/9rBkmWz8vlCUElBoT+WFlhRlhPOqHB
         0NNg==
X-Gm-Message-State: APjAAAV61JeUBYCaiF/w5jkiFd3/NofDojmJQPJRoj9BBzzmuYbaLPPo
        3e7aQRNwytDgmemPm0ZmYbg=
X-Google-Smtp-Source: APXvYqxR2xyviv6mLXhC6mS2L8PxCy7ryPDjjR5LFx/Lflw35JxRQXKJm3U0R7oi2SjXCGqZ4ByYrQ==
X-Received: by 2002:a50:8dcd:: with SMTP id s13mr80926913edh.247.1558437888063;
        Tue, 21 May 2019 04:24:48 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id d33sm6229709ede.10.2019.05.21.04.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 04:24:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com> <87ef4svk1k.fsf@evledraar.gmail.com> <CACsJy8AdhQH25NeDKKdSBctXcU=oyGcJ05XaNryj22GUQH5Btw@mail.gmail.com> <CACsJy8AU7=N_npgTuLES3r8VBMw+6kS+7D-B5MY0eghdD8O=AQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8AU7=N_npgTuLES3r8VBMw+6kS+7D-B5MY0eghdD8O=AQ@mail.gmail.com>
Date:   Tue, 21 May 2019 13:24:46 +0200
Message-ID: <87blzwuk1t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 21 2019, Duy Nguyen wrote:

> (dropping lkml and git-packagers)
>
> On Tue, May 21, 2019 at 3:31 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> > The bug there is that the old opt_arg() code would be torelant to empty
>> > values. I noticed a similar change the other day with the --abbrev
>> > option, but didn't think it was worth noting. Maybe it's a more general
>> > problem, in both cases we had a blindspot in our tests.
>>
>> Hmm.. this one is different (at least it does not use opt_arg()). But
>> I'll double check.
>
> What is wrong with --abbrev? The code is simple enough for me to just
> compare line by line, and the only difference I can see is that if you
> pass --abbrev=12a, then the old code accepts "12" while the new one
> rejects.
>
> Granted, I said "no behavior change", but this may be pushing the
> limits a bit. But maybe you're seeing something else?
>
> Note that "git diff --abbrev" still uses the old, but different,
> parser in revision.c. parse_options() is only used for --abbrev with
> --no-index.

Before d877418390 ("diff-parseopt: convert --[no-]abbrev", 2019-03-24):

    $ ~/g/git/git --exec-path=$PWD diff --raw --abbrev= --no-index {color,column}.c
    :100644 100644 00000 00000 M    color.c

after:

    $ ~/g/git/git --exec-path=$PWD diff --raw --abbrev= --no-index {color,column}.c
    :100644 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 M      color.c

This patch brings back the old behavior, but will break tests for
describe/branch (we have no tests on this for the diff behavior, but I'm
hoping to re-submit those after 2.22):

    diff --git a/parse-options-cb.c b/parse-options-cb.c
    index 6e2e8d6273..0a3c8bd565 100644
    --- a/parse-options-cb.c
    +++ b/parse-options-cb.c
    @@ -23 +23 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
    -               if (v && v < MINIMUM_ABBREV)
    +               if (v < MINIMUM_ABBREV)

I discovered this the other day because I was rebasing my "relative
abbrev" series and some of the tests I'd added here failed:
https://public-inbox.org/git/20180608224136.20220-5-avarab@gmail.com/

Now, in that case I think the change is fine, and is what we should do,
and when I found this I couldn't imagine anyone relied on this
empty-value '--abbrev=' behavior so I didn't bother to send an E-Mail
about it. It also brought diff.c in line with what we did with
empty-value '--abbrev=' elsewhere.

I'm just noting it because it might be indicative of some logic errors
in this conversion for other options, e.g. argument-less -U, and since
we didn't test for (or --abbrev=) perhaps we have other blind spots.
such a case.

Unrelated to any potential bugs in yoeur changes, I just noticed that we
should probably do this too:

    diff --git a/parse-options-cb.c b/parse-options-cb.c
    index 4b95d04a37..1216a71f4b 100644
    --- a/parse-options-cb.c
    +++ b/parse-options-cb.c
    @@ -16,6 +16,9 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
            if (!arg) {
                    v = unset ? 0 : DEFAULT_ABBREV;
            } else {
    +               if (!*arg)
    +                       return error(_("option `%s' expects a value"),
    +                                    opt->long_name);
                    v = strtol(arg, (char **)&arg, 10);
                    if (*arg)
                            return error(_("option `%s' expects a numerical value"),

I.e. we support and document --abbrev=0, but now we conflate it with
--abbrev= for no good reason.
