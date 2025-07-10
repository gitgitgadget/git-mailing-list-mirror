Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96772C08CE
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187275; cv=none; b=iaBsbtmaKUflav5o92tWAdtUK+yIoXPm7hDQH15TJAYzEnFbdudmaXPg+owhOzMmr/4nt+H12/l9F+UqTR8SB++Hp3V7Pf7vVOcIt5Ktd3oa8b4fISc7q3acTBrdZNuz2ZSgtjxRVsfYscZUfK85ht3dPletFKiXgVeJLyaaAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187275; c=relaxed/simple;
	bh=4vNJC+KdQ371u9BGWnKUNmHtHIeJe4S4g52M8VH7K3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPNS5e7iKOTLK4bCvweFjqWPFi1AsBnKN5qeFn9ZR3ysoS24sRB4fJH0h+UGkX7KlXAvzWvFWuJCKluFA4T46R43Yvbk9Xo6CwDbE5cLM73Z5kPD+Jh0Mxs46nNdhM2UtCG32QEjhM9DK2k8iMKjdCK+Td6k2Dr6mqM51gyfZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP5difu7; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP5difu7"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ef60dbaefbso929670fac.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752187271; x=1752792071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LAnExpuDvMeJpoEnHpRhZg0OZdEPPV6lHSsaomJdN0=;
        b=EP5difu7+LS2c/R9gJa0M3r0mNU8aDVSwcNgv9DbZUY+ZfF23fAK6LwBQ4LkpaMroT
         ojkr+aqTV3ARVOks0qgv8rBo6iFGo0EBqoV7BIoSKvLzAfR/eXe+49rybn1uhpKPwnuS
         oJzUmf4yGh2jC3lgPDNJBe8vjg8ozdi/7/awFJdzXKtk1ngH6pGXBB3r4k9u1jtxs21z
         QPRZozQ7CP5fi5QKm3p+EumPzzR+dLLiwwJFdZJzJNLYVMs98vzHpImh444o1CN1EHrO
         qB42zb9t5+YSKpQ1TXJgGu4DUVblURyvUB2KkFbyT5iJauS0JOXtNzTHCV2ccmO5cF+M
         3Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187271; x=1752792071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LAnExpuDvMeJpoEnHpRhZg0OZdEPPV6lHSsaomJdN0=;
        b=kqDxIY1qGM8E0FefXm5NqqNQs3IDr8dvpAD0Gjj/dHPmaEuWCW2sh49t0wM/OhTGK4
         FBQNG6C67WXGGeACFkaGSWutmRvdCVRrutI2bHNcjzMame7W3avSlsV1WcGE7Yhv2NZP
         r1cKUsE2Ib5PgPoZ9zstAkgpsVx6XfHKkETT0b3PbwJoB5WEi1AxxGWHAo+H929UdYgB
         wMLEvNsAQj5rGP01M1FPZPHs20vijhug53guj0f4LgZX1ml1g3HlWMfAzkBAPkHOLwM2
         SyQ4srkiuh+k0p7ulG/uQrXAj7LpyjHndoEqR0YKve0kdWW3804a/cAQo2BJB47L/LGP
         DGFQ==
X-Gm-Message-State: AOJu0YyVDADB3QWPIT0gzHkR8jK3+tBc5Gc0iFAxpEYBX5kBSMJlecM5
	T62n3PIJ9QC5/knenYulkXZW2wKlpWga7WxQPMk6W6eO74ryWkdaNW/n
X-Gm-Gg: ASbGncshn4zPYMKSaXYkf3UkmYU2pwHrOuPcwHJPF58BDNihyB4bCtRPsaFk01S77Ak
	zPl4BKYm9TvJV4d0qNVvtjr8oQ6QVMsJP27rWd+RU7cLSnA/KyXNaL0xf1zxZtJpsq/H4xIe0GF
	11Zuie7y/C7raTtZ4z5RvLx2cF9029TLXp87HNFYRxBKgsKGuCYHIka4w1eH0jtzN3//R1xb7Tf
	IKFQbjqwnCgCrTxfNh0ZRULw3GxZQaWgJK96IHDFfhpGcGl1fBPFNJ3YPtv2kLhZouqkH53tgNo
	UrFUCO7VrX4Y1sKo8/xsJkVxqnE2cP+m4I9dvK1yk+13nD5Wbs9X0ckExJ0PLgfcD8biJC9xhPf
	cFweHtYvKP45aIY8=
