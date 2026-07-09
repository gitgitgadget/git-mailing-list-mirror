Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E144999A
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628398; cv=none; b=ZhQcHYMrXtj36/Y0w93cdtn3Y+cwt8f64IHss7NE+ajWlruHaKlKw765+MXOo4JEy9DW0g+He1wEYvvo5qdSkjhpNbGzvM7ALHeMSsAo9NP2YOp3XHsq07SCCm8pSDi+1stxh+XkO3zWH3vhFqEiifT2VM05cCkhjk23ff61+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628398; c=relaxed/simple;
	bh=OuCvIXo3GZBwcb/16BE/aVyWz0WiKXWflVr4QQz8AMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqm0AveDmsOd0JzUVbJeedCi6fheoc3w9XI4MesopTAIzG9WJRsI4Mz6FYfIzbdSU027mGvhFK/ZuWyVlywUFzJoLHLDBiXIiqTrS81S7OMKsd16zcHsas4szAWRZjW6M4l+U6lXrup9C48PvsddAUUf+y7NJbaDOOmb70y1PkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZo79f6N; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZo79f6N"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-448479e0eb6so101096fac.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628396; x=1784233196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7OkCo9p8lXsmpoTsLydbtSsJVJuciunkHWuKBI5v5KI=;
        b=AZo79f6NpFlZmgu3Dp4j519DJsFNlN0pLBr8zlIOLhK0vdqYZMkmFG2xkLD+k4Wvwj
         EEHQydmURXUCdtk/vbeCvy/tp5xiRTJ7EmNzsQ9cccQQxfvlUEeQPIHUe9ANwAb+ltFJ
         1ugKLU4abTJ8BficsfFTGioMmALEHKG5nlBEGHfJlzyRotlsxG6bfhyNGi3j+/EYYwFo
         PbaCGKxid4ASTRAVe0emM96OgvlrYzd8wMDyN8X6VWeXG0M9Uz9SElrNLHRgPBchx8ih
         uSqCvk30vuNp6o4qjUBBleTU5YBlH3MZnt8IPmE/7j0pedCkayLzNx7J4QB/+H0GvAyx
         s3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628396; x=1784233196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OkCo9p8lXsmpoTsLydbtSsJVJuciunkHWuKBI5v5KI=;
        b=IW4mVCTeI7i6DCl0pOge9RI981DxMD/Ui1Tf9lzfn774MiO1jYEKPslvuQDGw8C3UU
         WQ16TdtVkaXUFE7VNBhiT/Xc9eI3ryLzd11TK8UaycURPxHSFAJbbugQqT+aZLlVTpMk
         As8Z/GFYDRZDrZ6CkJMzF54q44qFbMyMaF1+X4cVCPMX/4XC6fV92L6PhF+dghAtIVGs
         i9OcvThlKFit/2V36djRmRU6GqRMaHpnh/X6GdJ2AKRUqt4t+Zyqg7qPA32jxiHTZTU5
         pSblY+KEDIReZIhFy2plnQHbgCV4bo2uYMrx7KZ0IJeJSj66fVJmNkEm0aH6jW6fJhPc
         A2fQ==
X-Gm-Message-State: AOJu0YzhvbqWVT6LIe7TV1wI6PMrQVNbOFYCtTayB47gpeNC6DizPf1G
	uA8k8S2Oser8Jf936T0SoJk2L+c4uFH59DDGrH015rPw1XoJ/Lt7RlvrEp0oEg==
X-Gm-Gg: AfdE7cmmLkW3JMmI4c/0UTYhi6HBhFdzYyBJY3U4Eq8B+U3crblJp4/0CAZIDZLJY96
	50Gs7El484xk9F+8FHVZJUusYO6UoybHcyxJoe95/kkCszlViqtq2xDeOR0ycLtJR4WOXaRoStz
	7TEwgGare1rMRVq6DHSLvxK6N44UZU48vJARRuDV5CoFuWdzQP8MEtEQkhxTXYYPuOC5Wu8Fv3c
	dp39dqLAaZl8CUHjvS7ZsOaVyhiAgTbFMTZUmbthQLimX7hVpwaIfM0WAzMY8jDZ6K6gS0Xm0tk
	fOx7DZpQPjOdpn8YWahX7T+L/l/naZjBkrnMwf7ZFZc8bwKV5tz/Yweva6GugKfb7yVNFRckfwV
	6gofubLiRcowq/T18Mf+6aQBrdq+tqXuCQ94t+ozP1x5DjkGsxDJmqGtCFJ/Uf4XUfNnbRhRS/P
	LJ4y1zUA==
