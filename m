Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FE331EA5
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646824; cv=none; b=rmn5+wNYd3Ba9gLG27dVotROL3LMpx2XqIZgKlsYNZR8sH8RBW5ERpYP7nEQc4c1PQwfJsSc3pfTHz3EbHU4v+XA3DzC5sXB7D9oLz4nCvhgTH7dS4YbiZRbNQyuKwJ1oSJJhRJvabsQhtnJafWOn8ucb/KJ19u1jEP27F9J8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646824; c=relaxed/simple;
	bh=RBTHoN4nkszIM0s2wD377s8S0W8pvGJZgg7M5oqKm30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI4fWMHSB2BHI4RzE43lSBvRZPzhbbx9656a2nh0PwgzXckDciQfdATSi3GZV+Akl8S5cnlAvfAvdzIg31MZDY5Z3dVwrCwi1tjJu+XlnSotRoLf1nO5dy0YiutNZo7VgNAeX5C/RSmvBNhW6A3HmWZ3BnzC+vfCEfKNflaDjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksm8G9GI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksm8G9GI"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69e4ac3b37fso3734364eaf.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781646822; x=1782251622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DirekZq9qsV1Bq8B0qpQ/vGrOmN49F0rCIdi+V9Rjp8=;
        b=Ksm8G9GItyR51dk+qvKHLXMXknhRHjQ6xORY3GCKlT5+P5EfaiFSijtnfgSJNk7MzX
         6ONOhkWD1ahchgdKbt+21NhxYpF+uqJpxfsdJWW07PWimKl5PPyVFeYbOhLazyP0HNDd
         xk7bu0zVWsvjSVzg81Wv/qCPkVsIR5wDlqc3/B0BAewtGShf3yKKNPXFBHyauuMVY4j2
         PlFEtlm03+3Sb+ggZegsDFWFNmBdp+0hj6hFSaR6Oh3ZQRzFeIGIrIK5JUPzCQeSgZJO
         RGnvMHU/AS7kw35BLfn+14jP8s1SNuvudtXuCLn1O2aOlopW/lAp8mPK3JQ/14Etenpm
         WwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781646822; x=1782251622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DirekZq9qsV1Bq8B0qpQ/vGrOmN49F0rCIdi+V9Rjp8=;
        b=gqruDWUoH+Hpjs+4rVfSsJ3mwhiOf7ypWiMztw4i7AsH5/NBE7Z2gzLoxZM3pJiMKl
         Q4lX6M8IaJrTB4zBR5tAIkFWohP2C2g5o8MtzbdfpX9slxt1ex5fKp9Msln1SBW5a4lm
         Qt+QBymp8RxUpZklKpCgBEhbFwF1QIO+GExFAkYv6GpjvN5MwDZdrv85dbywU8U+Wbbp
         ISqHKBeAYujGbU6EDHWNfyTWm59c2RHcRrD80PheRXKSkOtVRGUB6Pyv5IU3z2+EDPDw
         e3RQFtumeeGAYDkiEzqKn0YVtNJU9r9zX2gKjZl5RWBbbnYmL6EE+8I3L7AP5wvTehBo
         PNfA==
X-Gm-Message-State: AOJu0YyOwVVFb1ibyV00xiJZ+6Rhj+kukTZIqCsFd5f/E9DXz3oyWrK+
	4nBWunrWrn0P30AH1SxMz/aLk7hzpVinmE9oTeDzKMArWnK6A6jOBE4L
X-Gm-Gg: Acq92OGZM2XXet0kCaVWmBQzRBiux9FIqkNP0WZKm1T8+w2Bl9FGppDi3s9dScimBP3
	Glp3hw3TaYLekK2+d090HG5sciQJCOVba7NPIxwGJ60K0m8yy/ppUaXSrfipzfKHE5vi144KVPs
	DM0ZgwTYoKlYHUZTcSdIeOmYcjKT9iSBkhVO14GhqM9Uf4FvVK4ci4onLOp4wSC5zDH2wol36j3
	38ypa0tAeIc4O+0he3WR3OrHIgzASINVvvs9OLIRRpymuEUjh877erdDEzlnoj5GFYiCogYMsMA
	MEmfaHWwH+Xxd+CRdIA2fj4bpQ/vSt4wyFw13M8keHZPhB9wTGqZHLeQR7cBuamM5iP80zp7IzQ
	eNBFhT4ks4oH2AyZDEbYhEk9LPXWKw1Kx2NK4QYXfl+etRQrvw2IsPYdvJQnmB5SliB82obyNe2
	czIj2PH3xYz9sSxunL
X-Received: by 2002:a05:6820:1987:b0:69d:cfb6:4f4a with SMTP id 006d021491bc7-6a0b5ed0458mr828174eaf.15.1781646822131;
        Tue, 16 Jun 2026 14:53:42 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308afc539sm3112928fac.6.2026.06.16.14.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:53:41 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:53:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/17] odb/source-packed: wire up `reprepare()`
 callback
Message-ID: <ajHDm_pG3Ckca4mp@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-7-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-7-839089132c8b@pks.im>

On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> Move the logic to prepare and reprepare the "packed" source into
> "odb/source-packed.c" and wire it up as the `reprepare()` callback.
> 
> Note that "preparing" a source is not yet generic. Eventually, it would
> probably make sense to turn the existing `reprepare()` callback into a
> `prepare()` callback with an optional flag to force re-preparing. But
> this step will be handled in a separate patch series.

I do find the prepare vs reprepare semantics a bit confusing. The
mentioned change above would be nice to see in the future. :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
>  static void odb_source_packed_reparent(const char *name UNUSED,
>  				       const char *old_cwd,
>  				       const char *new_cwd,
> @@ -58,6 +214,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  
>  	packed->base.free = odb_source_packed_free;
>  	packed->base.close = odb_source_packed_close;
> +	packed->base.reprepare = odb_source_packed_reprepare;

We moved `packfile_store_reprepare()` logic into "odb/source-packed.c"
and setup the callback making it accessible via `odb_source_reprepare()`
instead. Makes sense.

>  	if (!is_absolute_path(parent->base.path))
>  		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index 68e64cabab..9d4796261a 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -81,4 +81,13 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
>  	return container_of(source, struct odb_source_packed, base);
>  }
>  
> +/*
> + * Prepare the source by loading packfiles and multi-pack indices for
> + * all alternates. This becomes a no-op if the source is already prepared.
> + *
> + * It shouldn't typically be necessary to call this function directly, as
> + * functions that access the source know to prepare it.
> + */
> +void odb_source_packed_prepare(struct odb_source_packed *source);

The logic for `packfile_store_prepare()` is also moved into
"odb/source-packed.c" and made accessible this function since there
isn't a matching callback.

The other changes are mostly 1:1 moves of associated logic and callsite
updates. Looks good.

-Justin
