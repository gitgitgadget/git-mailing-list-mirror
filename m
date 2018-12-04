Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA54211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 14:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLDOqW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 09:46:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39824 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeLDOqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 09:46:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so16242898wra.6
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 06:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zWVaNCUd38SoQXOlBpb6rgz/Qy+xvm33O8L1LsqyrvU=;
        b=m7qXoUeZiiPJI8vszEKNLJ2F1xfzlDgxIcC0pFFt/ULAwL4GyPmjNC4Dy/GTYhWR5J
         U+58xh7vLk9h5WXNq5ABj8tCFatWdfY9uOpeo0Nwoxlno0mgEFtUb4CaK0EX7nFYnFWm
         +QLQoLUHaRUdbaLyvkCvDVBdcUKNlg/r0+6tBV4J8OkZYlbI8eQr+eKPz1ugxEopfmvi
         fv0hPpCNmqYcj+9QAUdVNu/4ou1BN+36s5fGeZVpfss/BAAEGgwW+jXHENs+kd2gogni
         PK2SwUP1m3aHbHIfqXLe+WeUGZQ5tHfHplToHYAvr9eB/weS7ubGv+EDx39EKG4CgnuG
         1qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zWVaNCUd38SoQXOlBpb6rgz/Qy+xvm33O8L1LsqyrvU=;
        b=ZYZPP3OCP8SCCyvtR7EufBrghB1Cwe1RZpQ/cdUfmbky2i+vuGI2KxV1qIE/r1vjTg
         zP/yq1cpAGEPoh10Co9lVoa6mC4iMpjojbO10cF9OMy+3zTKPE/WocyGw8Qa/TjYU1KZ
         sEQzS/WEs9GNot006YKomgrTY/O7OWRMaVqWyom4JtKkm8+3MoUjVNmw3BcTcTQh7QKZ
         L4jLDT0CkvxqAe19Ie2ZRuaZOAtHvYuu08GE2yVFn0M65UuaneQasCPYylE/GP2A87go
         w8CpbCcZeOh2ZzQs+JntCivYtN0bzXkeS07Q8F61OTP7VjKmm9sSQxB678CS53k9lIwh
         bzAw==
X-Gm-Message-State: AA+aEWZE1kwgVVA6bjR7zyZdxLKszdW7BrVuQxgoZ7MoxIOYnSYvS7mN
        cDOXpATq8m+FcPd6BZnSEu4=
X-Google-Smtp-Source: AFSGD/UtToLtFZ+dKqxJgOcJ7izSXuhBhGNH5HJsu99BBfn/RCUWKjvaszgvgd2knKbbHbIiwButhg==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr19317816wrf.164.1543934779272;
        Tue, 04 Dec 2018 06:46:19 -0800 (PST)
Received: from szeder.dev (x4db19e3e.dyn.telefonica.de. [77.177.158.62])
        by smtp.gmail.com with ESMTPSA id o8sm13521205wrx.15.2018.12.04.06.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:46:18 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:46:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] test-lib: add support for GIT_TODO_TESTS
Message-ID: <20181204144615.GH30222@szeder.dev>
References: <20181127225445.30045-1-avarab@gmail.com>
 <20181127225445.30045-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127225445.30045-5-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 11:54:45PM +0100, Ævar Arnfjörð Bjarmason wrote:
> As noted in the updated t/README documentation being added here
> setting this new GIT_TODO_TESTS variable is usually better than
> GIT_SKIP_TESTS.

I don't see why this is "usually better".  I get how it can help your
particular use-case described below, but that doesn't mean that it's
"usually better".

> My use-case for this is to get feedback from the CI infrastructure[1]
> about which tests are passing due to fixes that have trickled into
> git.git.
> 
> With the GIT_SKIP_TESTS variable this use-case is painful, you need to
> do an occasional manual run without GIT_SKIP_TESTS set. It's much
> better to use GIT_TODO_TESTS and get a report of passing TODO tests
> from prove(1) at the bottom of the test output. Once those passing
> TODO tests have trickled down to 'master' the relevant glob (set for
> all of master/next/pu) can be removed.

