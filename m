Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238C257827
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645823; cv=none; b=p3oB0c7GugeCXjx+va41+yjl/XzSjJieWIrwtCnsgMxco08BzoTjytf3nDv+8pzgPpPQ0xA/fSr9QymPgOQelhlZRJtRE6osCJ3A8IzA7nVzePEI+2zhui0iJRBmG5lkWtNZHum3E8WHgseveTUEBOYv09evd8lsKxk1MeUhrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645823; c=relaxed/simple;
	bh=ebT7S2+JszTJd6WYkYYKh+GarwoeZ5bLv8L9AEbUGKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lviypyILpmJQ7nvi8xWJU6PtUFwXfuHaS+8PNjHLP9IN8g8nNCiZBs92J+CraW5vnR4JmU3LwVWkupmij5dQcqj0VfYnrsbomD2ow9azkaXBVeBAg+3150N7OAfjdo9pJYQcj8gI+I4oGdof1A3HP4S6IyBicC4AxlDZSojzep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAZk7Qyl; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAZk7Qyl"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69e4483cfe9so176388eaf.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781645821; x=1782250621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fDj9KFNTPgbuBvrgYA0qauPPCMFFydF9giJYxKUvsU=;
        b=eAZk7QylDHRFdPRLTnpqdEVqFz690jbglfdHpUw8Q5miCDA2psPAIwA06iun5XFisA
         ViT4HRsEV+1SZ7OMvedXSdNEd0BJIMIqyMFOldMEPmndCg/3N6uc2SUHs7l7d+Zx1ZwZ
         5onPigtWTDjHp7NW62nlAWWid7sW2PMg8a8bLdeDjVZF7/TbIJC1jy2oMOZugbkl95hY
         BkO43YjfM1JfuNk1MtQCxV/5pqzP6rGNcJRRmlf78ydf1xdJQ22sPJvr+R5Bou76vA1j
         dCBzGkPESRovVViVsRLkopM/zaBmImfHJ3GWYstbzi2KYmoUmbAb0m97UpGmulHbh+Me
         OOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645821; x=1782250621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fDj9KFNTPgbuBvrgYA0qauPPCMFFydF9giJYxKUvsU=;
        b=emKqWGNQuwycvIsLehJbfxSPaN+QKkvQnPVRaHctCHb8MgEPIyjqQ2g+s2ROqJGcYX
         A6n7CMusDJ3BGz5/uGxj5cf2uqs39nruqsYaff0ty8bnj4k/MRcRHekcj2mMwCwHLGOP
         XiElKvYNrcUFBxLKsjmTwqViqu+f58zeZSQrQM9iaKZ6fgEKsBmKvW34pO44z5fsKf6I
         SkV87LWnUEsZCGVJYP+cNCSV+0sz0GgWAVKjv0Ps2ZKX23dXy1yku+x26xyy3T3TbXLd
         u7Io1wE2Y+h/VenVlYiqMfblIUPjy6YvEtetQvx7Y1WPGS2vsg9AYwK09LUmeVjf5J9A
         w0SA==
X-Gm-Message-State: AOJu0Yzp1fPJyEXQp1BVUWyrOODtIg6JEuQU2lWCgvIzhLXUiG1yNYQt
	cAbELrYkcf7bF6rJD1zgf78kjxt7vDjqukhTWBG5BDj3QEHTSkHFnF2J
X-Gm-Gg: Acq92OFReLqdatdXcw3TSWhvfh8iAZLpTWK4IDvPjdrlheFqVW62WyhMXktaNw/Rxql
	05Hua/Nrj5N5dJB3EQV9z1jNYlAArAN4dEmiqKl7Yi50EvL/1PXI4NgOYEr4BESw6aAKeYow2Af
	tzCId8N5CZN0D9t3AsG//UbmvvpH4q2tfcllZW3xmWpdmayk4Y7MDfOJr/r2nGHuwq9Uw3jxmPV
	9e5pib13Liyvp8a77cy14awY7gPNoZ9d7m2Oz3jdXsHjI3ozak3MaObjRsCsLwYxTEkI2VqhY2k
	7rtV+loK49D1sMRFAGMe+HCNolGiRP3DmuEYhfolI/o4uUdJQWoRwunBqUog8PmYGKdNcmTv+7t
	tKJ00ItGCt385DWL+DGRDp5OsRz7xbu7ixPf7isKDaJHsIUM/MEFnBiYErsIbUI9Nizd5i0ZWW6
	dIHtObqMzaFC+V+Fgf
X-Received: by 2002:a05:6820:4c09:b0:69e:854b:3bd2 with SMTP id 006d021491bc7-6a0b7be2f97mr248546eaf.35.1781645821046;
        Tue, 16 Jun 2026 14:37:01 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0057csm3155542fac.8.2026.06.16.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:37:00 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:36:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/17] odb/source-packed: start converting to a proper
 `struct odb_source`
Message-ID: <ajG-rP7cRjZa3zJE@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-5-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-5-839089132c8b@pks.im>

On 26/06/09 10:50AM, Patrick Steinhardt wrote:
> Start converting `struct odb_source_packed` into a proper pluggable
> `struct odb_source` by embedding the base struct and assigning it the
> new `ODB_SOURCE_PACKED` type. Furthermore, wire up lifecycle management
> of this source by implementing the `free` callback and taking ownership
> of the chdir notifications.
> 
> Note that the packed source is not yet functional as a standalone `struct
> odb_source`, as it's missing all of the callback implementations. These
> will be wired up in subsequent commits.

Ok.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
>  struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  {
> -	struct odb_source_packed *store;
> -	CALLOC_ARRAY(store, 1);
> -	store->files = parent;
> -	strmap_init(&store->packs_by_path);
> -	return store;
> +	struct odb_source_packed *packed;
> +
> +	CALLOC_ARRAY(packed, 1);
> +	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
> +			parent->base.path, parent->base.local);
> +	packed->files = parent;
> +	strmap_init(&packed->packs_by_path);
> +
> +	packed->base.free = odb_source_packed_free;
> +
> +	if (!is_absolute_path(parent->base.path))
> +		chdir_notify_register(NULL, odb_source_packed_reparent, packed);

Out of curiousity, did the packfile store previously not have to worry
about changing directories?

> +
> +	return packed;
>  }
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index 3c2d229a17..68e64cabab 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -9,6 +9,7 @@
>   * A store that manages packfiles for a given object database.
>   */
>  struct odb_source_packed {
> +	struct odb_source base;
>  	struct odb_source_files *files;

At first I got confused as to why we were adding back a `struct
odb_source` pointer, but this is for the "base" not the parent ODB
source. We need to embed a `struct odb_source` here to make this a
proper ODB source.

Looking good.

-Justin
