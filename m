Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C667C1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeKCBpO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:45:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50773 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeKCBpO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:45:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2-v6so2532748wmb.0
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MRqNVu/ZfrY1zCuY7DfPdPFrQAEkU8y20qaC/cHAUbE=;
        b=lXzb72FOMB6/WTx5Aje23G+VFxXKX0/a5gj/RUsFY7rFHAzWoCMG/Vue3hsUM4z6lA
         1RRHoD3NF0ztfLSaLhr15ufqlacBvWT9+mRZTSctYfJrfL6eFTwxRsgk3tEv8OsfXscZ
         jSBsrmfH8kR5dxgxChm4o+qn66FSNF8dnij1kpHUTKJAHnnxz7d186pbpLk2aNPuguzR
         4iiWu4eexSDy5ljcxOrGuI6u2i/TMyAesfINca1q/YpB09LVy3/odLSYdiT545G7YTnD
         8p4K9DA37DQf+0B2qgt6r/hQP3aUGmekgrkC3KOwmRS//IoK+Mgz0TBcG3mKxodoAbac
         2AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MRqNVu/ZfrY1zCuY7DfPdPFrQAEkU8y20qaC/cHAUbE=;
        b=VUKhQZgTSQP+o9Jw0oOMEt041vFU5a3UvG7kh3GrL8kSBXwIni05dGTY5Q2MmqUhgi
         N/XS6LUulSNVouXFy+uUxcN/NkZfOsPGRs48e5so0JwVRblbC3y+qkOu0rdbcfFbL8BW
         bNkwVi9WV22HDyewtf4LskixHf5EdOrGwqOBABYP13RSD3DhFRvfwhqDmHMeAjrvvDiQ
         5ivmBLE02Aq0ZDYUbfd7smj93SNodBXHEhHz+3B1QagRdgeGPwh8w1ni+re3CUte2aN5
         8rgiw5iMqx8z13DUuwmJQ+1NufmGUjSjuRcdpKfBnxzA+R+1oV6h6hp7bXO0riyxYR2v
         koqw==
X-Gm-Message-State: AGRZ1gKezA04kSRDkFJz8ItLjREfcAc5YNpigjk+BYWSy9m8WKO/akhJ
        XHQMI+Mc9pah5ZH2goZvWRA=
X-Google-Smtp-Source: AJdET5ftUTcM8Ej+GvFtjvyLS3PQwMcDZCaFtmFT5Oc+XtP0W9LtCVFQ0mCQXhUVTSPVcY9xb8Ed4A==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206-v6mr8250wmc.78.1541176648837;
        Fri, 02 Nov 2018 09:37:28 -0700 (PDT)
Received: from szeder.dev (x4db1ea80.dyn.telefonica.de. [77.177.234.128])
        by smtp.gmail.com with ESMTPSA id y16-v6sm2837977wrn.18.2018.11.02.09.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:37:27 -0700 (PDT)
Date:   Fri, 2 Nov 2018 17:37:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181102163725.GY30222@szeder.dev>
References: <20181024114725.3927-1-avarab@gmail.com>
 <20181101193115.32681-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 07:31:15PM +0000, Ævar Arnfjörð Bjarmason wrote:
> Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
> test parameter to only be a GIT_TEST_GETTEXT_POISON=<non-empty?>
> runtime parameter, to be consistent with other parameters documented
> in "Running tests with special setups" in t/README.
> 
> When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
> to simulate unfriendly translator", 2011-02-22) I was concerned with
> ensuring that the _() function would get constant folded if NO_GETTEXT
> was defined, and likewise that GETTEXT_POISON would be compiled out
> unless it was defined.
> 
> But as the benchmark in my [1] shows doing a one-off runtime
> getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
> originally added the GIT_TEST_* env variables have become the common
> idiom for turning on special test setups.
> 
> So change GETTEXT_POISON to work the same way. Now the
> GETTEXT_POISON=YesPlease compile-time option is gone, and running the
> tests with GIT_TEST_GETTEXT_POISON=[YesPlease|] can be toggled on/off
> without recompiling.
> 
> This allows for conditionally amending tests to test with/without
> poison, similar to what 859fdc0c3c ("commit-graph: define
> GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
> some of that, now we e.g. always run the t0205-gettext-poison.sh test.
> 
> I did enough there to remove the GETTEXT_POISON prerequisite, but its
> inverse C_LOCALE_OUTPUT is still around, and surely some tests using
> it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=.
> 
> Notes on the implementation:
> 
>  * We still compile a dedicated GETTEXT_POISON build in Travis CI.
>    This is probably the wrong thing to do and should be followed-up
>    with something similar to ae59a4e44f ("travis: run tests with
>    GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
>    for running in the GIT_TEST_GETTEXT_POISON mode.

I'm of two minds about this.  Sure, now it's not a compile time
option, so we can spare a dedicated compilation, and sparing resources
is good, of course.

However, checking test failures in the 'linux-gcc' build job is always
a bit of a hassle, because it's not enough to look at the output of
the failed test, but I also have to check which one of the two test
runs failed (i.e. the "regular" or one with all the GIT_TEST_* knobs
turned on).  Adding a second test run with GIT_TEST_GETTEXT_POISON
enabled to an other build job (e.g. 'linux-clang') would then bring
this hassle to that build job as well.

Furthermore, occasionally a build job is slower than usual (whatever
the reason might be), which can be an issue when running the test
suite twice, as it can exceed the time limit.

Anyway, we can think about this later.

In any case, GIT_TEST_GETTEXT_POISON definitely should not be enabled
in the same "catch-all" test run with all other GIT_TEST_* variables,
because it would mess up any translated error messages that might pop
up in a test failure, and then we wouldn't have any idea about what
went wrong.

>  * We now skip a test in t0000-basic.sh under
>    GIT_TEST_GETTEXT_POISON=YesPlease that wasn't skipped before. This
>    test relies on C locale output, but due to an edge case in how the
>    previous implementation of GETTEXT_POISON worked (reading it from
>    GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
>    and needs to be skipped.
> 
>  * The getenv() function is not reentrant, so out of paranoia about
>    code of the form:
> 
>        printf(_("%s"), getenv("some-env"));
> 
>    call use_gettext_poison() in our early setup in git_setup_gettext()
>    so we populate the "poison_requested" variable in a codepath that's
>    won't suffer from that race condition.
> 
> See also [3] for more on the motivation behind this patch, and the
> history of the GETTEXT_POISON facility.
> 
> 1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
> 2. https://public-inbox.org/git/87woq7b58k.fsf@evledraar.gmail.com/
> 3. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Now:
> 
>  * The new i18n helper is gone. We just use "test -n" semantics for
>    $GIT_TEST_GETTEXT_POISON
> 
>  * We error out in the Makefile if you're still saying
>    GETTEXT_POISON=YesPlease.
> 
>    This makes more sense than just making it a synonym since now this
>    also needs to be defined at runtime.

OK, I think erroring out is better than silently ignoring
GETTEXT_POISON=YesPlease.  However, the commit message only mentions
that GETTEXT_POISON is gone, but perhaps this should be mentioned
there as well.

>  * The caveat with avoiding test_lazy_prereq is gone (although there's
>    still some unrelated bug there worth looking into).
> 
>  * We call use_gettext_poison() really early to avoid any reentrancy
>    issue with getenv().

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 175f83d704..3c6b185b60 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1697,7 +1697,8 @@ test_expect_success 'sourcing the completion script clears cached commands' '
>  	verbose test -z "$__git_all_commands"
>  '
>  
> -test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
> +test_expect_success 'sourcing the completion script clears cached merge strategies' '
> +	GIT_TEST_GETTEXT_POISON= &&
>  	__git_compute_merge_strategies &&

OK, makes sense.

>  	verbose test -n "$__git_merge_strategies" &&
>  	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 78d8c3783b..2f42b3653c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -755,16 +755,16 @@ test_cmp_bin() {
>  
>  # Use this instead of test_cmp to compare files that contain expected and
>  # actual output from git commands that can be translated.  When running
> -# under GETTEXT_POISON this pretends that the command produced expected
> +# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
>  # results.
>  test_i18ncmp () {
> -	test -n "$GETTEXT_POISON" || test_cmp "$@"
> +	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
>  }

>  test_i18ngrep () {
>  	eval "last_arg=\${$#}"
> @@ -779,7 +779,7 @@ test_i18ngrep () {
>  		error "bug in the test script: too few parameters to test_i18ngrep"
>  	fi
>  
> -	if test -n "$GETTEXT_POISON"
> +	if test_have_prereq !C_LOCALE_OUTPUT

Why do these two helper functions call test_have_prereq (a function
that doesn't even fit on my screen) instead of a simple

  test -n "$GIT_TEST_GETTEXT_POISON"

>  	then
>  		# pretend success
>  		return 0
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 897e6fcc94..370a4821e1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1105,12 +1105,8 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
>  
>  # Can we rely on git's output in the C locale?
> -if test -n "$GETTEXT_POISON"
> +if test -z "$GIT_TEST_GETTEXT_POISON"
>  then
> -	GIT_GETTEXT_POISON=YesPlease
> -	export GIT_GETTEXT_POISON
> -	test_set_prereq GETTEXT_POISON
> -else
>  	test_set_prereq C_LOCALE_OUTPUT
>  fi

GIT_TEST_GETTEXT_POISON=1 will influence even those git commands that
are executed during initialization of test-lib and the test repo:

  $ GIT_TEST_GETTEXT_POISON=1 ./t0000-basic.sh -v
  # GETTEXT POISON #expecting success: 
  <....>

It should say:

  Initialized empty Git repository in <... path ...>
  expecting success:

See https://public-inbox.org/git/20181022202241.18629-2-szeder.dev@gmail.com/
for a bit of code that you might find worthy to steal.

