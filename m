Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA21EB29
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC0Wx7eo"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA4AC6
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 03:06:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso58232691fa.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699268765; x=1699873565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUhsJB6x+k9lCaNtAqyx0ZhAevgyts3pmpgaJy7Ei6A=;
        b=OC0Wx7eo3/J7KRVURLNk6ZUQc9b3evWrRuHSSpqwcqbAiT1N7nHcgVuaDKX1uWk++a
         pPp2LzzNWf0WxBQccov8S77V4fjow34b6D5eoz9OJ22Y7Jtqd1mj644x7aY00RHGBIr4
         I2vAW8wOQCNjwbws2iFUKx0WBRQcrI18Uz9ouiJXx8cHJnu/MwcwGxp/t/5aL5XWyy0I
         9IORggs3CzIUwjkcQfivXB0l9qC70hKTtRBjOsWgL4gTAsyYrXbEIoKgavr8UGzptuf7
         hxAUEIz9QIsNcjOpEEgj/jUuE+NrANQ81jSyA7UeQ1fYRY/2TpK5P1CWUknMnahu3W5n
         i0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268765; x=1699873565;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUhsJB6x+k9lCaNtAqyx0ZhAevgyts3pmpgaJy7Ei6A=;
        b=Hs8SknQEZEybgPGAG9unh0hit58YNj9ayjbt8yxkFWdEeMXUk6k4A9n5sQGzmtk/0X
         0S+RrtED6XpIIgwUfoqXeyqlFjOO6kwYYsxsy6ngGV0QjvbuD5GKfoBWHh1mkQrRSEf9
         e9KdvTpBLp5OSz7dUoxWNHd2BcaCf/sX7Gecfm79QhnfHJVMBBAJ0J/u6i2hhSUJRFOG
         ys0lMHqiyWDCi8iB+ibonsFjui0b7W806q0RNpprc8FJxRGMInz+FB2KRlbUwW/gDcYw
         mvgj0hi+v+6Joe8RnMV9ppjT9a+PAB+TDeSrLWrRfG7IFNtb9AeF2TVAihmlSByj1vB8
         SWXQ==
X-Gm-Message-State: AOJu0Yzn0XUKPT9Iv+nDKXCMOQ1rWK6kS00qOvzk5fC0yv7WxnfSbF5v
	k0xGfJi4du1xU87kd949b4m/Gtjp6Cs=
X-Google-Smtp-Source: AGHT+IGITz5+/37rk5JzPkx3cmtZjf3vkgFhHrhQoVnd5KHcg3P/9onQJo07xz7jJdPIeJ1cnVbbCg==
X-Received: by 2002:a2e:9b4c:0:b0:2c6:ece6:5b65 with SMTP id o12-20020a2e9b4c000000b002c6ece65b65mr10382533ljj.10.1699268764360;
        Mon, 06 Nov 2023 03:06:04 -0800 (PST)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c3b8500b004064e3b94afsm12051132wms.4.2023.11.06.03.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 03:06:04 -0800 (PST)
Message-ID: <8c2bb219-127c-4128-99ed-158bc64b1dab@gmail.com>
Date: Mon, 6 Nov 2023 11:06:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: support non-interactive autosquash
Reply-To: phillip.wood@dunelm.org.uk
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231104220330.14577-1-andy.koppe@gmail.com>
 <20231105000808.10171-1-andy.koppe@gmail.com>
Content-Language: en-US
In-Reply-To: <20231105000808.10171-1-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 05/11/2023 00:08, Andy Koppe wrote:
> So far, the rebase --autosquash option and rebase.autoSquash=true
> config setting are quietly ignored when used without --interactive,

Thanks for working on this, I agree that "--autosquash" being ignored 
without "--interactive" is something that we should address. I think 
there are several possible solutions

1 - make "--autosquash" imply "--interactive". This has the advantage
     that the user gets to check the commits are going to be reordered as
     they expect when they edit the todo list. It is hard to see how to
     accommodate the config setting though - I don't think we want
     "rebase.autosquash=true" to imply "--interactive".

