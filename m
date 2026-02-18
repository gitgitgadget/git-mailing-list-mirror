Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB4346770
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439187; cv=none; b=IaE21Z9GjbAUAwaaGPwsmGgeK3rBMBqtuci7awZagYpHCLvuSLXkxA3rHCQMcb2RnMcE18o8hRKxeCjzhjS2q9VH6keUbtHwQtktYIGqav/gWSpo9q0TqMcrurRma8vuVTeEXLZOtRJw8CbDyJo4+yq36dasPxK/hQmjHsWRZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439187; c=relaxed/simple;
	bh=PWbO/NLZ/Kf6ul85Nlob1poHachTelVMZVDdqgDgyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlkb5oXAo8hkHC4sBPPU0sR/YJBZKBoXuZwKBZX5fDTPBnZJ7VczUMIjPzaSuskrqm5iw7QKGo/dn9hkZAI2ubW5MBOKwdlnANFsnft+U8dKs8GVLdgyh/9lrd73rAueh0u4lcZEzgGwnkjTyBmrONALk6sDayBqoYPa32Nmwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLJBYt8k; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLJBYt8k"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463d81452abso82453b6e.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439185; x=1772043985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VoQkEtoZz8aAWbJg8NQwa0/SCFXSriNbkJ9H4VsFtGg=;
        b=fLJBYt8k75A6YsxDuFj6Ah7bKNhpSsdo/94JFJpr6O0F5VpLVlVvqgyTz1+d3NR8PH
         XIJdd9HG2oyCZdS1NNZOq6J1Bfl44K6LL8BFtqir6pV07L3X/hSbbfS+FfbsuLcpmQrJ
         rEJqTqdNKlIKsJnUtlfsY+T0Mvr0JgdwWsmJToGFJkHeq3xMcEgk+LPbUtMAKq/kJZEQ
         8k1aIzDsdTXXo1VTl9R9NEjR86X8HzKhUaFhf94BlbXgXEVgdcI2YAkcuxRwfoD36h8y
         uSRfNVnY2hICX+BlOVa4HI3fsz0akqhqD8jS1w8qSUo/R6s9cb2j3aDIFAenT0GljMY+
         pUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439185; x=1772043985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoQkEtoZz8aAWbJg8NQwa0/SCFXSriNbkJ9H4VsFtGg=;
        b=rrlRRIPanRV0JtN37TfUtESrrznQ+pZStU7I+FEVVh8HrRvuVUXynP1Q70/At1HHWf
         dHslOzbiUy5sHjBhoTgQzkGFgZTgu3thDI1yPSLxx5ca5TL7aGLYdKAbSTqM/v0J4vmd
         R5X25OE9CB2Kdn03CqCFu2PhCZUz8X+Khu3R7ZwLRQImWbN/ED73XrxynDaGLTMDnThJ
         35t3gEXHEhCRqghMkPK/gY73opyHCXzrJ4muFkIOGJFqJ79xi6GfkhpJBvFL3zzL0RqV
         xcuW4Q028ou2yxf78ZoNDL58+2eiOR1QId8LNSiyzT/thDHH+DzXo2c0LD9+WPipAdZm
         fOdQ==
X-Gm-Message-State: AOJu0Yzd8ykyhaqwUCggJlE79c2TYzKRyS8v3bl20jiyJrQpih55n2dQ
	w8ZTz72Ybv4AkeVerhbNeCsxj+/oYrwmpfkYJkyHhz398swShj8UK8eU
X-Gm-Gg: AZuq6aLyFk0JYTIj0XWBnzgFSj+cNwatr3k/bKSYAVUjb5IhYRZBnz0K1mmeeNpnq8h
	znu8535zpT97AE2oWEYBtUmsuFNslE46kCVQnKplcknXCNcVAJtOUjMw+bLi6b8brgSep/gt0k1
	2Ra3ymwy5WsOKPy9gsAHOVi1smmlTZNbAkq8utwgBtI5vTQdTJyBIP36ayjGy2sHLbx+q4rxHNC
	HRXZNIN5AsqWD4OjXwBetZpDTTkrwYQFnYcDMnw8KaOQgNFhjj5E8EpvspTWkQASMvQITaEGumB
	Ya5wBs2fk87Nndp249IOoNlfJgVsIYTG0qe2z32B6523UlSxRs7IbG0VQ9DvvBGfXLzbIL8Zp9O
	kIUei75y0vvco/a0vuoLstbDB3tD8yq5iJW/8u6EiOmTfBr5SI41zx270LBWJfqSUL0yiFB6y2a
	0mWSOFMyLMzvX3WE+v
