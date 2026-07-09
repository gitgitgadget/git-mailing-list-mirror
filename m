Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C13793A6
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626863; cv=none; b=jFDZtq5sm+eE54zeklLIOvn+wHSn8PM6AGNN8jxTM08CSL1hVFMsoTDJYaqQ/Ps4s3hk6Ez9Ab1UJwjsP+RHzZJOf3m850LJJVDFBjkj5tyuOSRkYyAmJ+mp7El3JrJ1VUonhNZpmOOGtPEd22UIrm8ffuBUKShkz5rnXzn1MH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626863; c=relaxed/simple;
	bh=AjnZZS+1JANq4zbrO+zroKXA/qKgLLj2we6vOzbBGwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/WmNE7Lr14YYPnz7/jJ4RAUzoRZv5CPLkek3NoyrdfJOKT0MnnZE2/UnN59Ewq1Fq/zQdIVx0f0vdTOJuNkf/sFXHkqQSbgwEkGhxwMmptun/4ONdWOZdHrmZ9pDJpTyIfhBVv5BbFyST1btpJjS7m6/vlHWb6Q9U5o7DTklnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRvkhQh7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRvkhQh7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9f5637634so187239a34.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626861; x=1784231661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rx+8VxMcksHk4CWv3+aIkl6rPyvkse5Kw/pAFMNIUok=;
        b=cRvkhQh7E8ltAwzIBFNkYkNim31nwfDlCTWFRoWOtQugEJKZty8aTUfFx0IyiHpAt0
         k2LurMKBD3lDzA0XgCm2QbTVM6o/sQUy8GKzFNUGPKfybj+1S84PF5zmispFwQXluMdm
         aZ6SK9uyjbW+Q2GTLKrjs/LtcHxvlJkd2WgFvW6Q0BahPjukzbrL7LNIXuguMjo3c3PF
         mWJwlKDZ3z/6ELi4eX8FPHa85BBD95Pdv5HV8pRDqWON1k3WZo+VCSUMNJpCbtW8vK18
         Vn2RbV1kR491z/Nvazc2X2vgnsNF/o5R7syIRjk8rkdVRpLnf+0iPb6v6Ec43quMi0i0
         q4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626861; x=1784231661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rx+8VxMcksHk4CWv3+aIkl6rPyvkse5Kw/pAFMNIUok=;
        b=eOnlft/DpioTG/X0+t271gxqyvu+L3wfIwY0bC8I8b99fNj3TVzHDjaxV0DvsYCtrT
         5N/hHTL6da0PCmGmskBvfApZGc5pWglWVyRai3064UnTjePttR/m7I6fnt5oNQzB1piD
         1pniXqo9YLNd1c7Rl+/xpHJFO+5HDu8c+9oXdMAm6CRD1Rj/pfUDU7gDeiarYELH5FdR
         HAWDLvg073AoexKo5ARZmk59NdDFf4ODTIlfSDZQGv3e3qi8vDAILmtm1mwEOqejDVoP
         Xwf5G6CSrpypya4Owu0YGq2UegyedDTzx3Lnnt7pI2QxUbRtF2nwbhs+YwbbABOIi7Us
         1Nag==
X-Gm-Message-State: AOJu0YxTLe0p+6mNeWFBRdw8fm0JET9ej09tUGUGMm1CXzWfDg3jn3tF
	VzXcKFeNzQ0ast5JuL1PU00mw7UQxalyac/jCJyX8Uh9hvk5UASytFfnDhUbww==
X-Gm-Gg: AfdE7ckcvd+WyCEOLEsk6hNsJcX7wBYKvtxCaECwmTnssrjpOTw+gcJ4d5T0CgELfZu
	UjANmk1MYGPOf/BD37cBcQWtxd1awY9vm3mHbd/yRvUb93kuVH4YGhS+U59BLJebpdP7AvyC5oV
	fso6WS+yYMHzOU7Rj5x63sYWrREdz1KRDa8jRokshm0bp5c9ABLEuPZyfMyZt4fzelmdxSPJEnw
	LRwsH36ezvkKGdIrKcPXIRyNtTB7tCZCPrTn+mFNRiYzgWIOM4VT1d4Qnyhzb1pzznk5xz3ykEw
	/43AJ0TUEmhOyrn/3HqlojxUll7w8K87sSkzm0nNgvZp4An/9PG/LIWmJOdDo+pvTAd2OgiEOzP
	P5Qh5IpjCNCeikjCJ3iOxocvinax5b2oft0gnndYNjSFyPa2mmNL4qeYhS64OhuhQ8YH2HOGXs/
	S5BpfBZqd/wenqg8pp
