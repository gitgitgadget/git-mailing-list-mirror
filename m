Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE53A0B11
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646053; cv=none; b=qC/93/jZSFvsy1CJ1SATAdWppQ1/xkthLCduoz2K/vei6RrRR7v7hu1qwxoGOhNUSnDsds03zgr6wCUj1u7ktfYVY3k0JK9hsiEP8O4/WNFL/gP00jjVcRiwj/NJSa4QQkOgnc4reqKUJcWKisJ5zDJA90EO8teDScjkOLvTfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646053; c=relaxed/simple;
	bh=WNfSOnuAyQT8XjQsZh2y63gwDGfuJomOO0vkwE9ORmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhlfxtuDgXW3oxfV4mjosgiwJ6JslhN9ZK2plklwQ/5oW1oAEXlHNU3QqUrJUi0PolqIt56VgBAyjyBCW2nsz556cVRDhhh7ygiwRsLNEmnGhpQZbEdH+LW6LLzlhtVwWDYPgaGzE9MzFUukwe7vuM48uEBvDEBz/fAyMGNtwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iufjAtFS; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iufjAtFS"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662f30d3f1fso5500311eaf.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772646051; x=1773250851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWYr5aHoYMPuO0qmcFTNUCsP8shzbLTxXUVzrYa2QXc=;
        b=iufjAtFSWuAnAtkjvag4st0AdNj0PV74zS9nruP4+bdelIOnIeU4iOSeLjPp5ylm0J
         6B2uEIAjR2C02Gpydvdn2Xpq/z0GL77/P3w4lCjGMR8Wjbu0DzooXdLcY+c//+xafK+y
         KlqZRVThhbGDGKVuV855Ka7n0UjX5Cky+bFj2/bmsdiaI3w1SGmVZ9j1NzJEiBscF+GY
         eTXFtjq/UsWiGPJ88JVCwNFSJPgMUJ6aRzenj+nMreZJzivAjOPy74wRIGe+zuXwcfLX
         5TaPyZl1k2sL2WRzWZVXPJa2lzr1l5NpynkP4V5SY63d4gw97mJ9TtjfwSdRo3z3RmQc
         Ip2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646051; x=1773250851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWYr5aHoYMPuO0qmcFTNUCsP8shzbLTxXUVzrYa2QXc=;
        b=nLVsY0jl8sBett51SssFSXxBC5gQScby8212pNjKjUIQswxe1CanFwcnF4uCRwy+dZ
         4wlxUTQgPHxv/gkhrEDmv5etk1iuDC6ZJgnvZxqYcd5IeFKpjKElOocXp4W9jEdNlosw
         z5mVrmube0LsyFZXAD6bPGvIU9JyXfpfKNTZTORiIoMu+y9QRTx3uvm60YPoIU6utXFK
         XZ8SD5ppEGkRQ12WxH6oYIK8jhfRicQfnYAg9zzmDLY45fj4X8sbm8kkBg6mrtzYbXFt
         DFaNYeayenzpMEWjvUMGBTr/N9YB0Kzd6Z9mT2i9V4nklETXH9SIvlBCk8MiUU1rdxMa
         Bc0A==
X-Gm-Message-State: AOJu0YwtRXIRJ9RRuRmTMONpQqCHUcnAt+WfD+EeYsPAkOplGS/nTy4G
	bh19dvn4lNOnuJIXtQET/d/VoHj+mKWD6sC9Y1KGXYtXHdvIFj0D4CtH
X-Gm-Gg: ATEYQzzAGedphysde35sOFdhnaedF6xSmxoLjoYyDLsWjxAZQb2flgwMqtJtEZFTfSA
	gssjHUSC5kk7B0qbnLe8LzuDUe5TR6pFYF4vYttus+K+wLxqQ0wLsU724M9fCtTZr0fccoHfY/L
	PGkkLLw+oehilDXqHBHMtSTA3UslL2xEOT8yffSYWJD3N41A+/T93xpyTxDEqNoJSPmxEyTRzOY
	JG8xh6CMwFyIP8gCA9awoAv5c8Xa4+rbUvIOwT3RZE2VtAVYR0NixclA33NNIPTV04rJrKIvT1d
	NjvVSaJF4eei0kq6GvMZxJLi1wtDjI9KQQt+l1NUM0WnPvYwUrMLEli2HF3/vE+FjB/MyU001oI
	FfawWOR+3AEb3ylBdIfnxIUaDn2GHz2xEjm05PNvz+XSmb7Au8s/eKYyO72yqL9XvLmzlOm8Og1
	VHF1x7SWSj1PJWYOG8etKRPqCnFKU=
