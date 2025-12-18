Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156081DED42
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019181; cv=none; b=MwBiwxQrId2JYdf5dr5bBmC4JF+U3GEvV28lM1RMyvmum7rNh/x9ZKNFe1u2vQSdsm6lx5mGL5NkbA8+H4854evacAwEgnsJdcadTKB+G6H0Duxc60s/S39JSgqQk+C+ko1/VkUNOWoV9mD+EMAI0ca19t6nKK10o0bLXHNkN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019181; c=relaxed/simple;
	bh=Z+xP/ttx/G98On64CPKGlPopvwqtvUjhffXpVy6LYBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1QEHCsQc8NrxeilM5O0H31/3Ah5qYbzvrP8aoXfQIj494T8hXuXIBFxHPnMngdYTYYc1XjhXLH9cXw7L4cnGP2josUhoPwTu6Tbsy/uK5TUT++PfQ7h/gO+eoPGIx2aJyHpu37ZtuKAQ9gfF04IvK50+1HlVonEJeNGCxHxUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL3vspR5; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL3vspR5"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ec5df386acso97994fac.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766019178; x=1766623978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4oUsS/xtpRgfSx368Q4Z3/mQpAp+wC06aCGO83W4KI=;
        b=HL3vspR5BoY+Nj8YBb9jCM8gMJiVXC3KbPVQdQ4DJoSJondOzHmF8y1wRyErT+a6V2
         z7w5UCKybECYGau8IjCtsjUmpqvtdQPklk47CGpou8coFla4I/CrTmklZq9i3eNQFv4c
         eq4cjSaqoxYhY5k2iT8Oqo7ZjdRb2OnXAwdsKK+WF6K9nso8/8IIR7h3I187mMOB6hk1
         NK6/LsVcsFPWIcrYVI9a0Aj4ZHaaVhhUNqMgPGcG/gaZh3E5TQF9PujZK+wrWPNsFGrh
         bW8SDvT8xgGmq9KKCLtLA66Uvy9T7KJJDl+lA686XmRbZKLJ+PyNXcL09nZM8W4+tUJS
         +Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019178; x=1766623978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4oUsS/xtpRgfSx368Q4Z3/mQpAp+wC06aCGO83W4KI=;
        b=JAx29BKWmaHVYPr3JtSGsmpp8e4vXCFh7orcfas3J6g8UwUNqx4mESE5XIJzO8h+M2
         gNhfYocd4xLcGAw4brgS/zRfspPciYrU42rSakK2JDubxW9Xclz1vH1MuyLjFo/98LVn
         sEfLldfk+Iw6OBkbptU6GgRlcVI6E74hG+rDsHLogYMlf0cWuzFi6JrL5R4qTbPPpfkr
         ukYInnasR7NZyNnckW/9IXofaOBS2zY+EQj8mXerBC2Xu8uOgMwvWVG/4Li+nZXDJWqg
         adABp4n9GrLFB9opOTNZj1hVFanko9Coqu5PfVwwi6RvTVH9BZcp3tbbhp+L68p/lKpZ
         v8OA==
X-Gm-Message-State: AOJu0YwcgOk4FZ90nfgcCCac/oa+SnWFoAmA+K1RFsIUmRv7Oitb/I+Q
	r4YdpKRhCZY1iPGWhRzO/zLuYS3fOBWhsehW8aVCpKVKaQcLJmsukN1GaTFsBg==
X-Gm-Gg: AY/fxX6rHB1+zmuTq717h4j0peWNlct+nHsabBfmLIbVPFW/nds6UF3x7g2dzh2X7GO
	5Gam1qjjqYhzWMRdNdsbXn4GDEcZt7ln7QPwfi8i0kMJ1WGsFkOqo43gzOkSmW6uJM1Zg67mSmG
	HbDB02kIWWMqrWQebFPSle32BmTmOFyk//VSSnhekaU1KxXhk6mCxHPl4gFu2eVqHLJuiMrAykS
	+k3GwspQz8ToXppWgGUYePRlQYtEaNmpceFZez9kRPGY+iFATjIjJE34OuEe3Zr0LcQJIWISBaq
	k4B2HEPcwXqP0OAcIAgZOOYvVstvl+AA2tVGWplWC+Vf4u8586fYHdjGllQEhZwoOI05jVQ+D/N
	1kCR6LeFsENuQMAfjbkP/npPPWtrG1oAlbJGtiYoPjaVUHTjptzVkxTw1tuJn8A6nHvYNaUSj68
	QPEKqZ
