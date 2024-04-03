Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7C17997
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120039; cv=none; b=Nj5FOG36FniYNxeeZKzHsOENYExSPg0ZIhByouMQfGWKH0z+PLU2SOngNWrPfPT0Jl+xfCB7dspidP2+wgPWRraQa3hJwS3z7Fp0zNzRaeBpqE9vaOngABAYCX4giLhUMmQ45JLLMIdiwOu9PYVkJt4VDFTr7vNm3IOYTJCadso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120039; c=relaxed/simple;
	bh=348DkX0Sh3Yv+tIhunseIfZ0SbRQSD5i0WtY0+anDHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMKvJEVHqzeRV73Zqsz2PwX0KkBpaH2+N29gVJPszaY+e+NZpRiaJq5t/VVcbbxXDvU+6P3+mbitzE0V6+VdvSlfFwkuMJqyLCNGGMHzDHZdgxFMrDr0J5hiJe3k7XfRZ3HXv2f7Y6KA2vUNvLoJtq0EdCj3EKrBcfe/e/T4vWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY/wjLt3; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY/wjLt3"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a7a4119d02so2032674eaf.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 21:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712120037; x=1712724837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YjnfbxbfZUXV5Vkuq4fiD4p0ZBFxSq3eCZIhN91RsE=;
        b=KY/wjLt3JzV8zP0/PqaoJdlX1gBxqAXJWv/zGjHx/0dSb9e4DW8TWMZYsp4Ilb0yKT
         eMPsDCzWvFkBF8oGIR7DIBsSD1Mp5wCaeq/kUTko8w8t9AnFJ160vusKwVtF2HPjqHzD
         a7M7+DbNTR0wjtsf+FLI8o+OwWchCUEDGfhd5Y2zhzaeq020Fa0UdNwhxLwPg9pcW4rP
         W3upuPV9L5y5JFPw5N1KEk4wFP7pCGF9oD1TDHdaRp6CL+fn9EWjtZB7SpgrBGgnnBWM
         LnKNS3qQ8xV/96i1P0dJ40KCgz5ziBO1Qw37szZni//eCUxusQRMKP8eMU4SsHknC7Yk
         kIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712120037; x=1712724837;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YjnfbxbfZUXV5Vkuq4fiD4p0ZBFxSq3eCZIhN91RsE=;
        b=oS9WkNfxRaoodUVdroz7gsDgjyn7gk2LUs+vzxDJcLZZbE5gtpl6p1xm412K0b2bta
         z3/GkMUGj8o2nE/UNs+b2Tlfq7LJwWP9VqHPNO5olbc0OQdeup3+U4ddjBW+cpwXJLsP
         Ok6ET37xd8Toqf5y+vttsufKngZ4xCqr0Kh7hrzwy6grNlCM1whTB4y58tX0PpGkBxjA
         1IekILitAKZneFy1zyVAvw5YuuKT0K4Oov5I5eo1uFYFqwJvbGy9LIxSW3vSFztehGHd
         rK2H5U19OklPxBh8CdicxVsZyS75b7cxJ6mBu3bBCtdU8u+auW6Z3hO3gaMGbGtSsCNH
         A4Sg==
X-Gm-Message-State: AOJu0Yw0dXs6YPIwZ20lG9B2UkmMz2YI5wf61CXO30xp13VDoGooWafU
	k2ctJN1knpE+ZBGce6CCAhhli3U35IyLdSmdJtUVuFzsp2Wy5goAloBSIcXW
X-Google-Smtp-Source: AGHT+IECs3L+Z2iwpW6NlxVjr05TLmLW1VP87BEoEZOv783ScAEWGGhvJbaA8NJ9kzGIwpV7jCsXyg==
X-Received: by 2002:a05:6820:270a:b0:5a5:2105:f209 with SMTP id db10-20020a056820270a00b005a52105f209mr15306144oob.6.1712120036919;
        Tue, 02 Apr 2024 21:53:56 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm3067414oob.7.2024.04.02.21.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 21:53:56 -0700 (PDT)
Date: Tue, 2 Apr 2024 23:52:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/9] reftable/block: move ownership of block reader into
 `struct table_iter`
Message-ID: <hwfkdfilniy46usnc3vnksaphdxboi5bxep4ek7aj2qxfhu332@6ym7dnn35k7z>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711519925.git.ps@pks.im>
 <f10882a0840a77f2569cf891374b70d1e84ceb4b.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10882a0840a77f2569cf891374b70d1e84ceb4b.1711519925.git.ps@pks.im>

