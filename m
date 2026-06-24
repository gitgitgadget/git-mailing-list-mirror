Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106A20459A
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336993; cv=none; b=LPXPm+7D2oTkMjIIRA6czeHtAcNq3+IrT7Lc4fGGlNuC5R8Z2l6L9P8DAe48WVkCisN6o5J/NJrLs+W+k6AmwuPM/DRTxCV2AWVg7FaCeBZEwrNyanlEA5dhatZSd/CUDIoevgmEXEjMIxFuRy+qICZM7or2buk8Dy8oF0gIAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336993; c=relaxed/simple;
	bh=/V9pvbHowEpCRCk9hleLHywgRKgd3SM8/mt4kfV+xkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQr+mWhjDPXvAkI7HkivaJX6xyLHorwKNcH1SHD4VfX+ujBSAVT9W2gpLEZmvReJkHEGDXFI05Rvoa8p6GAWdefQkeyVMvzWlTm7JE5VchoZwPrd+OK4ZGwrrp391kYZIaJem4aSLXhPIb+29b+cygS+ll0j5zQ2vYydKo+wGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+mYVQ35; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+mYVQ35"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9565cc13aso621626a34.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336991; x=1782941791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnI+LXrM2QyCrokYq9KWa44fCiEdP/VldON4Epkf0b4=;
        b=Z+mYVQ35xtMPVdiy5UApd7cvUrYFTt/3L2yt/av33UlIu7JnL7Io57bRTUsSruGBVz
         dxZ7rkOxWEdy4kFysEuYZstlc6dE7wTPfm0A1mfgjyEa4FZLsqvj+awdQ9+cNgQFlxxq
         9ipOMdtCqdfR1EXZn+9AZoeBnjjMSVme69lCcA4H66XS9Bno3TarWywdB4TegM8crfz4
         3IJ1kC+G7XdyGnjYfSkXVK01hm9GSryLhsWXj5d1ZsGPX4kmpRY3UJpsl2iNlAJuQNnq
         mcWEjvJRbiHDOZGAJ8UElEKQo7rveM7rcjk6nXTC6bQDWFFmODiuHxJhxZ+t/ucpASEh
         L9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336991; x=1782941791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnI+LXrM2QyCrokYq9KWa44fCiEdP/VldON4Epkf0b4=;
        b=i/m15061eBkfPNwpu0c+LVwH7jSSIvyDNAduHOkgatHWaQESv5dZ/zw+C3zEJM4P5t
         oCEIrOl7ZPqEz/vRK71J6Mvao3dPivA1ggQB7HZNb9MnxPV28Ao9u+yBucIjnLwF72Xz
         vtP6dNTFwaihhBcNaRooVB+2hB4XnMQEFDnmyyTQszp7qtX/txE6SADEqyhr/MPAJ10c
         +273lUpOkkGFK2cYJpHQxiS5X+QE3B/8MkcXopiXL5pcH9rFhIJ+1cUc1Urkch8lGA6D
         /TPTwTvkY5zuqAaXxuCfl1eZnU6Y1EW9MTsqn5IiMK/ZWR6eEHzGHo9Yzj/ng+WtDlcq
         mj2A==
X-Gm-Message-State: AOJu0YxADz/3Eg8SjITgmxVRIO24Zvg8wN3i7YzBmaJPcXOdkgC575Oh
	LuL1nqAGI1DNweu0iCH5z0oAqYoFG/0IKTms87YbxgmwGk8ooqwpAeMI
X-Gm-Gg: AfdE7cnw0X0XBdjlLY824IXuYf7R2g8024M/9YVWjvslRtnzopyIbijERYCyTQ/mdH1
	UETf+mBvmBxmRlbWeefsyf8ImKamyCauApUtRypU+zddfITQ9aBlrWlyn4w8tpq++bfpFSGYuVP
	E5do9L26icH80y8+5Y66WcA7C3jK5B2byTgfzolJMYC3KNhKmrCd54M90l09d3NJhWATdYJnXcj
	SW6RavOoqBjMhv/uaLgRpl6BkWGn82zGlaDO0AoY1f4Vr7b9hS5TUh9pSl4dZ8VzNcZJy2QbRUq
	EpbwixMxm3x+moiNR6jopuIwCsQTDBRQEkiGsgy2XSMEJLwhgK9KvoaLFaR6Fs1Ie+Xm0dXsMPn
	4vsgucC7/+db8K9DeYxhjFpVpaxjX0hD9rKrStPq3TXnCbgqXyaSuSqI/A+1p5o1QUuCBCqJj4g
	XpcNGRxg==
