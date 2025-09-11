Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D87635
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631632; cv=none; b=Egl6yvaVLCs5AwyOi5eBRlbj/9clKtGfrVJHAE0xqtLwK07gsmvDJujW/iRmcTK/pGfgUlhmsjRye6V4e882SuZcj40E0wXKrzOIdSisVfWwnvLkNuoePPDMF4sMARVRiHnirO5keAIpaf0CzcKG9Qh7DngWbaeFvO7anwsDeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631632; c=relaxed/simple;
	bh=7ATogErDmn9qn8U341HtVIR3aSgCoMKysDm+gIw9mNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsocZZsKajn+t2dUz8htGVImUR6H/y9ZHmPYG4mYhFoqNlgzerbMS/GVSZkUEHZzSpEK09IVTmhEHtam1D/T7YqqfFWDgUrwWY0vFxnDsVm4VS2ydoIT9wdhqHuxGnFI2zN68fS2fJHaCbEGTyJcleI1wV1KPAbaxQpq4+0cq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Y/wymZnK; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Y/wymZnK"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-61381743635so901429d50.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757631630; x=1758236430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+EXG1xpRaWImaAX25REl3lOO+i67FlXx6uXQXbwoWg=;
        b=Y/wymZnK2Yvaqma5KV2PBQAnw+gACXfpM91lA+bY0pnyc0X/7RAXGjw7GiU/M+Czff
         Nk6xUsX5uwxjV5gkYeQbFGfmQEfsg3R/7WHrpDw84sJSSWbiES+me4kqwdUPTxxpQci6
         jCnjm6Ch+C3UM0riP3mSOVRzGFYJpa3IgRpDSPUgyDXqaI6LBpEIfntYu0hb7qId2y7n
         wKiMal1ebTM227PrBnW8t/Q2qqjUHHgd8H2l3vk1DQ1GogXuGJxHB9PziRurAb6ce4xz
         ydIv7Zu2F/NPJ+2APe4WMWglqnmNSRzQCebZQzWACFr6UhJIDsiut2aLKEssz+14NXWT
         B1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757631630; x=1758236430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+EXG1xpRaWImaAX25REl3lOO+i67FlXx6uXQXbwoWg=;
        b=uB2mwl3YDWynJT8aM1kZ1ihqivJxWHV9h5YM+IGq4djd54B4x667jzVKtsCgQADkBI
         8LgkSvsSLPL9g7oekVlLDxxMZmAefAqCUAhO0BqjXyL/sPF1iI2Dl2N6visav6drpS2G
         OkK+omefmwizn6Bh+41drwuF8A0ftQeP8iba/iKnWH9Fukn16aia63sFFt2NxStPTWfz
         5GMlW7lzZQ/o1cReagfnjnK3YIkrSBWEBKt6MwWkUAdpI4y0UC2yhi+w3xH/xwtrsQ1/
         2aSTEOjl65GgK9674xnBO1dPha3vj2HTK3mhs2Jq7wfFXP3wry4RFMcDSB9OfEFCDdct
         aGKA==
X-Gm-Message-State: AOJu0Yy4MwCWDGnbrns1u7iXBbFvGTn9VtRQaaaGDw95/xasxw7/vHRu
	LoAR67H37xe1PR/IzBf1j48FdTbbaFu7pNKGLxt0esutbFfUUePxOJGJSqJ/5lte13A=
X-Gm-Gg: ASbGnctn75N0Vq1/wQlH76rLZSf9hL24t786UhLvnWK7mQAHQSH8tFKmM3NMBp5k3jE
	hBCBab9ogbBiIqYEOlGCuXRteJ+B3u6VPDEKB7KD44CzHG/pCi38fYenzByqqnImn5J5/FcfiK3
	PQn9fln0KrS7WH8oKMdvg8koiBwE4nNge7i/Lk/s1pllv0A7+0HIMAX4qVIg7L4I2muoT+zEera
	cMYdzb5BVA8h4kA379rb77Aq1/tACftUYHUHaDbgaFmViVwSeM6ir1IkJDMRJdWvSBxsoP+H9Bp
	kW9fggcjq2vaoMA242qjkNpvI12ZU9z1aWwYaCZrAy3qDZb9qQjHkIzjekglQhC/DgXkAQTeTZX
	s8MPzui91KGa3dfcIbEkXt/9Y11MTkg5sxRzKfPwyYxAxljehCewdzovGnZCMnDDsXjBKOjP2Oq
	K7/YC8VFm/VfGTfETxu9tYhZW/6g==
