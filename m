Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F09409635
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273825; cv=none; b=BxjBp607xFOjL1KWMhvQgzwFzbjZff6eZ87ZpMYOWt2AkDJrhWsKyMHH63ei02hGqxzBbOqLOSCO7wyeRNkR0tjLUMLyUnlPV1BVVO/UhQSQTZbfS8uJaLIyRo4rM9e0/xD8YfPLpRRSAqHJPfF14/CczeMaETqR5nEO7Hqdr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273825; c=relaxed/simple;
	bh=UveUaBYBFO6GSvx9p9622Bmn9yDFMTc4+2/Rnq3kI48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4g3xbkj7BsrLxpYSJd7JmFVfu3DaDCd3mNPSjHisXPQ3kzmgwid3msybKPRRfZacdU41TsdISMuDvDHSPolAf9d3WBua7q1xvdo76KA3WBNpHlUDJ+JLIlQJlr04Y0AEwswR1uFCtZYau53qzrgV8gr32Rb3yDsdGIrU0kqnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Nw7knV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Nw7knV"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a475409044so127322b6e.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273823; x=1785878623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNF1zeFH6Y8xhuv0NmKTdtQa8c5AgjuT37FxHUndgKU=;
        b=h5Nw7knVmokm7+rElia09cJx3e4GxJKbfuaQRVc+6cXxIG6koA2gpSrnC5XeNBMr6J
         McPZ03LgPhN/UY9WIOX8Cz4B189EuVcWWwh96OzAEpctBfv6MebBiQkdh3rWOtcIeuDa
         tAsV0fsrKLO0Xqknr/tTQAydHmu3O/J9g42PbnH2G7yjXeZnN3LWGYQFnumVdNmpffN6
         h1RbpdYNEkbopvyWKgx3QZGz+698NO2F95eOP41QutgzOvZgbXVUWTJ3/IPDjjOtvpCH
         8syY9iJ0osLs6eKNGyQobgHo42eAZzv9aGNU+LvR//8lfUyf4sSJ5gwybRW/nLbH4XSi
         GZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273823; x=1785878623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNF1zeFH6Y8xhuv0NmKTdtQa8c5AgjuT37FxHUndgKU=;
        b=OwHAvxP2KD2DOWJkLBMLBYr2xMXEUPPN+mQ7W+M3G74itwxnZ3gBGXJUZoY3CQgG4p
         +12ZQjtmNmvJ61z/m5VmEhSI2hkWOin1YL345SVDLGIVrnlcvk9rQEuYCw/BDUCS0lRd
         JV+ouDrdP9UTGhI336V+1/naw0PI9tbWz9UlQGiQjsgjU56rHvUnr1zgK7WCybDNW8lz
         TMTQrXm93icVqadqP2xS4G4HLl+dhSQpCxPXcEgPAeWfJfggPnMFmOWsEGPeRwz26OxT
         kfcR7Rhu/XfJz6Z/+Rho7yJTmkdjKdPZpmagF9v0b9GaqA1GBNzca70gfu5NM6CLjCMc
         Hi3A==
X-Gm-Message-State: AOJu0YwBGYtl2DcR656jo1MUvgyMmc2B3WcRZQK09lUGiM/SSN6dC2+t
	vuqJG/TLK4zB2mcg4eeb5yZa4J6zTb30NdcAna4FQQFN1HT0sYfL9eHoKSd/9Q==
X-Gm-Gg: AR+sD10sb35U1D3DkomM4lyYnYJvo7K1c1LXDxlycyb2N5aqGVffxl/dzKOeTPWkoz3
	yrOycmAmvuaFw6cVJf+uH2wh/3bDz2Zo/ZkVkgoTDjEt+Fh2j3ScodAT/jj7LSIcNI9R5G/eGxD
	YPfKYI9fu1u6JzA1FQh5Sl75lucPsIbZC9cBKCDmd9Xx1XHCPEoDzIXpHnQ/vbqpLG/MrRtN4NF
	/BvpzHE7OwahW0JUOjW1BZxrfJ93+PueAM640AJ6xK8/mzmwgAgRj45siDo5s2qT8g4ua9CWOJr
	uqg6fmjblcezfLC/OhjS4XKAFujyw+mOjxLDfaAz41hN9nFRrQEPgxRx3QDis712Z9o2L2A09vU
	cvKPGmaAowtisNum5VijMrrE4d08PAwfs/OB7EiIuX9d8zXd0xijXzt8SA93Pdo4W5FCW1dkWjf
	PSYAexPUXNiBhA3qenfwll3/37c3B3JL66iBUu5xgLsp6Ekn8fp/z12D9/4g+S4AGRAA==
X-Received: by 2002:a05:6808:1908:b0:49a:8f0d:cdbb with SMTP id 5614622812f47-4ad5bd29b67mr2997502b6e.31.1785273822624;
        Tue, 28 Jul 2026 14:23:42 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc9c91sm227668b6e.16.2026.07.28.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:23:42 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:23:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] odb: make creation of on-disk structures pluggable
Message-ID: <amkcNhMTKqWdLXwX@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>

On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> When creating a new "files" object database source we have to create a
> couple of directories. These directories are of course specific to this
> particular backend, and a different backend may require a setup that is
> completely different.
> 
> Make the creation of on-disk structures pluggable to accommodate for
> this.

Ok.

