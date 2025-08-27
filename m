Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C17186A
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257184; cv=none; b=ZOPlGF1bxmICZad2GJWNpoPlfl81ARFSRrjlWYUNYAMXc8hdQOkRtFnNg++S2cq7Rx87TCKMv+wNjxFNe2eF2BmF3SfBk0cQ5fbEEYY5zL/k0z5tRn+asJm8Jnk6WX48BHQdvLnPSXfYsLtox5TJOE5muipgBQUzHQ1+1nbdAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257184; c=relaxed/simple;
	bh=j1lkKq7mvXlzX5FKFF/yhHOOGHKhVz/JNnHKMFGdxjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR+UX+zrEShoxAC3pML4SAwkIsrMj4vyg1nZ3KBalIgvdf5SbHtvidbrZPqJHVTRKMCXZppjGJIHf/Bij+JKq8k3fW5eyUN72h7ZzRQL/qF83e6mNbCOFKPJlys4WvsHPVk7iddtPEXBRC8I6MvbziiS6H4vM7p+m12tzw92u7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WB70aQbA; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WB70aQbA"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e9e0e38dcdso54627825ab.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756257181; x=1756861981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hq9ae5iTsvg37nL3a3OyxLRFQ6k9WlBctP/ShkovdU=;
        b=WB70aQbAWGKiXKKgnHiJhooxy+UrJnmEfRo5+JdnjMSx4ZMMKESM5bPq0hXfpDDOkt
         6qyLyk6EOIYYTD6C/O+ZCRRrmMGcLhDVW7ToI8jMsSnkFjDbWLnKGGl1iefrdkjFt7aj
         hP+AQt6lJFdYoeZqWn5hX9QDVX7+wo7xYKqQ7jjR+wbhYBlYX1MZ7o02JUT4fDOSxqu7
         3GdXSdoGcGyOKaWr8l+ZH4bznZHiNx51uNDh9Dj0+CDVh7gkLoOiYyFP/fMb5kujPuuv
         pXpxezsNfAjnckruUiVkW1cxiF8wG3VD2z1i0zvg1DGG2kaGqLaIem+L01P2r98kiYTN
         lmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257181; x=1756861981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hq9ae5iTsvg37nL3a3OyxLRFQ6k9WlBctP/ShkovdU=;
        b=Nwk8dicVv9O7sOa+6HvfxcnZPFkcsDA4EqJoFCRySzQH3SkO7CNRkfA38KsWhxTojG
         sFE/uWamOVmlg5Ph2aGRFLyBEA7+UuNyjwJ9xQnrNeLDmTZMEXLdeWdRfvV0jITdud/c
         gl495NnpKaK6TsMyMTEDthOwFSqcdcGJmkLVjZGB3khCDSvTyuOcFdu4EYmJzRB3rS8T
         Z0VdxZLh6Bd4Ip5tcrAf4rLVIehE7SAKBo7naWvhYivl4f7WoP6zpc31ja0E2qfAMbTo
         +9zktFmi/lTm1IHrUOU7nl5JVj4TyoqKEwxV7C/Pa1CJUYohaG3iBecVBpGgA8KM7ROu
         QXZA==
X-Gm-Message-State: AOJu0Yx9mg4pA5W5kGyVDOqJXA0nbtIVZcHIs024rCLmJJm+VAWGGWUK
	iMxsLu3HpCzs9nPrnEJgkn/SnHiMPb6YyywgYMsH4nr2OmFN0H4HAB0HZFa3GfQNdY0=
