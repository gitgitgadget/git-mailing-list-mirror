Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF951F1302
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629324; cv=none; b=GixMD/2zFOWujJE8AxGMoBBClv9HSnVcpCPyX16ROFVEoGGEJdHBqYrKVW4NaPCxEEpHth6XpMCcoqEj9JH+eJ0JhfWmY3I84Bxm5XUAyxh67+Nd41MIlzvd0xGrqSaW5g6Q3R2RcF1Sl0VCXf1FZOCqN8bxk8wCh8YWrui6uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629324; c=relaxed/simple;
	bh=Mt6ERff7U6jFZrAGwzZB7F+MKVMYq7qBi9YPCKp+e/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWH+MTd9XEolBsoM/UggrxklSLlnkMjX6mj1adtx4/VIVrpUzuiYJrTKjyN4ey+7n8rj05GiemSc757iLBhgx+gKmHwnZjOcmOYPrpJ2ZHJN93wq1iMI5gg+Xe7Pw8XnUEZGxs+wQav2nOyxHfAR/5JRM+7PxQA8Y9xKhFWxDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTkJEMaP; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTkJEMaP"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fa6c54cc1aso169739b6e.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743629322; x=1744234122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcpRXXZ+jPkNw5spxCU+HOUE/uIfkCHaMV2HC7tvhgQ=;
        b=XTkJEMaP31vhgRM/Wq4EaTGZsKz3dU69XUg3Mnfnckgs3+iW2LHtdJPpILZdLOejgj
         siUj3rbi/h6soADuEwwZmTZKEqvFpBZHa3L+IcjMAmfrghV/niBDnizMJdmGyh2MoobD
         8pw3+8I07Pwcw8W1xApl30eKFvZ4OuPV8R10Fv4095Oy3h6N9S2OeKVzraANnz/NcWB9
         Lb9AVG2dMTP+kiml5qRfcTZ7aNz8lkbc2+O59hfvjhj0Ns6q8l8+9F5DvRPR/5ihFU3r
         lSF42ecsaQ/BHFGdsTXH5+Ti79EQyXtxzY1jXh7XvGx5pKKVmeFZlqQkwOSBXTqEOBe/
         Df9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743629322; x=1744234122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcpRXXZ+jPkNw5spxCU+HOUE/uIfkCHaMV2HC7tvhgQ=;
        b=SryVQnq0znIXhUlJQfrNgvARKM7deWagwgq/nKAOXkGf2Hg7C/09t4PnL2giVZLFTP
         KpAslj40+udtwe4pRaFMiR+WPqQiG4RuNTTC7xVkvJxYxcmS9QrbAGJh6IjEu510NkqK
         lZKCOODYRK75Iyk9PmpVdCs3K0CkKRfTo471a85TYqJogavAUbAlr/jf3s3iY27CSi9W
         uQjUzjhhMW7a8U5EzEpWlvNvqon0GOfe9VBltrP4qlledv34xB+4P9RANXEmd7e9Xw+d
         fy/zEr5nhISiBR7oFasRFR9RIvSBU9CcDHVaJY6h0kKsC1hPSbVaowfVlhBYtOBgkZeE
         tD0Q==
X-Gm-Message-State: AOJu0Yw2DEAd4VfVsd/OYMKjzYn9bIAaJVtqSZqJMi/TNCn2PYa8t1/H
	aUrTyzyeWvGYlAhc9UG75DxTBb3NOFg5hcLCIWmujPCyCiNSpL/etIOH7Q==
X-Gm-Gg: ASbGncv5bsetL84m9goF/ucS3nyyufJZ/kb5yYCOsxqfUtGjxln4iX13cEc4sIGbFyp
	EPhQzWNLw/Djh564aOkid7TgIsBLq3QbSCMNPtM5yFfJ297zfrfvScl1eCYMX+xHqXbONBSQPq1
	qOyaMofvKW3dDC5uf8HXzK5qhm55ucijct2s1fxb9QMOT6Y4JESqS3nUo6mRDwj6XauhZlthWP3
	wzY+QqK3udUwe6vda/sDZGWm9VVOsdiLRuM1twnsxImcC/GjAOkIxWu7mr9l6NZVCm5/9KN16ti
	fah7VfPYxg5MHiqMA6j53IVi4YErhl5vV6iZUSfOpWvOsgtt
X-Google-Smtp-Source: AGHT+IHyeKnXp+hTinNMdRn4CzwnJJ5+Efn2DSX0ApN0T1mXC8p+/HnLS0FrfEiLyBLOviwHgHKL5w==
X-Received: by 2002:a05:6808:1509:b0:3f9:94c7:4a5a with SMTP id 5614622812f47-4003620f398mr2417325b6e.19.1743629321969;
        Wed, 02 Apr 2025 14:28:41 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3ff05180f3esm2520184b6e.12.2025.04.02.14.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:28:41 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:24:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/16] reftable/block: make block iterators reseekable
