Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376BD1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfBKTzD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:55:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37198 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfBKTzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:55:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so508798wmg.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CubG9RDuD+NOWIkV58Ywvx7j+w3N7xYjKywakBE48tk=;
        b=KqfbWeVt+EMrDWEYncKUuVCYMKtWsIEwuYktBGJej4MXH3k97r3iK7F47WhbW4tRXQ
         JEcbt8+zEzQplchPZOh8UI3xxyZwCrfeCHWwSd90AP26GLlGEPfCvVDdqsmiUs3F8AUY
         TIGNeQcMNaBM1QnEvg8YAvwULMaa7W8Yc1xZyGJE6wMM8HGbYT+nbKVxSBeKAh0iYfab
         aGxjARld4B2XjHR427EP2gtiqD5SizF0kKt4alEbzGmD0SWAjCTedleF5gV07ko1ufdk
         ariryjlkM7A8S0w5eaELDOPafmbinyGbWF6tJSa5knOqRfuDlv3dxj7h3H6UsgtyS3sp
         AjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CubG9RDuD+NOWIkV58Ywvx7j+w3N7xYjKywakBE48tk=;
        b=LS5K4sjctEuNpgIbgZe6iUb049ZFpGqO/cdcmESWGUMWfPOD2u4lC9Vze+6KfyiBee
         9v80PXA6dEdFgLrqBqn6PoCQR9YBRcRZHYJspPYh5xNWpPS8mYNp9q6yCnntcl66LS8U
         aDIyCSyyIj6OSDrM2d//aurUF28p2p6rGu0ERAU2YGtYWolS4GU/sUiLSzKXjEwdYWnB
         hBivaWSXFvlua0cdo+djfRPe4N4iPa8ciWq23CBk3FtvYngcP8l0acT07yEnjCmsmv8b
         iZwVMZirT1eNIMJKBEWPyn653CpAq1VwamBgxHQUoXGpKNZ7MKQu83ag/PZaccNNffb2
         PqOw==
X-Gm-Message-State: AHQUAuY2LKlRVJJ1+mtW0CCuN02PNgk9Vs+9X67SWPleVKPQM1CyCvJb
        f6uPscEtvEeso8BNZahXwLo=
X-Google-Smtp-Source: AHgI3IbN+ymTuccm/V9agW3C7NL28sABKOsM/pmI8MteGJDmuI4u/uN5nKv2arb25ZPQ31bgg8s4eQ==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr945859wmf.32.1549914900064;
        Mon, 11 Feb 2019 11:55:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q21sm392912wmc.14.2019.02.11.11.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 11:54:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2] reflog: specify default pretty format in config
References: <20190130144744.3248-1-rhi@pengutronix.de>
        <20190208183145.11041-1-rhi@pengutronix.de>
Date:   Mon, 11 Feb 2019 11:54:58 -0800
In-Reply-To: <20190208183145.11041-1-rhi@pengutronix.de> (Roland Hieber's
        message of "Fri, 8 Feb 2019 19:31:45 +0100")
Message-ID: <xmqqzhr2gkx9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roland Hieber <rhi@pengutronix.de> writes:

> The output of git-reflog(1) is currently only customisable by calling
> reflog with --pretty=... or overriding the "pretty.oneline" format in
> the config, which is currently the default fallback.

It is correct to point out that "git reflog --pretty=..." is a valid
way to get customized output, but I do not think the pretty.<name>
configuration allows you to modify built-in formats line oneline.

Don't overuse 'currently'.  The present tense is about describing
the current behaviour by default anyway.

	The output from "git reflog" can be customized with
	"--pretty=..." option from the command line.

is sufficient.

> To enhance flexibility and save typing, teach reflog to fall back to a
> default format specified in the config option "reflog.pretty" unless a
> different pretty format is given on the command line. This behaviour is
> similar to the "format.pretty" option for git-log(1) and git-show(1).

OK.

> When "reflog.pretty" is not set, fall back to the old default of
> --pretty=oneline --abbrev-hash.

I've never heard of the "--abbrev-hash" option.  Perhaps you meant
to say --abbrev-commit?

Make it a habit to try out any program example you write in your log
message or documentation and you'll do much better.

> diff --git a/Documentation/config/reflog.txt b/Documentation/config/reflog.txt
> new file mode 100644
> index 000000000..637cd852a
> --- /dev/null
> +++ b/Documentation/config/reflog.txt
> @@ -0,0 +1,5 @@
> +reflog.pretty::
> +	The default pretty format used by linkgit:git-reflog[1] if nothing
> +	else is specified via the `--pretty=` option.  If both are unset,
> +	git-reflog falls back to `--pretty=oneline --abbrev-hash`.  See the
> +	section Pretty Formats in linkgit:git-log[1] for possible values.

Likewise.

> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index ff487ff77..9dccd4bcf 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -41,6 +41,8 @@ command-line (or `HEAD`, by default). The reflog covers all recent
>  actions, and in addition the `HEAD` reflog records branch switching.
>  `git reflog show` is an alias for `git log -g --abbrev-commit
>  --pretty=oneline`; see linkgit:git-log[1] for more information.
> +The config option `reflog.pretty` is used as the default pretty
> +format if nothing else is specified.

