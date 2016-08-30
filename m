Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2756F1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbcH3Usm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:48:42 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35782 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcH3Usk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 16:48:40 -0400
Received: by mail-qk0-f173.google.com with SMTP id v123so31704787qkh.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oqopnWkQo9fYuUFvNDRzKOcydra59nkE9ewsfkzTmyA=;
        b=TtTrCMi2vtC5lN6QMiFd8NC+LDiHxjE2Eo0oiO9syMmovpTLdz1rup/Gh0IahVL6xt
         B4p8UO0/Am1MLhP9J/IFtlfmIXn/8gAOIJtdA948hf4Wk1T17t0ZM3ZhV2jJN3w+f4dK
         MD7DdVKjB9wm3niG0jbli9cnQqqI+4HtQg+4rmbUDz+NVOzTQ1DLrpWSUgd/ihEcfN3M
         1vIeR1kRtuwBQLz4NRFWm0a9LrlBX+TvfCyPYLEBGxJ0AMTXaxBP+NiTzYIXpI39nTxS
         7+sYdCeRO4+t4m/tTPc1Qh6BCHLn92Lgx9CtWUtqQbRb8+DGcwvCCZFFqK1jhlWq+cip
         NRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oqopnWkQo9fYuUFvNDRzKOcydra59nkE9ewsfkzTmyA=;
        b=RbY8JzeWJ76d+BJVmz+czp4k74eTZG8bwHiviEiKZfV99NdVrwfaok2nilM0xsuMtK
         2NT4CKvRBPXbYLMIk4PGoh6x2Rf2tzpqkCWFwXBRXN+D2JzPiDYeehr28e3n0TEvTVyK
         J93/u/2jNTkCSwnyx11E+z0ny0jkbQDDIyHN+j/1ViFi1xBvwvSIj8U56r8L8yhOU5Uh
         SAJAsfsAGpkmkUcZhnnfGRrUM8A69g3dUHefnUnEJHj9e7WDPAq7EjuI/LPKy+7r5+bV
         lavEbm2OJQ9p+Sn58Jx6swekZLf7ogVOiQvEiTI81C5uV7qK4vlpEAdgT/d9UEzq7scg
         Aizw==
X-Gm-Message-State: AE9vXwNrPspQ6BRT+1DTVz6Z3OvQL+qy0FL5cS5/6sXcb+T2m2FsU1X1izC3xc9OVXpcoFH7n9A41i05rwMWow==
X-Received: by 10.55.197.29 with SMTP id p29mr6994167qki.141.1472590119678;
 Tue, 30 Aug 2016 13:48:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.193 with HTTP; Tue, 30 Aug 2016 13:48:19 -0700 (PDT)
In-Reply-To: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 Aug 2016 22:48:19 +0200
Message-ID: <CACBZZX6iEmbb68tzRKNAryp5qmt=iU9FMuOe2ONV=2ojcazoEg@mail.gmail.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 3:46 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> While developing patch series, it is a good practice to run the test
> suite from time to time, just to make sure that obvious bugs are caught
> early.  With complex patch series, it is common to run `make -j15 -k
> test`, i.e.  run the tests in parallel and *not* stop at the first
> failing test but continue. This has the advantage of identifying
> possibly multiple problems in one big test run.
>
> It is particularly important to reduce the turn-around time thusly on
> Windows, where the test suite spends 45 minutes on the computer on which
> this patch was developed.
>
> It is the most convenient way to determine which tests failed after
> running the entire test suite, in parallel, to look for left-over "trash
> directory.t*" subdirectories in the t/ subdirectory. However, as was
> pointed out by Jeff King, those directories might live outside t/ when
> overridden using the --root=<directory> option, to which the Makefile
> has no access. The next best method is to grep explicitly for failed
> tests in the test-results/ directory, which the Makefile *can* access.
>
> This patch automates the process of determinig which tests failed
> previously and re-running them.
>
> Note that we need to be careful to inspect only the *newest* entries in
> test-results/: this directory contains files of the form
> tNNNN-<name>-<pid>.counts and is only removed wholesale when running the
> *entire* test suite, not when running individual tests. We ensure that
> with a little sed magic on `ls -t`'s output that simply skips lines
> when the file name was seen earlier.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>         The patch is unfortunately no longer as trivial as before, but it
>         now also works with --root=..., i.e. when the user overrode the
>         location of the trash directories.
>
> Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v2
> Fetch-It-Via: git fetch https://github.com/dscho/git failing-tests-v2
> Interdiff vs v1:
>
>  diff --git a/t/Makefile b/t/Makefile
>  index c402a9ec..8aa6a72 100644
>  --- a/t/Makefile
>  +++ b/t/Makefile
>  @@ -35,7 +35,12 @@ all: $(DEFAULT_TEST_TARGET)
>   test: pre-clean $(TEST_LINT)
>         $(MAKE) aggregate-results-and-cleanup
>
>  -failed: $(patsubst trash,,$(patsubst directory.%,%.sh,$(wildcard trash\ directory.t[0-9]*)))
>  +failed:
>  +      @failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
>  +              grep -l '^failed [1-9]' $$(ls -t *.counts | \
>  +                      sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./d;P;d') | \
>  +              sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
>  +      test -z "$$failed" || $(MAKE) $$failed
>
>   prove: pre-clean $(TEST_LINT)
>         @echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)

I don't at all mind this solution to the problem, if it works for that's cool.

But FWIW something you may have missed is that you can just use
prove(1) for this, which is why I initially patched git.git to support
TAP, so I didn't have to implement stuff like this.

I.e.:

    $ prove --state=save t[0-9]*.sh
    $ prove --state=failed,save t[0-9]*.sh

Does exactly what you're trying to do here with existing tools we support.

I.e. your new target could just be implemented in terms of calling prove.

Check out its man page, it may have other stuff you want to use, e.g.
you can run the slowest tests first etc.
