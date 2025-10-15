Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E446A33086
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565950; cv=none; b=obRofwfyeZ4kELZ8sw52Se24ACi1m3b2zmF8kKHY8xE645XUUsROTQhTr1SWFbs2XE9IffsEwFUG0Y0/Z+AZH8c5MWtRLxPmNkHB+q6vI0Ej++MgBDKiBCVduMA8jacMCDwPDv8YqCgkwT0Fy9shnbfR1FDD0ardsQGWtgQ8t78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565950; c=relaxed/simple;
	bh=QAMXclC2KTZ62XMzBPMLPYGc3IKZ4AczQObPg0Bin6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpV+121E6dA/lTG5EGh0PcSc0OS0URA9pVcomXPfIx39041NiRN8VaxHTL6//p5uXZjsK69Tl08p6NBiO1GDWAe9bQKhtfsoxt7mnfKvi5N3eMvKUqAjLill1OlKE0vb1EcX22w/tiU88kiE7kQoOadH5iYK1py74PgOzdy9eDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdJ50WSW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdJ50WSW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-442003b80d0so15737b6e.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565948; x=1761170748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7BuuigYv69es0dfddCu6OKpbkvvI7tbXB25VsuK3w8=;
        b=AdJ50WSW1ecMa/sD2stJBeWd50ucgwSOS8/Kih1XTgz7hm0CHW5ls5vmxpFjtCdVRW
         m5JKrA8w/g1dFd4JFFlGGajpl5EGiZXhXCqg8kKMo6S6al15l2QD99CFbNgRv36hEgY2
         5tPpzHlY+7l+cJH1ZFJkkQSpIevShscPi9+6MR5xY9GLAljxZE4q+k9gLyLcFwqznfRv
         9iwKjwMHsVOKH56+XObMdmrkCOPEjKTuIaMHGZTDoDmsHwMulRxZBAURH5vSnakR/NnO
         Et8Gvm55ZSfd5+B99Dujgu8QzuP97RS2OG1iFEHJklBmhIHJAi7rz4AZEUJFKHGZ8Bj3
         EgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565948; x=1761170748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7BuuigYv69es0dfddCu6OKpbkvvI7tbXB25VsuK3w8=;
        b=TyibhXwEVUNS7DX9CEFBekAUIGdaiTzOrJEC5rQEYpWCemCEBJfA5LICokna9Icj7o
         bDtRCTgi41IAJg4NE10+wDyUINZ4QmIBHsbvk5MhSKJYdMBcD1A2LprOywFN2QcH6mJP
         MjmS6Y1ne5tKe5pXMj9Fp8LEqd+amjS01eyuCU+hv8xf+Br85hEFDbieVhuSRzPXt5lz
         ccZNZqtpaPKs8g0pufwqbgdCVBJsrWXycs6SnnKObP1Jbemg8zi8LiCplfS1pEAdsfO0
         bf29jMWfaM/Bnynufpc55aBCloPb4LLObsR/3w6pWuD/rCurYSMIN9ZjcMqtwZFPFogl
         N+Gg==
X-Gm-Message-State: AOJu0YxXZp0r0wPAQewfS8r/Q5qJaq2Urh/bAS4uhs/Aa9D/33afINk6
	YmHZUvpEvNbTfOeafGOpGjyPLVugeSvLU4ltKJShwBUTjbwGWHyJENqQ
X-Gm-Gg: ASbGncuKnsjMI72UR4u3piAPI4JsjithNYm6rJfOCTNKSMX8Hymm4ofc5SR4Ji1ufpA
	Imd7kfX8U/MVsx6Uc5rPcksbIGU5Jn088KefvatK6dylUfVmPFX5rja4OMjV56zUuHJ3tYa97/a
	jNCIpGv0hu6mqha/K/yf4a+zA+nJoHYl8hnqHxutqk9cBHN4Uk6N/Wmp31d3fNHrJ4WIUxIkBkJ
	Rs7pyKw+1+4az/YSxq8l0eI/YKrDDWAPUOIVFEMgG9M5H0iJnX73LLeBAZ38QVFRPbGHxYJYnxJ
	WO2b518Gk8Wq3wmJpFIzInqwMCfSQScCiPm8b2hIF8KRECn+WR3Hy5c42bcbm69YdpsEYdcTIys
	IbWrKDr4K/ahQIQsMSXohxi6kA6IV6qWTQQm2VNWpg7tUFG5+nPbmF+FGrauhRjLHmcCUZKtDNY
	XTMFcw
