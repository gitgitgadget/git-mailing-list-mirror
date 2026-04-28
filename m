Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E95391E7C
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368736; cv=none; b=jOO6pLtNG+2upLFxTvg5HrvYTp0P6yhoSqaCjpauvSLOqIkYgQ/H47+clJu+bUsXmOMiFeeXwbC6SdC+PkKn7FPxbseVmzrYGhv+bKc8IWSxteD0CA/0AdW+a0UqqYgDWEsjn7WdjpnSxIMzRQBqVgN8IJRV3Lgk1l40TFWzOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368736; c=relaxed/simple;
	bh=XHjNQQs6ncxk3FH9OeAc9BTy/9TSxOD7szA/iCiloqk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fixrHFTL73o/5pcJczGT8ZKDGokyV36ERE7suHdWHTUn8bDgAw0HDiYLBgUAc0SJsNQu0Q96FCn51p1Dh3MV+J/vqz8DI4Y7J9eQ3QRaPPOm4xnSYUlSb76VA90v6IbmdV23Vpc1AIJKiRiJzBKLVr8uLIBjojiAhc7JEkIlzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgwJW6bL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgwJW6bL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so56391365e9.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368733; x=1777973533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSW/X+ALJ2+0RRo926fITCXYF65qYEK+YPmHIpHzEBI=;
        b=KgwJW6bLhEOS0IzReDywmTq1yb9nb2duGUepzLGxJMmcZOgtYHWBPURiz6nzbMbC4T
         vJjo4aU1CvJyz9/t9yL27GJPjmTjbtMWL89NXE9t159365rOXC0piOlEGbhTUixFcb1Y
         eWQkfZANZKGiMLuwYS/nxM//v7fAUbgkBXIPBV7A25uLWBOHRNVd/pygYEOW/lVJSHYB
         8fBCEPuztQrHwmRRkBgL8N7vXQZQrsvwEKpz0LZQtXwy5rZ/OzRucJFL7fUj9shDXNje
         LXtX0UERaqy8oqQpH8qy+sF6VKD9ZjkELAKQrR+/+9iGyqKIFCSAycvAFVu6ftZji8k9
         BB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368733; x=1777973533;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSW/X+ALJ2+0RRo926fITCXYF65qYEK+YPmHIpHzEBI=;
        b=VueTAoqtJIgjrmqfhlLaZuIzAsV6xc/0jlNvMojtHkmFh7allhqi69ybwIrIx8JIox
         1mXaNOisvJlhhd2jhDapLpJ0+HZoe5eIX62a4TDgJ0SJwIv8KArlJXcuU7VEIOGKtlHq
         jDZcYCpkefueDF8lty7IcZDE1atLl4Qt7+jlE6iYldMzxI4Mm0+vEDiCuuTdWHwUs0ta
         l0Iv8JbZrnihY5kQySlsseDKGadRzRttKAhMKYoE6Z6sq8sPropls8Poo+yVj5ELA+9Q
         RHlRonhIeEbL9mm63PmmcC89GwN0u8bX6sUeWZJ84uOvCHUQsA4prp2RX+07RdKERE6C
         C8yA==
X-Forwarded-Encrypted: i=1; AFNElJ9gLmbTWE3HWFoYBGWFQj9tkqkXxseimId77L09bekqTLmbMGZ/VQqjcDDL9DUWix/BeCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/Dh9OkeKMKau3i5X7NUxOHxMCPDOBkzjwE41QGd64vnnr1HC
	LzNHl9UI8En3V+ZLTFrjFdxl8KnpnJIFP0m/sQROoMr2pJBgh17lMjL3
X-Gm-Gg: AeBDiesb4WjAfWJwMajdb2VIG8nS2BcZSnVxwbFf9695a5R814+FFE8e9105SSVAutu
	I5b4ySLKpIVygs5mKxKRgf1Y+/AdIJimvxtRxE5+SYFd0pnuvpGhMYauLskul2IrhMg2i5Z8Ko0
	rT4c48B+o/zDYKJO1JUXbaesRHzem+c6pifJZVTzD8YC5wXS1Lr1VLIWBE24xGpYB3Pw7F8LxyZ
	dbi/QP0LrNGj+YRenP1C4/vfaHTc+iMPk3Ykid7IMOcVgTdChtx5NIaI69WLTtFkY6EtUfH2pGt
	kBO2Fo7blP2bFAPkAincthR3V/VFByzE3ZKwM70ikubUv8QhWivcCOptj8AMWHn1jbJ1OHTWsaV
	xO/u9YJJrVkCfJ4Nbuo/T+ftGeOSXAwTJ/C4uLT+ecHMWxnjXV2WpnNO1MIS6VRt7UW6vSKwour
	TmefxvfGEsHDLiJdUqxwxqY5cke/yFOW/ojIg5aVkMX5tkvFY9XHk+Wpa3Kn8N1Z8cfPe5OGx+u
	4NIk4c2xv9/2A==
X-Received: by 2002:a05:600c:3ba6:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-48a78a43734mr27467635e9.11.1777368733168;
        Tue, 28 Apr 2026 02:32:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775e57d4sm22970135e9.9.2026.04.28.02.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:12 -0700 (PDT)