X-Received: by 2002:a05:6820:1793:b0:674:2a5:61a8 with SMTP id 006d021491bc7-679a74724d5mr1349723eaf.74.1771439184715;
        Wed, 18 Feb 2026 10:26:24 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-678c9eec065sm9034033eaf.10.2026.02.18.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:26:24 -0800 (PST)
Date: Wed, 18 Feb 2026 12:26:21 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 1/3] commit: avoid parsing non-commits in
 `lookup_commit_reference_gently()`
Message-ID: <aZX4w8C5In9gEF33@denethor>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
 <20260216-b4-pks-receive-pack-optimize-shallow-v1-1-e98886daff2b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-1-e98886daff2b@pks.im>

On 26/02/16 04:38PM, Patrick Steinhardt wrote:
> The function `lookup_commit_reference_gently()` can be used to look up a
> committish by object ID. As such, the function knows to peel for example
> tag objects so that we eventually end up with the commit.
> 
> The function is used quite a lot throughout our tree. One such user is
> "shallow.c" via `assign_shallow_commits_to_refs()`. The intent of this
> function is to figure out whether a shallow push is missing any objects
> that are required to satisfy the ref updates, and if so, which of the
> ref updates is missing objects.
> 
> This is done by painting the tree with `UNINTERESTING`. We start
> painting by calling `refs_for_each_ref()` so that we can mark all
> existing referenced objects as the boundary of objects that we already
> have, and which are supposed to be fully connected. The reference tips
> are then parsed via `lookup_commit_reference_gently()`, and the commit
> commit is then marked as uninteresting.

s/commit commit/commit/

> But references may not necessarily point to a committish, and if a lot
> of them aren't then this step takes a lot of time. This is mostly due to
> the way that `lookup_commit_reference_gently()` is implemented: before
> we learn about the type of the object we already call `parse_object()`
> on the object ID. This has two consequences:
> 
>   - We parse all objects, including trees and blobs, even though we
>     don't even need the contents of them.
> 
>   - More importantly though, `parse_object()` will cause us to check
>     whether the object ID matches its contents.
> 
> Combined this means that we deflate and hash every non-committish
> object, and that of course ends up being both CPU- and memory-intensive.

IIUC, the `mark_uninteresting()` callback used by `refs_for_each_ref()`
is resulting in resolved/peeled object being parsed regardless of its
type. This is wasteful though because we should only care about commits.
This makes sense.

> Improve the logic so that we first use `peel_object()`. This function
> won't parse the object for us, and thus it allows us to learn about the
> object's type before we parse and return it.
> 
> The following benchmark pushes a single object from a shallow clone into
> a repository that has 100,000 refs. These refs were created by listing
> all objects via `git rev-list(1) --objects --all` and creating refs for
> a subset of them, so lots of those refs will cover non-commit objects.
> 
>   Benchmark 1: git-receive-pack (rev = HEAD~)
>     Time (mean ± σ):     62.571 s ±  0.413 s    [User: 58.331 s, System: 4.053 s]
>     Range (min … max):   62.191 s … 63.010 s    3 runs
> 
>   Benchmark 2: git-receive-pack (rev = HEAD)
>     Time (mean ± σ):     38.339 s ±  0.192 s    [User: 36.220 s, System: 1.992 s]
>     Range (min … max):   38.176 s … 38.551 s    3 runs
> 
>   Summary
>     git-receive-pack . </tmp/input (rev = HEAD) ran
>       1.63 ± 0.01 times faster than git-receive-pack . </tmp/input (rev = HEAD~)
> 
> This leads to a sizeable speedup as we now skip reading and parsing
> non-commit objects. Before this change we spent around 40% of the time
> in `assign_shallow_commits_to_refs()`, after the change we only spend
> around 1.2% of the time in there. Almost the entire remainder of the
> time is spent in git-rev-list(1) to perform the connectivity checks.

Nice!

