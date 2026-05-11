Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B303E556B
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505398; cv=none; b=nl9UUP4VE4AcgDTLHUitEejC5V+ZsRPUv14fqaptcNIzfyXh5NKKRakGXgdc4R1rNPrrY42AsL129/3D/xDP12LkGohm7i8D9GArYRFuVKuJEi56xX+B/KeXgqr5mfegvyGOdGKP80+mn+ImbVmHnlGL4SnP7HAgd6uRtsTqp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505398; c=relaxed/simple;
	bh=Wd8Z7FZ6fMz9oq6s7QhzBao6a7v1Vqlim8BSPDwW/xo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uhq7kngrGFrb1Ln/RCaXS+TMie6paFjZ8bcBlg8mx8qH4wTEgcSWfiOrHB7RZJP0lXZepxLs3zPcqCjVzdUAGSifkzcKy7oL/oUUxV0DLuj4mwW2bNIwrnWAu1IpAQsVusQN+ngh2iXq/8Xi7Jwz0tB1MYlUm/WNkLqrf9LUNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H54yYBhH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H54yYBhH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so39152275e9.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778505395; x=1779110195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQAkmYcsQbIdi9olJ5VATggeh4Rv03fWDR5XY2IO4R8=;
        b=H54yYBhHh4l09pLPNcjHVpvr1Cts2cIDsDNho51i+6tXcdFQ7znJ2smJs04GEwYDqS
         hocn/6GhUATbQsP+QHm8Flv4sC2+RiMe6naKHEkbOV9rRtJ4PEEAaY/QjxoOvbUy1/nG
         ZmIT1uyaLD5jh9AU5eYZMVMYsZ7O0lI2g8bfhCbiLTzJxu9cOhWEp1mrUI/zi/fIQ1IJ
         C93Lx6KfsilEIsgMmm8GvDQHaugtZdsTcB9cjLbNeIRC/6IsSFIZ10VBi7ibb4LAky3a
         W8fND3SrzKt6V25bqBvdztdBh0GPeZRqzznrZ68ODF/6pLLptTT28mCJKrBUC1WtBN57
         fGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505395; x=1779110195;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQAkmYcsQbIdi9olJ5VATggeh4Rv03fWDR5XY2IO4R8=;
        b=Efb743aHfVNZdD2BLfoSmNiGPiNoyuWHYuVu1wExA5UKa2VaaGsNK8fI8HQ21FE3Pe
         8ykVDSS0E4u7vMl0ks+hC9QDk/hf/pagfFIeobymhOlL64dlUE4AlUrrUzP129+G3R0o
         SBtRlDQPNfmU01J9omoWWMuiLysekT0LWDJoyn4ayZ8ygb8+x2Mxk/YigKu1q26sA7H+
         r009XERdXpCQGIWz/yWDBJBY8jq2vVeF/IajDPLsl1wV4MwrNPtPkUlSqjl7Eh9OiFK2
         OLzV+809MqtIx3CX2kdM8CnCFfmWNXdLhUr503TiKadwE2zSEkijyhFdX103bFlwAa/u
         x1nQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GL6C3yJ713lPro2/Q4alTkxPy+snlEWQ/NYNxrJh9Yqpdccl0dmbeCV3lxFTQN0FftSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziN/XUN6+H26628ywT2jsbi/PzSf6t2LSuEa7IQg566nivIVdR
	Pwko2zem2PDpzvEbrZQ28NVBpz07lS/FTcFnvGcG+xMSEhUNiPF0HL1T
X-Gm-Gg: Acq92OHuF4SkZip+WnNTMtcuLKI6OUvsX47zw3cROpMVO7sYQIpquBolxYkGJs8v3o+
	uIuYdl2WoIAnmiSicdrBIr+pfugHQf5fl1xuyFcq0x4cjBYH0bXr2EJLxTPEztAA3V7oary4CLu
	jnhuU7cGLakVX43Ed6pYoZnIr9fH0ABmhb6aUc8PyIUJui0ninRZ7aeQVWIo0QIPIEPRbmwnK+t
	Nnw5mMCDfKqim/iPgziE39fXpHaE1pCtNA/mm2nqblBiPo3QmG1O+seIl4x7LcLRPD84AKXJN3R
	wCzAbjPb4u9XktdEn+P5i2PQQ/s/V8Yc0mT4L+CMgz7RPd2aK8l4f3KRwUjZv84sY6Ko4b8oB8q
	eDiSlff53FbdrBJHtqvhBT75wibR4LfBFzDYlYS2vMHL8Hgr5DINWSS6ST7P2njMZOSW84ukN76
	cRSprx/bqBj8TxdVFFpaOhb4weu0VOpi/uUqxlcj/XDr2C16/UK5fzDNI7lai/YEZzUDtMGkE6j
	z+Y/Q==
