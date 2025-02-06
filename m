Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1821345
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814832; cv=none; b=V7z6NXXLn2ea1HNDCPSk8NuwFT2aeRoov4fnIRJJTN0foRtp9avD+Qcs/BVRyWIHyAEZ8OJlXIYt0Nj7bqW6DDJG+z8cz5OX7mLJ2xhWc0hs+4BXYIcifrkA/nDGacQsRXI5w+OGJ5Obl06qOL39asl+fgQAGGHe4yOPtCyljiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814832; c=relaxed/simple;
	bh=snf56Pvtj1r4v2nXvtTOkAkiXCoWRevzTHzc2h6cLYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H960C7Y9Dmun37tMvmTO9rURaexQ0p0DiHdgY2FL6D72MixsbAeeuFnwrrsy+NbLFTUaveeZTQGEAKnPheBohRX0E72RiSriVjFUwjj27gZUEwnJq4xJ4gWyDxWmJLuaP8qzxMVCTnvZZA/VnrQ+Jo2kj+qVA9w6BOjmcYx8fhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQmw+XwH; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQmw+XwH"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb7ecc3c54so298433b6e.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 20:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738814830; x=1739419630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BEnuxXxwdH0IM1q/Y8lztypn4ayCZNOPs77+Fem0dA=;
        b=HQmw+XwHjNbHPh9/GVecwdw0ttBMA1jYz76znCgXi87hez/rsfouLB/cekjfGttdjZ
         s6ngf0hMa7MWL+vwRLCSh+L6BwQvKc7o/hqZgH9qjkXgg7x73EpdfPOAqjrlYjkTOPau
         uLoABJUMp1jYTPr4ljCVxZQq+FrZpd/jBoxXn50GZLR78TJlR7Pef+pXPoiDnkNMia3U
         efCWzaiTsCkfAYM2yrelWrrbmZatQf4h+bgshO/z1L7L1qJxKdTzCvOKtUGx/8vKvpYR
         CFiS8yBbiFsmCXRw+x6wcd/dufyBZMEHKHCTtW9mUbel0Jv1FY184W7b5ijMX8qJB+Jn
         X8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738814830; x=1739419630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BEnuxXxwdH0IM1q/Y8lztypn4ayCZNOPs77+Fem0dA=;
        b=NuDpnWk4TusM4LQ9aaaxG/Di/fr/cKBi2tAGZqdSYB9rADNQEbPXimm3zZJyDAKe0v
         sV3TQ3iAJD7Q4w6uSL1L5OJWyz5Di8m1d9iUqacqMoOQDysQzftuxDvGg5+N4ORD6pun
         hGCr+pgO+/FE/c/NQp4F9E9XzZOEq17DwHA60p8ySyrbjd6YRKpbpYzAYeHBVOCfkFic
         8jDEcC2hsiZauLP8btkI++sFlnrGsq6HypgHLl+uMrIsziyjkCZmlJZF36hctRk3KOAD
         rvAnFscTcrRimeag+Okw4R4crIuAYeqCsEK7tMSLqG2A42oz0Wl94sV9EibnKqZs9d7A
         OUow==
X-Gm-Message-State: AOJu0Yw4zv5GHhNSehIMtrTDjBlnWbr8df7oaTxVEcT44tZFAvOJM+eh
	qb4L48oGlO0/gQ8ttrC3XrggR1XZyC08u4WZT/jS2dd5IeAk+kXK2+j5Bw==
X-Gm-Gg: ASbGncvltkAtEum9SFknhwIfQGVc6s7IuA0WBoh+5NhFDadAKt1ovsS64PquuG0v1kc
	BfGjUwq0aDzOIkbKjhorGC6p5HgsniI2rDE2vuClofjQTtpWogonUGgLhr0ULgCS7tOj0CgBYyA
	DDY7bAljwtTywamC3LJv4Fil7j/0P3Q22KiWxysTnLz4h5mBLmUFvuOU6aVWgdnXtEWyiP+3Fzn
	/ErqIzRIL1pPmcpzqIOu2ATDs6YtBBO1SE8h2OLp+A3ZQZTTnPBYdUDrCNwMk6nNJKI836baXKg
	t0FxuhKX
X-Google-Smtp-Source: AGHT+IFSD039co/SIjlkAYAhrsjWErhdOC79xjjglOEb2aQ/dbcxTaWa7T9f5UJvYqJpdJs7mMplnw==
X-Received: by 2002:a05:6808:218f:b0:3e6:5a7f:e102 with SMTP id 5614622812f47-3f37c10c1d9mr3705212b6e.9.1738814830430;
        Wed, 05 Feb 2025 20:07:10 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f389fb4e5asm56430b6e.40.2025.02.05.20.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:07:10 -0800 (PST)
Date: Wed, 5 Feb 2025 22:04:12 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/18] reftable: stop using "git-compat-util.h"
Message-ID: <6kamtfoc5gsltrreu75n5we5qwylsnic2b5waxjcgq4hvtopl4@6j2dswje3i4k>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>

On 25/02/03 09:03AM, Patrick Steinhardt wrote:
> Changes in v3:
>   - Fix type of `total_read` variable used to track how many bytes we
>     have read in `fd_read_lines()`.
>   - Drop the patch use root-relative includes again. Let's rather
>     discuss this outside of the scope of this series.
>   - Link to v2: https://lore.kernel.org/r/20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im

Thanks Patrick. This version looks good to me!

-Justin
