Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A4B20248
	for <e@80x24.org>; Mon, 18 Mar 2019 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCRR7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 13:59:06 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43240 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRR7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:59:05 -0400
Received: by mail-wr1-f47.google.com with SMTP id d17so18104546wre.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IpHczH/CpsNBJnTxA+Y/6Kla7wGSnG4lsNkqmG+wrXs=;
        b=Js/R4f/tQIp2KC6/Nx9sHjXe67B9Y5gcpKHMPDt+K4zbMIY/ZnCuwZjyVwni1xngH9
         2oJ3yTe2aHc57TF90uXZwUgmgHPNF9AeQhtA2sbZjKqDgQ3teb0klRmKNavWXBy4flTN
         BghJwBi1fXgx21Hj/QXGcIe70qOdy6xog23DvRbARjBKI32glF6Wb30ScPoIeIDxWkLj
         jpsChk59Vvuy8drC62p2BEAlFM0RRrvIA4sW/NYN0PUlPeX/jN8lOfUg+muG0ZVx9DBY
         BjsiP1OhpaSM0dDoKYJ1AMde9pgcj901pP8V+hTIjYMEh6ufDZRplZZqD4ED5MBR4knb
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=IpHczH/CpsNBJnTxA+Y/6Kla7wGSnG4lsNkqmG+wrXs=;
        b=BYZElmIs/FDAfCv4oB5ixxGrHMo+TObbtVItmhPFE1Kb32wwtsPt6087Z6pfSPQNfi
         bUmBZpxK3ObzffdfxZo4XupO+VFCzzAqG0AZT4E4InhEwDSLSQS6EK8ow+GYqeLeh3TY
         mSbuSimgQcc0c+E9Tl4yIFQBcKT/JJyDkN9u5nk3J0RiiHaC4AgiZnrURWB3xvIgcQZG
         PrStYCnZJJmCgFS+NR8dwWt2QdjDteMSKqtU+nj0PMlgnQWDC9mnBrJ9xBw89Ra9IcKB
         u5dmB/E92kzSrqCMm7FDgnvi4smslqeTZ3YHtFGCucNjW3JhAE//TlP8zy+bWX7DnwhZ
         2JTA==
X-Gm-Message-State: APjAAAUrlvo1v3baZmQ4oxKXPE+qo+46JCi2jubzoP/b9SOR4NVr86Us
        YO9WN2pm33R7ehuEHfxDkQ4=
X-Google-Smtp-Source: APXvYqyrxdVTxLPD8QT68NAUQZPMZ78YcRqXI35iU7E8qII42IgKEYdUz/XEbp+UkaTtmaCR/pIuHg==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr12986941wrv.217.1552931943691;
        Mon, 18 Mar 2019 10:59:03 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 11sm21329wmg.27.2019.03.18.10.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:59:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain> <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home> <87wol3bydp.fsf@evledraar.gmail.com> <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 18:59:01 +0100
Message-ID: <87o968dpy2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Elijah Newren wrote:

> On Tue, Mar 12, 2019 at 2:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Mar 12 2019, Andreas Schwab wrote:
>> > On M=C3=A4r 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> >> I however think it may be worth making sure that our docs do not
>> >> encourage "diff A..B" and teach "diff A B" when comparing two
>> >> endpoints.  That can be done without changing anything in the code.
>> >
>> > The nice thing about "diff A..B" is that you can c&p the output from t=
he
>> > fetch run without the need to edit it.
>>
>> Not to shoot down this effort, just to add another similar thing I do
>> regularly for ff-branches:
>>
>>  1. Copy/paste A..B fetch output
>>  2. git log A..B
>>  3. ^log^diff
>>
>> I.e. I just need to tell my terminal to re-run the same "log" command
>> with "diff" instead of "log".
>>
>> Of course as covered in the linked thread it doesn't work for some
>> (non-ff) cases, and I'll sometimes end up cursing it and swapping around
>> ".." for "..." with log/diff.
>
> Doesn't this somewhat imply that although you use diff A..B here for
> convenience, that it's actually wrong since what you really want is
> A...B?

Yeah "..." would be more correct, but usually when I do this it's for
things where the LHS hasn't diverged.

> Or said another way, the end goal of deprecating "diff "A..B"
> then later reinstating "diff A..B" to mean the same thing as "diff
> A...B" would actually be better even for your usecase?

Yeah, it would be. Sometimes I need to go back and tweak it to be "..."
instead of ".." now. When the two have different behavior I usually want
the former.

> Of course, switching to the removal period may just be too painful for
> too many folks since there are obviously people that use it, but I
> just want to see if I'm understanding correctly here.

I think we'd ideally migrate, but the conversion might be too
painful. Junio doesn't seem excited in
<xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>

I'm not claiming that this ^log^diff use-case is common or anything,
just noting a use-case I do use occasionally and mostly works now.
