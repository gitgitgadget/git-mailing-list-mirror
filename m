Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3333F8CA
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768049956; cv=none; b=YO3yWiWscwnQGb+XaPiDMUtJ6I4RTM03cdx4bF5XR1WZLYpZ7ncmokKbY45oi02dEIqsFgRKyChmhpZX4DFxOZ9kZCnz0+NporO1Ma3rX924cPJy91TZ/eeylbr9xyrTJvU1TLuo+DSTZ7gPpWUga+4/QKmaFZYAkdXlQh5RTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768049956; c=relaxed/simple;
	bh=6Pvn3spZ97PpwyYbFyFrDlYKHz+0u6fvk4uOhb+sjkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irDgp9JVct4a2ADAW07SL9BkzPZGqiqgphfTZJBnrgG0pcLIbSAzkdxj9cFFC7sVJmZrQ6MabcFiu4QAQZsy9VjfPpHBBET1SAoCyCcd55wECcagLF3aKLv+dkSS3DYXtX03O77/6X/FWjSSqVg/gn2intMu0af2GCUuBEz5zog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAfKNXIx; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAfKNXIx"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso7388406eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768049954; x=1768654754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=193Ibp9zSH1LeT5RRh4w+sJMsgzCYA7sXm8Q0bJ85nA=;
        b=cAfKNXIx43va8QOBVQupj+kzw8dtPthn1wSwxulIiBC6q8YSs3YG+OLr1UJ3pGarld
         Sa0tB1hZVsflCECEjD8hg8AyBoJVQS85pNwxBo1me5fQsolswDucbzoPQ78oKsAJ+skf
         URQMNHK+h8V+G0Ygf7qLWYqugrtR4q7Bue3YJv30HUVjOXIyCMZ5tJc7x+QgDEtAYJsL
         PYVby3T1t/Yji1yv0Q96oBq+8m5tHqYPoy7yWH5jsYTFZyK2XgzJezfgQuE1CHCs2k2a
         46D6KS4fbuldbZcBo5XWgOrcAQxoqGnrlCVF5uWwsISsKgqcTIdcMHxTiBXaR/GbNOXX
         RWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768049954; x=1768654754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=193Ibp9zSH1LeT5RRh4w+sJMsgzCYA7sXm8Q0bJ85nA=;
        b=el4kPdGDl7kZP88FSuLVtPZi3IDUd5A3EeuNTDIsoLTR4JrfBMr3XqrvBbwBs/AiuL
         s9phYl1PDGU1/emyuxzBDU9sBzvcRfaUUBy8JP05X0G5j3n4if6yc4jCR4UdRBWH1ZvF
         RBD0inQOYydbmZtqKUAuCeLA1evTks0HXrtDry3XH3UyVvqRgBk3qEAS5hNbWoXUtnXr
         VmCkFzeDvSQV9w4/E7d+V/Uub8B4nH+Int+gHOShEVlhmyrd9enutWUUvtc1YUgrMZVn
         rMfpuCom6ZZGERvn89dxz3GurLIM43nN2y+qVsAJJJQkL3QZGgVvnBvF2LNlm28Frzes
         Ssjw==
X-Gm-Message-State: AOJu0Yz00blfAou11VKv+jyRaRU7WAlAtHh0JpmyO/vM7i39ErMONJso
	30O0r8Y6syVdrvdI/Ouyz/oqsMp24XGyLVQiMaW0AwseJ5GdCf81R42vlNdWtYJY
