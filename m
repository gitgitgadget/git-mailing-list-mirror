Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674855C29
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731270658; cv=none; b=qGrILj1sZQK3K2d+0H0hmPVuEqnnoRxsN8+7t4+0yBCuVfYXnUqr5FqcFYMkgEcLRJ29QLQ2gquPYzzP3LWH4UJlOrpBu8ZqSR+7Wn628ltIZKawUdxhLdqX2Nycmhn50U+wBCXHnayg8gy0/hqh8VN7uKCXvO15nTC6vMlH5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731270658; c=relaxed/simple;
	bh=PPa7eZ27cSQunoGaN1PoKO+1ONynpnKTALV/6mnBFEY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZrCNgCmexuDNeVi2qpytAlJdlEGd7uN4bw73ERawboPt521QRgoOLHemiUgOgC4OLW6+oXAtwYAGl/E2Y1YVO9KWkG4pdrvRzhwaIqoO93+fqdx0NGKZ5Npx0YrcrwEt0gOwgMl4ciS1u71S4BtqmUzJxEQFH8VjudWJ9atGbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAP8KD+1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAP8KD+1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso29507176d6.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731270655; x=1731875455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZXFcJQt8wNFEiFoPuXORrK3X6LECXRX9wthSr5Oz9I=;
        b=NAP8KD+12JnGGXxQepEGrXnNInR9YkAaCJA1IDW9jmwWhJj1yyeejWfDkQq9c54BZt
         1ZNCmonLBtTaEsc4pIGEdBxPawi3BJ61kBlzTjIlGiaNNFvEHY01EBt8AsKgNU4OeWUI
         gCuYUFFEYS9zLsH/R6w17T5vRHKYgNpJFvnz5XtLQn0ieq2S5Iit/WtrsnlSu8h8EQVE
         1Fe2Xzu/zQM952DPKH2MBm8W6DD88C1IrRL+C6Ds8m8L+Nl45O06df08/zSUsXne0lQO
         BNvdV0c4v6etyLcATcDQgWlQjFYJY4843QeaoNwHheZVIldrap4gBkRPPjcZk3H0EtWm
         dJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731270655; x=1731875455;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZXFcJQt8wNFEiFoPuXORrK3X6LECXRX9wthSr5Oz9I=;
        b=DkgVWZekbiQGOcqA/bvWUWSpT3o0FqnPNTWwbU/ZwyuhP1wBNG23D1AzCkv1BdRHuu
         hJ72t7DuAeOSCnKAQCjo4lf7daxAhpk75W3Q8P5aDCdd8OTOjfV+JJsClgBkhsAeteHc
         zOVSmxzLg8V1EpEuloGHmxx7/Msk8Y8T+R8IHTPz6f/NhWBoBIUqoxY5Fog0y/UqmhR5
         2RmqR7H1QrbFr8CPBWfRDHNXdLSv/iJ4QBMVr7zeRFQsfPvVoN07OAAf6V6qaencqYmt
         wx4O60vOrXOXHH8eqUDjsP7EAjzcxgfSBONp58Wt0cU0ncZCVRRZUvBO+73+/hqwTBdG
         jOgA==
X-Forwarded-Encrypted: i=1; AJvYcCXJwBEZbaB9vXyZZYGOWdt/BxrvzaYb6ONpcEdEP7vMezftMPjVFU+89ZDy5qzBj7sIGE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9Rl4EnqrolO1+9BI1KJ6fIGgey6m+UILbRymhSdcuqME1URi
	JOnrqb6iRp4pHAPJuyy63ecgxkHhcb0nrouZhOi3+GSdqCvoU3RyH4z8GqWx
X-Google-Smtp-Source: AGHT+IG+UVkFuo9+SNoCYKaOZknXtihgqwz/EaMOt8EcL58VurXjRPg/o1s8tGVEbQtDWolNVdEEJw==
X-Received: by 2002:a05:6214:3217:b0:6d3:46a8:8f02 with SMTP id 6a1803df08f44-6d39e166cefmr150339686d6.5.1731270655345;
        Sun, 10 Nov 2024 12:30:55 -0800 (PST)
Received: from ?IPv6:2606:6d00:10:9ce1:245c:e0ef:8e1c:2879? ([2606:6d00:10:9ce1:245c:e0ef:8e1c:2879])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df907sm48303086d6.9.2024.11.10.12.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 12:30:54 -0800 (PST)
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Elijah Newren <newren@gmail.com>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
 <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <444e4a94-0005-bed6-1092-20770c226109@gmail.com>
Date: Sun, 10 Nov 2024 15:30:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Dscho,

Le 2024-11-08 à 08:43, Johannes Schindelin via GitGitGadget a écrit :
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `git log` command already offers support for including diffs for
> merges, via the `--diff-merges=<format>` option.
> 
> Let's add corresponding support for `git range-diff`, too. This makes it
> more convenient to spot differences between iterations of non-linear
> contributions, where so-called "evil merges" are sometimes necessary and
> need to be reviewed, too.

Maybe "between commit ranges that include merge commits" would be more
workflow-agnostic ? Just thinking out loud here, I think what you wrote 
is also OK.