2 - make "--autosquash" without "--interactive" an error. This would
     prevent the user being surprised that their commits are not squashed
     by a non-interactive rebase. Users who have set
     "rebase.autosquash=true" would have to pass "--no-autosquash" to
     perform any form of non-interactive rebase. This is similar to the
     current behavior where the user has to pass "--no-autosquash" if
     they want to use the apply backend with "rebase.autosquash=true".

3 - make "--autosquash" rearrange and squash commits without
     "--interactive". This is convenient but there is a risk in that the
     user does not get a chance to check the todo list before the commits
     are reordered and squashed. I think that risk is fairly small with
     an explicit "--autosquash" on the commandline. This is the approach
     taken by this patch. I do have some concerns about extending the
     config setting to non-interactive rebases though. If the user has
     commits that look like

	fixup! foo (HEAD)
	foo bar
	foo

     and runs "git -c rebase.autosquash=non-interactive rebase HEAD~2"
     then we'll silently squash the fixup into the wrong commit due to a
     prefix subject match.

> except that they prevent fast-forward and that they trigger conflicts
> with --apply and relatives, which is less than helpful particularly for
> the config setting.

The behavior to make the config setting incompatible with the apply 
backend was implemented to avoid users being surprised that their 
commits are not squashed by that backend even when they have set 
"rebase.autosquash=true"[1]. I think one could consider "--autosquash" 
being silently ignored without "--interactive" to be an oversight in 
796abac7e1 (rebase: add coverage of other incompatible options, 
2023-01-25) that introduced that change.

[1] 
https://lore.kernel.org/git/pull.1466.v5.git.1674619434.gitgitgadget@gmail.com/

> Since the "merge" backend used for interactive rebase also is the
> default for non-interactive rebase, there doesn't appear to be a
> reason not to do --autosquash without --interactive, so support that.

I think making "--autosquash" on the commandline work for 
non-interactive rebases is reasonable but I would be open to the 
argument that it would be better to make it an error and require 
"--interactive" to allow the user to check that the commits are going to 
be reordered as they expect.

> Turn rebase.autoSquash into a comma-separated list of flags, with
> "interactive" or "i" enabling auto-squashing with --interactive, and
> "no-interactive" or "no-i" enabling it without. Make boolean true mean
> "interactive" for backward compatibility.

Please, please, please don't introduce abbreviated config settings, it 
just makes the interface more complicated. The user only has to set this 
once so I think the short names just add confusion. I also think 
"non-interactive" would be a better name for the config setting 
corresponding to non-interactive rebases. Does this mean the user can 
request that commits are only rearranged when the do not pass 
"--interactive"?

As I said above I do have some concerns that the 
"rebase.autosquash=non-interactive" setting will catch people out. 
Having said that ignoring "rebase.autosquash=true" without 
"--interactive" as we do now is inconsistent with the behavior of 
"rebase.autosquash=true" with "--apply". One possibility would be to 
introduce "rebase.autosquash=interactive" which would not cause an error 
with "--apply" and always require an explicit "--autosquash" on the 
commandline to squash fixups without "--interactive"

> Don't prevent fast-forwards or report conflicts with --apply options
> when auto-squashing is not active.

I think this change deserves to be in a separate commit (which probably 
means separating out the config changes into that commit) as it is not 
directly related to fixing "--autosquash" without "--interactive" on the 
commandline. It would revert 796abac7e1 (rebase: add coverage of other 
incompatible options, 2023-01-25) and part of eddfcd8ece (rebase: 
provide better error message for apply options vs. merge config, 
2023-01-25) and so the commit message would need to explain why that is 
desirable (and why it is desirable to revert only the changes related to 
"rebase.autosquash" and not those related to "rebase.updateRefs")

> Change the git-rebase and config/rebase documentation accordingly, and
> extend t3415-rebase-autosquash.sh to test the new rebase.autosquash
> values and combinations with and without --interactive.

Thanks for adding tests for the new behavior.

In summary I like "--autosquash" working without "--interactive" but I'm 
unsure about the config changes.

Best Wishes

