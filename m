Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F6C1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 14:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfKSOdP (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 09:33:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKSOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 09:33:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so3435701wmc.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BX/v5Hv8ki5/7F7n5mkMb8ItNEUWkExN8R7biNqzdrE=;
        b=T0pTvRR90vXHJJu+zDBoQ4/Drh5ZNaE84hwyH9YSUNjHMdXd9KZ2XiNGZmPp19xSEq
         rnpW04pmBeyjknacdPgM47WU7fH/hcHNJ0HvNX27Xu/QnQ5tpqN5TJ2MlLN+UMmOH3oq
         pYyI21Z6u1DT6a633TcqOk6XK/imlhdY0TU29i2ohfXVNZBgqBpWXwHNNjGpWQD0Imch
         ddtxWWRLPWZpxt9BcG7fQXHQTIOzlQI52m9NWQXYDaJUlUH/c9vRzS39iEEbaFIuEGpA
         T2wkyBabmJ80DSErpbCs+SJhyKS/hs5tgfBRTA1VC4FIsV2Z0CrsnsX91I6oQXv6hU10
         ClvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BX/v5Hv8ki5/7F7n5mkMb8ItNEUWkExN8R7biNqzdrE=;
        b=jQ5kf14Gu0PPnw0+jSrK5LHhHNlXVecmEWTi4g5usjsvDi8cr3ihpvEowHhDg6nCRy
         iwzDiHeEwlTBDav/SbRcFd0wCwQTsFZV9BkQneRIZWhTikDVep3vzXziSOMq/eDza3Cq
         oqTPwPEgX4vvhvkbYnFu1hB6/w9ItYbM7tIAN/xB+lQD7Jsp9FTJKlbacuFDbAGOyV++
         Kc7sWxt7H6UTJ0aik2r8dHPTJFiawuloeBvIb+B+rSraHUmNqUhcDPmureWZ8BZlvg0/
         a2eXvOjlapBAKgOYHm/7D2QHMRbpcOOi7rWBvTzbdQE7OITO2sfk54vn6tqRTNPU026Z
         hzwg==
X-Gm-Message-State: APjAAAXPKkV+OxBgZDMt+SWyC2fWkFKWhq4oreo+4YSI+zYqe9HIUcac
        pNyE9A13qmv01OUctNJ3c20=
X-Google-Smtp-Source: APXvYqzVKUG3HyC9oV5WJB56imFChuecFoD2KQ28DdGneLgrr76MvZFy3HpNaldNWMI9HUBE5Sj8qg==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr6079999wme.89.1574173991761;
        Tue, 19 Nov 2019 06:33:11 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id v9sm26765602wrs.95.2019.11.19.06.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 06:33:10 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:33:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Message-ID: <20191119143308.GF23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Getting started with a sparse-checkout file can be daunting. Help
> users start their sparse enlistment using 'git sparse-checkout init'.
> This will set 'core.sparseCheckout=true' in their config, write
> an initial set of patterns to the sparse-checkout file, and update
> their working directory.

Reading this I was wandering what those "initial set of patterns"
might be ...

> Make sure to use the `extensions.worktreeConfig` setting and write
> the sparse checkout config to the worktree-specific config file.
> This avoids confusing interactions with other worktrees.
> 
> The use of running another process for 'git read-tree' is sub-
> optimal. This will be removed in a later change.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 11 ++++
>  builtin/sparse-checkout.c             | 79 ++++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh    | 41 ++++++++++++++
>  3 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 9d6ca22917..930a361567 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -30,6 +30,17 @@ COMMANDS
>  'list'::
>  	Provide a list of the contents in the sparse-checkout file.
>  
> +'init'::
> +	Enable the `core.sparseCheckout` setting. If the
> +	sparse-checkout file does not exist, then populate it with
> +	patterns that match every file in the root directory and
> +	no other directories, then will remove all directories tracked
> +	by Git. Add patterns to the sparse-checkout file to
> +	repopulate the working directory.

... and then reading this I was wandering why these are those "initial
set of patterns".

> ++
> +To avoid interfering with other worktrees, it first enables the
> +`extensions.worktreeConfig` setting and makes sure to set the
> +`core.sparseCheckout` setting in the worktree-specific config file.
>  
>  SPARSE CHECKOUT
>  ---------------
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 5717c9b2cb..77aa52ca01 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>  
>  static char const * const builtin_sparse_checkout_usage[] = {
> -	N_("git sparse-checkout list"),
> +	N_("git sparse-checkout (init|list)"),
>  	NULL
>  };
>  
> @@ -59,6 +59,81 @@ static int sparse_checkout_list(int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int update_working_directory(void)
> +{
> +	struct argv_array argv = ARGV_ARRAY_INIT;
> +	int result = 0;
> +	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
> +
> +	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +		error(_("failed to update index with new sparse-checkout paths"));
> +		result = 1;
> +	}
> +
> +	argv_array_clear(&argv);
> +	return result;
> +}
> +
> +enum sparse_checkout_mode {
> +	MODE_NO_PATTERNS = 0,
> +	MODE_ALL_PATTERNS = 1,
> +};
> +
> +static int sc_set_config(enum sparse_checkout_mode mode)

Nit: s/sc_//, perhaps?  I suppose that "sc" prefix stands for "sparse
checkout", but this is a static function in
'builtin/sparse-checkout.c', so it doesn't need a distinguising
prefix.  Even at the end of this patch series no other functions have
this "sc" prefix.

> +{
> +	struct argv_array argv = ARGV_ARRAY_INIT;

This 'argv_array' is not cleared at the end of the function, but...

> +	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
> +		error(_("failed to set extensions.worktreeConfig setting"));
> +		return 1;
> +	}
> +
> +	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
> +
> +	if (mode)
> +		argv_array_pushl(&argv, "true", NULL);
> +	else
> +		argv_array_pushl(&argv, "false", NULL);
> +
> +	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +		error(_("failed to enable core.sparseCheckout"));
> +		return 1;
> +	}