X-Received: by 2002:a05:6808:5384:b0:4a0:cf55:3cf0 with SMTP id 5614622812f47-4a201beed72mr7099490b6e.9.1783628395756;
        Thu, 09 Jul 2026 13:19:55 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1ad5a77e3sm4501519b6e.6.2026.07.09.13.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:19:55 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:19:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] pack-bitmap: allow aborting iteration of bitmapped
 objects
Message-ID: <alAAN6_ZqLj9tlgV@denethor>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-3-82fe014b12b3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-3-82fe014b12b3@pks.im>

On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> In a subsequent commit we'll lift iteration of bitmapped objects into
> the "packed" backend and make it accessible via `odb_for_each_object()`.
> The calling convention for that function is that the callback may return
> a non-zero exit code, and if so we'll abort iteration. This is currently
> impossible to realize though, as `for_each_bitmapped_object()` will
> ignore any return value and just churn through all objects completely.

Ok.

> This doesn't matter to the callers of `for_each_bitmapped_object()`, as
> there's only one of them in git-cat-file(1), and the callbacks we pass
> always return zero. But once we move the logic into the generic
> infrastructure it becomes a latent bug waiting to happen.
> 
> Refactor the code so that the return value of the `show_reach` callback
> is not ignored anymore. Instead, returning a non-zero value will cause
> us to abort iteration in both `show_objects_for_type()` and in
> `for_each_bitmapped_object()`.

Make sense. We want to ensure that the `show_reach` callback can
properly signal back to `for_each_bitmapped_object()` to abort.

> Note though that there's a second user of `show_objects_for_type()` with
> `traverse_bitmap_commit_list()`, and that function does indeed invoke
> callbacks that may return non-zero. This non-zero return value never had
> any effect at all though, and the callbacks that return non-zero values
> are only ever invoked via `traverse_bitmap_commit_list()`. Consequently,
> we adapt them to always return 0.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c |  2 +-
>  builtin/rev-list.c     |  2 +-
>  pack-bitmap.c          | 31 +++++++++++++++++++++----------
>  pack-bitmap.h          |  3 ++-
>  4 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ea5eab4cf8..8ff92c5272 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
>  		return 0;
>  
>  	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
> -	return 1;
> +	return 0;

I wonder why this was even returning 1 to begin with? As you mentioned,
the return value appears to be ignored anyways. I'm assuming it was
signal that an object entry was created?

>  }
>  
>  struct pbase_tree_cache {
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 8f63003709..02818b81c6 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -486,7 +486,7 @@ static int show_object_fast(
>  	void *payload UNUSED)
>  {
>  	fprintf(stdout, "%s\n", oid_to_hex(oid));
> -	return 1;
> +	return 0;

Also curious about this one too. It probably doesn't matter though.

>  }
>  
>  static void print_disk_usage(off_t size)
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index a47c231632..eda38a5433 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1695,7 +1695,7 @@ static void init_type_iterator(struct ewah_or_iterator *it,
>  	}
>  }
>  
> -static void show_objects_for_type(
> +static int show_objects_for_type(
>  	struct bitmap_index *bitmap_git,
>  	struct bitmap *objects,
>  	enum object_type object_type,
> @@ -1704,6 +1704,7 @@ static void show_objects_for_type(
>  {
>  	size_t i = 0;
>  	uint32_t offset;
> +	int ret;
>  
>  	struct ewah_or_iterator it;
>  	eword_t filter;
> @@ -1749,11 +1750,17 @@ static void show_objects_for_type(
>  
>  			hash = bitmap_name_hash(bitmap_git, index_pos);
>  
> -			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
> +			ret = show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
> +			if (ret)
> +				goto out;

The show_reach callback now wires back its return code.

>  		}
>  	}
>  
> +	ret = 0;
> +
> +out:
>  	ewah_or_iterator_release(&it);
> +	return ret;
>  }
>  
>  static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
> @@ -2062,6 +2069,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
>  			      show_reachable_fn show_reach,
>  			      void *payload)
>  {
> +	const enum object_type types[] = {
> +		OBJ_COMMIT,
> +		OBJ_TREE,
> +		OBJ_BLOB,
> +		OBJ_TAG,
> +	};
>  	struct bitmap *filtered_bitmap = NULL;
>  	uint32_t objects_nr;
>  	size_t full_word_count;
> @@ -2086,14 +2099,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
>  		goto out;
>  	}
>  
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_COMMIT, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_TREE, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_BLOB, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_TAG, show_reach, payload);
> +	for (size_t i = 0; i < ARRAY_SIZE(types); i++) {
> +		ret = show_objects_for_type(bitmap_git, filtered_bitmap,
> +					    types[i], show_reach, payload);
> +		if (ret)
> +			goto out;
> +	}

`for_each_bitmapped_object()` now has access to the underlying return
code and can abort. Looks good.

-Justin
