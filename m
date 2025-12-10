Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BD4C97
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395115; cv=none; b=ZA9yn3EA2Dw5CK1glW1kj2D02KNZXpeiZvMfFL1+gpsHMEOUO8WslzaVl8ftZwkStJyDR3x4N7fPIos+LhqswjC0zX7sEZkmG/wmszq6cRCrPqk2ijncb0Fq7ykqX91b5lswGpuDoyVFdjPS1ggA/4LR/Qg7n50VwcfLz/LIGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395115; c=relaxed/simple;
	bh=5+15Wnz4R0LvZdjD4eSYpvKINnss6VRuQ6AW5Xe+jzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9LRh8kyoqX4OJDQaSulWj7so3FUv9LTbM0isy0ZI+6ibFl9NXg93cKXfB8fkaClBWWjr5w/ZWhEuSCDRZJjWb8cigNOH6UYj/3R00LVMXFj0yYU2ZSYg7mnY2hAzm0Ibd1FjyqOGdn3HYRFVYATPpJqS8D2Ajo2j3CvCh0/xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9aFilmN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9aFilmN"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c7660192b0so178362a34.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395113; x=1765999913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tfg7CPa1ZjU72C+FlIE36H89QpQtNI45uhv+M+D0ejA=;
        b=D9aFilmN72pgccWgXx9qEPKYTmJFy9s7SsNsnBaAS8JO6PlohmGpvlOWtnaCjwGKW4
         O5R0LoBEBcTZvycRRWWgF2aU0r6Tj7URtJC7FtjGMYe0+QsnprRoa9hcsnGlEd2bJ432
         iedmKaqwKs3VbXY8G0HxZcKIXZPZ+fs0ss/gEHCAh6lPvtfGOKZao4g5SabGZTprlNwz
         283j5odEPwDcm9iKAIyLTia3ljyoG5Rg7zE84G+JNoSFPIiyfAm0gPTJM2OtYDjpwai0
         m0rtFXwAArY8FTcr+uwq4w+YuaTQivZSCscqZZzrpNY5zDPhS4s3m3q1IIfBUJOnIix3
         6Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395113; x=1765999913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfg7CPa1ZjU72C+FlIE36H89QpQtNI45uhv+M+D0ejA=;
        b=RJEKD6fYL+5J2ZVPkkLUFPKBqcEsDpRPuzoiBKvLHSvs15bLZfgBo2VHWYypoK3f2E
         80uHeMcZ6CozlKlLAXSkXcJcoSA/6FY7gJmO6DaO4cbrIyiBTrACIaCV5BSMGj/0dEcA
         zcFqLbCW2MnSquHofRpJhp9MtHZewrbhQ4o/poLI6mAYyEK8ow+/B45aVH0JAk4f4Evv
         MpYjJn/6PBEDvldcDozCIZW8zyCeCgBdvpzbSesx42MlgbhseTkn2Fqyihy1PzH7AMSi
         WCi12/MwKL4k9sqOSPj/89WEZmTbb9PoTcWfIZuSt6PY2G+4KoROi7MaXjYB2ZbYSJvx
         9Qdg==
X-Gm-Message-State: AOJu0Yye7I1cZcoxoZ1oU7zTUVdwjq+yE6cOv8I5eRxGlcibW4GfcfTX
	5T4XbaxqTNjAwtNINK/6JctUcCezV4czjWbyfXKjcR+GC/anbcp0IrHk
X-Gm-Gg: ASbGncv4YPh4Cd3mM/lLJm01uVP38kf3uyYUZtvMSMExkmBAwMJW6mJ2Ll0nziQWIZC
	aUq3wIc25RAJUltSfvm7u2jLhNQmvkzt7JdVIRa2hDlCBV4h4XnYCxCIpGcI3qzk+LWfheF8/iq
	1jo5vCvYit5bx5zXxC4sysRAFIZULn9S7RNcH7tjeYywwPM0f3hLrDMmAQtfbnctSFX/9UUrWWm
	Rh5tgJ61JPXJmKYYSv4avNNfqcz80aucweJalqR7/zwnn1nHu18npPQBj8CfaArhpDKgy8t+jtr
	ijIFnf3WBJBPCrzoNAl3dWLs/0kJ2I1S4NBLEVjLDafDsMdGlKAvW+jSbXaxN84bSlinRjkralp
	gboJukGazH1A1pHOcxkvNtKBlz7nZ6F9XwJlizbMB8cv0CDVgUHOII8vilveahv7mkJQTWpQSd2
	2AxwKZ
X-Google-Smtp-Source: AGHT+IF9ezUdbX1qqmNdwrxIscuq9pYai1WTnMQyXWL1FY8+DkyQlumsrLZkmU3keNGEeV4guILMzQ==
X-Received: by 2002:a05:6830:6e5e:b0:7c7:5e52:456b with SMTP id 46e09a7af769-7cacebce451mr2379469a34.16.1765395113319;
        Wed, 10 Dec 2025 11:31:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cad9120b6bsm313055a34.3.2025.12.10.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:31:52 -0800 (PST)
