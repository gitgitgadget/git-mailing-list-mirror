Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F23EAC0
	for <git@vger.kernel.org>; Fri, 10 May 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368784; cv=none; b=A+9lXA8iMwSVQam4uooltBk53k3hsXVogT3PwfEPmfvyiW16CqrUTeZdW7aY/m86Uvhc5AqfmepdBQM6Qgw7aJN+d5N9Wgm8sgNxocVoIdake9Wv1np/S6VPahXaGQTMwLjPHCLZ3j461UogGnZ32ztSAdZt61jPTxPHTgnT2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368784; c=relaxed/simple;
	bh=RWOGNvT/N1OBZgT22isZUKNRORcpz9R7ed1wsHwUs+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFDiQC7URK9YnZ5ZrTs8yzFWuajV7eGXDt5URezsoI+Xk9OeDTlkUTOFrct5ecHiexztrQDyya177xxB0q4yPjCA0faptEJjD6PlcDZrj3F51uLVRfvDDe8kuOyJM4G1iETJpa+HUdqr3BJKm1EHxSxGmRPfvIckcRKi472yYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1ancmQq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1ancmQq"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23f5a31d948so1417148fac.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715368782; x=1715973582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orMGOmKTVSi6k5ObVUbKHtdYquqg8yE5St71ylpy1cw=;
        b=O1ancmQqAZjAMM991Hq+5a2VJcfsfwKwSEhBybhZ3KKWXjSomwtqdWEgPtvlIsUSUc
         mMGftfrWVbicp0ELYhavWQa0bGP9oCgxKc7XBBGiN1sKjvtcVtD9rkAcYCaKMX0qUFi+
         T6uA54oFoBDFQWWxSfBUjwfIooG1LB5k1hcTwikF/ViNEexcdbPbpi0QHfXbprJ0vGXH
         fIb+rS8L1pq406LqAFbgsqRp0wK6zYoH2B8G/1Fb6IxUH0qITqUQ8rqprYqNx8spgYD4
         pzX+3RYs8lu+RThPKuNCfsVdlcu4rIWqLWODN9q5f8q7lrj4EeLoCZyVJVTxh6StWBem
         G+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368782; x=1715973582;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orMGOmKTVSi6k5ObVUbKHtdYquqg8yE5St71ylpy1cw=;
        b=F5rcZ2kshMYW5YV8wPQulHDmXjx8lzTEAa38rmwnbOkqD0Uib3h/BiwAb4qoNYUXka
         f7TEPg+TMAAji62QQo6yvUBCTQDq0y5vs9DB9Bg09uNSHue16pXZMmU7oHPIG3n+7XON
         /5CB1YMY2jH4PiHL4deh8mOVMzjB8JdEwFrTTtKC6v3XaXi7FyqQ2B6+5Y06m6Zg3zZV
         SE7X554icdbin/AhpL3bGhXtDPW1zfywifFXF3SwrQpnCR4xPHPjgjhWcVUrAaGbh8Xm
         FGIL4/TtvcGrCGVbp9mdZMdBjKU9zKviKHdze62BK/YNReNsanYFMN5RC89WgL3K4fv4
         ZBYg==
X-Gm-Message-State: AOJu0Yz48G6zwi202fbW9IgiSevRZouhLaq95iDxl07pnA+RxA99QUFn
	3+nYjPF0OrrTV3jpHdmoIQwU/Kkec7MibrEORw5wOqlLvQtUMGCo
X-Google-Smtp-Source: AGHT+IHoiYSUk6WwEuI91q3WUyjn6x2/GNesFJfMro7aqrRnX8bctsYdJiy93X+X0IV/uchqMbMB0w==
X-Received: by 2002:a05:6870:5b97:b0:23d:4123:6041 with SMTP id 586e51a60fabf-24172e41c7bmr3969995fac.44.1715368781674;
        Fri, 10 May 2024 12:19:41 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c7d64sm957882fac.11.2024.05.10.12.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:19:40 -0700 (PDT)
Date: Fri, 10 May 2024 14:18:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] reftable/merged: split up initialization and
 seeking of records
Message-ID: <dqnhhjdingkhhwwp5nwut2hsnkkze7m2ls4kscddqxm3txjzbf@5knvdk4vc6eg>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1715166175.git.ps@pks.im>
 <21b3e3ab5f04e66fdd352187b1da699d1ab67cee.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b3e3ab5f04e66fdd352187b1da699d1ab67cee.1715166175.git.ps@pks.im>

On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> To initialize a `struct merged_iter`, we need to seek all subiterators
> to the wanted record and then add their results to the priority queue
> used to sort the records. This logic is split up across two functions,
> `merged_table_seek_record()` and `merged_table_iter()`. The scope of

Did we mean `merged_iter_init` instead of `merged_table_iter()` here?

> these functions is somewhat weird though, where `merged_table_iter()` is
> only responsible for adding the records of the subiterators to the
> priority queue.
> 
> Clarify the scope of those functions such that `merged_table_iter()` is
> only responsible for initializing the iterator's structure. Performing
> the subiterator seeks are now part of `merged_table_seek_record()`.
> 
> This step is required to move seeking of records into the generic
> `struct reftable_iterator` infrastructure.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
> @@ -246,32 +230,33 @@ static int merged_table_seek_record(struct reftable_merged_table *mt,
>  				    struct reftable_iterator *it,
>  				    struct reftable_record *rec)
>  {
> -	struct merged_iter merged = {
> -		.typ = reftable_record_type(rec),
> -		.hash_id = mt->hash_id,
> -		.suppress_deletions = mt->suppress_deletions,
> -		.advance_index = -1,
> -	};
> -	struct merged_iter *p;
> +	struct merged_iter merged, *p;
>  	int err;
>  
> -	REFTABLE_CALLOC_ARRAY(merged.subiters, mt->stack_len);
> +	merged_iter_init(&merged, mt);
> +
>  	for (size_t i = 0; i < mt->stack_len; i++) {
> +		reftable_record_init(&merged.subiters[merged.stack_len].rec,
> +				     reftable_record_type(rec));

I find it somewhat confusing how we increment the subiterator index
here. I assume this is because when a record is not found we don't want
to add it to the index. Might be nice to add a comment here explaining
this.

Edit: Looks like you address this in the next commit so I guess we are
good :)

> +
>  		err = reftable_table_seek_record(&mt->stack[i],
>  						 &merged.subiters[merged.stack_len].iter, rec);
>  		if (err < 0)
>  			goto out;
> -		if (!err)
> -			merged.stack_len++;
> -	}
> +		if (err > 0)
> +			continue;
>  
> -	err = merged_iter_init(&merged);
> -	if (err < 0)
> -		goto out;
> +		err = merged_iter_advance_subiter(&merged, merged.stack_len);
> +		if (err < 0)
> +			goto out;
> +
> +		merged.stack_len++;
> +	}
>  
> -	p = reftable_malloc(sizeof(struct merged_iter));
> +	p = reftable_malloc(sizeof(*p));
>  	*p = merged;
>  	iterator_from_merged_iter(it, p);
> +	err = 0;
>  
>  out:
>  	if (err < 0)
> -- 
> 2.45.0
> 


