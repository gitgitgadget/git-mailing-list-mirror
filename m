Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91A1E507
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713291; cv=none; b=E37OFFdEjliGLfMTTk3tEWDIgfzslNPs5TmywI6orLcLzkiiYO9XP1bfY7nWHfmN2s4yHhbuf3izsZZXDK5zqkEMsDxw4intqJmrQ8GnJsr+nh7JY/UFCR9tpqmENTS/H4uYbDDIwMFqZy1Tu7HiuLNNBNqai98fgzLaJ9JrN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713291; c=relaxed/simple;
	bh=cJOXwJkSVCUJODny7YYXOAvSQTbyLpBChY7bULcMc4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEzpLbXPLHXHqe38nZV5XuQa1WoiELrCEmoCGFz+vPeApSVqpNi9Ny8IZ+AOhX3t+JqjMepPOpEzSkoNDow0JwiTl/L2R7YF1l9agy5m3JRTKnxNjzbm3bG5LVARfb9pnSNKkiLIeznOx4Mp1DdOHspc6EJMaUOjOHMi44Nk1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aydF58b/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aydF58b/"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25d405f238so3802723276.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727713289; x=1728318089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0SznXcz2GwJvGzYevks3KlUykIzStEpvL8NnPoY/xQ=;
        b=aydF58b/xA5z5jhqfGPY2LkRiSsH9XquyWXrfdN/YzxfBLN6ZcxcVLg+4vydohW4kQ
         Gae1qFk11d303uQWAMHPoZrO5/ALcl/5ts2yoyODgAtUPCGZNODrcfKVD2OVnAH5B5X4
         iuYTsuLJrWg+ROFeh4HFQDLGmOqcuIxY1gOWZmnIakAwYKWX3yBwSRwfCb/NG3BGM+az
         zMRklCh2fzzAyAo/aB61VRSpc6o6R3vIXAqu71jpNX7Ob+1kFLV3vjwqEYDLtOrTHcNW
         Qrfa5PBmg44/ffPDx+VqOsbiLOvE+Y8ptYAieW8oTbRPkzPAmaS+vSxnZdNWfnLmJizh
         NFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713289; x=1728318089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0SznXcz2GwJvGzYevks3KlUykIzStEpvL8NnPoY/xQ=;
        b=N+zFoEkO7ERQmHgmu8++5GReYV8FgSpVicvayMUcUZBy5TLw3d7firCLebbsu7Rr1d
         QbCQrMm5uiZ6eZNSll4CfYUXcCBwKrzUthIb9skm3+7L688swA7Qc7hvBcMD6ZUvBQL5
         bklqqUSztg5egLijjBtuoa0wUHX2wYIEBIIKejIGCsDKz8JKwd2tfCEw7MlESXTM6YW+
         mCEeFOk+SxbA0sufOQff3HpV4+RWyQ3qSt4JogbXZBdqUwEfyO49kY0NtP6RJ/ACjkQh
         fLzXSEP3QR0n+A7Wlub8cGna3gfvRjcHu/I5CXZX85Mhwprg6QACgSENJ7GxtTpFhwIn
         A5qw==
X-Gm-Message-State: AOJu0Yzyav3OIsS5rOnmWoHsHJgDVpr+AtoHL+Pm2BHiClI91sHPxx22
	xt0/3m1A4vLWK/ZWXna2c51ZzWeBlG9yiiroEW/7gIup0V6g21CC+aJ0+DnxABJEMZ7RUDgCcDP
	My2E=
X-Google-Smtp-Source: AGHT+IFs7/ah+nMn1sTmM5pia6uFVfX6V7LReUZ2+TP2LuP/8C0jsFaPZooM9v/QOmHPGjaQ+n6BXA==
X-Received: by 2002:a05:6902:2089:b0:e22:6a94:f22f with SMTP id 3f1490d57ef6-e2604b47f8dmr10009996276.28.1727713289196;
        Mon, 30 Sep 2024 09:21:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3efab1dsm2425936276.6.2024.09.30.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:21:28 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:21:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/23] pseudo-merge: fix various memory leaks
Message-ID: <ZvrQByUPoHhlDMiF@nand.local>
References: <cover.1727687410.git.ps@pks.im>
 <6e7a272c29577536ba992cc73d736d8f66397607.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e7a272c29577536ba992cc73d736d8f66397607.1727687410.git.ps@pks.im>

On Mon, Sep 30, 2024 at 11:13:51AM +0200, Patrick Steinhardt wrote:
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 4dc0fe8e40..6413dd1731 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -64,6 +64,12 @@ static void free_pseudo_merge_commit_idx(struct pseudo_merge_commit_idx *idx)
>  	free(idx);
>  }
>
> +static void pseudo_merge_group_release_cb(void *payload, const char *name UNUSED)
> +{
> +	pseudo_merge_group_release(payload);
> +	free(payload);
> +}
> +
>  void bitmap_writer_free(struct bitmap_writer *writer)
>  {
>  	uint32_t i;
> @@ -82,6 +88,8 @@ void bitmap_writer_free(struct bitmap_writer *writer)
>  	kh_foreach_value(writer->pseudo_merge_commits, idx,
>  			 free_pseudo_merge_commit_idx(idx));
>  	kh_destroy_oid_map(writer->pseudo_merge_commits);
> +	string_list_clear_func(&writer->pseudo_merge_groups,
> +			       pseudo_merge_group_release_cb);

Looking good, and this is the right spot to free the pseudo-merge
groups. Note for other readers: pseudo-merge "groups" are a utility
structure that is only used while writing pseudo-merge bitmaps, so we
don't expect to see any corresponding pseudo_merge_group_release() calls
sprinkled throughout, e.g., pack-bitmap.c.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 9d9b8c4bfb..32b222a7af 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1390,8 +1390,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		}
>
>  		base = bitmap_new();
> -		if (!cascade_pseudo_merges_1(bitmap_git, base, roots_bitmap))
> -			bitmap_free(roots_bitmap);
> +		cascade_pseudo_merges_1(bitmap_git, base, roots_bitmap);
> +		bitmap_free(roots_bitmap);

I probably would have pulled this leakfix into its own separate patch,
since it's not immediately obvious how it's related to other changes in
the same patch.

But the change here is definitely correct. We initialize the
roots_bitmap field to just the tips of our traversal. I wrote some
details about why in 11d45a6e6a (pack-bitmap.c: use pseudo-merges during
traversal, 2024-05-23), but the gist is as follows: We want to avoid
accidentally thinking that roots which aren't part of some satisfied
pseudo-merge or existing bitmap are part of the reachability closure,
leaving those bits as dangling and leading to incorrect results.

In any event, we definitely do not need the roots_bitmap outside of that
block (regardless of whether or not we successfully cascaded any
pseudo-merges), so free-ing it here is the right thing to do.

> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 10ebd9a4e9..28782a31c6 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -97,6 +97,25 @@ static void pseudo_merge_group_init(struct pseudo_merge_group *group)
>  	group->stable_size = DEFAULT_PSEUDO_MERGE_STABLE_SIZE;
>  }
>
> +void pseudo_merge_group_release(struct pseudo_merge_group *group)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	regfree(group->pattern);
> +	free(group->pattern);
> +
> +	strmap_for_each_entry(&group->matches, &iter, e) {
> +		struct pseudo_merge_matches *matches = e->value;
> +		free(matches->stable);
> +		free(matches->unstable);
> +		free(matches);
> +	}
> +	strmap_clear(&group->matches, 0);
> +
> +	free(group->merges);
> +}
> +

All looks good here, I didn't see any fields that were missed or
over-eagerly free'd here.

Thanks,
Taylor
