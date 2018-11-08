Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5B01F453
	for <e@80x24.org>; Thu,  8 Nov 2018 20:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKIGDa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:03:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40682 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:03:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id a14-v6so13262988edr.7
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VXoFkomvB1fEirf+7LWdXiDT+kvxUC8lc60rgxzK32E=;
        b=lQu3dwWSBgge/I9aUWStC9UfN5GqjBU/0lU+w/AacUkP+COLxm9O+JnfYDQgWM0bVo
         G01hW4kYyv8XWx/XGY34bxxX0Et4ZUFypoQUFmq2s2hS77S0wQaY9GHoQ3Ieg69lKPwS
         8Cbtezj5GJ6hergTioO+T4zmLP7lI4hA5zC4IM86iVsNspezc9BVDnmeM+itemIyRLVy
         H5uELXeeqpfXCTzGGyZuNrRgiFiCf8V9UqldBhr5IEN1h2tTUSG+1FdsXEOgOhzCuo0d
         HttYn+VFy0FTTPq6XqzyNmof90IJXinfBRDHkzx6X9ludgUAQc3uVK/StyJDYuAsQo0z
         kkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VXoFkomvB1fEirf+7LWdXiDT+kvxUC8lc60rgxzK32E=;
        b=L4/Je3T8vF7Cqd6mS0UlfQqH3FQHZODXb0rvSy+B6rGtdTO1wUD/d+5CiBGxp6xMrP
         ib6l4UzVsUg8FoGcfyoIFDjsWL5fKebA5fOT0XX28AMRTo87OIlVZ1PzihXoKf4DCSK0
         dzOtdNgPVQTR4sI2t44hIN1TRKkokH51R/Leuzujg4W338w8upaFUqXfd6poT0tvtpV8
         +yRUIrgcAIWniBM/0bt0lpE3EJ5TNsrCcjD31anUUzsTQJyOBg7yirIkxZReoOa+EQPx
         9oTjX5OU6DQ11h9jOUb4oCmtg0pFsYjZMAmgD0n/0nApxArG5xRIgogYLlkZJNHtvjNu
         s87g==
X-Gm-Message-State: AGRZ1gKVSWgwnreQn091yYuj5iw5QRHo3c8GXtytpyAN1kCEJJxU8PBL
        /8ePFEirGUbYuADKGqXTLXFI4u9F
X-Google-Smtp-Source: AJdET5c/qdn30tBHdZEI1/yhjEizyWDlZRv20hCNUhFWr6HMoKZK95iuUO/jrYYY/Bdn4EhyMLbk1A==
X-Received: by 2002:a50:9b52:: with SMTP id a18-v6mr5085716edj.246.1541708781615;
        Thu, 08 Nov 2018 12:26:21 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id h4-v6sm1349280edd.33.2018.11.08.12.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 12:26:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
References: <20181024114725.3927-1-avarab@gmail.com> <20181101193115.32681-1-avarab@gmail.com> <20181102163725.GY30222@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181102163725.GY30222@szeder.dev>
Date:   Thu, 08 Nov 2018 21:26:19 +0100
Message-ID: <87muqj5n9w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 02 2018, SZEDER Gábor wrote:

