Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8511F461
	for <e@80x24.org>; Tue, 14 May 2019 09:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENJlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:41:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41124 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:41:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so21914021edd.8
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=J70a4LNWwLK3iS/f3pBvXkGMvju+7BG8coY3Ot8k7cc=;
        b=o+DcV0K3q95ONgJhRLpPi1TbqrKhHAXlPbk0VIgCPKGNrfM0qLaxTxlvcbqkUjc0Xt
         ieWN9d2jmiif3le7l7+EV9YaanhPulPCYl40qLzsWeBQSuLpCTYd9Mv7d6XC1A16UyQs
         vWRAkNZEmWzAAJbciuO5cs3L8RKNCbuCrWAneRO486wkHtg6XrfkuE6/HIyLCnLmJ3Rr
         URgoCE31eHK422SZk0Km3znd5McGs0k5NB9B826VV+xVsQZ3DtC/B2bIbNUzzYoMCNM5
         mNLBwKS0bvZTuDRdqhXqHOjXDMKoQrOY19uZIokSxaIolkAkTokd2AuRKPA69vxQkCRV
         1s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=J70a4LNWwLK3iS/f3pBvXkGMvju+7BG8coY3Ot8k7cc=;
        b=B/QrbzsKcT548vkgxNTiaAA21lj6+/aIaYU+FnfmOzZAi/HPmBnpVJva85/E3Qwoyy
         dAs11OCG2XLKZaSz3cd7vhpQb8aGB7JVsUOsITu/lNGpMtuT2tZNVD1wv0oxqQI++tpD
         PycJpd+zWUWlcSAZS1QCn+EQxS+nCbEeBXluZIF+CaEjwKVDeqPNWSVebT1mVgtWyLN0
         Ojqk05sT1uzLKbHkP1ziYPFI/+3MFa+SGnOsw0ChNAmnjBPPyyyllvNdem7b+/NNe/Z5
         X4I5d5MfC7JJlL8s9lILeHIz1XnalJE/fbxc1UYCPRFuQ7qw6rb7MXq6sKCWmLxuWRRO
         IIrA==
X-Gm-Message-State: APjAAAUGtw4mSIGnCpk2wD8Jj9v9dv3YejEaRwd4I0r1diPj9sacFW4V
        nVuo3Lf/u1NlixfFlpCK3QA=
X-Google-Smtp-Source: APXvYqy/hTFAVzm4ZtiiMJ9PmVjQ9OGJHgN043unHe1m121PGSsDuUUxhDOZuL9s6U2KqtNoT36w2g==
X-Received: by 2002:a50:9266:: with SMTP id j35mr35822164eda.60.1557826912605;
        Tue, 14 May 2019 02:41:52 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id 96sm2959774edq.68.2019.05.14.02.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:41:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH] tests: add a special setup where prerequisites fail
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <20190513183242.10600-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet>
Date:   Tue, 14 May 2019 11:41:51 +0200
Message-ID: <87lfz9wexs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 13 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> As discussed in [1] there's a regression in the "pu" branch now
>> because a new test implicitly assumed that a previous test guarded by
>> a prerequisite had been run. Add a "GIT_TEST_FAIL_PREREQS" special
>> test setup where we'll skip (nearly) all tests guarded by
>> prerequisites, allowing us to easily emulate those platform where we
>> don't run these tests.
>>
>> As noted in the documentation I'm adding I'm whitelisting the SYMLINKS
>> prerequisite for now. A lot of tests started failing if we lied about
>> not supporting symlinks. It's also unlikely that we'll have a failing
>> test due to a hard dependency on symlinks without that being the
>> obvious cause, so for now it's not worth the effort to make it work.
>
> I don't know... In Git for Windows, the SYMLINKS prereq is not met.
>
> (Side note: Windows 10 already supports symlinks for quite some time, even
> for non-admin developers, but the fact that Git's test suite is
> implemented in shell script bites us yet one more time: MSYS2 has a
> completely different idea what symlinks are. It uses the "system file" bit
> that only exists on Windows, and if that is set, reads the beginning of
> the file, and if that reads "!<symlink>" (interpreted as ASCII), then the
> rest of that system file is interpreted as the symlink target.)
>
> So it makes me worry if you say that you had to exclude the SYMLINK
> prereq. Maybe all the dependent tests have different prereqs that just so
> happen *also* not to be met on Windows?

