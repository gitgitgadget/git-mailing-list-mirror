Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E95349AE8
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639719; cv=none; b=TK2GSxeptb3bHR8mmSbF9rgkpd1ZGtOLtJU6Sm5A838yiYuaemAWc7IzfY00NbH1U5ciLcjVSwt4X4fvg2NOJnSPd7SMZwfnEk7k9NwNGkhSM0M2el+ggEmqmI3d+IAPpQ8secqEnbTwrSdzUZ1SO4o4L80awq01H2yqLGIq9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639719; c=relaxed/simple;
	bh=o/Vm9TCiTyYuaUJXYmbrDXQam/4ZQwaBlXfmR5UOf2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2tsNq3XLT6sBkBhQF5n5X3JEAd2vUcA+wVK4Yt37sh6eBXCircCubc444mU1oj9OiaLLwJ46rnT326RZoKG2hlzSAOPdd83moe2dWfeHqCExAldwd2dsQKLM6Tl8kCwctBAoO4fj0dwgtcTsZ0+58ckDy24h2t9C6CuCk6EGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvv93a9X; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvv93a9X"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40429b1d8baso901409fac.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639717; x=1773244517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7J/QYt+L2Jm0pjgc80EThpg2PMsAag01OhZAsC+wTo=;
        b=Xvv93a9XiPQxmOMX2Ky2IRNqr44WeeHwm+w1vYAKvcggPBWwzU0kqwcvdotWVERMtK
         J0I3e+t24IomUc8+QT01b7uUF6q6bEqPVz1d623XlfP+qSHezOvedyI4+1npzQj6K3W2
         Ogq2ZCSU1pOYslf7PA99XQEyRJh5Ik+0M50VNJ2mcuDW5AOhT6WZH2zoIdjl7jMJmoQR
         HWd2CU0g27C2C1+aQj8VLPmsz8zTL89utnu9rFFzx8dvNOdr9keLkZJM4GHOBz8sVce7
         z/5VK9oVSIqwGWiJFkwjT9mFKdwz1fxvD4v4MkiOQ4zdfo2l3/0CUwPRwR2ROtS7a1QT
         agNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639717; x=1773244517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7J/QYt+L2Jm0pjgc80EThpg2PMsAag01OhZAsC+wTo=;
        b=Yjw8g5nNFlvacLmdBKrjQyC6YCWK8NyZIEPlvX2JJ8Xc59hHsLeMgq40jyIeZYo194
         8vDp15lwwzWolkli7Ylyqu7ZzsIXmIgJYqYF2EwJFAcfe1TrSgXl08tDNRrguGwPX/nz
         s/yEPVJwmlm8WA7K38AlcbZIZksJM1WH3Ies76DUPWlmUkReXigW1oc0MI8OmNT5ztYB
         Kc5r6oVtL171Cu6jUBifqwD+KePquey6vfKqlo4YtS8mm6/Xtd0JJjDzlNoJ8O8I/+Hb
         GHX6WOfPV7YIiRqT/LHGsmpJW+V67A4SCcF3cVQPT1YA4kn9L4ewrP9tjFnowlgKTWb5
         E6Sw==
X-Gm-Message-State: AOJu0Yy5JQ7Pjb9Nom5S2Og/Y6pEUOC81Bd3hBTACOUdcz9JHOUP70T/
	mFEfxhTTrm+fImNYyIl4/axdHv5j5G85MuCuVDfHT0g/HqWn4q50D1iNlYcy9Q==
X-Gm-Gg: ATEYQzznw3J8pnyl7VZFhLHJL1PmviSUsAIP78IldvnrEDUEyye+1ut7DY2hk+Homo6
	En7rha95B0YAPgJT3edB7Bl5IVG0SoAz/7YUwIzo3Mdhieo94SR/9O/siUyicPBMMYvwSl7uNWb
	9GNc3si55dEfwHRKGo1ABWvRV4H/zWE1WoS5NQFKyAjYfNe660PxfJ6XokXvVY13hEHI2LJyQNX
	SCg+BmwxkFc3f/biqDR/CzvSVDokWcR21+gojZHgiv+I7+yn+ShQVfb58bLHrW2hSL6WBzrWNgs
	Al9j35x829sde0rKKZDoIwCEasjyZCkMeVV2lIkCR6P7NVi3k/BmrAJ86+mpJZQo1l/5ipN4Hda
	j04VQr8kELa7LwqlHObAo16SMT4kVtTgK8rqLZ4m0vQZ4zhleNm6Wj7uTe/0pneSGYOfvMOCy9s
	9zKY3TMZg4Qd47mmHl
X-Received: by 2002:a05:6870:d29b:b0:3f9:b172:33e0 with SMTP id 586e51a60fabf-416ab4dbc26mr1346558fac.1.1772639717239;
        Wed, 04 Mar 2026 07:55:17 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cbd405fsm18730740fac.0.2026.03.04.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:55:16 -0800 (PST)
Date: Wed, 4 Mar 2026 09:55:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/17] odb: split `struct odb_source` into separate header
Message-ID: <aahToju3J2qj6lR3@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-1-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-1-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> Subsequent commits will expand the `struct odb_source` to become a
> generic interface for accessing an object database source. As part of
> these refactorings we'll add a set of function pointers that will
> significantly expand the structure overall.
> 
> Prepare for this by splitting out the `struct odb_source` into a
> separate header. This keeps the high-level object database interface
> detached from the low-level object database sources.

This certainly seems sensible to me. I've been thinking about also
splitting out ODB transactions into a separate header. I may do
something similar in the future.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb.h b/odb.h
> index 68b8ec2289..e13b5b7c44 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -3,6 +3,7 @@
>  
>  #include "hashmap.h"
>  #include "object.h"
> +#include "odb/source.h"

Out of curiousity, since we include the header here, it is transitively
included wherever we are using `struct odb_source`. Ideally should we be
explicit or would it be best to just rely on this transitively?

The rest of this patch looks good.

-Justin
