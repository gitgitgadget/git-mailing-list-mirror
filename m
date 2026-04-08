Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9E2E54B6
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682054; cv=none; b=VUu0K++6Lx+qZc3+9KL8f3yHOJgQdbsnVSz/T150RkVm+bjRXVGp9/O3y5cTr75rVxye5ofHD3QSVIdu7d8HyKG8HiJhlx5GWSZF+0yL6scPIwx9g98eVzD6N69Lznj0+9Dm5bzVG92Br6mbCw0DgXdLsyOIPZZcF8QT8VnZuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682054; c=relaxed/simple;
	bh=OtuyUiRmNi96JS4NHaceMueDDl/trxfEs815iM50txs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFq5Qkj8cHFt2hboI4gnrdKQiMu5OG5i2KIn2Ssn5IARWXWmHzvy6+wAadDnSoqqpg2zD1+XoO4/W9i/FtIPVKJx7wopzbyRIOEqv6mNAdE0rvq3jNO2bZaSwRDHbz2MlCQ9+os4Y9dItofHuKg3B9RJEdxmed7dMkM4t6YEw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiD8Ok/t; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiD8Ok/t"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbcb467f2bso225851a34.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682052; x=1776286852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUl77VqeIUAhtHcj0ArX1VxkUNicnLcp7Vz5EKM8eYk=;
        b=eiD8Ok/twDuhR7hFO7UaDyIeLnLv++mpBFBWITXN/rqP8Ij4OifUiVl31TnwjOr0Qu
         Oqnc1+/7HP1kDvxzCsKcYjfLsveRSqodNUY4bqfgrgnR6K4Y0E+zMGMTtPAFY3GWvgGm
         0eVzAvFNPJJRXmZqFmEY4Mrg8hDsmB1vWuUy20ybmaY0Rp5XGm2mWCx1afCh/z6yYW7C
         bu3MKYn9HRQbz39oVGb+DPInO13TPM9JqFNXdYcdCjhofKNQ36hTYB0mBLsOQ4hZFJbn
         ui6eBKibziX6zKf5AkvD1MQqdw4MvnyQLc2wSDg+opMmL4WMeafnHkVw5y8v6uT4f/BS
         UOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682052; x=1776286852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUl77VqeIUAhtHcj0ArX1VxkUNicnLcp7Vz5EKM8eYk=;
        b=f3kQUJ2B6JQIHkhNyChFXsn338lt10/kkRWfIeKNfqg//rNBs5f1kCCwzbMOHFD2Ma
         AF0VkRF/FAcjKhgRMPsf9teRfFX3mf8WSqbYPCzjJx/gb+QCunu+C61rx5XTRaPneBZo
         xJzCc4/NB/kfMoqbqcQpQSWfJrxcCWVAQ0mEDYGhZQnCKaE35EJKxfkxYaC/YzUc5GZf
         Mo5ouKbovqGC77wT7MxCgqrxPXjs6z7W7qcViq7Vz6bNmOouwd5RuMGtZzChFLQvvc8A
         6gzuf5B2abwUOG0wtARcLCfwf7ddwkBd7PvPDGqflwlR4LTWI1ycJ561UrOk/enfZs8J
         gl3Q==
X-Gm-Message-State: AOJu0YxH9GV5uAIdOXD7f7l5cAFbxPJd6JFlOJ4Wkr1/dovMapEiu4fG
	eF1jgfKjVvovBZMalh5L8IBGjzn4E6dyb6MYeYlnFm66n3ganT0TI0Ymwt7VaA==
X-Gm-Gg: AeBDievVu0SWJqG5YPyXUYnwRTTLEG/9aecFl4ZsmCJa5UO94ZaMJKYtuOmKCy7+MQG
	EIOOwtvgEUD2rQZOH2TQE62unhgSDo1ZesXFOH9XgOdqYRsmAf8qBf2nbedmDz+dawc4MiVqPyH
	laDFaZAOXxfprS2qUozcet7Emgi6jmgjMu9mvvVzYtJV4paTqoHkWt0aMfQnnf6YSPiTkv9/aEO
	Zi0hWTFzZ/gRT7TcMt7CcODF9L5qMtieASOtw0B0Uc1280Tf5RCmWJYnc7v4mg7nMsLDwtjgnVS
	D1yyLCZWe8qKiVhBxYRfYmAVu9RZF6NSY413fsd6PjIF59NwRrESeiiloOfFr40QIJzQvMRqio4
	vnf1Pm1C5nPl7lni/pwN20wal11wkBf0154+zpCb0BylAdGNHnYhqWZudk46njc//GCwCPfR1us
	E4apuo+KT4yngidpGT
X-Received: by 2002:a4a:edce:0:b0:67f:caa7:944c with SMTP id 006d021491bc7-68a63c8d6afmr654366eaf.62.1775682052050;
        Wed, 08 Apr 2026 14:00:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25acbesm20084579fac.11.2026.04.08.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:00:51 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:00:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] odb: introduce "inmemory" source