X-Google-Smtp-Source: AGHT+IF1vYvBimr7URbStQUJpjn/kL/0ug8hq9Ial0RMdEd/JUpy9e8jFfL0mAlnXXiZwoQ9v/Q4Gw==
X-Received: by 2002:a05:6871:4411:b0:3d2:5ad4:4e7 with SMTP id 586e51a60fabf-3f5f8cc3878mr8509922fac.47.1766019177557;
        Wed, 17 Dec 2025 16:52:57 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17fbf048sm640864fac.17.2025.12.17.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:52:57 -0800 (PST)
Date: Wed, 17 Dec 2025 18:52:53 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/10] packfile: move packfile store into object source
Message-ID: <coihoxu2loroo4xrlog226c6ib7hy6wfsvlbfvanhp3xksezie@buisls2ii3d5>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-5-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-5-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> The packfile store is a member of `struct object_database`, which means
> that we have a single store per database. This doesn't really make much
> sense though: each source connected to the database has its own set of
> packfiles, so there is a conceptual mismatch here. This hasn't really
> caused much of a problem in the past, but with the advent of pluggable
> object databases this is becoming more of a problem because some of the
> sources may not even use packfiles in the first place.

So since there there is only a single packfile store per ODB, this means
that all sources use the same packfile store a thus there is a single
place to find all packfiles. I suppose this means access patterns must
be changed to account for alternate sources that would now each have
there own packfile store. Overall this change sounds reasonable to me.

> Move the packfile store down by one level from the object database into
> the object database source. This ensures that each source now has its
> own packfile store, and we can eventually start to abstract it away
> entirely so that the caller doesn't even know what kind of store it
> uses.

Makes sense.

> Note that we only need to adjust a relatively small number of callers,
> way less than one might expect. This is because most callers are using
> `repo_for_each_pack()`, which handles enumeration of all packfiles that
> exist in the repository. So for now, none of these callers need to be
> adapted. The remaining callers that iterate through the packfiles
> directly and that need adjustment are those that are a bit more tangled
> with packfiles. These will be adjusted over time.
> 
> Note that this patch only moves the packfile store, and there is still a
> bunch of functions that seemingly operate on a packfile store but that
> end up iterating over all sources. These will be adjusted in subsequent
> commits.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fast-import.c  |  37 ++++++++------
>  builtin/grep.c         |   6 ++-
>  builtin/index-pack.c   |   2 +-
>  builtin/pack-objects.c |  96 +++++++++++++++++++------------------
>  http.c                 |   2 +-
>  midx.c                 |   5 +-
>  odb.c                  |  36 +++++++-------
>  odb.h                  |   6 +--
>  odb/streaming.c        |   9 ++--
>  packfile.c             | 127 +++++++++++++++++++++++++++++++------------------
>  packfile.h             |  62 ++++++++++++++++++++----
>  11 files changed, 243 insertions(+), 145 deletions(-)
> 
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 7849005ccb..b8a7757cfd 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -900,7 +900,7 @@ static void end_packfile(void)
>  		idx_name = keep_pack(create_index());
>  
>  		/* Register the packfile with core git's machinery. */
> -		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
> +		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->packfiles,
>  						 idx_name, 1);

Naive question: it looks likes we are only using the primary source's packfile
store here. Is that fine?

>  		if (!new_p)
>  			die(_("core Git rejected index %s"), idx_name);
> @@ -955,7 +955,7 @@ static int store_object(
>  	struct object_id *oidout,
>  	uintmax_t mark)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
> +	struct odb_source *source;
>  	void *out, *delta;
>  	struct object_entry *e;
>  	unsigned char hdr[96];
> @@ -979,7 +979,11 @@ static int store_object(
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[type]++;
>  		return 1;
> -	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
> +	}
> +
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
> +			continue;

