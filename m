Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE33191CA
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158191; cv=none; b=IPdmugOG5JsmVgj1AWbB9OzEHrzJIxue32QpuyM34ayudkHIjsmrHNbw6VsrDXwijzxZ7aJi336/v17kylxqTTy0x1MvqmUAf5Jxs9vEL0V75MD+gu3ZF7Mz4BMe7Lre7ztVzFcLR4OzKCM6huLNxTVS39P1/8W/fjLuK5npTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158191; c=relaxed/simple;
	bh=fRyntCVfEktVZnd2nPFdB3aFrXTiDRT7ssUHJKJ3+2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPFMs5WwOX/3ybcowUh1+3IfjsLEWWNCbFZsIWE65dsYUCE6aru2jBIO6Xalz508pIoXdQm1s/y+VvC26Kf6fLXl6nLgKTkELyYCSZQ1itEiNgsHgIbXUrXBimF2t7OSDGJ4X9Z7HQVj3jzz+YVw5m9WLZZFjNfKF3Otpv1Zc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhow/YPs; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhow/YPs"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b28d9537bcso84804b6e.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787158188; x=1787762988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsH0ItX35tdA6Rd2sCaYbkUeGtnwgZe9Rx6ctRdDltE=;
        b=Rhow/YPspCNzC/vxRIAxyEZGypqDGH473oiofd4uLkkL/EY8pMw3YiMO9irKti4iU0
         Zt0i7z+Vv4oaCj+86VlJyzCaBHsXp2z2ltRrZp48v7gmrsPZFs3EHlWklFbDl/zESM8q
         4YNLzkFEWFznJ7kRh8yHJFv3Z0+f9UqlCSYrZTPZdl2fSRivjOcLZ2zjQNZDMSqMVxQw
         VRh0gGgw4Ujm1foTY3kzwz74xKV6S4Sqdj9q0qksRG9Id/JJRLfIapxnXfZPbtYn4mu1
         W8bSNY2bN5iTp+xsYgcF9BIz5UxVjHWjmk9C/CMlCyl4AooEXLDejZ1Kdh1Fv+pK/jh/
         37ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158188; x=1787762988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsH0ItX35tdA6Rd2sCaYbkUeGtnwgZe9Rx6ctRdDltE=;
        b=T6H7fGsoe4zB79XoIc3lMwQB6c9C9DB5Y+/489mINkCZRx6uU3+cEDCOiuicSt5Rnp
         rJM9QWCbmJaWaYaURVThbcARkdqdVeFi3CUeGGrE0kZ/mhlpL/atAH/LALoLeJHUT/tY
         XnlZpblBCqUWQljfWLmaXF1Yfpx2zCDzc7mPwMKmq7SUqcAXa7K6Z/UDJobJNYoN3KKA
         sRJERchJ1Ovv3fdL4l/wvQMEAzhUDRHh1aMO+EPzpV5j4BuSg8kKiil1K9FeSHn8ztuW
         BSAqoDW2Hrkmvu4ZnfbPE6wqZwwcGfy99RqO+nP8+SmDV+XP7gpbjo5hGEmEyTsCny8H
         AJ9Q==
X-Gm-Message-State: AOJu0YzCyYlUuwvbQLThhs3N4XuuFFp+LT9lsVaUzil12UZWhIGNSocO
	5+vYR8B4M49QtgbMEbCP2zd0yKI0NkSnzITjy5eXoQ9DQCnncTcyhFcF
X-Gm-Gg: AR+sD13QFbH7QL1ysOQbcqkTKrnVpOc+wPY5sUIm2rZJXqHq4LiLT+34letFdeNVKiH
	H1woBEh5jVhqH5gcRCkOUYJLup6xupU0dVeV5oRe7lQmVySq04ohpj0jAyvqSUuNFmmWf5EboVl
	ZzJHEcYXKbwTeWwzVHfkJUDvHCjG/2QgDUCGtdMUzJyoAF3hHl9iLKmpeI8cDkAGqNvS6EuV4fD
	978ysRnCHJpXH7b7ZrPJkk7TCcXfSTFbJJN4Hlrg0PnLLVS7NE7PMzJp7vb5Nc9E/w8JqHqKbXQ
	ma1b7VWDAtQo95WYlau1nwclSSwlSYqWrXs+PTv6AxKRv33A6MogJQlikzy1/4i7Gj6IsSseJuH
	RkS6HsPZfGJ1msjP1IPrImUPfHtvuyvnQsGCO3YLSDCMx3/hbn/dyNrPopZYoWSYRo3m9IL/tak
	YfglCff9nxW/EQjj9EfqMCdFJ1eOe1rIMuLvIjQNAtE13YH+YcZlIlfg==
X-Received: by 2002:a05:6808:c226:b0:4b2:b057:934c with SMTP id 5614622812f47-4b2cdb56b08mr507672b6e.3.1787158188275;
        Wed, 19 Aug 2026 09:49:48 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b296129e2fsm6400772b6e.17.2026.08.19.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:49:47 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:49:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] reftable/stack: avoid reloading the stack when
 already locked
Message-ID: <aoXcvhFbUJruALIe@denethor>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>

On 26/08/19 03:19PM, Karthik Nayak wrote:
> When making modifications to the reftable stack, the stack obtains a
> lock to the list file and removes the lock after the commit phase. Since
> most operations reload the stack to ensure we have the latest state, any
> branched operation during the locked phase could trigger a state reload.
> 
> To prevent data loss due to concurrent writes, state reload is necessary
> right after obtaining the lock. But any reloads after that are just a
> no-op. Now that the struct has access to the lock file status, simply
> skip reloading if the lock is present.

Makes sense.

> Benchmarking with a fixed, non-symbolic target OID shows a modest but
> consistent ~1-2% improvement in clock time for `update-ref` across ref
> counts ranging from 2,000 to 100,000.
> 
> We can see better improvements in the number of syscall counts. On
> master, the number of calls to `newfstatat()` grows linearly with the
> number of refs created. With this patch, the number is now a constant:
> 
>   refcount   master   patch
>   --------   ------   ------
>   1,000      1,059       55
>   5,000      5,059       55
>   10,000     10,059      55
>   20,000     20,059      55
> 
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  reftable/stack.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index e449af9c03..433a611ed1 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -553,14 +553,21 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
>  
>  /*
>   * Check whether the given stack is up-to-date with what we have in memory.
> + * If skip_if_locked is set skip stack reloading if the stack is currently
> + * locked. Stack reloading must _not_ be skipped right after obtaining the
> + * lock, to check for concurrent updates which may have happened.
> + *
>   * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
>   * otherwise.
>   */
> -static int stack_uptodate(struct reftable_stack *st)
> +static int stack_uptodate(struct reftable_stack *st, int skip_if_locked)
>  {
>  	char **names = NULL;
>  	int err;
>  
> +	if (skip_if_locked && st->list_lock.fd != -1)
> +		return 0;
> +
>  	/*
>  	 * When we have cached stat information available then we use it to
>  	 * verify whether the file has been rewritten.
> @@ -623,7 +630,7 @@ static int stack_uptodate(struct reftable_stack *st)
>  
>  int reftable_stack_reload(struct reftable_stack *st)
>  {
> -	int err = stack_uptodate(st);
> +	int err = stack_uptodate(st, 1);

Ok, this appears to be the only call site where is actually want to skip
if there is a lock present. Could we instead just not invoke
`stack_uptodate()` in such cases? That way we don't have to change its
function signature and can leave all other existing call sites alone.

-Justin
