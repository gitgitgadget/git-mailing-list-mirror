Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6A260566
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003852; cv=none; b=CzCNLA7D4A6zcvLzfrxTKOIrt0bd51QS16Y5JGO/99Cu3oT39cf+/4UUhw1EOxFaNVZjDJyY9Bi4grMja5Y7byNIzuH5/mB/9AsI+osZzRw650T2Z/y9TOK3eZUoi7cqtsmkOl9nAtNUfIyIr/Oy3zT+z6mv2XmeW4aqnJ1sMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003852; c=relaxed/simple;
	bh=emABobRH4o0cIvEyi6YlrjIm1jz5/sz56xxYTWLortE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltWf7HwLalGYMrvdvQ2JeKomXn+2vyUz9vkoRUaojeGpMzZzdSJ7F+gKABG53EU8juAqRBzgWdWIpjoLjBsAgqpcZdT7fbJQVLjSbRnZ7Ri1af/duccAaQlN8eFFekxK/yixc+9t8KUqfhbzLx3fk6LFBQfjh1E5avsHdsXYCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kO8RlWhs; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kO8RlWhs"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786d1658793so3218297b3.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1763003849; x=1763608649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+raOYtwTtbTSP6q7qzRMQWQTW6dWHmIQS1qnSBt59Do=;
        b=kO8RlWhscZ9DyzPQfjqVD0SwJKQmIokBWNo0cEeV1f2jvWy7FcfepokrTp9vXdk+1y
         o49b03yp9D48SlSQ9VqbAuZMSCHDTLFGqYkNAkZb11sAwPHP3VIFdxPXPzqyjl45QpHO
         mUq2HmB+DurnnN51JOmjVd2AIcMG/dpeS4y51jUWX+OWIThfrseDqldPiBqt9ETTbRoA
         VHKCo485F4CQy8ZVlhGrO4VnLTE1b02JxnR5vHhkpqabLfbdIPnmAGfF/BHJ9VMZj8pG
         LQBp9H3RMaOOro9LkyYiVI8n1C4OBIC2UOH2Xy6kMnNYbATGMh6zzNRToX0XWioX9mcc
         jfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003849; x=1763608649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+raOYtwTtbTSP6q7qzRMQWQTW6dWHmIQS1qnSBt59Do=;
        b=pSrAQBol8lJYEKFCR+bl+iQcPhIUMXd7KCp8dNhCqQ8Dtv91012Bves6Rbl/U+kog/
         4wridCrODqw5QI3BXlYAfSRGW8E8n5t5vO4cinchJrz0Lb8qLbN8em5NfBjD1gG9CglK
         P2/32b89U9qt0cDMC8v5iT5T3qvzlBWEh9n/mi711C0ZgF4Kwe7Oe/LxLaavcPLybDPU
         c3pqJ5YAiNtzQbA3w5FCfOHBWAghjcNOEF109JV/PfxZ4gsc5BGIcRZyWCP/48ZgdhYe
         QiSkTIx039WmsjTwEvBibgtCjPfbJSxjdaoPqauBK+nNLulDm2VDOB+FRuALMhLOrir0
         NTMg==
X-Gm-Message-State: AOJu0YyVhdBMFllXPhGRFxu5yrwij2xoHQgX4t+EmFSOuKDXd3bLFpDY
	C/hMc6QR3bn+C/nM3Oganvp86SiddXYvy6gfTXBzQkb3uiGl1XLJsg09PZOI+7/EOVQ=
X-Gm-Gg: ASbGnctpIUm4Ff5IX3SvTh0n3QztnYMbXxFmtVTBeYg1etI+/lJBMu5Loce8Dj0nHIA
	aopyf1CZ8/+ODqSDf47zy8IXB5oFuEvYRvjcfOUXG3bHT0cFFi4tHcfXJU2xNn+uZ5KAVzY8FFT
	0jHUeBOQUlE9ROIzM9YkEnFEbgGHssqEgqZkTdkXQ27fD16BMHAyZRg/nmVZQ9z/zC2KD4y7LUB
	zYsg5vY7kxnQVuy8OPTDvSbFhnWRIFeLbWeAw4aTv8SreBKiS+hpPcQdbJ0+AsfZ4duicY680CD
	MF+c6BbYRkH2D/v8O87FcSs7JkpuCaz3pDtilPrWKg30a7NPx7kyOPC1gead4sgR844RD6lCjvw
	SavXwSSB4EDU8rJ3Gde2J4hA2ORdgOPloWEUA3vM/POnJK8JWGuZNoMehlPQ0+vA8m6McXnTFsZ
	zTaoBUyqX6iprw8M1sihZ5kRtTzYNqurcO2OtftTjjFJV+2og=
X-Google-Smtp-Source: AGHT+IFVdiByETXeSO8dUt868RjFiKCsLtr6XQS+sBoGNZPAug6HGIpSg0ChuIYlAxhSVag0/NGr8A==
X-Received: by 2002:a05:690c:3602:b0:787:f043:1f10 with SMTP id 00721157ae682-788136c3cebmr81615447b3.66.1763003849646;
        Wed, 12 Nov 2025 19:17:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78822177ee0sm2779847b3.53.2025.11.12.19.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:17:29 -0800 (PST)
Date: Wed, 12 Nov 2025 22:17:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>
Subject: Re: [PATCH 0/9] asan bonanza
Message-ID: <aRVNyGHJMqR+9WCy@nand.local>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 02:55:22AM -0500, Jeff King wrote:
>   [1/9]: compat/mmap: mark unused argument in git_munmap()
>   [2/9]: pack-bitmap: handle name-hash lookups in incremental bitmaps
>   [3/9]: Makefile: turn on NO_MMAP when building with ASan
>   [4/9]: cache-tree: avoid strtol() on non-string buffer
>   [5/9]: fsck: assert newline presence in fsck_ident()
>   [6/9]: fsck: avoid strcspn() in fsck_ident()
>   [7/9]: fsck: remove redundant date timestamp check
>   [8/9]: fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
>   [9/9]: t: enable ASan's strict_string_checks option

Naturally I focused on the first two patches more than the others, but
the rest look good to me. I left one minor comment that you might
consider if you end up re-rolling, but I don't feel strongly about it.

I like Patrick's suggestion to use an interface similar to
git_parse_int() instead of introducing parse_long() as a strtol()
replacement. That may be worth a re-roll, especially because there are
two spots that would benefit from that style of interface. But I don't
feel strongly about it either way.

Like I mentioned earlier, I mostly glossed over the fsck patches, but
they all look reasonable to me.

Thanks,
Taylor
