Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D26FBF
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697287; cv=none; b=BRRyQHZ2sSAoSY3caEV/qh2RriL3qGmH8jVmVWR82ZIYN/cRzCrQGM9KtkSTyuxBpdNeG7hi8hGaohVvKDt+SCDtrxkWTbG2cd6nNiegLjigJxpbJpTCU+tXGWFoZb5H2P4hoD+eMVSLZZUkX4FxVPNKdYzLA0uQbIV4RG+Xah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697287; c=relaxed/simple;
	bh=w3slvvZCh9XIFnWjSyo8PNeqn9t73JMmMLOD0uKAxKo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=m70aJkUzVlKvfMm+KxeIT2eKU5UabuM2IMUFXB6qZAZg/I+UHNPA8uEMLJyT5wRSTcTGHXDOrU2wgrhSsvQd/njJYAHmfe52jBsAP/WphVpS2CZZsDF1wR6+9C5UH7sNf8aF7vaTAhDib11omiU98CWAG8cYjnwHOoWAeMjEVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfaXO6gp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfaXO6gp"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b17498109so2255700e0c.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755697285; x=1756302085; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3jrPQpnTy72rl1waHR6gBCO3b6mr9lGdpkHg1buzk=;
        b=RfaXO6gpa5tzH02saSE8DE1uOJ/MFgA5PzHIgTReMIrtlKnqc8sKjCXDI9fxLZd9mJ
         z85xnuHpCyTmV7/FujKxRetDlIfn5rHdrHRLRpacd6TX/s3/YfIO5W4WVs43uWP0ahUR
         Dnl7+bcKelwWd/qdqxSHm76+M93lX+POpNpDgau/idH02ePc8n3dPIaG1d+ZYtmi69sP
         NMV4051xBAsQSgcWytgkbU3yJEIxCaR6/vYjjLCoOA5wVjpi4LzC2HxlTegGgIBD+HZ5
         XjsLPyXeuiT5UqT466BC1knogfSS+OAaBnxbqLadHC2Mqe9DYAToH8iXYM8KnaM8tKF0
         +khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755697285; x=1756302085;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3jrPQpnTy72rl1waHR6gBCO3b6mr9lGdpkHg1buzk=;
        b=ZjSMFnmNS9YA9sSPFI3l47KPs3Hg4gG5xQ2PyZ5fITMxbqCiq8wqaQ4sVYIVbOtBT2
         ayhX0mR07RVnDEF7MXoHMzmQC3fbG6lD0zYFPv6nrT9oX5eFhuzho5C5gBa0Vv3lGPlq
         zPcTsYplMXqrr/c/6xd5MivUwcj2+6LPUJcVq73KoG1GSzhcteX7vL2spJRy6rqRrEFW
         lXSf7oA7ONMU2CSG/MAsjgmN0lK/R//peJSVbbUNBG9nN8a1PsjWEOPxkmYaUbJpc6Lx
         2r3Apo3MUoJW7uplWlXtyWnh4reNg732qXEzP44NXRvvH7aHAtTs7+Cd8xrqzYFWD2Jd
         zW9g==
X-Forwarded-Encrypted: i=1; AJvYcCVNGnCvxjl5XHa1uykIpunI1YnZK1DRLh/kxbfnPXaRTW2NeiRJpvWa4Xpfi1SDbEH4Yyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZEpQdgDQ+DuWoq0wUsDVSEfV0BCy4+ti6wo9PXHI0zR18Upo
	kycQ42mtMcmPegQPP5FZbpaexiiloLPy4noAttdDRADgPj+qJfH2Tk7fY9A6mA+WxlsYFtKhHut
	r796pgv59bzteamZC69t4fv318PT55l/Bkg==
X-Gm-Gg: ASbGncuEoXZRlmG8vPRCqlexHPf4aOuZxiWoML6QXrfIabUITzzO7591kZAgrLLQ9qR
	KvuxqiT8rxWPmg4xwRrCinbwL35SpREvzFz5ERk3SBIDIh9ZauYxwZCilEHZUZ/9uav8wG7g1/O
	3wUs05yTeQzOuoLbJNHvZlQCH8Fauclcz8JtkWx1z8DjTRIxQ6webRTJMQ+we6CYahruuuXzLij
	O9dvVnM+Kogd0A0
X-Google-Smtp-Source: AGHT+IGXPMNSrnqe0Jhd+WDtCAtH9HJyNUZi7GxJxzrqTSHbfqGIuT/rWkSsN2qBhDlIIzh33blLFh2SZDaypTtQ6to=
X-Received: by 2002:a05:6102:2b85:b0:519:534a:6c28 with SMTP id
 ada2fe7eead31-51a51dbecd0mr815183137.30.1755697284506; Wed, 20 Aug 2025
 06:41:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:41:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:41:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-12-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-12-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:41:23 -0700