The existing text in the pre-context hints a possible pitfall in
implementing this new feature.  When we defeat the built-in default
via the configuration or an explicit --pretty=... option, what would
(and more importantly, what should) happen to the --abbrev-commit
option given by the default?

Let's read on.

> diff --git a/builtin/log.c b/builtin/log.c
> index a479642eb..0592e5076 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -667,6 +667,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info rev;
>  	struct setup_revision_opt opt;
> +	int cfg_have_pretty;
>  
>  	init_log_defaults();
>  	git_config(git_log_config, NULL);
> @@ -676,10 +677,14 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
>  	rev.verbose_header = 1;
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
> +
> +	cfg_have_pretty = git_config_get_string_const("reflog.pretty", &fmt_pretty);
>  	cmd_log_init_defaults(&rev);
> -	rev.abbrev_commit = 1;
> -	rev.commit_format = CMIT_FMT_ONELINE;
> -	rev.use_terminator = 1;
> +	if (cfg_have_pretty != 0) {

This is misleading.  A natural thinking would go "unless we have
config, we use the default", so the following three lines that makes
the command use the default setting must be triggered when config
does *NOT* have reflog.pretty, and in C, a non-zero integer is
generally TRUE.

If you are using the fact that the result of git_config_get_X() is
non-zero if the configuration is not found, then fixing the polarity
of the value of the variable to match its name (or fixing the name
to match what it means), perhaps like:

	int needs_default;

	...
	needs_default = git_config_get_string_const(...);
	cmd_log_init_defaults(&rev);
	if (needs_default) {
		... set the --oneline --abbrev-commit ...
	}

would make the logic easier to follow.  Or if you choose to keep the
name, then

	cfg_have_pretty = !git_config_get_string_const(...);
	...
	if (!cfg_have_pretty) {
		...

I think "needs_default" would be a better solution that avoids
unnecessary negation.

> +		rev.abbrev_commit = 1;
> +		rev.commit_format = CMIT_FMT_ONELINE;
> +		rev.use_terminator = 1;
> +	}

And this answers my earlier question.  In the original code,
rev.abbrev_commit is always set by default and is not turned off, so
unlike "git log --oneline" that never gets .abbrev_commit=1 (hence
shows a full object name in the oneline output, unless shortened by
giving --abbrev-commit at the same time), "git reflog --oneline" would
still shorten the object names.

Even with this change, "git reflog --oneline" without reflog.pretty
configuration would behave the same as before.  Which is nice.

What interests us is how the new feature, i.e.

	git -c reflog.pretty=oneline reflog

would behave.  As we have the config, abbrev_commit is not set.  So
my guess is that it would give the full object names in the output?

In other words,

	git reflog --oneline
	git -c reflog.pretty=oneline reflog

would behave differently.

That is easily "fix"-able by moving the assignment of .abbrev_commit
outside the conditional.  I am not sure what the best way to justify
that behaviour, though.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index ae8a448e3..74abf3d0f 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -383,4 +383,25 @@ test_expect_success 'expire with multiple worktrees' '
>  	)
>  '
>  
> +test_expect_success '--pretty format' '
> +	git init pretty-formats &&
> +	(
> +		cd pretty-formats &&
> +		cat >expect <<-\EOF &&
> +		HEAD@{0} commit (initial): foobar
> +		EOF
> +		test_tick &&
> +		test_commit foobar &&
> +
> +		git reflog -n1 --pretty="%gD %gs" > output &&

Style: do not write SP after redirection operator '>' and its target
filename.

Style: our convention is, unless there is a good reason to deviate,
call the expected output "expect" and actual output "actual".

> +		test_cmp expect output &&
> +
> +		git -c reflog.pretty="%gD %gs" reflog -n1 > output &&
> +		test_cmp expect output &&
> +
> +		git -c reflog.pretty="%h" reflog -n1 --pretty="%gD %gs" > output &&
> +		test_cmp expect output
> +	)
> +'
> +
>  test_done

If I apply the attached patch on top of yours to restore the
behaviour of the command that forces .abbrev_commit to be always on,
these tests still pass.  Which means that this test is not covering
enough.  You would want to make sure "git -c reflog.pretty=oneline",
"git reflog --pretty=oneline", and "git reflog" behaves the same
way, at least, I think.


[Sample patch---do not blindly squash]

 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 619bb06686..00e29409bf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -670,7 +670,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
-	int cfg_have_pretty;
+	int needs_default;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -681,13 +681,13 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 
-	cfg_have_pretty = git_config_get_string_const("reflog.pretty", &fmt_pretty);
+	needs_default = git_config_get_string_const("reflog.pretty", &fmt_pretty);
 	cmd_log_init_defaults(&rev);
-	if (cfg_have_pretty != 0) {
-		rev.abbrev_commit = 1;
+	if (needs_default) {
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.use_terminator = 1;
 	}
+	rev.abbrev_commit = 1;
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 