X-Gm-Gg: AY/fxX4ShaO+ZjsBxXDjcxoJT7Gl8ZOHowiDgpoa4rDg0d/Ag4gCX1wpUHUJLLhstue
	RGOGQ27nDvOlwtoUMesfGwqbKw667i5J2UlmgMje28/0Q+dnsr89HFIksgIshFXxE/rbE0f5gk2
	rS2YcKMOO7akXF+75Tjf4sS6buQUtLDiLpMhpFBc6AJtuDwUT9MqUhLOIj3+oYbo3JVht3hRjLB
	b0vnnl7a5xImverHozfLKRdyKWjLQnsNBRBflEB/rnJ7HZozbgIZEidY7HooAslmKTn+vdGHCFc
	zaeMdF1+VnaAi0J0ZE++14G4czV4sPnyxtGja88PcFXVUiscswAEfMQGmnU4Jv4++sTmtkXwqry
	vSfqrrjvGOXjlN81bQORHzhA/INoMgPrCnMKSKc5Oq+E3jBCBj1JNThinRFsBW4ixH0T2HtJGg5
	gJ8ebN/paAFnvj49Ec
X-Google-Smtp-Source: AGHT+IFQLhNKtHcQGp3kVgAzj2mTtTktfN6yh60fnC+UHrK0F21shkB2a4P/cbu5E2lReEfrHjsXug==
X-Received: by 2002:a05:7300:e9d3:10b0:2b0:5dac:450e with SMTP id 5a478bee46e88-2b17d0be83fmr7761165eec.0.1768049953633;
        Sat, 10 Jan 2026 04:59:13 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53fbsm12617965eec.12.2026.01.10.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 04:59:12 -0800 (PST)
Date: Sat, 10 Jan 2026 20:59:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 09/17] refs/files: extract generic symref target checks
Message-ID: <aWJNHgFnimXRHkb6@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-9-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-9-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:38PM +0100, Patrick Steinhardt wrote:
> The consistency checks for the "files" backend contain a couple of
> verifications for symrefs that verify generic properties of the target
> reference. These properties need to hold for every backend, no matter
> whether it's using the "files" or "reftable" backend.
> 
> Reimplementing these checks for every single backend doesn't really make
> sense. Extract it into a generic `refs_fsck_symref()` function that can
> be used my other backends, as well. The "reftable" backend will be wired
> up in a subsequent commit.
> 

s/my/by

> While at it, improve the consistency checks so that we don't complain
> about refs pointing to a non-ref target in case the target refname
> format does not verify. Otherwise it's very likely that we'll generate
> both error messages, which feels somewhat redundant in this case.
> 

Make sense, we should fail early in this case.

