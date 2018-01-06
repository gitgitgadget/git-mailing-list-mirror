Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1DA71F406
	for <e@80x24.org>; Sat,  6 Jan 2018 13:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeAFNcj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 08:32:39 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37961 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeAFNch (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 08:32:37 -0500
Received: by mail-wm0-f51.google.com with SMTP id 64so6898765wme.3
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 05:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ctTePYcpd5R7ouOkwS6bwOYfNWSmwIv4q6YGpcR4WXk=;
        b=Due0FwXadA8aDQbX32QPLqAve1+sSR5KtZ5M3Se76RG3yjQM0Xctdd+JgHNgZloDXB
         lwlTijTeEIEJmY90ep7TbXoj2z0qXgH99gGNl5b9X/fcZSv9T2ehN1mSC8nUBEjKY4yp
         cJDU8zUkGNWFZzlmDK+6cG2DhxOgu5YGoQYv3TsJbkGmgPaRONFegsIYeC78VtB17epL
         64pgbo9Mx8PJxfOkq6Fu/IvsfVDbg7ZBFPcyM7907o3nrzU93gAfrsfwnIud/Djqhywn
         n/lw/spJdhZuHxZLxzecuEvoCi0u4gUKgAw1LS+Zbr5FWU18YRCBh0JtvN/zk2zuiDTl
         PKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ctTePYcpd5R7ouOkwS6bwOYfNWSmwIv4q6YGpcR4WXk=;
        b=gPFXjYr9iSSt2DtaOJ7ka3ZuXZkP7yCSpxrre7R7+TvH0oi0b5Q2DSf8qcGuyRHbPa
         23NbodUhlm5g8mcohLj7m/qXT+zpXOYugT7RM8rPVU9Ua0pX38+zFV0vOUzxLGmBqrZn
         JP2K5xUAXq0RAGlf5asF/kgZ54kej4cjJHIHt9iI5pIKjulCcn3RBoFNLUulfQnW/rlQ
         Pfsz8DTAHV6YQXPbo7gyuu0uaRRv6xYuNAhof1A51CLQ09LnXcXgpR57PzkP5IuDGZch
         4C+HWhZbyADN0g9Y4naxoYyx5SXZFSVVW95BoONZRzOtRe5cInG0wwNVl8wwXJoqBfk8
         Zq2g==
X-Gm-Message-State: AKGB3mJXA+u9u8uGve3+jX/Ph5B72pIYTpvPmodOW5d4rVf72CYdWKjD
        vSr16z1/ZwPDMylNukfKhlI=
X-Google-Smtp-Source: ACJfBosJ60wodYJ1v9CP9+TwDxsv91OZu8ZZoiIqfhmZjq2zYv0V6A2vMGqFzmTOjEie3fdlCTnnMA==
X-Received: by 10.80.206.67 with SMTP id k3mr8807555edj.153.1515245556174;
        Sat, 06 Jan 2018 05:32:36 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x28sm5917496edd.0.2018.01.06.05.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Jan 2018 05:32:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on Windows proper
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Date:   Sat, 06 Jan 2018 14:32:34 +0100
Message-ID: <87mv1raz9p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 06 2018, Johannes Schindelin jotted:

> Hi Junio,
>
> On Fri, 5 Jan 2018, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>> > Skip the newly added file creation tests on Windows proper, these
>> > already work under Cygwin, but as that involves a significant
>> > emulation layer the results are different under Windows proper with
>> > MinGW.
>> > ...
>> > diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
>> > index f606f91acb..50a53e7a62 100755
>> > --- a/t/t3070-wildmatch.sh
>> > +++ b/t/t3070-wildmatch.sh
>> > @@ -7,6 +7,14 @@ test_description='wildmatch tests'
>> >  create_test_file() {
>> >  	file=$1
>> >
>> > +	# These tests limp along under Cygwin, but the failures on
>> > +	# native Windows are still too many. Skip file tests there
>> > +	# until they're sorted out.
>> > +	if test_have_prereq MINGW
>> > +	then
>> > +		return 1
>> > +	fi
>> > +
>>
>> That looks to be a nuclear option.
>
> Indeed:
>
> 	# still have 84 known breakage(s)
> 	# failed 52 among remaining 1428 test(s)
> 	1..1512
>
> Let's just switch it off completely because 52 of those 1512 test cases
> break only on Windows? Pretty heavy-handed.

Can you please provide me with the output of the test under -v -x -d
from github.com:avar/git.git wildmatch-refactor-8 branch?

It has some improvements that should make things a bit faster for you,
but also most of the logic is now in test_expect_success so -x is more
helpful.

I should then be able to fix these 52 remaining cases (and at least 1 of
them should be fixed already).

> But do read on.
>
>> For now it may be suffice, but somehow it feels that it goes directly
>> against Dscho's wish to treat (or pretend to treat) Windows as
>> first-class citizens and/or just like other platforms.
>
> It not only goes against my wish to treat Windows as a normal citizen
> instead of like Rey's parents, it also goes against my wish to have a
> focused and meaningful test suite. Nobody likes to run tests that take too
> long. And look at this:
>
> 	...
> 	ok 1511 - ipathmatch: match 'Z' '[Z-y]'
> 	ok 1512 - ipathmatch(ls): match '[Z-y]' 'Z'
> 	# still have 84 known breakage(s)
> 	# failed 52 among remaining 1428 test(s)
> 	1..1512
>
> 	real    5m51.432s
> 	user    0m33.986s
> 	sys     2m13.162s
>
> Yep. It takes *over eight minutes*.
>
> And this is a *fast* machine.
>
> Why? Because of the completely overboard testing of all kinds of
> *potential* breakages *at some point* in the future.
>
> I understand that Ævar wants to increase test coverage. I am sympathetic
> to this cause.
>
> But I completely disagree that increasing the test coverage beyond reason
> is a good thing. Tests *can* take too long, and they do, in practice, and
> the results are always problematic: every developer who has to deal with
> test suites that take too long... does not run them. As simple as that.
> And then you have *zero* test coverage. Pretty stupid, eh? And contrary to
> your intentions, too.
>
> So yes, I think that it has been proven beyond any doubt that t3070 takes
> *waaaaaaaaaay* too long on Windows, for dubitable benefit.
>
> I could see a reasonable compromise where
>
> - an extensive test matrix is hidden behind an EXPENSIVE_WILDMATCH prereq,
>
> - the test matrix would be written in a much more understandable way, i.e.
>   using English words rather than "1"s. If need be, there could be blocks
>   ("test this with case-sensitive matching", "skip case-sensitive matching",
>   you get the idea),

I take your point with the readability of some of this stuff, and will
get around to fixing that before the next submission.

> - these magic skippings of certain test cases (where the (non-traced)
>   `create_test_file()` function returns 1 for certain things) still would
>   need to go away, in favor probably of prereqs and/or blocks where flags
>   are set accordingly in a preamble,

This is a lot of work for dubious benefit. I'm not going to try to
maintain some exhaustive mapping that's potentially going to be a hash
4-levels deep of:

    os.os_version.fs.vs_version

And that's before we'd get to the potential 6-level crazyness of:

    os.os_version.os_flags.fs.vs_version.fs_flags

It's way easier and more portable (even to OSs or FSs nobody's invented
yet) to just test whether a file can be created, and if not skip the
test.

As I explained in 20180105221222.28867-1-avarab@gmail.com the actual
benefit of this test is that as much as possible is tested
*somewhere*. There's no reason to suspect that e.g. Linux will overnight
make the character ":" illegal in filenames and we'll be the only ones
who notice it.

Since we don't treat ":" or any other character differently for the
purposes of glob matching on Windows, but *do* treat the raw glob
matching differently than calling wildmatch() directly, as the current
tests do, I really don't see what the point of this exercises would be.

> - by default, i.e. without the EXPENSIVE_WILDMATCH prereq, it should test
>   a *tiny* subset that is indicative of the most likely bugs.

> As it is, I like 8/7 in the present form for all the wrong reasons: it
> protects me from the damage a full t3070 would do to me.

This test takes around 8 seconds to run on a 3.4GHz i7 on Linux, and
around 4 seconds on a 2.6GHz i5 on my SSD laptop on Linux.

I agree that there should be some prerequisite to skip this on Windows
by default since 6 minutes is clearly excessive (although I think you'll
find it runs a bit faster in the branch above), but that should be
something like:

    test_lazy_prereq EXPENSIVE_ON_WINDOWS '
            test -n "$GIT_TEST_LONG" || test_have_prereq !MINGW,!CYGWIN
    '

As the long runtime is not inherent to the test, but to excessive
slowness caused by certain operations on certain platforms, or maybe it
should be EXPENSIVE_ON_SLOW_FS or EXPENSIVE_IF_FORKING_IS_SLOW or if
we'd like to generalize it.
