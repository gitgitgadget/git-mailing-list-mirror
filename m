Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072EF1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 11:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJUTe5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 15:34:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42694 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJUTe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 15:34:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so35238468edd.9
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfaChqHlaX33hTXRI2yljp633ic4OjHgHUQL+emAIbo=;
        b=CYOgmr3Xkpv43Ra7SRa+V85Anr6hY3UEukWiTuUg/HspdG+ysWiL8phUGTd1n6O6kF
         nrGSteVK7XsEDXDepbDLQ243FpERKcCrAVW3qD86K0RYG3RNEW/qDXGqn99WZzzJIqkr
         XUbO8uSGkNcxWQyb4mzn53AHC5pkyJ5QbGXoDtNv62po5YZOnU+Z3pnXgaBZTflXnH99
         yMV70fKiFfOqOTgKX/ywkv7rXdekOqesKUiNxqNWLf+5l6EYUSqW5SnS7MMX0yr7V2ao
         3z/O2mbE+GtDFxlEpi18zyR89s/SjK/o9pvzvyjVvZaHeJX+uVhAqRpXviouUhsiX75x
         3+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfaChqHlaX33hTXRI2yljp633ic4OjHgHUQL+emAIbo=;
        b=c/vtgnWbKkmVEu86YZN1VHglrXHeZ1d0iEEhWTSIH2Eud9JrEJ1kdYo9t/wOp7cJip
         ALj6UqLEJBOyABNfKXIcNRMMW4Cq031hfFBDKs+BERWzZLdRZor2cTh9oYRv/4HPpHWU
         APpLA3OD1EIMiAaP2GAGOi9Yf92/CuVcCERjSLxAX4qqChFoH8XtM2hTNqpvKujfSGYs
         NSyGry75Q9FMC9sUzdz/jvZYr9mwJ/aFfNxPrPovq8OPeqnVVX80VoPLSRaD9KqIr49q
         e6WKZ9PQeiJQLQaPN4Q+p46coXgZ7nwmgVK8wDc9bOZRZ76t8bZBKwqU2ruTckEJxKVn
         rbBA==
X-Gm-Message-State: ABuFfoi1F2Gp+zf1hBghf3dIN7CX3fIjLa7MJTJHvtwW0Ayf7G/36o98
        59cbCbJmxe2pZtWWH/jeMEU=
X-Google-Smtp-Source: ACcGV62KR6NAenanAX4PdctdUm8MTGcDMco7xZNfPCC3JPxE8sIlTg2FUfnaNa9umn2cUM8VQPJG1w==
X-Received: by 2002:a50:b246:: with SMTP id o64-v6mr11067087edd.80.1540120856793;
        Sun, 21 Oct 2018 04:20:56 -0700 (PDT)
Received: from szeder.dev (x4db03e75.dyn.telefonica.de. [77.176.62.117])
        by smtp.gmail.com with ESMTPSA id y16-v6sm10814546eds.45.2018.10.21.04.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 04:20:55 -0700 (PDT)
Date:   Sun, 21 Oct 2018 13:20:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/13] tests: introduce `test_atexit`
Message-ID: <20181021112053.GC30222@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <12d6137f8d2ccc2041bed8d56d88a09b1db0fd77.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12d6137f8d2ccc2041bed8d56d88a09b1db0fd77.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:08AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When running the p4 daemon or `git daemon`, we want to kill it at the
> end of the test script.
> 
> So far, we do this "manually".
> 
> However, in the next few commits we want to teach the test suite to
> optionally re-run scripts with different options, therefore we will have
> to have a consistent way to stop daemons.
> 
> Let's introduce `test_atexit`, which is loosely modeled after
> `test_when_finished` (but has a broader scope: rather than running the
> commands after the current test case, run them when the test script
> finishes, and also run them when the `--immediate` option is in effect).

I think killing daemons on failure even with '--immediate' will make
life a bit easier.  I remember several occasions when I tried to debug
a failing test with '--immediate', some daemon stayed alive, and then
the next time I run the test it failed during setup.