> Note that the function has a couple of `UNUSED` parameters. These will
> become referenced in a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c               | 21 ++++++++++++++++++++
>  refs.h               | 10 ++++++++++
>  refs/files-backend.c | 54 ++++++++++++++++++++--------------------------------
>  3 files changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index e06e0cb072..739bf9fefc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -320,6 +320,27 @@ int check_refname_format(const char *refname, int flags)
>  	return check_or_sanitize_refname(refname, flags, NULL);
>  }
>  
> +int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
> +		     struct fsck_ref_report *report,
> +		     const char *refname UNUSED, const char *target)
> +{
> +	if (is_root_ref(target))
> +		return 0;
> +
> +	if (check_refname_format(target, 0) &&
> +	    fsck_report_ref(o, report, FSCK_MSG_BAD_REFERENT_NAME,
> +			    "points to invalid refname '%s'", target))
> +		return -1;
> +
> +	if (!starts_with(target, "refs/") &&
> +	    !starts_with(target, "worktrees/") &&
> +	    fsck_report_ref(o, report, FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
> +			    "points to non-ref target '%s'", target))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  int refs_fsck(struct ref_store *refs, struct fsck_options *o,
>  	      struct worktree *wt)
>  {
> diff --git a/refs.h b/refs.h
> index d9051bbb04..d91fcb2d2f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -653,6 +653,16 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
>   */
>  int check_refname_format(const char *refname, int flags);
>  
> +struct fsck_ref_report;
> +
> +/*
> + * Perform generic checks for a specific symref target. This function is
> + * expected to be called by the ref backends for every symbolic ref.
> + */
> +int refs_fsck_symref(struct ref_store *refs, struct fsck_options *o,
> +		     struct fsck_ref_report *report,
> +		     const char *refname, const char *target);
> +
>  /*
>   * Check the reference database for consistency. Return 0 if refs and
>   * reflogs are consistent, and non-zero otherwise. The errors will be
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0ff047d0df..72c1db849e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3718,53 +3718,39 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *path,
>  				  int mode);
>  
> -static int files_fsck_symref_target(struct fsck_options *o,
> +static int files_fsck_symref_target(struct ref_store *ref_store,
> +				    struct fsck_options *o,
>  				    struct fsck_ref_report *report,
> +				    const char *refname,
>  				    struct strbuf *referent,
>  				    unsigned int symbolic_link)


Nit: as we touch this function, maybe we could change `unsigned int
symbolic_link` to be `bool symbolic_link`.

>  {
> -	int is_referent_root;
>  	char orig_last_byte;
>  	size_t orig_len;
>  	int ret = 0;
>  
>  	orig_len = referent->len;
>  	orig_last_byte = referent->buf[orig_len - 1];
> -	if (!symbolic_link)
> -		strbuf_rtrim(referent);
> -
> -	is_referent_root = is_root_ref(referent->buf);
> -	if (!is_referent_root &&
> -	    !starts_with(referent->buf, "refs/") &&
> -	    !starts_with(referent->buf, "worktrees/")) {
> -		ret |= fsck_report_ref(o, report,
> -				       FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
> -				       "points to non-ref target '%s'", referent->buf);
> -	}
>  
> -	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
> -		ret |= fsck_report_ref(o, report,
> -				       FSCK_MSG_BAD_REFERENT_NAME,
> -				       "points to invalid refname '%s'", referent->buf);
> -	}
> +	if (!symbolic_link) {
> +		strbuf_rtrim(referent);
>  
> -	if (symbolic_link)
> -		goto out;
> +		if (referent->len == orig_len ||
> +		    (referent->len < orig_len && orig_last_byte != '\n')) {
> +			ret |= fsck_report_ref(o, report,
> +					       FSCK_MSG_REF_MISSING_NEWLINE,
> +					       "misses LF at the end");
> +		}
>  
> -	if (referent->len == orig_len ||
> -	    (referent->len < orig_len && orig_last_byte != '\n')) {
> -		ret |= fsck_report_ref(o, report,
> -				       FSCK_MSG_REF_MISSING_NEWLINE,
> -				       "misses LF at the end");
> +		if (referent->len != orig_len && referent->len != orig_len - 1) {
> +			ret |= fsck_report_ref(o, report,
> +					       FSCK_MSG_TRAILING_REF_CONTENT,
> +					       "has trailing whitespaces or newlines");
> +		}
>  	}
>  
> -	if (referent->len != orig_len && referent->len != orig_len - 1) {
> -		ret |= fsck_report_ref(o, report,
> -				       FSCK_MSG_TRAILING_REF_CONTENT,
> -				       "has trailing whitespaces or newlines");
> -	}
> +	ret |= refs_fsck_symref(ref_store, o, report, refname, referent->buf);
>  
> -out:
>  	return ret ? -1 : 0;
>  }
>  
> @@ -3807,7 +3793,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  		else
>  			strbuf_addbuf(&referent, &ref_content);
>  
> -		ret |= files_fsck_symref_target(o, &report, &referent, 1);
> +		ret |= files_fsck_symref_target(ref_store, o, &report,
> +						target_name, &referent, 1);

Nit: we might change 1 to be `true`.

>  		goto cleanup;
>  	}
>  
> @@ -3847,7 +3834,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  			goto cleanup;
>  		}
>  	} else {
> -		ret = files_fsck_symref_target(o, &report, &referent, 0);
> +		ret = files_fsck_symref_target(ref_store, o, &report,
> +					       target_name, &referent, 0);
>  		goto cleanup;
>  	}
>  
> 
> -- 
> 2.52.0.542.g9473a8513b.dirty
> 

Thanks,
Jialuo
