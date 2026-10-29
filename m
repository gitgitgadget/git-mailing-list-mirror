Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235768;
	b=IuhvX9t64sJivel2msSva1zM/1cXEs/YYTtkNBwrJPInCVOnyey5SLImKUSR91pz3LIS
	 /n1P+/X5ORlPhxRFNIWwAMwIUpK8qp2xGFAzkCghsOFEyAm/9rzzHB4GkqMdGfmv9NhOV
	 I2woCzMNdJkXXTjLKzv/q9YOjsE10+vSxcTYgEi7QYNV0HJIqBCAfqZEic4G43Vsb4Czz
	 WN5MDWsBAgltyP9vM/O1HLwD+9eFDz6R08pgARHEzkZuSsJu45oKyuTfTjsVMmXbDnuRc
	 BjN5kVill3MO1n0M0bm0Ks3j5JyeIbLzEyU9E+lIKX63Rvdp4Nao6l12jWj8XUeyCYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=mizKqmrxZ2yzOvch2PkF5uly4TaFR3o4W3LmksXy6R0=;
	b=jBDkn4l1OiWzdERERrZJtIR2kl1jFN+ltQLV/3631RCXFBrs2tsfyqCAhpPaM7MZMQds
	 5fWcfoqQyES6ArlPEQTF9lmmspBewwloAamMIOU1jlD/SQN2+eLHJX/XwQnsCfmff70/i
	 keGWckjRxOvXU66NnOF4DvDaX4v7ZBd9g5mrHEM7qQ/WGEtiVLBj3dVHKPYZtNXCWNwdB
	 L/Y45QO5wfB5Ko61fMFNCXS2HI+TM3XBtHfGzgcJIvky6rHvQBMLjlGpF+CXeiBmMKVKb
	 io7Jl738gmopE3Y5/5lEdKHexexxanw7ws6kEUDWQzYuWeFTMf/OMpUaPD968WKNX+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyUf0XOP;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4E606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyUf0XOP
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso11905475e9.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793235766; x=1793840566; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mizKqmrxZ2yzOvch2PkF5uly4TaFR3o4W3LmksXy6R0=;
        b=LyUf0XOPoWjSAJSo3Q/aAiVh3Q/XR7jzbtIAAzVwPvSZ6vxNHdJJ6FphddADQLd6Ix
         ukPouJth+hthMIByADe+x9ChK5illUO+XRxSpR6ySaXPUNciLr5De+0yKIFuq47Gk+xB
         glHagRSc1Cf3DMOXCX2wyNrH/1/g5blkuIZ88GBekqHgL7qe5YC5pPniqEak9q8FjlGK
         usELCwq50WsiG6xrdvWu4aRCEykpTvR10jNz1tyssWDUz4TODzRxBHkyg7ZWgSbMCxFz
         k81+tDQElhQh8t6HYGEkZWTGkG2mUbPi4PyqgpehrV+gi6K8Re1lO7ZNwMPgUOSI53HJ
         bUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793235766; x=1793840566;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mizKqmrxZ2yzOvch2PkF5uly4TaFR3o4W3LmksXy6R0=;
        b=aeqQB1PQa76gzjJlSxxbuVyBgSS7DS5INLHlveDQYJIUZfH0LcFP57nMZqG3sxwCFr
         +LlgqR0tIyE+GWaDyujIGS6CXpuLwxZWyhu2uTY5TB7of5mfNSsfjHE37r0zNx3La0/r
         Z7GyLFLKMb7UtQo6U8fY3V9JJWW2KcXZXbWeg57PHqDzS5C1y+sYS1CRyDE6mVXxsIJs
         3psrQsvrg0tDZkWCF3Ida3nqFqg93Qhwe3CwMW7WMNkXT+fjbLgwc6uRTRoT00T0Uzf8
         X5ve9W6d5Ua9aeQLMCjxRghTYBGOWyPJYNWv87bq40cOLaBc88dyUAmtWeJ+X10mNNNE
         Nkdw==
