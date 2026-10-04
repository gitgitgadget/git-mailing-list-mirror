Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097F17BCA
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107711; cv=none; b=GyGsMFi8BkwDAQ0bmSuflC1kd9HNVsQ+gi9+n1QNzJEZBrdjTYdxpeBCujJR4dt5gL9aNxjzdD+Y3aA89TVkOv125AL1VpDnIsB9VqSsDQdVMExd8WrMqD4fjLzCBkpCY7R0KHfG3V9jfn6JkDaDplc+aVrjoOgGj8a3dWDOoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107711; c=relaxed/simple;
	bh=Vb11pnOLn04092JAn9XtE5ktb5JUSf8IWeSAjYvG0q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpcDYQgoniafwfAToxwTa2/GtzmFRtqCL5Jf0x3iWAnojLUziQocmXhy2qQAhSVB2pUA6PXJVUF4iGoQOObA08RIP5Z3KDqufryHSusFV7ezQq11CZ6QSm84meJWbCe4bFjssx1W6BWX1LyP0xwTYD6l0mpGWeUWuotaBCL65JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc0HN2or; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc0HN2or"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10345605e9.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791107708; x=1791712508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mSTkEycjBl/icK5vQHN8iedQNfGitU36GARf8M56qL0=;
        b=Hc0HN2ortuKDJJROEGmaxxgKkQI1DJRHB8VQjMZ0ey3e7+MB1rElqeqzbQd0r5Xmqr
         w0WgpadtrTf2EaUsuHGTWZVcwKpyxW2VlQMfTOSDOMacOd8xZBee0dB0xBddDknXvXrY
         Ov/1u1wstsI0ItQuQQ8dUyrFTeJxw4UxOBhBwRhI4WnFc36RebZ2u7fq3vqUO38mAnLw
         y+ay3pcMngeNMgI9EKa7NwhVVlScKTgrjj4diytZtfl586ROmXAIZ8ILS7MBiQzFtPF/
         UKqA5m9aYTPpgVI4obYdDmZf02+jz3tnP+Ss7qlhKppL1SWejg5cnhwtnw46JIp0lSnc
         7oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791107708; x=1791712508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mSTkEycjBl/icK5vQHN8iedQNfGitU36GARf8M56qL0=;
        b=dvOAcA6GZmTe75IKijUZH/GM2C79/MMOBWUxzQwCJD0m6Kn4z8nFU6SHcKQ4G7FhcY
         WZRwNchuAVnoIwp9E63Meh+81K3yxku40TQaVae8u7462Mu5i2ks9OthgXKEq3bVyGnh
         zly05QbdbpLeVobAaVv9gUyCP3MDJuzCiwUZ3tMezbmUy4qwlFeSfrbbJiW6D072ND0A
         fgalcRUNA9dcX32ezbIV85EG+QkozPmaFDIrBpHTc9Zr3AIOirxuHchnvv1eHqOQqUur
         zkHjK6Pv1RWr8i9r8HAXkuqDb1r93bY2LpBZjcvriN8c5c9g6OmD34LRAkUe3KGWRAqH
         2RcA==
X-Forwarded-Encrypted: i=1; AKwUvBxzv9POeQdPv0tnyb02ECJOaGjAtn7THK/WL2J2h9mpnt7CwDdV/yFNanO9SvMIgClJSU4=@vger.kernel.org
X-Gm-Message-State: AFuF++leejNfLu2xqCTMJhZzTR7vdtTB26J3SXWsE1e03r0DEHLvyQL7
	E66GWhLYt60GbskhmkNG6aLl+/hDeLlflzwiPu48yssKtnNQZDurRCM4
X-Gm-Gg: AYBFou0vy2Ela2huWBspLv2jcC5mc8/fVKAGHdcdBfUBRqIwXldMqKNYZ+X0nKzChYu
	p7YfQt3Um5bo3ivuPMUmK2FvcsigB6NJmUfVuNpy2krgNg7AtOmD4HT2ur3CzarHIecbJagS2pd
	JUgS02HRRSEPzT1TsuJVm1pT1yW0PtjdAyZOoyeEa2EPqgYbEfOhbMnQIYDxwmFGeM89dF39Nio
	zKNoPmoj0nHwz7Wmb2pg9IszsvcTn3QMbtjvVq38ZPtfXlIksk+RS8W3IJGckvFVWafGy87CP3Z
	XX+pd55At6FkbaJ2n2P4V3aGHSPRdVtIE0jQ+uGzISE62atzostAimo/OeQfGFJQIUVzNytoQ59
	6A834YJ2l4cEw/lm3hC7IlGPNbi2AXvnCQiTHgntkGRxzpmldVn5sf1EKoK+t0MDpTt2ksNAXBs
	4ucpctYChFWWvGia/ZA6SpiDWN6BuEym0wotL1Y0+EIgT2Plk3EFVceW/7Ukm/kJ8isMeyOmK1K
	2D9a4kUD5BRGKSk93Mcv+R9oV7NBY4nNUH2CzFrffPNAFn4IGtI5g==
X-Received: by 2002:a05:600c:8b10:b0:49c:edd8:ba35 with SMTP id 5b1f17b1804b1-4a1680e78b6mr66471965e9.6.1791107708069;
        Sun, 04 Oct 2026 02:55:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027f2a4c4sm255329505e9.2.2026.10.04.02.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 02:55:07 -0700 (PDT)