X-Gm-Gg: ASbGncvtyAEnF/kd815WGGlbaPaHojfQ4mNmQyxaJUok8Qjku2YToikNWdQaM+bkL9l
	O3Fs1CFx/6SZqG9lljVLo9j3Pnc7j+jeYKCvsbveZB/C1z564DXDEHFIGrIoJTn+mgy0YxtLpTS
	3GXWPkxZ8B/5iEh1TBvV5DibM9w5/RuGWtkeisDkGfWqaUVjYDGEYOJ163iKImGQoGA8fFvgU34
	bUH82de7WxJjhGfJbRDVlKSym5lw45tX5IH6C2zdV5orDARCWzBcw2nundcCqm9Kw3dQaAorJ+E
	5cHpfgymyvbrzrssiBt6wkIHkcLqGTW0EMJzuDKwhAddfxBRzfpJaO6NfQOwoL0Itx991NsQHez
	6MctPDMwUWSJ1llbWUFxBFtGo+Tv26PafKO0SUWMeSbJte0gVMJ+wzBNWAyq58mp0gZo93jU3MT
	sIgsKvmeLTPzargra76CtSTagVkA==
X-Google-Smtp-Source: AGHT+IGZCFDLJbg1drOGGBQmFXpywuGqMGR+uNAYyuK1U7sEyEiZam6AM7i/+dRl0jQfT4vL+fAxmg==
X-Received: by 2002:a92:c5c4:0:b0:3ea:5739:5e4f with SMTP id e9e14a558f8ab-3ea57395e53mr147707735ab.32.1756257181203;
        Tue, 26 Aug 2025 18:13:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4c28623fsm80504365ab.19.2025.08.26.18.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:13:00 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:12:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 12/16] packfile: introduce function to load and add
 packfiles
Message-ID: <aK5bm/tth12aYTI6@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-12-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-12-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:10AM +0200, Patrick Steinhardt wrote:
> We have a recurring pattern where we essentially perform an upsert of a
> packfile in case it isn't yet known by the packfile store. The logic to
> do so is non-trivial as we have to reconstruct the packfile's key, check
> the map of packfiles, then create the new packfile and finally add it to
> the store.
>
> Introduce a new function that does this dance for us. Refactor callsites
> to use it.

Nice, I have definitely noticed this pattern before and thought it would
be nice to DRY it up a bit, but never got around to doing so ;-).

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fast-import.c |  4 ++--
>  builtin/index-pack.c  | 10 +++-------
>  midx.c                | 18 ++----------------
>  packfile.c            | 44 +++++++++++++++++++++++++++++++-------------
>  packfile.h            |  8 ++++++++
>  5 files changed, 46 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index e9d82b31c3..a26e79689d 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -897,11 +897,11 @@ static void end_packfile(void)
>  		idx_name = keep_pack(create_index());
>
>  		/* Register the packfile with core git's machinery. */
> -		new_p = add_packed_git(pack_data->repo, idx_name, strlen(idx_name), 1);
> +		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
> +						 idx_name, 1);
>  		if (!new_p)
>  			die("core git rejected index %s", idx_name);
>  		all_packs[pack_id] = new_p;
> -		packfile_store_add_pack(the_repository->objects->packfiles, new_p);

OK, we can now avoid calling packfile_store_add_pack() explicitly here,
since that is part of the new packfile_store_load_pack() function which
is called a few lines up. That does change the order of operations a
little bit (previously the new pack would end up in 'all_packs' first
before being installed, now it's the other way around), but not in a way
that I think matters.

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index ed490dfad4..2b78ba7fe4 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1640,13 +1640,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
>  			    hash, "idx", 1);
>
> -	if (do_fsck_object) {
> -		struct packed_git *p;
> -		p = add_packed_git(the_repository, final_index_name,
> -				   strlen(final_index_name), 0);
> -		if (p)
> -			packfile_store_add_pack(the_repository->objects->packfiles, p);
> -	}
> +	if (do_fsck_object)
> +		packfile_store_load_pack(the_repository->objects->packfiles,
> +					 final_index_name, 0);

Looks obviously correct to me.

