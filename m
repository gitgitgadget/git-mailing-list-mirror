Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF71377ECC
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926924; cv=none; b=cURvHMSyNSCWXZmVQQADnSElLQyyjcEydMhJ6bYu1RbMUIZd8EXX/QWnOcck3oZFyn4Iol+2dEsnNtA050Jyx0OmHQ5DXE19cw/IkxE8EE6k5n9A8UHtgw8zh4PtI+I0dA/pNbGx41hpkH/XZ/R6aBBhWQdwsY6fjGF16FxEwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926924; c=relaxed/simple;
	bh=btugE8STRWCfPOJaIUKZhn2IQ17uGp7vvGC6qTdZmog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O65sW7jm9BSMnUm5JE6a8sGfEQULcbzM95QeuejTSzp7vxWBPM5EFNkf63uaNPLBkTVxt4u7gyNhedEV3Uk7u3NUYT7Ex6kflGfH4Y8/P/PoW5Qs7nn+4d8W9ZrQdpDv0HdQgSZn327P3Uc3vk40MLWpNeiH4issWTQjviLO0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHlkFgt/; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHlkFgt/"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82380b0f55dso1608593a34.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791926921; x=1792531721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAuJYMiZPrCRYH/bQfRAIECs1vtvI1nKa4YYGh+gytc=;
        b=HHlkFgt/eVLUZIvxoQI+lPzs8mVxNykpXJVPCKKkAitN8F05P+gomrlloMKl5kIsN7
         wquD7cUiujLOWmNACipsOEST7azA4cg74s2iXg25CZnmfWRXd49GT+C6fbmnx+mDymSk
         jh58DCu+B3n7/Pgb0k1dOn0q0gyibrQDZXo1ZX9zVAndJy599O0VRu9EhPe+HrhDh/0Y
         /8s7WQatXdzT3G7+Jshe5fBKmD5OuDYutAO8oU9cuHNrVzrezHqzhdcn/fZa8KZNJ7tD
         xngQQyE9dFEgt1HHJTmoE1nqtRcrEmUmboJhShlENZGewxteJItKL01y6vE7dJYB090j
         SOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926921; x=1792531721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAuJYMiZPrCRYH/bQfRAIECs1vtvI1nKa4YYGh+gytc=;
        b=g8+kXjIwO3EQSzocsHxYNbuFuPP7d3g19nqkI+9PzTPcxZyCZJzK70v83TsQXTvReI
         03lv7JCAxY0h9HgZaKRLIpalw2OmNN+o6a+8CE/tTNHLj3syd7v4+9J4CL3MsuP2lQ6v
         YAVAzIo/6ZjBCuBpXq6h1IwFp4n8dFGq0CeDwswD4ICXzKGb7ezln3gwPwm47ovezTXu
         HNVc9dBaHKxuAzEQj+FWnFtxZLaTItAKHQK/O2hHGR7l3xOOrko/SZis7xYkoL7WfPYH
         SsIpkbPVfjF4GawNxNkPgZA11fH33TDrzwi9JCsC75IG/v8XxhLJrzvuopDGwL3zHPUk
         UhzQ==
X-Gm-Message-State: AFq9FYItEF9/viYHrfnppXFWH2tRupqbkjQ0A5NNABv6R42UJ7OLEJIs
	I0LhyCVGhblwhQzHqUjPsRXui43nDwag+05cHiosdlXm6QwS7q30IO2o
X-Gm-Gg: AYBFou30KpUjztl8anJwdB6b/stkR1geIvIQ+x5OKN0XISxiqyvc77eObpjbyzQBhSl
	f/YRbDfYAmAzIr57C/YjR6OjXI9gQVnARvY7w7KwpnlbMr9tfUzwC4+kgOVG2lkH6Cbol+TONOU
	RyP5WwY4eiDDWnEfsyR/Then3zWwfHR//jMAgbvRqI1YzKkWwFoxilT2CTkOxy7kpMWQNvqwoTj
	vMqsCe9odVKbXw9QZ7mYZgFyoVG1l/ruQyCgEGHXQGTt5jaMzgXJplbwdL9wLYbX7mGl7sNvdRb
	DNeXXYvHPwcqUW2TomK+X6KAzkXy7yo7VQ+f+sUrsTo3XlH0oyjluu57WxrTTB8NSUdhZ48b7Ne
	pWBwp95zOlLQ9+C8HHRI+LXV8dwZ4lpCX49ymSmiDRYzguqTbA/AgIRnLMiuR8IieQhiLhyGO2I
	yusqeNj4kprXjd1J2DCBaY0b123Kl9SdaAcxxhQ1uAq1eyOUSSTjZC/naS7FUJhfejT53FtH4yP
	YMqWkoJIfdjZ+Dc7Hb/n/s=