X-Received: by 2002:a05:6830:3697:b0:7dc:c4ae:a689 with SMTP id 46e09a7af769-7e9792ecf9bmr7632880a34.2.1782336991270;
        Wed, 24 Jun 2026 14:36:31 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944068bb7sm11987329a34.9.2026.06.24.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:36:30 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:36:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 08/11] refs/files: lazy-load configuration to fix
 chicken-and-egg
Message-ID: <ajxKh-IrC2EPWJnW@denethor>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-8-018475013dbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-8-018475013dbc@pks.im>

On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> When initializing the "files" reference backend we read the repository's
> config to parse "core.preferSymlinkRefs" and "core.logAllRefUpdates".
> This results in a chicken-and-egg problem though, because parsing the
> configuration may require us to have access to the reference store
> already when an "onbranch" condition exists.

Ok so both of these configuration options are currently parsed at ref
store initialization time. This is problematic because we need the ref
store to properly handle "onbranch" conditions in the config.

> Luckily, all the configuration that we honor only relates to writing
> references. Consequently, we don't strictly need that configuration to
> be readily available at initialization time, and we can easiliy defer
> parsing it to a later point in time.

That's nice. So we don't actually need this configuration during
initialization and can instead lazily load it when writing the first
references. Makes sense.

> Implement this fix and add tests that verify that we can indeed properly
> parse these config knobs via an "onbranch" condition.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c        | 37 ++++++++++++++++++++++++++-----------
>  t/t0600-reffiles-backend.sh | 21 +++++++++++++++++++++
>  2 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 79fb6735e1..d0f379dcd6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -84,12 +84,14 @@ struct files_ref_store {
>  	unsigned int store_flags;
>  
>  	char *gitcommondir;
> -	enum log_refs_config log_all_ref_updates;
> -	int prefer_symlink_refs;
> -
>  	struct ref_cache *loose;
> -
>  	struct ref_store *packed_ref_store;
> +
> +	struct files_ref_store_write_options {
> +		enum log_refs_config log_all_ref_updates;
> +		int prefer_symlink_refs;
> +		bool initialized;
> +	} write_opts_lazy_loaded;

It might be nice to leave some sort of breadcrumb comment to future
readers to explain why we lazy load this configuration.

>  };
>  
>  static void clear_loose_ref_cache(struct files_ref_store *refs)
> @@ -121,17 +123,31 @@ static int files_ref_store_config(const char *var, const char *value,
>  				  const struct config_context *ctx UNUSED,
>  				  void *payload)
>  {
> -	struct files_ref_store *refs = payload;
> +	struct files_ref_store_write_options *opts = payload;
>  
>  	if (!strcmp(var, "core.prefersymlinkrefs")) {
> -		refs->prefer_symlink_refs = git_config_bool(var, value);
> +		opts->prefer_symlink_refs = git_config_bool(var, value);
>  	} else if (!strcmp(var, "core.logallrefupdates")) {
> -		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
> +		opts->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
>  	}
>  
>  	return 0;
>  }
>  
> +static const struct files_ref_store_write_options *files_ref_store_write_options(struct files_ref_store *refs)
> +{
> +	struct files_ref_store_write_options *opts = &refs->write_opts_lazy_loaded;
> +
> +	if (opts->initialized)
> +		return opts;
> +
> +	opts->log_all_ref_updates = LOG_REFS_UNSET;
> +	repo_config(refs->base.repo, files_ref_store_config, opts);
> +
> +	opts->initialized = true;
> +	return opts;
> +}
> +
>  /*
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
> @@ -156,9 +172,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>  	refs->packed_ref_store =
>  		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
>  	refs->store_flags = opts->access_flags;
> -	refs->log_all_ref_updates = LOG_REFS_UNSET;
>  
> -	repo_config(repo, files_ref_store_config, refs);

Configs are no longer read eagerly during initialization.

The rest of this patch looks good to me.

-Justin