X-Forwarded-Encrypted: i=1; AKwUvByHETImWjaxGmhwnNQvhMPmm5Ba3h4wP2rmAIx0BGK9PlnsmCdgq9Ljl5oR27MzSWTk2oU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIW3u/mj9oAJs7ecFXtatMRbmF23XWBLFcQ0NBl6eHCJ76ZFT3
	UTk2NoBkUC4T83vyQ+Tq/i9yWoGR+pzYz8Ctc85yAD06paL7/lcoNkAs5gO414i9
X-Gm-Gg: AYBFou0YMLcOQ09QUneLfjkMo9Q6La0zc1OeGaqm+DVDwktyzVGR3HYh9ifLqqu/DAQ
	VHXueceRm2N0GEjj+ACQ84e7TvMJ097mOsG4UaBZgEyzNUS5bM1IfLnWBcAUI44KLYtXBw0mRdm
	bSmTgDvK2hpHBNPwhpM/V6fMuuOVOS5grb6UlZImOYthKD+AxlJ32TMIwrYCEm9q3P7fjVoiFcz
	U+hnr64kpRiKcn3ZiioaXwRjoLOmrBwWALh+cP61VuqTzY7ZWfOO8APIUrTfx9DMY2bFz3CixjW
	MYWczYOB4STx27oqwApL8ywe6qM/TtbTwvrGLGc2cifb0v5VK+BbBREAjSJgPoacBx7whipj1+/
	TVL8ZfipXMtCC/GI3J0CbTYbjepIsOIPZzJXuicOU8npmDu7pu6q+wb25URo5VAH1hSu3BctuaL
	bU6l9VXUjGT6wCPyz1Uy1STF8xed4QWosAublJjMMjtX7dAuEv0p23ogNoLj7fHjGV8xfOMUEc2
	4QzfQ9v4Xf/Bk51TrcudDQW+eHXzcXLybq5Es/23P0yCzB7b/kidxHcUyOCVwZB2rXD8iPOyAIZ
	LhZ0Dh25zz4EYSHP+gT96CcWItMRglxfNLzd4PqOXUsIn4uRiiEKudyn3X6a525MDb1Y6UlQbSy
	AUU/bGrgP6KDo/QWAXegT3yOYk0tThgs0uqsyUWcXFco2Z9uealLiYpFFhrOBoF8e/5nVMvkVui
	FxyYCSMVYHQVG53Cj9veafk6L2QY//9ye8aB0H4EpRMiX2C3nPO8zkzUg=
X-Received: by 2002:a05:600c:1391:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4a966e2b41dmr96634425e9.20.1793235765907;
        Wed, 28 Oct 2026 18:02:45 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:b017:4479:7c99:e3fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee57594sm26769035e9.3.2026.10.28.18.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 18:02:45 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 01:02:44 +0000
Message-Id: <DMGX0XEZIMHC.2P0KB28XC83HV@gmail.com>
Cc: <christian.couder@gmail.com>, <usmanakinyemi202@gmail.com>,
 <siddharthasthana31@gmail.com>, <kaartic.sivaraam@gmail.com>
Subject: Re: [Outreachy PATCH] range-diff: use the repository from the diff
 options
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261028215137.15262-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261028215137.15262-1-okhuomonajayi54@gmail.com>

On Wed Oct 28, 2026 at 9:51 PM WET, Okhuomon Ajayi wrote:

Hi!

I think that the title, "range-diff: use the repository from the diff
options" can be confusing for someone that doesn't know that diffopt has
a repo field (as it happened to me when reading this).

Also, when talking about variables in our code, using their names makes
it easier to know which code is referred to.

Does this work for you as title?:

range-diff: use diffopt->repo instead of the_repository

> output_pair_header() and patch_diff() already receive the diff
> options, but use the_repository and the_hash_algo. Use the

This first sentence reads a bit strange. But apart from that, I miss a
reason about why we want this [1].

