Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48183AD503
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726816; cv=pass; b=iBzHWDsY/GJ0APcmHGuYCB9ssBtyaAv5HCt6kGHVK7NxTtTsPYya9RswnFA3Rht9s6VxTj3hxOP9HrrpyW191WFSEKcFd5As2aPAErVUt3emSSSPzCN7/q6LvngilwHjSYCecOhv/MqNPPn2VGp/oghZf+WAPLQQ+9aqg6P/3Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726816; c=relaxed/simple;
	bh=1St0LzENMS/L2RiE9XeE3joOEj1DClmWyO5f2mJJX1Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD+y/mcqD2xhjGq6hh7SOb6n/zwI2hE5TNJbo6nQIR+y58/nbvEZ+ReGrMiqviO5dHxL3DapoIoU24iHYNyh8ucxXInHvclacO/CpKJ7oSbEY3Nru76wigh72mpuWaa+///qkfH/LhTs3wwvLYACmx8X9d6QP5oxK08Qosc790A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUdNAYB4; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUdNAYB4"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-604f327bafcso199999137.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 02:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775726812; cv=none;
        d=google.com; s=arc-20240605;
        b=IrLvQHpTpDf1ra/EdAfpeurFU0jngCCm2W5EUWuWmsrVrdc8LqMhn+O/iNddW/G5QF
         LBvrSiQRH8X2SDuU/ZL+gTvkEqYfQB5L8DERDr0aUEamy4F+iSseCe7/LwPdWAXTGimc
         NO/8UvQu9ggZH2BtS1ijxtAcI+tMi5xtNFtMLeZlAuZ9zqN0PD4ixMHD+Gfw3QnnAQ0D
         bdexvrRqfCJAhfh/ilTAJ5DGicC4nHqTjAt8OMTWaKECFzbqo8tK7o3fPpj3jrmwdHA6
         ZCdVnPbyBx+YEAmtFXtouikBEwh8cYaJtDgc/7WtXRy7O2QAuXwHNXazBBpm6oesgUlT
         LplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KqT+ti7MuY2UiO35fJ7pZ+f7eDdDj0uX/Zy575RRfeA=;
        fh=7AewTDgNNKwfBN6EJIG1CTX2QA/Dc+pKG+I42JSN5QA=;
        b=dFS/vIKmLlTt1zdNZntyFNZCNpDgkBG8nYNfHQpM/v3iWqVZ+7Lso7T5a9iBRm6d4z
         3O7tghsNHM2Sm30TrFqaRtGKXt+6mm6zUDU36QaxMmtQh0xu0vEiWqZPVbktWKdINlXy
         4mLOCkORyobHfphJrd6KD/9j0KovBYBe/DW2ARNdT2SYzg0dT0pzW6xniGuymXFFYJxe
         K0EcnRNKMpvPw8Ve/Md64hX7SuDVoZHRvC2AgSjTzIJaQL9SwdOncVYgDQ1OE3LSI+4d
         iAiuab4+18HtLzPDCyUO/y16ePB1t8UuBOjrnNl9wbYAKHIKSyCMMa9H1/MGKKOC4inx
         6ibw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775726812; x=1776331612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqT+ti7MuY2UiO35fJ7pZ+f7eDdDj0uX/Zy575RRfeA=;
        b=pUdNAYB4Sw5UAQR1ba9SBML1BqQtoI70vDt/K29jTxeFR1JUWKxSS4KZRQzSti1MtD
         n7tjojKy+WT6hZNpbUe0qgeBGQ+3+NCPEz1W4pFxNUSUJ6aa06t76FKt1kpB0/AgLv+u
         1q+VqVa7vNJzv4naiBgsztpfMianontrC8g/UxF//I9byzt3WoOjfOSlvkIha6Imwc4h
         D+RI0cqNai/60N41HvXFrCbfuv4xWoCB/vCSbFy+fNmbVdpffCa0GJT0L4MnpwyF86Uw
         lMQMws3U0syic6XAVUIB07mLMwcVB1rD3FQLQ+a74SeqtlESWT0TbYVT5DQl2a8vEIZe
         UJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726812; x=1776331612;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqT+ti7MuY2UiO35fJ7pZ+f7eDdDj0uX/Zy575RRfeA=;
        b=Inur7oX03ZPItbVFoGlJPRgdaG6QNcFMUxI+vPofeQg8AhFidxYq67Vq8VqLezH/uf
         TXvLjE4XXfSsu9rfJow5htRFKLixZzeTBHWep9TXchaGDLdWZPm0BAIiwcqHHHWgbRfE
         MCP/Fxr0DukAQPFq0Hq+k9aeiYj8bpOEUWO2ON+/Ad1HQfF76jjIepPKAkm7sSzzWZZL
         2ouKsimwcfcoY1URzjXObc3EDASwAmhchwy8fWVhcVcoImabTZPCalWTkd/x31xHv4ai
         p5ZnUJPGA+ejWqCTPoVBeINKY7GQXN8G3hEa56jubKrqIpP9tHarm+9DKqyqr6IZ/fXQ
         2Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCWf7TKGk5ym5Ey7VrbjoAVTjStLxqxaME5ZkLYTJHzqW4lG1MLqbpkKpI7tKV6Itn+Q97k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb546oFyP17iQy63zCqg5NYxVWcXV4XK9n4UG1aQI2qlvWOtLs
	uMvz2H0c3/uaeySDDkdgK2HUDH3O8L0FJ+pSo8AL318WRni73aUmoORiHzGc4vfD0JTpKA63ej8
	HeSFWqrRjQs9MoxrFdkXZzw/wwJhQFhcktQ==