Message-ID: <5dbbo5wiszgx74ijinu7xkf7ptddoubkzt53sc6cg5ak357fja@x7v2kra4ny32>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-11-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-11-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> Refactor the block iterators so that initialization and seeking are
> different from one another. This makes the iterator trivially reseekable
> by storing the pointer to the block at initialization time, which we can
> then reuse on ever seek.

s/ever/every/

> This refactoring prepares the code for exposing a `reftable_iterator`
> interface for blocks in a subsequent commit. Callsites are adjusted
> accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                | 23 +++++++++++++----------
>  reftable/block.h                | 21 ++++++++++++++++-----
>  reftable/iter.c                 |  2 +-
>  reftable/table.c                | 11 +++++++----
>  t/unit-tests/t-reftable-block.c | 30 +++++++++++++++---------------
>  5 files changed, 52 insertions(+), 35 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index 576c6caf59b..6e5c1191f5f 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -381,11 +381,16 @@ static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
>  	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
>  }
>  
> -void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
> +void block_iter_init(struct block_iter *it, const struct reftable_block *block)
>  {
>  	it->block = block;
> +	block_iter_seek_start(it);
> +}
> +
> +void block_iter_seek_start(struct block_iter *it)
> +{
>  	reftable_buf_reset(&it->last_key);
> -	it->next_off = block->header_off + 4;
> +	it->next_off = it->block->header_off + 4;
>  }
>  
>  struct restart_needle_less_args {
> @@ -473,12 +478,11 @@ void block_iter_close(struct block_iter *it)
>  	reftable_buf_release(&it->scratch);
>  }
>  
> -int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
> -			struct reftable_buf *want)
> +int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)

Ah so now that we store the `reftable_block` directly as part of
`block_iter`, passing the block in `block_iter_seek_key()` becomes
redundant. Nice!

