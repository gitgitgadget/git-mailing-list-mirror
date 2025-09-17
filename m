Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACDA945
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147347; cv=none; b=VKjxV6eHm/9ECa28eRfy2JWof+ClNsIxb+Pa4/GzYsUGs+jB6ys+qucn/LIFfPBeC5ON1ONUStYNoGjmm7L/pGy5R5esoSpbV1Aj8nOVQnuXz/HfXIJ6RnhSIVOpV/fcIPxOm2rps4bcH4r2Smyi7uIGs4mPJ39xUhlaOZVPZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147347; c=relaxed/simple;
	bh=sBL366kQkdadCk6jazgfbFBY02zPiABySbKpS61qGhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg7kSxddXP7hZKpziVXhiAh/CC6uASCdYoudQ05UFCCPji3wy1UtsIBxjh8DWud+ltOSl97H46fEwKCqqklVzQKui+cLQOlsxkHJJGFn+Aa1NTAbbr/p4qv0t1tpOAELRVdZRc51MQWpYUP1wYkGUtlJEu19Vo8tuMX2xBPUGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dsdz3Tuq; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsdz3Tuq"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-757fda06b0cso233930a34.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758147345; x=1758752145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+1IRJZK2Net7JF71HtPGoQwtaZ6qbSVgKCq/EOjXzg=;
        b=Dsdz3TuqAHk7N3MWHCQeTkUfWuSeeTyOVF7YeO4QgpCur+gCFk2+qTOO/7+FcmMDGZ
         pxBM+7Hcy5wK3vWBZv+mi/wh99Yo+B9Wm4OyjP7ZkUuPBT3tnPleocLHVEyBT13PAEWY
         DGVyPWIZ+LmKi/tRJ5rDdD8BYo7kdUXDthBGCLdVloKq8NTRmOBYb3cTKnhLQGIhmqkQ
         JUA6T0elLn+EJqm9S8Go9OVupg8d6lGFW/4hgHev5E0KXfA3yfzFcfhxtxtck2eKszgL
         KkHRMffA9i06T97MnrVxDnvvJYKuDjHqjtmdX9dCurocioLamyeMmlNGL6ngpxrTaa39
         8PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758147345; x=1758752145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+1IRJZK2Net7JF71HtPGoQwtaZ6qbSVgKCq/EOjXzg=;
        b=PteraVrPWDJ2CYPiULReA5OkMDJWaafK+vHCDORX30jhU6e93MSnYAtWoaIVprVzpe
         mrPOrcuLqeV3SKN5+pLE5fXsQn9eJMgFD6fXUQFHjJ5l5hX0djupyv8BTtmv2y0mJ+BO
         7o6cclycxdHx8n5PiH3j6eEJpufQf1VYBaOJFz6I+BgMj6K1TBejsXNCb0sEnd5M2iAE
         C63yPDWum82r2luBxwmRS8v0yyOk4nyr8ZjAKD7BUp5BcoMqVKaZg/lpCghB4+KxQxcm
         XpkbiDrmR5dO6/NmFvWwX69Kz5yI1P4vIqo66Xej6PjqbEUf0/xEc3y12+OI0pSec3IH
         6sqQ==
X-Gm-Message-State: AOJu0Yx7lnDa3bZeIBpaW5LEQBeZcpfqkFTOIK2KGMlW4LMgTllkE5xk
	Ox9gebjCOfajxbD5iWmjZ7+3wlSdc1os0sl6fw/cnvw+l3v289NbiPRy
X-Gm-Gg: ASbGncs8GzSKpE9LBbQGD6FNcD+4bvTVbGP1sxgIvkc+PdWZ07cFtIAd2uXzaMT6l19
	/EIFNCzh/sySYaYmgfgMC4+E35l7zn6E+K7gPO2ATMvop2E+igpFujLzZG/sBl9kLrX4/0gR4mT
	YcUL2aucMJA2VGIYT41vAzPqCyX+3zNPf5Mup3qEm+qwu8HeFHiJxOsh1ONFttOQniw2FOSCdw4
	g0JDu9KgRajG6h8O3Y6Z/kpRHAZAAnpoSwFj0cg0I+KO2YPNGhHdZLuyV/+ihz2pYxT8S2oWtIv
	aDjKTTez5RSO5Jya6kP5Tdf5pFveoByY1BWhvxCLvsi6MT1IKQSRspDEqMCMwV3crVVhS0VslEE
	XSQsJntSAU0Mmfj+vA/1pbtILzD1O7WPZ8yw=
X-Google-Smtp-Source: AGHT+IFBPm+B16qVANv1DoxC6vOtKA5hFXH/9/z18laWz+BpnD3q+GRR0AVQzsDlO76YQvXPR8XguQ==
X-Received: by 2002:a05:6830:914:b0:74e:e67b:8bfd with SMTP id 46e09a7af769-76326b02a89mr2557722a34.27.1758147345344;
        Wed, 17 Sep 2025 15:15:45 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7692c725368sm313928a34.41.2025.09.17.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:15:45 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:15:44 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/15] odb: move packfile map into `struct
 packfile_store`
Message-ID: <54aadwxqaxm5sewgxg6aegfrvtqrdla6mxbhkrdbbufgqpb3sd@ymwtrihoj4kb>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-4-d6340350934f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-4-d6340350934f@pks.im>

On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> The object database tracks a map of packfiles by their respective paths,
> which is used to figure out whether a given packfile has already been
> loaded. With the introduction of the `struct packfile_store` we have a
> better place to host this list though.

Makes sense.

> Move the map accordingly.
> 
> `pack_map_entry_cmp()` isn't used anywhere but in "packfile.c" anymore
> after this change, so we convert it to a static function, as well. Note
> that we also drop the `inline` hint: the function is used as a callback
> function exclusively, and callbacks cannot be inlined.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/midx.c b/midx.c
> index 7726c13d7e..e96970efbf 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -460,7 +460,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
>  	strbuf_addbuf(&key, &pack_name);
>  	strbuf_strip_suffix(&key, ".idx");
>  	strbuf_addstr(&key, ".pack");
> -	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
> +	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
>  					strhash(key.buf), key.buf,
>  					struct packed_git, packmap_ent);

In `struct object_database`, the comment above the defined `struct
packfile_store *packfiles` says it "should only be accessed directly by
packfile.c". Now that the packfile map has been moved into `struct
packfile_store`, it looks like "midx.c" now reaches into this structure.

Is this something we should consider?

-Justin
