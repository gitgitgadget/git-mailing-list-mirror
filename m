Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140D31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbeHNULH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:11:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36915 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbeHNULG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:11:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so9395447pgq.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vg0dc5Hq2j1SDOwQeOZo3vJ+iASKRGXERtCgAUhqTiU=;
        b=MxjB091y2nkM1INGasuPnd0Dk5n5ZFZzbfZBAB6llE0+EcXIG948YfB7R5kT+nHcm1
         ELPJYifV/0NgSJ73S2D5NRRfjVfLjSELh12Y/TLRCnRgPC9bF/QElBL4K0QsbVorW736
         J8H6p2BBxyuwc7FfUKw54Tf0KIH4b0bCqVQBhdEziHE6hTwiUUfLzZOVDZgMtcWmbJXq
         dYr2QPPDyzcEF6IFKIz8XTz7/hwS3BXPZBG/vZL64/pReEPrV8kyleGvmZMJIDwihrHN
         E0yHi5It41ObRRNwwqvCMk5uSRTGWg+Koaz63qkqJUWcYlQnEouYLLIYnikaA0noaBwy
         m7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vg0dc5Hq2j1SDOwQeOZo3vJ+iASKRGXERtCgAUhqTiU=;
        b=entTPOICo10VFBUxNrpf6kROJ/AOuqlz51qXsVl5gLTONyiC9HNzQKXS3qmD5U6eIC
         UnPOwPUq+W0bH39UugJk2G3CMx5fvFcuD6Ru6yvkjmMUG7lY4WTE3y/BYP8+hcC1+rmP
         aQwNR8LoyDZsFwUShHQNDTzvI2btAVAra1hcgAc9daZWmt+tXn5V8wieHb4xcM6b7IGx
         8DY4MatXaOZY3n86PB2jKovZ6mHEKudMs6Io2ER1WjicbgAXZbjW+hx97ORCEHblNhEU
         tMoTfcWPa5qdOwKPpddB8PGJoL9SiplDJtVdAEDwKxanjxyt+MPEoY5T4qT49klCF6ve
         F+Ug==
X-Gm-Message-State: AOUpUlE4NytywRRJ0Yly/d6iFa8tOYF149xYgVAlYPg6HRcS9/32c5Hb
        14yGOrNSd4dpZOZRRnufIB4rlQ==
X-Google-Smtp-Source: AA+uWPzh4zQnNL+0vMFGDH7NiqSyCwrr730AqTZzRaZ3jl+VRdKP6BfjEIwdQ6iz52Ot6FGPWRJ9jw==
X-Received: by 2002:a62:9b18:: with SMTP id r24-v6mr24196287pfd.105.1534267381142;
        Tue, 14 Aug 2018 10:23:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f67-v6sm38924469pfe.75.2018.08.14.10.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 10:22:59 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:22:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when
 it's not checked out
Message-ID: <20180814172258.GB233973@google.com>
References: <20180814110525.17801-1-ao2@ao2.it>
 <20180814110525.17801-8-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814110525.17801-8-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Antonio Ospite wrote:
> When the .gitmodules file is not available in the working tree, try
> using HEAD:.gitmodules from the current branch. This covers the case
> when the file is part of the repository but for some reason it is not
> checked out, for example because of a sparse checkout.
> 
> This makes it possible to use at least the 'git submodule' commands
> which *read* the gitmodules configuration file without fully populating
> the working tree.
> 
> Writing to .gitmodules will still require that the file is checked out,
> so check for that before calling config_set_in_gitmodules_file_gently.
> 
> Add a similar check also in git-submodule.sh::cmd_add() to anticipate
> the eventual failure of the "git submodule add" command when .gitmodules
> is not safely writeable; this prevents the command from leaving the
> repository in a spurious state (e.g. the submodule repository was cloned
> but .gitmodules was not updated because
> config_set_in_gitmodules_file_gently failed).
> 
> Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
> from .gitmodules succeeds and that writing to it fails when the file is
> not checked out.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
> 
> Maybe the check in config_set_in_gitmodules_file_gently and
> git-submodule.sh::cmd_add() can share some code:
> 
>   - add an is_gitmodules_safely_writeable() helper
>   - expose a "submodule--helper config --is-safely-writeable" subcommand
> 
> But for now I preferred to keep the changes with v2 to a minimum to avoid
> blocking the series.
> 
> If adding a new helper is preferred I can do a v4 or send a follow-up patch.

I see how it would be nice to have the addition of a helper like this.
I think maybe at some point we'd want it but its definitely not needed
now and can easily be added at a later point (maybe we can avoid needing
it until we can convert all of the git-submodule.sh code to C!).

Great work, thanks for working on this.

