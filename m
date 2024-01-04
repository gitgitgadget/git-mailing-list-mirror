Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209062E838
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="n4eM92sx"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204e1203a22so362823fac.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704396829; x=1705001629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1tyz0iXUyaasTww+LnSjIaATGPxkuqxSeNFg0+6d8w=;
        b=n4eM92sxs4N0a2RSmUn7vxv6ZwexkgUEEhDV860eDQ5wPz903rFANTdv7FFOg4K4mw
         /XEYQmP2ABholznnJ9UNolPwqMIiKiloYRQSMxEFaMCNprDl1lDi73Tro+Dq6hYusuk6
         hpXZR9JMRGzq2OZj/ipWbJxwQSwJAqIgzcc2oEfm1udr4y6QSVvM0mwzuicaVqjp/7cz
         APosw+qVgQEeIHFzUL95D4+W4k18v2gL1y7QEb8HecezZn+aLkiqs/pEziPrGER9BzT1
         2OZZGOSHfjqFw98p4th00oQq9Ovs7E5yq7j/rnwsdaZx+ZULy6fl3NqG5rO/lmA6O4n6
         WVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396829; x=1705001629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1tyz0iXUyaasTww+LnSjIaATGPxkuqxSeNFg0+6d8w=;
        b=Ty2qGhuONOHjdXmsNAtkjoAmmSvlnFhLH39m01HIQNbW2Cy9bDTaNQsMzX6mYC5emO
         mRVOVG+X5Axc4wn+6ithHjCO8MksrvzkzGYOKl3Re9v+z9u4ydv3cp4V9zv+o1tFIbsX
         gajwX/84zQk+FUw8+ilJVawHblIY48iqmoo3FzLR6gY43SnpeRmvNyZ/ZO/rEGHHVR6M
         022bj3HKOA69QpqRCjZObz0usvjqW5XXVtuMH+Bbrkvm6pBpCfA2Y5PLbGZOgavojmWX
         DuHrkvghwEAfuhgtWqMbJuxb6Z+pcg5a3pzbLqcLIJFjggNE+APFQFpdGLGVEH/zWQSj
         LiHQ==
X-Gm-Message-State: AOJu0YxJ5n8WKvMltIdlM6/1BkSO317g/C/QWN+f2UI/LEOywGZ0RZoc
	jNnakNEw/++m6Z7LIV7Bv+4QMabsdUcD3w==
X-Google-Smtp-Source: AGHT+IEVVbr9ThmMKK7PaL538XycN6rh8KSv41uD/AGpnkXSPsHosHKba/swvGh+uECclAJnsxm87A==
X-Received: by 2002:a05:6870:164b:b0:205:cd32:dfd1 with SMTP id c11-20020a056870164b00b00205cd32dfd1mr720569oae.36.1704396829149;
        Thu, 04 Jan 2024 11:33:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pj27-20020a05620a1d9b00b00781b73f77b1sm30695qkn.128.2024.01.04.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:33:48 -0800 (PST)
Date: Thu, 4 Jan 2024 14:33:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: Does extending `--empty` to git-cherry-pick make sense?
Message-ID: <ZZcIG+mNXhZ0rHw3@nand.local>
References: <CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com>

[+cc Elijah]

On Thu, Jan 04, 2024 at 12:57:18AM -0600, Brian Lyles wrote:
> Is there any real barrier to exposing that option to git-cherry-pick as
> well? Was this an oversight, or intentionally left out? The
> corresponding commit message doesn't seem to indicate any specific
> reason for limiting it to git-rebase.

I am not nearly as familiar with this code as Elijah is, but this
certainly appears possible by setting the `drop_redundant_commits` and
`keep_redundant_commits` flags in the replay_opts struct.

I don't see any fundamental reason why cherry-pick shouldn't have the
same functionality.

Thanks,
Taylor