Here we now iterate across each ODB source to check each of the packfile
stores to find the OID. This matches the previous behavior.

>  		e->type = type;
>  		e->pack_id = MAX_PACK_ID;
>  		e->idx.offset = 1; /* just not zero! */
> @@ -1096,10 +1100,10 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
>  
>  static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
>  	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
>  	unsigned char *in_buf = xmalloc(in_sz);
>  	unsigned char *out_buf = xmalloc(out_sz);
> +	struct odb_source *source;
>  	struct object_entry *e;
>  	struct object_id oid;
>  	unsigned long hdrlen;
> @@ -1179,24 +1183,29 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[OBJ_BLOB]++;
>  		truncate_pack(&checkpoint);
> +		goto out;
> +	}
>  
> -	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
> +			continue;

Same here. Looks good.

>  		e->type = OBJ_BLOB;
>  		e->pack_id = MAX_PACK_ID;
>  		e->idx.offset = 1; /* just not zero! */
>  		duplicate_count_by_type[OBJ_BLOB]++;
>  		truncate_pack(&checkpoint);
> -
> -	} else {
> -		e->depth = 0;
> -		e->type = OBJ_BLOB;
> -		e->pack_id = pack_id;
> -		e->idx.offset = offset;
> -		e->idx.crc32 = crc32_end(pack_file);
> -		object_count++;
> -		object_count_by_type[OBJ_BLOB]++;
> +		goto out;
>  	}
>  
> +	e->depth = 0;
> +	e->type = OBJ_BLOB;
> +	e->pack_id = pack_id;
> +	e->idx.offset = offset;
> +	e->idx.crc32 = crc32_end(pack_file);
> +	object_count++;
> +	object_count_by_type[OBJ_BLOB]++;
> +
> +out:
>  	free(in_buf);
>  	free(out_buf);
>  }
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 53cccf2d25..4855b871dd 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1213,8 +1213,12 @@ int cmd_grep(int argc,
>  		 */
>  		if (recurse_submodules)
>  			repo_read_gitmodules(the_repository, 1);
> +		/*
> +		 * Note: `packfile_store_prepare()` prepares stores from all
> +		 * sources. This will be fixed in a subsequent commit.
> +		 */
>  		if (startup_info->have_repository)
> -			packfile_store_prepare(the_repository->objects->packfiles);
> +			packfile_store_prepare(the_repository->objects->sources->packfiles);
>  
>  		start_threads(&opt);
>  	} else {
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a7e901e49c..b67fb0256c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1638,7 +1638,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  			    hash, "idx", 1);
>  
>  	if (do_fsck_object && startup_info->have_repository)
> -		packfile_store_load_pack(the_repository->objects->packfiles,
> +		packfile_store_load_pack(the_repository->objects->sources->packfiles,

Does packfile_store_load_pack() also load stores from all sources?

>  					 final_index_name, 0);
>  
>  	if (!from_stdin) {
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e86b8f387a..7fd90a9996 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1529,49 +1529,53 @@ static int want_cruft_object_mtime(struct repository *r,
>  				   const struct object_id *oid,
>  				   unsigned flags, uint32_t mtime)
>  {
> -	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
> +	struct odb_source *source;
>  
> -	for (; *cache; cache++) {
> -		struct packed_git *p = *cache;
> -		off_t ofs;
> -		uint32_t candidate_mtime;
> +	for (source = r->objects->sources; source; source = source->next) {
> +		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
>  
> -		ofs = find_pack_entry_one(oid, p);
> -		if (!ofs)
> -			continue;
> +		for (; *cache; cache++) {
> +			struct packed_git *p = *cache;
> +			off_t ofs;
> +			uint32_t candidate_mtime;
>  
> -		/*
> -		 * We have a copy of the object 'oid' in a non-cruft
> -		 * pack. We can avoid packing an additional copy
> -		 * regardless of what the existing copy's mtime is since
> -		 * it is outside of a cruft pack.
> -		 */
> -		if (!p->is_cruft)
> -			return 0;
> -
> -		/*
> -		 * If we have a copy of the object 'oid' in a cruft
> -		 * pack, then either read the cruft pack's mtime for
> -		 * that object, or, if that can't be loaded, assume the
> -		 * pack's mtime itself.
> -		 */
> -		if (!load_pack_mtimes(p)) {
> -			uint32_t pos;
> -			if (offset_to_pack_pos(p, ofs, &pos) < 0)
> +			ofs = find_pack_entry_one(oid, p);
> +			if (!ofs)
>  				continue;
> -			candidate_mtime = nth_packed_mtime(p, pos);
> -		} else {
> -			candidate_mtime = p->mtime;
> -		}
>  
> -		/*
> -		 * We have a surviving copy of the object in a cruft
> -		 * pack whose mtime is greater than or equal to the one
> -		 * we are considering. We can thus avoid packing an
> -		 * additional copy of that object.
> -		 */
> -		if (mtime <= candidate_mtime)
> -			return 0;
> +			/*
> +			 * We have a copy of the object 'oid' in a non-cruft
> +			 * pack. We can avoid packing an additional copy
> +			 * regardless of what the existing copy's mtime is since
> +			 * it is outside of a cruft pack.
> +			 */
> +			if (!p->is_cruft)
> +				return 0;
> +
> +			/*
> +			 * If we have a copy of the object 'oid' in a cruft
> +			 * pack, then either read the cruft pack's mtime for
> +			 * that object, or, if that can't be loaded, assume the
> +			 * pack's mtime itself.
> +			 */
> +			if (!load_pack_mtimes(p)) {
> +				uint32_t pos;
> +				if (offset_to_pack_pos(p, ofs, &pos) < 0)
> +					continue;
> +				candidate_mtime = nth_packed_mtime(p, pos);
> +			} else {
> +				candidate_mtime = p->mtime;
> +			}
> +
> +			/*
> +			 * We have a surviving copy of the object in a cruft
> +			 * pack whose mtime is greater than or equal to the one
> +			 * we are considering. We can thus avoid packing an
> +			 * additional copy of that object.
> +			 */
> +			if (mtime <= candidate_mtime)
> +				return 0;
> +		}

Ok, this all looks the same, but repeated for each source.

Naive question: If a the same OID were to exist in multiple ODB sources,
could this effect the behavior now that there are separate packfile
stores?

>  	}
>  
>  	return -1;
> @@ -1749,13 +1753,15 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
>  		}
>  	}
>  
> -	for (e = the_repository->objects->packfiles->packs.head; e; e = e->next) {
> -		struct packed_git *p = e->pack;
> -		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
> -		if (!exclude && want > 0)
> -			packfile_list_prepend(&the_repository->objects->packfiles->packs, p);
> -		if (want != -1)
> -			return want;
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		for (e = source->packfiles->packs.head; e; e = e->next) {
> +			struct packed_git *p = e->pack;
> +			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
> +			if (!exclude && want > 0)
> +				packfile_list_prepend(&source->packfiles->packs, p);
> +			if (want != -1)
> +				return want;
> +		}
>  	}
>  
>  	if (uri_protocols.nr) {
> diff --git a/http.c b/http.c
> index 41f850db16..7815f144de 100644
> --- a/http.c
> +++ b/http.c
> @@ -2544,7 +2544,7 @@ void http_install_packfile(struct packed_git *p,
>  			   struct packfile_list *list_to_remove_from)
>  {
>  	packfile_list_remove(list_to_remove_from, p);
> -	packfile_store_add_pack(the_repository->objects->packfiles, p);
> +	packfile_store_add_pack(the_repository->objects->sources->packfiles, p);

Here we are always adding the packfile to the primary packfile store. A
thus relies of the primary source having a packfile store. In order to
move to pluggable ODBs I suppose this is one of spots that will have to
be resolved later.

>  }
>  
>  struct http_pack_request *new_http_pack_request(
[snip]
> diff --git a/odb.h b/odb.h
> index 014cd9585a..c97b41c58c 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -51,6 +51,9 @@ struct odb_source {
>  	/* Private state for loose objects. */
>  	struct odb_source_loose *loose;
>  
> +	/* Should only be accessed directly by packfile.c and midx.c. */
> +	struct packfile_store *packfiles;

As mentioned, now the packfile store is moved to the ODB source.

-Justin
