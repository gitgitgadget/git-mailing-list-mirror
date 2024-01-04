Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66C22EEE
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Zwes+C9u"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2041c292da8so267940fac.3
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704380007; x=1704984807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpj14VsBEto8/DzqFs/oDSgRd0+nbvGG8wTGwR9EGgk=;
        b=Zwes+C9uXnHU/HkkEbf6mYBKE3CspkV5XU71l8DenkizzgkDBk29SVdPlEHrxsNsKl
         nTD+qjiAxT744j8N6Hgdknu+dXY1K7S/S5FuTrGSIiyTkpFOc1LuvXWEqDYKWxWhLMYv
         8JzRkX4Nr5YD5a2UfwHhSA5+2jl5GpLft7lmJbEwnvva2o2at0wpsP9kOP15hezWlujs
         GQRhddH8jKehbkyOOmCQUpnSnLpiTE22WK+tlAMHGvHt+5ISOUVUr+cz7I4qmGxhszt/
         XbrzvcLLFxVLbB7oB/LAtse00AS3qrO52f5hIwbLGevcWO5WMtFW9lehjtfPQ0kS5yUh
         QgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380007; x=1704984807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jpj14VsBEto8/DzqFs/oDSgRd0+nbvGG8wTGwR9EGgk=;
        b=TAiO0DBsrXQrnLSB1xZieSXRiQFKG6iriVrFy82B94MP9Vk2EZfKAUnec7mav6TQY2
         I1+elBFXY8iGOuLWG+Ho4rzZ+EDt4vnzvvY1d2Uyp7bO/ksHnD3nxyL1C93Z+Wa28ZGD
         U4zd8k/l8LyKgwYC44iYElRAcrYdBdJLE8d8DsdzSsBIL+PdH0OzV/VFF15uEtXjZ9i0
         k6eLbSYmzP1I3aNaR0N+FUSkYdb8yZhBKIe9CLUz4Rqx8+nbDZ21WH9vWdPkFyFRYOKp
         Rr15jgfLnrMfF73juWANhnXZubTSKWe+/We9cQ15h974yEwkt3q4rJEpQXQ1/rIeWZTo
         2k7A==
X-Gm-Message-State: AOJu0Yw4O6rJOwirE7p2g8KbHfyCbylzr43dODqmWXQa35XuLafQETe7
	18RH1rd/CediLfKZcWy9BCWCiSJfM7wwbQ==
X-Google-Smtp-Source: AGHT+IEoIeNzaWDUFDUVRhcEr0BEYqEIvKQq3aXhe3jPY73eKHGzMdKC5Taa9Fy1O0MB0mY0Dmm4kw==
X-Received: by 2002:a05:6870:44c6:b0:204:2ea8:3f41 with SMTP id t6-20020a05687044c600b002042ea83f41mr668482oai.52.1704380006787;
        Thu, 04 Jan 2024 06:53:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bl8-20020a05620a1a8800b0078305ec597esm41588qkb.71.2024.01.04.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:53:26 -0800 (PST)
Date: Thu, 4 Jan 2024 09:53:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Chen Xuewei via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chen Xuewei <316403398@qq.com>
Subject: Re: [PATCH] fix: platform accordance while calculating murmur3
Message-ID: <ZZbGZYhhWpHh2pS/@nand.local>
References: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com>

Hi Chen,

On Thu, Jan 04, 2024 at 01:56:46PM +0000, Chen Xuewei via GitGitGadget wrote:
> From: Chen Xuewei <316403398@qq.com>
>
> It is known that whether the highest bit is extended when char cast to
> uint32, depends on CPU architecture, which will lead different hash
> value. This is a fix to accord all architecture behaviour.

Thanks for your patch. A similar fix is being pursued in [1], part of
which includes [2], which I believe is functionally equivalent to your
patch here.

>     Others
>     ======
>
>     after fixed the bug, the historical bloom_filter data stored in
>     commit-graph need to be updated. because the path's hash value is
>     already calculated through a bad way. so we need to update it. this need
>     to be done in repository

We would not want to impose that burden on all users upon upgrading to
the latest Git version. In [1] we are perusing an approach where:

  - The Bloom data is stored with a version identifier, meaning that we
    can still use the existing/non-murmur3 Bloom filters after
    upgrading.

  - When the user decides to upgrade from v1 -> v2 Bloom filters, we
    reuse the existing Bloom filter data when possible, namely when all
    paths within a tree have no non-ASCII characters.

If you have thoughts on the approach in [1], they would be most welcome.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1697653929.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/f6ab427ead86bc82284b2c721f3c177947ece3c9.1697653929.git.me@ttaylorr.com/
