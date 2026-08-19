Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2D48A2D9
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156919; cv=none; b=K7j1ljEnro+EiRh7sCTuImfnn0AoUSRbLYHmqRSCMtQA2c/YQdDwtyIQ/DajknEIFTC1i/3CXVnyuKPSTL/nrY2Y7rRXcn2357shcpxFanEoZzS+aBHp0Gah2KKPT8n8UL6dJb7Rhc9FzGld3E9CDV4PCXOYj3EY/u4aHWYaJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156919; c=relaxed/simple;
	bh=KK1jW70+80WQVL9m52X/1hCwUAU+gGVNiVthFeM4dCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6HdsCgSXYljVackswTcZLKWI6n8FFu/bCcvLhzSFbBZQgtvrZVdMXuTEgk7a3p94xjZic39Hd3ym/tCJzeLWkLALO5fFFkahagVOFaKFyDH3wRa9w41bW50uppLk3MEkdICUbiAU8oeFmR5Zrgp169FjB+tHE/exZBBgmI7m8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M71YUWju; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M71YUWju"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb61bbeb25so894660a34.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787156914; x=1787761714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fB8kmyp0enITDUL6YJS289b1FiIF7ORf3kJ+W4AjniY=;
        b=M71YUWjuScTxkMK4F1AmkkBZZ6mHHnNbg2o0xC3bzJBaL2qBR4g/0UDaVxTHDgC2E4
         5too4dmJvNAvS5vZmoA1aye7/KmLMiV4TAm92kVXbcle9d2LJX4tTKRM4WQW1TBGvAFv
         bxqnBnLq+JEy59+4qKjDe11/9lkb9lcIvsvj2yWlcp8L+y/esnrRlvhfQIF97JhONf1z
         5cGyFHR7GJqlx7Xu1e/StLfAYy3bA3LqUM865o1fDaicWzdCcNoZ6ZPr33/h8obNbWw3
         y4Kad360ngdTzU22ixRm1fwGRx7X8UuOwpZJczqI43T51c8q+I1BJ/hWU7FsP1hnsQJW
         yOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156914; x=1787761714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fB8kmyp0enITDUL6YJS289b1FiIF7ORf3kJ+W4AjniY=;
        b=d7+e1SRQwpyaQzuqyRS/4n2iqugdmek0f8uDfHK85bgznCM3r6GbF0ba//ChRCEnpO
         Y4NbJS9zxeAush08jx2qx9Zt/Ho6ozeHaWIeP+jIPh5+BjqUJVtA/5HIrx0ap2+gjHo6
         XLk33T6Ty+JgAnWUW0CY9+4AJmFCtax6fhk6s079ihmLEMiS9nglwPXg9IR2CU4Ws0NI
         S5oslPv+VAsDNo/DqQE9aYJNXic5Q31nIIMFFbW5PXHFNBAePOCZ0TUcooIITfdwGX0i
         Lwux1qKJQoaFPEckh+PD2BUC00GScRZOKXTx85185Ch1s/M7aOQtfwVSD6Lln0yQPLJN
         xpZw==
X-Gm-Message-State: AOJu0YyPmghCnAcLsTCFt0nMbuQRjTFuuxTJdoC3mgkksg/vDlWfz1Bl
	4hAF24vCSzAgZ5ykfTw1+qy9m5Jkq12qdvahAff9ZQuHWvVHys4bqT+FIuHrzQ==
X-Gm-Gg: AR+sD13U/mBX85eQfSGfTh3zbjJvejl9yiY82aCpohbmgPFPiR6QieayGLMo7aoUMuI
	QZ6JhUPcQaOJ1pjL3ob18Sxj9Ij6loP9bff5cPRm1nAqDp2CcZXkpFmftKhfkfGmKiIVxUEz6en
	jtqXkcg2FM28NWmtoglahrFkElOFKm/yhWmpaVvj38ha6lnD8EZZHNb5PHQIOUomiOoKmfpXmH9
	d4lUXFIuinePGtHFzi6ip0KINB3/LJRoC9TSsG5ET1hcmCj6OmuhY+HyU/U3FlKo2Zz4LAarLTI
	PCZSQKudNTHJMPD9hoFuzrbmOZEph8TKxBWkNXBkrveVkHKHHwItJyuSrZhVA4dT3Y3uUGwJ9di
	qEGXeBALOGOajJZH4/CM9zzWAQ6eNv32svKl0pKKkcsRCbyKYcszcYYsFuZ2wF9lVU5lR/whDYj
	ttUJki43lQGVSM1qKIS6SJv+X3V8krI4X8MTYVZ4qT/z2F7CB8sTWIUw==
