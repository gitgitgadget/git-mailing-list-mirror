Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B22AD24
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797791; cv=none; b=I9k4amYChZ12+blKVo2AA9daI+xkFtg7ixLtvYi8s9gy80AGhAKFcEjXSzsuA6XeYNu05ILKRkQZ9ZGAYi0C69JluSpla0qTMv2GIXv9c7zANHSZ2cFXwpEx69M4Rw6Ngdv1+vKohFmnJbK7em41c++UgIvJkAN3f/9EtNGUWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797791; c=relaxed/simple;
	bh=+XbzBbb5PfbBHI1LfU8B54QtLAYMdvk7BEzgCmvZQ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Ey0UzNE9JAEBQ4X/T9hja6cVYl0TMps6e6Xk8LNsV05GhYIsDiCtTCMBabR+uu3fRhqhX2KdoOq20qYdupJUEWnY8YS6RCMYYeO/H7SihjtVDUkiz7Wpw/H98RHE0GO+BWj1jf/XhJ2EcvZlK81bB4nwiM1L4YpIYgOZM2qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k/nasjYH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k/nasjYH"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-711d4689084so14097137b3.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752797789; x=1753402589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdWsLa3sCzfpcOIIU2x8ysYorYIpkuRLCFWNwJFyW6A=;
        b=k/nasjYHxinUEp7qL8aFkkL+e7FqqkfqKWeUXERcWODAqETow/ViR0b1vC5Hy/8JlT
         59WkpBHCzz87BIZl5t8BTnXNrLN10BCRiZZ3sODMskxZ/XYtwAu9fBPf7LenyRoztgF+
         N/cD6/9VQ3V1jzVlj2pTq+kRqE7idtmyCvfyZrgjlpwS7s9VUrFFGwtm+Zry0Pw1V2Gw
         ipZGlwCHcst9070av0vn9LZh7JELoQw3YjRxAq0h21YjvDIO8fSM95xhjbg1qHC36DPL
         GydEekTxN4diQga4ILLQgYtccDtLwtodORcpFTQEdTs+pitHwMaUVZe3yA7lEk8iSFai
         F/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797789; x=1753402589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdWsLa3sCzfpcOIIU2x8ysYorYIpkuRLCFWNwJFyW6A=;
        b=LdtbBJe88eD3MWH6uS9etCTktGzs/oQwV1APFkQH4slfhR+x+Wy9h0XJyY5+b9Av5w
         szxKaUVoGfcYPWuBeUnZrPDe+lgFE17JuOzPzSYV0tw9KcRY+gBSOv6ngGom72ot8k/n
         5hIUCZAvXYehazGOwKxvRCYPLsghmLZ+/iSWQAO8eutY8hKHR6eCf3mTQMKC4iQWUFvf
         c5GAfs/cCQyuHRimYzrJ5cg6AYQgdVhnqP60lwzgLQuC0d/mPQ3JhgG+1230OlQYKbA5
         dm9fOykvjReeQ8juoNUP/WT6BHSjsJ2qxZ6rvE51N3yWj9YNEXCkXeH/ZvYXmXQkqCY3
         niyA==
X-Gm-Message-State: AOJu0YxxAmWd+c1kkhFo2maUjT6Kd+PgojFldw49Molx42JwdwgwBDBj
	bltbV6j6tlWwvmjUhSUF1iwfDSiqHg708Dfl8s0be5qiiTRiSsuCru72Ai/ofMrYhtISty4SLIM
	coKXKN40=
X-Gm-Gg: ASbGnctX74nWak1tdu2sg34ml/WXe/BMYklgYfJdxvAm5viBdpSJf6w6YfizBUmnCkl
	0OTQydbHvY24Z6ho5Q6mWsii+qjksRjL+LhTTaGDW7dcnlEaeeiQxj9sOyO1IWRMIM5694phSvQ
	mv1XfWCwj1FAUx8Eb01D9xJBJ+O2dT4h417c/GXgnylVKBZv73rRIgbznOhiYcjuWohm/hK3CmO
	OO5dUgEN8uBEiYhN+YtZdOcDIJqp+cXD5qw/Ool2cQGBVUvHSZpP38rwdOD57l/4IHNAlHx1Plc
	rhhKOrUZhbnp4+jJlzrOW37P6SwyJpx1+Nued1dtb5cA4TFewqObIHLBMa+74a94gKpybaqFpWd
	Nf3EE+0Elf3YnNAw5gwiqfbmoJKTCucq9vjw+X/+wlgVpWp6ibKe/r6Wasta/G7POSU/ZAMPhqY
	Ih2BX0
