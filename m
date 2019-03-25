Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C3F20248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfCYSfJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:35:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36363 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfCYSfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:35:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id k2so352360plt.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEhHR5dZSQLAtc9dwNDR8H8njbag9ZJZvf7D+aC+d+Q=;
        b=Us8A4h69Zmt9kQuYmdObwa+KizTFNPkWbMJ7Gw/9FZ3KrINFHvm2aZAtO1NWMFDyOi
         GTLwuSNZ2y3FSq0/vGljIj4tseSdZE2cFIJdP74UwahoNUnn0slqY7N6iORgig+JEFWY
         T3/yQrapGoEZ0xtmc/QhXMAMmUXQnnQmyRRffJLtfHTz8uvCtgGTP4IEXZmlCr9anW4k
         g883fAqLSfsbEiDoj9MqPF9W3JYCdOe3lVvP9rtgZuGsGF17IoG4ZVDFzXc1CV8WGwBE
         /HPtQ6Gl0p8wtCtNBsIBWPYlq6ppvxLJV4bupDnS7MAPDdqmRy2T0bop5JdSz5I5LL1/
         0kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEhHR5dZSQLAtc9dwNDR8H8njbag9ZJZvf7D+aC+d+Q=;
        b=sk9uqs7FzIiVjpBvTjGcFGzewRUyHL33w0MEMqyxTj+Z7c55ReHiEoObZx2ojox48Q
         DB/2lFzY0jBNYCP8FNCV10n0RUvPvzGcaI0Gwej0XiH3dXwGn/7A2uMhB7su5yX9PtFA
         vxHpzbZc4F6xKev6ii8AWReysjcz5LLoWKQr9KTYUjDai7NxirE7eUc7dylwdHrV69tC
         UtcGpmsflOlBgQtSfdo2+0AY+nAMhvwmss/mlwW5cz5kEFsJU4XpDYxS1z4nj0JIvxQG
         lJ0ZRNj6HBRkmGatRnPGoBBkIt6tWKERNuJIddEB9vdtGkmuJQG01A1aDxQYKF0WyKnO
         78Rg==
X-Gm-Message-State: APjAAAXSCMH9kw8O85KmBA9SGd5KUJedGNgyGYHp3UtaorIXjX3Of2Cf
        CxGS31nw9wKGgD+6UfBxkIc=
X-Google-Smtp-Source: APXvYqxueUxulujy/iybCjnoQAdwnE1FyBQGzx72x7xLJm7TPoHD0fyK1CcF6O1YUykEyAeP9kV2vA==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr26622169pls.189.1553538908393;
        Mon, 25 Mar 2019 11:35:08 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id y5sm19069000pgv.15.2019.03.25.11.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:35:07 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:35:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by
 default)
Message-ID: <20190325183505.GA28920@dev-l>
References: <pull.167.git.gitgitgadget@gmail.com>
 <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for catching this. Perhaps I should've been more diligent and ran
the entire test suite before submitting but I was running low on
batteries only ran the rebase-related tests.

On Mon, Mar 25, 2019 at 11:14:23AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Git's command-line parsers support uniquely abbreviated options, e.g.
> `git init --ba` would automatically expand `--ba` to `--bare`.
> 
> This is a very convenient feature in every day life for Git users, in
> particular when tab completion is not available.
> 
> However, it is not a good idea to rely on that in Git's test suite, as
> something that is a unique abbreviation of a command line option today
> might no longer be a unique abbreviation tomorrow.
> 
> For example, if a future contribution added a new mode
> `git init --babyproofing` and a previously-introduced test case used the
> fact that `git init --ba` expaneded to `git init --bare`, that future

s/expaneded/expanded/

> contribution would now have to touch seemingly unrelated tests just to
> keep the test suite from failing.
> 
> So let's disallow abbreviated options in the test suite by default.
> 
> Note: for ease of implementation, this patch really only touches the
> `parse-options` machinery: more and more hand-rolled option parsers are
> converted to use that internal API, and more and more scripts are
> converted to built-ins (naturally using the parse-options API, too), so
> in practice this catches most issues, and is definitely the biggest bang
> for the buck.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  parse-options.c          | 9 +++++++++
>  t/README                 | 4 ++++
>  t/t0040-parse-options.sh | 7 ++++++-
>  t/test-lib.sh            | 6 ++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index cec74522e5..acc3a93660 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -6,6 +6,8 @@
>  #include "color.h"
>  #include "utf8.h"
>  
> +static int disallow_abbreviated_options;
> +
>  #define OPT_SHORT 1
>  #define OPT_UNSET 2
>  
> @@ -344,6 +346,10 @@ static enum parse_opt_result parse_long_opt(
>  		return get_value(p, options, all_opts, flags ^ opt_flags);
>  	}
>  
> +	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
> +		die("disallowed abbreviated or ambiguous option '%.*s'",
> +		    (int)(arg_end - arg), arg);
> +
>  	if (ambiguous_option) {
>  		error(_("ambiguous option: %s "
>  			"(could be --%s%s or --%s%s)"),
> @@ -708,6 +714,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  {
>  	struct parse_opt_ctx_t ctx;
>  
> +	disallow_abbreviated_options =
> +		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
> +
>  	parse_options_start(&ctx, argc, argv, prefix, options, flags);
>  	switch (parse_options_step(&ctx, options, usagestr)) {
>  	case PARSE_OPT_HELP:
> diff --git a/t/README b/t/README
> index 656288edce..9ed3051a1c 100644
> --- a/t/README
> +++ b/t/README
> @@ -399,6 +399,10 @@ GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
>  fetch-pack to not request sideband-all (even if the server advertises
>  sideband-all).
>  
> +GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
> +the default when running tests), errors out when an abbreviated option
> +is used.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index b8f366c442..5f6a16336d 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -203,20 +203,24 @@ file: (not set)
>  EOF
>  
>  test_expect_success 'unambiguously abbreviated option' '
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
>  	test-tool parse-options --int 2 --boolean --no-bo >output 2>output.err &&
>  	test_must_be_empty output.err &&
>  	test_cmp expect output
>  '
>  
>  test_expect_success 'unambiguously abbreviated option with "="' '
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
>  	test-tool parse-options --expect="integer: 2" --int=2
>  '
>  
>  test_expect_success 'ambiguously abbreviated option' '
> -	test_expect_code 129 test-tool parse-options --strin 123
> +	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
> +	test-tool parse-options --strin 123
>  '
>  
>  test_expect_success 'non ambiguous option (after two options it abbreviates)' '
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
>  	test-tool parse-options --expect="string: 123" --st 123
>  '
>  
> @@ -325,6 +329,7 @@ file: (not set)
>  EOF
>  
>  test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
>  	test-tool parse-options --no-ambig >output 2>output.err &&
>  	test_must_be_empty output.err &&
>  	test_cmp expect output

Would it make sense to include a test case to ensure that
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is working properly?

Thanks,

Denton

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 562c57e685..e550009411 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -57,6 +57,12 @@ fi
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
>  
> +# Disallow the use of abbreviated options in the test suite by default
> +test -n "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" || {
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
> +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> +}
> +
>  ################################################################
>  # It appears that people try to run tests without building...
>  "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
> -- 
> gitgitgadget
