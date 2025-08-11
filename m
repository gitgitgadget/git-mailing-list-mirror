Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378422FDFF
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940893; cv=none; b=O1JVikFXobfPCM/h1OpgLl8pOIZw4pRBK7QdWQG4LWfJNVnSX7WieGoXG66MW+FEwzootU/+ET0g6B0ujAN3ixzk2szOuELuyXXr+WNWNclItQqDvLO2jquvCqVHCdo9BA0PaSlUj16dsr9z+s+uD1llTOmAViUgEbadtOspvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940893; c=relaxed/simple;
	bh=9dmlkXJFTMsasRQITBWhemkTqKVeumpJC54PJEvl7bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmr/S466PyPPN57mt2PC1vKykuM5rWWuBgJZ92v5di8LAL7pXgUaNF4sFWvWrtaw+iJu1s0wwTJpHNrpnMsu8ASsRBb4DCOoVkiN2aX2FA0Zs846ZEdJeAd4meiK6DQI2si8TFMjM8302FrjM49Uw4DifZMptPe+ILVz3iyRpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5izHaZf; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5izHaZf"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-741b8c26e70so995067a34.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754940891; x=1755545691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YOUOso467y3Sq1fm184zje3ZQJk5PfSlZRsa7Y/SqQ=;
        b=I5izHaZfBV4iO66cTCYsuo3lXbWV8GD+IWTsWkZkpCRJJpxTxaLc4AmZG1Ziax6bmU
         M1g66VH6bQ41xWr0SIyuze5btM3JlfJQLUO1MJ5OXsanJgzbo6qaedCvlEv+I8l4SFzj
         WJlfbs50DKuLSffgN302g8cCblS7Yg7CvT7iLq/KMLIBfUqfUrbO62L10IMgTLkVWgXa
         +MLaxbX+KKjRlTZO6vogMGmnM0v4s59E0hNApjvzhMU+S+D0qJld8I2KcRsHZzmWDfYY
         tpLDtZbh+vMe9SVkZeW+NsTmANjuMVuAIB6iMD4Z6jLMaF6JwVs8HT9CHB2XJZ16V7ay
         9wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940891; x=1755545691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YOUOso467y3Sq1fm184zje3ZQJk5PfSlZRsa7Y/SqQ=;
        b=pSrx63hL6ILTF9DLkBk9d3Fp25iiqbmfnjP8P7ltUtw1mzSnm5pAp+ve+/c/FAQ0ia
         54vx1UEurqplSe1Gc2dPJNGhqQeaACZfQKA3CumOFTtzIOBVaCiLDFipkfqEBqbcd7ZM
         PWS6JZmFV9hNu6MN0oodWSugXK9tj7A0C2i7QdgRHaZRPdyNrZfCgku5vK+JYnavMSHq
         0fqlEzyuxs9l976VBgNdkjssGtoD3QHvJj+P8wOL5ZbZOd1BlYhU/Twt31CY/d9VBlzA
         xTL0uV+iTiWVgvLXrUDw6cib+j85fCTIC+pWQiXGg9CVMU4aJOFUDTIFTThMuSgQWGpd
         98aA==
X-Gm-Message-State: AOJu0Yx3+5iq4H/Wewvlp6XeLMNW9HVmS0jz6gYlE7MR1jNzdlTLP8s9
	te47vA+sGPxe9J6zivTuo2DNLDCV0T3JznKqOZUukCl28fpKlTYmSbu6M2ODJODM
X-Gm-Gg: ASbGncuxBsshjeLNcvc+wTnmLl7BYMKdjvo7WQKEUvbPfFqvdByUas45CELUrp5W9RN
	bqw77soD+esX63fkQeUHIPVHjRDz8DJajA9N8Out5gzoMtt6ARoaRwol/llsO2UYfMytbHvtnEj
	7jz+S+ZCY4Qf6igXKkajCVWfxcK3llbMSko39MmOCuo30RSNVlNAe7prdcvKsUoZuNWycE6Wo2S
	6qgKMeS45qBRzxMe+23GbqP6OmyCmsDIWJLxc2h8eulxsNtNc9R4pnL+moaEOBEl4K+BF8Ydnja
	LuSNH1cz/khSH2SDMVYDmWr+CTHYdlHyE517qmNmYWryhLWxGki5kO618e8CnRfdRAuW5IWAbVD
	8PsOZrka7sRM9mwU=
