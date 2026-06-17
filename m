Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE135E956
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719350; cv=none; b=JtLMSYrMGkcGMk12cMDsIKQCj2YzvyAYVpAkyXFl2OcbK2+LekfNz38kL2BH1vCRY2UWXTk8RYk2Qth0YSaNISpDsSuHcSvraiBGlvBuA3CzyB3S/7zUTNsYS/AdBE6rZ+mQnURI7wGPy6/j1KYuXFCMOQiFMrc7Hwil5PymGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719350; c=relaxed/simple;
	bh=mHAhcbt3rW0ifstyQmnEWWf6H6PjKr7YGztZrlbSIug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtrNN1N7n+8Nlw/aSZ6ehtslusWsI+KyuuQl2gAPFua3YPAs7cPHfCi8wIiXEKyCr0LTrbqd1UQmEve0+lCIFoIYw9KyfEqkbJrI91lOidlv9gsetPiCpAFrNKLGeHf8HRQ1osSrlJxV0FaSAHILY2m/Kf/OX4clb60wEDsJxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLCrDo1J; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLCrDo1J"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e71198e0adso14388a34.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719347; x=1782324147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NY9/i7V0fIM7XqgHOMykgg2dVjIIRgQeErVARfWCpXk=;
        b=OLCrDo1JNc2p+7yjmflAA+v8jOycqUliulY9ICA5F3gnfSexxy06oxUqL5DVRcQhFi
         +nWJYKpoP6Vmhlco7mxUjCxKRgmmv5nN7eT2kC2omwUnJnzes0TMDu4nXwLwXGwI+gvb
         /lxNbHPHYZVQxemqzoaUt3n8FLQXYKyGDEiE03Zq9TMoRGh0n8PGFaF12NoFK4NKklpo
         oSgjNU7komXYwFscULW1kYiLUs+xTN1XCQW58SqXLOwsyN4UhY7vhxZoo1rBXnYFDQC6
         rRXNhmS9P7whHqApDDJr6Ct4rlOWetPlEcQZqUvFjoMghVHHEpBWf4kJyMVhV9QMs7gF
         FLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719347; x=1782324147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY9/i7V0fIM7XqgHOMykgg2dVjIIRgQeErVARfWCpXk=;
        b=HYCOMtBUJQ6MPPWLi4BXqGFA56H4G6GvPHU2WWuGCuiBxH7Lox8dwYew701L4nlhxu
         yx0lA0tymaLo6zVBpDmaWbmANtKepOVJpuxgb4QYPs7TcDL7EyRQZ55O+sblWbvMWqc5
         5Zwxqew5h9tw8KBwPVp1fJpHlKrnO93bP8JDr6DNhthZMvKXnV0/glV7pytz0DafA6+d
         m6Hpj4n7uC8RMoizcdaz98HqW8TAa40Be6FWtFWd7fVFyGfrQXpp4l7ldcsDDwbSogNN
         6gZe96tnb4lEn1qq+iLNu8STEHlIVs++AoLcsMrJe9/rzkTTy3Zebu+8DoqePHIKdvMq
         jENw==
X-Gm-Message-State: AOJu0YxwGyYJAQQn8v83iY1Lw86CcqYRW6Gu9U8kRKHWirgEvMBGiJCp
	saIzem2B+LVLURs+UGC+a6uKNcy3qXGOBseYt+2JdclBkYiqctwJhmHo
X-Gm-Gg: Acq92OFG0wnyRigb01lqsZsWc50Hj0rsjjQCQfd8wa+TyUfiA/oEMD5hnX5qWoL3SkI
	2TJZTLzRRwZWQW5gkFEdPKuV8Pas8p8nhkeTUi8i/zNLutOrIVu4e7UBBEZQvoJKyQ0CS4+R8/Z
	h8oR3kL9OfzZg0Nl82jORjxXkneUqhqv552ajCJ2Vq/q8NsGj30xOs6tJqyXKWaaPXwIkAFrC8v
	9UVCLuOJ5KVACFG/n767l8f8N3iW+0WjZw++XWUbo37U9H+WCGkAQ7F/vjqQaOMrkjPvNSFwreJ
	2UVvCe8xssEK/dEhvRnpn8WQ7QmzPzmDVeMZ5Js0a/1eV/KY/PNuw/K5ckug4Jxifxv9sitq5jT
	NvACNQYcuLO6MBgnTLm6RpWZcXEY9nBv/bpCvpDrSTadHn5Gb6KTbL5il9R1wmMNYXuYS9ToUnF
	hlriBCZA==
