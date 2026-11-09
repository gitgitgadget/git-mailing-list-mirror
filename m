Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219475;
	b=4sRCGHd5lM86mvlyKN491GjptC+AklaufUtSy3/jUtVO8gWg2qyqySJ1ZGn6GtcZ8QYX
	 NldHzg9ylLoO2ef+90+vdM8/4mU2VcR4oT3kBBm7wdDcqWuKs5ZHg6hMWy4s870lnA0BQ
	 Ek6/C8uVgkGllshg/K1594tviWV0Z0GVcVVRpTPVtOPzdAhnA0yOJDv8EywV5jyKFcQuU
	 +e70cNvHwcT6WUmCYv8Uok76PBBlU3vpWY/0UrMs/LmCTax5Jam7wjFbfuro6MLl5FITQ
	 ZHa/r3TzgFYxjmQeM2luJJLhKgwB35MI9+hA3JZJrp4lAPsiVDaYYYMeDTDn05Z9exA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R05KzK/dIyZgyVl5mpvxu0hwdZoDNs1IEdh5gDAFuGc=;
	b=nTTE4gC0OnvnerAc+lEnxUNNjCYw0o469FEOvfNXsg2UaaxV10TkDT9QppyHSH7wFAxd
	 HLZLAAt6I4D5SFaTk7ERDoOMGkDNjivkeR4Qx5qQaw06RlqTvGcSP6BoWFaS8aYZDGo2V
	 TJpzoEB4HxHFWOgsO/ADo0UpfBvRZyv7CB0K+EgtxM5zEEwhFh9NpFaXW3LlZ5pFIj8AQ
	 GIsDKKcP9CqJ1gq+TetDmXqFiDKIcvIhC3Ezm7xx/SMw7TeSng9Fa764wSLfkFICcNb52
	 VjnwWN16vyf1aKbPfG5j86rIQD6pFTpI1ZYdU5i38m/VbCVnIuxwNVt683E32PLhPAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EgET9gQr;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9E606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE9E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EgET9gQr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so10227105e9.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219473; x=1794824273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R05KzK/dIyZgyVl5mpvxu0hwdZoDNs1IEdh5gDAFuGc=;
        b=EgET9gQravjhkWeScAQ9s2XjyZypHVpzTWpsxC+mQxPUa3/8myQVegb7L8opVKKhGo
         a6B6+Vx52cm4x3FzUnmg85RHiwIq9egpme0UHV9UwYBUfly3qECpmB+LhhEngsfhzU+2
         mu76CXJQF0887TcYzB/RUbQCO7mqwv9uDeT0g3tqnDS76eMBLepo2aFERp9DRFhNhQQG
         TocjDzpTQL4iJSvX3gfLWq6y5CfQXtZhw1mZmi+rN9v7Nf/XQG3ar4G7fGXh+4AVbx/d
         t+Wo0f1mSmx6aCqsTJvG7pMHAxQPwjUbi64nu7QzPiuzg+hzpRufR9oAnHGEiUQuVyXB
         o9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219473; x=1794824273;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R05KzK/dIyZgyVl5mpvxu0hwdZoDNs1IEdh5gDAFuGc=;
        b=NLMcD/54LkHdX8Wwa5vJIYC7xp04ZMWccXlL3uBGIh9ftP44qegJ+QugykoDGoyOfd
         pBAGa4g0uR61w0P4b+ZBlroMQ96PhaI0GG1KAeNCMk9tjX7vy7k9FKY3rmWtSe5HeUNw
         NRUB7TCBzJ1x9F4G90qU62DnhbNx9l/wUvZ7oY8zQdp4oM8zMcmPFepNHddQ1hHR9dlf
         vdb1+AvS+HOrCW2cDJBUS9Im/E+3wfxHUe6ay7ofj02+v2g0NxAyLyRIe1Ml/eQQ9WBc
         qBSrolYhrP29MbEn09U8Wen2zzbdG3QJbP5Q+6mgKCZRmPoewpOnKPpdFIyWr8Sd/5Og
         2cEA==
