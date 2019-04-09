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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DDF20248
	for <e@80x24.org>; Tue,  9 Apr 2019 09:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDIJOw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 05:14:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 05:14:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id k45so188693edb.6
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1weg5tMZaOESshry/AWqkdvjrxOh22y3cK6ol0Ep4eA=;
        b=WLFdjLc5m2uKrXLEwpUb9a7/UpT9lj514C0yjeistel3rcTwI2euGlho3vI1A5B8Zp
         a9hLHeFfU2RquV1jL/y1vyjtV3HxkoZnnkqAGqpkp5mDt6ufOmCm+8BpH0wC9bxWx1fy
         zhrW4ChmhxP1g8Au0X+0tZb3qISdCYYGOa2WJeQIamEq13rNDGjbhro/jEI6dfgwPHpU
         9Q8g5QnN5nwwxkKbwk5H6KfKKuWgZJAbNkGn32pP4kxlXCxV0G1SA5ZlxTKwoVGVo6Cx
         Wpd5qdMZsSPYKagw03NtZlfvgvgGpuxSJxD/NBote1ScApi6ZqEyrPZHvdpE0UQno1uu
         1riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1weg5tMZaOESshry/AWqkdvjrxOh22y3cK6ol0Ep4eA=;
        b=eRN8EUg1G9oRXJk6PAIfuJci59zdrmYhosfjZrMPMmlQStJWfKmU+TUWrfWdBQJ933
         Wg/akToAAf1veaHkExoNuDG7QTAvJ67TRnm7Nf9SLVVAvevYqaTxsnIPKRe306ymnn8B
         VuBNWjYCRBL3Q/qCnQhvp43KjXyJKQWNFFspnUefnJN1Kt29cwNJJQQZOeEKg5WceynO
         i23uFCemW8+QMA2Opgi8Qga+Xo+jutnDjSJ1mvWOyh2JI3ENpgSwjl/q11/nUt98VMTA
         +xGBaMKTg7ZwnfY4+KliyZcN4EifBXYG/Bl/OQKP+bJ71iLjlY4Ly9K+WfLpzgysE66e
         hebA==
X-Gm-Message-State: APjAAAUnm3DxGQk+jc+tc9D4UXeliDSgx0mmkL46aN8wbp1hcp2bfFaX
        mZfsaX+u7oLy6g/U9XNM2gY=
X-Google-Smtp-Source: APXvYqwxjaS0fVoBygth3Keppr3vnvWslnw9UturJoWCLPZKzfcqARL0jzwuvveiHsU0SXWOKli0Hg==
X-Received: by 2002:a50:c9c4:: with SMTP id c4mr7237604edi.107.1554801289441;
        Tue, 09 Apr 2019 02:14:49 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x17sm2458370eds.16.2019.04.09.02.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:14:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
References: <cover.1554435033.git.me@ttaylorr.com> <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com> <20190405105033.GT32732@szeder.dev> <20190405182412.GC2284@sigill.intra.peff.net> <20190405184229.GB8796@szeder.dev> <20190405185241.GG2284@sigill.intra.peff.net> <87a7h1a5uk.fsf@evledraar.gmail.com> <20190409022936.GE81620@Taylors-MBP.hsd1.wa.comcast.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190409022936.GE81620@Taylors-MBP.hsd1.wa.comcast.net>
Date:   Tue, 09 Apr 2019 11:14:48 +0200
Message-ID: <871s2ba6bb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 09 2019, Taylor Blau wrote:

> Hi =C3=86var,
>
> On Sun, Apr 07, 2019 at 11:00:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, Apr 05 2019, Jeff King wrote:
>>
>> > On Fri, Apr 05, 2019 at 08:42:29PM +0200, SZEDER G=C3=A1bor wrote:
>> >
>> >> > > Don't run git commands upstream of a pipe, because the pipe hides
>> >> > > their exit code.  This applies to several other tests below as we=
ll.
>> >> >
>> >> > I disagree with that rule here. We're not testing "cat-file" in any
>> >> > meaningful way, but just getting some stock output from a known-good
>> >> > commit.
>> >>
>> >> It makes auditing harder and sets bad example.
>> >
>> > I disagree that it's a bad example. Just because a reader might not
>> > realize that it is sometimes OK and sometimes not, does not make it bad
>> > to do so in the OK case. It means the reader needs to understand the
>> > rule in order to correctly apply it.
>>
>> FWIW I thought the rule was something to the effect of "we're hacking on
>> git, any change might segfault in some unexpected test, let's make sure
>> that fails right away", hence the blanket rule in t/README against "!
>> git <cmd>" in favor of "test_must_fail git <cmd>", and "don't feed the
>> output of a git command to a pipe" documented right after that.
>
> I have some loosely-held opinions on this. Certainly knowing if a change
> to git caused a segfault in some test is something that we would want to
> know about, though I'm not sure we're loosing anything by putting 'git'
> on the left-hand side of a pipe here.
>
>   - If someone wrote a change to git that introduced a segfault in 'git
>     cat-file', I'm sure that this would not be the only place that in
>     the suite that would break because of it. Presumably, at least one
>     of those places uses 'test_must_fail git ...' instead
>
>   - At the very least, 'broken-commit' doesn't contain what it needs to,
>     the test breaks in another way (albeit further from the actual
>     defect), and the developer finds out about their bug that way.
>
> In any case, these above two might be moot anyways, because I'm almost
> certain that it will be a rarity for someone to _only_ run t6102, unless
> it is included in a blanket 'make' from within 't'.

