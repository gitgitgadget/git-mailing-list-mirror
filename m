Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579B1C687
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168827; cv=none; b=mlVIcKhgfT8Cd3O3YSz2yOZXhax8RnpJayVsuusPlk752BKWTHuMmoJnD53ex8tVZAUjeTkhS54+y8/DvH1hJ4OpH+1AbGizo9q/QMbnZUOHWQhwi74EGEvKrYanynfhAy2acRSE89Y42wMDmRkna7EOI++oe7zSBrfFcQxrLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168827; c=relaxed/simple;
	bh=2tJH93Vsv8njSJP0pOazcHPVGAE4ytsHVI2UXSci+84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKCNm8GpgcoBhCrmGYVDEE0przgMX6Mv7UEx/8uzIRz9arMNca0K/HIdzNoaBo/fGXgz1hM3RZ+6J52rjicquYikNusnL6I5FYnj8U2GB2FQo4s41dzwsMTo/02BdXl+6A6O3X+zfiWfBO6Yuz8v2cRJZMWKSekwgDMxJpeVtfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqvX2UWr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqvX2UWr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f60a502bb2so16428295ad.3
        for <git@vger.kernel.org>; Fri, 31 May 2024 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717168825; x=1717773625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QP9o545LSS/bzBWlwgsLgVQkduwfqGrnnzmgku+sF6o=;
        b=YqvX2UWrHDGiYhV1o9ITPSzCa8rAK3b7FN1JBrG/LVBN4pF6iTJaNuOStThyJgZn/Q
         AFoBmIYzyCJU1/cZRaK9uy5X7TzGuIx6YTCnnD7A0YC/hZlluJaVFvcLSBWlPM9qLLTm
         6P9B1HwOekAP8HlENOF8YZLRkcY4678aPZoxnHSA5qY8mm6FhIEopP27lYoPbkJzUhRw
         9VNf3fD1zb13o9rJ8suPu15MfajHcvigN485MhFf8hrSajquvd71Yr9EHIHuNErXEiiE
         DVeYoRhC8qjMktXzT/PBvfRSF4HtMrBs4cScm1q3VqaAPmZJyQFmTIQyVWxvVo1X9YU7
         XJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717168825; x=1717773625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP9o545LSS/bzBWlwgsLgVQkduwfqGrnnzmgku+sF6o=;
        b=E4POugXoXx+PGT4iDUF35HHq2rOBb9VJpRml/hFsYZ9LvxQhHnEuj+JacVIxZp16se
         93wpX7IFdq9vuWmbutBVD0LvyupwZRLVVMvZbIvuxHmZWinw3JExIV22+1LnEjepSwyV
         XfbUjEzuMlIJBpFQuhXFKRApuuqCQYbZpGK/MVHiLQnEoUbaZlpxwubrWw/NJyePyvJt
         OTFZUgTdeo71vNLG0tXxy51Z/wtHNktenPzhvfP9I5mxkgp5NrRWL6lu/D/by7LVdqdf
         kUsT3IfCkJwPkYSMMucb9Wzx+OZ5alD0cSFOzr8gFvu3sJ27h6yqjnxsPTIErv21U0Rg
         5BaQ==
X-Gm-Message-State: AOJu0YxnGRQ0QAOFzjkdkpw1+8GqH1twSMVO5EPUGxaaYm+CQWLWJ/wW
	k3+kghm1JB2n8rc/5JMIofDOLbJ+8SFMMK0EW9pI4r2hK3VTM50V
X-Google-Smtp-Source: AGHT+IE9AbPcZov7l+a9ZhZBgbOINChjD+MIhStan5UlZlLL2zW93P5/2B61xvgbYlZu6jpxgW6uyQ==
X-Received: by 2002:a17:902:cec3:b0:1f4:7db9:7366 with SMTP id d9443c01a7336-1f63712946fmr26121435ad.29.1717168825125;
        Fri, 31 May 2024 08:20:25 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323feaa0sm18054375ad.230.2024.05.31.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 08:20:24 -0700 (PDT)
Date: Fri, 31 May 2024 23:20:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 1/2] refs: setup ref consistency check
 infrastructure
Message-ID: <ZlnqtRgBsGOZ_3Uy@ArchLinux>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240530122753.1114818-2-shejialuo@gmail.com>
 <xmqqfrtyjc0w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrtyjc0w.fsf@gitster.g>

On Fri, May 31, 2024 at 07:23:27AM -0700, Junio C Hamano wrote:
> 
> What is the extra blank line doing there?  It makes reader wonder
> why the .fsck member is somehow very special and different from
> others.  Is there a valid reason to single it out (and no, "yes this
> is special because I invented it" does not count as a valid reason)?
> 
> The same comment applies to a few other places in this patch.

The interfaces defined in the `ref_storage_be` are carefully structured
in semantic. It is organized as the five parts at now:

  1. The name and the initialization interfaces.
  2. The ref transaction interfaces.
  3. The ref internal interfaces (pack, rename and copy).
  4. The ref filesystem interfaces.
  5. The reflog related interfaces.

I firstly thought that we could just add a new function into the ref
internal interfaces part with the name `check_refs_fn`. However, the
ultimate goal is not only to achieve consistency check of refs but also
consistency check of reflogs. So it's not suitable to name this
interface to `check_refs_fn`.

In order to keep consistent with the git-fsck, we decide to name this
interface to `fsck_fn`. This semantic cannot be grouped into any above
five categories in my view. So I deliberately add a blank line to
indicate its independence.