> In my code reviews, I found the `--diff-merges=first-parent` option
> particularly useful.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Support diff merges option in range diff
>     
>     The git range-diff command does the same with merge commits as git
>     rebase: It ignores them.
>     
>     However, when comparing branch thickets it can be quite illuminating to
>     watch out for inadvertent changes in merge commits, in particular when
>     some "evil" merges have been replayed, i.e. merges that needed to
>     introduce changes outside of the merge conflicts (e.g. when one branch
>     changed a function's signature and another branch introduced a caller of
>     said function), in case the replayed merge is no longer "evil" and
>     therefore potentially incorrect.
>     
>     Let's introduce support for the --diff-merges option that is passed
>     through to those git log commands.
>     
>     I had a need for this earlier this year and got it working, leaving the
>     GitGitGadget PR in a draft mode. Phil Blain found it and kindly
>     nerd-sniped me into readying it for submitting, so say thanks to Phil!
>     
>     Changes since v1:
>     
>      * Changed the documentation to recommend first-parent mode instead of
>        vaguely talking about various modes' merits.
>      * Disallowed the no-arg --diff-merges option (because --diff-merges
>        requires an argument).
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1734%2Fdscho%2Fsupport-diff-merges-option-in-range-diff-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1734/dscho/support-diff-merges-option-in-range-diff-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1734
> 
> Range-diff vs v1:
> 
>  1:  11361e07af8 ! 1:  d01a395900b range-diff: optionally include merge commits' diffs in the analysis
>      @@ Documentation/git-range-diff.txt: to revert to color all lines according to the
>       +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
>       +	and include them in the comparison.
>       ++
>      -+Note: Some of the formats supported by linkgit:git-log[1] make less sense in
>      -+the context of the `range-diff` command than other formats, so choose wisely!
>      ++Note: In the common case, the `first-parent` mode will be the most natural one
>      ++to use, as it is consistent with the idea that a merge is kind of a "meta
>      ++patch", comprising all the merged commits' patches into a single one.
>       +
>        --[no-]notes[=<ref>]::
>        	This flag is passed to the `git log` program
>      @@ builtin/range-diff.c: int cmd_range_diff(int argc,
>        				  N_("notes"), N_("passed to 'git log'"),
>        				  PARSE_OPT_OPTARG),
>       +		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
>      -+				  N_("style"), N_("passed to 'git log'"),
>      -+				  PARSE_OPT_OPTARG),
>      ++				  N_("style"), N_("passed to 'git log'"), 0),
>        		OPT_BOOL(0, "left-only", &left_only,
>        			 N_("only emit output related to the first range")),
>        		OPT_BOOL(0, "right-only", &right_only,
> 
> 
>  Documentation/git-range-diff.txt | 11 ++++++++++-
>  builtin/range-diff.c             | 10 ++++++++++
>  range-diff.c                     | 15 +++++++++++----
>  range-diff.h                     |  1 +
>  t/t3206-range-diff.sh            | 16 ++++++++++++++++
>  5 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> index fbdbe0befeb..17a85957877 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
>  	[--no-dual-color] [--creation-factor=<factor>]
> -	[--left-only | --right-only]
> +	[--left-only | --right-only] [--diff-merges=<format>]
>  	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
>  	[[--] <path>...]
>  
> @@ -81,6 +81,15 @@ to revert to color all lines according to the outer diff markers
>  	Suppress commits that are missing from the second specified range
>  	(or the "right range" when using the `<rev1>...<rev2>` format).
>  
> +--diff-merges=<format>::
> +	Instead of ignoring merge commits, generate diffs for them using the
> +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
> +	and include them in the comparison.
> ++
> +Note: In the common case, the `first-parent` mode will be the most natural one
> +to use, as it is consistent with the idea that a merge is kind of a "meta
> +patch", comprising all the merged commits' patches into a single one.

I think I agree with Elijah that we probably should also highlight at least
'remerge'.

Also, is it worth making this a proper Asciidoc "[NOTE]" ? (I'm not sure, there are 
a lot of "Notes:" in our doc that are not Asciidoc "[NOTE]"s.

> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 1b33ab66a7b..901de5d133d 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c

The changes look good to me. Maybe it would be nice to add a corresponding
'range-diff.diffMerges' config option to allow users to configure the 
behaviour more permanently ?

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 86010931ab6..c18a3fdab83 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -909,4 +909,20 @@ test_expect_success 'submodule changes are shown irrespective of diff.submodule'
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--diff-merges' '
> +	renamed_oid=$(git rev-parse --short renamed-file) &&
> +	tree=$(git merge-tree unmodified renamed-file) &&
> +	clean=$(git commit-tree -m merge -p unmodified -p renamed-file $tree) &&
> +	clean_oid=$(git rev-parse --short $clean) &&
> +	conflict=$(git commit-tree -m merge -p unmodified -p renamed-file^ $tree) &&
> +	conflict_oid=$(git rev-parse --short $conflict) &&
> +
> +	git range-diff --diff-merges=1 $clean...$conflict >actual &&
> +	cat >expect <<-EOF &&
> +	1:  $renamed_oid < -:  ------- s/12/B/
> +	2:  $clean_oid = 1:  $conflict_oid merge
> +	EOF
> +	test_cmp expect actual
> +'

The test looks good. 

Thanks for submitting that patch!

Philippe.
