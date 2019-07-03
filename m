Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2411F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGCRtP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:49:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCRtP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:49:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so3336732wmj.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAn2hNKaWW1J4cCLWTrRWwfT5/TzUHef5m21BKeLeWk=;
        b=ppWirJhnqV39rgmEf3Ej5PMyqyladYW0zwXzU7np5QhBsDqDCcfirVLdylKL5gznh2
         SjbrFMdycIhR8B7ew1wzcJER0vbXNolULrNViRvWT2oIf+9Pd/guJlSjfpbTUsnTG8Qb
         7M70XiW3UJleS7RPBWl2TDINnY57JbQTqOlwN9EBOdzqEB2GJPjvEDk9l08E0c8/Ip0s
         tZWjV0D1g59Msi8wIopJy5NfJPKhSR3jsz8kqmDDDYy8eyKa5Cm4XJlUQNYwgSJhhh5e
         TcVPyJAHDpSZWZfEpkpcm1RcsHAPrio3ekahkz3fhG3L3naQk2np/uK0fDQE9lUwmUOS
         1JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAn2hNKaWW1J4cCLWTrRWwfT5/TzUHef5m21BKeLeWk=;
        b=ptoWriPSKpGyT+6KKTFMbx95PPRobWgtSUVzb6m+LqopTGGsLYx/A3+A/Jd1KvkFJy
         xwDKYq0DkvW0Lkn11Uki2ttM+zEqXkS7QuwYud/nhEOq7ZiKrju7tG7LRVyVxDC3t2AJ
         1cC/BcUfP4NG89PwXKsTAhQys3s36NCdOpnUCnRpnbEskLdxBkSQFVW02thLnNcTwr0W
         tL1FKWnG47T7JPmuvjjA9uAOOGHGXrR6hJ9AYk447+nsKe7EozQLjkhN29YsiMkMvLAO
         QS3bIPSPUSJRL1/wU8Q/QltqCS/WVX2phqihAz0Hv5kGqE2nqeJIWY9cyb90UX4YRXOb
         PNXw==
X-Gm-Message-State: APjAAAWXn9UywsHrXMU47587GcvIEYQQ7LTW7RwP615JO2T6EjkcDbSR
        DDg/oVk0qJCcyzgi0T5f6dU=
X-Google-Smtp-Source: APXvYqy1l06gr06e09nhlpjYgBUzyVoHowrV2Cftziuv6y+PZS260OxEHSQTFRk5Hf2SB8RWVIlagQ==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr8502400wmf.119.1562176152648;
        Wed, 03 Jul 2019 10:49:12 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id a2sm3679684wmj.9.2019.07.03.10.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 10:49:11 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:49:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/14] test: completion: tests for __gitcomp regression
Message-ID: <20190703174909.GU21574@szeder.dev>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-12-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190621223107.8022-12-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 05:31:04PM -0500, Felipe Contreras wrote:
> There's a regression in the completion since the introduction of
> __gitcomp.
> 
> Go to any directory that doesn't contain a git repository, like /tmp.
> Then type the following:
> 
>   git checkout --<tab>
> 
> You will see nothing. That's because
> `git checkout --git-completion-helper` fails when you run it outside a
> git repository.
> 
> You might change to a directory that has a git repository, but it's too
> late, because the empty options have been cached.

This will get outdated rather soonish, as soon as 69702523af
(completion: do not cache if --git-completion-helper fails,
2019-06-12) graduates to master.

> It's unclear how many commands are affected, but this patch attempts to
> at least detect some already in the testing framework.

It seems that several changes in this patch modify tests in a way that
defeats the purpose of the given test, e.g. the tests
'completion.commands removes multiple commands' or 'sourcing the
completion script clears cached merge strategies'