Message-ID: <ada_W-IWfNKUKnVK@denethor>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-1-8b8d1abaa25e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-1-8b8d1abaa25e@pks.im>

On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> Next to our typical object database sources, each object database also
> has an implicit source of "cached" objects. These cached objects only
> exist in memory and some use cases:
> 
>   - They contain evergreen objects that we expect to always exist, like
>     for example the empty tree.
> 
>   - They can be used to store temporary objects that we don't want to
>     persist to disk.
> 
> Overall, their use is somewhat restricted though. For example, we don't
> provide the ability to use it as a temporary object database source that
> allows the user to write objects, but discard them after Git exists. So
> while these cached objects behave almost like a source, they aren't used
> as one.

I find the wording of the second bullet point and paragraph above a
little confusing. Are there existing uses where new objects are written
to only the cache?

> This is about to change over the following commits, where we will turn
> cached objects into a new "inmemory" source. This will allow us to use
> it exactly the same as any other source by providing the same common
> interface as the "files" source.

Treating the object cache just like any other ODB source seems like a
good direction.

> For now, the inmemory source only hosts the cached objects and doesn't
> provide any logic yet. This will change with subsequent commits, where
> we move respective functionality into the source.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile              |  1 +
>  meson.build           |  1 +
>  odb.c                 | 21 +++++++++++++--------
>  odb.h                 |  4 ++--
>  odb/source-inmemory.c | 12 ++++++++++++
>  odb/source-inmemory.h | 35 +++++++++++++++++++++++++++++++++++
>  odb/source.h          |  3 +++
>  7 files changed, 67 insertions(+), 10 deletions(-)
> 
[snip]
> @@ -1123,9 +1126,11 @@ void odb_free(struct object_database *o)
>  	odb_close(o);
>  	odb_free_sources(o);
>  
> -	for (size_t i = 0; i < o->cached_object_nr; i++)
> -		free((char *) o->cached_objects[i].value.buf);
> -	free(o->cached_objects);
> +	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
> +		free((char *) o->inmemory_objects->objects[i].value.buf);
> +	free(o->inmemory_objects->objects);
> +	free(o->inmemory_objects->base.path);
> +	free(o->inmemory_objects);

Should we have some sort of `odb_source_inmemory_release()`?

>  
>  	string_list_clear(&o->submodule_source_paths, 0);
>  
> diff --git a/odb.h b/odb.h
> index 3a711f6547..3d20270a05 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -8,6 +8,7 @@
>  #include "thread-utils.h"
>  
>  struct cached_object_entry;
> +struct odb_source_inmemory;
>  struct packed_git;
>  struct repository;
>  struct strbuf;
> @@ -98,8 +99,7 @@ struct object_database {
>  	 * to write them into the object store (e.g. a browse-only
>  	 * application).
>  	 */
> -	struct cached_object_entry *cached_objects;
> -	size_t cached_object_nr, cached_object_alloc;
> +	struct odb_source_inmemory *inmemory_objects;

We store an inmemory ODB source instead of the cache object info
directly. Makes sense. 

>  
>  	/*
>  	 * A fast, rough count of the number of objects in the repository.
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> new file mode 100644
> index 0000000000..c7ac5c24f0
> --- /dev/null
> +++ b/odb/source-inmemory.c
> @@ -0,0 +1,12 @@
> +#include "git-compat-util.h"
> +#include "odb/source-inmemory.h"
> +
> +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
> +{
> +	struct odb_source_inmemory *source;
> +
> +	CALLOC_ARRAY(source, 1);
> +	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);

huh, so we set the path for the `struct odb_source` to "source". In the
context of an inmemory source, a path doesn't make much sense. I suspect
though that storing a path is likely only useful the context of the
files ODB source. Is there reason for us to still keep this around in
the generic ODB source?

> +
> +	return source;
> +}
> diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
> new file mode 100644
> index 0000000000..95477bf36d
> --- /dev/null
> +++ b/odb/source-inmemory.h
> @@ -0,0 +1,35 @@
> +#ifndef ODB_SOURCE_INMEMORY_H
> +#define ODB_SOURCE_INMEMORY_H
> +
> +#include "odb/source.h"
> +
> +struct cached_object_entry;
> +
> +/*
> + * An inmemory source that you can write objects to that shall be made
> + * available for reading, but that shouldn't ever be persisted to disk. Note
> + * that any objects written to this source will be stored in memory, so the
> + * number of objects you can store is limited by available system memory.
> + */
> +struct odb_source_inmemory {
> +	struct odb_source base;
> +
> +	struct cached_object_entry *objects;
> +	size_t objects_nr, objects_alloc;
> +};

This new ODB source now just contains the object cache info. Looks good.

-Justin
