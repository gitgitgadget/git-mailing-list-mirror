Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605E61F404
	for <e@80x24.org>; Tue,  6 Mar 2018 00:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeCFAT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 19:19:29 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:44802 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbeCFAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 19:19:28 -0500
Received: by mail-wr0-f172.google.com with SMTP id v65so19133025wrc.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AR7jwqB8MCDWQnb76EjEdRMx7IjU9SfOMRZBKfuP8bQ=;
        b=nZB4PB+sx/2nUBHq2Qrwbm0CzIyuhOdlEGDxyueWpIK3/3G1AxiPzmT07RtG0U7y94
         JOPhT49IpoycAq7u4MQpxX15LK113wy0V1Ld0HRqc8soPKHBeivD3TP6H8WeeoJ8JGcg
         TKPguvxwritLVGFGW5OmfsnrUinAF8NkPcS7Tt0HocjBc33Y34zQ41cxDAh8Ps1adoIt
         +MX9YQ2ls0TY//ZP1Wa6iWF/NKEfmn0WQQRnuZAFI6Cd6aRE5k0ua1YHOT8tEYQdbtd9
         pdU5HBTjSUfIhASsv0hMsh26OqJtMPZvR/kBNlinbuucCA9UtPenDQFNfhZ9jlXvCeDP
         gqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AR7jwqB8MCDWQnb76EjEdRMx7IjU9SfOMRZBKfuP8bQ=;
        b=NP+gUS9bsrsxkr8/CDNQY8MnNvxWGQyaBA9bjAz+FpT1GdpxM8o6xtPfJv++X8Fw7Q
         Vrw9WOr6kn/hQTyeVU7G3IIxc+t9ivZI1/lFkfj0e815GOL1axuMQFyrQhNrRzFOTi0o
         6V4fTUyqCCqLFdtzCQr74Hn9qcGLCEdI8p08YUkgcSN+G9dDot/ADhnvAtuOGgLO/Rkr
         fdt05q2SNLil4zUtrwoRVtBjVxSkf/FniZ7c4kfg8IA0jJgFmZGP7IpBRLU2upPVj7oT
         IKS8MjLDiwITO6xDrQqxUMJ4tf6jKqpfiRjE5RF2yuTc906n2VPPPdj8NSUFbWtjbz9+
         9d4w==
X-Gm-Message-State: AElRT7FiSuDzF2HaMhIe12UUD5/zF7rZlninXjoBaFh9f8dtBZeC60gl
        ebVBLGQ2UTbtChQLq/Z/lmA=
X-Google-Smtp-Source: AG47ELtxYPWuFUIuu9NRtw2qfH6clamNWAZOjt3S9Rz+g4M7JbZLO3R6oEZ2LRpgUOqkHWgTT0XHOg==
X-Received: by 10.223.186.18 with SMTP id o18mr6331593wrg.158.1520295566651;
        Mon, 05 Mar 2018 16:19:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v75sm32571573wrb.76.2018.03.05.16.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 16:19:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v3] Make options that expect object ids less chatty if id is invalid
References: <20180303210938.32474-1-ungureanupaulsebastian@gmail.com>
Date:   Mon, 05 Mar 2018 16:19:25 -0800
In-Reply-To: <20180303210938.32474-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Sat, 3 Mar 2018 23:09:38
        +0200")
Message-ID: <xmqqzi3m6ooi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Usually, the usage should be shown only if the user does not know what
> options are available. If the user specifies an invalid value, the user
> is already aware of the available options. In this case, there is no
> point in displaying the usage anymore.
>
> This patch applies to "git tag --contains", "git branch --contains",
> "git branch --points-at", "git for-each-ref --contains" and many more.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---