On 24/03/27 07:37AM, Patrick Steinhardt wrote:
> The table iterator allows the caller to iterate through all records in a
> reftable table. To do so it iterates through all blocks of the desired
> type one by one, where for each block it creates a new block iterator
> and yields all its entries.
> 
> One of the things that is somewhat confusing in this context is who owns
> the block reader that is being used to read the blocks and pass them to
> the block iterator. Intuitively, as the table iterator is responsible
> for iterating through the blocks, one would assume that this iterator is
> also responsible for managing the lifecycle of the reader. And while it
> somewhat is, the block reader is ultimately stored inside of the block
> iterator.
> 
> Refactor the code such that the block reader is instead fully managed by
> the table iterator. Instead of passing the reader to the block iterator,
> we now only end up passing the block data to it. Despite clearing up the
> lifecycle of the reader, it will also allow for better reuse of the
> reader in subsequent patches.
> 
> The following benchmark prints a single matching ref out of 1 million
> refs. Before:
> 
>   HEAP SUMMARY:
>       in use at exit: 13,603 bytes in 125 blocks
>     total heap usage: 6,607 allocs, 6,482 frees, 509,635 bytes allocated
> 
> After:
> 
>   HEAP SUMMARY:
>       in use at exit: 13,603 bytes in 125 blocks
>     total heap usage: 7,235 allocs, 7,110 frees, 301,481 bytes allocated
> 
> Note that while there are more allocation and free calls now, the
> overall number of bytes allocated is significantly lower. The number of
> allocations will be reduced significantly by the next patch though.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
> @@ -340,14 +344,14 @@ void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
>  int block_iter_next(struct block_iter *it, struct reftable_record *rec)
>  {
>  	struct string_view in = {
> -		.buf = it->br->block.data + it->next_off,
> -		.len = it->br->block_len - it->next_off,
> +		.buf = (unsigned char *) it->block + it->next_off,

Would it be best to use the `uint8_t *` type instead of `unsigned char *`
to match `string_view.buf`? Not sure if it matters in this case.

> +		.len = it->block_len - it->next_off,
>  	};
...  
> diff --git a/reftable/block.h b/reftable/block.h
> index 601a1e0e89..b41efa5042 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -84,16 +84,18 @@ int block_reader_init(struct block_reader *br, struct reftable_block *bl,
>  void block_reader_release(struct block_reader *br);
>  
>  /* Returns the block type (eg. 'r' for refs) */
> -uint8_t block_reader_type(struct block_reader *r);
> +uint8_t block_reader_type(const struct block_reader *r);
>  
>  /* Decodes the first key in the block */
> -int block_reader_first_key(struct block_reader *br, struct strbuf *key);
> +int block_reader_first_key(const struct block_reader *br, struct strbuf *key);
>  
>  /* Iterate over entries in a block */
>  struct block_iter {
>  	/* offset within the block of the next entry to read. */
>  	uint32_t next_off;
> -	struct block_reader *br;
> +	const unsigned char *block;

Same question here. Would it be better to use `uint8_t *`? Or does it not
really matter?

> +	size_t block_len;
> +	int hash_size;
>  
>  	/* key for last entry we read. */
>  	struct strbuf last_key;
> @@ -106,17 +108,22 @@ struct block_iter {
>  }
>  
>  /* Position `it` at start of the block */
> -void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
> +void block_iter_seek_start(struct block_iter *it, const struct block_reader *br);
>  
>  /* Position `it` to the `want` key in the block */
> -int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
> +int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
>  			struct strbuf *want);
>  
> -void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
> +void block_iter_copy_from(struct block_iter *dest, const struct block_iter *src);
>  
>  /* return < 0 for error, 0 for OK, > 0 for EOF. */
>  int block_iter_next(struct block_iter *it, struct reftable_record *rec);
>  
> +/*
> + * Reset the block iterator to pristine state without releasing its memory.
> + */

Do we want to make the comment a single line to match the other adjacent
examples?

> +void block_iter_reset(struct block_iter *it);
> +
>  /* deallocate memory for `it`. The block reader and its block is left intact. */
>  void block_iter_close(struct block_iter *it);
>  
...

-Justin
