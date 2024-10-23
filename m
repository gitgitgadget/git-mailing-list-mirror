Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4041C9B75
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697769; cv=none; b=GdIGSvUk4+DQtSUxrZHbBP/Tfz5TRbdkKity1bnPb+PahOsEX7QCb3k175/WPijp36PrQomkbUMlHWTjJzjBZTbQDXZV9gEnAxeBjK7tBNd32tQKqmefHCmhSWLcxOUkOrn9z/A/Trm+hNPjPHk8276ShrbmA0G+JcoaW8ggNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697769; c=relaxed/simple;
	bh=+Pi4vvFv+cECHykrgJfRYFiWY+G399I2TJaAH/vflsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYNqb1IvqUfH+El/Zh+uW81YQguL6VTvJaMIL7uxuomy/kaVJFjvEQmvQ9SmnWaunpUd7DX0oEfQqaIgVQCBMukiw7Hu63VpDRXFIZmCrppgf+LdKuPh0OJD6ZBQA6EizhiyhmWws77YddDIKFN8JeA1R0ahvGodyvNGBGlVNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KdYs8dGK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KdYs8dGK"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e41bd08bso81012007b3.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729697767; x=1730302567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pi4vvFv+cECHykrgJfRYFiWY+G399I2TJaAH/vflsc=;
        b=KdYs8dGKdmyGh2ceTksYR6x0sw8bnV8LIV09G3cZ5n34ffRLxylspzaBpNVFZR9FP6
         cvSmcBgFQG1cdrBy2Q0Qb47Bccm8E2CnZBFTVpqqg0hI9UQL8ZohcYp4jex2MEdsp7/b
         Kk0dWc6Gjclot+ofERS+SW1mpEmqxtWh/XychWEwz55TyU/R0BoT2/c/zBbY0UbcmvTM
         9MxVVOtmhwlFkWW6Dg5tanuti4345QFNOOqsn6PJqGAZ92kl30NKrEWx4M59gmVVVRrS
         Hqb4xc6ViNBIpxm+KpH5jyoP2F4qIJDk9TNXR7oX/Fh/qv+ZF+Z1J/cDpZiO23m2FV7z
         hxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697767; x=1730302567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Pi4vvFv+cECHykrgJfRYFiWY+G399I2TJaAH/vflsc=;
        b=Ni5Q7dUwbkRtb5hW2WkSvLQpxN17ntq73dUbFGaGTORRo6649+iiSvf6wrnpRbQX7q
         YzHPXMP3tuw/9zeeYyE10pN8+kU7taIL7vtWleMU6hz4UCdirYO6UeN461aXsdd3JvLi
         pWGTRC+tDfO6oprTHHms1pZELnxnIjuQS6Pvncj70980oMeEpTc7pGOLf8AbzQ5c+V+v
         fAdlgP6W4sAikYvt2Gl566A/UsT9dGame/AGXlKaUO9UHjurgNXtzhWNnv8eNyv6s88j
         rn5MbkZKqvw1K36v6FlOdgzhw95sQAXIyWMNAAt4LtQV9MtXBi5lfzhfOMT0VhU9BgAL
         Z9VQ==
X-Gm-Message-State: AOJu0YwFPWvDT9BDnnzdJy0MrPmNW9LRvnOCriN2mjX6PYCq9YjUeDsr
	FBzKTCTAS9ZDoUpn5W43gwxQp7aEJAB6adDhYE/JktnuNcPYou2VSPbQtrsxbpM=
X-Google-Smtp-Source: AGHT+IF8B5d+5BnnTYEh8Il/Wdy1dAvpJOEhT/muBNfyfo848GoJFIpvOu7SbICSEBd/c7j1ThSWqQ==
X-Received: by 2002:a05:690c:890a:b0:6b1:735c:a2fc with SMTP id 00721157ae682-6e7f0e57c0bmr22429227b3.27.1729697767154;
        Wed, 23 Oct 2024 08:36:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5adab54sm15584897b3.60.2024.10.23.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:36:06 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:36:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] compat/mingw: implement POSIX-style atomic renames
Message-ID: <ZxkX5XgghHp74NAT@nand.local>
References: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729695349.git.ps@pks.im>

On Wed, Oct 23, 2024 at 05:04:55PM +0200, Patrick Steinhardt wrote:
> With these changes t0610 now passes on my Windows 10 machine, but this
> may also have a positive impact on other parts of Git where we might
> have previously failed.

Ooo. Thank you both for collaborating and working on this.

Thanks,
Taylor
