Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F93019C0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148366; cv=none; b=UU15HMpPPb+MePtLjO3W+UL3p8BvyqSiMlHKdVPtPNKTbVCNPKvznZD6qrFgmOt47KbAavmCuN5LZnMVQEXG/nKXTgdThCWubuuxtFrka4ciHYjRz0i+a5zwkCyxdXrkB+beiRjK03cA90VHv65UOIbeWfTPzTgDuzN4sEBh++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148366; c=relaxed/simple;
	bh=gyvxYPl//ZdrT1W8NQZznMTYKFGfCuVLUISdmQIVMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSG4rkQecNWN0pq9QK4T0qly1MwAJBIYmP4rJCOWqIqcpLs7aWekbIfC1cI+HVnvkTbR4H2rSIEzOCwvX5r8ODA3HNstHwg1I8YObrLVIG+6PcQfxZQSYWKH/dm+yiVi4BZbbAfNoC0a4hxGgBugeCQxuHpUVI7NEJ5uM9+RQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCLMqIC1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCLMqIC1"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccea8a199so193648fac.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758148364; x=1758753164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZdFsNGXPImn1w7SE/Uw3N9Ip5YMN8TeScxydwisa20=;
        b=CCLMqIC1pPUmmbC2Ua29p/WwqYITkSjhI4m7ns+8gskuIbyXBIaASbfEaasBGsCLUg
         3kFPl9c89Lh8MWSXCzblzDo4pOB3LKnrV1HM7R2jXeRhkw+4bBOtu+8hcLMQfZfb2kHz
         w8p+rKog6YAXX6iOre13MQQWPH/1mZ67FxcICb+/iW/gO3viGuTG6Avc3zObsUO5Pt5/
         I65V059HJzDO2aHR8rWBXnHdtwaAsM1NdJ1O8vghcSfs2EdEjGfbU42NCWVl+7dMlCtJ
         XudIiVPregLaFrFKE9pv4GpEMfBFI4FmQQWH9My3rGrexNvbrczoyaKU7GbOIoOcvnUX
         xGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148364; x=1758753164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZdFsNGXPImn1w7SE/Uw3N9Ip5YMN8TeScxydwisa20=;
        b=cddYSGwDcx/hj1qlfvbal/5SGAYXLuOiBpNn6Hf7aNpO4gzEMWGdVl1KaUnaD2Y7ua
         bwhZgTy0WXOgbZ7nGM63/Uux3lgFO3lfnIro70wfE1bjLRG6yhiAvTmfriQzEciOl7Wl
         IcSr38W6942j+LJxgSujZMWLGA12dmB/xTdnRVI6DEH52eT9LmXYqmJToDLoW5WAzL7t
         ahdfNit3G7tO+vYWEmSTPf86y7gVMf5G/5JEpBobo8SWsPQiFE4rPGxOJXRCfU/a0HCM
         U1ydljvjzNh6tur2PYHTg/XiJkiCgPcT7sj6Gh/eXPIT9LyTBohcY7LYyV4dh203UG2M
         EaRw==
X-Gm-Message-State: AOJu0YwlyeK218AyDN8d4ZGiLz0fn8tPAQb78xEHRZ9yhOuogR9akDrU
	/IjIk7CShHelAD6CY3fh1KyzX1KoYW3V7Eu6e7JkSLpBq682gxfDrkil
X-Gm-Gg: ASbGncu110AtkyAaaXpJw4SPg7XOMm3aRfoJMLJISvfPtv8o+AUHtc4KEiyLgJhc888
	4FApspFQ4VWIyqTx8gFcTyFsmZoW20WHwn7Lkj1KzmrESntd6uBVYhRCFOuPLug+6smKIdJfqyi
	OmN58ey3954+o57LdbhyRUM4vjltDWjDIE4wSIehBAP4/nCts52/lUbXhm6G33EG3szYFVgvUJY
	3fpbxG/HavpyeVhYM2PWCotF8vzYpHoHFJ8W+lrdf/lE2Dz9kkPXqpAmG5M9UvazztwUnLbZRmp
	379qGW1QcQ6L716mntPUmR+9EZ8HWWu5gIosklWbmOan+WGQRarSU/QfZIo0wtbZMADlJAQta/b
	Kw/ocOO6X0A0D0qVbsur2DpOBe6avUCciuQE=
X-Google-Smtp-Source: AGHT+IE+HaNifl4PxSs5gNikoiD6F/slf4QnRCsyp48ScwMJ0KSfH9aimklxviTtACGQRiggVtJVvw==
X-Received: by 2002:a05:6871:4b11:b0:31d:8ceb:20f2 with SMTP id 586e51a60fabf-335bfb357dbmr2259221fac.41.1758148364115;
        Wed, 17 Sep 2025 15:32:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-336e41275b7sm384187fac.13.2025.09.17.15.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:32:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:32:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/15] packfile: split up responsibilities of
 `reprepare_packed_git()`
Message-ID: <p6f3xtitrepajnaho4eqwoh7o2qweim6adr3x726dbwg63kmny@cx5n43myawue>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-9-d6340350934f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-9-d6340350934f@pks.im>

On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> In `reprepare_packed_git()` we perform a couple of operations:
> 
>   - We reload alternate object directories.
> 
>   - We clear the loose object cache.
> 
>   - We reprepare packfiles.
> 
> While the logic is hosted in "packfile.c", it clearly reaches into other
> subsystems that aren't related to packfiles.
> 
> Split up the responsibility and introduce `odb_reprepare()` which now
> becomes responsible for repreparing the whole object database. The
> existing `reprepare_packed_git()` function is refactored accordingly and
> only cares about reloading the packfile store now.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb.h b/odb.h
> index 1c998a2478..ef34132c58 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -163,6 +163,12 @@ struct object_database {
>  struct object_database *odb_new(struct repository *repo);
>  void odb_clear(struct object_database *o);
>  
> +/*
> + * Clear caches, reload alternates and then reload object sources so that new
> + * objects may become accessible.
> + */
> +void odb_reprepare(struct object_database *o);

nit: IMO, something like `odb_reload()` sounds a bit better, but it's
not a big deal either way.

[snip]
> diff --git a/packfile.h b/packfile.h
> index bf66211986..a85ff607fe 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -112,6 +112,14 @@ void packfile_store_free(struct packfile_store *store);
>   */
>  void packfile_store_close(struct packfile_store *store);
>  
> +/*
> + * Clear the packfile caches and try to look up any new packfiles that have
> + * appeared since last preparing the packfiles store.
> + *
> + * This function must be called under the `odb_read_lock()`.
> + */
> +void packfile_store_reprepare(struct packfile_store *store);

nit: I also think `packfile_store_reload()` sounds a bit nicer here.

Overall this patch looks good. :)

-Justin
