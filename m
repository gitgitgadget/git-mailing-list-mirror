Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQonO4p4"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35C10C6
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 08:33:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so8164115e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700757193; x=1701361993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NssN0jun/3dv/M5cnBFShkhGOZow0M3j4yRgZLU/ToM=;
        b=fQonO4p4oQObbdvW/1Qy6SL17XzHDv85O1vi9qGlCjr9cG65vE/3shZU77wWenOlSO
         11CoBjp/NGGq52PripltTFpvNWnLm3xON+i1CvZv6d7ZFD6hTluQUSen8/6AOQXiBfMQ
         HmVPdFX+rqh7Gbk9yX/5xwUcLhm+blg7myyqxUeGB1vB0p3ZhkdRLYLXLsXuPtCNxOWQ
         JkzwdxIpuoRm3Nimt8YivQit+qO0O3qYzqLiGBFOWfsEgSuBCmbIPfcbXcySfu3SH21y
         8F23V8INFYr9sbG+6jO2yVf9D6royQy2YoeWyEL7TUnlxLR7PzBtHcvx7b6mgb7Fq73L
         R/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757193; x=1701361993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NssN0jun/3dv/M5cnBFShkhGOZow0M3j4yRgZLU/ToM=;
        b=aF9iBUEjEKF0HUo/zsu1IpDhVEzsOgZajJGkUYq7eOEUWRGvqIBcuSw+7kao20yIub
         lo+E4GqhvjJz2A8+ZkAQGdBPFJofMIF23sLvJW35IlaEQFJmG4bdR2a5h8JYTE7h/fq1
         dVaBx6x6HVvmkBMrd4hALa1Wp6rnmapIlhH00/o16saT11iTqtcHUnpf4bxcl3WNIfUT
         Bb4ss63nellmgrc3Z3uiMFhRSQZTHjCVodEZimnUpaS/gVCzmQ93bvcs4mpCHIrVnVeU
         rFSfhRA/8qPpeGxt8Zc61NEqgNveNfT8PTJf3DBDSJ+BuoAKN+JN0lX/wdS0Fo7u1wVd
         9wNw==
X-Gm-Message-State: AOJu0YxcSFhOEeip+9xU6M/OqR7O03+/NjjL6gvOIGhB7g9/yvH2q60J
	Thz8umh0E/f1gffkPQk92tE=
X-Google-Smtp-Source: AGHT+IEjfRCfBhqYCGJtcofRFAcylPBk8wGc4okTMJDoBBjClCUomvRowLQ8lnCLq/9CHJ5Tm9rAsQ==
X-Received: by 2002:a5d:64ea:0:b0:32d:9a8f:6245 with SMTP id g10-20020a5d64ea000000b0032d9a8f6245mr3144730wri.68.1700757192741;
        Thu, 23 Nov 2023 08:33:12 -0800 (PST)
Received: from [192.168.1.212] ([84.69.146.25])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d69d0000000b00332cddd7468sm2078464wrw.40.2023.11.23.08.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 08:33:12 -0800 (PST)
Message-ID: <bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
Date: Thu, 23 Nov 2023 16:33:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a branch
 used elsewhere
To: Junio C Hamano <gitster@pobox.com>,
 Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: git@vger.kernel.org
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
 <xmqqpm01au0w.fsf_-_@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpm01au0w.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/11/2023 06:00, Junio C Hamano wrote:
> "git checkout -B <branch> [<start-point>]", being a "forced" version
> of "-b", switches to the <branch>, after optionally resetting its
> tip to the <start-point>, even if the <branch> is in use in another
> worktree, which is somewhat unexpected.
> 
> Protect the <branch> using the same logic that forbids "git checkout
> <branch>" from touching a branch that is in use elsewhere.
> 
> This is a breaking change that may deserve backward compatibliity
> warning in the Release Notes.  The "--ignore-other-worktrees" option
> can be used as an escape hatch if the finger memory of existing
> users depend on the current behaviour of "-B".

I think this change makes sense and I found the implementation here much 
easier to understand than a previous attempt at 
https://lore.kernel.org/git/20230120113553.24655-1-carenas@gmail.com/

> Reported-by: Willem Verstraeten <willem.verstraeten@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   * The documentation might also need updates, but I didn't look at.

This option is documented as an atomic version of

	git branch -f <branch> [<start-point>]
	git checkout <branch>

However "git branch -f <branch>" will fail if the branch is checked out 
in the current worktree whereas "git checkout -B" succeeds. I think 
allowing the checkout in that case makes sense for "git checkout -B" but 
it does mean that description is not strictly accurate. I'm not sure it 
matters that much though.

The documentation for "switch -C" is a bit lacking compared to "checkout 
-B" but that is a separate problem.

> 
>   builtin/checkout.c      | 7 +++++++
>   t/t2060-switch.sh       | 2 ++
>   t/t2400-worktree-add.sh | 8 ++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b4ab972c5a..8a8ad23e98 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1600,6 +1600,13 @@ static int checkout_branch(struct checkout_opts *opts,
>   	if (new_branch_info->path && !opts->force_detach && !opts->new_branch)
>   		die_if_switching_to_a_branch_in_use(opts, new_branch_info->path);
>   
> +	/* "git checkout -B <branch>" */
> +	if (opts->new_branch_force) {
> +		char *full_ref = xstrfmt("refs/heads/%s", opts->new_branch);
> +		die_if_switching_to_a_branch_in_use(opts, full_ref);
> +		free(full_ref);

At the moment this is academic as neither of the test scripts changed by 
this patch are leak free and so I don't think we need to worry about it 
but it raises an interesting question about how we should handle memory 
leaks when dying. Leaving the leak when dying means that a test script 
that tests an expected failure will never be leak free but using 
UNLEAK() would mean we miss a leak being introduced in the successful 
case should the call to "free()" ever be removed. We could of course 
rename die_if_checked_out() to error_if_checked_out() and return an 
error instead of dying but that seems like a lot of churn just to keep 
the leak checker happy.

Best Wishes

Phillip

> +	}
> +
>   	if (!new_branch_info->commit && opts->new_branch) {
>   		struct object_id rev;
>   		int flag;
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> index e247a4735b..c91c4db936 100755
> --- a/t/t2060-switch.sh
> +++ b/t/t2060-switch.sh
> @@ -170,8 +170,10 @@ test_expect_success 'switch back when temporarily detached and checked out elsew
>   	# we test in both worktrees to ensure that works
>   	# as expected with "first" and "next" worktrees
>   	test_must_fail git -C wt1 switch shared &&
> +	test_must_fail git -C wt1 switch -C shared &&
>   	git -C wt1 switch --ignore-other-worktrees shared &&
>   	test_must_fail git -C wt2 switch shared &&
> +	test_must_fail git -C wt2 switch -C shared &&
>   	git -C wt2 switch --ignore-other-worktrees shared
>   '
>   
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index df4aff7825..bbcb2d3419 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -126,6 +126,14 @@ test_expect_success 'die the same branch is already checked out' '
>   	)
>   '
>   
> +test_expect_success 'refuse to reset a branch in use elsewhere' '
> +	(
> +		cd here &&
> +		test_must_fail git checkout -B newmain 2>actual &&
> +		grep "already used by worktree at" actual
> +	)
> +'
> +
>   test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
>   	head=$(git -C there rev-parse --git-path HEAD) &&
>   	ref=$(git -C there symbolic-ref HEAD) &&