I should have clarified this. What I mean is that it leaves SYMLINK
alone, i.e. what was breaking is that on Linux we don't deal with
pretending that we don't support symlinks, these tests should still work
just fine on Windows (or anywhere SYMLINKS is genuinely false), since
there we actually back up our promise not to support them.

>> 1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1905131531000.44@tvgsb=
ejvaqbjf.bet/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> On Mon, May 13 2019, Johannes Schindelin wrote:
>>
>> > [...]
>> > Namely, when test cases 51 and 52 are skipped because of a missing GPG
>> > prerequisite [*1*], and those two are obviously required to run for the
>> > `git merge to fail in your test case, as you can very easily verify by
>> > downloading the artifact containing the `trash directory.t7600-merge`
>> > directory and re-running the last steps on Linux (where the `git -c
>> > rerere.enabled=3Dtrue merge master` *succeeds*).
>> >
>> > In fact, you can very, very easily emulate the whole situation on your=
 box
>> > by running:
>> >
>> > 	sh t7600-merge.sh -i -v -x --run=3D1-50,53-59
>> >
>> > And then you can fix your test case so that it does not need to rely on
>> > test cases that may, or may not, have run previously.
>>
>> I think it would be better to more pro-actively spot this sort of
>> thing in the future, so here's a patch to do that. It passes on
>> "master", but fails on "pu" due to the issue with the one test being
>> discussed here.
>
> It does drive me nuts that the `--run=3D<N>` option exists (thank you,
> Slavica, for teaching me!) and is so poorly supported by our test suite.
>
> For example, if t7600.59 fails, it would make a ton of sense to run
>
> 	sh t7600-merge.sh -i -v -x --run=3D59
>
> right?
>
> Except that we frequently have at least one "test case" whose only purpose
> is to set things up.
>
> But we never declare explicitly "test case 59 requires test case 51 to run
> first".
>
> We do not even declare the test cases: we execute them immediately. So we
> would not even be able to juggle them about, e.g. run them in reverse
> (which would otherwise be the easiest way to get rid of almost all side
> effects).
>
> I think in the long run, we'll have to drag Git's test suite into the 21st
> century (kicking and screaming, I'm sure), to have a more declarative
> style, with those features that one might know from Mocha, Jest, JUnit,
> xUnit.NET, etc.
>
> Back to your patch: it only catches prereq problems. But the `--run=3D59`
> thing would still not be addressed.

Yeah that would be a nice-to-have but unrelated thing (and a much bigger
task). We'd need to split up "this is setup code" v.s. "this is a test",
or make each individual test declare its dependency graph, which could
get quite verbose.

> What would you think about a mode where random test cases are skipped? It
> would have to make sure to provide a way to recreate the problem, e.g.
> giving a string that defines exactly which test cases were skipped.
>
> I am *sure* that tons of test scripts would fail with that, and we would
> probably have to special-case the `setup` "test cases", and we would have
> to clean up quite a few scripts to *not* execute random stuff outside of
> `test_expect_*`...

I think it would be neat, but unrelated to and overkill for spotting the
practical problem we have now, which is that we *know* we skip some of
this now on some platforms/setups due to prereqs.

>> diff --git a/t/README b/t/README
>> index 6404f33e19..9747971d58 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -334,6 +334,15 @@ that cannot be easily covered by a few specific tes=
t cases. These
>>  could be enabled by running the test suite with correct GIT_TEST_
>>  environment set.
>>
>> +GIT_TEST_FAIL_PREREQS<non-empty?> fails all prerequisites. This is
>
> Did you mean to insert `=3D` after `GIT_TEST_FAIL_PREREQS`?

Yeah, will fix.

>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 819c24d10e..c20209324c 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -352,7 +352,7 @@ test_expect_success 'log with grep.patternType confi=
guration and command line' '
>>  	test_cmp expect actual
>>  '
>>
>> -test_expect_success 'log with various grep.patternType configurations &=
 command-lines' '
>> +test_expect_success !FAIL_PREREQS 'log with various grep.patternType co=
nfigurations & command-lines' '
>
> Is this an indication of a bug in this test case?
>
>>  	git init pattern-type &&
>>  	(
>>  		cd pattern-type &&
>> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
>> index 7855bd8648..aa33978ed2 100755
>> --- a/t/t7405-submodule-merge.sh
>> +++ b/t/t7405-submodule-merge.sh
>> @@ -417,7 +417,7 @@ test_expect_failure 'directory/submodule conflict; k=
eep submodule clean' '
>>  	)
>>  '
>>
>> -test_expect_failure 'directory/submodule conflict; should not treat sub=
module files as untracked or in the way' '
>> +test_expect_failure !FAIL_PREREQS 'directory/submodule conflict; should=
 not treat submodule files as untracked or in the way' '
>
> Same here?
>
>>  	test_when_finished "git -C directory-submodule/path reset --hard" &&
>>  	test_when_finished "git -C directory-submodule reset --hard" &&
>>  	(
>> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
>> index 2e1bb61b41..7d7b396c23 100755
>> --- a/t/t7810-grep.sh
>> +++ b/t/t7810-grep.sh
>> @@ -412,7 +412,7 @@ do
>>  		test_cmp expected actual
>>  	'
>>
>> -	test_expect_success !PCRE "grep $L with grep.patterntype=3Dperl errors=
 without PCRE" '
>> +	test_expect_success !FAIL_PREREQS,!PCRE "grep $L with grep.patterntype=
=3Dperl errors without PCRE" '
>
> And here?
>
>>  		test_must_fail git -c grep.patterntype=3Dperl grep "foo.*bar"
>>  	'
>>
>> @@ -1234,7 +1234,7 @@ test_expect_success PCRE 'grep --perl-regexp patte=
rn' '
>>  	test_cmp expected actual
>>  '
>>
>> -test_expect_success !PCRE 'grep --perl-regexp pattern errors without PC=
RE' '
>> +test_expect_success !FAIL_PREREQS,!PCRE 'grep --perl-regexp pattern err=
ors without PCRE' '
>
> And here?
>
>>  	test_must_fail git grep --perl-regexp "foo.*bar"
>>  '
>>
>> @@ -1249,7 +1249,7 @@ test_expect_success LIBPCRE2 "grep -P with (*NO_JI=
T) doesn't error out" '
>>
>>  '
>>
>> -test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
>> +test_expect_success !FAIL_PREREQS,!PCRE 'grep -P pattern errors without=
 PCRE' '
>
> And here?

To all of the above: Not a bug, I guess it could be refactored as an
unrelated fix, but it's tests of the form "without this prereq we should
die", so of course if I lie about not having it where I *do* have it it
won't die.

>>  	test_must_fail git grep -P "foo.*bar"
>>  '
>>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 8270de74be..0367cec5fd 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -309,6 +309,26 @@ test_unset_prereq () {
>>  }
>>
>>  test_set_prereq () {
>> +	if test -n "$GIT_TEST_FAIL_PREREQS"
>> +	then
>> +		case "$1" in
>> +		# The "!" case is handled below with
>> +		# test_unset_prereq()
>> +		!*)
>> +			;;
>> +		# (Temporary?) whitelist of things we can't easily
>> +		# pretend not to support
>> +		SYMLINKS)
>> +			;;
>> +		# Inspecting whether GIT_TEST_FAIL_PREREQS is on
>> +		# should be unaffected.
>> +		FAIL_PREREQS)
>> +			;;
>> +		*)
>> +			return
>> +		esac
>> +	fi
>> +
>
> I would probably have done that on the reading side rather than the
> writing side ;-)

I started out by doing that (I'll note so in the v2 commit message), but
found it much harier, in that function we need to deal with the lazy
prereqs v.s. non-lazy, so I'd need to change multiple branches of that
or refactor it, all that stuff calls test_set_prereq() after it
discovers what the prereq is, so doing it here is much easier &
straightforward.

>>  	case "$1" in
>>  	!*)
>>  		test_unset_prereq "${1#!}"
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 908ddb9c46..6fabafebb3 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1607,3 +1607,7 @@ test_lazy_prereq SHA1 '
>>  test_lazy_prereq REBASE_P '
>>  	test -z "$GIT_TEST_SKIP_REBASE_P"
>>  '
>> +
>> +test_lazy_prereq FAIL_PREREQS '
>> +	test -n "$GIT_TEST_FAIL_PREREQS"
>> +'
>> --
>> 2.21.0.1020.gf2820cf01a
>>
>>
