Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6C14C5B0
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750901704; cv=none; b=DSaQ8hYKgxshJnEzuH7mPHo6YC9YpZ7ysspqNhekG8e2anttp63MxStgJ7qiIHUlpzTI2ihfn3rh+K3D6d+UDjX8aeexvOqmsqX5jo1Io615QNuA1yNv1jj88rhuNs3z8urd0ogc8WaVLdywbpn9dkGnUCsZsOg96c+oz6Y1LuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750901704; c=relaxed/simple;
	bh=21+sb/NRrXip+8KuZ3a8mUDLWYr3T6sdHyCdiNsXCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwtzUYXtBmwPaxdqDsKzySjcgfas1NOhnEWO2g8vMGN7AfKLqo89kFPj4X+0QErE9U7C7EPkZbq9+TwiodMWRUv2ptnk15+qz9V2dPF9EPkg53MccSdJ9G8a7p/4aE9h+a8mMf4VXtLNIT8XxHCnrs8wicHrC3xmGy4JSVwpRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emV9l4aF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emV9l4aF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso587828b3a.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750901702; x=1751506502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T498cxyjH5q+J5NkNbxFx3CyPRL6jUGu9MZokx/KqD4=;
        b=emV9l4aFAwdwXdiA4M8vplflZFQ3uT7wbfwhekWXz/wzE26F2xdZ6lgAd1Zp95zTGQ
         08PiOxTqRH0VtwNFNt1XOPpI0pDjyHgBbrjewxqSYpybqnwUCiYpFKQAbuj6elp/oBuC
         AoY1vhK2sBv7d1kn5pgep37Qb/n3Al5HiX9Q/ip1DRe/iqRoOjZwSdzg2PtZkghZMqfG
         vK0dDC07PMKl+vPN1MDoEf9BNbwsA5fUkWvtV8Qt+jjPiePTx/PBxHX93xGStdpQExeb
         BN5AktBNFry8Fi4w0YL1wZuzJ8feaWTz2OHJxvOW31cRq27GQJLKAb5ynzJ1YJCZlh3s
         Bfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750901702; x=1751506502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T498cxyjH5q+J5NkNbxFx3CyPRL6jUGu9MZokx/KqD4=;
        b=SB36FT82T4LkvEI7psZvjXEq2dWv9gjUahGm4JJ6+K5vpY4Z2vRGCS18QFFXQg7VZB
         l/6w9JCRWrOAKrVcraOnKmUStr3spKobIO9jxuCAd2CfAECPUR4d57Rbc440BJcH5GF0
         dMUeKDViMOyb40kooOKPylYFGFp+xTqbbaovC+Q5+eNhTFyOL7gHs7ER4QbI4/NaDmUW
         jNR7s8lO3/y7fP5HcoZnTfdPnLta6iubkD/RVHb145SFVqsCbPPoMOicWi4fhHph7ra4
         nHm7U2x7fX0QpFnKT/uSQwAChXChLEbWhQPTqa8HKbTrrdfFCmoDnmJVqPEPlDBkRZoN
         8k+g==
X-Forwarded-Encrypted: i=1; AJvYcCWem9EMlHgnrx5WznMcVPvsepTKsY+RmXeANSvGdo9FU7rWd1iTPufBX4dZ8/keKhDlELM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/cuGHjeMpjXsxhvqrW6X4kwp6S8k5O4L6EG9ki2IBXbAxPwS
	lWV3kCjxRY6v78Zdk7EwPiKcGEkSVt7FujpkVu8BMdqYhUbJdzovjP9t
X-Gm-Gg: ASbGncs8wVgPx/cZ48DF+5xR5IMCvXdZwrCF2fHj+wJ1BZw7uuRuR+F3H5rME0SifjN
	NoBhVyTH8hc9sXRY0uu6DfF5x0CfKzI1r1VwAls/b+KjBFooudwncYepzecjTR3dbT5r8c3yv14
	1GsP2gp/fk6ukYPGEQaoTaOVj6nZQvToUs+I9cUg9UTnnh+UVVJrlsRxVnegrZgY1yQCz0m6XlH
	3kGsX7jGRF6YvBiM0YF596767zGP32KfddbDyuBvIUxaf7HxoIPEXbSrOigk1FtG6OOMJRm39Mq
	1KqTJqAi5enVebAiBf21zMtOOsLDbl9Pl9QpBJv2XAhch242a6tAyWvcSfZ3S5ooQP8Mqc0stzE
	xf3uNl48mUB1MhNdog/PCqXiYYn6Rt8eOSA==
X-Google-Smtp-Source: AGHT+IHk+UKDioJDEu5yk0W8+1ynBUiCYmCJrhciGw8F7ktwN7RZZMdc6Te77YL2jA/O40+egRCP7A==
X-Received: by 2002:a05:6a00:1952:b0:736:3979:369e with SMTP id d2e1a72fcca58-74ad44902dfmr7348931b3a.9.1750901702429;
        Wed, 25 Jun 2025 18:35:02 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882ce03sm6001547b3a.97.2025.06.25.18.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 18:35:01 -0700 (PDT)
Date: Wed, 25 Jun 2025 18:35:00 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
Message-ID: <ilvhfzdfqcwkjt5h336ldrimnzpz7kwkkdst6egyohwxppo2gn@fpkulngdty23>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
 <xmqq4iw3yfd8.fsf@gitster.g>
 <4oh4eatsp4wo4ur6rluy6ickfy5jfpuarg435vplrqzvk3eaiz@jbtnnwqnz2yi>
 <xmqqzfdvqr3a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzfdvqr3a.fsf@gitster.g>

On Wed, Jun 25, 2025 at 05:33:29PM -0800, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > On Wed, Jun 25, 2025 at 09:07:15AM -0800, Junio C Hamano wrote:
> >> "Carlo Marcelo Arenas Belón via GitGitGadget"
> >> <gitgitgadget@gmail.com> writes:
> >> 
> >> > +# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
> >> > +# prefer using ANSI C signal() over POSIX sigaction()
> >> > +
> >> > +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
> >> > +	AC_COMPILE_IFELSE(
> >> > +		[AC_LANG_PROGRAM([#include <signal.h>], [[
> >> > +		#ifdef SA_RESTART
> >> > +		#endif
> >> > +		siginterrupt(SIGCHLD, 1)
> >> 
> >> This is curious.  What is this #ifdef/#endif doing that does not
> >> have anything in it?
> >
> > It checks that `SA_RESTART` is defined in `signal.h`, which should
> > fail at least in QNX, NonStop and Windows.
> 
> The above roughly expands to
> 
>         #include <signal.h>
>         int main(void)
>         {
>                 #ifdef SA_RESTART
>                 #endif
>                 siginterrupt(SIGCHLD, 1);
>                 return 0;
>         }
> 
> Are you saying that a preprocessor macro SA_RESTART, which may or
> may not be defined, when asked by "#ifdef", causes what is left in
> the preprocessed source change in any meaningful way to cause the
> compilation to fail?

Lack of judgement on my part; I apologize and will correct it.

Carlo