X-Google-Smtp-Source: AGHT+IFbl5OD+wRn3sXQdB/bXDmi8iczDh8lN0EXK/7o/jhHhHH/zrk9hytKReDkYakGo16hjMIciQ==
X-Received: by 2002:a05:6870:7889:b0:2d6:2a40:fb9d with SMTP id 586e51a60fabf-2ff2698443amr796462fac.28.1752187270750;
        Thu, 10 Jul 2025 15:41:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12b62e8sm357023a34.60.2025.07.10.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:41:10 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:35:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] packfile: refactor `get_multi_pack_index()` to work
 on sources
Message-ID: <5ordhipbyhkkwx64jfr26ojirs77tumowxy6g5yhibo6ylb4uv@v6wwpjnqomcv>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-5-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> The function `get_multi_pack_index()` loads multi-pack indices via
> `prepare_packed_git()` and then returns the linked list of multi-pack
> indices that is stored in `struct object_database`. That list is in the
> process of being removed though in favor of storing the MIDX as part of
> the object database source it belongs to.
> 
> Refactor `get_multi_pack_index()` so that it returns the multi-pack
> index for a single object source. Callers are now expected to call this
> function for each source they are interested in. This requires them to
> iterate through alternates, so we have to prepare alternate object
> sources before doing so.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c |  9 ++++++---
>  builtin/repack.c       |  4 ++--
>  midx-write.c           | 22 ++--------------------
>  object-name.c          | 21 ++++++++++++++-------
>  pack-bitmap.c          | 20 ++++++++++++++------
>  packfile.c             | 30 +++++++++++-------------------
>  packfile.h             |  3 +--
>  7 files changed, 50 insertions(+), 59 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5781dec9808..f889e69e07d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1701,7 +1701,6 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  {
>  	int want;
>  	struct list_head *pos;
> -	struct multi_pack_index *m;
>  
>  	if (!exclude && local && has_loose_object_nonlocal(oid))
>  		return 0;
> @@ -1721,9 +1720,13 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  		*found_offset = 0;
>  	}
>  
> -	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
> +	odb_prepare_alternates(the_repository->objects);

Previously this explicit call to `odb_prepare_alternates()` was not
necessary because it was done when `prepare_packed_git()` was invoked.
Now that we iterate though the sources upfront to call
`get_multi_pack_index()` on, we need to prepare those sources first.
Makes sense.

> +
> +	for (struct odb_source *source = the_repository->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
>  		struct pack_entry e;
> -		if (fill_midx_entry(the_repository, oid, &e, m)) {
> +
> +		if (m && fill_midx_entry(the_repository, oid, &e, m)) {
>  			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
>  			if (want != -1)
>  				return want;
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9bbf032b6dd..5956df5d927 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -218,9 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
> +	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);
>  	strbuf_addf(&buf, "%s.pack", base_name);
> -	if (m && midx_contains_pack(m, buf.buf))
> +	if (m && m->local && midx_contains_pack(m, buf.buf))
>  		clear_midx_file(the_repository);
>  	strbuf_insertf(&buf, 0, "%s/", dir_name);
>  	unlink_pack_path(buf.buf, 1);
> diff --git a/midx-write.c b/midx-write.c
> index f2cfb85476e..c1ae62d3549 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -916,26 +916,8 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
>  static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
>  							const char *object_dir)
>  {
> -	struct multi_pack_index *result = NULL;
> -	struct multi_pack_index *cur;
> -	char *obj_dir_real = real_pathdup(object_dir, 1);
> -	struct strbuf cur_path_real = STRBUF_INIT;
> -
> -	/* Ensure the given object_dir is local, or a known alternate. */
> -	odb_find_source(r->objects, obj_dir_real);
> -
> -	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
> -		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
> -		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
> -			result = cur;
> -			goto cleanup;
> -		}
> -	}
> -
> -cleanup:
> -	free(obj_dir_real);
> -	strbuf_release(&cur_path_real);
> -	return result;
> +	struct odb_source *source = odb_find_source(r->objects, object_dir);
> +	return get_multi_pack_index(source);

Nice and simple :)

