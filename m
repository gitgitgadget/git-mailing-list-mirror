Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE402E3385
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626629; cv=none; b=WMD7XrjNw4oXND/FSGx4+LqA6XNO2SaOvGHqQt0fumiRsFTUOHqc8SpooF1OVABUQPxmrlVf8GIvnektYnCq9w/Aw5TS/opSFGU29bAQni++Af7NY+XtVbmK59G1E7GdQ8JXpMtY1bOQ5m2icay9Hsn8ASU7EvSYdz5qP9VHn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626629; c=relaxed/simple;
	bh=x/7PYgD5o4VPoV9z8fGx9UCoHOp62UOewtUWNDty65U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9gu9E7ROkqIIPLFQRFZBAVwUfUIsc7FIZbjgiWR+vb6OHq+N6FKCb9idrYOdt0sZbuMSbi3KeN0g5kgzm4jWycwz6wfkWbwDU0ze2wb/aCgZ+D6ThW/K1hM0RrHa3sj3GR3dQm+lYyNjuJo5ofR2bT39iUC5Mjae6fHieQF2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbLviqjb; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbLviqjb"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fea67e64caso126028b6e.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743626627; x=1744231427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Geo2nXIQuhVxkw4wjNzm7J/w0SYhv7CM82tnSSKc67Y=;
        b=hbLviqjb6NCZO4jm+hT72vQ9FqSorJsUnzaNYEWelznx8yGt6/u2FJ+30ZHAbhx/Uo
         w/2l+LGW/amA533KFAE29Dm4anxrKbsv1o8SQC6SskYYPiywsO22zKp2wRatGdIJAgOM
         ZilyuKJOz9Jd+CbU7vLE8fQ+qRWaO3p+nhpSYk6+2bd6fS/Jve6M4KfzhDkxYjKEK42Y
         QDKauF89tGouXUs0mGUG+SYDSJBQS8XvxOJP8D+wnZQHJVqZn4wJi3wVIACkp65Xtz4B
         Hg0DP2VnEtpKUdjVV1A0FuX38siJfWYrTI0+wCLjMi/7mLd2UtBM/Sm3XOr5uvDLr1dl
         LhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743626627; x=1744231427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Geo2nXIQuhVxkw4wjNzm7J/w0SYhv7CM82tnSSKc67Y=;
        b=eE2U5urq3V/vqnw3rdejmYpc8PDIWqkSKtZfYJkBTg/lbnx+IiKEDfFj5ngK2Trsvw
         vuADhXMW3dczeF7kGXYtYU++hU/J3UYSk7JuovxZ1cwN+XAPYAaVrd7iEYqD7H8Uqlbw
         pfcXIaQe+ZABu7xjbBOr5cnnDcS06sTxS1ieXqTskgHMTiU6p9cBsj/+cgQM4kswh6mU
         K7jBhO5Rm3OKljG4SKUPOpeb7WUobuiH7yer5+ftQoH/BZXkNvxb2pqLKY+sVlHmRTyC
         qSmRsdyIdFGcp1hHO+iw4AknFlNXit8ZNoqWAzGJr9LzpdJPJTvBrVVt65jJzPT/hAXR
         +VXQ==
X-Gm-Message-State: AOJu0Yx2nXLOXCgueaq/cC1PjDAv1zwYI+G3DySUHRVUJZfshWK1CExL
	D39luJ9TLuf9n/vq5IBYy26E1eme5+O8IzSoGmqfJL1/dEvkceUiXKNxBA==
X-Gm-Gg: ASbGnct668f2e25kHhY//xMN/GsYpOUw0Ic6tljP3Ba7KWqsntYTg/JUdB/Uq3wiRCB
	u1P3uAUNNvUjJv5bgUEUainIUTplMWeEwD1rfLJYa5NE6rKrMVQjl4Y0RfWryubDtbDX9eXZmPO
	Plvr6MrXXFZ93eooUR8NlTM5LS5EJKevn/N8Uk6SKDQFwJ3tEmothy5IisaFwvgtOGwN2A27vSb
	8+hwXb+cqIGUCr6dY8gRMKHY1mJe7p3ahObBdtKFYIZSpahovJWiGaZ+gXiLzkNBpYqUUG/ShnS
	XQp5GubHZDRv9VVYX4t3kVBsHXlCzumbjmu4JQ==
X-Google-Smtp-Source: AGHT+IHzBgIzkHUfdUlALeEPQDWyr8qQzJdfJSM3WSXXCmcpBIj5mLgEIXRUEu0wNTWEzm9ofenGxQ==
X-Received: by 2002:a05:6808:11d0:b0:3fe:b0ad:f927 with SMTP id 5614622812f47-3ff0f55d352mr10672485b6e.16.1743626626547;
        Wed, 02 Apr 2025 13:43:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3ff05295307sm2460429b6e.45.2025.04.02.13.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:43:45 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:39:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/16] reftable/block: rename `block_reader` to
 `reftable_block`
Message-ID: <y47rmb3ahghwvhdukfj27fihddmg57rqpfcqmaylfejqjjxvrr@luc7xuu5qiza>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-7-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-7-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The `block_reader` structure is used to access parsed data of a reftable
> block. The structure is currently treated as an internal implementation
> detail and not exposed via our public interfaces. The functionality
> provided by the structure is useful to external users of the reftable
> library though, for example when implementing consistency checks that
> need to scan through the blocks manually.
> 
> Rename the structure to `reftable_block` now that the name has been made
> available in the preceding commit. This name is in line with the naming
> schema used for other data structures like `reftable_table` in that it
> describes the underlying entity that it provides access to.
> 
> The new data structure isn't yet exposed via the public interface, which
> is left for a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                | 142 ++++++++++++++++++++--------------------
>  reftable/block.h                |  29 ++++----
>  reftable/iter.c                 |   9 ++-
>  reftable/iter.h                 |   2 +-
>  reftable/table.c                |  46 ++++++-------
>  reftable/table.h                |   8 ++-
>  t/unit-tests/t-reftable-block.c | 102 ++++++++++++++---------------
>  7 files changed, 172 insertions(+), 166 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index ad162ecdbf6..d188665388d 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -222,10 +222,10 @@ static int read_block(struct reftable_block_source *source,
>  	return block_source_read_data(source, dest, off, sz);
>  }
>  
> -int block_reader_init(struct block_reader *br,
> -		      struct reftable_block_source *source,
> -		      uint32_t offset, uint32_t header_size,
> -		      uint32_t table_block_size, uint32_t hash_size)
> +int reftable_block_init(struct reftable_block *block,
> +			struct reftable_block_source *source,
> +			uint32_t offset, uint32_t header_size,
> +			uint32_t table_block_size, uint32_t hash_size)
>  {
>  	uint32_t guess_block_size = table_block_size ?
>  		table_block_size : DEFAULT_BLOCK_SIZE;
> @@ -236,19 +236,19 @@ int block_reader_init(struct block_reader *br,
>  	uint8_t block_type;
>  	int err;
>  
> -	err = read_block(source, &br->block, offset, guess_block_size);
> +	err = read_block(source, &block->block, offset, guess_block_size);
>  	if (err < 0)
>  		goto done;
>  
> -	block_type = br->block.data[header_size];
> +	block_type = block->block.data[header_size];

Ah, in the previous patch I suggested renaming the `block` field to
`data`, but I guess that would lead to `block->data.data` here and would
also be a bit funny. It's probably fine to just leave it as-is then.

The rest of this patch is just a refactor to rename types from
`block_reader` to `reftable_block` and associated variable names to
match which all looks correct.

-Justin