>  {
>  	struct restart_needle_less_args args = {
>  		.needle = *want,
> -		.block = block,
> +		.block = it->block,
>  	};
>  	struct reftable_record rec;
>  	int err = 0;
> @@ -496,7 +500,7 @@ int block_iter_seek_key(struct block_iter *it, const struct reftable_block *bloc
>  	 * restart point. While that works alright, we would end up scanning
>  	 * too many record.
>  	 */
> -	i = binsearch(block->restart_count, &restart_needle_less, &args);
> +	i = binsearch(it->block->restart_count, &restart_needle_less, &args);
>  	if (args.error) {
>  		err = REFTABLE_FORMAT_ERROR;
>  		goto done;
> @@ -521,12 +525,11 @@ int block_iter_seek_key(struct block_iter *it, const struct reftable_block *bloc
>  	 *     starting from the preceding restart point.
>  	 */
>  	if (i > 0)
> -		it->next_off = block_restart_offset(block, i - 1);
> +		it->next_off = block_restart_offset(it->block, i - 1);
>  	else
> -		it->next_off = block->header_off + 4;
> -	it->block = block;
> +		it->next_off = it->block->header_off + 4;
>  
> -	err = reftable_record_init(&rec, reftable_block_type(block));
> +	err = reftable_record_init(&rec, reftable_block_type(it->block));
>  	if (err < 0)
>  		goto done;
>  
> diff --git a/reftable/block.h b/reftable/block.h
> index 268d5a1e005..1bfd44f56aa 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -79,12 +79,23 @@ struct block_iter {
>  	.scratch = REFTABLE_BUF_INIT, \
>  }
>  
> -/* Position `it` at start of the block */
> -void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block);
> +/*
> + * Initialize the block iterator with the given block. The iterator will be
> + * positioned at the first record contained in the block. The block must remain
> + * valid until the end of the iterator's lifetime. It is valid to re-initialize
> + * iterators multiple times.
> + */
> +void block_iter_init(struct block_iter *it, const struct reftable_block *block);
> +
> +/* Position the initialized iterator at the first record of its block. */
> +void block_iter_seek_start(struct block_iter *it);
>  
> -/* Position `it` to the `want` key in the block */
> -int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
> -			struct reftable_buf *want);
> +/*
> + * Position the initialized iterator at the desired record key. It is not an
> + * error in case the record cannot be found. If so, a subsequent call to
> + * `block_iter_next()` will indicate that the iterator is exhausted.
> + */
> +int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want);
>  
>  /* return < 0 for error, 0 for OK, > 0 for EOF. */
>  int block_iter_next(struct block_iter *it, struct reftable_record *rec);
> diff --git a/reftable/iter.c b/reftable/iter.c
> index 74684de8f6a..7a7e8aa4d7e 100644
> --- a/reftable/iter.c
> +++ b/reftable/iter.c
> @@ -139,7 +139,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
>  		/* indexed block does not exist. */
>  		return REFTABLE_FORMAT_ERROR;
>  	}
> -	block_iter_seek_start(&it->cur, &it->block);
> +	block_iter_init(&it->cur, &it->block);
>  	return 0;
>  }
>  
> diff --git a/reftable/table.c b/reftable/table.c
> index 3f2e70caac4..5422ed6769c 100644
> --- a/reftable/table.c
> +++ b/reftable/table.c
> @@ -208,7 +208,7 @@ static int table_iter_next_block(struct table_iter *ti)
>  
>  	ti->block_off = next_block_off;
>  	ti->is_finished = 0;
> -	block_iter_seek_start(&ti->bi, &ti->block);
> +	block_iter_init(&ti->bi, &ti->block);
>  
>  	return 0;
>  }
> @@ -256,7 +256,7 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
>  
>  	ti->typ = reftable_block_type(&ti->block);
>  	ti->block_off = off;
> -	block_iter_seek_start(&ti->bi, &ti->block);
> +	block_iter_init(&ti->bi, &ti->block);
>  	ti->is_finished = 0;
>  	return 0;
>  }
> @@ -349,7 +349,8 @@ static int table_iter_seek_linear(struct table_iter *ti,
>  	 * the wanted key inside of it. If the block does not contain our key
>  	 * we know that the corresponding record does not exist.
>  	 */
> -	err = block_iter_seek_key(&ti->bi, &ti->block, &want_key);
> +	block_iter_init(&ti->bi, &ti->block);
> +	err = block_iter_seek_key(&ti->bi, &want_key);
>  	if (err < 0)
>  		goto done;
>  	err = 0;
> @@ -417,7 +418,9 @@ static int table_iter_seek_indexed(struct table_iter *ti,
>  		if (err != 0)
>  			goto done;
>  
> -		err = block_iter_seek_key(&ti->bi, &ti->block, &want_index.u.idx.last_key);
> +		block_iter_init(&ti->bi, &ti->block);
> +
> +		err = block_iter_seek_key(&ti->bi, &want_index.u.idx.last_key);
>  		if (err < 0)
>  			goto done;
>  
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> index e36ed7ac576..c4ced39a73b 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/t-reftable-block.c
> @@ -66,7 +66,8 @@ static void t_ref_block_read_write(void)
>  	block_source_from_buf(&source ,&block_data);
>  	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
>  
> -	block_iter_seek_start(&it, &block);
> +	block_iter_init(&it, &block);
> +	block_iter_seek_start(&it);

If I'm understanding correctly, `block_iter_init()` already invokes
`block_iter_seek_start()`. Why do we need to invoke
`block_iter_seek_start()` again?

>  
>  	for (i = 0; ; i++) {
>  		ret = block_iter_next(&it, &rec);
> @@ -79,10 +80,9 @@ static void t_ref_block_read_write(void)
>  	}
>  
>  	for (i = 0; i < N; i++) {
> -		block_iter_reset(&it);
>  		reftable_record_key(&recs[i], &want);
>  
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -91,7 +91,7 @@ static void t_ref_block_read_write(void)
>  		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
>  
>  		want.len--;
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -156,7 +156,8 @@ static void t_log_block_read_write(void)
>  	block_source_from_buf(&source, &block_data);
>  	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
>  
> -	block_iter_seek_start(&it, &block);
> +	block_iter_init(&it, &block);
> +	block_iter_seek_start(&it);
>  
>  	for (i = 0; ; i++) {
>  		ret = block_iter_next(&it, &rec);
> @@ -169,11 +170,10 @@ static void t_log_block_read_write(void)
>  	}
>  
>  	for (i = 0; i < N; i++) {
> -		block_iter_reset(&it);
>  		reftable_buf_reset(&want);
>  		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
>  
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -182,7 +182,7 @@ static void t_log_block_read_write(void)
>  		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
>  
>  		want.len--;
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -249,7 +249,8 @@ static void t_obj_block_read_write(void)
>  	block_source_from_buf(&source, &block_data);
>  	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
>  
> -	block_iter_seek_start(&it, &block);
> +	block_iter_init(&it, &block);
> +	block_iter_seek_start(&it);
>  
>  	for (i = 0; ; i++) {
>  		ret = block_iter_next(&it, &rec);
> @@ -262,10 +263,9 @@ static void t_obj_block_read_write(void)
>  	}
>  
>  	for (i = 0; i < N; i++) {
> -		block_iter_reset(&it);
>  		reftable_record_key(&recs[i], &want);
>  
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -334,7 +334,8 @@ static void t_index_block_read_write(void)
>  	block_source_from_buf(&source, &block_data);
>  	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
>  
> -	block_iter_seek_start(&it, &block);
> +	block_iter_init(&it, &block);
> +	block_iter_seek_start(&it);
>  
>  	for (i = 0; ; i++) {
>  		ret = block_iter_next(&it, &rec);
> @@ -347,10 +348,9 @@ static void t_index_block_read_write(void)
>  	}
>  
>  	for (i = 0; i < N; i++) {
> -		block_iter_reset(&it);
>  		reftable_record_key(&recs[i], &want);
>  
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> @@ -359,7 +359,7 @@ static void t_index_block_read_write(void)
>  		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
>  
>  		want.len--;
> -		ret = block_iter_seek_key(&it, &block, &want);
> +		ret = block_iter_seek_key(&it, &want);
>  		check_int(ret, ==, 0);
>  
>  		ret = block_iter_next(&it, &rec);
> 
> -- 
> 2.49.0.604.gff1f9ca942.dirty
> 
> 
