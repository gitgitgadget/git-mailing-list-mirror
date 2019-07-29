Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A5E1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbfG2Mio (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 08:38:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39448 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbfG2Min (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 08:38:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so59174620edv.6
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3BiyTdp+ReAP1pu5ksWJ3iwYTQkHNC0LU74TYC4F5QU=;
        b=XReq7ot1q217szd4SH1pTb/EAsXTQ30IWKAWWBrxPGXwWPEIDC2G7IbCy38kfxBPdL
         xhCWBPxuUplL5gMP79In1oF1gjLUGoEdAmYz2K2uuOZ+s5fI5z4ilSpXGigrAHrjm6mB
         y5PsBlSARrA2yXU6I++H0ivOQpSHCsiFzCzNxJQF0z8QxG0S4kE0fH0WmKQ1kemfjAdA
         b3Se9gXaighjp/ePPieAwfuIKz0Xjfy52KLeSshKDrUf/CbbgSkj2Ro8/vduWaGjtieR
         u0cFX7/OfRjxMwBvdYl2meEnRO9cKl8R4KZY0qYt9+kbzHRxzG2Ko6hpA6cB+HRHTmMO
         9aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3BiyTdp+ReAP1pu5ksWJ3iwYTQkHNC0LU74TYC4F5QU=;
        b=HcN0LJ4fEY/eZU8lFx8Ec7defm/wT0rAmKQ+I0HHVg3X8+GG96BhJQnXJ9AXMi4aIl
         OhPMB/+wrRGr6V/mlQmwHgvQUkuN0MOW80MpWEYtjYcx4eu0pws73LK061GXoXDILO98
         2fkudS/llvzmZOyg+R3GPHAQOTINcMngXQZNvq+wkiDsALv67QYYPdztUoi90SZ0IWZF
         lfHcVeJJNOc5v04Ww0J3dqBT56t3+PKsjMuMoZ/z1ffVsGQcCa+DJQjFzL7TD6kWRuY8
         VoraPs62fPEZrGx7os/YGjeEML2Y60mESQoq5cVQ4EKka6EI3MRm8nt9JTlljetkzmXa
         Gl3g==
X-Gm-Message-State: APjAAAVGhgZ9TkPU7zCTEa6cbLGs/tyLiwtKG+TikhMiKs49RsylpS/H
        xg144sapp4eLmemSSjaAvuEKJflEIjg=
X-Google-Smtp-Source: APXvYqy2qTiB8gbesCUZXfzDSKqlq2eJAmXZSKEZq3kKLlyzPZaUpTYvsuqNElBnqKvAguPl24sBQA==
X-Received: by 2002:a17:906:b34d:: with SMTP id cd13mr84019379ejb.107.1564403921138;
        Mon, 29 Jul 2019 05:38:41 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id s52sm16017425edm.55.2019.07.29.05.38.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:38:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
References: <20190728235427.41425-1-carenas@gmail.com> <8736ip6wzk.fsf@evledraar.gmail.com> <CAPUEspgQNCENviPYP6X790DvSgj_RpJVo2KP_39voLQnVc65pQ@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPUEspgQNCENviPYP6X790DvSgj_RpJVo2KP_39voLQnVc65pQ@mail.gmail.com>
Date:   Mon, 29 Jul 2019 14:38:39 +0200
Message-ID: <87wog15834.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, Carlo Arenas wrote:

> On Mon, Jul 29, 2019 at 1:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Jul 29 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>>
>> > PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
>> > had one, forcing the use of JIT if -P was requested.
>>
>> What's that PCRE1 compile-time flag?
>
> NO_LIBPCRE1_JIT at GIT compile time (regardless of JIT support in the
> PCRE1 library you are using)

Ah of course, I was reading this as "regexp
compile-time". I.e. something like (*NO_JIT). No *such* thing exists for
PCRE v1 JIT AFAIK as exposed by git-grep.

>> > After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
>> > the PCRE2 engine will be used more broadly and therefore adding this
>> > knob will give users a fallback for situations like the one observed
>> > in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:
>> >
>> >   $ git grep 'foo bar'
>> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>> >   $ git grep -G 'foo bar'
>> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>> >   $ git grep -E 'foo bar'
>> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>> >   $ git grep -F 'foo bar'
>> >   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>>
>> Yeah that obviously sucks more with ab/no-kwset, but that seems like a
>> case where -P would have been completely broken before, and therefore I
>> can't imagine the package ever passed "make test". Or is W^X also
>> exposed as some run-time option on OpenBSD?
>
> ironically, you could use PCRE1 since that is not using the JIT fast
> path and therefore will fallback automatically to the interpreter

...because OpenBSD PCRE v1 was compiled with --disable-jit before, but
their v2 package has --enable-jit, it just doesn't work at all? Is this
your custom built git + OpenBSD packages of PCRE coming with the OS?

I don't use OpenBSD, but isn't this their recipe? Seems they use "make
test", and don't compile with PCRE at all if I'm reading it right:
https://github.com/openbsd/ports/blob/master/devel/git/Makefile

> there is also a convoluted way to make your binary work by moving
> it into a mount point that has been specially exempted from that W^X
> restriction.
>
>> I.e. aside from the merits of such a setting in general these examples
>> seem like just working around something that should be fixed at make
>> all/test time, or maybe I'm missing something.
>
> 1) before you could just avoid using -P and still be able to grep
> 2) there is no way to tell PCRE2 to get out of the way even if you are
>     not using -P

Right, no arguments at all about ab/no-kwset making this worse (re: your
#1). I just really prefer not to expose/document config for what
*should* be something purely internal if the X-Y problem is a bug being
exposed that we should just fix.

Particularly because I think it's a losing battle to provide run-time
options for what are surely a *lot* of "make test" failures.

If it really is unavoidable to detect this until runtime in some common
configurations I have no problem with it, I just haven't encountered
that so far.

> you are right though that this is not a new problem and was reported
> before with patches and the last comment saying a configuration
> should be provided.

patches =3D your recent
https://public-inbox.org/git/20181209230024.43444-2-carenas@gmail.com/
or something earlier?

That patch seems sane without having tested it. Seems like the
equivalent of what we do with v1 with PCRE2_JIT_COMPLETE.

I *am* curious if there's setups where fixing the code for PCRE v1 isn't
purely an academic exercise. Is there a reason for why these platforms
can't just move to PCRE v2 in principle (dumpster fires in "next"
non-withstanding)?

>> To the extent that we'd want to make this sort of thing configurable, I
>> wonder if a continuation of my (*NO_JIT) patch isn't better, i.e. just
>> adding the ability to configure some string we'd inject at the start of
>> every pattern.
>
> looking at the number of lines of code, it would seem the configuration
> approach is simpler.
>
>> That would allow for setting any other number of options in
>> pcre2syntax(3) without us needing to carry config for each one,
>> e.g. (*LIMIT_HEAP=3Dd), (*LIMIT_DEPTH=3Dd) etc. It does present a larger
>> foot-gun surface though...
>
> the parameters I suspect users might need are not really accessible throu=
gh
> that (ex: jit stacksize).
>
> it is important to note that currently we are not preventing any user to =
use
> those flags themselves in their patterns either.
