Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2D2C15A0
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566735; cv=none; b=PH4e/s7H+TX4zy23n7L3S1aKjbPFWYGplrxn95+JjCw+vEGDkvWLXIOOP+7LCQYF2vbzlZK+MGOusibFL3g1tY2u+fESdl9FgqYrbN9su4gXXhu/BYWAhtsMYahXd3r6zvlNkEqfcxIfj4yGjAsE8dr1TofaP48MAJ7rQi0dCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566735; c=relaxed/simple;
	bh=xQzJJj0C1B+Hc97QwYfTPOCRSuqglSXsBXHPTCp+inc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfdy9Nix3n9vtNJ97OQkWQROAaybSnvdWuNbhw/9eXiz97z8sxoYCJVxhpaDc7dpQRblosDa6Tz8oRPUXjzszB0oNkKGTf584xpeRU27WVefthgkuMzYZyy4kGZJjgrnnk+hgoh34BlNNYT6GvWhqmyDf46eO+W5WUHJRgzF2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbkitRGF; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbkitRGF"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65036e4b307so12742eaf.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760566732; x=1761171532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouRw6mp3mA8diBWQmXm8i7pbrsynYRuzYXKaZjHSl04=;
        b=kbkitRGFWa98/XcsYmF7bB8ObTyVZGEqlMQu/soFK56UxoDCi9oXl2GbKxmF2qZBuA
         M4qgqeMAWlkHilW6bmYJEH/FlNmBgBz4LmHAfIS7tRtu82SxSRx3zmdXlavGdUqu6LmZ
         DTv3dUWYgbMaP4gSNpCr2TO/nUp2JcQ0faFWOHLuQ+4D7PHdrWt8uYlxOrWzjmo+H7fi
         IpuzRfMSYnB2UqSUFuENdLjgmuvIwm0WNDcY3MUzphqiH2Bibp2e3cEAMLmw+/7M+iPw
         7HyB7q3n/vYLckIEAH9UqwGLND8ES0O7lck7dDMonPPeMWAMt/mOho3mR8ZDXFjzEiqc
         ffYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760566732; x=1761171532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouRw6mp3mA8diBWQmXm8i7pbrsynYRuzYXKaZjHSl04=;
        b=BifdEWyjsXItNkHW6hQ9p1kRvFcw0F9I+FlN1GSY/YBxCSB6ak3g/7AVKzTLEDCo+l
         U1AOYfIPREceJ5iuKbD9J+wiC3AREHqGqm/GXh+3Nz48ygLkHKVikdyVGZ7jSP6UsC7o
         cyRC6h4PLvHKPZ76sRLSJeF+gUA6Y3LAqGANBm5Bnxws4xbt9oB5CIpajLzsRpB3bWii
         Pn1Z3aqahg2t1xbDNbyM6vRZ3LYuh8xuMgAuFHFVy6TOSmpca0mh2cuj0lTJjiUxgYUq
         maXWP8ZyssvK/q1FZ3Jm0UyXHmKPZ0upAvVwnBMDbRU5mTbk8mRixGJnO7/zb53HFZE9
         Up7Q==
X-Gm-Message-State: AOJu0Ywu+lTnughUYCImaEmbd7rMvFuKmsbaNI//THru1YrXmwb3Feiu
	k10KAlMmZDE6GQZtM9TuVhxgDZC2ylu/T7LtzTThdts77seHeUpD7kvt
X-Gm-Gg: ASbGncufKvPpFogpVByn7S6qZ5qsoZsKoWzErlvA2yQbilp55cd8w8N20XwVoHqtPh+
	kHXlmiy/WMeTM781ze9KzYZIoAmvmMB8i7irKpe+XIT8IuqClOQSyYjQGZtkt9COR59NIWWrXuZ
	p6jMH3Rzw1OkyrdnFnf1HWN51tPhY7ZEe3d2gMId6zrOSnMMK1NRZ075vFS7yPOWZg6DXUgk18P
	KeDcLtIdhuGK6qeRrFUWFDGRAwO9YD5COpuq6Q+MUnfrlek/ZQT6xuJaOg7OYdP+aPG7zbfFwWY
	wdJfi16+smvgCoaPKDkkPHwkYdoYFCmGRdwIYOokey2JFfI/R2W4zRqiT5gSWe/gRHp2ie4PPKx
	FogHqLPkug9BAQigzSandiqB7Vr/eSMELcBmA3O5yJbdCk74xGUsFF4jI3mqhlP5dFfaCIw==