X-Received: by 2002:a05:600c:4617:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48e51e0bb17mr218624405e9.4.1778505394768;
        Mon, 11 May 2026 06:16:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6? ([2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0bf2sm325694385e9.4.2026.05.11.06.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:16:34 -0700 (PDT)
Message-ID: <98410b9c-8ed6-41df-b508-ca9e15d4ee53@gmail.com>
Date: Mon, 11 May 2026 14:16:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
 <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 08/05/2026 23:52, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> +static void fetch_remote_for_start_point(const char *arg)
> +{
> +	char *remote_name = NULL;
> +	char *src_ref = NULL;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf dst_ref = STRBUF_INIT;
> +	int have_existing_ref = 0;
> +
> +	if (resolve_fetch_target(arg, &remote_name, &src_ref))
> +		return;
> +
> +	if (src_ref) {
> +		const char *short_src = src_ref;
> +		struct object_id oid;
> +
> +		skip_prefix(short_src, "refs/heads/", &short_src);
> +		strbuf_addf(&dst_ref, "refs/remotes/%s/%s", remote_name, short_src);
> +		if (!refs_read_ref(get_main_ref_store(the_repository),
> +				   dst_ref.buf, &oid))
> +			have_existing_ref = 1;

src_ref is the name of the branch on the remote server, not the name of 
the remote tracking ref which is given by arg. If arg is a remote name 
then we need to resolve refs/remotes/$arg/HEAD to find the branch to 
check, otherwise we should be checking refs/remotes/$arg

I've only given this version a quick scan through, but I didn't notice 
any other issues.

Thanks

Phillip

> +	}
> +
> +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
> +	if (src_ref)
> +		strvec_push(&cmd.args, src_ref);
> +	cmd.git_cmd = 1;
> +	if (run_command(&cmd)) {
> +		if (have_existing_ref)
> +			warning(_("failed to fetch start-point '%s'; "
> +				  "using existing '%s'"),
> +				arg, dst_ref.buf);
> +		else
> +			die(_("failed to fetch start-point '%s'"), arg);
> +	}
> +
> +	free(remote_name);
> +	free(src_ref);
> +	strbuf_release(&dst_ref);
> +}
> +
> +static int parse_opt_checkout_track(const struct option *opt,
> +				    const char *arg, int unset)
> +{
> +	struct checkout_opts *opts = opt->value;
> +	struct string_list tokens = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	int saw_direct = 0, saw_inherit = 0;
> +	int ret = 0;
> +
> +	opts->fetch = 0;
> +
> +	if (unset) {
> +		opts->track = BRANCH_TRACK_NEVER;
> +		return 0;
> +	}
> +
> +	opts->track = BRANCH_TRACK_EXPLICIT;
> +	if (!arg)
> +		return 0;
> +
> +	string_list_split(&tokens, arg, ",", -1);
> +	for_each_string_list_item(item, &tokens) {
> +		if (!strcmp(item->string, "fetch")) {
> +			opts->fetch = 1;
> +		} else if (!strcmp(item->string, "direct")) {
> +			saw_direct = 1;
> +			opts->track = BRANCH_TRACK_EXPLICIT;
> +		} else if (!strcmp(item->string, "inherit")) {
> +			saw_inherit = 1;
> +			opts->track = BRANCH_TRACK_INHERIT;
> +		} else {
> +			ret = error(_("option `%s' expects \"%s\", \"%s\", "
> +				      "or \"%s\""),
> +				    "--track", "direct", "inherit", "fetch");
> +			goto out;
> +		}
> +	}
> +
> +	if (saw_direct && saw_inherit)
> +		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
> +			    "--track", "direct", "inherit");
> +
> +out:
> +	string_list_clear(&tokens, 0);
> +	return ret;
> +}
> +
>   static void branch_info_release(struct branch_info *info)
>   {
>   	free(info->name);
> @@ -1237,7 +1391,6 @@ static int git_checkout_config(const char *var, const char *value,
>   		opts->dwim_new_local_branch = git_config_bool(var, value);
>   		return 0;
>   	}
> -
>   	if (starts_with(var, "submodule."))
>   		return git_default_submodule_config(var, value, NULL);
>   
> @@ -1734,10 +1887,10 @@ static struct option *add_common_switch_branch_options(
>   {
>   	struct option options[] = {
>   		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
> -		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
> +		OPT_CALLBACK_F('t', "track",  opts, "(direct|inherit|fetch)[,...]",
>   			N_("set branch tracking configuration"),
>   			PARSE_OPT_OPTARG,
> -			parse_opt_tracking_mode),
> +			parse_opt_checkout_track),
>   		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
>   			   PARSE_OPT_NOCOMPLETE),
>   		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unborn branch")),
> @@ -1942,8 +2095,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   			opts->dwim_new_local_branch &&
>   			opts->track == BRANCH_TRACK_UNSPECIFIED &&
>   			!opts->new_branch;
> -		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
> -					     &new_branch_info, opts, &rev);
> +		int n;
> +
> +		if (opts->fetch)
> +			fetch_remote_for_start_point(argv[0]);
> +
> +		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
> +					 &new_branch_info, opts, &rev);
>   		argv += n;
>   		argc -= n;
>   	} else if (!opts->accept_ref && opts->from_treeish) {
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..19ac6a1a2e 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -801,4 +801,136 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
>   	test_cmp_config "" --default "" branch.main2.merge
>   '
>   
> +test_expect_success 'setup upstream for --track=fetch tests' '
> +	git checkout main &&
> +	git init fetch_upstream &&
> +	test_commit -C fetch_upstream u_main &&
> +	git remote add fetch_upstream fetch_upstream &&
> +	git fetch fetch_upstream &&
> +	git -C fetch_upstream checkout -b fetch_new &&
> +	test_commit -C fetch_upstream u_new
> +'
> +
> +test_expect_success 'checkout --track=fetch -b picks up branch created upstream after clone' '
> +	git checkout main &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
> +	git checkout --track=fetch -b local_new fetch_upstream/fetch_new &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
> +	test_cmp_config fetch_upstream branch.local_new.remote &&
> +	test_cmp_config refs/heads/fetch_new branch.local_new.merge
> +'
> +
> +test_expect_success 'checkout --track=fetch <remote>/<branch> leaves other tracking branches untouched' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_target &&
> +	test_commit -C fetch_upstream u_target_pre &&
> +	git -C fetch_upstream checkout -b fetch_other &&
> +	test_commit -C fetch_upstream u_other_pre &&
> +	git fetch fetch_upstream &&
> +	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
> +	git -C fetch_upstream checkout fetch_target &&
> +	test_commit -C fetch_upstream u_target_post &&
> +	git -C fetch_upstream checkout fetch_other &&
> +	test_commit -C fetch_upstream u_other_post &&
> +	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
> +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
> +'
> +
> +test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout main &&
> +	git remote set-head fetch_upstream main &&
> +	git -C fetch_upstream checkout -b fetch_unrelated &&
> +	test_commit -C fetch_upstream u_unrelated_pre &&
> +	git fetch fetch_upstream fetch_unrelated &&
> +	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
> +	git -C fetch_upstream checkout main &&
> +	test_commit -C fetch_upstream u_main_post &&
> +	git -C fetch_upstream checkout fetch_unrelated &&
> +	test_commit -C fetch_upstream u_unrelated_post &&
> +	git checkout --track=fetch -b local_from_remote fetch_upstream &&
> +	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
> +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
> +'
> +
> +test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
> +	git checkout main &&
> +	test_might_fail git branch -D bogus &&
> +	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
> +	test_must_fail git rev-parse --verify refs/heads/bogus
> +'
> +
> +test_expect_success 'checkout --track=fetch warns and proceeds when fetch fails but ref exists' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_offline &&
> +	test_commit -C fetch_upstream u_offline &&
> +	git fetch fetch_upstream fetch_offline &&
> +	saved_url=$(git config remote.fetch_upstream.url) &&
> +	test_when_finished "git config remote.fetch_upstream.url \"$saved_url\"" &&
> +	git config remote.fetch_upstream.url ./does-not-exist &&
> +	git checkout --track=fetch -b local_offline fetch_upstream/fetch_offline 2>err &&
> +	test_grep "failed to fetch" err &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_refspec &&
> +	test_commit -C fetch_upstream u_refspec &&
> +	git fetch fetch_upstream fetch_refspec &&
> +	git remote add fetch_custom ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_custom" &&
> +	git config --replace-all remote.fetch_custom.fetch \
> +		"+refs/heads/*:refs/remotes/custom-ns/*" &&
> +	git fetch fetch_custom &&
> +	test_commit -C fetch_upstream u_refspec_post &&
> +	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
> +	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
> +'
> +
> +test_expect_success 'checkout --track=inherit,direct is rejected' '
> +	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
> +	test_grep "cannot combine" err
> +'
> +
> +test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_lastwin &&
> +	test_commit -C fetch_upstream u_lastwin &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin &&
> +	test_must_fail git checkout --track=fetch --track=direct \
> +		-b local_lastwin fetch_upstream/fetch_lastwin &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
> +'
> +
> +test_expect_success 'checkout --track=fetch,inherit fetches and inherits' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_inherit &&
> +	test_commit -C fetch_upstream u_inherit &&
> +	git fetch fetch_upstream fetch_inherit &&
> +	git checkout -b base_inherit fetch_upstream/fetch_inherit &&
> +	test_commit -C fetch_upstream u_inherit2 &&
> +	git checkout main &&
> +	git checkout --track=fetch,inherit -b local_inherit base_inherit &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD &&
> +	test_cmp_config fetch_upstream branch.local_inherit.remote &&
> +	test_cmp_config refs/heads/fetch_inherit branch.local_inherit.merge
> +'
> +
> +test_expect_success 'checkout --track=bogus reports an error' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
> +	test_grep "expects" err
> +'
> +
> +test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_switch &&
> +	test_commit -C fetch_upstream u_switch &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
> +	git switch --track=fetch -c local_switch fetch_upstream/fetch_switch &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
> +'
> +
>   test_done
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0

