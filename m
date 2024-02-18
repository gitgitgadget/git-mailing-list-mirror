Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2E38388
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252348; cv=none; b=Yb26WmJtsHWwKm/ux/jqTkupDVPRx1Zlpxqmy6t10MR1TMHp8SFeyrHQC7VN7/t0njLum+RmRdjDKCnYx0s5h77DYFLEn3iQi/U8Cj61PkmPGiBmnu7xQrM656+ixUQYjYJkjP2RyTTn8+bbno8zq1trIA0zU5C/c+j6riS4GZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252348; c=relaxed/simple;
	bh=jYWDyNPtDpG99x/pU+BS/uJxx/TLfnPbSZAPNAoLUxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A2D2qSGzb+wDLnUqwejpikjHNTY2GyS1dCWtzwKK4T1HoRGWvL7VMeZXKAviAM/d824N12MR+OnDsSHQU/PSJ69buejX5hqq2Wf/ag1peUzk+sZY6FweFv1TMPfkbR1yYVJJPt3xnRPUGsuufU5Ja9bULTjhQMbMOvfy1ufRtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgx7e8L3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgx7e8L3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so24751445e9.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708252345; x=1708857145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hgtZWRY3WXTuQMTVWsKGWW/ALfe5NtPd7sVQNKw/Ccw=;
        b=Cgx7e8L35nfTEQ/7P6JVhDTH5gD+wle5b9nmD7ovvXy9qMT/csSMN8loCIFEkjVHv6
         BfrZRcK65Ydej6d61cBVdZelE+9het1njyfLt1n+y1cvVxghmMwxgMfLs0lPhe2mcgRg
         kdfN6G2Q2fRp26uzyHlxemKCC7kH3JiU2On8JsdWhd4YKkVDxKYe/2S7qAILpdZuqimP
         Y5VJVgJCn0hdxaKnn1ahmYbKRUg8neT4Rh9zlIVJctzhbnp6n7ZEoSswECSFA1aoiq+e
         cBkQkYStC3OyuH75lfaN7Mkc2twdi19ZZBnPTS64C6DpRMmQuA0sf+7a4lO8taecX8wi
         z7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708252345; x=1708857145;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgtZWRY3WXTuQMTVWsKGWW/ALfe5NtPd7sVQNKw/Ccw=;
        b=K1K+E/a4ipMXJZ9JnN1xLMcudioJfqDAqAujeiy4uLoNMtHxn0w2OZ1ND8Qnb1YeCV
         Zeey4t2hEwYXUHP04s6PfDxuI5RuWRu7qwfCntf5NNr+z60HraPbi+QQ1tOr3CCd7AzL
         5o85yRENMxS/Zv4rZOHQhszRpDCUNaSdyBi/URv2boU4WMAPoDCilmgUEwq/p4CJCwtJ
         G968fEoEl8MJOgMkd3lFEe//AEJ3LG5M1MQEa5Uftz6G+l2RFajHLSEf+gnEIW3lTWDZ
         31dCStHZOriQ8/rM8BWvpiEJLi6/f8xdjsUkOA7rWJLQ7tnFCDtzVEfkrl/BlY1i159R
         sCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqJ1D9tv5T22q8tPUp4sFvMiviMht2lcQLWirHlFPB9imcyB+6DOBnWa4KgU8544JZNRwP8adANuHQi7pWgu/cpsD
X-Gm-Message-State: AOJu0Yz1nBhOnXkNFHgcABcFGRNHhlJU0bDR6nQc8wnoR/o/aVozjvPO
	6FFvmaVRaqw+b0GWcVCGU2FTd3/oEKOzQpy4goOkU5lM7vsjZk54v7KO6vbg
X-Google-Smtp-Source: AGHT+IFqloUxYM6XtpJf519UtGn0QYT8pTd8qS0FxB7/IdMRI8VyvhxkMo+aUlzW1HrQVbGB7xZPhQ==
X-Received: by 2002:a05:600c:4f8a:b0:412:4731:a5e9 with SMTP id n10-20020a05600c4f8a00b004124731a5e9mr5094184wmq.4.1708252344888;
        Sun, 18 Feb 2024 02:32:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b00410c7912c6esm7818557wmq.14.2024.02.18.02.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 02:32:24 -0800 (PST)
Message-ID: <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
Date: Sun, 18 Feb 2024 10:32:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: MithicSpirit <rpc01234@gmail.com>, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240218033146.372727-2-rpc01234@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ricardo

On 18/02/2024 03:30, MithicSpirit wrote:
> Adds options `stash.keepIndex` and `stash.includeUntracked`, which
> enable `--keep-index` and `--include-untracked` by default (unless it
> would conflict with another option). This is done to facilitate the
> workflow where a user:
> 
> . Makes modifications;
> . Selectively adds them with `git add -p`; and
> . Stashes the unadded changes to run tests with only the current
>    modifications.
> 
> `stash.keepIndex` is especially important for this, as otherwise the
> work done in `git add -p` is lost since applying the stash does not
> restore the index.