Neither from the commit message nor from the documentation is it clear
to me what the result of 'make test' will be when a test listed in
GIT_TODO_TESTS fails.

> As seen in the "GIT_TODO_TESTS mixed failure" test the lack of
> interaction with existing tests marked as TODO by the test suite
> itself is intentional. There's no need to print out something saying
> they matched GIT_TODO_TESTS if they're already TODO tests.
> 
> 1. https://public-inbox.org/git/875zwm15k2.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  ci/lib-travisci.sh |  2 +-
>  t/README           | 18 +++++++++--
>  t/t0000-basic.sh   | 81 +++++++++++++++++++++++++++++++++++++++-------
>  t/test-lib.sh      | 31 +++++++++++++++---
>  4 files changed, 112 insertions(+), 20 deletions(-)
> 
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 69dff4d1ec..ad8290bfdb 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -121,7 +121,7 @@ osx-clang|osx-gcc)
>  	# t9810 occasionally fails on Travis CI OS X
>  	# t9816 occasionally fails with "TAP out of sequence errors" on
>  	# Travis CI OS X
> -	export GIT_SKIP_TESTS="t9810 t9816"
> +	export GIT_TODO_TESTS="t9810 t9816"

This change is not mentioned in the commit message.

As noted in the hunk's context, these test scripts are not skipped
because they don't work on OSX at all, but because they are flaky.
Consequently, reporting them as "maybe should be un-TODO'd" when they
happen to succeed is pointless and will just lead to confusion, so
this seems to be a case when GIT_TODO_TESTS is actually worse than
GIT_SKIP_TESTS.

If a failing test in GIT_TODO_TESTS makes the whole 'make test' fail,
then this should be most definitely left as GIT_SKIP_TESTS.

>  	;;
>  GIT_TEST_GETTEXT_POISON)
>  	export GIT_TEST_GETTEXT_POISON=YesPlease
> diff --git a/t/README b/t/README
> index c03b268813..922b4fb3bf 100644
> --- a/t/README
> +++ b/t/README
> @@ -207,8 +207,19 @@ ideally be reported as bugs and fixed, or guarded by a prerequisite
>  (see "Using test prerequisites" below). But until then they can be
>  skipped.
>  
> -To skip tests, set the GIT_SKIP_TESTS variable. Individual tests can
> -be skipped:
> +To skip tests, set either the GIT_SKIP_TESTS or GIT_TODO_TESTS
> +variables. The difference is that with SKIP the tests won't be run at
> +all, whereas they will be run with TODO, but in success or failure
> +annotated as a TODO test.

This is confusing.  "To skip" a test means that the test is not run at
all.  Now, if GIT_TODO_TESTS were to run the listed tests, then it
definitely won't skip them, so this sentence contradicts the previous
one.

What does "annotated as a TODO test" mean?  Something similar to how
'test_expect_failure' works?

> +It's usually preferrable to use TODO, since the test suite will report
> +those tests that unexpectedly succeed, which may indicate that
> +whatever bug broke the test in the past has been fixed, and the test
> +should be un-TODO'd. There's no such feedback loop with
> +GIT_SKIP_TESTS.
> +
> +The GIT_SKIP_TESTS and GIT_TODO_TESTS take the same values. Individual
> +tests can be skipped:
>  
>      $ GIT_SKIP_TESTS=t9200.8 sh ./t9200-git-cvsexport-commit.sh
>  
> @@ -223,7 +234,8 @@ patterns that tells which tests to skip, and either can match the
>  
>  For an individual test suite --run could be used to specify that
>  only some tests should be run or that some tests should be
> -excluded from a run.
> +excluded from a run. The --run option is a shorthand for setting
> +a GIT_SKIP_TESTS pattern.
>  
>  The argument for --run is a list of individual test numbers or
>  ranges with an optional negation prefix that define what tests in