Why the external 'git config' invocation?

  git_config_set_in_file_gently(git_path("config.worktree"),
                                "core.sparseCheckout",
                                mode ? "true" : "false")

> +
> +	return 0;
> +}
> +
> +static int sparse_checkout_init(int argc, const char **argv)
> +{
> +	struct pattern_list pl;
> +	char *sparse_filename;
> +	FILE *fp;
> +	int res;
> +
> +	if (sc_set_config(MODE_ALL_PATTERNS))
> +		return 1;
> +
> +	memset(&pl, 0, sizeof(pl));
> +
> +	sparse_filename = get_sparse_checkout_filename();
> +	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
> +
> +	/* If we already have a sparse-checkout file, use it. */
> +	if (res >= 0) {
> +		free(sparse_filename);
> +		goto reset_dir;
> +	}
> +
> +	/* initial mode: all blobs at root */
> +	fp = xfopen(sparse_filename, "w");
> +	free(sparse_filename);
> +	fprintf(fp, "/*\n!/*/\n");

What if this fprintf() call were to fail?

> +	fclose(fp);
> +
> +reset_dir:
> +	return update_working_directory();
> +}
> +
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_sparse_checkout_options[] = {
> @@ -79,6 +154,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  	if (argc > 0) {
>  		if (!strcmp(argv[0], "list"))
>  			return sparse_checkout_list(argc, argv);
> +		if (!strcmp(argv[0], "init"))
> +			return sparse_checkout_init(argc, argv);
>  	}
>  
>  	usage_with_options(builtin_sparse_checkout_usage,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 9b73d44907..cd56cc384b 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -42,4 +42,45 @@ test_expect_success 'git sparse-checkout list (populated)' '
>  	test_cmp expect list
>  '
>  
> +test_expect_success 'git sparse-checkout init' '
> +	git -C repo sparse-checkout init &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +	EOF
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	git -C repo config --list >config &&
> +	test_i18ngrep "core.sparsecheckout=true" config &&

We have the 'test_cmp_config' helper function to check the expected
value of configuration variables.

> +	ls repo >dir  &&
> +	echo a >expect &&
> +	test_cmp expect dir
> +'
> +
> +test_expect_success 'git sparse-checkout list after init' '
> +	git -C repo sparse-checkout list >actual &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'init with existing sparse-checkout' '
> +	echo "*folder*" >> repo/.git/info/sparse-checkout &&
> +	git -C repo sparse-checkout init &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +		*folder*
> +	EOF
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	ls repo >dir  &&
> +	cat >expect <<-EOF &&
> +		a
> +		folder1
> +		folder2
> +	EOF
> +	test_cmp expect dir
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