X-Google-Smtp-Source: AGHT+IEklYQMUee5NlVi0E0Z4AbBdWbX9okh7r98n+6VsqhBx/aQFqm6M1gPvnFFK0Yz2t16c2I//g==
X-Received: by 2002:a05:690c:18:b0:712:de91:53d4 with SMTP id 00721157ae682-71835041da3mr142290437b3.24.1752797789004;
        Thu, 17 Jul 2025 17:16:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7195310adedsm807227b3.18.2025.07.17.17.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:16:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:16:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/6] last-modified: use Bloom filters when available
Message-ID: <aHmSW1pOUF0U3KFk@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-3-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716133518.1788126-3-toon@iotcl.com>

On Wed, Jul 16, 2025 at 03:35:15PM +0200, Toon Claes wrote:
> Our 'git last-modified' performs a revision walk, and computes a diff at
> each point in the walk to figure out whether a given revision changed
> any of the paths it considers interesting.
>
> When changed-path Bloom filters are available, we can avoid computing
> many such diffs. Before computing a diff, we first check if any of the
> remaining paths of interest were possibly changed at a given commit by
> consulting its Bloom filter. If any of them are, we are resigned to
> compute the diff.
>
> If none of those queries returned "maybe", we know that the given commit
> doesn't contain any changed paths which are interesting to us. So, we
> can avoid computing it in this case.
>
> Comparing the perf test results on git.git:
>
>     Test                                        HEAD~             HEAD
>     ------------------------------------------------------------------------------------
>     8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
>     8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
>     8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%

As an aside on 8020.3 (that I probably should have mentioned in the last
commit), I think that our "| head -n1" heuristic for picking a sub-tree
is skewing these results down. In git.git, the lexicographically
earliest sub-tree is ".github", which is awfully tiny. I wonder if we
should be grabbing the *last* sub-tree, or maybe the largest one by
count of entries?

> @@ -40,6 +43,12 @@ struct last_modified {
>
>  static void last_modified_release(struct last_modified *lm)
>  {
> +	struct hashmap_iter iter;
> +	struct last_modified_entry *ent;
> +
> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
> +		clear_bloom_key(&ent->key);
> +

I did a double-take to make sure that ent->key would always be
initialized here, but it is thanks to the FLEX_ALLOC_STR() call below.

>  	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
>  	release_revisions(&lm->rev);
>  }
> @@ -67,6 +76,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
>
>  		FLEX_ALLOC_STR(ent, path, path);
>  		oidcpy(&ent->oid, &p->two->oid);
> +		if (lm->rev.bloom_filter_settings)
> +			fill_bloom_key(path, strlen(path), &ent->key,
> +				       lm->rev.bloom_filter_settings);
>  		hashmap_entry_init(&ent->hashent, strhash(ent->path));
>  		hashmap_add(&lm->paths, &ent->hashent);
>  	}
> @@ -126,6 +138,7 @@ static void mark_path(const char *path, const struct object_id *oid,
>  		data->callback(path, data->commit, data->callback_data);
>
>  	hashmap_remove(data->paths, &ent->hashent, path);
> +	clear_bloom_key(&ent->key);

OK, we're calling clear_bloom_key() here, too, but it uses
FREE_AND_NULL(), so calling it again in last_modified_release() may be a
noop, but won't ever be a double-free.

> @@ -238,6 +276,13 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>  		return argc;
>  	}
>
> +	/*
> +	 * We're not interested in generation numbers here,
> +	 * but calling this function to prepare the commit-graph.
> +	 */
> +	(void)generation_numbers_enabled(lm->rev.repo);
> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);

Hmmph. I think when I originally wrote this I was using the side-effect
of calling generation_numbers_enabled() as a hack. But I think that it
may be worth making "prepare_commit_graph()" a non-static function and
calling that instead.

Thanks,
Taylor
