Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288C34C815
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443152; cv=none; b=Oxo+Yx0RZjIR0woqKpeRGVgQdOxvepTt3CnPxA46Fiwh0ACIAWo3Ss4P364woZIiQPUQ2ttZbOC+3kUtA7T1eIQpAcibBdkCcmJtOCNINfZKCKs9bNm38O+t1Fxht//J2OXc5Q8SAbd5Qm3xO0Dy6huVkPYqhL5D+ZzSux4LBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443152; c=relaxed/simple;
	bh=2ybduZsjqe5WFS2eC8RVFc6FjUQMCPoTOE8tEFxYz/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZtg0++zYLWMRy7FLVZII/0EJIAX/XRPKf8Y/ahjB0hXLqEEN+uRr3C0V76DbgRO9k5ul4ATzCEU3DLAWQLS+elToyDU2AKVM5OpH+BsdDumPO5N3el4rvN8mlEuDFjmupNahWk5O/5cqzegaRlNzKLd7NuptalRkFDNtMwlnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxNQDT2k; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxNQDT2k"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d744d9acbeso1087045a34.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773443150; x=1774047950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpuLaylzEuR+3p5fPETJiraxQD4PmxK8z1Qh/sTgPrg=;
        b=jxNQDT2kz4wRCcLiO+5JLUKv4HAK6oCwlQ+5gxBZjAnp92J8UbMdtrwchT2+gCuToi
         hy288j074nb0vZMdYxPm314hcOpd+uNiHaACzkX+Ctm2J3IQBflKUQm+ZJZ/VJ58fg0m
         IYRShUc9kCh4NASYczkJjiZUvJnGNSxFN37RXLQLGozqMj7DKKdnD6J82ehEwp8Q3a+T
         tcL3z2e2OgLBoyruzl/6E1fFBRT34/Iimos94q67KZ524XqgkGyb+NOA0QQ+ko4CZFgx
         oKBb3kZ+d4rwyaFtYEtcRb2E5GMcuXoJnvqA28cbgHguAPf7D6JB3mMauq5HyldX1YMs
         BlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773443150; x=1774047950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpuLaylzEuR+3p5fPETJiraxQD4PmxK8z1Qh/sTgPrg=;
        b=bGY4F5J1gSnUALjX7ag3x+FTKIyW/bfHdfZvy9rdQUK5+CtDIYtCdvzfx6/u9r/9ha
         nCFeIm2TUAZC3MFxd7ynfl+gSNN4crxZ4KQbrb9fGtTG3tcwvAVqs6I0p+XGKcrJY9Tg
         FEcYw/tyA23qsuv0uwLFTYGrvyJqLe/rRr6KiCSZBO5kVSICodoSwX0AG0z8WQhGItmD
         aopbPVyhvQPxjXe6+ht7XlfzgYSuaqTXsWIRYoFuD/PAyaDV2Fsc7xunI7pDHFkBjJe0
         tdKwYJaxhyFIwAtnP3WJI/rEK+mKXLO3Gq1igE8SNMqp7nDxoxm62Ljt1tlCF/HHjuFf
         bjmQ==
X-Gm-Message-State: AOJu0Yx04PykHAscnkNfQHxEtKmvaJDFAKJr76sg+T+oP1TLRM95ueNe
	8AltsEB/DcuXMqWM8JpxIOpFN1dH/LfMMi/hszlx8Lb5tVxWZBFXZB6K
X-Gm-Gg: ATEYQzyNuMflF9EGC9BGLAwOem+P2bTesevxq5GxtdKaJWSPPhhFTo1xunQ9rxeoxlz
	7oNXXqaW0cGQeJjbsnJhcLsedtUzErNZKXvJa4KnTqE3INk1DwLRvJsvZqvPq+6wtVTL1K+1Wx6
	L/DBx4PhS8K/MA7YKMpOEV7mBB6QUU0C8dqp3xY1ufmuMF82tUi69XkdcOKDtxslIoQ2UHi+7Zk
	5MEOyBwB6lT//RQ4BUYXbaSuYwM2tPI99pwn9Bt5XZAKGhOPknzkOd3lx6vFwxMdR6UyWeXoCUC
	KK0pVwvhbdih9QWgcWhcdHGzFTp1E2fVoTtIbJu1Dh84cN/z2C3mFWJmrCpNwiK210p7qT3PAbL
	W+evC/zujRFZOP4ULUh/T05nlrRmpAEwicbAQDnWVTmamWHaCHlmT3HahPCNd5GspHq8rgquqm9
	d3sTmdfvdA3F5Q8h27
X-Received: by 2002:a05:6830:6b0a:b0:7d7:5bb2:5690 with SMTP id 46e09a7af769-7d7825d85a4mr3012931a34.32.1773443149965;
        Fri, 13 Mar 2026 16:05:49 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae398fcsm6978461a34.16.2026.03.13.16.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 16:05:49 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:05:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: eric.peijian@gmail.com
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/1] Add preparing state to reference-transaction hook
Message-ID: <abSWrcvm-smx92MY@denethor>
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260313193537.62827-2-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313193537.62827-2-eric.peijian@gmail.com>

On 26/03/13 03:35PM, eric.peijian@gmail.com wrote:
> diff --git a/refs.c b/refs.c
> index 6fb8f9d10c..f1439476d3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2655,6 +2655,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  	if (ref_update_reject_duplicates(&transaction->refnames, err))
>  		return REF_TRANSACTION_ERROR_GENERIC;
>  
> +	/* Preparing checks before locking references */
> +	ret = run_transaction_hook(transaction, "preparing");
> +	if (ret) {
> +		ref_transaction_abort(transaction, err);
> +		die(_("ref updates aborted by %s hook"), "preparing");

Should "preparing" be marked for translation here?

> +	}
> +
>  	ret = refs->be->transaction_prepare(refs, transaction, err);
>  	if (ret)
>  		return ret;
> @@ -2662,7 +2669,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  	ret = run_transaction_hook(transaction, "prepared");
>  	if (ret) {
>  		ref_transaction_abort(transaction, err);
> -		die(_("ref updates aborted by hook"));
> +		die(_("ref updates aborted by %s hook"), "prepared");

Same question here for "prepared"?

Thanks,
-Justin