> Despite the speedup though, this also leads to a massive reduction in
> allocations. Before:
> 
>   HEAP SUMMARY:
>       in use at exit: 352,480,441 bytes in 97,185 blocks
>     total heap usage: 2,793,820 allocs, 2,696,635 frees, 67,271,456,983 bytes allocated
> 
> And after:
> 
>   HEAP SUMMARY:
>       in use at exit: 17,524,978 bytes in 22,393 blocks
>     total heap usage: 33,313 allocs, 10,920 frees, 407,774,251 bytes allocated
> 
> Note that when all references refer to commits performance stays roughly
> the same, as expected. The following benchmark was executed with 600k
> commits:
> 
>   Benchmark 1: git-receive-pack (rev = HEAD~)
>     Time (mean ± σ):      9.101 s ±  0.006 s    [User: 8.800 s, System: 0.520 s]
>     Range (min … max):    9.095 s …  9.106 s    3 runs
> 
>   Benchmark 2: git-receive-pack (rev = HEAD)
>     Time (mean ± σ):      9.128 s ±  0.094 s    [User: 8.820 s, System: 0.522 s]
>     Range (min … max):    9.019 s …  9.188 s    3 runs
> 
>   Summary
>     git-receive-pack (rev = HEAD~) ran
>       1.00 ± 0.01 times faster than git-receive-pack (rev = HEAD)
> 
> This will be improved in the next commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit.c | 32 +++++++++++++++++++++++++++-----
>  object.c | 23 ++++++++++++++++++-----
>  object.h |  5 +++++
>  3 files changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 9bb471d217..b7c4ec2eb5 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -43,13 +43,35 @@ const char *commit_type = "commit";
>  struct commit *lookup_commit_reference_gently(struct repository *r,
>  		const struct object_id *oid, int quiet)
>  {
> -	struct object *obj = deref_tag(r,
> -				       parse_object(r, oid),
> -				       NULL, 0);

Here we drop the use of `deref_tag()` which required us to
unconfitionally parse the object.

> +	const struct object_id *maybe_peeled;
> +	struct object_id peeled_oid;
> +	struct object *object;
> +	enum object_type type;
>  
> -	if (!obj)
> +	switch (peel_object_ext(r, oid, &peeled_oid, 0, &type)) {

Here we peel the object and also get its type.

> +	case PEEL_NON_TAG:
> +		maybe_peeled = oid;
> +		break;
> +	case PEEL_PEELED:
> +		maybe_peeled = &peeled_oid;
> +		break;
> +	default:
>  		return NULL;
> -	return object_as_type(obj, OBJ_COMMIT, quiet);
> +	}
> +
> +	if (type != OBJ_COMMIT) {
> +		if (!quiet)
> +			error(_("object %s is a %s, not a %s"),
> +			      oid_to_hex(oid), type_name(type),
> +			      type_name(OBJ_COMMIT));
> +		return NULL;
> +	}
> +
> +	object = parse_object(r, maybe_peeled);
> +	if (!object)
> +		return NULL;

Now we only parse the object if it is a commit.

> +
> +	return object_as_type(object, OBJ_COMMIT, quiet);
>  }
>  
>  struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
> diff --git a/object.c b/object.c
> index 4669b8d65e..99b6df3780 100644
> --- a/object.c
> +++ b/object.c
> @@ -207,10 +207,11 @@ struct object *lookup_object_by_type(struct repository *r,
>  	}
>  }
>  
> -enum peel_status peel_object(struct repository *r,
> -			     const struct object_id *name,
> -			     struct object_id *oid,
> -			     unsigned flags)
> +enum peel_status peel_object_ext(struct repository *r,
> +				 const struct object_id *name,
> +				 struct object_id *oid,
> +				 unsigned flags,
> +				 enum object_type *typep)
>  {
>  	struct object *o = lookup_unknown_object(r, name);
>  
> @@ -220,8 +221,10 @@ enum peel_status peel_object(struct repository *r,
>  			return PEEL_INVALID;
>  	}
>  
> -	if (o->type != OBJ_TAG)
> +	if (o->type != OBJ_TAG) {
> +		*typep = o->type;
>  		return PEEL_NON_TAG;
> +	}
>  
>  	while (o && o->type == OBJ_TAG) {
>  		o = parse_object(r, &o->oid);
> @@ -241,9 +244,19 @@ enum peel_status peel_object(struct repository *r,
>  		return PEEL_INVALID;
>  
>  	oidcpy(oid, &o->oid);
> +	*typep = o->type;

Here we are modifying the existing `peel_object()` to also provide
object type info back to the caller. With this, we can avoid the
unconditional object parsing in `lookup_commit_reference_gently()`.
Looks good.

-Justin