X-Google-Smtp-Source: AGHT+IFv+vUDFqK7mbZtPoGuGCueldAon9pK9ZvfCxWxoKpZC3GcH3AQdW/gag5URB9NJGQQ0yLzcg==
X-Received: by 2002:a05:6830:3895:b0:73a:96e5:19cd with SMTP id 46e09a7af769-74366961349mr819725a34.10.1754940891104;
        Mon, 11 Aug 2025 12:34:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-741c298a960sm4628190a34.8.2025.08.11.12.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:34:50 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:34:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/6] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Message-ID: <6gcuu35ey34nrxtsgpelfykvgxo7vqqhgsq3obnbducmplaymv@blgaxqyp6low>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
 <20250804-pks-reftable-fixes-for-libgit2-v2-5-fef06209a984@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-5-fef06209a984@pks.im>

On 25/08/04 11:40AM, Patrick Steinhardt wrote:
> The `reftable_stack_add()` function is a simple wrapper to lock the
> stack, add records to it via a callback and then commit the
> result. One problem with it though is that it doesn't accept any flags
> for creating the addition. This makes it impossible to automatically
> reload the stack in case it was modified before we managed to lock the
> stack.
> 
> Add a `flags` field to plug this gap and pass it through accordingly.
> For now this new flag won't be used by us, but it will be used by
> libgit2.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c         |  8 +++----
>  reftable/reftable-stack.h       |  9 +++++---
>  reftable/stack.c                |  8 +++----
>  t/unit-tests/t-reftable-stack.c | 50 ++++++++++++++++++++---------------------
>  4 files changed, 39 insertions(+), 36 deletions(-)
> 
[snip]
> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 910ec6ef3a2..d70fcb705dc 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -68,12 +68,15 @@ int reftable_addition_commit(struct reftable_addition *add);
>   * transaction. Releases the lock if held. */
>  void reftable_addition_destroy(struct reftable_addition *add);
>  
> -/* add a new table to the stack. The write_table function must call
> - * reftable_writer_set_limits, add refs and return an error value. */
> +/*
> + * Add a new table to the stack. The write_table function must call
> + * reftable_writer_set_limits, add refs and return an error value.
> + * The flags are passed through to `reftable_stack_new_addition()`.
> + */
>  int reftable_stack_add(struct reftable_stack *st,
>  		       int (*write_table)(struct reftable_writer *wr,
>  					  void *write_arg),
> -		       void *write_arg);
> +		       void *write_arg, unsigned flags);
>  
>  struct reftable_iterator;
>  
> diff --git a/reftable/stack.c b/reftable/stack.c
> index d6e4ea93a37..f77d7f58e8e 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -737,10 +737,10 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  static int stack_try_add(struct reftable_stack *st,
>  			 int (*write_table)(struct reftable_writer *wr,
>  					    void *arg),
> -			 void *arg)
> +			 void *arg, unsigned flags)
>  {
>  	struct reftable_addition add = REFTABLE_ADDITION_INIT;
> -	int err = reftable_stack_init_addition(&add, st, 0);
> +	int err = reftable_stack_init_addition(&add, st, flags);

Ok, so now if the `REFTABLE_STACK_NEW_ADDITION_RELOAD` flag is provided,
reftable_stack_init_addition() will attempt to reload the stack if it is
outdated before locking the stack. I assume Git itself hasn't needed
this because it just uses reftable_stack_new_addition() directly when
neccessary.

This patch looks good.

-Justin
