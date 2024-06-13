Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935C137923
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319547; cv=none; b=m1hVdtfQWnAN3H9Fx1zcyWCfpMQyfw/lVUuwxb0KNQOZaXS0dtn9e2WglGV41RyhprwJ36wstYVrH++t0w+NeYm7WZmivgS+7SYrVVBTPcLLlSxMNv8INCGUcXrO1+u6JF6hRsYjpf6exYB+9PoFcgqmMXkN/dfGLNphudgWfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319547; c=relaxed/simple;
	bh=GFfu73oQH2UclYJ9OGnDM5CvYhlAuEQSCrYRTIUk/58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCsAgPD5aH2w0XeyF1lqo1eWQDF2oy3/Jy7XdKJiOZm3lY0AiNo+wM/GqKnbOEePdaRPDn2mykHk41j9X1Nk/gCuZ4ohddsaaBBVMXsQ75210FqxgJrnvF3ZViGrh5YPnvxLd5ZqC8bjvNOfMO9cAtmHkgplCR4Jlnb0Pfow18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rEETr+5z; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rEETr+5z"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7955af79812so92792285a.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718319544; x=1718924344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDI4PAG5Y8u0Z14Zh93Vfucct3SKG8xTMUgMQ2ajV5Y=;
        b=rEETr+5z/tNooV7UMNSU+zUS0YqSybFWuGIWaPjH6kLczaBDm/Fsb8Z805Hds8PMqb
         vYTCZyS2LyXWR434VYRsG/w4kofVXUSRbVhWLIMaLohsrwbFq1CuJV5ryFHBlu65DXbn
         3k9Bym0dgDMOXQkelSnkJU0XmNf6dwFYP5b9ZKBpxBrF9e4iw8Q4FbQ6xdeBVY/LTBBD
         Iu+ouAGPEu9+uMq6bJe+/CqYoyl3BkcoCkE92GweYd5DQrcyLvjHKScehes4L2wIYONe
         mVLt/dYMKAkBoqiN1xxt6v7T1PxF4U7eCKS4AE95qhEasNWZZWvf/jG4MOb/Tr73dGYE
         GeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319544; x=1718924344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDI4PAG5Y8u0Z14Zh93Vfucct3SKG8xTMUgMQ2ajV5Y=;
        b=OOBKvDBT/8dPdW5c25k0rMRQd1q1Q0NNYjqxvM7/P/4Zih7VSdJ2EBiykVmBhsYkpP
         WZl7/q1/G0hO0yK0D0ujoWAhCaAmJCK9FgFPqNuYHT/RWAkzjp1eq2EOzsLjF2XzOmjw
         +nEmMrkrz6Tc8o8tQlqRrkWlppSumlI5KB3qm4s80PemyMkx4Jr0vxgRVjxyse7JGv+n
         MSmUS0xXJkBjzqItf/AlJaV55UZB3fHs7cGPPt/6f/9VFuCVJNDQFlYU0lZ3l1iumfuh
         ru3P7q9bWkhl6Hu1ix21//JSDVYvcxYNiswwxZPAscaJk1gJ2yJorpKAUrnDdX+Pk1Vw
         GmDg==
X-Gm-Message-State: AOJu0YyFpBgp3bTHaAxyDx/QiRe+7OxNbFu1vWN2mb89JE1z+KZxilkB
	nT/c7tb7vdffe35pJ3sQF99k/7chzgMhWUODvNDr+fDma7GKKnYpPk5swAmNsNs=
X-Google-Smtp-Source: AGHT+IEmYDpfldstRTvbwSPrpxkXb/qW2Eqbg6lDFcrTFcK8ZXNagTTpO/IeWqHdKiIFX8ZLvbCpBQ==
X-Received: by 2002:a05:620a:4694:b0:796:1807:c9c7 with SMTP id af79cd13be357-798d23f092amr124641285a.13.1718319544401;
        Thu, 13 Jun 2024 15:59:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0cfb9sm90823185a.92.2024.06.13.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:59:04 -0700 (PDT)
Date: Thu, 13 Jun 2024 18:59:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: maintain expected invariant for priv
 member
Message-ID: <Zmt5tiuGIpTHLHRC@nand.local>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <17c97301baa829a993cf8838deb9271add5bd1cd.1718310307.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17c97301baa829a993cf8838deb9271add5bd1cd.1718310307.git.gitgitgadget@gmail.com>

On Thu, Jun 13, 2024 at 08:25:02PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> The calling convention for the merge machinery is
>    One call to          init_merge_options()
>    One or more calls to merge_incore_[non]recursive()
>    One call to          merge_finalize()
>       (possibly indirectly via merge_switch_to_result())
> Both merge_switch_to_result() and merge_finalize() expect
>    opt->priv == NULL && result->priv != NULL
> which is supposed to be set up by our move_opt_priv_to_result_priv()
> function.  However, two codepath dealing with error cases did not

s/codepath/&s/ ?

> execute this necessary logic, which could result in assertion failures
> (or, if assertions were compiled out, could result in segfaults).  Fix
> the oversight and add a test that would have caught one of these
> problems.
>
> While at it, also tighten an existing test for a non-recursive merge
> to verify that it fails correctly, i.e. with the expected exit code
> rather than with an assertion failure.

I suspect that this test was flaky, too, since if the assertion errors
were compiled out and it died via a segfault, the test would have failed
outright as test_must_fail does not allow for segfaults typically.

So I'm glad to see us tightening up that area of the test suite.

> Reported-by: Matt Cree <matt.cree@gearset.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c           |  3 ++-
>  t/t6406-merge-attr.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 10f5a655f29..6ca7b0f9be4 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -5015,7 +5015,7 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
>  	 * to move it.
>  	 */
>  	assert(opt->priv && !result->priv);
> -	if (!opt->priv->call_depth) {
> +	if (!opt->priv->call_depth || result->clean < 0) {
>  		result->priv = opt->priv;
>  		result->_properly_initialized = RESULT_INITIALIZED;
>  		opt->priv = NULL;
> @@ -5052,6 +5052,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
>  		    oid_to_hex(&side1->object.oid),
>  		    oid_to_hex(&side2->object.oid));
>  		result->clean = -1;
> +		move_opt_priv_to_result_priv(opt, result);
>  		return;
>  	}
>  	trace2_region_leave("merge", "collect_merge_info", opt->repo);
> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index 156a1efacfe..b6db5c2cc36 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -185,7 +185,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
>
>  	>./please-abort &&
>  	echo "* merge=custom" >.gitattributes &&
> -	test_must_fail git merge main 2>err &&
> +	test_expect_code 2 git merge main 2>err &&
>  	grep "^error: failed to execute internal merge" err &&
>  	git ls-files -u >output &&
>  	git diff --name-only HEAD >>output &&
> @@ -261,4 +261,44 @@ test_expect_success 'binary files with union attribute' '
>  	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
>  '
>
> +test_expect_success !WINDOWS 'custom merge driver that is killed with a signal on recursive merge' '
> +	test_when_finished "rm -f output please-abort" &&
> +	test_when_finished "git checkout side" &&
> +
> +	git reset --hard anchor &&
> +
> +	git checkout -b base-a main^ &&
> +	echo base-a >text &&
> +	git commit -m base-a text &&
> +
> +	git checkout -b base-b main^ &&
> +	echo base-b >text &&
> +	git commit -m base-b text &&
> +
> +	git checkout -b recursive-a base-a &&
> +	test_must_fail git merge base-b &&

Here and below, do you care about the particular exit code of merging as
above? IOW, should these be `test_expect_code`'s as well?

Thanks,
Taylor