First. I realize we're talking about the light fixtures in the bike shed
at this point, but with that in mind...

I just think it's useful as a general rule, particularly since with the
"special setups" in the test mode we've found that all sorts of odd
tests we didn't expect to stress test some features turned out to cover
edge cases of them, e.g. when "GIT_TEST_COMMIT_GRAPH" was added we found
that a bunch of random stuff segfaulted all over the place.

So it's hard to say with any confidence in advance that something isn't
going to stress git in some unusual way and isn't useful to guard for
segfaults.

Of course if and when it segfaults it's likely to be seen by subsequent
tests. In this case I'll note that if git fails we'll happily run not
only perl/sed, but then hash-object the subsequent empty file, and then
(presumably) fail in the next test.

>> > I am sympathetic to the auditing issue, though.
>
> Just to satisfy my curiosity, I put git on the left-hand side of a pipe
> to see how many such examples exist today:
>
>   ~/g/git (master) $ git grep 'git cat-file .* |' -- t/t*.sh | wc -l
>       179
>
> I'm not going to claim that changing 179 -> 180 is neutral or bad, but
> it's interesting nonetheless.

Separate from the question of if we generally agree that some value of
"Y" makes for good coding style or not, we're always going to be in some
flux state where a bunch of examples in our existing codebase contradict
that, particularly in the test suite.

I think that's a bit unfortunate in some ways. It's the result of the
default "policy" that refactoring for refactoring's sakes is generally
frowned upon, so we don't tend to go back and mass-fix "X" to "Y" once
we agree "Y" is better than "X" for new code, just do it as we go when
new code is written, or existing tests are updated for other reasons
"while we're at it".

>> > I dunno. In this case it is not too bad to do:
>> >
>> >   git cat-file commit $commit >good-commit &&
>> >   perl ... <good-commit >broken-commit
>> >
>> > but I am not sure I am on board with a blanket rule of "git must never
>> > be on the left-hand side of a pipe".
>
> I think that I mostly agree with Peff here for the reasons above.
>
> That all said, I don't really want to hold up the series for this alone.
> Since there don't seem to be many other comments or issues, I would be
> quite happy to do whatever people are most in favor of.

FWIW this series LGTM as a whole. I think it says something about the
general quality of it that we're all in some giant nitpick thread about
perl v.s. sed and git on the LHS of a pipe or not :) I'm happy to have
it queued as-is. These test issues are minor...

> I basically don't really feel strongly about writing:
>
>   git cat-file commit $commit | sed -e ... >broken-commit
>
> as opposed to:
>
>   git cat-file commit $commit >good-commit &&
>   sed -e '' <commit >bad-commit
>
>> >> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another =
perl
>> >> > > dependency?
>> >> >
>> >> > Heh, this was actually the subject of much discussion before the pa=
tches
>> >> > hit the list. If you can write such a one-liner that is both readab=
le
>> >> > and portable, please share it. I got disgusted with sed and suggest=
ed
>> >> > this perl.
>> >>
>> >> Hm, so the trivial s/// with '\n' in the replacement part is not
>> >> portable, then?  Oh, well.
>> >
>> > I don't think it is, but I could be wrong. POSIX does say that "\n"
>> > matches a newline in the pattern space, but nothing about it on the RHS
>> > of a substitution. I have a vague feeling of running into problems in
>> > the past, but I could just be misremembering.
>> >
>> > We also tried matching /^tree/ and using "a\" to append a line, but it
>> > was both hard to read and hit portability issues with bsd sed.
>
> I think that all of this discussion is addressed elsewhere in thread, but
> the gist is that Eric provided a suitable sed invocation that I am going
> to use instead of Peff's Perl.
>
>> > -Peff
>
> Thanks,
> Taylor