X-Received: by 2002:a05:6820:f027:b0:67a:2264:5b7a with SMTP id 006d021491bc7-67b5fdec258mr1225798eaf.19.1772646051076;
        Wed, 04 Mar 2026 09:40:51 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9b7bfsm13554733eaf.12.2026.03.04.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:40:50 -0800 (PST)
Date: Wed, 4 Mar 2026 11:40:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/17] odb: embed base source in the "files" backend
Message-ID: <aahkh1ICViKjP6Il@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> The "files" backend is implemented as a pointer in the `struct
> odb_source`. This contradicts our typical pattern for pluggable backends
> like we use it for example in the ref store or for object database
> streams, where we typically embed the generic base structure in the
> specialized implementation. This pattern has a couple of small benefits:
> 
>   - We avoid an extra allocation.
> 
>   - We hide implementation details in the generic structure.
> 
>   - We can easily downcast from a generic backend to the specialized
>     structure and vice versa because the offsets are known at compile
>     time.
> 
>   - It becomes trivial to identify locations where we depend on backend
>     specific logic because the cast needs to be explicit.
> 
> Refactor our "files" object database source to do the same and embed the
> `struct odb_source` in the `struct odb_source_files`.

Makes sense.
 
> There are still a bunch of sites in our code base where we do have to
> access internals of the "files" backend. The intent is that those will
> go away over time, but this will certainly take a while. Meanwhile,
> provide a `odb_source_files_downcast()` function that can convert a
> generic source into a "files" source.
> 
> As we only have a single source the downcast succeeds unconditionally
> for now. Eventually though the intent is to make the cast `BUG()` in
> case the caller requests to downcast a non-"files" backend to a "files"
> backend.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source-files.c b/odb/source-files.c
> index cbdaa6850f..a43a197157 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -1,5 +1,6 @@
>  #include "git-compat-util.h"
>  #include "object-file.h"
> +#include "odb/source.h"
>  #include "odb/source-files.h"
>  #include "packfile.h"
>  
> @@ -9,15 +10,20 @@ void odb_source_files_free(struct odb_source_files *files)
>  		return;
>  	odb_source_loose_free(files->loose);
>  	packfile_store_free(files->packed);
> +	odb_source_release(&files->base);
>  	free(files);
>  }
>  
> -struct odb_source_files *odb_source_files_new(struct odb_source *source)
> +struct odb_source_files *odb_source_files_new(struct object_database *odb,
> +					      const char *path,
> +					      bool local)
>  {
>  	struct odb_source_files *files;
> +
>  	CALLOC_ARRAY(files, 1);
> -	files->source = source;
> -	files->loose = odb_source_loose_new(source);
> -	files->packed = packfile_store_new(source);
> +	odb_source_init(&files->base, odb, path, local);
> +	files->loose = odb_source_loose_new(&files->base);
> +	files->packed = packfile_store_new(&files->base);

When creating the files ODB source, it is now responsible for also
creating the embedded base ODB souce. Makes sense.

> +
>  	return files;
>  }
> diff --git a/odb/source-files.h b/odb/source-files.h
> index 0b8bf773ca..58753d40de 100644
> --- a/odb/source-files.h
> +++ b/odb/source-files.h
> @@ -1,8 +1,9 @@
>  #ifndef ODB_SOURCE_FILES_H
>  #define ODB_SOURCE_FILES_H
>  
> +#include "odb/source.h"
> +
>  struct odb_source_loose;
> -struct odb_source;
>  struct packfile_store;
>  
>  /*
> @@ -10,15 +11,26 @@ struct packfile_store;
>   * packfiles. It is the default backend used by Git to store objects.
>   */
>  struct odb_source_files {
> -	struct odb_source *source;
> +	struct odb_source base;

Out of curiousity, was there any reason to the reference ODB source in
the prior patch? Seems like we could have just added it here.

>  	struct odb_source_loose *loose;
>  	struct packfile_store *packed;
>  };
>  
>  /* Allocate and initialize a new object source. */
> -struct odb_source_files *odb_source_files_new(struct odb_source *source);
> +struct odb_source_files *odb_source_files_new(struct object_database *odb,
> +					      const char *path,
> +					      bool local);
>  
>  /* Free the object source and release all associated resources. */
>  void odb_source_files_free(struct odb_source_files *files);
>  
> +/*
> + * Cast the given object database source to the files backend. This will cause
> + * a BUG in case the source doesn't use this backend.
> + */

