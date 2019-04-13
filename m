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
	by dcvr.yhbt.net (Postfix) with ESMTP id E61BC20248
	for <e@80x24.org>; Sat, 13 Apr 2019 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDMVKr (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 17:10:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44939 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMVKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 17:10:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id i13so626680edf.11
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hyIYgkLmpsnr9ORS9rpBe7sE+XVwOqcfH0OzEKYJtSc=;
        b=mJ7u3IFuwLz1iA/cRgzgpkIVUEo/tsiaiWmL5eAQdzuYUBlq0rk+jNjggiBKGbIL5g
         Qg8FUnvajyNT9qRd6ElM2yGvDLYhgtxFWvvBJuxb0f9b28s6IPL6NGhVIWvypOIqEVqe
         vVwiH2six0Zd/efSx+9V0/XezHF8nc0mIbgrmzz4YVinXntW6WKqKuvzBeSm0y17BTuq
         51U+ZA329T/trGLIy3968+99/1ef1L7x8jvzQdYvUKkLCz3VgezWgKl7cETA3K++DAgy
         Iuo+U1qq5ht9SiNLriHZybJiRnStIY0RD6lkeZzQVD9V2e8ebijGQ8C3nTGVyXYwHqF1
         GxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hyIYgkLmpsnr9ORS9rpBe7sE+XVwOqcfH0OzEKYJtSc=;
        b=Lmtj+VUzjEgbZ/YeKmrI8jgoD2bek/u+lGCMdkBi+cjr/mtazFYyABg1pEHGn1cDvn
         qZCCb0Fv4hYOMYDsFRboB7OpohZPejiqXTuK7M7F+zM2TYPM/Nx8p0361qn1GTETNAE2
         +DsX3jDuyvpPCmt6utjPJyb6WJhGw0wAUwvmsvvc+Ro8/134ragbuk8Vl/xtdXBBb9BY
         lL3b9cALTlWU1m0fVzOR7DsY5jCBC3mvqj7k8xuzcIkWu+NbMRlN59dwI7CdfiszVS/O
         CVgc/B+8eDOd53YEUw5M/WFKpdNHTvD02JjPx2ftgTnXSsRlBP/2dVYat/+EzpnvSNXg
         6lLg==
X-Gm-Message-State: APjAAAV5RS0YRIANNJ+WjVRN6rF38xCKQa3REI6IP3XTaIehgJTlOiKQ
        YcaRR+cLQaS6yfXoPmLMImw=
X-Google-Smtp-Source: APXvYqzU9sCkb+p1cesEVbCAoYRXGPYgPhniH/+F0QNa0T/vWP7AMWxchtkdCtq4GQXZnZkDpMb85w==
X-Received: by 2002:a17:906:828b:: with SMTP id h11mr34774455ejx.1.1555189844777;
        Sat, 13 Apr 2019 14:10:44 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v13sm7775856ejj.8.2019.04.13.14.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 14:10:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/4] rebase: teach rebase --keep-base
References: <20190328221745.GA3941@dev-l> <cover.1554151449.git.liu.denton@gmail.com> <87ftquapfy.fsf@evledraar.gmail.com> <20190406203800.GA6147@archbookpro.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190406203800.GA6147@archbookpro.localdomain>
Date:   Sat, 13 Apr 2019 23:10:43 +0200
Message-ID: <8736mlfw6k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 06 2019, Denton Liu wrote:

> On Sat, Apr 06, 2019 at 09:44:49PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Apr 01 2019, Denton Liu wrote:
>>
>> > Thanks again for your feedback, =C3=86var! I think we're both on the s=
ame page now.
>> > Hopefully I've addressed all of your high-level concerns with this pat=
chset and
>> > we can move into a discussion on implementation detail.
>>
>> Late in replying to this, have been off-list. This also applies for your
>> v4.
>>
>> The current version you have still doesn't explain the "Why would we
>> redundantly rebase every time in this case..." question I had in
>> https://public-inbox.org/git/87tvfma8yt.fsf@evledraar.gmail.com/
>>
>> I *think* it's closer to "it was easier to implement this in terms of
>> --onto, which happens to behave that way now" than "it must work this
>> way for --keep-base", which is fair enough.
>
> Correct, the reason why --keep-base was not lazy initially was because
> "--onto did it that way". You are correct in that --keep-base should be
> lazily rebasing so I changed --onto's behaviour in 3/4 because it would
> also benefit from laziness. Thus, now --keep-base lazily rebases because
> --onto also does.
>
>>
>> Although I see when I forward-port my POC patch from that E-Mail that
>> one test fails now, which is good, that wasn't the case before, but it
>> looks like that might be testing something else than just the lazy
>> behavior.
>
> The test fails because the patch disables fork_point if --keep-base is
> set. So, with the patch applied, C is rebased even though it is excluded
> when fork_point is set.
>
>>
>> It would be good to know in terms of commit message or (better) explicit
>> tests so that if we teach these various rebase modes the same lazyness
>> --fork-point uses in the future it's clear if that's OK or not.
>
> Sorry, could you please clarify what you mean by the "lazyness
> --fork-point uses"? I don't understand what laziness is introduced by
> using --fork-point. Also, are the tests in t3432 not sufficient for
> testing fast-forwarding (aka lazy) behaviour?

Late reply, sorry. I mean if I do e.g. on git.git:

    git checkout -b avar/test 041f5ea1cf

I.e. branch of Junio's "The third batch" (we're now on the 4th) and
then:

    git branch --set-upstream-to origin/master

And commit a dummy change, I'm now:

    On branch avar/test
    Your branch and 'origin/master' have diverged,
    and have 1 and 33 different commits each, respectively.

Then I run a --keep-base rebase twice:

    $ git log --oneline --no-decorate -2; ~/g/git/git --exec-path=3D$PWD re=
base --keep-base; git rev-parse HEAD
    fc3e916c5f foo
    041f5ea1cf The third batch
    First, rewinding head to replay your work on top of it...
    Applying: foo
    b10e672074dfee6b6e8b2901c9bb49f856a13708
    $ git log --oneline --no-decorate -2; ~/g/git/git --exec-path=3D$PWD re=
base --keep-base; git rev-parse HEAD
    b10e672074 foo
    041f5ea1cf The third batch
    First, rewinding head to replay your work on top of it...
    Applying: foo
    fd3029e73b89f5a799653ff17199d00f2a6ee2e2

I.e. I'll keep on getting a new commit, even though by any criteria I
can think of for this type of case there's no work to do. I.e. we're
already based on 041f5ea1cf, no need to rebase again.

Of course this is also currently the case with --fork-point without
argument, which'll settle on (note fourth, not third):

    $ git log --oneline --no-decorate -2; ~/g/git/git --exec-path=3D$PWD re=
base --fork-point; git rev-parse HEAD
    85a1861cec foo
    e35b8cb8e2 The fourth batch
    First, rewinding head to replay your work on top of it...
    Applying: foo
    c6046e97af29d71bf6270080acf188c095e0cb7c
    $ git log --oneline --no-decorate -2; ~/g/git/git --exec-path=3D$PWD re=
base --fork-point; git rev-parse HEAD
    c6046e97af foo
    e35b8cb8e2 The fourth batch
    First, rewinding head to replay your work on top of it...
    Applying: foo
    672d22d58e9aa9b6a28054531c21e1f1b598b013

Whereas a --keep-base in *this* case should be identical to:

    $ git log --oneline --no-decorate -2; ~/g/git/git --exec-path=3D$PWD re=
base $(git merge-base --fork-point origin/master HEAD); git rev-parse HEAD
    fc3e916c5f foo
    041f5ea1cf The third batch
    Current branch avar/test is up to date.
    fc3e916c5fc707cfc83f28b3faca81046306b305

The reason I'm asking is that as noted in the thread starting at
https://public-inbox.org/git/20190224101029.GA13438@sigill.intra.peff.net/
we used to in *some* cases do the same for:

    rebase $(git merge-base --fork-point origin/master HEAD)

As for just:

    rebase --fork-point

I.e. say "Current branch is up-to-date". I'm planning to loop back to
that and fix it for the --fork-point case. So I was wondering if you
could think of a reason for why --keep-base couldn't also do the same,
or if there was some intrinsic difference I'm missing.

Anyway. Don't worry about it. When I poke at it it'll likely shake out
of the respective tests.

I was just wondering if you having looked at many of the same things
recently could understand my ramblings and knew if this was a case of
"yup, we could add a bit more to that can_fast_forward(...) case and
make it lazy too", or "no, --keep-base is special for reasons you're
missing...".