Besides 'git daemon' and P4, the httpd tests could benefit from this
as well.


> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 78d8c3783b..d7dd0c1be9 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -891,6 +891,35 @@ test_when_finished () {
>  		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
>  }
>  
> +# This function can be used to schedule some commands to be run
> +# unconditionally at the end of the test script, e.g. to stop a daemon:
> +#
> +#	test_expect_success 'test git daemon' '
> +#		git daemon &
> +#		daemon_pid=$! &&
> +#		test_atexit "kill $daemon_pid" &&
> +#		hello world
> +#	'

I think we should add something like this as well:

# Note that these commands will be run even when a test script run
# with '--immediate' fails.  Be careful with your commands to minimize
# any changes to the failed state.

> +
> +test_atexit () {
> +	# We cannot detect when we are in a subshell in general, but by
> +	# doing so on Bash is better than nothing (the test will
> +	# silently pass on other shells).
> +	test "${BASH_SUBSHELL-0}" = 0 ||
> +	error "bug in test script: test_atexit does nothing in a subshell"
> +	test_atexit_cleanup="{ $*
> +		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
> +}
> +
> +test_atexit_handler () {
> +	test : != "$test_atexit_cleanup" || return 0
> +
> +	setup_malloc_check
> +	test_eval_ "$test_atexit_cleanup"
> +	test_atexit_cleanup=:
> +	teardown_malloc_check
> +}

The file 'test-lib-functions.sh' contains helper functions to be used
in tests.  'test_atexit_handler' is not such a function, so I think it
would be better to add it to 'test-lib.sh'.

> +
>  # Most tests can use the created repository, but some may need to create more.
>  # Usage: test_create_repo <directory>
>  test_create_repo () {
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7ed0013f6d..6f9c1f5300 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -413,6 +413,7 @@ test_external_has_tap=0
>  
>  die () {
>  	code=$?

# Run atexit handlers even when a test script run with
# '--immediate' fails.

> +	test_atexit_handler || code=$?
>  	if test -n "$GIT_EXIT_OK"
>  	then
>  		exit $code
> @@ -826,9 +827,12 @@ write_junit_xml_testcase () {
>  	junit_have_testcase=t
>  }
>  
> +test_atexit_cleanup=:
>  test_done () {
>  	GIT_EXIT_OK=t
>  
> +	test -n "$immediate" || test_atexit_handler

You mentioned elsewhere [1] that you'll remove the condition to run
'test_atexit_handler' unconditionally.  I think this is the right
thing to do, because this condition is responsible for the hanging P4
tests I reported in [2].

So, 'lib-git-p4.sh' stores the pid of the 'p4d' process in the file
"$TRASH_DIRECTORY/p4d.pid" in 'start_p4d', to be read later in
'kill_p4d' to know which process to kill.  When a test script run with
'--immediate' ends successfully, and the atexit handlers are run in
'die' above instead of in 'test_done', then you've got the problem
that 'test_done' removes the trash directory along with the 'p4d.pid'
file before the atexit handlers are run.  With the pidfile gone
'kill_p4d' won't know which process to kill, and the 'p4d' process
will stay alive.

If that condition is removed, then the atexit handlers will be run
before the trash directory is removed, so 'p4d' processes will be
stopped as they should even when an '--immediate' run succeeds.  Good.
Note, however, that in this case 'test_atexit_handler' will be called
twice: first in 'test_done' and then in 'die' as well.  This should be
fine, because 'test_atexit_handler' resets 'test_atexit_cleanup=:', so
the second call will do nothing.  Great.  Perhaps this would be worth
pointing out explicitly in the commit message and/or a comment.

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1810161111240.4546@tvgsbejvaqbjf.bet/
[2] https://public-inbox.org/git/20181017232952.GT19800@szeder.dev/

> +
>  	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
>  	then
>  		test -n "$junit_have_testcase" || {
> -- 
> gitgitgadget

