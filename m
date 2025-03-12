Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297924501D
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784319; cv=none; b=aM5zisHZ+9ixEloawUBY+18ps0o/cn7pn6YBCW6HHKWPs+9JtPnvyTwKibdffSXzrHq7gIrPgamYWx3ZUHIfu0rTrGM3OTgwLkF8b/YkhXro37pm3Q48LNe09m5LyJssSY6/sRHv9YGSYEI7B7ik4O7Jrlt+LxrPZRyUvEjk1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784319; c=relaxed/simple;
	bh=sfYgB3MzPvfqeHjR+4JCSHtdz7zXPkr3MvygmW7Buko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIlQBS/SnzaVkja+t22422Unb/7s+aVHWU/5hhKceqnxLil3LJnkWFz9e8gGpGr2hqXcxg4Gfd+5GoIbucLtA4PrTNSOnQefIKegJDdHBHCQE/Q9Qkf5lxYZsDYLm1ImuFUMRIovq47udVEqi618xz/u1bzES/icFEapYPADasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhNX7d5r; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhNX7d5r"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2feae794508so10096870a91.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784317; x=1742389117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqPoBAuItdEgRw8NAwuReExfs4ptNfuMfmx10cpxsgo=;
        b=BhNX7d5r9Mu9u9m5LGbHR25huiF0VcB0D90/VdnV+LMwQlWiSezlLkLU+U8vqaoquY
         Ie9THIklfJIHt3hXVsu+YoNBXb/3G4YkZrjsyNHWp2T5SCjj5exjy/icOH9ZDg6JlqaQ
         0m8S8cDASz4cXUc6oQBPGtry3CcpFouqZ9ZUAe1Kff3YQf4BGqaOP6R2YY3iyc+t5Qqv
         L75Ag8UmhmErD5k+1YYpkfhq6wMwaQgUaj5ngy9YlWMjb9UQkIkpffgpQzetCkezSBrr
         2DTojguxSk7HyRDcSN+Warra2Ol2EiNWVF4gdCPqnBAMlMGc+ut5uZ2Nzi9kl9Ua6dhA
         UShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784317; x=1742389117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqPoBAuItdEgRw8NAwuReExfs4ptNfuMfmx10cpxsgo=;
        b=l0tF4fOmSJIjdcvNA84B30hvrgPjNkNFI7zxtrhCagOUHfi+OiI6GkWrBNNvZFnuZ0
         NM/jQgPlkZ12o3S881C5Mpv6Z7Csaxoh5dzk5EU3avXcRUW87ZHSoNmbZzuYmofsfPWp
         1nrAP+pVbND/XS+SSNdEvMlF5gGh6xnJaCUvzJEHOhjXuN8mRdNdbAouGAECoxq0lRmp
         DWm44NrCYeuL0HKaIkTTxm8N3caihkaNodm+MagXiOqI2CpJPX+UCvmn1TgOa+yEKMhI
         QooghIwNwXXnqGCttNTKCfMNqPpbzMaWMtkNL5uE2sAypPICRs8JvUOq/6YDaHpIbhyB
         BisQ==
X-Gm-Message-State: AOJu0Yy+v74RUqZcfpcqHUArfqE0UoGniS2+TmzfdBDCncM5l5pOA2Wl
	xCtAMXF++iXJ91vjgfi42d/7Kb9S8SwCIBfrgCqT1ef8AEZp8EYs
X-Gm-Gg: ASbGncscuRf30zyUthb/I+tdGT9VxJas6IN5CNjFypGb8nicUPzlb1vnu5zhgHAEpPG
	M/FHe1PWiMvpX8+81evtdoV4VL3bezUK1xysYDEGEOogFHBXuNPtiW3qpCh2w7oye2SBudOtb0/
	/pel9u7mAEs7xAgq0gRFLXoRGmhDAicigs3P2s1yIBSa/XNMQvI2pn7qch2b1KtbbtwKmEmIoDU
	cd2Wb/RE2QWg1S+abgl+m5lrdkGlHhmdH27MDKB3kV7pr1GOQPJbH7Vk1pdza5/osaRxkAXO0+x
	wRTJ7FW0evh7Esa1YtVXmDj7KG/31Dr6hw7QugXp
X-Google-Smtp-Source: AGHT+IEDBrFJcr46a6dYGD54Df+qyU9Fa+rfBhJTDdMHDMVqj7MYz74T5vOho184urdl/B+bkEHDTA==
X-Received: by 2002:a17:90b:380e:b0:2ff:64a0:4a57 with SMTP id 98e67ed59e1d1-2ff7ceef536mr26917969a91.26.1741784316852;
        Wed, 12 Mar 2025 05:58:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3011928604esm1661867a91.41.2025.03.12.05.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:58:36 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:58:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 06/16] refs/files: batch refname availability checks
 for normal transactions
Message-ID: <Z9GFBl5AIQZGyI-9@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-6-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-6-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:37PM +0100, Patrick Steinhardt wrote:
> @@ -2811,6 +2808,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  	size_t i;
>  	int ret = 0;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
>  	char *head_ref = NULL;
>  	int head_type;
>  	struct files_transaction_backend_data *backend_data;
> @@ -2898,7 +2896,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		struct ref_update *update = transaction->updates[i];
>  
>  		ret = lock_ref_for_update(refs, update, transaction,
> -					  head_ref, &affected_refnames, err);
> +					  head_ref, &refnames_to_check,
> +					  &affected_refnames, err);
>  		if (ret)
>  			goto cleanup;
>  
> @@ -2930,6 +2929,26 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		}
>  	}
>  
> +	/*
> +	 * Verify that none of the loose reference that we're about to write
> +	 * conflict with any existing packed references. Ideally, we'd do this
> +	 * check after the packed-refs are locked so that the file cannot
> +	 * change underneath our feet. But introducing such a lock now would
> +	 * probably do more harm than good as users rely on there not being a
> +	 * global lock with the "files" backend.
> +	 *
> +	 * Another alternative would be to do the check after the (optional)
> +	 * lock, but that would extend the time we spend in the globally-locked
> +	 * state.
> +	 *
> +	 * So instead, we accept the race for now.
> +	 */

I am curious why we don't sort the `refnames_to_check` here. What is the
difference between the reftable backend and files backend?

> +	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
> +					   &affected_refnames, NULL, 0, err)) {
> +		ret = TRANSACTION_NAME_CONFLICT;
> +		goto cleanup;
> +	}
> +
>  	if (packed_transaction) {
>  		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
>  			ret = TRANSACTION_GENERIC_ERROR;