I would rather see tests specifically focusing on the
__gitcomp_builtin() helper function, including test cases when it's
excersized outside of a repository and when it gets additional
parameters to include and exclude some options.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 43cf313a1c..7bef41eaf5 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -122,6 +122,15 @@ test_gitcomp_nl ()
>  	test_cmp expected out
>  }
>  
> +offgit ()
> +{
> +	GIT_CEILING_DIRECTORIES="$ROOT" &&
> +	export GIT_CEILING_DIRECTORIES &&
> +	test_when_finished "ROOT='$ROOT'; cd '$TRASH_DIRECTORY'; unset GIT_CEILING_DIRECTORIES" &&
> +	ROOT="$ROOT"/non-repo &&
> +	cd "$ROOT"

I think fiddling with $ROOT is unnecessary here.

> +}
> +
>  invalid_variable_name='${foo.bar}'
>  
>  actual="$TRASH_DIRECTORY/actual"
> @@ -358,10 +367,8 @@ test_expect_success SYMLINKS '__git_find_repo_path - resulting path avoids symli
>  '
>  
>  test_expect_success '__git_find_repo_path - not a git repository' '
> +	offgit &&
>  	(
> -		cd non-repo &&
> -		GIT_CEILING_DIRECTORIES="$ROOT" &&
> -		export GIT_CEILING_DIRECTORIES &&
>  		test_must_fail __git_find_repo_path &&
>  		printf "$__git_repo_path" >"$actual"
>  	) &&
> @@ -1388,6 +1395,7 @@ test_expect_success '__git_pretty_aliases' '
>  '
>  
>  test_expect_success 'basic' '
> +	offgit &&
>  	run_completion "git " &&
>  	# built-in
>  	grep -q "^add \$" out &&
> @@ -1401,6 +1409,7 @@ test_expect_success 'basic' '
>  '
>  
>  test_expect_success 'double dash "git" itself' '
> +	offgit &&
>  	test_completion "git --" <<-\EOF
>  	--paginate Z
>  	--no-pager Z
> @@ -1419,7 +1428,8 @@ test_expect_success 'double dash "git" itself' '
>  	EOF
>  '
>  
> -test_expect_success 'double dash "git checkout"' '
> +test_expect_failure 'double dash "git checkout"' '
> +	offgit &&
>  	test_completion "git checkout --" <<-\EOF
>  	--quiet Z
>  	--detach Z
> @@ -1442,6 +1452,7 @@ test_expect_success 'double dash "git checkout"' '
>  '
>  
>  test_expect_success 'general options' '
> +	offgit &&
>  	test_completion "git --ver" "--version " &&
>  	test_completion "git --hel" "--help " &&
>  	test_completion "git --exe" <<-\EOF &&
> @@ -1460,6 +1471,7 @@ test_expect_success 'general options' '
>  '
>  
>  test_expect_success 'general options plus command' '
> +	offgit &&
>  	test_completion "git --version check" "checkout " &&
>  	test_completion "git --paginate check" "checkout " &&
>  	test_completion "git --git-dir=foo check" "checkout " &&
> @@ -1480,11 +1492,13 @@ test_expect_success 'general options plus command' '
>  '
>  
>  test_expect_success 'git --help completion' '
> +	offgit &&
>  	test_completion "git --help ad" "add " &&
>  	test_completion "git --help core" "core-tutorial "
>  '
>  
> -test_expect_success 'completion.commands removes multiple commands' '
> +test_expect_failure 'completion.commands removes multiple commands' '
> +	offgit &&
>  	test_config completion.commands "-cherry -mergetool" &&
>  	git --list-cmds=list-mainporcelain,list-complete,config >out &&
>  	! grep -E "^(cherry|mergetool)$" out
> @@ -1547,9 +1561,10 @@ test_expect_success 'complete tree filename with metacharacters' '
>  	EOF
>  '
>  
> -test_expect_success PERL 'send-email' '
> -	test_completion "git send-email --cov" "--cover-letter " &&
> -	test_completion "git send-email ma" "master "
> +test_expect_failure PERL 'send-email' '
> +	test_completion "git send-email ma" "master " &&
> +	offgit &&
> +	test_completion "git send-email --cov" "--cover-letter "
>  '
>  
>  test_expect_success 'complete files' '
> @@ -1649,6 +1664,7 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
>  '
>  
>  test_expect_success 'completion without explicit _git_xxx function' '
> +	offgit &&
>  	test_completion "git version --" <<-\EOF
>  	--build-options Z
>  	--no-build-options Z
> @@ -1699,13 +1715,15 @@ do
>  done
>  
>  test_expect_success 'sourcing the completion script clears cached commands' '
> +	offgit &&
>  	__git_compute_all_commands &&
>  	verbose test -n "$__git_all_commands" &&
>  	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
>  	verbose test -z "$__git_all_commands"
>  '
>  
> -test_expect_success 'sourcing the completion script clears cached merge strategies' '
> +test_expect_failure 'sourcing the completion script clears cached merge strategies' '
> +	offgit &&
>  	GIT_TEST_GETTEXT_POISON= &&
>  	__git_compute_merge_strategies &&
>  	verbose test -n "$__git_merge_strategies" &&
> @@ -1714,6 +1732,7 @@ test_expect_success 'sourcing the completion script clears cached merge strategi
>  '
>  
>  test_expect_success 'sourcing the completion script clears cached --options' '
> +	offgit &&
>  	__gitcomp_builtin checkout &&
>  	verbose test -n "$__gitcomp_builtin_checkout" &&
>  	__gitcomp_builtin notes_edit &&
> -- 
> 2.22.0
> 
