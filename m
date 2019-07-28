Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79EB1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 02:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfG1CuT (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 22:50:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44074 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfG1CuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 22:50:19 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so112622432iob.11
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aa+7fKK5J6y9mFyfjqdJqdFh1kgfGTKIIuO0d39f/5U=;
        b=ip9V8ZCEPMzIlh52zsLeOdB/Ga63ZoH9n2BCt99sNMBT9ljvIiR2KcEP4wmIbj9bMl
         TOlItMkq11a0hYWfCki0nlcOz/Gt943RDcxXtFrfa4JYqH+NzYBhBT9IyrflT2Jcc32f
         4uPwR0krUcnYUShRfJNEQLMAAM1cNUTMIrQddtceBWJG/s8Uzu/uVE1aMAmL/WLiK/mv
         1vMy0FyZOOKifDgUJzBQtuIduiV8lOBIDj4QEQVVP+rIN1W5JAKAMv9L2lnn4IFKvAae
         GNr+erJymVddQ4fsomsVYH1bBq1zpQ1wJQMnIJvhfDb+MuEUFfMb+QWpUWhVHQVDxnDc
         JaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aa+7fKK5J6y9mFyfjqdJqdFh1kgfGTKIIuO0d39f/5U=;
        b=QKYLUvayQIsYjirJvEIsrFAML2tHUL1I377sbnGjcPaKqdJR/i5TR/SdmQHWhyyRnh
         FChjT7nWmqATBQj86NOuYQ5hk4QwC5hXmjiW0RbBY63qu96jV+m7ndyp0YoQvYusEcZE
         lzFYwGUDO9sOYfJaL0gJZdNVpSnGgb4E9lT0CEDvwtTPv9eQXgr17fr2ICy928yj16U+
         yGg4rcx0pktZWl+66ODWTpfUEl0Vp21x81z6GmDrZ5OQg8eA4EnbehYhIgTaE/HDAaLQ
         MIsN1UNRcQBIgS7UgeiDvWSaOzrnlhJrrPm5iunEKWNRcH/W/Y1ZmhNmgqTFS8efKNSq
         Wzvw==
X-Gm-Message-State: APjAAAUW41eisENeRiI9Ba9+XFuTOUEIkGZ/HALFfIqRZQP//CeoLte8
        ifje15bei+8ZiHQF84YfnWuH6+jgsjV45dFzkFA=
X-Google-Smtp-Source: APXvYqz/JjgBP0SpQ7vxZF3EzD8VSG2nag+aXQxY1P2/BxkND7ifa5MYcYccHvtzetQfB2NGL0ltYqZ0dGeEctynmWI=
X-Received: by 2002:a5d:890d:: with SMTP id b13mr44722039ion.124.1564282218390;
 Sat, 27 Jul 2019 19:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190727202759.22310-1-carenas@gmail.com> <20190727202759.22310-2-carenas@gmail.com>
 <875znn6nvt.fsf@evledraar.gmail.com>
In-Reply-To: <875znn6nvt.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 27 Jul 2019 19:50:07 -0700
Message-ID: <CAPUEspg255TAE-1ozc8CuC=k9oeP_WLD4TrFur5p=XY3s8PX3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] grep: make pcre1_tables version agnostic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 27, 2019 at 4:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jul 27 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > 6d4b5747f0 ("grep: change internal *pcre* variable & function names
> > to be *pcre1*", 2017-05-25), renamed most variables to be PCRE1
> > specific to give space to similarly named variables for PCRE2, but
> > in this case the change wasn't needed as the types were compatible
> > enough (const unsigned char* vs const uint8_t*) to be shared.

reading this again, had to admit there is a fair amount of guessing on
intent, but reading commits and the email discussion couldn't come
up with a better explanation.

is the root cause for the bug different?, could it be that the pcre2 API
was misunderstood? and you expected this pointer will be free together
with the context? (as it is done when a cloned context with tables is
used?)

> Both the v1 and v2 functions return const unsigned char *. I don't know
> where I got the uint8_t from. This makes more sense.

the type in PCRE2 is uint8_t, the documentation has a bug[1]
almost every platform git cares for would have unsigned char =3D uint8_t
though.

> The point of 6d4b5747f0 was not to only split out those variables we
> couldn't get away with re-using. Then I would have later re-used
> e.g. pcre1_jit_on & pcre2_jit_on as just pcre_jit_on. We could also do
> that now.

IMHO pcre_jit_on makes more sense as a bit, with local variables being
used for the pcre*_config() call with the right type.(uint32_t !=3D int)

> I think doing that & this part of the your changes makes things less
> readable. The two code branches we compile with ifdefs are mutually
> exclusive, so having the variables be unique helps with eyeballing /
> reasoning when changing the code.

I thought that too until the typo[2] in the pcre?_jit_on variable (now
in next) kind of
proved us wrong.  Maybe the names are too similar?

either way, would you rather drop this patch and make a replica variable?
should I rebase to next with Reviewed-By tags so that all other changes
in flight that would conflict could be corrected?

Carlo

[1] https://bugs.exim.org/show_bug.cgi?id=3D2420
[2] https://public-inbox.org/git/20190722181923.21572-1-dev+git@drbeat.li/
