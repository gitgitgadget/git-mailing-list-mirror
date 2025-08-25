Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D80273F9
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165378; cv=none; b=ViMeoFo5Ksfw7AZVwrGzeYF7miiUszz3SyUtFG2z5UXt4B5QMHimXnlFbCZspB/ESOc4BOWy79CgOR05s9JP/KnAZYEnZLCzXHzrKQciHrh//+3pLzu6aLvmOvxqSVF88Ya4td1Fy35KjCfT3AZYWYHdtv0PeOwmqPFX7cGn458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165378; c=relaxed/simple;
	bh=8N7l3MbeRp+s9X9xqFhn/6cQP9Hyn+KF56riWyn7fzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1P+4uvk4rlm+In9nxCk7mpvMMhNBhupodtqynu8Mz3EfXKhRvD217UrUwsV0q6eJwOAUhPyeHGCXcAXzRj/Il3fMVjOlHH5CfAzs9hq4dC1bZmGA0QGEio6YxylYWkpaylBL0rsktvrdePyKqqObIF6OWQ26/lb2o3vWcr1wis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AQlZ17Qx; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AQlZ17Qx"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432daa703so188100139f.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756165376; x=1756770176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8azPa5UbI0HUaqYYWAuggxAWE0zZfanzAa9PNb54ag=;
        b=AQlZ17QxY/Q8qN/Iqws/H62RgvJ40UhNdt0ZQpnkdgf2ZV3CUv5pNEe0F9TbM58RJR
         AikN21ikLglXQQzmEuE5fF8IfTS665uP+Uoq0DLJmGebS9eLsUw+rldiZoqDkh2VOjQt
         QdugAbmdpUWbsznQUl8p7nF/K6r+NVON6LYquvQZghLzfAbr91Mxpq2WzcZ52euI3an+
         Ay+UF2085Gt4ZkVAMtuAvqLOZeUrhm78hdHtKs0/5fn38s9tLEdFLj6XddvoLFMuba3/
         /lWauf1TnS1HNhVH9puUBVBrmPcVN74ohwer35VOp+qHtjBOWh628Pgx18FmITtxX1R1
         KNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756165376; x=1756770176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8azPa5UbI0HUaqYYWAuggxAWE0zZfanzAa9PNb54ag=;
        b=YBSWqdgr+p8rTg0rCU6Mm0dfGiu72xVPm2Qwsa9ryAMQnOuQDgHPF10VBvKb+vQgWF
         cX9+fWNXw2YSXE9tf20qvHyxsL1EkLRA6qoYzI3du/gx/TjWdl0b1NJTO6NUpkN+uYMb
         bvgSLFCGowJT/ms/sz/5zfmXBXtCN0KcU1C9SOpnmCIrqbgqsQ/DMTQuiW60NEkf0k90
         IUPbUPILcOpgoCOnSUdEXb8cTy3VJ3ax3tvKRcT61/gEDGbjJXKbafkenY3AZSmT70nM
         EWp/LJC5CvkccBqj9ECk9pA32jnme+alrkx8GGsKsHGSLnjFfMFH3VIqdOqMVQvQ6hSr
         je6A==
X-Gm-Message-State: AOJu0YxbqYy6Kzsb6lBQnsTU3MBKswVhEbe+I5UYGQVY0rrhvfv1LwQO
	BXIEyT/gOpR8PN3pZguC1pJq25A1cteTutFNL3wJibcD+Ds0Xo8eN37D4Els+iJIv3fPUshRa/R
	ulYTa
X-Gm-Gg: ASbGncvI0lFJfAofylo5LAki3nndrJ79a2cfh6zinHFPqq9x2K3D7kR06Aw852MFO0l
	WHqA7cD3J0ys82aNahB2R4s0hHnYxEESbhQEbY7+Vg5UazYKE/Bh2y5+jhLYs174G6Ql4zg0URL
	RaTtTrqTRq0FtT0H2EDW5s+JUlzQBQw3n/pCL3eu+0NJQqDD81VgzxYlmFH8epXxpW0Py9v9W9Q
	VIFRJIe0mx8d94Y301c3OujAxCMImTC34pqZSUpJJcZMMoGZMakRmbAnLotyyZLjv04GNWaj0FA
	HoeV23NVvA+SuuH7zxnK+alhlNpxDFK2yHPj5pNh7d8ThpCCSmqVFf6pybmxNLxjGRpo4zT7WZy
	pBm9ADM3Hz8LPNjOn00RQByTCTJ6zYjhXaa2qBqEuwyVKjYF+E1ngBpvN3Utn+22IUdme+U25dg
	p1mhCAt/FHlhB7IdtqcZBa4NWfdw==
X-Google-Smtp-Source: AGHT+IFW1yk/dPxD2z+Y9QNpzRcD6WIvnFggaw7ADZFAR8VNAiaZG8hnPiIOkw0q97BQAkIbMl8LqA==
X-Received: by 2002:a05:6602:2c13:b0:886:eac3:d5d with SMTP id ca18e2360f4ac-886eac30eb2mr270895339f.2.1756165375620;
        Mon, 25 Aug 2025 16:42:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886ef2be3e2sm5168739f.22.2025.08.25.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 16:42:55 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:42:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aKz0/WNu/GRYh3/W@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:00AM +0200, Patrick Steinhardt wrote:
> The object database tracks the list of packfiles it currently knows
> about. With the introduction of the `struct packfile_store` we have a
> better place to host this list though.
>
> Move the list accordingly. Extract the logic from `odb_clear()` that
> knows to close all such packfiles and move it into the new subsystem, as
> well.