> diff --git a/midx.c b/midx.c
> index 3cfe7884ad..d30feda019 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -454,7 +454,6 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  		      uint32_t pack_int_id)
>  {
>  	struct strbuf pack_name = STRBUF_INIT;
> -	struct strbuf key = STRBUF_INIT;
>  	struct packed_git *p;
>
>  	pack_int_id = midx_for_pack(&m, pack_int_id);
> @@ -466,22 +465,9 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>
>  	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
>  		    m->pack_names[pack_int_id]);
> -
> -	/* pack_map holds the ".pack" name, but we have the .idx */
> -	strbuf_addbuf(&key, &pack_name);
> -	strbuf_strip_suffix(&key, ".idx");
> -	strbuf_addstr(&key, ".pack");
> -	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
> -					strhash(key.buf), key.buf,
> -					struct packed_git, packmap_ent);
> -	if (!p) {
> -		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
> -		if (p)
> -			packfile_store_add_pack(r->objects->packfiles, p);
> -	}
> -
> +	p = packfile_store_load_pack(r->objects->packfiles,
> +				     pack_name.buf, m->local);

Nice. This all looks like it preserves the right behavior, and it's nice
to see the "we have a thing that ends in '.pack', but we need one that
ends in '.idx'" logic get inlined, too.

> diff --git a/packfile.c b/packfile.c
> index a79d0fc1fa..f7a9967c9d 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -793,6 +793,33 @@ void packfile_store_add_pack(struct packfile_store *store,
>  	list_add_tail(&pack->mru, &store->mru);
>  }
>
> +struct packed_git *packfile_store_load_pack(struct packfile_store *store,
> +					    const char *idx_path, int local)
> +{
> +	struct strbuf key = STRBUF_INIT;
> +	struct packed_git *p;
> +
> +	/*
> +	 * We're being called with the path to the index file, but `pack_map`
> +	 * holds the path to the packfile itself.
> +	 */
> +	strbuf_addstr(&key, idx_path);
> +	strbuf_strip_suffix(&key, ".idx");
> +	strbuf_addstr(&key, ".pack");
> +
> +	p = hashmap_get_entry_from_hash(&store->map, strhash(key.buf), key.buf,
> +					struct packed_git, packmap_ent);
> +	if (!p) {
> +		p = add_packed_git(store->odb->repo, idx_path,
> +				   strlen(idx_path), local);
> +		if (p)
> +			packfile_store_add_pack(store, p);
> +	}
> +
> +	strbuf_release(&key);
> +	return p;
> +}
> +

This all looks good too, and matches the behavior of the callees which
are being refactored.

>  void (*report_garbage)(unsigned seen_bits, const char *path);
>
>  static void report_helper(const struct string_list *list,
> @@ -892,23 +919,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  			 const char *file_name, void *_data)
>  {
>  	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
> -	struct packed_git *p;
>  	size_t base_len = full_name_len;
>
>  	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
>  	    !(data->m && midx_contains_pack(data->m, file_name))) {
> -		struct hashmap_entry hent;
> -		char *pack_name = xstrfmt("%.*s.pack", (int)base_len, full_name);
> -		unsigned int hash = strhash(pack_name);
> -		hashmap_entry_init(&hent, hash);
> -
> -		/* Don't reopen a pack we already have. */
> -		if (!hashmap_get(&data->r->objects->packfiles->map, &hent, pack_name)) {
> -			p = add_packed_git(data->r, full_name, full_name_len, data->local);
> -			if (p)
> -				packfile_store_add_pack(data->r->objects->packfiles, p);
> -		}
> -		free(pack_name);
> +		char *trimmed_path = xstrndup(full_name, full_name_len);
> +		packfile_store_load_pack(data->r->objects->packfiles,
> +					 trimmed_path, data->local);

I think we could avoid the allocation here by passing along the length
of the string we want to use, as in:

    packfile_store_load_pack(data->r->objects->packfiles,
                             full_name, full_name_len,
                             data->local);

, but I prefer the way it is written here.

Thanks,
Taylor