X-Received: by 2002:a05:6830:4908:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7f43fb052e9mr6946228a34.16.1787156914078;
        Wed, 19 Aug 2026 09:28:34 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440056836sm2158114a34.20.2026.08.19.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:28:33 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:28:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] reftable/stack: remove
 `REFTABLE_STACK_NEW_ADDITION_RELOAD`
Message-ID: <aoXUrsAiDvgS2s6H@denethor>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>

On 26/08/19 03:19PM, Karthik Nayak wrote:
> In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
> 2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
> that callers of `reftable_stack_init_addition()` can also reload the
> stack if there was a concurrent update made before the lock was
> obtained.
> 
> Then 16684b6fae (refs/reftable: always reload stacks when creating
> lock, 2025-08-12) updated all of the remaining call-sites to propagate
> this flag to ensure that we always reload the stack whenever there was a
> concurrent update.

Ok, if all call sites already wire this flag, then we probably don't
need if anymore.

> As all calls to `reftable_stack_init_addition()` inevitably propagate
> the flag, it is safe to remove the flag and its associated code and make
> the reloading of the stack the default flow. This makes it easier to
> follow the flow and simplifies the logic.

Makes sense.

> The only exceptions are:
> 
>   1. Unit tests, where we explicitly do not propagate the flag. These
>      tests are now modified with the new status quo.

I assume this means we no longer need to test for the case where we
don't reload.

>   2. `reftable_stack_clean_locked()`, which was propagating 0 to

Did you mean `reftable_stack_clean()`?

>      `reftable_stack_new_addition()` but was then manually reloading the
>      stack after. Here the new flow will achieve the same, while also
>      allowing us to remove the manual reload.

Out of curiousity, was this call site just forgotten previously? Or was
there any reason a manual reload was useful?

> This also makes two checks for 'REFTABLE_OUTDATED_ERROR' redundant, so
> remove them also.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
[snip]
> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 5d22d84e80..5d224f8079 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -58,22 +58,13 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
>  /* holds a transaction to add tables at the top of a stack. */
>  struct reftable_addition;
>  
> -enum {
> -	/*
> -	 * Reload the stack when the stack is out-of-date after locking it.
> -	 */
> -	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
> -};

The flag is dropped now that it is the only behavior.

>  /*
>   * returns a new transaction to add reftables to the given stack. As a side
> - * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
> - * flags.
> + * effect, the ref database is locked.
>   */
>  int reftable_stack_new_addition(struct reftable_addition **dest,
>  				struct reftable_stack *st,
> -				const struct reftable_write_options *opts,
> -				unsigned int flags);
> +				const struct reftable_write_options *opts);

Signatures updated. Ok.