Message-ID: <ae47baff-daaa-4b78-97e9-94faebb8e694@gmail.com>
Date: Sun, 4 Oct 2026 10:55:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 02/10/2026 17:55, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Cleaning up every branch whose work has landed upstream required
> typing '*/*' as the pattern.
> 
> Let a bare "git branch --delete-merged" consider every upstream. As
> with "--merged" without a commit, this applies only when the option
> comes last, so "git branch --dry-run --delete-merged" previews the
> cleanup.

PARSE_OPT_LASTARG_DEFAULT is a usability footgun that I think it is best 
to avoid. If we ever wanted to add a new option that worked with 
"--delete-merged" (for example to control whether it looked for branches 
that had been squashed) then

	git branch --delete-merged --foo

would behave differently to

	git branch --foo --delete-merged

With hindsight maybe

	git branch --delete-merged [<upstream>...] -- [<branch>...]

and

	git branch --forked [<upstream>...] -- [<branch>...]

would have been a better design. That's the sort of design mistake that 
is much more likely to happen when a contributor sends an endless stream 
of patches because they're eager to get something merged, rather than 
engaging in a thoughtful discussion with the reviewer.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      branch: let --delete-merged default to every upstream
>      
>      A bare git branch --delete-merged now considers every upstream.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2428%2FHaraldNordgren%2Fbranch-delete-merged-default-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2428/HaraldNordgren/branch-delete-merged-default-v1
> Pull-Request: https://github.com/git/git/pull/2428
> 
>   Documentation/git-branch.adoc |  6 ++++--
>   builtin/branch.c              | 14 +++++++++++---
>   t/t3200-branch.sh             | 25 ++++++++++++++++++++++---
>   3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index bfdf459329..4a91ae6879 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
>   git branch (-c|-C) [<old-branch>] <new-branch>
>   git branch (-d|-D) [-r] <branch-name>...
>   git branch --edit-description [<branch-name>]
> +git branch [--dry-run] --delete-merged
>   git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
>   
>   DESCRIPTION
> @@ -202,14 +203,15 @@ This option is only applicable in non-verbose mode.
>   	Print the name of the current branch. In detached `HEAD` state,
>   	nothing is printed.
>   
> -`--delete-merged <pattern>`::
> +`--delete-merged [<pattern>]`::
>   	Delete local branches whose configured upstream matches
>   	_<pattern>_, but only when their tip is reachable from that
>   	upstream. In other words, the work on the branch has already
>   	landed on the upstream it tracks, so the local copy is no longer
>   	needed. _<pattern>_ may name a ref, a remote (using the branch its
>   	`HEAD` points at), or a shell-style glob. The option can be
> -	repeated to widen the upstream match.
> +	repeated to widen the upstream match. Without _<pattern>_, every
> +	upstream matches.
>   	Optional _<branch-pattern>_ arguments limit which local branches
>   	are considered, e.g. `git branch --delete-merged 'origin/*'
>   	'topic-*'`.
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a613148fc7..f2a4e117dc 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -39,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
>   	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>   	N_("git branch [<options>] [-r | -a] [--points-at]"),
>   	N_("git branch [<options>] [-r | -a] [--format]"),
> +	N_("git branch [<options>] --delete-merged"),
>   	N_("git branch [<options>] (--delete-merged <pattern>)... "
>   	   "[<branch-pattern>...]"),
>   	NULL
> @@ -1029,9 +1030,16 @@ int cmd_branch(int argc,
>   		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
>   		OPT_BOOL(0, "edit-description", &edit_description,
>   			 N_("edit the description for the branch")),
> -		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
> -			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
> -			PARSE_OPT_NONEG, parse_opt_strvec),
> +		{
> +			.type = OPTION_CALLBACK,
> +			.long_name = "delete-merged",
> +			.value = &delete_merged,
> +			.argh = N_("pattern"),
> +			.help = N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
> +			.flags = PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
> +			.callback = parse_opt_strvec,
> +			.defval = (intptr_t) "**",
> +		},
>   		OPT_BOOL(0, "dry-run", &dry_run,
>   			N_("with --delete-merged, only print which branches would be deleted")),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cdb6c6a634..e60f4794c8 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -2133,9 +2133,28 @@ test_expect_success '--delete-merged result is independent of stacked branch nam
>   	)
>   '
>   
> -test_expect_success '--delete-merged requires a value' '
> -	test_must_fail git -C forked branch --delete-merged 2>err &&
> -	test_grep "requires a value" err
> +test_expect_success '--delete-merged without a pattern matches every upstream' '
> +	setup_repo_for_delete_merged &&
> +	create_merged_branch merged &&
> +	(
> +		cd repo &&
> +		git branch --track local-topic main &&
> +		git checkout --detach &&
> +
> +		git branch --dry-run --delete-merged &&
> +
> +		check_branches <<-\EOF &&
> +		local-topic
> +		main
> +		merged
> +		EOF
> +
> +		git branch --delete-merged &&
> +
> +		check_branches <<-\EOF
> +		main
> +		EOF
> +	)
>   '
>   
>   test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
> 
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4