X-Received: by 2002:a05:6808:14c8:b0:4cb:abff:6351 with SMTP id 5614622812f47-50c516e4241mr15330436b6e.27.1791926920880;
        Tue, 13 Oct 2026 14:28:40 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c19f4c066sm14559847b6e.11.2026.10.13.14.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:28:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:28:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 3/5] odb/source-files: make the second read an
 implementation detail
Message-ID: <as6al15q80dII-bk@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-3-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-3-b7030ff2b26f@pks.im>

On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> When looking up an object fails we perform a second read in all sources
> with the `OBJECT_INFO_SECOND_READ` flag set. This flag tells sources
> that the first lookup has failed and that they should reload any on-disk
> state that may have changed in the meantime so that the object may be
> surfaced after all. The "packed" source uses this to reprepare its
> packfiles, whereas the "loose" source short-circuits the second read
> because there are no caches to flush.
> 
> This logic lives in the generic object database layer even though it is
> highly specific to how the "files" backend handles its reads. But now
> that alternates are an implementation detail of that source, we can
> easily move that logic into the backend, as well.
> 
> Move the logic into the "files" source and drop the flag.

Very happy to see this flag go away. It always felt rather leaky to me.
:)

> Note that the "packed" source also used this flag to figure out whether
> it should try to surface an object via a packfile that should have the
> object as determined by a multi-pack index, but where the packfile has
> vanished. The multi-pack index is stale in that case, and that scenario
> should really only happen when the process is racing with a concurrent
> maintenance task.
> 
> This code is adapted to instead use `OBJECT_INFO_QUICK`, which means
> that the fallback may trigger on the first read already, but not in a
> case where callers know to handle false negatives already. In the worst
> case this could cause another scan through all packfiles covered by the
> multi-pack index. But that scan should be fast enough anyway, and it
> only triggers when we hit the race. So the effect thereof should be
> limited.

Would it be more correct to say that we are now using the absence of the
OBJECT_INFO_QUICK flag trigger the fallback?

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c               | 15 ---------------
>  odb.h               | 12 ------------
>  odb/source-files.c  | 13 +++++++++++++
>  odb/source-loose.c  | 10 ----------
>  odb/source-packed.c | 15 +++------------
>  odb/source.h        |  7 -------
>  6 files changed, 16 insertions(+), 56 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 98c5c862f5..69a4c203bc 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -285,21 +285,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  		if (ret != ODB_READ_NOT_FOUND)
>  			corrupt = true;
>  
> -		/*
> -		 * When the object hasn't been found we try a second read and
> -		 * tell the sources so. This may cause them to invalidate
> -		 * caches or reload on-disk state.
> -		 */
> -		if (!(flags & OBJECT_INFO_QUICK)) {
> -			ret = odb_source_read_object_info(odb->source, real, oi,
> -							  flags | OBJECT_INFO_SECOND_READ,
> -							  corrupt_err.len ? NULL : &corrupt_err);
> -			if (!ret)
> -				goto out;
> -			if (ret != ODB_READ_NOT_FOUND)
> -				corrupt = true;
> -		}

We no longer perform the second read at the ODB level so this code is
no longer needed. This is also the only callsite that sets the flag.

