Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104EEAF6
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751249255; cv=none; b=AzfRiuAzTst73mIYYUyoc8GiBmMEN4/DaFsiDUsGNA5YL2iYF9mV+IlaR7oqUiCEvVM2pjMZgA3oT3AU4+CBGcu05CGUx8B0oOZgMcvIdsPAbBAn7QBI8lT3xCHct3rBKBteiSbsUuczR1Kj4knqN0goesHu1p+HT46DD1sK8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751249255; c=relaxed/simple;
	bh=eztY/wp+ejzq2y9wQI1lp1CK94E4c8KRWm1FklRVT5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOXMT1aldOqF2qTfOMS+Qr8HEbdGV6N0UKUH/gPwLToU0r+8j5mLKz32vDl3YUl94X/z8W+yYDGURazNDYyPgfZnUemQYOmTfuwTJeoXLOMEKZyceIi0tmP1/J5o6pQjibQu9g0Awkb8tjYOIBDj1dm47Ls3K57X9Z+W1m42pCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPUByBf7; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPUByBf7"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2ea080f900cso493561fac.2
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 19:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751249253; x=1751854053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMYUTFfx6Bx8BRVLBiagAcMj3/WIqmPFlzF56o0APEQ=;
        b=kPUByBf70+KdqJyL0+5qJZrRR6SlnXI88O0p7gn3UYyXPeZJefkHebxz0/x4if/4a4
         FQlWjQxCsYpR+Wg/kqaTUMMInqdqY74CnHKwgEHqgbyi7TQlNDhULps5nyQ8jwyP2Dcl
         tzMCt6mXvAbR/CI/7iQ8KuhA01e0nnD1aPf0sAMuSu7ZtmCmCVWNOrkElDmRbwyX12Gs
         YDD/+dCxXyubk8XpZOpUfrQpcGz0EVgKphuGi3o6wkJKjZjCC8mRdUYILKP8m0kPQ9/b
         f/i5NsxyIoUX63j/PK5A6Ut5AKuhzoGoYkcJ/uj9uCcfAgb9GqmC9LxVm2zgKTbKyX20
         qklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751249253; x=1751854053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMYUTFfx6Bx8BRVLBiagAcMj3/WIqmPFlzF56o0APEQ=;
        b=PhvHz8dh15SxlnoYW001f6YyN48Eznl0SQKOhsokGKiDCli0sSayiCfU6nXk27xbfF
         sWGHS588zj3dJh+G4Zhr+1YFvfIaq2fKvSNjd7pfyImcgvoAYVx6izxkSSyWCdZCghMV
         Yff9jphIFqsaGzFB6zRcH91BhijCIBKIfugc9WQwOq/myeUVDKDxwueoA2+L+XtFptiw
         o7WhAtmHSPan25qSJpLY2dETWb/2fvgKuoubI8FGZovBZcs9T16Vl/pDdIzv35KsBxAx
         SxcQsdOWa01vIABaC7R71AXTdGV82yh2nrSUhj1W8+zDJzmowGGXZLA/0zq9jRL0ybpX
         dWAQ==
X-Gm-Message-State: AOJu0Yyq51MpPXkLyJNxo35NdCl5Ug6wicRKciU85uwrRhffSAwusHlh
	0mUGtd5STg1RdBndvFLFoGfbt4SS4kCTtkAbdK9CZBPnUz9PUO+kI/a6
X-Gm-Gg: ASbGncteSTv4IW24QQM1UtxDghAR6E/JV347c5TmoRQZ/GS55JhIYJEPwVeJIbiZQGe
	qmUcQ0sU8Hwo0zomhiqduvCEHKcErqD4xzPYWmrQMdWIobyoeLuGCcXXRScsJgazoaFyeylzJMS
	oNe6dt8hnuwTSdxQap1xBpp57OWQBFCj+5o1Pr5wFQmdNJVzCaDB5G7Yxfz+0h6J+PGwC08BH7I
	OKk+SM2pp7ozBF5XyoY0HPnalCAkjC/PZRUaaka2/d5fQFRkdA60UjX39uLNGdLHHgX/Q+Unu/e
	j4fvuvlw4coTlidQF+pjV+gfFlZrxqPrxa4ocJhcQB8nDcoVAHatzFA=
X-Google-Smtp-Source: AGHT+IEjeWnN7rNZaN/HzMIfmnaRfxXHxtzcKALOMffhWpT5mOPBasJQ/sCAoMvaiGwbt1CfK8GBUA==
X-Received: by 2002:a05:6871:a0c5:b0:2bd:456c:92a with SMTP id 586e51a60fabf-2efed4c2f86mr8527595fac.10.1751249252859;
        Sun, 29 Jun 2025 19:07:32 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4eaafdbsm2480648fac.7.2025.06.29.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 19:07:30 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:02:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 02/17] object-store: rename `object_directory` to
 `odb_source`
Message-ID: <yeimqezalnffifo57opsmngxdyggu2rv53mj3plp5alx37j6pl@slkxiv4brpso>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-2-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-2-779d1c28774b@pks.im>

On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> The `object_directory` structure is used as an access point for a single
> object directory like ".git/objects". While the structure isn't yet
> fully self-contained, the intent is for it to eventually contain all
> information required to access objects in one specific location.
> 
> While the name "object directory" is a good fit for now, this will
> change over time as we continue with the agenda to make pluggable object
> databases a thing. Eventually, objects may not be accessed via any kind
> of directory at all anymore, but they could instead be backed by any
> kind of durable storage mechanism. While it seems quite far-fetched for
> now, it is thinkable that eventually this might even be some form of a
> database, for example.
> 
> As such, the current name of this structure will become worse over time
> as we evolve into the direction of pluggable ODBs. Immediate next steps
> will start to carve out proper self-contained object directories, which
> requires us to pass in these object directories as parameters. Based on
> our modern naming schema this means that those functions should then be
> named after their subsystem, which means that we would start to bake the
> current name into the codebase more and more.
> 
> Let's preempt this by renaming the structure. There have been a couple
> alternatives that were discussed:
> 
>   - `odb_backend` was discarded because it led to the association that
>     one object database has a single backend, but the model is that one
>     alternate has one backend. Furthermore, "backend" is more about the
>     actual backing implementation and less about the high-level concept.
> 
>   - `odb_alternate` was discarded because it is a bit of a stretch to
>     also call the main object directory an "alternate".
> 
> Instead, pick `odb_source` as the new name. It makes it sufficiently
> clear that there can be multiple sources and does not cause confusion
> when mixed with the already-existing "alternate" terminology.

I'm biased, but I think the new name fits well ;)

> 
> In the future, this change allows us to easily introduce for example a
> `odb_files_source` and other format-specific implementations.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> -struct object_directory *find_odb(struct repository *r, const char *obj_dir)
> +struct odb_source *find_odb(struct repository *r, const char *obj_dir)

Since we renamed `object_directory` to `odb_source`, should instead call
this function `find_odb_source`?

Otherwise, the renames in this patch look good to me.

-Justin