X-Google-Smtp-Source: AGHT+IGpWWDanWks7+v4DX+Ws1cRNOHg/ZJNXe8dzecB+sUP+tI4v22KbdG95C44OxsQ8jMW4Ww4AQ==
X-Received: by 2002:a4a:a7cd:0:b0:650:104d:6742 with SMTP id 006d021491bc7-650104d6a6cmr7835860eaf.2.1760566731831;
        Wed, 15 Oct 2025 15:18:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6502d6237fcsm2742610eaf.6.2025.10.15.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:18:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:18:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 3/4] refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
Message-ID: <j4kd7andvwa77uf7yaxvfkrb5bpxyda4awhnyce5fypr3qijsp@sw4bzfd43byg>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-3-550fdd8a3b41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-refs-code-cleanup-v1-3-550fdd8a3b41@gmail.com>

On 25/10/15 11:25PM, Karthik Nayak wrote:
> The previous commit removed all references to 'pack_refs()' within
> the refs subsystem. Continue this cleanup by also renaming
> 'pack_refs_opts' to 'refs_optimize_opts' and the respective flags
> accordingly. Keeping the naming consistent will make the code easier to
> maintain.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  pack-refs.c             |  8 ++++----
>  refs.c                  |  2 +-
>  refs.h                  | 16 ++++++++--------
>  refs/debug.c            |  2 +-
>  refs/files-backend.c    | 10 +++++-----
>  refs/packed-backend.c   |  2 +-
>  refs/refs-internal.h    |  2 +-
>  refs/reftable-backend.c |  4 ++--
>  8 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/pack-refs.c b/pack-refs.c
> index 1a5e07d8b8..d0ffed93c1 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -14,10 +14,10 @@ int pack_refs_core(int argc,
>  {
>  	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
>  	struct string_list included_refs = STRING_LIST_INIT_NODUP;
> -	struct pack_refs_opts pack_refs_opts = {
> +	struct refs_optimize_opts pack_refs_opts = {

We could rename the variable name here to, but probably not a big deal
either way.

>  		.exclusions = &excludes,
>  		.includes = &included_refs,
> -		.flags = PACK_REFS_PRUNE,
> +		.flags = REFS_OPTIMIZE_PRUNE,
>  	};
>  	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *item;
> @@ -26,8 +26,8 @@ int pack_refs_core(int argc,
>  
>  	struct option opts[] = {
>  		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
> -		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
> -		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
> +		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
> +		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
>  		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
>  			N_("references to include")),
>  		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
> diff --git a/refs.c b/refs.c
> index b9a4a60646..0d0831f29b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2313,7 +2313,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>  	refs->gitdir = xstrdup(path);
>  }
>  
> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
> +int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
>  {
>  	return refs->be->optimize(refs, opts);
>  }
> diff --git a/refs.h b/refs.h
> index 04e917fec0..d2630af97f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
>  
>  /*
>   * Flags for controlling behaviour of refs_optimize()
> - * PACK_REFS_PRUNE: Prune loose refs after packing
> - * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
> - *                 result are decided by the ref backend. Backends may ignore
> - *                 this flag and fall back to a normal repack.
> + * REFS_OPTIMIZE_PRUNE: Prune loose refs after packing
> + * REFS_OPTIMIZE_AUTO: Pack refs on a best effort basis. The heuristics and end
> + *                     result are decided by the ref backend. Backends may ignore
> + *                     this flag and fall back to a normal repack.
>   */
> -#define PACK_REFS_PRUNE (1 << 0)
> -#define PACK_REFS_AUTO  (1 << 1)
> +#define REFS_OPTIMIZE_PRUNE (1 << 0)
> +#define REFS_OPTIMIZE_AUTO  (1 << 1)
>  
> -struct pack_refs_opts {
> +struct refs_optimize_opts {
>  	unsigned int flags;
>  	struct ref_exclusions *exclusions;
>  	struct string_list *includes;
> @@ -518,7 +518,7 @@ struct pack_refs_opts {
>   * Optimize the ref store. The exact behavior is up to the backend.
>   * For the files backend, this is equivalent to packing refs.
>   */
> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
> +int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);

I noticed when poking around the code that the optimize callback was
still using the `pack_refs_opts`. Nice to see this clean up. :)

>  /*
>   * Setup reflog before using. Fill in err and return -1 on failure.
[snip]
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 20cf9fab18..0aa0ff6701 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1774,7 +1774,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
>  }
>  
>  static int packed_optimize(struct ref_store *ref_store UNUSED,
> -			   struct pack_refs_opts *pack_opts UNUSED)
> +			   struct refs_optimize_opts *pack_opts UNUSED)

Also not a big deal, but we could rename `pack_opts` here to just
`opts`. It's not even used anyways.

All the other trivial renames in this patch look good.

-Justin
