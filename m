Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA66339B3D
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682313; cv=none; b=ObSXA8ckwXhTkVBz71tOCxC942h08O0macEbx2wI5CPcM8144ebEZ7Kl4LMApB5bgtqppv/5fFLYL38npXwVx1TpAcw+Cr9Sr2U6C+bXFGJ+wM6nQKETyG8A/YocnODJXTkdogIoWroPCo3gGw4Bwea0C69q3ekAABxb3ezk8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682313; c=relaxed/simple;
	bh=CSW1r/+ayEvx7+eAMyf2y5CDY41N7bX1+nxfjVqcxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfXA/doEXfeMCIX+fAkqMdZc5VPdKv6A7aOZ816eKMtKiJZoFCo52lwNZdZ+ugkgNna0m3FtU4rgUba9X/eHI0Y5OX7dDUVlHGR0GXVfUQ5Yw806je8UfFzqTNkSUCCgxHYljqsR+Oad10UjqIt6aclAN6wqYpLMKzv4y6YpKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvZTsNFT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvZTsNFT"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbcb467f2bso229890a34.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682311; x=1776287111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gaefhwb9+SzImpq2IZX5vHaDF+qMEjQlmGm2iqlPD5Q=;
        b=FvZTsNFTdDKe5R9ok37CHJ0IlHHd8+FyWFQh/mqYXuqnLVcrNPSb6TEi9GLY0qvGH2
         Xlc54eCIGlkoNxutvOL22GzsmWpNPa/YMcLKcAJWOBqyKLf4zhrOsOHUSbSdBfxsHOjl
         nddZrucX7tPELlhXweAW8S1hxBAmyFlyfDpwxUzlbwtuDrFuPa6quwxTXr8fUUn8vHAu
         il0UJsa0a4pocwxu8iJUfg9LkYB84Ua2RTXdLNDueYfFZXo5/s0pLoTg0RBD+2a/eojx
         hihplKXXTM7Wn0eJmiZdvaVTy4aSeSgdUD7l9Ece5l4WKzhbWMkPfUNAT5cCa8PeT+Cv
         WjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682311; x=1776287111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gaefhwb9+SzImpq2IZX5vHaDF+qMEjQlmGm2iqlPD5Q=;
        b=UfnaPQIglQ9p/N15mjhMMm5WR6xM1JLNwEvjhqO092fIE2u1YZatQl6ianvLUYwb9N
         bhzVOevrXvatU3MHhnvq8Nllsk7iUdJ10JVBaNL7HBg0QKOPVZIiNaCb+pfvmjNxS4Qa
         Z1RXT8WRX9Ft4hYSD3lB/wZLubCs01aIrHL6UAf+pcRwv4+V7SMZcbDH7hNWx7u7TY0d
         vgEniqzhWpm/gHYD4UBxzPuZQRgZj63xtxvncm8iyhaMdZAtIht4zYWJcefL3wjFjZkZ
         zARc2fTnx9JxjE1qVMCiDXBoINHfZ7hpi/G7QJe4yEkp7zplI8jUcC+dwKGGL6EEkje5
         3prQ==
X-Gm-Message-State: AOJu0YzKUuVlIpzodKIu7lH2+P33qqyy1SuDKQSlQJE/LTlP5IFZbU85
	plL3+4uwwcbwelP00xfIv4Spw3BTyDizNz7NtNbiYzKCsX/VsXqs9wbt
X-Gm-Gg: AeBDieuHq3J6mlOabv1XsuWnx85ZsSC14YY3HUGD5EF0m7DhP4XoUNVIkU95pQPbpPj
	MpwJlkmFR2dN1P5DInLi5mkxKPRqyb9ss/SSMzzStr6wHAN+oN2MTS2ZjuB+Jv1URyWrFJHkair
	pWzEYmeeTej51Xtq6pDRDuXxQhaxWpGsvIYZISix5GdfC03r3WnyE3bQhFEn8IBXAeCNgCxY3uk
	ZfmqNWUscHhN/L/RP3bBCIDGaxEEGtp51PfSvf79lGIyOOmafMm8w2m9q1xx/Q2Up2/Kux9poO7
	4iDIGtEZ3ejez2YF5e0zKn/SKS8znrOcfznCaPxG8/kWqzNsHTg9PJDpBk7XoK7SEYZ5hwx0APv
	62YtT5UE9Ub4XWLXgP4LTcN0Ul/MI+h2XyALTV2yls9nYAlKw5Nljpg3s53AZsM7+3gcBxY2yAQ
	ILIDsFPexySajJZHeh
X-Received: by 2002:a05:6830:82a2:b0:7d7:da43:387 with SMTP id 46e09a7af769-7dc16f2df97mr691527a34.16.1775682311410;
        Wed, 08 Apr 2026 14:05:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72febcdsm16082430a34.18.2026.04.08.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:05:10 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:05:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/16] odb/source-inmemory: implement `free()` callback
Message-ID: <adbCaYrt2mJcMPyK@denethor>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-2-8b8d1abaa25e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-2-8b8d1abaa25e@pks.im>

On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> @@ -1126,12 +1115,6 @@ void odb_free(struct object_database *o)
>  	odb_close(o);
>  	odb_free_sources(o);
>  
> -	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
> -		free((char *) o->inmemory_objects->objects[i].value.buf);
> -	free(o->inmemory_objects->objects);
> -	free(o->inmemory_objects->base.path);
> -	free(o->inmemory_objects);

Ah ok, this addresses a comment in the previous patch.

> -
>  	string_list_clear(&o->submodule_source_paths, 0);
>  
>  	free(o);
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index c7ac5c24f0..ccbb622eae 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -1,6 +1,16 @@
>  #include "git-compat-util.h"
>  #include "odb/source-inmemory.h"
>  
> +static void odb_source_inmemory_free(struct odb_source *source)
> +{
> +	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
> +	for (size_t i = 0; i < inmemory->objects_nr; i++)
> +		free((char *) inmemory->objects[i].value.buf);
> +	free(inmemory->objects);
> +	free(inmemory->base.path);
> +	free(inmemory);
> +}
> +
>  struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
>  {
>  	struct odb_source_inmemory *source;
> @@ -8,5 +18,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
>  	CALLOC_ARRAY(source, 1);
>  	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
>  
> +	source->base.free = odb_source_inmemory_free;

We wire up a function to specifically handle freeing the inmemory ODB
source. Looks good.

-Justin