Not a comment on this patch itself, but as a meta-comment, I really
appreciate you taking such an incremental approach here. The packfile
machinery is quite fragile in my experience, so breaking it up into (what
are so far) easily review-able chunks makes it much easier to build
confidence in the correctness of these changes.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c      | 11 +----------
>  odb.h      |  1 -
>  packfile.c | 47 ++++++++++++++++++++++++++++++-----------------
>  packfile.h | 15 ++++++++++++++-
>  4 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 34b70d0074..17a9135cbd 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1038,16 +1038,7 @@ void odb_clear(struct object_database *o)
>
>  	INIT_LIST_HEAD(&o->packed_git_mru);
>  	close_object_store(o);
> -
> -	/*
> -	 * `close_object_store()` only closes the packfiles, but doesn't free
> -	 * them. We thus have to do this manually.
> -	 */
> -	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
> -		next = p->next;
> -		free(p);
> -	}
> -	o->packed_git = NULL;
> +	packfile_store_free(o->packfiles);

Interesting. The movement of the for-loop here all looks correct to me.
But I think the new packfile_store is creating a new awkardness here
that we should consider.

In existing implementation, all of the ->next pointers here point to
heap locations that have already been free()'d. But that's OK, since
they aren't reachable at the moment that we do "o-packed_store = NULL".

Having a separate packfile_store changes that, since (from my reading of
the code) o->packfiles will still be non-NULL even after calling
odb_clear(), *and* those pointers will refer to free'd heap locations.

That seems like a potential footgun to me. I think that we could either:

 * Change packfile_store_free() to take in an object_database pointer,
   and NULL out the ->packs pointer after free'ing all of the packfiles.
   That would make it more similar to the existing behavior.

 * Leave packfile_store_free() as-is, document that it does NOT clear
   out the top-level pointer, and so callers are encouraged to NULL it
   out themselves after calling it. Likewise, we should change
   odb_clear() to do:

       packfile_store_free(o->packfiles);
       o->packfiles = NULL;

Let me know what you think.

>  	hashmap_clear(&o->pack_map);
>  	string_list_clear(&o->submodule_source_paths, 0);
> diff --git a/odb.h b/odb.h
> index 08c3a01f3b..6f901c5ac0 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -130,7 +130,6 @@ struct object_database {
>  	 * should only be accessed directly by packfile.c
>  	 */
>  	struct packfile_store *packfiles;
> -	struct packed_git *packed_git;

Makes sense.

>  	/* A most-recently-used ordered version of the packed_git list. */
>  	struct list_head packed_git_mru;
>
> diff --git a/packfile.c b/packfile.c
> index 8fbf1cfc2d..6478e4cc30 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
>
>  	if (current)
>  		scan_windows(current, &lru_p, &lru_w, &lru_l);
> -	for (p = current->repo->objects->packed_git; p; p = p->next)
> +	for (p = current->repo->objects->packfiles->packs; p; p = p->next)

Not a huge deal, but I do find "current->repo->objects->packfiles->packs"
to be a bit unfortunate. I wonder if we should rename "packs" to "head"
or "list_head" or similar since it's clear from
"current->repo->objects->packfiles" that this is a list of packfiles.

>  		scan_windows(p, &lru_p, &lru_w, &lru_l);
>  	if (lru_p) {
>  		munmap(lru_w->base, lru_w->len);
> @@ -362,13 +362,8 @@ void close_pack(struct packed_git *p)
>  void close_object_store(struct object_database *o)
>  {
>  	struct odb_source *source;
> -	struct packed_git *p;
>
> -	for (p = o->packed_git; p; p = p->next)
> -		if (p->do_not_close)
> -			BUG("want to close pack marked 'do-not-close'");
> -		else
> -			close_pack(p);
> +	packfile_store_close(o->packfiles);

Looks good.

> @@ -468,7 +463,7 @@ static int close_one_pack(struct repository *r)
>  	struct pack_window *mru_w = NULL;
>  	int accept_windows_inuse = 1;
>
> -	for (p = r->objects->packed_git; p; p = p->next) {
> +	for (p = r->objects->packfiles->packs; p; p = p->next) {

Likewise.

> @@ -2344,5 +2339,23 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
>
>  void packfile_store_free(struct packfile_store *store)
>  {
> +	packfile_store_close(store);

Seeing a call to packfile_store_close() here was a little surprising to
me. The code that you are moving has a comment that says:

   * `close_object_store()` only closes the packfiles, but doesn't free
   * them. We thus have to do this manually.

, so I would have expected to preserve that behavior. I *think* that
this happens to be OK, since close_pack() is a noop if it is called more
than once (though I had to double check through all of its leaf
functions that that was indeed the case).

I would probably strike this from the new function, since the sole
caller above already calls close_object_store() before calling
packfile_store_free().

> +
> +	for (struct packed_git *p = store->packs, *next; p; p = next) {
> +		next = p->next;
> +		free(p);
> +	}
> +
>  	free(store);
>  }

This part looks good.

> +void packfile_store_close(struct packfile_store *store)
> +{
> +	struct packed_git *p;
> +
> +	for (p = store->packs; p; p = p->next)
> +		if (p->do_not_close)
> +			BUG("want to close pack marked 'do-not-close'");
> +		else
> +			close_pack(p);
> +}

And likewise this looks good to me. I do find the braceless for-loop a
little hard to read, but it's (a) correct, and (b) consistent with the
original implementation, so I don't feel strongly about changing it.

As a side-note, you could inline the declaration of "p" here into the
for-loop, but I can understand not wanting to to make the diff more
readable with --color-moved.

> diff --git a/packfile.h b/packfile.h
> index 8d31fd619a..d7ac8d24b4 100644
> --- a/packfile.h
> +++ b/packfile.h

The rest looks good to me.

Thanks,
Taylor
