Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21A3BED42
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270753; cv=none; b=SPGUcsKAqN8dGFR/O/xamVLWgQMFGq8V/2jAZm/eSe/YjgsDZ+PD7ptiYWYf5InDCl1UfIK7ApkH8Yo0dlG5iMIz1fpX3fun/cKiy8uLPBSgvEupSD9N8n2vahNyl5FchxDvHXHg7TqBNJDfJz0F1NfhXZluRs6h0y1bfwm7RN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270753; c=relaxed/simple;
	bh=Pjiv2IoJzkEwduINsm/k43lbMx21gsVGmDV/Mgs35oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPBXpJHNMq/3IgUYfWw/2rYEWWtLg8nM0q/1lh2nDgb6/Uw1RXlLEdUd7Dx/+DyCfhENu3ngj+WUcJJ4vIWQo7R3T9yhHOFaA3Zxy9U2AyhBmDP6DmWx54E4tG/nesQaBwxylaVDsuoCOQJ3JVSaVk6W/NfkIfop5ap1IfZfjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJu+qO9t; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJu+qO9t"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso203658a34.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270751; x=1785875551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mb0GMrUKrY4PI1kfT2LXsK3d+1Jmxf2PmDjDxDamRvo=;
        b=PJu+qO9tm0YUT77/exOI+Q04hXHPkdoqdYqYBotsg1GpxoIfqUpd0VMnFqxBaR9tA+
         3k4KSxpU3jA547YECm0sK75yA7LecoY75cBQSLqwyEXjo+iKDFnEb62wIHHuM9rDqJ82
         nmzmSB7te30lfCMWnV6bEEaDpPMPBR7aVy+vFs9DQmKgWkYDPDY8Tlu/BnitL6FajasQ
         sPcuvq+v57dsbxNO/SxwiNAZvUpfBdMn/m9bcE5pfVoN5LUYR7YckRrIf8aZrhfa9tTi
         8Yr65rvXxioT9phlSTgPvh0oqrGNlmGiuaj6sXs/JAvJBaeyz/cVANEjdYqZYcOXLm8C
         I2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270751; x=1785875551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mb0GMrUKrY4PI1kfT2LXsK3d+1Jmxf2PmDjDxDamRvo=;
        b=SLzdurBQHlAUzuMxnYqEx5/grUn8msf0PvnNEobf2J13EhAvzFeVmkssZSKG6o5kXu
         d2kCVtW7vZtTM3pLKoxW/MbLOujzQbfb9crB38gIOmWiODFS+YMxZveZR4zVImvdcfT/
         ZxS68IgDSsvFQS+0mm3gqBwlCaa0zgZ0zkhS8TNFE36XA8ihrcxprFcgHLI9B8QfHX7w
         tTflKqkkLi8MCeQ0M+MIzhZbvEol4x3nSc3Q1xQ2vViwOLBlp9cUsKICdxPB02NM9rrT
         Vmhm3fynJ0OPnd/+PDuyK8ejgubpvY3TdnYc8uVHq6tIzg/VlGMzXa/FLX5D9hf47AHb
         YuhQ==
X-Gm-Message-State: AOJu0YwHCUsJCU1Nr1w3cFu6VKFhozK4jdEM57qYl+QZMPuHb/rTKj3d
	VCVRl+gsm2X8IKlQFSNEy7dzOY56n2e2cB+hZ2SVY7He6Ea+wDPYlbZn
X-Gm-Gg: AR+sD13zgcuV1orWmDiHx4juyPaLVnIp9Kr2d6ovI6i6nvU9bCfz2AmLXf8HRnbLE7e
	9ciNclqwjVQnCF+OJbnxMGChThjGtYnmCHDXV6tJA9xBgaxDamRIv8D5b1qU2RheV9w0xi0OXvv
	KSVbAH6RIq9dmjqICCYRdRMF5igtPTJmkPvVX8CnQGYr9LD307EqHABkSZTdI2oodM2K79vi8qU
	d4y8DoKiDzk/ec/Wx179kpfAXVoJX6ynxUSyqBwoC1UjUyGUSuulrHI1xy2zL09p/v207yK6LzC
	yU+YroINDR+9VRHCFdL6b0u/yTTWgt77WhhnnMVpdpa4Al/O9VaLMtfDGK0+S1myVT4Roh3OfDI
	3fLfqFUBTWUlabiZFmf6/D9c+V+vSaUECIuLGACH3BovMoTmQWSIq41iltPIupt890lp+NeWzrE
	NzxBeSXZdEGCICXDueDQuDaJPV89pSYsfsLOjT3zWd3pVpEiyx/RbAMA==
X-Received: by 2002:a05:6830:f8d:b0:7ee:19dc:b00 with SMTP id 46e09a7af769-7efff060805mr2207162a34.3.1785270750662;
        Tue, 28 Jul 2026 13:32:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d591d97sm642875a34.3.2026.07.28.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:32:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:32:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: detangle loading of loose object maps
Message-ID: <amkOb3rvWFUpnT28@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>