X-Google-Smtp-Source: AGHT+IH7KFUBsclY+pOs0+bc2Jz3oWZGkjzIYWO1sGh9k0lRImn44ql6rQDHK99DI7FbibT+Q7r5zQ==
X-Received: by 2002:a05:6808:c2ab:b0:43f:1daf:dacb with SMTP id 5614622812f47-441fb980e02mr907809b6e.18.1760565947882;
        Wed, 15 Oct 2025 15:05:47 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f911a992sm5801981a34.26.2025.10.15.15.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:05:47 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:05:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/4] refs: move to using the '.optimize' functions
Message-ID: <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com>

On 25/10/15 11:25PM, Karthik Nayak wrote:
> The `struct ref_store` variable, exposes two ways to optimize a reftable

s/variable,/variable/

> backend:
> 
>   1. pack_refs
>   2. optimize
> 
> The former was specific to the 'files' + 'packed' refs backend. The
> latter is more generic and covers all backends. While the naming is
> different, both of these functions perform the same functionality.
> 
> In the following commit, we will consolidate this code to only maintain
> the 'optimize' functions. In preparation, modify the backends so that
> they exclusively implement the `optimize` callback, only. All users of
> the refs subsystem already use the 'optimize' function so there is no
> changes needed on the callee side.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/debug.c            |  8 ++++----
>  refs/files-backend.c    | 14 ++------------
>  refs/packed-backend.c   |  6 +++---
>  refs/reftable-backend.c | 13 +++----------
>  4 files changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/refs/debug.c b/refs/debug.c
> index 01499b9033..40cd1d9c15 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
>  	return res;
>  }
>  
> -static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
> +static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
>  {
>  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
> -	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
> -	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
> +	int res = drefs->refs->be->optimize(drefs->refs, opts);
> +	trace_printf_key(&trace_refs, "optimize: %d\n", res);
>  	return res;
>  }
>  
> @@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
>  	.transaction_finish = debug_transaction_finish,
>  	.transaction_abort = debug_transaction_abort,
>  
> -	.pack_refs = debug_pack_refs,
> +	.optimize = debug_optimize,

question: Was the debug backend not using either of these callbacks?
From the commit message, it sounds like all the backends were using the
optimize callback.

>  	.rename_ref = debug_rename_ref,
>  	.copy_ref = debug_copy_ref,
>  
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ed8a1729d6..92d90fc508 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1444,8 +1444,8 @@ static int should_pack_refs(struct files_ref_store *refs,
>  	return 0;
>  }
>  
> -static int files_pack_refs(struct ref_store *ref_store,
> -			   struct pack_refs_opts *opts)
> +static int files_optimize(struct ref_store *ref_store,
> +			  struct pack_refs_opts *opts)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
> @@ -1512,15 +1512,6 @@ static int files_pack_refs(struct ref_store *ref_store,
>  	return 0;
>  }
>  
> -static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
> -{
> -	/*
> -	 * For the "files" backend, "optimizing" is the same as "packing".
> -	 * So, we just call the existing worker function for packing.
> -	 */
> -	return files_pack_refs(ref_store, opts);
> -}
> -
>  /*
>   * People using contrib's git-new-workdir have .git/logs/refs ->
>   * /some/other/path/.git/logs/refs, and that may live on another device.
> @@ -3969,7 +3960,6 @@ struct ref_storage_be refs_be_files = {
>  	.transaction_finish = files_transaction_finish,
>  	.transaction_abort = files_transaction_abort,
>  
> -	.pack_refs = files_pack_refs,
>  	.optimize = files_optimize,

Ok, we are removing the "pack_refs" callback and its implementations
from all the backends in favor of using the just using the more generic
"optimize" callback. Make sense.

It does look like we still have `refs_pack_refs()` which references the
"optimize" callback. It looks like there are no users, but should we
also remove it as part of this patch?

-Justin