[snip]
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 308f9578f0..540f5e77ac 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -659,8 +659,7 @@ static void reftable_addition_close(struct reftable_addition *add)
>  
>  static int reftable_stack_init_addition(struct reftable_addition *add,
>  					struct reftable_stack *st,
> -					const struct reftable_write_options *opts,
> -					unsigned int flags)
> +					const struct reftable_write_options *opts)
>  {
>  	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
>  	int err;
> @@ -686,15 +685,11 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  	err = stack_uptodate(st);
>  	if (err < 0)
>  		goto done;
> -	if (err > 0 && flags & REFTABLE_STACK_NEW_ADDITION_RELOAD) {
> +	if (err > 0) {
>  		err = reftable_stack_reload_maybe_reuse(add->stack, 1);
>  		if (err)
>  			goto done;
>  	}
> -	if (err > 0) {
> -		err = REFTABLE_OUTDATED_ERROR;
> -		goto done;
> -	}

`reftable_stack_init_addition()` now reload unconditionally. Looks good.

>  	add->next_update_index = reftable_stack_next_update_index(st);
>  done:
> @@ -708,13 +703,12 @@ static int stack_try_add(struct reftable_stack *st,
>  			 int (*write_table)(struct reftable_writer *wr,
>  					    void *arg),
>  			 void *arg,
> -			 const struct reftable_write_options *opts,
> -			 unsigned flags)
> +			 const struct reftable_write_options *opts)
>  {
>  	struct reftable_addition add;
>  	int err;
>  
> -	err = reftable_stack_init_addition(&add, st, opts, flags);
> +	err = reftable_stack_init_addition(&add, st, opts);
>  	if (err < 0)
>  		goto done;
>  
> @@ -731,17 +725,10 @@ static int stack_try_add(struct reftable_stack *st,
>  int reftable_stack_add(struct reftable_stack *st,
>  		       int (*write)(struct reftable_writer *wr, void *arg),
>  		       void *arg,
> -		       const struct reftable_write_options *opts,
> -		       unsigned flags)
> +		       const struct reftable_write_options *opts)
>  {
> -	int err = stack_try_add(st, write, arg, opts, flags);
> +	int err = stack_try_add(st, write, arg, opts);
>  	if (err < 0) {
> -		if (err == REFTABLE_OUTDATED_ERROR) {
> -			/* Ignore error return, we want to propagate
> -			   REFTABLE_OUTDATED_ERROR.
> -			*/
> -			reftable_stack_reload(st);
> -		}

Since we always reload now, the REFTABLE_OUTDATED_ERROR is no longer a
possibility and doesn't need to be handled anymore.

[snip]
> diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
> index e6c1635940..c6254190e6 100644
> --- a/t/unit-tests/u-reftable-stack.c
> +++ b/t/unit-tests/u-reftable-stack.c
> @@ -127,7 +127,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
>  		cl_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
>  
>  		cl_assert_equal_i(reftable_stack_add(st,
> -						     &write_test_ref, &ref, &opts, 0), 0);
> +						     &write_test_ref, &ref, &opts), 0);
>  	}
>  }
>  
> @@ -168,7 +168,7 @@ void test_reftable_stack__add_one(void)
>  	err = reftable_new_stack(&st, dir, NULL);
>  	cl_assert(!err);
>  
> -	err = reftable_stack_add(st, write_test_ref, &ref, &opts, 0);
> +	err = reftable_stack_add(st, write_test_ref, &ref, &opts);
>  	cl_assert(!err);
>  
>  	err = reftable_stack_read_ref(st, ref.refname, &dest);
> @@ -231,12 +231,9 @@ void test_reftable_stack__uptodate(void)
>  	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
>  	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
>  	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref,
> -					     &ref1, NULL, 0), 0);
> +					     &ref1, NULL), 0);
>  	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
> -					     &ref2, NULL, 0), REFTABLE_OUTDATED_ERROR);
> -	cl_assert_equal_i(reftable_stack_reload(st2), 0);
> -	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
> -					     &ref2, NULL, 0), 0);
> +					     &ref2, NULL), 0);

We no longer need to check for REFTABLE_OUTDATED_ERROR since the stack
is always reloaded now. Makes sense.

>  	reftable_stack_destroy(st1);
>  	reftable_stack_destroy(st2);
>  	clear_dir(dir);
> @@ -260,7 +257,7 @@ void test_reftable_stack__transaction_api(void)
>  
>  	reftable_addition_destroy(add);
>  
> -	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL, 0), 0);
> +	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL), 0);
>  	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
>  						&ref), 0);
>  	cl_assert_equal_i(reftable_addition_commit(add), 0);
> @@ -301,21 +298,17 @@ void test_reftable_stack__transaction_with_reload(void)
>  
>  	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
>  	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
> -	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL, 0), 0);
> +	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL), 0);
>  	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
>  						&refs[0]), 0);
>  	cl_assert_equal_i(reftable_addition_commit(add), 0);
>  	reftable_addition_destroy(add);
>  
>  	/*
> -	 * The second stack is now outdated, which we should notice. We do not
> -	 * create the addition and lock the stack by default, but allow the
> -	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
> +	 * The second stack is now outdated, but it should automatically reload it
> +	 * with the newer updates.
>  	 */
> -	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL, 0),
> -						      REFTABLE_OUTDATED_ERROR);
> -	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL,
> -						      REFTABLE_STACK_NEW_ADDITION_RELOAD), 0);
> +	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL), 0);

Same here.

The rest of this patch is just updating call sites and looks good.

-Justin
