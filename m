Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB3450FE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543393; cv=none; b=KwoOqJzc9UtUIfnAxu5SemX269N3ITuA+rqDJUyvsHp+IDaFiRCrU12K6GIdevDM58MSMQ4BIJ9Q3g/L66ilE41QKIycnx0d6hNZAWKqdvb2tX+tueDvuVbrUZMsj8nD1771WWmfBoSgT3UOGb82EvwpkMOgbNDVBABu0YogC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543393; c=relaxed/simple;
	bh=eemvw8S65HO4DtRR1CTSrWxPwGwoiaKKQvdh2qthdFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz+Nr/960Gza9/b8e5pJr8TVEXMyvke+kLmTEZHzoCuz7qTZk4HQWNkXp+zVqTSRpQsWbUarBXI3TPVBtiQRICQWXbehgYOxoCl4Fdb2nCvK4c9ZJO/G7km83n9chGmwpxFzgScJhS0N88zXTv1zLTHpfDZg+0Gv3BCrfIeExGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=p5OaOL4J; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="p5OaOL4J"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e3c3da5bcdso50649927b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543390; x=1730148190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmKlte9h2RrrZlG08XxPyj/LmS5GlxrHvRj+xydpZLQ=;
        b=p5OaOL4JsURaXZ8rnkMax/2q39q/DuxkHmdoUNAJpqW+58GAyrJxDhJvsNMFxlOivT
         h9UaX9F1Oq0C79+i4IAJygDsTZ9AmZXlQb2JN/ecDecglS5VA4CsB3aI0dVJeFiKGLkm
         XrSMn0V94R4L59gN5L1EqYtFdZt2Ld8i+AelOmh7LQ322vqjEFJozcbGBYMFNO/8n0S4
         xMeIduu+ij5HGL+3IG9REjJcWQaZXtzA64JAoEZxGA6zHd/a3Og3nCFjgmPYXFbyJG3/
         1q5Qt89Zb0dnN4Dyi7EEn7n/q399N4Qfo+ECbKH9XlIawOsNdHdBtftEdzjafxuBXQkB
         L65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543390; x=1730148190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmKlte9h2RrrZlG08XxPyj/LmS5GlxrHvRj+xydpZLQ=;
        b=AKRyPAnZdAr6tIJdf2BHsUA2N/UHnd/K1fw3HP32uOJ36ckv1XnrOC/GW5tpJZ9qmc
         RXVrx1Vbns9EiIrhReJDGUpX/CVIHE3oEM3dOw95tEnySsWcXGRcA7/vfsEGaHbnfn2/
         P+zLsEqqX9gtxgb3H+pZwsD7erRtzutXaZ5yoBQ0V4FX0mY2hqU4aRUZvlZ755U7SlxR
         klSP3s4ix94O9NSvYW+elim/xml/2geoOPirdj0MMD6J3bcX99LC1DKx7NTRh8ZaVI5q
         0NVS/VGvxaUgjAmoGCTtJjwrN2GW5fVLQ1EZwFjXKVKjRDNsTVuSPn6REl1PAKa56iyP
         A4tg==
X-Gm-Message-State: AOJu0YzMxSXhe3UC4ZVl4WXxNB/muk7FV3fQmmJZL583Bu0YaZMDi/nJ
	hBCFLZKiV68NkxBOo8VikChP3kppxSTqXnBvXtRX66KJHH7mIvx87ij0UEjeF6w=
X-Google-Smtp-Source: AGHT+IH8ohg65A86sINu5dyJQWYPk1Pk44/iSvJOQbQalDlQqxDrSpcqPjYB+FqLTCObokqcrsa7Fw==
X-Received: by 2002:a05:690c:dd2:b0:6e5:e163:e001 with SMTP id 00721157ae682-6e7d3a91a02mr12640757b3.8.1729543390467;
        Mon, 21 Oct 2024 13:43:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acfbdbsm8070327b3.61.2024.10.21.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:43:09 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:43:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?RsWRdsOhcm9zaSBWw616bcWxdmVrIFpydC4=?= <noreply@vizmuvek.hu>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Message-ID: <Zxa83K3M7vUY7k4m@nand.local>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021134354.705636-1-bence@ferdinandy.com>

On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
> Sorry for sending a v10 so soon after v9 without really waiting for feedback,
> but as I started digging into
> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ I
> realized that the root cause is in fetch and not remote add, so the solution
> belongs to this series. I'll leave my overall comments for v9 in here for
> clarity.
>
> v10: added a new patch (8/8) on top of v9 to handle HEAD in mirrored bare
> repositories, rest of the patches are unchanged

Thanks. For other readers, this is a continuation of the v9 from this
thread:

    https://lore.kernel.org/git/20241019225330.4001477-1-bence@ferdinandy.com/

Thanks,
Taylor