Date: Wed, 10 Dec 2025 13:31:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] builtin/repack: fix geometric repacks with promisor
 remotes
Message-ID: <pva24p5jl2wjnwtdysmiqy4ljcfxtarss2cudqf5k7so36c5b3@6xkb6o2tgx5j>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-1-ef4250abb584@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-odb-related-fixes-v1-1-ef4250abb584@pks.im>

On 25/12/05 09:19AM, Patrick Steinhardt wrote:
> When repacking a repository with promisor remotes git-repack(1) knows to
> pass "--exclude-promisor-objects" to git-pack-objects(1). This option
> ensures that the new pack will not contain any promised object that do
> not yet exist locally.
> 
> This command line option is incompatible with "--stdin-packs": the
> latter option enables the rev-walk-based machinery to figure out which
> objects to add to the pack, whereas the former tells git-pack-objects(1)
> to merge all packs passed via stdin into one large pack. As we do not
> know to filter those packs via the passed-in revisions it is clear that
> at the current point in time nothing sensible comes out of combining
> these two options.

Is the latter/former part here backwards? I find it a bit confusing to
read. As I understand it, --stdin-packs expects the packfiles provided
as input to dictate the source of objects when repacking. With
--exclude-promisor-objects, we walk the object graph normally, but
exclude promisor objects. Thus combining these two options would create
a conflict regarding which objects are included.

> But there is one case where git-repack(1) decides to pass both options:
> when performing a geometric repack we always pass "--stdin-packs" to
> identify the packs that should be merged. So if one performs a geometric
> repack in a partial clone we'll end up with both options, and that
> causes the repack to fail.
> 
> Fix this issue by never passing "--exclude-promisor-objects" when we
> have a geometric split factor. We don't need the option anyway when
> doing a geometric repack as we will only ever pack loose objects or
> merge multiple packs. And neither of those cases can yield a promisor
> object.

I'm not sure I fully understand why --exclude-promisor-objects would not
be needed for geometric repacks. To clarify, do geometric repacks
already exclude promisor packfiles when merging? If so, then this change
makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c            |  5 +++--
>  t/t7703-repack-geometric.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d9012141f6..4621eed3e6 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -294,9 +294,10 @@ int cmd_repack(int argc,
>  		strvec_push(&cmd.args, "--all");
>  		strvec_push(&cmd.args, "--reflog");
>  		strvec_push(&cmd.args, "--indexed-objects");
> +
> +		if (repo_has_promisor_remote(repo))
> +			strvec_push(&cmd.args, "--exclude-promisor-objects");
>  	}
> -	if (repo_has_promisor_remote(repo))
> -		strvec_push(&cmd.args, "--exclude-promisor-objects");

Ok, now the --exclude-promisor-objects flag is only added when there is
a promisor remote and geometric repacking is not used.

>  	if (!write_midx) {
>  		if (write_bitmaps > 0)
>  			strvec_push(&cmd.args, "--write-bitmap-index");
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 9fc1626fbf..6d2c712bff 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -445,4 +445,30 @@ test_expect_success '--geometric -l disables writing bitmaps with non-local pack
>  	test_path_is_file member/.git/objects/pack/multi-pack-index-*.bitmap
>  '
>  
> +test_expect_success '--geometric works with promisor packs' '
> +	test_when_finished "rm -fr remote local" &&
> +
> +	git init remote &&
> +	test_commit -C remote first file first &&
> +	test_commit -C remote second file second &&
> +	git -C remote config set uploadpack.allowfilter 1 &&
> +	git -C remote config set uploadpack.allowanysha1inwant 1 &&
> +	git -C remote repack -Ad &&
> +
> +	git clone --filter=blob:none file://"$(pwd)"/remote local &&
> +	git -C local rev-list --objects --missing=print HEAD >missing-objects &&
> +	test_grep "^?" missing-objects &&
> +
> +	# Assert that promisor packs are left alone and that we still manage to
> +	# create new geometric packs.
> +	ls local/.git/objects/pack/*.promisor >promisors-before &&
> +	ls local/.git/objects/pack/*.pack >packs-before &&
> +	test_commit -C local change &&
> +	git -C local repack --geometric=2 &&
> +	ls local/.git/objects/pack/*.promisor >promisors-after &&
> +	ls local/.git/objects/pack/*.pack >packs-after &&
> +	! cmp packs-before packs-after &&
> +	test_cmp promisors-before promisors-after

Ok, so it does seem to be the case that promisor packfiles are ignored
when performing a geometric repack. Naive question: does this mean there
are scenarios where a repository could accumulate many promisor
packfiles, but never repack them?

-Justin