Phillip

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   Documentation/config/rebase.txt        | 11 +++-
>   Documentation/git-rebase.txt           |  2 +-
>   builtin/rebase.c                       | 66 +++++++++++++++-----
>   t/t3415-rebase-autosquash.sh           | 83 +++++++++++++++++++++-----
>   t/t3422-rebase-incompatible-options.sh |  2 +-
>   5 files changed, 132 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 9c248accec..68191e5673 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -9,7 +9,16 @@ rebase.stat::
>   	rebase. False by default.
>   
>   rebase.autoSquash::
> -	If set to true enable `--autosquash` option by default.
> +	A comma-separated list of flags for when to enable auto-squashing.
> +	Specifying `interactive` or `i` enables auto-squashing for rebasing with
> +	`--interactive`, whereas `no-interactive` or `no-i` enables it for
> +	rebasing without that option. For example, setting this to `i,no-i`
> +	enables auto-squashing for both types. Setting it to true is equivalent
> +	to setting it to `interactive`.
> +
> +	The `--autosquash` and `--no-autosquash` options of
> +	linkgit:git-rebase[1] override the setting here.
> +	Auto-squashing is disabled by default.
>   
>   rebase.autoStash::
>   	When set to true, automatically create a temporary stash entry
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..102ff91493 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
>   	When the commit log message begins with "squash! ..." or "fixup! ..."
>   	or "amend! ...", and there is already a commit in the todo list that
>   	matches the same `...`, automatically modify the todo list of
> -	`rebase -i`, so that the commit marked for squashing comes right after
> +	`rebase`, so that the commit marked for squashing comes right after
>   	the commit to be modified, and change the action of the moved commit
>   	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
>   	matches the `...` if the commit subject matches, or if the `...` refers
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 261a9a61fc..26c3e5dcb4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -131,7 +131,10 @@ struct rebase_options {
>   	int reapply_cherry_picks;
>   	int fork_point;
>   	int update_refs;
> -	int config_autosquash;
> +	enum {
> +		AUTOSQUASH_INTERACTIVE = 1 << 0,
> +		AUTOSQUASH_NO_INTERACTIVE = 1 << 1,
> +	} config_autosquash;
>   	int config_rebase_merges;
>   	int config_update_refs;
>   };
> @@ -149,7 +152,6 @@ struct rebase_options {
>   		.reapply_cherry_picks = -1,             \
>   		.allow_empty_message = 1,               \
>   		.autosquash = -1,                       \
> -		.config_autosquash = -1,                \
>   		.rebase_merges = -1,                    \
>   		.config_rebase_merges = -1,             \
>   		.update_refs = -1,                      \
> @@ -711,10 +713,8 @@ static int run_specific_rebase(struct rebase_options *opts)
>   	if (opts->type == REBASE_MERGE) {
>   		/* Run sequencer-based rebase */
>   		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
> -		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
> +		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
>   			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
> -			opts->autosquash = 0;
> -		}
>   		if (opts->gpg_sign_opt) {
>   			/* remove the leading "-S" */
>   			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
> @@ -748,6 +748,30 @@ static int run_specific_rebase(struct rebase_options *opts)
>   	return status ? -1 : 0;
>   }
>   
> +static void parse_rebase_autosquash_value(struct rebase_options *opts,
> +					  const char *var, const char *value)
> +{
> +	struct string_list tokens = STRING_LIST_INIT_NODUP;
> +	char *buf = xstrdup(value);
> +
> +	opts->config_autosquash = 0;
> +	string_list_split_in_place(&tokens, buf, ",", -1);
> +
> +	for (int i = 0; i < tokens.nr; i++) {
> +		const char *s = tokens.items[i].string;
> +
> +		if (!strcmp(s, "i") || !strcmp(s, "interactive"))
> +			opts->config_autosquash |= AUTOSQUASH_INTERACTIVE;
> +		else if (!strcmp(s, "no-i") || !strcmp(s, "no-interactive"))
> +			opts->config_autosquash |= AUTOSQUASH_NO_INTERACTIVE;
> +		else
> +			die(_("invalid value for '%s': '%s'"), var, s);
> +	}
> +
> +	string_list_clear(&tokens, 0);
> +	free(buf);
> +}
> +
>   static void parse_rebase_merges_value(struct rebase_options *options, const char *value)
>   {
>   	if (!strcmp("no-rebase-cousins", value))
> @@ -772,8 +796,14 @@ static int rebase_config(const char *var, const char *value,
>   	}
>   
>   	if (!strcmp(var, "rebase.autosquash")) {
> -		opts->config_autosquash = git_config_bool(var, value);
> -		return 0;
> +		int b = git_parse_maybe_bool(value);
> +
> +		if (b < 0)
> +			parse_rebase_autosquash_value(opts, var, value);
> +		else if (b)
> +			opts->config_autosquash = AUTOSQUASH_INTERACTIVE;
> +		else
> +			opts->config_autosquash = 0;
>   	}
>   
>   	if (!strcmp(var, "commit.gpgsign")) {
> @@ -1402,13 +1432,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		    state_dir_base, cmd_live_rebase, buf.buf);
>   	}
>   
> +	if (options.autosquash == 1) {
> +		imply_merge(&options, "--autosquash");
> +	} else if (options.autosquash == -1) {
> +		int conf = options.config_autosquash;
> +		options.autosquash =
> +			(options.flags & REBASE_INTERACTIVE_EXPLICIT)
> +			? !!(conf & AUTOSQUASH_INTERACTIVE)
> +			: !!(conf & AUTOSQUASH_NO_INTERACTIVE);
> +	}
> +
>   	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
>   	    (options.action != ACTION_NONE) ||
>   	    (options.exec.nr > 0) ||
> -	    (options.autosquash == -1 && options.config_autosquash == 1) ||
> -	    options.autosquash == 1) {
> +	    options.autosquash) {
>   		allow_preemptive_ff = 0;
>   	}
> +
>   	if (options.committer_date_is_author_date || options.ignore_date)
>   		options.flags |= REBASE_FORCE;
>   
> @@ -1508,7 +1548,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			if (is_merge(&options))
>   				die(_("apply options and merge options "
>   					  "cannot be used together"));
> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> +			else if (options.autosquash && options.config_autosquash)
>   				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
>   			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>   				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
> @@ -1529,11 +1569,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
>   				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
>   
> -	if (options.autosquash == 1)
> -		imply_merge(&options, "--autosquash");
> -	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
> -			     ((options.config_autosquash >= 0) ? options.config_autosquash : 0);
> -
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
>   			options.type = REBASE_MERGE;
> @@ -1858,3 +1893,4 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	free(keep_base_onto_name);
>   	return !!ret;
>   }
> +
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index a364530d76..1386eb6394 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -43,7 +43,7 @@ test_auto_fixup () {
>   
>   	git tag $1 &&
>   	test_tick &&
> -	git rebase $2 -i HEAD^^^ &&
> +	git rebase $2 HEAD^^^ &&
>   	git log --oneline >actual &&
>   	if test -n "$no_squash"
>   	then
> @@ -61,15 +61,43 @@ test_auto_fixup () {
>   }
>   
>   test_expect_success 'auto fixup (option)' '
> -	test_auto_fixup final-fixup-option --autosquash
> +	test_auto_fixup fixup-option --autosquash &&
> +	test_auto_fixup fixup-option-i "-i --autosquash"
>   '
>   
> -test_expect_success 'auto fixup (config)' '
> -	git config rebase.autosquash true &&
> -	test_auto_fixup final-fixup-config-true &&
> -	test_auto_fixup ! fixup-config-true-no --no-autosquash &&
> +test_expect_success 'auto fixup (config false)' '
>   	git config rebase.autosquash false &&
> -	test_auto_fixup ! final-fixup-config-false
> +	test_auto_fixup ! fixup-config-false &&
> +	test_auto_fixup ! fixup-config-false-i -i
> +'
> +
> +test_expect_success 'auto fixup (config true)' '
> +	git config rebase.autosquash true &&
> +	test_auto_fixup ! fixup-config-true &&
> +	test_auto_fixup fixup-config-true-i -i &&
> +	test_auto_fixup ! fixup-config-true-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto fixup (config interactive)' '
> +	git config rebase.autosquash interactive &&
> +	test_auto_fixup ! fixup-config-interactive &&
> +	test_auto_fixup fixup-config-interactive-i -i &&
> +	test_auto_fixup ! fixup-config-interactive-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto fixup (config no-interactive)' '
> +	git config rebase.autosquash no-interactive &&
> +	test_auto_fixup fixup-config-no-interactive &&
> +	test_auto_fixup ! fixup-config-no-interactive-i -i &&
> +	test_auto_fixup ! fixup-config-no-interactive-no "--no-autosquash"
> +'
> +
> +test_expect_success 'auto fixup (config always)' '
> +	git config rebase.autosquash i,no-i &&
> +	test_auto_fixup fixup-config-always &&
> +	test_auto_fixup fixup-config-always-i -i &&
> +	test_auto_fixup ! fixup-config-always-no --no-autosquash &&
> +	test_auto_fixup ! fixup-config-always-i-no "-i --no-autosquash"
>   '
>   
>   test_auto_squash () {
> @@ -87,7 +115,7 @@ test_auto_squash () {
>   	git commit -m "squash! first" -m "extra para for first" &&
>   	git tag $1 &&
>   	test_tick &&
> -	git rebase $2 -i HEAD^^^ &&
> +	git rebase $2 HEAD^^^ &&
>   	git log --oneline >actual &&
>   	if test -n "$no_squash"
>   	then
> @@ -105,15 +133,42 @@ test_auto_squash () {
>   }
>   
>   test_expect_success 'auto squash (option)' '
> -	test_auto_squash final-squash --autosquash
> +	test_auto_squash squash-option --autosquash &&
> +	test_auto_squash squash-option-i "-i --autosquash"
>   '
>   
> -test_expect_success 'auto squash (config)' '
> -	git config rebase.autosquash true &&
> -	test_auto_squash final-squash-config-true &&
> -	test_auto_squash ! squash-config-true-no --no-autosquash &&
> +test_expect_success 'auto squash (config false)' '
>   	git config rebase.autosquash false &&
> -	test_auto_squash ! final-squash-config-false
> +	test_auto_squash ! squash-config-false &&
> +	test_auto_squash ! squash-config-false-i -i
> +'
> +
> +test_expect_success 'auto squash (config true)' '
> +	git config rebase.autosquash true &&
> +	test_auto_squash ! squash-config-true &&
> +	test_auto_squash squash-config-true-i -i &&
> +	test_auto_squash ! squash-config-true-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto squash (config interactive)' '
> +	git config rebase.autosquash i &&
> +	test_auto_squash ! squash-config-interactive &&
> +	test_auto_squash squash-config-interactive-i -i &&
> +	test_auto_squash ! squash-config-interactive-i-no "-i --no-autosquash"
> +'
> +
> +test_expect_success 'auto squash (config no-interactive)' '
> +	git config rebase.autosquash no-i &&
> +	test_auto_squash squash-config-no-interactive &&
> +	test_auto_squash ! squash-config-no-interactive-i -i &&
> +	test_auto_squash ! squash-config-no-interactive-no "--no-autosquash"
> +'
> +test_expect_success 'auto squash (config always)' '
> +	git config rebase.autosquash interactive,no-interactive &&
> +	test_auto_squash squash-config-always &&
> +	test_auto_squash squash-config-always-i -i &&
> +	test_auto_squash ! squash-config-always-no --no-autosquash &&
> +	test_auto_squash ! squash-config-always-i-no "-i --no-autosquash"
>   '
>   
>   test_expect_success 'misspelled auto squash' '
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 2eba00bdf5..e5119e7371 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -102,7 +102,7 @@ test_rebase_am_only () {
>   
>   	test_expect_success "$opt incompatible with rebase.autosquash" "
>   		git checkout B^0 &&
> -		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
> +		test_must_fail git -c rebase.autosquash=no-i rebase $opt A 2>err &&
>   		grep -e --no-autosquash err
>   	"
>   
