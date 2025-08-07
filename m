Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693D1C8633
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604997; cv=none; b=ThHl8K6WYH1hs0MkEVqp8AtOFsYWMuuHYXeYEBixJc+A8wsKGFqHP5SqJJSDuN0mMKitsZpzaC2Uaf0lTsUwWf7lGgqd7/nXLOX8LDjIoI2lZ7rV+76+qAeE0oEd5Le9Cy388vYXLXfj/q9M2SlTSccWVwUPPtlf3297c7wrI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604997; c=relaxed/simple;
	bh=TX52k/rhgGeTivs2wR3eBq35i5lvB2CvEJcfqEy6LZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfVLw9lV9Uk8iyAW7ElNXrwBF80YKoskC6VwpR5lw369UIc9aS8uJeroDEjI4HaMr8nwT8EBRgo4KvdGoG+cQfFs+aCm8OkriMFKKa1ym1jWM8kNGltwp/F0bM3PwqeJnH09VMk3htX2CYI+HYdd7tzHAY9MW9Idp9DesV5g5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LRFmFvsU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LRFmFvsU"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e5328231e6so1237035ab.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754604995; x=1755209795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiSUY7uUqL4j9jFlzYW11Sx9Aymf9wJLIWBMDZXvaDY=;
        b=LRFmFvsUYp3tVe8bFUACXLCJZyHDLoVArMGM7knVNUx5dJ7BBS71nB0X9ho2EzzvtN
         eYfsm6F0s6HMTE3b2fjU/2DI2O1mkminfE153h9k29skWyzpF3ap8zF3IMTkPRJKPgq8
         E7Jhw+wQ6RvqmmSkaJ7hWsqMw5IZTNCYRDoeSA1mvxT+pO/uXOqm7+LGeeA+hXtxc7V4
         86PC4qKPYFMXyaSr2Fd2faKMP5niQOKuKPJyncvDz1JVJR0/LtnjFScXdNrsbbic5TV+
         011I4Te89n/KMTkucIQoSXa/Ldg7jSweflCA56ATrShm8hl5zkOEUqVTbo0hQPjkuNCQ
         md1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604995; x=1755209795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiSUY7uUqL4j9jFlzYW11Sx9Aymf9wJLIWBMDZXvaDY=;
        b=GsRZUOQYS/pmPSujsbWuapPPWOgFCydKNFFzkNm4d40uMeqDtnEhrdqElSoARxQpKn
         gLVUJa5gVUkcQQXc4Pflc5GORKx0xGyEnfCugTrXaUGojEzini2LCOTjLylcM/f8oY7o
         lv18Cdp0v3/E07H8PRHsULW6ThNZmfyagl9rQwck2Ah9HXdcl9QHIHwBbxk1IA4kL2KU
         +rIa2SGs4AuBDoeHrApOdpb3MGiCmpKoR5GqFFHkc3TCMLvXkwVlkj8U3RluM2UTOBJB
         3rg1wD6cEwc1Rz4jyaB2ojWVbU+3MZZOgUkF4GKVA9SFQm97T2h1ES9asMApfQoB2gD5
         2Orw==
X-Gm-Message-State: AOJu0YzQ12H+wI/rSbDV508GmhhFvfP28NXJ9ApZwT0sibPIxckV5wVR
	3/+wUMywhlcEalADSN5mVUrk+OqhOSKL43jeAQeGXSK3Hh+7cRTteVX8ukazJ0QA7hI=
X-Gm-Gg: ASbGncuA3aYNTauzOW1xlygOblOKyxGj7d+2VeO7PY0FTncWPjjuMursg9iJXhojNGq
	aHTbxKX6RpZCpxdrDHjpxUQStQj84Ng+JRToda/gXKy2qPGwI5uZqIoCmENcGUkI3FmL16Uke45
	cxDI1bjhdMz4gSnejj1RELIUNd6LOVRPM0Ho4MoWFUFebAJz5scB4ud1jH9AW/yG3KbYdM726Vx
	mHe5opWukRem0WlbITxNfiKTiVi/2OQwfDbdOeWlant9BE2FqMb8HUDL/er9Fw/lKogZx5bpeDr
	iDFHWI7jYdgSeMlp+n25l/7hTKVmSDkBNGQJUheerErs2ax+7K4MjGpVm2r7hgzgZra+GFi9SSm
	6NlcAnWoSDmvYXpEOQ4vLhm9P78xw4GR3Lkj2LBwHi5iwYW4oo2/B528EJclfpGjX844Gng==
X-Google-Smtp-Source: AGHT+IFjYIj+pzBrRZAtJzJ09vlzkThVzzcfSRCUljuVsJYRmWoY2FuQwD6Zf69SxDInsFC/90mneA==
X-Received: by 2002:a05:6e02:1547:b0:3e3:d289:43d7 with SMTP id e9e14a558f8ab-3e53318a48dmr17479175ab.15.1754604994925;
        Thu, 07 Aug 2025 15:16:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae9c6a1afsm73020173.81.2025.08.07.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:16:34 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:16:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 3/9] odb: return newly created in-memory sources
Message-ID: <aJUlwLJyxSmD4EQF@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-3-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-3-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:53AM +0200, Patrick Steinhardt wrote:
> Callers have no trivial way to obtain the newly created object database
> source when adding it to the in-memory list of alternates. While not yet
> needed anywhere, a subsequent commit will want to obtain that pointer.
>
> Refactor the function to return the source to make it easily accessible.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 37 +++++++++++++++++++++----------------
>  odb.h |  4 ++--
>  2 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 61104b7cb8..7793816f81 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -139,23 +139,22 @@ static void read_info_alternates(struct object_database *odb,
>  				 const char *relative_base,
>  				 int depth);
>
> -static int link_alt_odb_entry(struct object_database *odb,
> -			      const struct strbuf *entry,
> -			      const char *relative_base,
> -			      int depth,
> -			      const char *normalized_objdir)
> +static struct odb_source *link_alt_odb_entry(struct object_database *odb,
> +					     const char *entry,
> +					     const char *relative_base,
> +					     int depth,
> +					     const char *normalized_objdir)

Beyond returning an odb_source pointer from this function, it looks like
"entry" was changed form a strbuf to a bare const char *. Is that
intentional? If so, it might be worth mentioning it in the commit
message, or optionally doing that as a preparatory step.

> @@ -316,17 +315,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
>  	free(alts);
>  }
>
> -void odb_add_to_alternates_memory(struct object_database *odb,
> -				  const char *reference)
> +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> +						const char *reference)

Not the fault of your patch, but while we're refactoring, do you think
it makes sense to rename the second parameter here to "dir", or changing
"dir" to "reference" in the declaration of this function over in odb.h?

Thanks,
Taylor