How does "stash.keepIndex" interact with "git rebase --autostash" and 
"git merge --autostash"? I think both those commands expect a clean 
index after running "git stash". They could just override the config 
setting but it might get a bit confusing if some commands respect the 
config and others don't.

> This problem could also be solved by adding
> functionality to the stash to restore the index specifically, but this
> would create much more complexity and still wouldn't be as convenient
> for that workflow.
> 
> Signed-off-by: Ricardo Prado Cunha (MithicSpirit) <rpc01234@gmail.com>
> ---
> This is my first patch to git and my first time using mailing lists for this
> kind of stuff. Please do let me know of any mistakes or gaffes I've made.

I've only given the patch a very quick scan, but it looked sensible. The 
only thing that jumped out at me was that quite a few tests seem to do

	git init repo &&
	(
		cd repo &&
		# test things
	) &&

Our normal practice is to run all the tests in the same file in the same 
repository rather than setting up a new one each time.

Best Wishes

Phillip


>   Documentation/config/stash.txt |  13 ++++
>   builtin/stash.c                |  65 ++++++++++++------
>   t/t3903-stash.sh               | 119 +++++++++++++++++++++++++++++++++
>   3 files changed, 178 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> index ec1edaeba6..d6d9ea7daa 100644
> --- a/Documentation/config/stash.txt
> +++ b/Documentation/config/stash.txt
> @@ -1,6 +1,19 @@
> +stash.includeUntracked::
> +	Boolean option that configures whether the `git stash push` and `git
> +	stash save` commands also stash untracked files by default. This option
> +	is ignored if `--include-untracked`, `--no-include-untracked`, `--all`,
> +	`--patch`, or `--staged` are used. Defaults to `false`. See
> +	linkgit:git-stash[1].
> +
> +stash.keepIndex::
> +	Boolean option that configures whether the `git stash push` and `git
> +	stash save` commands also stash changes that have been added to the
> +	index. This option is ignored if `--keep-index`, `--no-keep-index`, or
> +	`--patch` are used. Defaults to `false`. See linkgit:git-stash[1].
> +
>   stash.showIncludeUntracked::
>   	If this is set to true, the `git stash show` command will show
>   	the untracked files of a stash entry.  Defaults to false. See
>   	the description of the 'show' command in linkgit:git-stash[1].
> 
>   stash.showPatch::
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 7fb355bff0..c591a2bf4b 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -836,12 +836,14 @@ static int list_stash(int argc, const char **argv, const char *prefix)
>   	return run_command(&cp);
>   }
> 
>   static int show_stat = 1;
>   static int show_patch;
>   static int show_include_untracked;
> +static int default_keep_index;
> +static int default_include_untracked;
> 
>   static int git_stash_config(const char *var, const char *value,
>   			    const struct config_context *ctx, void *cb)
>   {
>   	if (!strcmp(var, "stash.showstat")) {
>   		show_stat = git_config_bool(var, value);
> @@ -852,12 +854,20 @@ static int git_stash_config(const char *var, const char *value,
>   		return 0;
>   	}
>   	if (!strcmp(var, "stash.showincludeuntracked")) {
>   		show_include_untracked = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "stash.keepindex")) {
> +		default_keep_index = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "stash.includeuntracked")) {
> +		default_include_untracked = git_config_bool(var, value);
> +		return 0;
> +	}
>   	return git_diff_basic_config(var, value, ctx, cb);
>   }
> 
>   static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
>   {
>   	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
> @@ -1509,33 +1519,50 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   	int ret = 0;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct strbuf patch = STRBUF_INIT;
>   	struct strbuf stash_msg_buf = STRBUF_INIT;
>   	struct strbuf untracked_files = STRBUF_INIT;
> 
> -	if (patch_mode && keep_index == -1)
> -		keep_index = 1;
> -
> -	if (patch_mode && include_untracked) {
> -		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
> -				     " or --all at the same time"));
> -		ret = -1;
> -		goto done;
> +	if (keep_index == -1) {
> +		if (patch_mode)
> +			keep_index = 1;
> +		else
> +			keep_index = default_keep_index;
>   	}
> 
> -	/* --patch overrides --staged */
> -	if (patch_mode)
> +	if (patch_mode) {
> +		if (include_untracked == -1)
> +			include_untracked = 0;
> +		else if (include_untracked) {
> +			fprintf_ln(stderr,
> +				   _("Can't use --patch and --include-untracked"
> +				     " or --all at the same time"));
> +			ret = -1;
> +			goto done;
> +		}
> +
> +		/* --patch overrides --staged */
>   		only_staged = 0;
> -
> -	if (only_staged && include_untracked) {
> -		fprintf_ln(stderr, _("Can't use --staged and --include-untracked"
> -				     " or --all at the same time"));
> -		ret = -1;
> -		goto done;
>   	}
> 
> +	if (only_staged) {
> +		if (include_untracked == -1)
> +			include_untracked = 0;
> +		else if (include_untracked) {
> +			fprintf_ln(
> +				stderr,
> +				_("Can't use --staged and --include-untracked"
> +				  " or --all at the same time"));
> +			ret = -1;
> +			goto done;
> +		}
> +	}
> +
> +	if (include_untracked == -1)
> +		include_untracked = default_include_untracked;
> +
>   	repo_read_index_preload(the_repository, NULL, 0);
>   	if (!include_untracked && ps->nr) {
>   		int i;
>   		char *ps_matched = xcalloc(ps->nr, 1);
> 
>   		/* TODO: audit for interaction with sparse-index. */
> @@ -1688,13 +1715,13 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   				fprintf_ln(stderr, _("Cannot remove "
>   						     "worktree changes"));
>   			ret = -1;
>   			goto done;
>   		}
> 
> -		if (keep_index < 1) {
> +		if (!keep_index) {
>   			struct child_process cp = CHILD_PROCESS_INIT;
> 
>   			cp.git_cmd = 1;
>   			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
>   				     NULL);
>   			add_pathspecs(&cp.args, ps);
> @@ -1718,13 +1745,13 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   		      int push_assumed)
>   {
>   	int force_assume = 0;
>   	int keep_index = -1;
>   	int only_staged = 0;
>   	int patch_mode = 0;
> -	int include_untracked = 0;
> +	int include_untracked = -1;
>   	int quiet = 0;
>   	int pathspec_file_nul = 0;
>   	const char *stash_msg = NULL;
>   	const char *pathspec_from_file = NULL;
>   	struct pathspec ps;
>   	struct option options[] = {
> @@ -1798,13 +1825,13 @@ static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
> 
>   static int save_stash(int argc, const char **argv, const char *prefix)
>   {
>   	int keep_index = -1;
>   	int only_staged = 0;
>   	int patch_mode = 0;
> -	int include_untracked = 0;
> +	int include_untracked = -1;
>   	int quiet = 0;
>   	int ret = 0;
>   	const char *stash_msg = NULL;
>   	struct pathspec ps;
>   	struct strbuf stash_msg_buf = STRBUF_INIT;
>   	struct option options[] = {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 00db82fb24..4ffcca742c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1565,7 +1565,126 @@ test_expect_success 'stash apply reports a locked index' '
>   		EOF
>   		test_must_fail git stash apply 2>err &&
>   		test_cmp expect err
>   	)
>   '
> 
> +setup_dirty() {
> +	echo a >tracked &&
> +	echo b >added-modified &&
> +	git add tracked added-modified &&
> +	git commit -m initial &&
> +	echo 1 >>tracked &&
> +	echo 2 >>added-modified &&
> +	echo c >added-new &&
> +	echo d >untracked &&
> +	git add added-modified added-new
> +}
> +
> +test_expect_success 'stash.includeuntracked equivalent to --include-untracked' '
> +	git init using_opt &&
> +	test_when_finished rm -rf using_opt &&
> +	(
> +		cd using_opt &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-opt
> +	) &&
> +
> +	test_config stash.includeuntracked true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp using-opt using-config
> +'
> +
> +test_expect_success 'stash.includeuntracked yields to --no-include-untracked' '
> +	git init no_config &&
> +	test_when_finished rm -rf no_config &&
> +	(
> +		cd no_config &&
> +		setup_dirty &&
> +		git stash push --no-include-untracked &&
> +		git stash show -u --patch >../no-config
> +	) &&
> +
> +	test_config stash.includeuntracked true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push --no-include-untracked &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp no-config using-config
> +'
> +
> +test_expect_success 'stash.includeuntracked succeeds with --patch' '
> +	test_config stash.includeuntracked true &&
> +	git stash --patch
> +'
> +
> +test_expect_success 'stash.includeuntracked succeeds with --staged' '
> +	test_config stash.includeuntracked true &&
> +	git stash --staged
> +'
> +
> +test_expect_success 'stash.keepindex equivalent to --keep-index' '
> +	git init using_opt &&
> +	test_when_finished rm -rf using_opt &&
> +	(
> +		cd using_opt &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-opt
> +	) &&
> +
> +	test_config stash.keepindex true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp using-opt using-config
> +'
> +
> +test_expect_success 'stash.keepindex yields to --no-keep-index' '
> +	git init no_config &&
> +	test_when_finished rm -rf no_config &&
> +	(
> +		cd no_config &&
> +		setup_dirty &&
> +		git stash push --no-keep-index &&
> +		git stash show -u --patch >../no-config
> +	) &&
> +
> +	test_config stash.keepindex true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push --no-keep-index &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp no-config using-config
> +'
> +
> +test_expect_success 'stash.keepindex succeeds with --patch' '
> +	test_config stash.keepindex true &&
> +	git stash --patch
> +'
> +
>   test_done
> --
> 2.43.2
> 