> On Thu, Nov 01, 2018 at 07:31:15PM +0000, Ævar Arnfjörð Bjarmason wrote:
>> Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
>> test parameter to only be a GIT_TEST_GETTEXT_POISON=<non-empty?>
>> runtime parameter, to be consistent with other parameters documented
>> in "Running tests with special setups" in t/README.
>>
>> When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
>> to simulate unfriendly translator", 2011-02-22) I was concerned with
>> ensuring that the _() function would get constant folded if NO_GETTEXT
>> was defined, and likewise that GETTEXT_POISON would be compiled out
>> unless it was defined.
>>
>> But as the benchmark in my [1] shows doing a one-off runtime
>> getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
>> originally added the GIT_TEST_* env variables have become the common
>> idiom for turning on special test setups.
>>
>> So change GETTEXT_POISON to work the same way. Now the
>> GETTEXT_POISON=YesPlease compile-time option is gone, and running the
>> tests with GIT_TEST_GETTEXT_POISON=[YesPlease|] can be toggled on/off
>> without recompiling.
>>
>> This allows for conditionally amending tests to test with/without
>> poison, similar to what 859fdc0c3c ("commit-graph: define
>> GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
>> some of that, now we e.g. always run the t0205-gettext-poison.sh test.
>>
>> I did enough there to remove the GETTEXT_POISON prerequisite, but its
>> inverse C_LOCALE_OUTPUT is still around, and surely some tests using
>> it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=.
>>
>> Notes on the implementation:
>>
>>  * We still compile a dedicated GETTEXT_POISON build in Travis CI.
>>    This is probably the wrong thing to do and should be followed-up
>>    with something similar to ae59a4e44f ("travis: run tests with
>>    GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
>>    for running in the GIT_TEST_GETTEXT_POISON mode.
>
> I'm of two minds about this.  Sure, now it's not a compile time
> option, so we can spare a dedicated compilation, and sparing resources
> is good, of course.
>
> However, checking test failures in the 'linux-gcc' build job is always
> a bit of a hassle, because it's not enough to look at the output of
> the failed test, but I also have to check which one of the two test
> runs failed (i.e. the "regular" or one with all the GIT_TEST_* knobs
> turned on).  Adding a second test run with GIT_TEST_GETTEXT_POISON
> enabled to an other build job (e.g. 'linux-clang') would then bring
> this hassle to that build job as well.
>
> Furthermore, occasionally a build job is slower than usual (whatever
> the reason might be), which can be an issue when running the test
> suite twice, as it can exceed the time limit.
>
> Anyway, we can think about this later.
>
> In any case, GIT_TEST_GETTEXT_POISON definitely should not be enabled
> in the same "catch-all" test run with all other GIT_TEST_* variables,
> because it would mess up any translated error messages that might pop
> up in a test failure, and then we wouldn't have any idea about what
> went wrong.

Will clarify this in v3. I.e. "let's think about this...".

>>  * We now skip a test in t0000-basic.sh under
>>    GIT_TEST_GETTEXT_POISON=YesPlease that wasn't skipped before. This
>>    test relies on C locale output, but due to an edge case in how the
>>    previous implementation of GETTEXT_POISON worked (reading it from
>>    GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
>>    and needs to be skipped.
>>
>>  * The getenv() function is not reentrant, so out of paranoia about
>>    code of the form:
>>
>>        printf(_("%s"), getenv("some-env"));
>>
>>    call use_gettext_poison() in our early setup in git_setup_gettext()
>>    so we populate the "poison_requested" variable in a codepath that's
>>    won't suffer from that race condition.
>>
>> See also [3] for more on the motivation behind this patch, and the
>> history of the GETTEXT_POISON facility.
>>
>> 1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
>> 2. https://public-inbox.org/git/87woq7b58k.fsf@evledraar.gmail.com/
>> 3. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> Now:
>>
>>  * The new i18n helper is gone. We just use "test -n" semantics for
>>    $GIT_TEST_GETTEXT_POISON
>>
>>  * We error out in the Makefile if you're still saying
>>    GETTEXT_POISON=YesPlease.
>>
>>    This makes more sense than just making it a synonym since now this
>>    also needs to be defined at runtime.
>
> OK, I think erroring out is better than silently ignoring
> GETTEXT_POISON=YesPlease.  However, the commit message only mentions
> that GETTEXT_POISON is gone, but perhaps this should be mentioned
> there as well.

Will mention.

>>  * The caveat with avoiding test_lazy_prereq is gone (although there's
>>    still some unrelated bug there worth looking into).
>>
>>  * We call use_gettext_poison() really early to avoid any reentrancy
>>    issue with getenv().
>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 175f83d704..3c6b185b60 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1697,7 +1697,8 @@ test_expect_success 'sourcing the completion script clears cached commands' '
>>  	verbose test -z "$__git_all_commands"
>>  '
>>
>> -test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
>> +test_expect_success 'sourcing the completion script clears cached merge strategies' '
>> +	GIT_TEST_GETTEXT_POISON= &&
>>  	__git_compute_merge_strategies &&
>
> OK, makes sense.
>
>>  	verbose test -n "$__git_merge_strategies" &&
>>  	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 78d8c3783b..2f42b3653c 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -755,16 +755,16 @@ test_cmp_bin() {
>>
>>  # Use this instead of test_cmp to compare files that contain expected and
>>  # actual output from git commands that can be translated.  When running
>> -# under GETTEXT_POISON this pretends that the command produced expected
>> +# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
>>  # results.
>>  test_i18ncmp () {
>> -	test -n "$GETTEXT_POISON" || test_cmp "$@"
>> +	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
>>  }
>
>>  test_i18ngrep () {
>>  	eval "last_arg=\${$#}"
>> @@ -779,7 +779,7 @@ test_i18ngrep () {
>>  		error "bug in the test script: too few parameters to test_i18ngrep"
>>  	fi
>>
>> -	if test -n "$GETTEXT_POISON"
>> +	if test_have_prereq !C_LOCALE_OUTPUT
>
> Why do these two helper functions call test_have_prereq (a function
> that doesn't even fit on my screen) instead of a simple
>
>   test -n "$GIT_TEST_GETTEXT_POISON"

I'm going to keep the call to test_have_prereq, it's consistent with
other use of the helper in the test lib, and doesn't confuse the reader
by giving the impression that we're in some really early setup where we
haven't set the prereq at this point (we have).

>>  	then
>>  		# pretend success
>>  		return 0
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 897e6fcc94..370a4821e1 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1105,12 +1105,8 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
>>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
>>
>>  # Can we rely on git's output in the C locale?
>> -if test -n "$GETTEXT_POISON"
>> +if test -z "$GIT_TEST_GETTEXT_POISON"
>>  then
>> -	GIT_GETTEXT_POISON=YesPlease
>> -	export GIT_GETTEXT_POISON
>> -	test_set_prereq GETTEXT_POISON
>> -else
>>  	test_set_prereq C_LOCALE_OUTPUT
>>  fi
>
> GIT_TEST_GETTEXT_POISON=1 will influence even those git commands that
> are executed during initialization of test-lib and the test repo:
>
>   $ GIT_TEST_GETTEXT_POISON=1 ./t0000-basic.sh -v
>   # GETTEXT POISON #expecting success:
>   <....>
>
> It should say:
>
>   Initialized empty Git repository in <... path ...>
>   expecting success:
>
> See https://public-inbox.org/git/20181022202241.18629-2-szeder.dev@gmail.com/
> for a bit of code that you might find worthy to steal.

Thanks. Fixing.