X-Gm-Gg: AeBDies0VGQ+D9C2oOayIqkPPM6eLGjiqdirMNwzJb/zOUSJMlMjMY7a3JtQhGjT/2L
	oL8UIcPC97iCxWqMsvlnuTxkrYFcC6YIwh7AwclQaavWBOCSFKGbVxGL7yZppr/EaZi97tmnsjl
	lafvMPlQKOe9RYQaMT8Jnk84SDMI15uJfNpwAP9DOduRqLP/IoN58+f/MtfOn+5Y1og8UgPh1Qe
	y2pc938gLbZwO1WB0eQ0KJJs0pRezl5Yu4scY28Pvyrw8J0Cxjluw0Dyp8+WUDMH1ved+wSV7vN
	mTS25SjafTawdPkH2a+FGuOYKhcxpcGssvKuE4mA
X-Received: by 2002:a05:6102:1623:b0:607:a394:1841 with SMTP id
 ada2fe7eead31-607a3941b0dmr2032682137.0.1775726812034; Thu, 09 Apr 2026
 02:26:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:26:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 05:26:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-1-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-1-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 05:26:50 -0400
X-Gm-Features: AQROBzC_sUKfxHicg4NvP2EBQ6xh0-Yd2nruYh5uKcvv8zTOYNSyO0DelbEULx0
Message-ID: <CAOLa=ZRkctXNkpTqiTSTkvskajPZTid9WTG3fKr0YV641_5qrw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] odb: introduce "in-memory" source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d99a5a064f039dee"

--000000000000d99a5a064f039dee
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Next to our typical object database sources, each object database also
> has an implicit source of "cached" objects. These cached objects only
> exist in memory and some use cases:
>
>   - They contain evergreen objects that we expect to always exist, like
>     for example the empty tree.
>
>   - They can be used to store temporary objects that we don't want to
>     persist to disk, which is used by git-blame(1) to create a fake
>     worktree commit.
>
> Overall, their use is somewhat restricted though. For example, we don't
> provide the ability to use it as a temporary object database source that
> allows the user to write objects, but discard them after Git exists. So
> while these cached objects behave almost like a source, they aren't used
> as one.
>
> This is about to change over the following commits, where we will turn
> cached objects into a new "in-memory" source. This will allow us to use
> it exactly the same as any other source by providing the same common
> interface as the "files" source.
>
> For now, the in-memory source only hosts the cached objects and doesn't
> provide any logic yet. This will change with subsequent commits, where
> we move respective functionality into the source.

[snip]