X-Gm-Features: Ac12FXwqrZyfIdqYJy-dK0vDsHCy-ujR7zIF3nF4OOR8u2lCElJRP0MKokAIkfk
Message-ID: <CAOLa=ZQ7MXCRbLk1S53urSxE8CmLza17684Yg2S6rhOSo+tyTA@mail.gmail.com>
Subject: Re: [PATCH 12/16] packfile: introduce function to load and add packfiles
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fa114c063ccc205b"

--000000000000fa114c063ccc205b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have a recurring pattern where we essentially perform an upsert of a
> packfile in case it isn't yet known by the packfile store. The logic to
> do so is non-trivial as we have to reconstruct the packfile's key, check
> the map of packfiles, then create the new packfile and finally add it to
> the store.
>

I was just thinking about this in the previous patch and how it seemed
weird that the midx.c file was checking and adding a packfile, so good
to see this.

> Introduce a new function that does this dance for us. Refactor callsites
> to use it.
>
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
>

I assume that the 'packfile_store_load_pack' function here returns a
new/existing packfile.

>  		if (!new_p)
>  			die("core git rejected index %s", idx_name);
>  		all_packs[pack_id] = new_p;
> -		packfile_store_add_pack(the_repository->objects->packfiles, new_p);
>  		free(idx_name);
>
>  		/* Print the boundary */
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
>
>  	if (!from_stdin) {
>  		printf("%s\n", hash_to_hex(hash));
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
>  	strbuf_release(&pack_name);
> -	strbuf_release(&key);
>
>  	if (!p) {
>  		m->packs[pack_int_id] = MIDX_PACK_ERROR;
> diff --git a/packfile.c b/packfile.c
> index 8b5e6b96ce..f7916543a6 100644
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

I was wondering from an earlier patch too, is there a reason to simply
not use 'strmap' for 'packfile_store.map'?

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
> +		free(trimmed_path);
>  	}
>
>  	if (!report_garbage)
> diff --git a/packfile.h b/packfile.h
> index e751a5d93e..4971f18f51 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -119,6 +119,14 @@ void packfile_store_reprepare(struct packfile_store *store);
>  void packfile_store_add_pack(struct packfile_store *store,
>  			     struct packed_git *pack);
>
> +/*
> + * Open the packfile and add it to the store if it isn't yet known. Returns
> + * either the newly opened packfile or the preexisting packfile. Returns a
> + * `NULL` pointer in case the packfile could not be opened.
> + */
> +struct packed_git *packfile_store_load_pack(struct packfile_store *store,
> +					    const char *idx_path, int local);
> +

This seems inline with my expectations.

>  struct pack_window {
>  	struct pack_window *next;
>  	unsigned char *base;
>
> --
> 2.51.0.261.g7ce5a0a67e.dirty

--000000000000fa114c063ccc205b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: af7e28481fef636f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbDBJSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNitYQy9zRnU3dFBTeHc4ajgwRTdsbjdGZWtyaEdLdQpHZ01JNFNyN1cz
ZDZGaTEwY3QrdEVHdlNzc0NubnFOVktibGJmaHhFTWtSVU1ueTd4cUhKWUpYZUFTajF4N1EwCjVS
aUFWM2t4c0pSWEo4ZGtTajR2SEpMMkxxZ3ZPSkU1Y291UHNKZ3hkVWduZWFiNDVxMFVGcXlQR0N4
cDhFNE8KdVYwWkdpeDd2TEpDS2F4Sm9KVWg0NDFEcnBDMVQ0Ui9UTXptMHVZTzA0UTRJajBmUC9w
K3A2OE5qREN1bG5vaApPbHlUVEI2VjAvM29NZVNXWThnUmd5QW9vT3FRYnlKUmpDMzIwRlVoK1Ft
U2MvRmhoaUtLckU0NmZUb2FaQTgyCm95OWNqRzFPVkl4RWhnRFhjSVgrb1k4TXVoUlJCeUlTeUo0
dXdFWjFac0o0WGdNd0EzbHR1L3N5d0RKajVVdjAKT1lYdEpvanc4M0djTHB4b3RCMnlocVBra1pn
QTVVbkZoUEplcTVPbHYrNUlzMWhvbEIxd2VyVmovZjdIallsUgoxY2pZSFEwUXE5TFJUa3pJTWgz
VFZtRGEwVEU5MXg5V0JSdktFOFNNNlp1R3NFZTNBNUM1RmtIQ0Y0T3EvKzJnCnlnWjlHNmsvbzhr
NnZCeDRFRGF3UTJudzQwaFMyUW8rMUQ3eER3ND0KPWRqUzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa114c063ccc205b--
