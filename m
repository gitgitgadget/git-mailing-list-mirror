Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5F7083C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784053; cv=none; b=D+7K9s2eau47X8ahGgigYRYC/BDw2YPYtAaMhNRJ9vTe5erFP0gHPQzXqkb5hhZp4DiorPgxvBGtxVU0Mb6wn9iU60ieB7y0mPWhq5AgCgyV+L7tvKt3Iju7ZJwcfe3OtycmC1YCs5j4s98l78VLe1YSHFbcJkeHDURTxHXvIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784053; c=relaxed/simple;
	bh=04F8YnjA1Wj7D1dHGziwnqCPm+SUWIVupPK7meYZuLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esvr/Cdn5/lr+LhB6d5dDkPeHLPVacmmbxiwDVRj/pVr7MVEcICzdoumNateAws719ie1MBTA/VnbYX1erYh7NRUouDsB8kq8EVVYkrkihiPUsUI036KWkw0KCdoyFOSf0rn262FTVTzrBTrP1792uw4+n5dGY4XmWq8TDtf0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPzBbicR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPzBbicR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so124469825ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784049; x=1742388849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K98/FCDNkT0SbpHt6lz8bkeyxIipQ9Ir+S4DqWreSM4=;
        b=MPzBbicRhYWqMTs6CR3/U6b2B5UuDwNxpc8iX9T+f7AT+NOS16H687m6AeSOSDLYYl
         n/iA1Re3visMW6umwpXnoeCfEYa4AGWYAWngQish9VmKQpefYMFIGY59OAEkWsU6298t
         lmSnG00I3kKbGYx7uNTHTqv9peEmWwx3ubAILcZcYEdMUsfy0W+eEpe3KjK4lI/SUfVd
         HpAhHO9GF3uj/ms/AIqiKjju6GqksuTmEQmIFm6NqP6AB5QfCdKIn6FduwnI/hoCOa7k
         nuUTwMgX7LGCWIivmjPTluo5+WQ4a3KUEMhhekBCT/Vb4vLBu3F0QDrC/faRdEXfHsln
         MWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784049; x=1742388849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K98/FCDNkT0SbpHt6lz8bkeyxIipQ9Ir+S4DqWreSM4=;
        b=kVBTpG5sIgnSDd+Gp444chcLDFmMbOw9PuS/zb/3RZTZzy+bFzLtFS3VIhHz9PqrIP
         5AITA3bzGSNRVVW8M7bzLOlBKp2iak1rg/mwRM5LNOVD5m8ipljmDwthjXuCDTW9oKpQ
         zEfFIcBzEK3sJSiy3aBonRYGppWRe8F26+AUdrMfrKoukmWcGDhEA9XwDGQc7pZ68jP9
         mOrGv4qAE6/V1I/KIWiUyxsgSa89mXoN7O6iHCDrqEVtkwtDLKT2seBX35qdUrkz+A4Z
         mU1YR9XdFbfQJcHtACWTiZs/BxDNsybJNVGQBzwPjb7vyz0yytQBXtDwC9km0b2VlSaK
         GYLQ==
X-Gm-Message-State: AOJu0Yzxt+75RZ729YqUDwxNDWyT1mA3yhD7tzVryoPSCNN51GmMur+I
	G9eYIrygs1ac0U+EX5/rCMtHYSR9QKP+SL1WlvOuAgUHN5qtCbGU
X-Gm-Gg: ASbGncsi1VhPjr8dw9EcaaYcrkUtwN54hKPx4We9X46KRBnnoY3UyNsb2kBSECcwHbc
	BADTzmwp7eOpFj92ZuZGBkEW/W8njoefzXasBWAoXmx99ZYNjuSLIeYjzSnorYDrbu/1938Jt0r
	ASM4sTvNwChnMiWxk7ZHhsw7zIU5QY9I+JDKDuYl6NB3M0A7EHQpmVSNqeRp86pv21kqdvqmIY9
	vm68zvRRaBGv5yWrSadNjIP6XKnjmGMg/uKSG09AJtY0lOg8re/C1/cq9BrJDRE0QMb+eGEKLRk
	UwcY/zMSZn14Zg2v50NnZaGG2p2w++ExbU1TyOlU
X-Google-Smtp-Source: AGHT+IH2f6vToCDJpMZh+9RcPUvWlQh2OUe3Binn8568vSHietJIYVXapo81G89fiD87AnzS8qGXqw==
X-Received: by 2002:a05:6a00:238d:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-736eb667a71mr10215762b3a.0.1741784048657;
        Wed, 12 Mar 2025 05:54:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7369824593csm12216650b3a.71.2025.03.12.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:54:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:54:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 05/16] refs/reftable: batch refname availability checks
Message-ID: <Z9GD-mg7CrvUxgqH@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-5-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-5-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:36PM +0100, Patrick Steinhardt wrote:
> Refactor the "reftable" backend to batch the availability check for
> refnames. This does not yet have an effect on performance as
> `refs_verify_refnames_available()` effectively still performs the
> availability check for each refname individually. But this will be
> optimized in subsequent commits, where we learn to optimize some parts
> of the logic when checking multiple refnames for availability.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index d39a14c5a46..2a90e7cb391 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1069,6 +1069,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
>  	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
>  	struct reftable_transaction_data *tx_data = NULL;
>  	struct reftable_backend *be;
>  	struct object_id head_oid;
> @@ -1224,12 +1225,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  			 * can output a proper error message instead of failing
>  			 * at a later point.
>  			 */
> -			ret = refs_verify_refname_available(ref_store, u->refname,
> -							    &affected_refnames, NULL,
> -							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
> -							    err);
> -			if (ret < 0)
> -				goto done;
> +			string_list_append(&refnames_to_check, u->refname);
>  

Instead of checking in `prepare`, we will just append the refname to the
list.

>  			/*
>  			 * There is no need to write the reference deletion
> @@ -1379,6 +1375,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		}
>  	}
>  
> +	string_list_sort(&refnames_to_check);

I am curious why we need to sort the refnames here. I think at current,
we don't optimize the `refs_verify_refnames_available` function. No
matter whether the `refnames_to_check` is sorted, it should not
change the result of `refs_verify_refnames_available` function, right? I
guess this statement may be related to optimization part. If so, I think
we should delete this line and add in the later commit.

However, I am not sure.

> +	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
> +					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
> +					     err);
> +	if (ret < 0)
> +		goto done;
> +
>  	transaction->backend_data = tx_data;
>  	transaction->state = REF_TRANSACTION_PREPARED;
>  
> @@ -1394,6 +1397,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  	string_list_clear(&affected_refnames, 0);
>  	strbuf_release(&referent);
>  	strbuf_release(&head_referent);
> +	string_list_clear(&refnames_to_check, 0);
>  
>  	return ret;
>  }