I am guessing that this was sent as a replacement for fcfba373
("ref-filter: make "--contains <id>" less chatty if <id> is
invalid", 2018-02-23) that was merged to 'next' at 9623d681 ("Merge
branch 'ps/contains-id-error-message' into next", 2018-02-27).

In general, we do not drop and replace what is already merged to
'next' with a new version; once a topic is merged to 'next', we go
incremental and further refinements are made on top instead.

I however strongly suspect that the approach taken by this round is
a lot better, and it is sufficiently different that an "incremental"
that applies on top of the previous patches would essentially revert
them and builds what we see in this message afresh.

So I am tempted to revert the previous one out of 'next' and then
treat this one as if it were a new/different topic.


> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 58d1c2d28..eeee1c170 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1060,6 +1060,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		switch (parseopt_state) {
>  		case PARSE_OPT_HELP:
>  			exit(129);
> +		case PARSE_OPT_ERROR:
> +			exit(1);

OK, so things like

	$ git update-index --index-version
	$ git update-index --index-version NOT_AN_INTEGER

used to give the full usage (just like your primary and original
focus that was what "tag --contains" etc. did), but with this
change, they just throw an error and stop.  I guess this is a very
good thing ;-)

Also the exit status is changed from 129 to 1.  It is not clear if
that is a desirable change (I am not yet saying we shouldn't change
it, though).  Calling scripts probably only care about non-zero ness
of the exit status, so this change probably does not hurt people in
practice, I guess.

> @@ -504,7 +503,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			goto show_usage;
>  		switch (parse_long_opt(ctx, arg + 2, options)) {
>  		case -1:
> -			goto show_usage_error;
> +			return PARSE_OPT_ERROR;

An error return -1 from parse_long_opt() unfortunately includes the
case where the given string is ambiguous.  The test-parse-options
command in t/helpers e.g. has --string and --string2 option, that
take a string argument, so "test-parse-options --stri" says "error:
Ambigous option: stri (could be --string or --string2)", and without
this patch, it goes on to show the usage help.  With the patch,
however, we no longer get the help, and I think that is a regression;
the user likely wants to see the help text that describes these two
potential options to decide between the two.

Of course, "test-parse-options --string" fails with "error: options
`string' requires a value" and stops without the usage help---and
that is definitely an improvement.

Taking these together, I _think_ this patch is moving things in the
right direction, in that it allows callers of parse_options_step()
to tell "user knew what option s/he wanted, and sufficient error
message has already be given" and "user gave us a nonsense option
and would be helped by usage text" cases apart by introducing a new
value PARSE_OPT_ERROR, but in order to be able to correctly give
PARSE_OPT_ERROR back to the caller, parse_long_opt() and
parse_short_opt() (possibly, but I didn't check) would need a bit of
tweak to help their callers in this function.

>  test_expect_success 'non ambiguous option (after two options it abbreviates)' '
> @@ -291,6 +291,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
>  test_expect_success 'OPT_CALLBACK() and callback errors work' '
>  	test_must_fail test-parse-options --no-length >output 2>output.err &&
>  	test_i18ncmp expect output &&
> +	>expect.err &&
>  	test_i18ncmp expect.err output.err
>  '

The way the existing script sets test vectors up is not that great,
but this "expect.err" file is created by getting the usage output at
the very beginning of the test (into "expect") and a few tests refer
to it, expecting it to have the usage help (see check_unknown_i18n
helper).  We should treat its contents as a constant, and shouldn't
touch it like this.  Instead, perhaps do

	test_must_fail ... 2>actual.err &&
	test_must_be_empty actual.err

here.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ef2887bd8..e6a0766f8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -921,7 +921,7 @@ test_expect_success 'rebase -i --exec without <CMD>' '
>  	set_fake_editor &&
>  	test_must_fail git rebase -i --exec 2>tmp &&
>  	sed -e "1d" tmp >actual &&
> -	test_must_fail git rebase -h >expected &&
> +	>expected &&
>  	test_cmp expected actual &&
>  	git checkout master
>  '

This used to test

 - "git rebase -i --exec" fails (due to lack of <cmd>).

 - its error output is of no interest--expected to be some "error"
   message that talks about the lack of <cmd>.

 - after that first line of the error message, the remainder must be
   the usage help.

With the change, the third point is no longer the case.  I wonder if
we want to change the second point above to more actively test that
we get the error about the lack of <cmd>, e.g. something like

	...
	set_fake_editor &&
	test_must_fail git rebase -i --exec 2>actual &&
	test_i18ngrep "requires a value" actual
	...

> diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
> index b1602718f..157cbcdb2 100755
> --- a/t/t3502-cherry-pick-merge.sh
> +++ b/t/t3502-cherry-pick-merge.sh
> @@ -34,10 +34,10 @@ test_expect_success setup '
>  test_expect_success 'cherry-pick -m complains of bogus numbers' '
>  	# expect 129 here to distinguish between cases where
>  	# there was nothing to cherry-pick
> -	test_expect_code 129 git cherry-pick -m &&
> -	test_expect_code 129 git cherry-pick -m foo b &&
> -	test_expect_code 129 git cherry-pick -m -1 b &&
> -	test_expect_code 129 git cherry-pick -m 0 b
> +	test_expect_code 1 git cherry-pick -m &&
> +	test_expect_code 1 git cherry-pick -m foo b &&
> +	test_expect_code 1 git cherry-pick -m -1 b &&
> +	test_expect_code 1 git cherry-pick -m 0 b

The comment in the pre-context is something to ponder on.  Perhaps
we would want to find a way to do this change without affecting the
exit status code.