In the commit message you mention that eventually
`odb_source_files_downcast()` will BUG() if the source doesn't use the
backend. But, it doesn't appear to do this yet. Should we still have
this comment?

> +static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
> +{
> +	return container_of(source, struct odb_source_files, base);
> +}
> +
>  #endif
[snip]
> diff --git a/odb/source.h b/odb/source.h
> index 1c34265189..e6698b73a3 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -1,8 +1,6 @@
>  #ifndef ODB_SOURCE_H
>  #define ODB_SOURCE_H
>  
> -#include "odb/source-files.h"
> -
>  /*
>   * The source is the part of the object database that stores the actual
>   * objects. It thus encapsulates the logic to read and write the specific
> @@ -21,9 +19,6 @@ struct odb_source {
>  	/* Object database that owns this object source. */
>  	struct object_database *odb;
>  
> -	/* The backend used to store objects. */
> -	struct odb_source_files *files;

Now that the base ODB source is embedded in `struct odb_source_files`,
it is accessed via downcasting and the direct reference is no longer
needed. This is responsible for most of the structural change fallout in
this patch.

> -
>  	/*
>  	 * Figure out whether this is the local source of the owning
>  	 * repository, which would typically be its ".git/objects" directory.
> @@ -53,7 +48,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
>  				  const char *path,
>  				  bool local);
>  
> -/* Free the object database source, releasing all associated resources. */
> +/*
> + * Initialize the source for the given object database located at `path`.
> + * `local` indicates whether or not the source is the local and thus primary
> + * object source of the object database.
> + *
> + * This function is only supposed to be called by specific object source
> + * implementations.
> + */
> +void odb_source_init(struct odb_source *source,
> +		     struct object_database *odb,
> +		     const char *path,
> +		     bool local);
> +
> +/*
> + * Free the object database source, releasing all associated resources and
> + * freeing the structure itself.
> + */
>  void odb_source_free(struct odb_source *source);
>  
> +/*
> + * Release the object database source, releasing all associated resources.
> + *
> + * This function is only supposed to be called by specific object source
> + * implementations.
> + */
> +void odb_source_release(struct odb_source *source);

From a naming perspective, I do find the odb_source_new() vs
odb_source_init() and odb_source_free() vs odb_source_release()
interfaces to be tad bit confusing. I understand that odb_source_init()
and odb_source_release() and only intended for use by the concrete ODB
source implementations to facilitate initializing/freeing the base ODB
source. The comments also do help clarify this, but I think it is still
rather easy to get them mixed up when reading.

Maybe we could rename them to odb_base_source_init() and
odb_base_source_free()?

> +
>  #endif
> diff --git a/odb/streaming.c b/odb/streaming.c
> index 26b0a1a0f5..19cda9407d 100644
> --- a/odb/streaming.c
> +++ b/odb/streaming.c
> @@ -187,7 +187,8 @@ static int istream_source(struct odb_read_stream **out,
>  
>  	odb_prepare_alternates(odb);
>  	for (source = odb->sources; source; source = source->next) {
> -		if (!packfile_store_read_object_stream(out, source->files->packed, oid) ||
> +		struct odb_source_files *files = odb_source_files_downcast(source);
> +		if (!packfile_store_read_object_stream(out, files->packed, oid) ||
>  		    !odb_source_loose_read_object_stream(out, source, oid))
>  			return 0;
>  	}

Overall this patch looks good.

-Justin