On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> When a repository is configured to use a compatibility hash function
> then we load the loose object map when we initialize the repository.
> This object map provides the mappings between the canonical object hash
> and the compatibility object hash.
> 
> Loading the object map happens in `repo_set_compat_hash_algo()`, which
> calls `repo_read_loose_object_map()` in case the compatibility object
> hash is non-zero. This setup sequence has two major downsides:
> 
>   - We assume that the primary object database is the "files" object
>     database so that we can extract its "loose" backend. This stops
>     working with pluggable object databases.

So IIUC, does this mean that `repo_set_compat_hash_algo()` is directly
reaching into the loose object source to load the compatibility object
map? I suppose it should be the responsibility of the respective ODB
backend to handle object compatibility.

>   - We require the object database to already have been initialized when
>     configuring the object database. This means that we must intermix
>     configuration of the repository and initialization of its
>     sub-structures in a weird way.

If there any reason we need to eagerly load compatibility object
mappings?

> Refactor the logic so that we instead load the loose object map via the
> "loose" backend, which fixes both of the above issues.

Sounds reasonable.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  loose.c            | 11 +++++------
>  loose.h            |  1 +
>  odb/source-loose.c |  2 ++
>  repository.c       |  2 --
>  setup.c            |  5 +++--
>  5 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/loose.c b/loose.c
> index 9dad75373b..a3b2dcedc2 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -61,7 +61,7 @@ static int insert_loose_map(struct odb_source_loose *loose,
>  	return inserted;
>  }
>  
> -static int load_one_loose_object_map(struct odb_source_loose *loose)
> +int loose_object_map_load(struct odb_source_loose *loose)
>  {
>  	struct repository *repo = loose->base.odb->repo;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -69,6 +69,9 @@ static int load_one_loose_object_map(struct odb_source_loose *loose)
>  	FILE *fp;
>  	int ret = -1;
>  
> +	if (!should_use_loose_object_map(repo))
> +		return 0;

Previously the above condition has asserted in
`repo_read_loose_object_map()` which calls `loose_object_map_load()` for
each source. Do we expect each source to potentially answer differently
though?

> +
>  	if (!loose->map)
>  		loose_object_map_init(&loose->map);
>  	if (!loose->cache) {
> @@ -112,14 +115,10 @@ int repo_read_loose_object_map(struct repository *repo)
>  {
>  	struct odb_source *source;
>  
> -	if (!should_use_loose_object_map(repo))
> -		return 0;
> -
>  	odb_prepare_alternates(repo->objects);
> -
>  	for (source = repo->objects->sources; source; source = source->next) {
>  		struct odb_source_files *files = odb_source_files_downcast(source);
> -		if (load_one_loose_object_map(files->loose) < 0)
> +		if (loose_object_map_load(files->loose) < 0)
>  			return -1;
>  	}
>  
> diff --git a/loose.h b/loose.h
> index 6c9b3f4571..ed663ac550 100644
> --- a/loose.h
> +++ b/loose.h
> @@ -13,6 +13,7 @@ struct loose_object_map {
>  
>  void loose_object_map_init(struct loose_object_map **map);
>  void loose_object_map_clear(struct loose_object_map **map);
> +int loose_object_map_load(struct odb_source_loose *loose);
>  int repo_loose_object_map_oid(struct repository *repo,
>  			      const struct object_id *src,
>  			      const struct git_hash_algo *dest_algo,
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 3f7d04a56e..812ca1c138 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -727,5 +727,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
>  	if (!is_absolute_path(loose->base.path))
>  		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
>  
> +	loose_object_map_load(loose);

Now we load the loose object map for the specific source when its
created.

> +
>  	return loose;
>  }
> diff --git a/repository.c b/repository.c
> index 2ef0778846..6d633002b4 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -201,8 +201,6 @@ void repo_set_compat_hash_algo(struct repository *repo MAYBE_UNUSED, uint32_t al
>  	if (hash_algo_by_ptr(repo->hash_algo) == algo)
>  		BUG("hash_algo and compat_hash_algo match");
>  	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
> -	if (repo->compat_hash_algo)
> -		repo_read_loose_object_map(repo);

The loose object map is no longer read eagerly.

>  #else
>  	if (algo)
>  		die(_("compatibility hash algorithm support requires Rust"));
> diff --git a/setup.c b/setup.c
> index d31808130b..825572f5f1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1788,8 +1788,6 @@ int apply_repository_format(struct repository *repo,
>  
>  	repo->bare_cfg = format->is_bare;
>  	repo_set_hash_algo(repo, format->hash_algo);
> -	repo->objects = odb_new(repo, object_directory,
> -				alternate_object_directories);
>  	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
>  	repo_set_ref_storage_format(repo,
>  				    format->ref_storage_format,
> @@ -1805,6 +1803,9 @@ int apply_repository_format(struct repository *repo,
>  	repo->repository_format_precious_objects =
>  		format->precious_objects;
>  
> +	repo->objects = odb_new(repo, object_directory,
> +				alternate_object_directories);

We now defer creating the ODB until after the compat hash is configured.
Makes sense.

-Justin