> repository from diffopt instead, and pass only the hash algorithm
> to get_filespec(), as that is all it needs.

"and pass only" reads as if now get_filespec() only receives the hash
algo, but it receives the hash algo on top of what it was already
receiving.

Also, saying that this is related to the_repository replacement because
the_hash_algo comes from the_repository would be nice.

>
> read_patches(), output() and is_range_diff_range() still use
> the_repository, so USE_THE_REPOSITORY_VARIABLE stays.

Nice to know. But I think that it would read better [2] if you used the
verb at the start, like:

Keep USE_THE_REPOSITORY_VARIABLE because read_patches(), output() and
is_range_diff_range() still use the_repository.

I recommend reading Documentation/SubmittingPatches for this kind of
things. I left at the bottom two links.

>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  range-diff.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 8e2dd2eb19..3f56a4f71a 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -418,7 +418,7 @@ static void output_pair_header(struct diff_options *d=
iffopt,
> =20
>  	if (!dashes->len)
>  		strbuf_addchars(dashes, '-',
> -				strlen(repo_find_unique_abbrev(the_repository, oid, abbrev)));
> +				strlen(repo_find_unique_abbrev(diffopt->repo, oid, abbrev)));
> =20
>  	if (!b_util) {
>  		color =3D color_old;
> @@ -440,7 +440,7 @@ static void output_pair_header(struct diff_options *d=
iffopt,
>  		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
>  	else
>  		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
> -			    repo_find_unique_abbrev(the_repository, &a_util->oid, abbrev));
> +			    repo_find_unique_abbrev(diffopt->repo, &a_util->oid, abbrev));
> =20
>  	if (status =3D=3D '!')
>  		strbuf_addf(buf, "%s%s", color_reset, color);
> @@ -452,9 +452,9 @@ static void output_pair_header(struct diff_options *d=
iffopt,
>  		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
>  	else
>  		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
> -			    repo_find_unique_abbrev(the_repository, &b_util->oid, abbrev));
> +			    repo_find_unique_abbrev(diffopt->repo, &b_util->oid, abbrev));
> =20
> -	commit =3D lookup_commit_reference(the_repository, oid);
> +	commit =3D lookup_commit_reference(diffopt->repo, oid);
>  	if (commit) {
>  		if (status =3D=3D '!')
>  			strbuf_addf(buf, "%s%s", color_reset, color);
> @@ -474,11 +474,12 @@ static struct userdiff_driver section_headers =3D {
>  	},
>  };
> =20
> -static struct diff_filespec *get_filespec(const char *name, const char *=
p)
> +static struct diff_filespec *get_filespec(const struct git_hash_algo *al=
gop,
> +					  const char *name, const char *p)
>  {
>  	struct diff_filespec *spec =3D alloc_filespec(name);
> =20
> -	fill_filespec(spec, null_oid(the_hash_algo), 0, 0100644);
> +	fill_filespec(spec, null_oid(algop), 0, 0100644);
>  	spec->data =3D (char *)p;
>  	spec->size =3D strlen(p);
>  	spec->should_munmap =3D 0;
> @@ -492,7 +493,8 @@ static void patch_diff(const char *a, const char *b,
>  		       struct diff_options *diffopt)
>  {
>  	diff_queue(&diff_queued_diff,
> -		   get_filespec("a", a), get_filespec("b", b));
> +		   get_filespec(diffopt->repo->hash_algo, "a", a),
> +		   get_filespec(diffopt->repo->hash_algo, "b", b));
> =20
>  	diffcore_std(diffopt);
>  	diff_flush(diffopt);
>
> base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8

The code looks good to me.
Passes make DEVELOPER=3D1 and git clang-format --diff HEAD~

[1]: https://git-scm.com/docs/SubmittingPatches#meaningful-message
[2]: https://git-scm.com/docs/SubmittingPatches#imperative-mood

Good job,
Pablo