> Note that there is one exception though: the "objects" directory must
> exist in a repository regardless of which backend is in use. If it
> doesn't exist then the repository is not treated as a Git repository at
> all. Consequently, we create this directory regardless of the backend.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 19 +++++++++++++++++++
>  odb/source.h       | 23 +++++++++++++++++++++++
>  setup.c            | 35 ++++++++++++++++++++---------------
>  3 files changed, 62 insertions(+), 15 deletions(-)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 4138758511..0db6e681fe 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -9,6 +9,7 @@
>  #include "odb/source-files.h"
>  #include "odb/source-loose.h"
>  #include "packfile.h"
> +#include "path.h"
>  #include "strbuf.h"
>  #include "write-or-die.h"
>  
> @@ -41,6 +42,23 @@ static void odb_source_files_close(struct odb_source *source)
>  	odb_source_close(&files->packed->base);
>  }
>  
> +static int odb_source_files_create_on_disk(struct odb_source *source)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +
> +	safe_create_dir(source->odb->repo, source->path, 1);
> +
> +	strbuf_addf(&path, "%s/pack", source->path);
> +	safe_create_dir(source->odb->repo, path.buf, 1);
> +
> +	strbuf_reset(&path);
> +	strbuf_addf(&path, "%s/info", source->path);
> +	safe_create_dir(source->odb->repo, path.buf, 1);
> +
> +	strbuf_release(&path);
> +	return 0;
> +}

This is the callback to create on-disk state specific to the "files"
source and matches the current set of created files.

> +
>  static void odb_source_files_prepare(struct odb_source *source,
>  				     enum odb_prepare_flags flags)
>  {
> @@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  
>  	files->base.free = odb_source_files_free;
>  	files->base.close = odb_source_files_close;
> +	files->base.create_on_disk = odb_source_files_create_on_disk;
>  	files->base.prepare = odb_source_files_prepare;
>  	files->base.read_object_info = odb_source_files_read_object_info;
>  	files->base.read_object_stream = odb_source_files_read_object_stream;
> diff --git a/odb/source.h b/odb/source.h
> index ab16d152f4..4abc418bdd 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -89,6 +89,18 @@ struct odb_source {
>  	 */
>  	void (*close)(struct odb_source *source);
>  
> +	/*
> +	 * This callback is expected to create on-disk data structures that are
> +	 * required for this source to operate.
> +	 *
> +	 * The callback is expected to return 0 on success, a negative error
> +	 * code otherwise.
> +	 *
> +	 * This callback may be NULL in case the source does not need any
> +	 * on-disk setup.
> +	 */
> +	int (*create_on_disk)(struct odb_source *source);
> +
>  	/*
>  	 * This callback is expected to prepare the source so that it becomes
>  	 * ready for use. It optionally clears underlying caches of the object
> @@ -316,6 +328,17 @@ static inline void odb_source_close(struct odb_source *source)
>  	source->close(source);
>  }
>  
> +/*
> + * Create on-disk data structures that are required for this source to operate
> + * correctly. Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int odb_source_create_on_disk(struct odb_source *source)
> +{
> +	if (!source->create_on_disk)
> +		return 0;
> +	return source->create_on_disk(source);
> +}
> +
>  /*
>   * Prepare the object database source and clear any caches. Depending on the
>   * backend used this may have the effect that concurrently-written objects
> diff --git a/setup.c b/setup.c
> index a7b1b9eaef..14ef119cb7 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2666,29 +2666,34 @@ static int create_default_files(struct repository *repo,
>  static void create_object_database(struct repository *repo)
>  {
>  	char *object_directory, *alternate_object_directories;
> -	struct strbuf path = STRBUF_INIT;
> -	size_t baselen;
>  
>  	get_object_directories(&object_directory, &alternate_object_directories);
> -	repo->objects = odb_new(repo, object_directory,
> -				alternate_object_directories);
>  
> -	strbuf_addstr(&path, repo_get_object_directory(repo));
> -	baselen = path.len;
> -
> -	safe_create_dir(repo, path.buf, 1);
> +	/*
> +	 * Create the "objects" directory in the common directory. This is done
> +	 * so that the repository can be discovered regardless of the backend
> +	 * used.
> +	 *
> +	 * Note that we only do this in case the object directory wasn't
> +	 * overwritten via an environment variable. If it _is_ being overridden
> +	 * then we skip this step, as the repository won't be discoverable
> +	 * anyway without the environment variable.
> +	 */
> +	if (!object_directory) {
> +		struct strbuf objects_dir = STRBUF_INIT;
> +		repo_common_path_append(repo, &objects_dir, "objects");
> +		safe_create_dir(repo, objects_dir.buf, 1);
> +		strbuf_release(&objects_dir);
> +	}

Here we always create the objects directory regardless of the backend.
Looks good.

> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/pack");
> -	safe_create_dir(repo, path.buf, 1);
> +	repo->objects = odb_new(repo, object_directory,
> +				alternate_object_directories);
>  
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/info");
> -	safe_create_dir(repo, path.buf, 1);
> +	if (odb_source_create_on_disk(repo->objects->sources) < 0)
> +		die("failed creating object database");

Here we invoke the pluggable callback to create source specific on-disk
state. Part of me does wonder if this would be better to include this
inside of `odb_new()` and enable it with a specific flag, but having it
as a explicit separate step is probably fine too.

-Justin