X-Google-Smtp-Source: AGHT+IFud4wnK3qiGx7bGTeO/r3dj9LMQPwrB1fhj22tbOlQHvWCtK8dtCs4axaHFA7ASBbn7L0uYA==
X-Received: by 2002:a53:7b03:0:b0:604:3849:9b8a with SMTP id 956f58d0204a3-6272164e7bbmr827083d50.32.1757631629730;
        Thu, 11 Sep 2025 16:00:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f79c78dbasm6832947b3.73.2025.09.11.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:00:29 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:00:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb: move commit-graph into the object sources
Message-ID: <aMNUi9+MZd0rtmOT@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <20250904-b4-pks-commit-graph-via-source-v1-6-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-6-d932c2481e1a@pks.im>

On Thu, Sep 04, 2025 at 02:50:00PM +0200, Patrick Steinhardt wrote:
> Commit graphs are inherently tied to one specific object source.
> Furthermore, with the upcoming pluggable object sources, it is not even
> guaranteed that an object source may even have a commit graph as these
> are specific to the actual on-disk data format.
>
> Prepare for this future by moving the commit-graph pointer from `struct
> object_database` to `struct odb_source`. Eventually, this will allow us
> to make commit graphs an implementation detail of an object source's
> backend.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-graph.c | 65 +++++++++++++++++++++++++++++++++++++++++-----------------
>  commit-graph.h |  2 +-
>  odb.c          |  9 ++++----
>  odb.h          |  6 +++---
>  packfile.c     |  3 +--
>  5 files changed, 56 insertions(+), 29 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 0e25b14076..9929c1ed87 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -721,11 +721,15 @@ static struct commit_graph *load_commit_graph_chain(struct odb_source *source)
>
>  struct commit_graph *read_commit_graph_one(struct odb_source *source)
>  {
> -	struct commit_graph *g = load_commit_graph_v1(source);
> +	struct commit_graph *g;
> +
> +	if (source->commit_graph_attempted)
> +		return NULL;

I wonder if some callers will find this surprising. The current analog
of this function is commit-graph.c::prepare_commit_graph(), which does:

    if (r->objects->commit_graph_attempted)
        return r->objects->commit_graph;

, but this function returns NULL on the second (and subsequent) calls,
even if the object source in question has a commit graph that was loaded
in an earlier step.

> +	source->commit_graph_attempted = true;
>
> +	g = load_commit_graph_v1(source);
>  	if (!g)
>  		g = load_commit_graph_chain(source);
> -
>  	return g;
>  }
>
> @@ -737,6 +741,7 @@ struct commit_graph *read_commit_graph_one(struct odb_source *source)
>   */
>  static struct commit_graph *prepare_commit_graph(struct repository *r)
>  {
> +	bool all_attempted = true;
>  	struct odb_source *source;
>
>  	/*
> @@ -749,9 +754,19 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
>  	if (!r->gitdir || r->commit_graph_disabled)
>  		return NULL;
>
> -	if (r->objects->commit_graph_attempted)
> -		return r->objects->commit_graph;
> -	r->objects->commit_graph_attempted = 1;
> +	odb_prepare_alternates(r->objects);
> +	for (source = r->objects->sources; source; source = source->next) {
> +		all_attempted &= source->commit_graph_attempted;
> +		if (source->commit_graph)
> +			return source->commit_graph;
> +	}
> +
> +	/*
> +	 * There is no point in re-trying to load commit graphs if we already
> +	 * tried loading all of them beforehand.
> +	 */
> +	if (all_attempted)
> +		return NULL;
>
>  	prepare_repo_settings(r);
>
> @@ -768,14 +783,16 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
>  	if (!commit_graph_compatible(r))
>  		return NULL;
>
> -	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
> -		r->objects->commit_graph = read_commit_graph_one(source);
> -		if (r->objects->commit_graph)
> -			break;
> +		if (source->commit_graph_attempted)
> +			continue;
> +
> +		source->commit_graph = read_commit_graph_one(source);
> +		if (source->commit_graph)
> +			return source->commit_graph;

Is this what callers expect? The pre-image here returned the
commit-graph belonging to the current repository's object database, not
any of its alternate(s).

I'm not opposed to the idea that perhaps loading commit-graphs from
alternates would be useful, but I am uncomfortable making that change in
this series.

Thanks,
Taylor