>  }
>  
>  static int fill_packs_from_midx(struct write_midx_context *ctx,
> diff --git a/object-name.c b/object-name.c
> index ddafe7f9b13..1e7fdcb90a8 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -198,16 +198,19 @@ static void unique_in_pack(struct packed_git *p,
>  
>  static void find_short_packed_object(struct disambiguate_state *ds)
>  {
> -	struct multi_pack_index *m;
>  	struct packed_git *p;
>  
>  	/* Skip, unless oids from the storage hash algorithm are wanted */
>  	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
>  		return;
>  
> -	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
> -	     m = m->next)
> -		unique_in_midx(m, ds);
> +	odb_prepare_alternates(ds->repo->objects);
> +	for (struct odb_source *source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
> +		if (m)
> +			unique_in_midx(m, ds);
> +	}
> +
>  	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
>  	     p = p->next)
>  		unique_in_pack(p, ds);
> @@ -792,11 +795,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>  
>  static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>  {
> -	struct multi_pack_index *m;
>  	struct packed_git *p;
>  
> -	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
> -		find_abbrev_len_for_midx(m, mad);
> +	odb_prepare_alternates(mad->repo->objects);
> +	for (struct odb_source *source = mad->repo->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
> +		if (m)
> +			find_abbrev_len_for_midx(m, mad);
> +	}
> +
>  	for (p = get_packed_git(mad->repo); p; p = p->next)
>  		find_abbrev_len_for_pack(p, mad);
>  }
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 0a4af199c05..7b51d381837 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -692,14 +692,16 @@ static int open_midx_bitmap(struct repository *r,
>  			    struct bitmap_index *bitmap_git)
>  {
>  	int ret = -1;
> -	struct multi_pack_index *midx;
>  
>  	assert(!bitmap_git->map);
>  
> -	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
> -		if (!open_midx_bitmap_1(bitmap_git, midx))
> +	odb_prepare_alternates(r->objects);
> +	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *midx = get_multi_pack_index(source);
> +		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
>  			ret = 0;
>  	}
> +
>  	return ret;
>  }
>  
> @@ -3307,9 +3309,15 @@ int verify_bitmap_files(struct repository *r)
>  {
>  	int res = 0;
>  
> -	for (struct multi_pack_index *m = get_multi_pack_index(r);
> -	     m; m = m->next) {
> -		char *midx_bitmap_name = midx_bitmap_filename(m);
> +	odb_prepare_alternates(r->objects);
> +	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +		struct multi_pack_index *m = get_multi_pack_index(source);
> +		char *midx_bitmap_name;
> +
> +		if (!m)
> +			continue;
> +
> +		midx_bitmap_name = midx_bitmap_filename(m);
>  		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
>  		free(midx_bitmap_name);
>  	}
> diff --git a/packfile.c b/packfile.c
> index e5d9d7ac8bc..e1ced050451 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -963,14 +963,17 @@ static void prepare_packed_git(struct repository *r);
>  unsigned long repo_approximate_object_count(struct repository *r)
>  {
>  	if (!r->objects->approximate_object_count_valid) {
> -		unsigned long count;
> -		struct multi_pack_index *m;
> +		unsigned long count = 0;
>  		struct packed_git *p;
>  
>  		prepare_packed_git(r);
> -		count = 0;
> -		for (m = get_multi_pack_index(r); m; m = m->next)
> -			count += m->num_objects;
> +
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +			struct multi_pack_index *m = get_multi_pack_index(source);
> +			if (m)
> +				count += m->num_objects;
> +		}
> +
>  		for (p = r->objects->packed_git; p; p = p->next) {
>  			if (open_pack_index(p))
>  				continue;
> @@ -1074,21 +1077,10 @@ struct packed_git *get_packed_git(struct repository *r)
>  	return r->objects->packed_git;
>  }
>  
> -struct multi_pack_index *get_multi_pack_index(struct repository *r)
> -{
> -	prepare_packed_git(r);
> -	return r->objects->multi_pack_index;
> -}
> -
> -struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
> +struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
>  {
> -	struct multi_pack_index *m = get_multi_pack_index(r);
> -
> -	/* no need to iterate; we always put the local one first (if any) */
> -	if (m && m->local)
> -		return m;
> -
> -	return NULL;
> +	prepare_packed_git(source->odb->repo);
> +	return source->multi_pack_index;

Now get_multi_pack_index() provides the MIDX for the specified source.

>  }
>  
>  struct packed_git *get_all_packs(struct repository *r)
> diff --git a/packfile.h b/packfile.h
> index 53c3b7d3b43..f16753f2a9b 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -147,8 +147,7 @@ void install_packed_git(struct repository *r, struct packed_git *pack);
>  
>  struct packed_git *get_packed_git(struct repository *r);
>  struct list_head *get_packed_git_mru(struct repository *r);
> -struct multi_pack_index *get_multi_pack_index(struct repository *r);
> -struct multi_pack_index *get_local_multi_pack_index(struct repository *r);
> +struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
>  struct packed_git *get_all_packs(struct repository *r);
>  
>  /*
> 
> -- 
> 2.50.1.327.g047016eb4a.dirty
> 
> 
