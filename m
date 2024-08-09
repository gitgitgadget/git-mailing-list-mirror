Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF862171
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237082; cv=none; b=CcPLt8+Pyz4PYvJMx3tK940+Z1ajOFjiOcS5jn21vL3t6aAyPoE5j8wnRQJaY/O+ntJgYOYgkZM0PuFPmKwHsecS2PtAhfRedmtb/w9/VkLzu2muDguqW6Cp+s3SZJpyhKylY1fNY70diS6iK8pzgjHuX5Ttp8+uayPCN/YyyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237082; c=relaxed/simple;
	bh=kuXAxokkaB9zN87bVNq3qSzDT9hrDBLHuNk9VrPHQII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRZxf2LyusUdgo+roF0CErGBu4ivb9D05Fbt87i4xYKiST2l+8ST61b8zPJx2qU3ziU32l8vwLkv+KUdf2xwmTpztT6JI2cAGPC8hwwGwuOWeKCBsTt4IbaOfZtvWVtmO+CXiPwupZNMq3M6ZUOEW9sKkBixAqlJfpmtHGj8w+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAxnGtY8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAxnGtY8"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so1519422eaf.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723237080; x=1723841880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuXAxokkaB9zN87bVNq3qSzDT9hrDBLHuNk9VrPHQII=;
        b=mAxnGtY8F2nwiwrwHlWkfJYLBnlQ/GAF7NvRcUo8ApGg1jIJ96nuizFiHCGVxNUmVw
         L3gVrHAPs9ORwY4iGtgYihad1C01J9RLCec/cdB6BxoqqSAIFW9mm1IziCms0ykIPER2
         CkgdH4n3lWgde61HORbJa8fiFCMOR31+zsithsT1ujTTI0deBFE8ZppsqPkimup59Vi6
         FJTTsfrmeCvjioD9mW3wzl1LFmOAZn3nk+EwnVRJzl1SRnx6HXKTaPhJ42x/g4Rgjqfy
         /8TwgR/3L/P5yEpR1Wftn4ON3RK65cn/lSsjwgD7t5ZkRrbhMc42Hd8VNluQinSeRV2N
         9t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723237080; x=1723841880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuXAxokkaB9zN87bVNq3qSzDT9hrDBLHuNk9VrPHQII=;
        b=X2wiRsUl95lV9DGyZBeeq+tvZgp4Vo/sut6jHtwjwxJy60+6ZehnOjWJF1aQfWaiEo
         GGUpOUv9kEURbfnvXnwR6izgLt0PK7cae5LEWwuKDWjpRbwjhJV/w8Nd66vaEDjTI3MQ
         0wFOKNLvWsjsM6zKHpoXX4YoymaAc4TEIhLSQ/k+EeC1WveNTIU5qSYXWPq4UQyonwd9
         h+VcCTrQOAoql+Ie6CkJQIP0+kBgKiog+ByGPhW6lzpDmCdoZs/wzO/cA99VJoR3aLnI
         qT5PEGDIz8Oy54XEmK8P1juD2TmRsnwyOWY31MxrIdSqjJ5aOtnD3QRp+EzJhepcKIIL
         WKFQ==
X-Gm-Message-State: AOJu0Yz8BDADlVvHekE9eXCjlh3XPzsTpxzJMh9LCkXp7XPdoAjw41AH
	rdsn+j7nvJH53vAgr1UMWHLfp5XM6ZlqxXxLdb6CAItaXSkL3ytcHW71dw==
X-Google-Smtp-Source: AGHT+IHDEPMnSisv2rMMx9OGiUci3DQ/Pqyi3tjgQLLnyzP2Kq1UN8nNgKzJZG0e8vt9c9bbsuh4FA==
X-Received: by 2002:a05:6870:8290:b0:25e:eab:6d32 with SMTP id 586e51a60fabf-26c62c427ecmr3470270fac.5.1723237080272;
        Fri, 09 Aug 2024 13:58:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b80da85sm146087a34.2.2024.08.09.13.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:58:00 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:57:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/20] global: prepare for hiding away repo-less config
 functions
Message-ID: <j6litzbor4sz7pycfh7wf5fmejidf5s75sbw3xgrpuwnroyvh6@kkydoqh47bjm>
References: <cover.1723013714.git.ps@pks.im>
 <f7617beaa5aad64fe98ac52015eb68786114728b.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7617beaa5aad64fe98ac52015eb68786114728b.1723013714.git.ps@pks.im>

On 24/08/07 08:58AM, Patrick Steinhardt wrote:
> We're about to hide config functions that implicitly depend on
> `the_repository` behind the `USE_THE_REPOSITORY_VARIABLE` macro. This
> will uncover a bunch of dependents that transitively relied on the
> global variable, but didn'd define the macro yet.

s/didn'd/didn't/

> Adapt them such that we define the macro to prepare for this change.

Once config functions that rely implicitly on `the_repository` are
guarded by `USE_THE_REPOSITORY_VARIABLE`, the macro will be required to
use them. Now that the dependency is exposed they must be marked
accordingly. Makes sense to me.
