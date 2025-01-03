Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEE1392
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735868971; cv=none; b=joFztTieys+AFcO9+apoMrM/ZoDTc39E54q1KWv9YhW9A3z9sPIQDPUxnLh4nfyAlbggIDabKYx/HKkYYTb9Z+cDCr91fapQVNF0vY4gtEawLphA3xhvfdtd76TxUUvCM4jbH9XyuYU3Z0hJEd64TQqmwjliT+HBbmX+c9MxDoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735868971; c=relaxed/simple;
	bh=QGXQcFM668hyJpEZl90EEGJcRUZVqN9IsPve/DjSfO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzqsQCc6Oke5uUThMeANygcUyI2KHQDUyxeQLJcmq3nuPwLdfz7Th9jTnzss8lrWeLmHv7nQeWrCs/aSnGARFBeafAGEBQmveKOKU2kyYGKu0AsjYT5zQxJUhb0BawKc+oX9gcHtLCzjkxsM4qksPlLqL8qaBzinqrWofhonETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFukyzT9; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFukyzT9"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebc678b5c9so6511261b6e.3
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 17:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735868968; x=1736473768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoAD+NzrODDSQlbGNLy29owPd5GbgoT3PQ2zUhDx+dU=;
        b=WFukyzT9sv2jY0CemY/yrwXJG4nZUVkYxamPfeSuHmb02ImUOFWI8jGLlJ+yLVQRKY
         NO2lRZvdK7pbEo3ddZiVQh+sZ4PpQaVlXUqGG9DDMlCvGxjGFqS+DfCzklbfr74SRdKk
         xufGqPhKVIPdg4PwB4wG7BUe2LMMkdqv8dCXpGiddWFVU9YNEcneikvpteYE8DUdrISf
         7iFRRwTdOmLZUIrBf9UART2Af/BLKh4QLjb8qLib67pmUO1xFrXsiExY0g/efvxS+rKd
         5bxLN7ciR2r/vq0dI6IMYQVjv3up/UDjBoddngiDb85vNaydAm+CxGvIZ51FOBMfljrw
         aVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735868968; x=1736473768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoAD+NzrODDSQlbGNLy29owPd5GbgoT3PQ2zUhDx+dU=;
        b=isfP0TjJcJPHqm1kE2zx3+4yzFWBicd3FyuyillQH4IK0q/r5Uvbic72Vm/pn6yW9n
         C1L7/Wcg2HDqeyP7KpBtBCTZTlhiosGNlDCUA0ISecTYpZAXDg4kwbzcRPOMFR0VlZbp
         QPCXkbBiz7Y7fkDjDCGZT9zt5c8/UdDY84gTJQ4qledjRaRd8DOHa8tXntvGJ/8QEKVl
         Z8x1R4U3JwRN58ayFLOnhzqQ4TBgziwNLsMw/Kq0d/HM40EAvxVcSY45jJqLbsXaj07Z
         b42ciJXzt3+2ZokfOm62NMn4wqcB96ekf08xz9f2DDhHQD+cdnelMRfP48kBZ4orkZLW
         0c7A==
X-Gm-Message-State: AOJu0YzmZZ9YZMNcOGOrAXferEuhO5PDJL1Rz/arT7UZNZiPxOU1SERG
	9usmv9977izE9Ytt4ZCHwGKMGdZ9s9PHw5CZvVVkfA6SA3TD5cuPmrE4rQ==
X-Gm-Gg: ASbGncsxNE/BrIsoS65AssG9rLPoz0EgF3kGoqYVuUezNOjh4BHpfzYLGnAROkYDDgy
	ro+pAmD/eEkEmKr05FK+vvfSug/f89PGkxBymwk8+tvf3L06dj5WBWam/il8mNMeyEeh3V8nhqk
	PTgCLiA6Ve/WQqVCoqVD79uLWe8Xolcm7EBQcS9u+lecGiYKVrsaes/PIO7W4P8c84P83K8KICy
	rbSy+QwahBNRFDk+sdAdAyAikifFyarYs5y+UfGlELReLLgJA==
X-Google-Smtp-Source: AGHT+IET5rmiP9jYu3gszUdzWl7C1Y9pTJACpEddZM6aElhz7n6v9Q61IuMVELIk2ltC2SbxAufukA==
X-Received: by 2002:a05:6808:1a17:b0:3db:1cd1:cadd with SMTP id 5614622812f47-3ed88f79308mr26924807b6e.18.1735868968611;
        Thu, 02 Jan 2025 17:49:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece24f8b0asm8094164b6e.24.2025.01.02.17.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:49:27 -0800 (PST)
Date: Thu, 2 Jan 2025 19:46:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/9] commit-reach: use `size_t` to track indices in
 `remove_redundant()`
Message-ID: <miadr6xzejrkauyoqbj2su6drnz53xd443ylvxertawa7ovuke@42bigdksj5iw>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-4-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-4-07c59c2aa632@pks.im>

On 24/12/27 11:46AM, Patrick Steinhardt wrote:
> The function `remove_redundant()` gets as input an array of commits as
> well as the size of that array and then drops redundant commits from
> that array. It then returns either `-1` in case an error occurred, or
> the new number of items in the array.
> 
> The function receives and returns these sizes with a signed integer,
> which causes several warnings with -Wsign-compare. Fix this issue by
> consistently using `size_t` to track array indices and splitting up
> the returned value into a returned error code and a separate out pointer
> for the new computed size.
> 
> Note that `get_merge_bases_many()` and related functions still track
> array sizes as a signed integer. This will be fixed in a subsequent
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-reach.c | 53 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index 9f8b2457bcc12bebf725a5276d1aec467bb7af05..d7f6f1be75e95cc834d60be719e930a77ad0518f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -212,12 +212,13 @@ int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
>  }
>  
>  static int remove_redundant_no_gen(struct repository *r,
> -				   struct commit **array, int cnt)
> +				   struct commit **array,
> +				   size_t cnt, size_t *dedup_cnt)
>  {
>  	struct commit **work;
>  	unsigned char *redundant;
> -	int *filled_index;
> -	int i, j, filled;
> +	size_t *filled_index;
> +	size_t i, j, filled;
>  
>  	CALLOC_ARRAY(work, cnt);
>  	redundant = xcalloc(cnt, 1);
> @@ -267,20 +268,22 @@ static int remove_redundant_no_gen(struct repository *r,
>  	for (i = filled = 0; i < cnt; i++)
>  		if (!redundant[i])
>  			array[filled++] = work[i];
> +	*dedup_cnt = filled;
>  	free(work);
>  	free(redundant);
>  	free(filled_index);
> -	return filled;
> +	return 0;

Previously the return value indicated either a potential error if its
value was negative or the new count otherwise. Since we now want to make
the count a `size_t` to avoid -Wsign-compare warnings, we split the two
concerns and have a separate pointer used to record the count. This
approach is used for each of the `remove_redundant*()` functions. Seems
sensible to me.

-Justin
