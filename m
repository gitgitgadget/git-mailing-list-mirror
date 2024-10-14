Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760221CFEC7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940780; cv=none; b=VHmIKe/hEyyUL+8Y4oz/pMG/5Hq/OJh1bppzZRWdww1SXMEERsvMl29LBddmbCwlMkf4WlPz8ctcDaYebdHBI4pDC3QqdHAgbS9+IRGUkZBGFeY7WB2joLD/6c9mQ9eTKf4mSXl5i5O8oW2/cwMfGyVaHu7hCmREcOE6HRUHOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940780; c=relaxed/simple;
	bh=k1fJPlp0wQxkBOseWsaUCpRbJCcWaEOi3hdRVT27rJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev+2N7seDWBTJ5xIiQkUChPg+D/VLjB/I6zgsLBp6BLY+Ayt7JjMMyBCYpuDQgpMj6Lx3uGpdZ8+5UGiEDPYduZ12nBLjH+jPlQEpME1DGjQGa4aWKKIMtte8wPrkcK7Rw9a/ZBQFkgUO4XL0xRMJUr+q4TeSEN/0gUNtBNB7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VbsPc0OW; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VbsPc0OW"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2884a6b897cso2468951fac.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728940777; x=1729545577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V04KwS8ADsDUWtJAWicJlIa5YqTYi1/PRN12wUrqjcg=;
        b=VbsPc0OW/swuxGACcTXyshzmk/jc8gxdMtRyzGaClR81je00uzkotWnjxoYHft8lys
         HI0hpDxI6Ea2f5Id2L9GzlArtXsFy8koFxfPC4keU/CQkbQFlLx33ckUOICB2Dioksxr
         PECbVhHOQSWc4Ou7ewPiUDEChT1EOfan51a0+UELbGroT2KH2NZoT6OgB+S9siKAXWIE
         FEV0JjUaKgsWsHNAcFWIRJGNh/GBGZ9zdTcqQHiBeymMSAtjwRweh1q4zjO7983Y4J7R
         OipyWys15MNiUkhjqU+IMl0k4WhvgpnXC+Qu7iWZzJOPWXHsHq9dcEupLIxmO5/jCgiB
         M7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940777; x=1729545577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V04KwS8ADsDUWtJAWicJlIa5YqTYi1/PRN12wUrqjcg=;
        b=loG1eQHPXNgdIj0T5ZQAznmo07keRrmNfgCn80A3AEa24ls7ByOzPPiT++iBkYMOsk
         nD7IL3U8CSko3TgmXL4FELfIBWpiv8zziAP/0Hx1pXHI+TRdzLXWdsBmTaLVPnjL8gmr
         9Cg/iUS7t5JS1yRDDPGEF7DMGN90pbBDDpd2XZwnwU7tdcX1lWbC4KcpqITtP/OiPqnb
         RyH9zKjaTelgpTBFl+xJn7BNSO27HcFNkR0qyiqL0ngvfwGnYQlkg9/aknBLHEZv2QAi
         0EtWcrU7IC753+wEf2srCx5bnUSOckyBLjecw9495+0pMwVBk5qFk3JGP3lf1joF/uXb
         8uKg==
X-Gm-Message-State: AOJu0Yxhs7hLiBarFXBBGtJppLagptId9GS4DxWNvFYGnKkMf5whFVHj
	isV56YTzo14GdjbZZNngx+XjdCMfKu+C0ABy4948zw9vp4oCwu4suid9QibHRHYJTaXRkrBvA28
	5
X-Google-Smtp-Source: AGHT+IGHzcH/rHHWp3dehZyxXjjKnJuk3GWm4WpjMqE7ZP6UVLATG0U/yP6azKFN7d4v43u8dm+heQ==
X-Received: by 2002:a05:6870:40c7:b0:287:a973:2c66 with SMTP id 586e51a60fabf-2886de63846mr7317039fac.28.1728940777484;
        Mon, 14 Oct 2024 14:19:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-288583e10ebsm2964188fac.53.2024.10.14.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:19:37 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:19:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: David Moberg <kaddkaka@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
Message-ID: <Zw2K5xJAOGWitfXr@nand.local>
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>

On Mon, Oct 14, 2024 at 10:46:45PM +0200, David Moberg wrote:
> What did you expect to happen? (Expected behavior)
>
> 1. This command should return the worktree toplevel, not a subdirectory
>   $ git rev-parse --show-toplevel
>   /tmp/tmp.DUUAVQCIKe/repo2
>
> 2. And the git grep command should return the match from dir/Makefile,
> not Fatal Error
>   $ git grep banana
>   Makefile:       git grep "banana" -- "$$BANANA"

I am not sure if this is expected behavior or not, but it feels
unintentional to me. Perhaps I am missing something funky in your
example that is causing it to behave this way.

Does this bisect to anything interesting, or has it always behaved this
way?

Thanks,
Taylor