X-Received: by 2002:a05:6830:81ca:b0:7e6:f172:ffd1 with SMTP id 46e09a7af769-7ebcffbdb8bmr6642836a34.23.1783626860899;
        Thu, 09 Jul 2026 12:54:20 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm4802067a34.13.2026.07.09.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:54:20 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:54:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] odb/source-packed: improve lookup when enumerating
 objects
Message-ID: <ak_uXc0UxB_9Vk9z@denethor>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-1-82fe014b12b3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-1-82fe014b12b3@pks.im>

On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> When iterating through packed objects via `odb_for_each_object()` we
> do so via two different mechanisms:
> 
>   - When a multi-pack index is available we use that one to efficiently
>     loop through all objects.
> 
>   - We then loop through all packfiles that aren't covered by a
>     multi-pack index.

To be specific, we are talking only about the for_each_object callback
for the packed source `odb_source_packed_for_each_object()` correct?
Also, this appears to only matter when we are enumerating OIDs with a
specific prefix.

> Regardless of which mechanism we use, we then iterate through all the
> objects indexed by the respective data structure. Curiously though,
> while we use the indices for enumerating the objects, we completely
> ignore it for the actual object lookup. Instead, we call into the
> generic `odb_source_read_object_info()` function, which will itself
> consult the indices to figure out where the object in question even
> lives.
> 
> This has two consequences:
> 
>   - It's inefficient, as we basically have to figure out the position of
>     the object a second time.

Since we already have the position from the index, there is no need to
start over. Makes sense.

>   - It's subtly wrong, as it may now happen that a specific object will
>     be looked up via a different pack in case it exists multiple times.

Naive question: Is there any real harm in reading the same object, but
from a different packfile here?

Regardless I do think it's a good idea to just reuse the same packfile
to get the same object here.

> Fix the issue by using `packed_object_info()` directly. While at it,
> rename the `store` variable to `source`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-packed.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 0edea5356d..9cfa02b7a2 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -143,7 +143,7 @@ static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_f
>  }
>  
>  static int for_each_prefixed_object_in_midx(
> -	struct odb_source_packed *store,
> +	struct odb_source_packed *source,
>  	struct multi_pack_index *m,
>  	const struct odb_for_each_object_options *opts,
>  	struct odb_source_packed_for_each_object_wrapper_data *data)
> @@ -170,6 +170,7 @@ static int for_each_prefixed_object_in_midx(
>  		 */
>  		for (i = first; i < num; i++) {
>  			const struct object_id *current = NULL;
> +			struct packed_git *pack;
>  			struct object_id oid;
>  
>  			current = nth_midxed_object_oid(&oid, m, i);
> @@ -177,9 +178,8 @@ static int for_each_prefixed_object_in_midx(
>  			if (!match_hash(len, opts->prefix->hash, current->hash))
>  				break;
>  
> -			if (opts->flags) {
> +			if (opts->flags || data->request) {

I'm not sure I follow why the above condition needed to change.

>  				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
> -				struct packed_git *pack;
>  
>  				if (prepare_midx_pack(m, pack_id)) {
>  					pack_errors = true;
> @@ -193,9 +193,9 @@ static int for_each_prefixed_object_in_midx(
>  
>  			if (data->request) {
>  				struct object_info oi = *data->request;
> +				off_t offset = nth_midxed_offset(m, i);
>  
> -				ret = odb_source_read_object_info(&store->base, current,
> -								  &oi, 0);
> +				ret = packed_object_info(source, pack, offset, &oi);

We not longer use the generic function to read object info. This ensures
the exact same object is read.

>  				if (ret)
>  					goto out;
>  
> @@ -219,7 +219,7 @@ static int for_each_prefixed_object_in_midx(
>  }
>  
>  static int for_each_prefixed_object_in_pack(
> -	struct odb_source_packed *store,
> +	struct odb_source_packed *source,
>  	struct packed_git *p,
>  	const struct odb_for_each_object_options *opts,
>  	struct odb_source_packed_for_each_object_wrapper_data *data)
> @@ -246,8 +246,9 @@ static int for_each_prefixed_object_in_pack(
>  
>  		if (data->request) {
>  			struct object_info oi = *data->request;
> +			off_t offset = nth_packed_object_offset(p, i);
>  
> -			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
> +			ret = packed_object_info(source, p, offset, &oi);

And we do the same thing here when reading the object from a packfile.

-Justin