Message-ID: <6d60573f-a02d-4aea-b891-6dd52e2d7048@gmail.com>
Date: Tue, 28 Apr 2026 10:32:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 1/5] stash: add --label-ours, --label-theirs,
 --label-base for apply
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <aba8e6a9dc7e1620a46888685bb081f878cc6932.1777065012.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <aba8e6a9dc7e1620a46888685bb081f878cc6932.1777065012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Allow callers of "git stash apply" to pass custom labels for conflict
> markers instead of the default "Updated upstream" and "Stashed changes".
> Document the new options and add a test.

This all looks good, just one small comment below

> -	o.branch1 = "Updated upstream";
> -	o.branch2 = "Stashed changes";
> -	o.ancestor = "Stash base";
> +	o.branch1 = label_ours ? label_ours : "Updated upstream";
> +	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
> +	o.ancestor = label_base ? label_base : "Stash base";

This uses the existing label which is sensible, but I wonder if "Stash 
HEAD" would be a better choice as the merge base is always HEAD commit 
that the stash is based on.

We can always change that later

Thanks

Phillip

>   
>   	if (oideq(&info->b_tree, &c_tree))
>   		o.branch1 = "Version stash was based on";
> @@ -723,11 +725,18 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
>   	int ret = -1;
>   	int quiet = 0;
>   	int index = use_index;
> +	const char *label_ours = NULL, *label_theirs = NULL, *label_base = NULL;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct option options[] = {
>   		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>   		OPT_BOOL(0, "index", &index,
>   			 N_("attempt to recreate the index")),
> +		OPT_STRING(0, "label-ours", &label_ours, N_("label"),
> +			   N_("label for the upstream side in conflict markers")),
> +		OPT_STRING(0, "label-theirs", &label_theirs, N_("label"),
> +			   N_("label for the stashed side in conflict markers")),
> +		OPT_STRING(0, "label-base", &label_base, N_("label"),
> +			   N_("label for the base in diff3 conflict markers")),
>   		OPT_END()
>   	};
>   
> @@ -737,7 +746,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
>   	if (get_stash_info(&info, argc, argv))
>   		goto cleanup;
>   
> -	ret = do_apply_stash(prefix, &info, index, quiet);
> +	ret = do_apply_stash(prefix, &info, index, quiet,
> +			     label_ours, label_theirs, label_base);
>   cleanup:
>   	free_stash_info(&info);
>   	return ret;
> @@ -836,7 +846,8 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
>   	if (get_stash_info_assert(&info, argc, argv))
>   		goto cleanup;
>   
> -	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
> +	if ((ret = do_apply_stash(prefix, &info, index, quiet,
> +				  NULL, NULL, NULL)))
>   		printf_ln(_("The stash entry is kept in case "
>   			    "you need it again."));
>   	else
> @@ -877,7 +888,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix,
>   	strvec_push(&cp.args, oid_to_hex(&info.b_commit));
>   	ret = run_command(&cp);
>   	if (!ret)
> -		ret = do_apply_stash(prefix, &info, 1, 0);
> +		ret = do_apply_stash(prefix, &info, 1, 0,
> +				     NULL, NULL, NULL);
>   	if (!ret && info.is_stash_ref)
>   		ret = do_drop_stash(&info, 0);
>   
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..bdaad22e1f 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -56,6 +56,7 @@ setup_stash() {
>   	git add other-file &&
>   	test_tick &&
>   	git commit -m initial &&
> +	git tag initial &&
>   	echo 2 >file &&
>   	git add file &&
>   	echo 3 >file &&
> @@ -1790,4 +1791,27 @@ test_expect_success 'stash.index=false overridden by --index' '
>   	test_cmp expect file
>   '
>   
> +test_expect_success 'apply with custom conflict labels' '
> +	git reset --hard initial &&
> +	test_commit label-base conflict-file base-content &&
> +	echo stashed >conflict-file &&
> +	git stash push -m "stashed" &&
> +	test_commit label-upstream conflict-file upstream-content &&
> +	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
> +	test_grep "^<<<<<<< UP" conflict-file &&
> +	test_grep "^||||||| Stash base" conflict-file &&
> +	test_grep "^>>>>>>> STASH" conflict-file
> +'
> +
> +test_expect_success 'apply with empty conflict labels' '
> +	git reset --hard initial &&
> +	test_commit empty-label-base conflict-file base-content &&
> +	echo stashed >conflict-file &&
> +	git stash push -m "stashed" &&
> +	test_commit empty-label-upstream conflict-file upstream-content &&
> +	test_must_fail git stash apply --label-ours= --label-theirs= &&
> +	test_grep "^<<<<<<<$" conflict-file &&
> +	test_grep "^>>>>>>>$" conflict-file
> +'
> +
>   test_done
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 29dad98c49..659ad4ec97 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   			      int size, int i, int style,
>   			      xdmerge_t *m, char *dest, int marker_size)
>   {
> -	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> -	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
> -	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
> +	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
> +	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
> +	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
>   	int needs_cr = is_cr_needed(xe1, xe2, m);
>   
>   	if (marker_size <= 0)

