Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213624291B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785772; cv=none; b=Utl0jhLeWJNdobzeOeuKmfC1spvhQ3DyDZtUq4KxltT5gP8UzKr7eWougYmEnI/pBF0EC/j9z8mM8sq0H/nfzsmizWj1DC6dHXNyKmA7rtAoewg7NIkjrKT2cm9ThMNhVjYc32tLCMGcF02d0tpZ0gYkC3CgcDfCVCaQXqubBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785772; c=relaxed/simple;
	bh=H0qC6aU0jAWW3qkzHXHG0Pp36vRQ3gSS1yNu4MCwDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNTgnl0lseOrw4oxdBO8SgZsOUIeeDNzOUl3JnrtqCr0ApnZXpNb1+jZ/Z+d+5GhiYF1bxKCmyXOG5RMjgMGejPfsFA2D4C6Jkv3sFIf/gqT/u4hR98y4S7wB2K6+mp4F9Q//PTDAgmi5jjpt0FssziVmjxDazSetEiQWt8J8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvkJ0Lut; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvkJ0Lut"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2232aead377so33461535ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741785770; x=1742390570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kIRQ54cklmdxM03wNJIEO0icUhTz0dedhjiuHzW79Q=;
        b=WvkJ0LutYCR3oIZCBGPM6YWphYEIFKk5GpSgKPGwUYF6MOB19omD+CDGBZqF2LXiw2
         699DzRATYrp0eSlQiEYtLXl0LVbVqbm/BqvHFOksSxXvx5P93+URdlAQxPvBIfH1NCz/
         CrAyhD5/O+XQjUf16lJ7Cl/0R3Kf7CF8Tuq4oWKPj/ouYsj4Af4cuUxfhvB0Y4M596jx
         b+8d1hnyPAmNne5q8cgPO3yqL89g3ntGMpJAMRLZ32gNJMTHNmXGC5GiODWeZmmr7Yrh
         I94vg0QJTIwjtin5TY3EHMyflfwp+fB6D1QdhUQityHyVjk5ZGF9LWXg71Cv+FhXr0JR
         C6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785770; x=1742390570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kIRQ54cklmdxM03wNJIEO0icUhTz0dedhjiuHzW79Q=;
        b=rYPPZ1U3XXNka0Fv0NzRHXquW9WuowTINg2JOCDwwfBCki1HrRO2egGo0VmQIdpr1F
         fji0D/nPowz0UfUIm3wZkkQ5hiGbzVbbfo+uUK1GQovKYAPvapxVyq7yvpBkwohElUtn
         xmrP/zmxvdmgKwp9mnMaaodMs4xcV51oKRFxAcY9Sm3zjNpamEnaGGprZEbQSBg4rdUf
         eWPNcF9Ijqz2XPdwbgr+aIE/5eboxXRuNbYAKnJnWizZf7SAgLBr5qLrK5zBBfeHMU6d
         8TVJj+cN3oIpLI3qeD+XxeQ+/ADgKyLrdJx13VxWvNtfmzcyGdz9diG50Fym5Eu+ZWP7
         POOQ==
X-Gm-Message-State: AOJu0YzjZorB4wkawL1I2yb1jrKb2uMOEhpWKHbSZ2ISfi573/V3vyAh
	nyMslePgnC5vRTWILxR7rFMmb2rQtezkB2TvXmqhl9/i4C7cePJt
X-Gm-Gg: ASbGncunOoN3r41OCe89GtzOmG3/Tgn31+F8x+e80zPYpD545nUJRefsJvYEJ2RkS7J
	dK0o7E4w1FPXhwu0VKevChIS2ikfnGcPghERSk5tQJUAiAYoxZlPJeF8k2Jo966I07q4nGRNHo7
	d9j/D7/HxxQZb6QqB41EID9o1yD9Ol50XsqrCv6qSuQwAli4oYtHM09pr0u5aTKzvZo4ai0blqk
	vERFm6kKfCuLLCYNI+mB56ziUXhSElXNOOfJOpYdAnoN0tCDcvebjUCDrH7lnlgP9DjuCcyi9qR
	2IqPx/cSLok2Y5H4xDtwFwm9ixLE+226Ya6IJQn3bhUAjC82vIQ=
X-Google-Smtp-Source: AGHT+IFez5VZPg1oYHiPi39EP4OTh8zWQ7hyLU4ixV7WjJsWd3ZOGHJTxM+Gr9s8o6l2nqyoEPN4gA==
X-Received: by 2002:a17:903:1b63:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22428bdee3cmr350565455ad.32.1741785769887;
        Wed, 12 Mar 2025 06:22:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a91be9sm115181445ad.179.2025.03.12.06.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:22:49 -0700 (PDT)
Date: Wed, 12 Mar 2025 21:22:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 08/16] refs: stop re-verifying common prefixes for
 availability
Message-ID: <Z9GKs9z4n4qgOP7n@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-8-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-8-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:39PM +0100, Patrick Steinhardt wrote:
>  refs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 5a9b0f2fa1e..eaf41421f50 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2476,6 +2476,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  {
>  	struct strbuf dirname = STRBUF_INIT;
>  	struct strbuf referent = STRBUF_INIT;
> +	struct strset dirnames;
>  	int ret = -1;
>  
>  	/*
> @@ -2485,6 +2486,8 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  
>  	assert(err);
>  
> +	strset_init(&dirnames);
> +
>  	for (size_t i = 0; i < refnames->nr; i++) {
>  		const char *refname = refnames->items[i].string;
>  		const char *extra_refname;
> @@ -2514,6 +2517,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  			if (skip && string_list_has_string(skip, dirname.buf))
>  				continue;
>  
> +			/*
> +			 * If we've already seen the directory we don't need to
> +			 * process it again. Skip it to avoid checking checking
> +			 * common prefixes like "refs/heads/" repeatedly.
> +			 */
> +			if (!strset_add(&dirnames, dirname.buf))
> +				continue;
> +

Reading here, I think we should not sort the refnames for "reftable"
backend. Anyway, really a nice job for optimizing the speed.

>  			if (!initial_transaction &&
>  			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
>  					       &type, &ignore_errno)) {
> @@ -2574,6 +2585,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  cleanup:
>  	strbuf_release(&referent);
>  	strbuf_release(&dirname);
> +	strset_clear(&dirnames);
>  	return ret;
>  }
>  
> 
> -- 
> 2.49.0.rc0.416.g627208d89d.dirty
> 