> 
> Thank you,
>    Antonio
> 
> 
>  builtin/submodule--helper.c            | 17 ++++-
>  cache.h                                |  1 +
>  git-submodule.sh                       |  7 ++
>  submodule-config.c                     | 16 ++++-
>  t/t7416-submodule-sparse-gitmodules.sh | 90 ++++++++++++++++++++++++++
>  5 files changed, 128 insertions(+), 3 deletions(-)
>  create mode 100755 t/t7416-submodule-sparse-gitmodules.sh
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7481d03b63..c0370a756b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2036,8 +2036,23 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  		return print_config_from_gitmodules(argv[1]);
>  
>  	/* Equivalent to ACTION_SET in builtin/config.c */
> -	if (argc == 3)
> +	if (argc == 3) {
> +		struct object_id oid;
> +
> +		/*
> +		 * If the .gitmodules file is not in the working tree but it
> +		 * is in the current branch, stop, as writing new values (and
> +		 * staging them) would blindly overwrite ALL the old content.
> +		 *
> +		 * This check still makes it possible to create a brand new
> +		 * .gitmodules when it is safe to do so: when neither
> +		 * GITMODULES_FILE nor GITMODULES_HEAD exist.
> +		 */
> +		if (!file_exists(GITMODULES_FILE) && get_oid(GITMODULES_HEAD, &oid) >= 0)
> +			die(_("please make sure that the .gitmodules file in the current branch is checked out"));
> +
>  		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> +	}
>  
>  	die("submodule--helper config takes 1 or 2 arguments: name [value]");
>  }
> diff --git a/cache.h b/cache.h
> index 8dc7134f00..900f9e09e5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -486,6 +486,7 @@ static inline enum object_type object_type(unsigned int mode)
>  #define INFOATTRIBUTES_FILE "info/attributes"
>  #define ATTRIBUTE_MACRO_PREFIX "[attr]"
>  #define GITMODULES_FILE ".gitmodules"
> +#define GITMODULES_HEAD "HEAD:.gitmodules"
>  #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
>  #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
>  #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ff258e2e8c..b1cb187227 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -159,6 +159,13 @@ cmd_add()
>  		shift
>  	done
>  
> +	# For more details about this check, see
> +	# builtin/submodule--helper.c::module_config()
> +	if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules > /dev/null 2>&1
> +	then
> +		 die "$(eval_gettext "please make sure that the .gitmodules file in the current branch is checked out")"
> +	fi
> +
>  	if test -n "$reference_path"
>  	then
>  		is_absolute_path "$reference_path" ||
> diff --git a/submodule-config.c b/submodule-config.c
> index b7ef055c63..088dabb56f 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "dir.h"
>  #include "repository.h"
>  #include "config.h"
>  #include "submodule-config.h"
> @@ -603,8 +604,19 @@ static void submodule_cache_check_init(struct repository *repo)
>  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
>  	if (repo->worktree) {
> -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> -		git_config_from_file(fn, file, data);
> +		struct git_config_source config_source = { 0 };
> +		const struct config_options opts = { 0 };
> +		struct object_id oid;
> +		char *file;
> +
> +		file = repo_worktree_path(repo, GITMODULES_FILE);
> +		if (file_exists(file))
> +			config_source.file = file;
> +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> +			config_source.blob = GITMODULES_HEAD;
> +
> +		config_with_options(fn, data, &config_source, &opts);
> +
>  		free(file);
>  	}
>  }
> diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
> new file mode 100755
> index 0000000000..5341e9b012
> --- /dev/null
> +++ b/t/t7416-submodule-sparse-gitmodules.sh
> @@ -0,0 +1,90 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
> +#
> +
> +test_description='Test reading/writing .gitmodules when not in the working tree
> +
> +This test verifies that, when .gitmodules is in the current branch but is not
> +in the working tree reading from it still works but writing to it does not.
> +
> +The test setup uses a sparse checkout, however the same scenario can be set up
> +also by committing .gitmodules and then just removing it from the filesystem.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'sparse checkout setup which hides .gitmodules' '
> +	echo file > file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m upstream &&
> +	git clone . super &&
> +	git clone super submodule &&
> +	git clone super new_submodule &&
> +	(cd super &&
> +		git submodule add ../submodule &&
> +		test_tick &&
> +		git commit -m submodule &&
> +		cat >.git/info/sparse-checkout <<\EOF &&
> +/*
> +!/.gitmodules
> +EOF
> +		git config core.sparsecheckout true &&
> +		git read-tree -m -u HEAD &&
> +		test_path_is_missing .gitmodules
> +	)
> +'
> +
> +test_expect_success 'reading gitmodules config file when it is not checked out' '
> +	(cd super &&
> +		echo "../submodule" >expected &&
> +		git submodule--helper config submodule.submodule.url >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success 'not writing gitmodules config file when it is not checked out' '
> +	(cd super &&
> +		test_must_fail git submodule--helper config submodule.submodule.url newurl
> +	)
> +'
> +
> +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> +	(cd super &&
> +		git submodule init
> +	)
> +'
> +
> +test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
> +	(cd super &&
> +		git submodule summary
> +	)
> +'
> +
> +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> +	(cd submodule &&
> +		echo file2 >file2 &&
> +		git add file2 &&
> +		git commit -m "add file2 to submodule"
> +	) &&
> +	(cd super &&
> +		git submodule update
> +	)
> +'
> +
> +test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
> +	(cd super &&
> +		test_must_fail git submodule add ../new_submodule
> +	)
> +'
> +
> +# This test checks that the previous "git submodule add" did not leave the
> +# repository in a spurious state when it failed.
> +test_expect_success 'init submodule still works even after the previous add failed' '
> +	(cd super &&
> +		git submodule init
> +	)
> +'
> +
> +test_done
> -- 
> 2.18.0
> 

-- 
Brandon Williams