> -
>  		/* Check if it is a missing object */
>  		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
>  		    !already_retried &&
> diff --git a/odb.h b/odb.h
> index 0ccc47ee73..dd85b880a7 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -383,18 +383,6 @@ enum object_info_flags {
>  	/* Die if object corruption (not just an object being missing) was detected. */
>  	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
>  
> -	/*
> -	 * We have already tried reading the object, but it couldn't be found
> -	 * via any of the attached sources, and are now doing a second read.
> -	 * This second read asks the individual sources to also evaluate
> -	 * whether any on-disk state may have changed that may have caused the
> -	 * object to appear.
> -	 *
> -	 * This flag is for internal use, only. The second read only occurs
> -	 * when `OBJECT_INFO_QUICK` was not passed.
> -	 */
> -	OBJECT_INFO_SECOND_READ = (1 << 4),

Flag is removed from the ODB layer. Looks good.

> -
>  	/*
>  	 * This is meant for bulk prefetching of missing blobs in a partial
>  	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 54235821d5..9788a5adf4 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -427,7 +427,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  	struct odb_source_files *files = odb_source_files_downcast(source);
>  	enum odb_read_status status = ODB_READ_NOT_FOUND;
>  	enum odb_read_status ret;
> +	bool retry = false;
>  
> +retry:
>  	/*
>  	 * Reading an object may fail even though the object exists, for
>  	 * example because it is corrupt. Report this failure to the caller in
> @@ -435,6 +437,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  	 * prefer the first such error in case multiple reads have failed.
>  	 */
>  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> +		if (retry)
> +			odb_source_prepare(&dir->packed->base, ODB_PREPARE_FLUSH_CACHES);

Ok, for each subsource in the "files" source we can reload the packfiles
to try to find the object. Makes sense.

> +
>  		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
>  						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
>  		if (!ret)
> @@ -444,6 +449,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  	}
>  
>  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> +		if (retry)
> +			break;

IIUC, we don't need to bother checking the loose objects a second time
so we exit the look early.

Nit: Mostly just a style preference, but instead of entering the loop
just to break out early for retries, could we just return early prior
the loop starting? It looks like the rest of the function is skipped on
the second read anyways.

> +
>  		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
>  						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
>  		if (!ret)
> @@ -452,6 +460,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  			status = ret;
>  	}
>  
> +	if (!retry && !(flags & OBJECT_INFO_QUICK)) {
> +		retry = true;
> +		goto retry;
> +	}
> +
>  	return status;
>  }
>  
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 0664634938..180ce7403f 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -222,16 +222,6 @@ static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
>  {
>  	struct odb_source_loose *loose = odb_source_loose_downcast(source);
>  	static struct strbuf buf = STRBUF_INIT;
> -
> -	/*
> -	 * The second read shouldn't cause new loose objects to show up, unless
> -	 * there was a race condition with a secondary process. We don't care
> -	 * about this case though, so we simply skip reading loose objects a
> -	 * second time.
> -	 */
> -	if (flags & OBJECT_INFO_SECOND_READ)
> -		return ODB_READ_NOT_FOUND;
> -
>  	odb_loose_path(loose, &buf, oid);
>  	return read_object_info_from_path(loose, buf.buf, oid, oi, flags, errmsg);
>  }
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 2226fbd313..48fe00c2bc 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -52,12 +52,11 @@ static int find_pack_entry(struct odb_source_packed *store,
>  	 * packs, and repreparing the on-disk pack set does not reload the
>  	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
>  	 *
> -	 * Do this only on the second read, by which point repreparing packs has
> -	 * already had a chance to find an object merely relocated into a new,
> -	 * uncovered pack; only a genuine hidden duplicate reaches here.
> +	 * Skip the scan for quick lookups, which are expected to accept false
> +	 * negatives in favor of speed.
>  	 */
>  	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
> -	    (flags & OBJECT_INFO_SECOND_READ)) {
> +	    !(flags & OBJECT_INFO_QUICK)) {

Ok, instead of performing the fallback when the OBJECT_INFO_SECOND_READ
is provided, we perform it as long as OBJECT_INFO_QUICK isn't. This
likely means that the fallback would happen more frequently, but since
we are already guarded on MIDX_FILL_OWNER_UNAVAILABLE, I'm not sure that
would matter much in practice.

Overall this patch looks good to me.

-Justin