X-Received: by 2002:a05:6830:d11:b0:7e7:c1d:bf5b with SMTP id 46e09a7af769-7e90c99b2a8mr3839296a34.24.1781719347227;
        Wed, 17 Jun 2026 11:02:27 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a11efsm9827165a34.1.2026.06.17.11.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:02:26 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:02:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/8] refs: unregister reference stores from
 "chdir_notify"
Message-ID: <ajLdIY_fxkKDTBaW@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-4-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-4-f4854aa99859@pks.im>

On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> When creating reference stores we register them with the "chdir_notify"
> subsystem. This is required because some of the paths we track may be
> relative paths, so we have to reparent them in case the current working
> directory changes.
> 
> But while we register the reference stores, we never unregister them.
> This can have multiple outcomes:
> 
>   - For a repository's main reference database we essentially keep the
>     pointer alive. We never free that database, either, and our leak
>     checker doesn't notice because it's still registered.
> 
>   - For submodule and worktree reference databases we do eventually free
>     them in `repo_clear()`, so we may keep pointers to free'd memory
>     registered. We never notice though as we don't tend to chdir around
>     in the middle of the process.
> 
> We never noticed either of these symptoms, but they are obviously bad.
> 
> Partially fix those issues by unregistering the reference stores when
> releasing them. The leak of the main reference database will be fixed in
> a subsequent commit.
> 
> Note that this requires us to use `chdir_notify_register()` instead of
> `chdir_notify_reparent()`, as there is no infrastructure to unregister the
> latter. It ultimately doesn't matter much though: in a subsequent commit
> we'll drop this infrastructure completely. We merely require this step
> here so that we can fix the memory leaks ahead of time.

Since this version of the series dropped the last patch which stopped
using `chdir_notify_reparent()`, does the log message here need to be
updated?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c    | 22 +++++++++++++++++++---
>  refs/packed-backend.c   | 16 +++++++++++++++-
>  refs/reftable-backend.c | 16 +++++++++++++++-
>  3 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a4c7858787..296981584b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -100,6 +100,23 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>  	}
>  }
>  
> +static void files_ref_store_reparent(const char *name UNUSED,
> +				     const char *old_cwd,
> +				     const char *new_cwd,
> +				     void *payload)
> +{
> +	struct files_ref_store *refs = payload;
> +	char *tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
> +	free(refs->base.gitdir);
> +	refs->base.gitdir = tmp;
> +
> +	tmp = reparent_relative_path(old_cwd, new_cwd, refs->gitcommondir);
> +	free(refs->gitcommondir);
> +	refs->gitcommondir = tmp;
> +}

Ok, here is introduce a callback specific to the file ref store to
handle reparenting both the gitdir and commondir.

>  /*
>   * Create a new submodule ref cache and add it to the internal
>   * set of caches.
> @@ -128,9 +145,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>  
>  	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
>  
> -	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
> -	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
> -			      &refs->gitcommondir);
> +	chdir_notify_register(NULL, files_ref_store_reparent, refs);

We use the new callback here instead of relying on the generic callback
used by `chdir_notify_reparent()`.

>  	strbuf_release(&refdir);
>  
> @@ -182,6 +197,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
>  	free(refs->gitcommondir);
>  	ref_store_release(refs->packed_ref_store);
>  	free(refs->packed_ref_store);
> +	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);

This allows us to unregister the callback and avoid holding on
references which may have been free'd. Makes sense.

The rest of the patch does the exact same for the packed ref store and
reftable BE which look correct too.

-Justin
