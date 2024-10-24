Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD51EABDB
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785755; cv=none; b=P26hdrm+xX3q78h8fdLlsRI0acPnvODLx36VJfTcpJLyn/lWxrLac7KRbNKR05620Q2m5HenBxNQyv1l/ZoNN/2oVORCK7biWFOIMdBlsH5yFkKNTu2aqluu/nav8wzgjPE+hQuCfGeLKvVsyYe7oOmQF6K8J5eiu9L2OSeV9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785755; c=relaxed/simple;
	bh=AiYqzVrYmRc61EhqqINyjbM+FIXmu6kQxMGfDDbfXNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUFxIkn7wRKdoCwAaB2ZFDwBOqlvSnY9Z+3e8vnS1cIhLD5jvgHUxjjGqkyWgWebmECq6nTE7hKqWCf5cTj+/IdejtC8z+CLtqg7OI3Cxclrtm4ZbST9tVMBHZGIZSLcMQo+lhDHX0KKA0kBqwh7X0aAYOM8iu9JqJjuvuuKJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ap5E/PEk; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ap5E/PEk"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-28896d9d9deso562869fac.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729785752; x=1730390552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc3Jscedjfv7niavBTN6WLVe2y7mCQjxOoAjVRqXhME=;
        b=Ap5E/PEk9uy7iGCtlxFCyML19vEr/r0uCy+mx3oJoXSh6+CCHQ3kU5tz5GHwDbRU0d
         y7nIAegsULuSMktSMtQY+SXQ/IxyjBqkN69zzzzThgHW9bOXG8TIsQCLiACUs/a6NToY
         hLm2mPfIdaACesRgn15ukaFXPsgEcY1FssVcdX1v4AxAmZyecP/WZbeeaB88wKubMmQB
         xu4J39GzR8qEdA0Woaqc2rsKrPLUlHY0kqd3iQ2QEszqOawXNHX76xuPvvj4bPJmwO0I
         0Vv8kI6UuKMmmSwFePhvojdFcQDasLZzwfTmRnBwq0GEihicN2SRdPt+XHhS2g1wHK5+
         1eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729785752; x=1730390552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc3Jscedjfv7niavBTN6WLVe2y7mCQjxOoAjVRqXhME=;
        b=u8UKFpAqyOz6ORGI8mfb2G2+pJmO7wy9pNIvbbM/hGct5i6462bYROBuQpvV1esbGM
         gRhavtYu/zbrl7DBq2VTGu1Y3M6p1KPtHZayO8FfkBj7H329+efeG/HLTUi6KiEskiW/
         Gt1jsURa4k6bsC7H+sHiHLzJXASAPFF8anU1KrFlHYfvNfY6TzUZYK5Cicz74mTAu4Rv
         +0qzVxnQUFkkmCtzwpLOz8fej5LYL+fFZTche7yUzmpvVQHnl/MscmlsamsmQCrPGSKh
         J0FT4zM8QsNTakyRwzAgvdbd7NYz6biG2SiprL3eufTdgfLTahuayvglqx8AXHaCwqe3
         SioQ==
X-Gm-Message-State: AOJu0Yx9jly6FAavkATRrppQLAK55W7fJI3axjtF7p2M6rFKeySphAPx
	IQCSKKscpVyysDyTFgf+7I6on2iZUlOeAY63T3TmWqP58QRfALVjuAZIA2r9Qzg=
X-Google-Smtp-Source: AGHT+IEgx280fy1AdXtnai3dvpc5W7h2isStwmY0YqHmoPU6JdFQhswNQoiTlyC0qkIF7F1ByYdOhQ==
X-Received: by 2002:a05:6870:b69a:b0:277:f2a6:8f94 with SMTP id 586e51a60fabf-28ccb6b1093mr6477408fac.33.1729785751762;
        Thu, 24 Oct 2024 09:02:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d13190sm20277177b3.117.2024.10.24.09.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:02:31 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:02:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZxpvlvafLlmXbgpA@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

On Thu, Oct 24, 2024 at 02:39:43PM +0200, Patrick Steinhardt wrote:
>   - The last patch is a compatibility patch for "seen". There are a
>     couple of topics that interact with this series, and I didn't want
>     to make all of them a strict dependency. So I've decided to just
>     create a fixup-style commit that does the necessary changes in order
>     to work with "seen". Like this, you can test without "seen" by
>     simply dropping that last commit, and you can test with "seen" by
>     merging it into this topic.
>
>     @Taylor: I didn't really have a better idea than this. There are
>     six additional topics that this branch interacts with, and building
>     the branch with eight dependencies in total didn't feel sensible.
>     Ideally, the topic branch itself shouldn't have the last commit, but
>     once it gets merged into 'seen' we should have it. Let me know in
>     case you have a better idea though.
>
> This topic is built on top of fd3785337b (The third batch, 2024-10-22)
> with the following two branches merged into it:
>
>   - ps/upgrade-clar at 30bf9f0aaa (cmake: set up proper dependencies for
>     generated clar headers, 2024-10-21). This is currently in 'seen'.
>
>   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
>     FreeBSD, 2024-10-16). This has been merged to 'next'.

Thanks for all of the helpful information. I changed the base up to
"The third batch" and merged in the two branches you mentioned.
Everything builds fine at the tip and passes 'make test'.

> I was pondering a bit whether I should split this topic up even further.
> I've already evicted other parts out of it such that they can land
> separately, and landing the Makefile refactorings independently would
> reduce the overall review load. These steps also make sense even if we
> don't have Meson, as those are all either simplifications, improvements
> for CMake or a necessary step towards out-of-tree builds. Let me know
> your thoughts!

I think erring on the side of smaller series makes them easier to
review, as Stolee and I were talking about in another thread. But if you
feel like this topic is receiving sufficient review as-is, then I
wouldn't bother changing it.

Thanks,
Taylor