X-Forwarded-Encrypted: i=1; AL+hErHTZdZvJ6MXUTZ1FJ6SBCjYzoJzet5ZpGlM4VEr55OxHgEQR3Zrv1nm72MT0uzHEBC9pzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MY2RoLyAousBcEkRfMb1erAal1iSFen0kLPy1za91Lj4tMIrw
	NtL2hRMW0xjKvRY3HV02NmLPRdYztx5zlRtse8KKUdUV69qKRoHM0gVV
X-Gm-Gg: AYBFou3TMsGDVI8Decvm6FqqVvabzZLdy6vuO+/h0oBURGCdSfZpgjqkChZoMRQ/eTC
	WZGTId03gS/V2DWbMu6U2r1DH7aILlbf+IQ+byj1jRHXNthmMDfnZU0jwjKtF2zBugRPLA8wgsA
	e2AfWIUiksEal8+FUEMZgDhWksSUHxBjR+U3IT1jYeO11eHGM6gXEaIDoNtSxE482Ud5fnQN0LC
	v66em5hQFho6eFdqFf6pU7OJd0Z4NxI8c1WhVPZFo/YJ7Mjv1Ekk99OisTVMwE8RtFUKf77sYfN
	dg+lcoGvR+tq5JvV4PeasDhEEiz/r9t4DkAGb3gYU+yh6Dz+2JEVfEjQVxIJwPDEm+9RpSXl3Is
	+ipBNVBFFkHGe2BenOc00YShuSnKAVTq5ZdHwDirKvIVwMJ0m2tDEWj6x68I+UkzaWqbKmLFZk5
	35D4+h25QEZs7rGs4NrbPWrkf7AcJmWia6Kp4sPzJbLkOPu/EqF+NvUf2xnCz/IPU+NJ1iwFDU9
	zXG5DSVPDWsVO1+2X3+7vX0ZnSxrYU1ln/j55TXL4/lwc+gACQUsxvgpmON7WTHaZ6tIWxUoSuz
	VCu0cr6GrAhABbyQakk3yb+z6zLCrUou3PvS7nl4nJT1+nI1LJIouL73rk/rO3Z/jUGH6AaLps5
	C0tZkNw==
X-Received: by 2002:a05:600c:6095:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4b960da5640mr65890135e9.12.1794219472603;
        Mon, 09 Nov 2026 02:17:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm268014325e9.1.2026.11.09.02.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <cd14971b-e99d-47aa-8e22-fff8558b28d0@gmail.com>
Date: Mon, 9 Nov 2026 10:17:47 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] history: add --verbose option for reword
To: Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Patrick Steinhardt <ps@pks.im>
References: <20261107193020.583215-1-jelle@vdwaa.nl>
 <20261107193020.583215-3-jelle@vdwaa.nl>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261107193020.583215-3-jelle@vdwaa.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jelle

On 07/11/2026 19:30, Jelle van der Waa wrote:
> When rewording a commit message it is often useful to have context of
> the changes. 

Indeed - I'm still using a wrapper around "git rebase -i" to reword 
commits because "git history reword" does not show the diff. Thanks for 
working on this.

> This commit implements the --verbose option of git commit
> in git history reword with the only difference in that it does not
> folllow the commit.verbose configuration setting.

As it is easy to support commit.verbose, I think we should. In my ideal 
world we'd default to showing the diff when rewording but that's not 
really compatible with the way "commit.verbose" works.

> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 1fcc30150a..a476780623 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -10,7 +10,7 @@ SYNOPSIS
>   [synopsis]
>   git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
>   git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
> -git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
> +git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [-v | --verbose] [--[no-]gpg-sign[=<key-id>]]

It is not a new problem, but these lines are getting very long.
> diff --git a/builtin/history.c b/builtin/history.c
> index cdb0d30784..e2e0aba4a9 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -34,7 +36,7 @@
>   #define GIT_HISTORY_FIXUP_USAGE \
>   	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
>   #define GIT_HISTORY_REWORD_USAGE \
> -	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
> +	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [-v | --verbose] [--[no-]gpg-sign[=<key-id>]]")

As above, it is not a new problem, but these lines are very long.

