Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD461F453
	for <e@80x24.org>; Wed, 24 Oct 2018 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeJYCXP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 22:23:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38953 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYCXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 22:23:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5-v6so5907392eds.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AByv+SczOgxAR2T89bIarnKAUD6P1HtwMQVrkz4cl9Q=;
        b=KfcKQ/7ilVq0O5mfoK5pOiaoUO+Z6i+dRzTnqMMHVeXmzAolkpyh/zdKatanj22Hxg
         8sjdZQ21mF2Tj4sophFJa/51MiNHyYmR1EX1XPpj43wWpxnEEUCsZYu87SR1RDEMDJ6w
         MCEZZaP0fvhldP0QeRRK3tDcZciMbLQlCUffuNEIIUDseXtXIdGQxKmz2mXST+dcAfxs
         VjaeTxHzZud0OCFsrG2iHU7wt/gyArmhlhcNoGv9UAOfCXnceT9CpZm2r8mNYM3TrcmI
         jjs1LggjwHvol+kgVFTTGh2jzntQunojR1Tj2QaqazzKTsICHjgTblyoJzkKoc1BJG7p
         Z6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AByv+SczOgxAR2T89bIarnKAUD6P1HtwMQVrkz4cl9Q=;
        b=ln/1ENynXJCcRQ8/0esVNzUvKOMR3CTUpzN/krlE90mqCodWgHK4MR9EHxA19BZI+3
         wNaw9/ZoM4VoUdeHQeZsbwYNm4AJdvzzyz2Iuja4MxjoGHYH5QGJyfBP+b3Rp7Fdl78r
         sellt1WTrAQa5pbvOku0Qx+tjg0UAN1iniKsas20x6roO/FxhqruY1ddO1j19anMh7ST
         DfKtBYakj+FVBgL+Zh0xChpjtbDJYU2CiBmxnwrXPGvZkJnTvwG2bzIWE06jKeVbyrui
         xTOTeGVn1T7kf1v9MM7gB2ak+KOPoVbiYckzhsFvatkNMMWHyzYnc22Qh1Hyx9eTB8Cj
         Plbw==
X-Gm-Message-State: AGRZ1gKiREZqjAySaUvAsWzCE/yk0VIfSSIYMg8NE+j3e88PdKDBGDgE
        5DclEFrHy/+GXSH/+37CByE=
X-Google-Smtp-Source: AJdET5cBnmQW8TktxgtIbZZBvv9eacZ/jbSmYMxwNfXry1AD7yrZBZLgFDF/5tV5QgHMPjnCMZ2qnQ==
X-Received: by 2002:a17:906:4d0e:: with SMTP id r14-v6mr1916409eju.76.1540403653168;
        Wed, 24 Oct 2018 10:54:13 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id p57-v6sm1777756edc.92.2018.10.24.10.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:54:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet> <8736sxc6gt.fsf@evledraar.gmail.com> <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com> <871s8gd32p.fsf@evledraar.gmail.com> <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
Date:   Wed, 24 Oct 2018 19:54:03 +0200
Message-ID: <87woq7b58k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 24 2018, Duy Nguyen wrote:

> On Tue, Oct 23, 2018 at 6:45 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> >> The effect of what I'm suggesting here, and which my WIP patch in
>> >> <875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
>> >> one-time getenv() for each process that prints a _() message that we
>> >> aren't doing now, and for each message call a function that would check
>> >> a boolean "are we in poison mode" static global variable.
>> >
>> > Just don't do the getenv() inside _() even if you just do it one time.
>> > getenv() may invalidate whatever value from the previous call. I would
>> > not want to find out my code broke because of an getenv() inside some
>> > innocent _()...
>>
>> How would any code break? We have various getenv("GIT_TEST_*...")
>> already that work the same way. Unless you set that in the environment
>> the function is idempotent, and I don't see how anyone would do that
>> accidentally.
>
> I didn't check those GIT_TEST_ but I think the difference is in
> complexity. When you write
>
>  var = getenv("foo");
>  complexFunction();
>
> you probably start to feel scary and wrap getenv() with a strdup()
> because you usually don't know exactly what complexFunction() can call
> (and even if you do, you can't be sure what it may call in the
> future).
>
> The person who writes
>
>  printf(_("%s"), getenv("foo"));
>
> may not go through the same thought process as with complexFunction().
> If _() calls getenv(), because you the order of parameter evaluation
> is unspecified, you cannot be sure if getenv("foo") will be called
> before or after the one inside _(). One of them may screw up the
> other.

Ah, you mean because getenv() is not reentrant such a construct may
cause us to return something else entirely for getenv("bar") (e.g. in
this case the value for getenv("bar")).

Is that something you or anyone else has seen in practice? My intuition
is that while POSIX doesn't make that promise it isn't likely that
there's any implementation that would mutate the env purely on a
getenv(), but setenv() (munging some static "env" area in-place) might
be another matter.

But we could always call use_gettext_poison() really early from
git_setup_gettext() (called from our main()) if we're worried about
this, it would then set the static "poison_requested" variable and we
wouldn't call getenv() again, e.g. if we're later calling it in the
middle of multithreaded code, or within the same same sequence point.

>> > And we should still respect NO_GETTEXT, not doing any extra work when
>> > it's defined.
>>
>> This is not how any of our NO_* defines work. *Sometimes* defining them
>> guarantees you do no extra work, but in other cases we've decided that
>> bending over backwards with #ifdef in various places isn't worth it.
>
> I guess it boils down to "worth it". For me #ifdef NO_GETTEXT would be
> limited to gettext.h and it's not that much work. But you do the
> actual work. You decide.

Yeah the ifdef is pretty small and not really worth worrynig about, the
main benefit is being able to run tests in this mode without
recompiling.

I hadn't been running with GETTEXT_POISON when I build git because I
hadn't been bothered to build twice just for it, but am now running it
alongside other GIT_TEST_* modes.