> diff --git a/odb.c b/odb.c
> index 40a5e9c4e0..60e1eead25 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -14,6 +14,7 @@
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> +#include "odb/source-inmemory.h"
>  #include "packfile.h"
>  #include "path.h"
>  #include "promisor-remote.h"
> @@ -53,9 +54,9 @@ static const struct cached_object *find_cached_object(struct object_database *ob
>  		.type = OBJ_TREE,
>  		.buf = "",
>  	};
> -	const struct cached_object_entry *co = object_store->cached_objects;
> +	const struct cached_object_entry *co = object_store->inmemory_objects->objects;
>
> -	for (size_t i = 0; i < object_store->cached_object_nr; i++, co++)
> +	for (size_t i = 0; i < object_store->inmemory_objects->objects_nr; i++, co++)
>  		if (oideq(&co->oid, oid))
>  			return &co->value;
>
> @@ -792,9 +793,10 @@ int odb_pretend_object(struct object_database *odb,
>  	    find_cached_object(odb, oid))
>  		return 0;
>
> -	ALLOC_GROW(odb->cached_objects,
> -		   odb->cached_object_nr + 1, odb->cached_object_alloc);
> -	co = &odb->cached_objects[odb->cached_object_nr++];
> +	ALLOC_GROW(odb->inmemory_objects->objects,
> +		   odb->inmemory_objects->objects_nr + 1,
> +		   odb->inmemory_objects->objects_alloc);
> +	co = &odb->inmemory_objects->objects[odb->inmemory_objects->objects_nr++];

Okay so we introduce the inmemory object storage and directly write
objects to it. I guess in the upcoming commits, we'll swap to using the
API as we implement them.

Makes sense for now.

>  	co->value.size = len;
>  	co->value.type = type;
>  	co_buf = xmalloc(len);
> @@ -1083,6 +1085,7 @@ struct object_database *odb_new(struct repository *repo,
>  	o->sources = odb_source_new(o, primary_source, true);
>  	o->sources_tail = &o->sources->next;
>  	o->alternate_db = xstrdup_or_null(secondary_sources);
> +	o->inmemory_objects = odb_source_inmemory_new(o);
>
>  	free(to_free);
>
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
>
>  	string_list_clear(&o->submodule_source_paths, 0);
>
> diff --git a/odb.h b/odb.h
> index 9eb8355aca..c3a7edf9c8 100644
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
> @@ -80,8 +81,7 @@ struct object_database {
>  	 * to write them into the object store (e.g. a browse-only
>  	 * application).
>  	 */
> -	struct cached_object_entry *cached_objects;
> -	size_t cached_object_nr, cached_object_alloc;
> +	struct odb_source_inmemory *inmemory_objects;
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
> +
> +/* Create a new in-memory object database source. */
> +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb);
> +
> +/*
> + * Cast the given object database source to the inmemory backend. This will
> + * cause a BUG in case the source doesn't use this backend.
> + */
> +static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
> +{
> +	if (source->type != ODB_SOURCE_INMEMORY)
> +		BUG("trying to downcast source of type '%d' to inmemory", source->type);
> +	return container_of(source, struct odb_source_inmemory, base);
> +}
> +

Interesting, in the refs namespace the downcast functions are added to
the source file (.c). This works too, is there any reason though?

[snip]

--000000000000d99a5a064f039dee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ad4334c18075de0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGNOZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menJuQy85bjJjNlhlSmc5enlsQ1hJTDd1N2Nhc0xLNwpaUUdncXp6U0hO
bmZPMENDL3lUL0U3TC9FK1ZIdFdValRhVzBuWCttMVltN05OVGZuMDNsN1JuQ1gxZ3Q4UW5KCnJQ
ZWNHdGtGbUZTY09EdjBFUEVFTVRxU1dqNmF0dWd4QjlRZzc5UitNdmJTbExDWE05SEJ4ajYyVFM3
MWNrbW8KRlZTUWo3dWFnMHFIVnYrcG4vU3JwU0Zadmo5Wks1QlhGaFU3NmpHa0FMTDVYSExjdHpp
NEF0UWRYSGFlZWpLQgorUFBtMmRES3QwSUp3VzBHU0tpdW9OdnFPU2JHNlM4ZTd6TWo0SG9hbkRB
ZlVvcFhsSGVLTDliUFFYVk1PdGlaCkt1RkxaVjBHOFBKN0xHTkM2VmU2Vnl6dWNOeVM4ampKYlhV
UXFZVFl0WFlLcnFaYmZDR040dktNNTVFc2xuRDAKZnNuU0ZsR2xxVXQwZ2s4Z0xRb09tZU1CcDNE
SWptY0xJS0VoRGJHS1RJRGlERVZNcWtjU2RlR01HY2FYRkN5MgpZZkZsWEwycFQ2ZUdUckNqcStC
dmpXRGlCS1RSaTZ0SlB0NzRpUkVzMFNwQ2NDQlozZVd4RlAycXN1dFFrUWRaCmdxWnZrRldHamhs
WC8zeVdpVFBLT0IzZW11UG91ZTZiaktRR3psQT0KPVBjS0UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d99a5a064f039dee--