>   #define GIT_HISTORY_SPLIT_USAGE \
>   	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
>   #define GIT_HISTORY_SQUASH_USAGE \

>   static int fill_commit_message(struct repository *repo,
>   			       const struct object_id *old_tree,
>   			       const struct object_id *new_tree,
>   			       const char *default_message,
>   			       const char *action,
> +			       int verbose,

If this was a bool, we could get rid of the "!!()" in the caller.

>   			       struct strbuf *out)
>   {
>   	const char *path = git_path_commit_editmsg();
> @@ -84,6 +107,10 @@ static int fill_commit_message(struct repository *repo,
>   
>   	wt_status_collect_changes_trees(&s, old_tree, new_tree);
>   	wt_status_print(&s);
> +	if (verbose) {
> +		wt_status_add_cut_line(&s);
> +		print_verbose_diff(repo, old_tree, new_tree, s.fp);

We already reuse some of the code in wt-status.c that "git commit" uses 
to generate the template message, how hard would it be to teach the 
status code to generate the diff for us as it does for "git commit"? 
"git commit" also respects status.relativePaths, status.renames and 
status.renameLimit in addition to the equivalent diff settings - should 
we be doing the same here?

> +static int reword_config(const char *var, const char *value,
> +			 const struct config_context *ctx, void *data)
> +{
> +	const char **sign_commit = data;
> +
> +	if (!strcmp(var, "commit.gpgsign")) {
> +		*sign_commit = git_config_bool(var, value) ? "" : NULL;
> +		return 0;
> +	}
> +
> +	return git_diff_ui_config(var, value, ctx, NULL);
> +}

I'm in two minds about this - it would be simpler to share the same 
config callback between all subcommands, even if it means we read a bit 
more config that we really need to for some commands.

> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 6dbe2143d3..4ec07fb493 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -16,6 +16,19 @@ reword_with_message () {
>   	rm fake-editor.sh message
>   }
>   
> +reword_and_capture () {
> +	write_script fake-editor.sh <<-\EOF &&
> +	cp "$1" captured &&
> +	{
> +		echo reworded &&
> +		sed -n "/^# -* >8 -*$/,\$p" "$1"

We preserve the scissors line and the diff to check the message is 
cleaned up as we expect - good.

> +test_expect_success '--verbose shows the diff of the reworded commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		echo unstaged >first.t &&
> +		echo staged >third.t &&
> +		git add third.t &&
> +		git show --format= HEAD~ >expect &&

This looks a bit strange - if we just want a diff why don't we create it 
by running "git diff"?

	git diff HEAD~^- >expect

> +
> +		reword_and_capture --verbose HEAD~ &&
> +
> +		test_grep "^# -* >8 -*\$" captured &&

If this line is not in the output then the sed command in the fake 
editor wont have printed the diff so I'm not sure this actually adds 
anything.

> +		sed -n "/^diff --git/,\$p" captured >actual &&
> +		test_cmp expect actual &&
> +
> +		test_commit_message HEAD~ <<-\EOF
> +		reworded
> +		EOF

We check the diff and the reworded message - good. We do not check that 
the user sees the original message though - perhaps we'd be better to 
just compare captured against what we expect the user to see.

> +test_expect_success 'no diff is shown without --verbose' '

Why do we need a separate test to do this, rather than just checking 
there is no diff in one of the existing tests?

> +test_expect_success '--verbose works in a bare repository' '

I'm not sure this adds much value - we already have a test to check 
reword works in a bare repository and there is nothing in the 
implementation of verbose that is conditional on the whether the 
repository is bare or not. What failure mode do we expect this test to 
detect that the existing test wont?

> +test_expect_success '--verbose on a merge diffs against the first parent' '

Can we extend the existing test for rewording a merge commit instead of 
adding a new one? Our test suite is slow and the way the history tests 
are written makes it even slower because they initialize a new 
repository and create a bunch of new commits for every single test.

Thanks for working on this - it is a really useful improvement

Phillip

>   test_expect_success 'retains changes in the worktree and index' '
>   	test_when_finished "rm -rf repo" &&
>   	git init repo &&

