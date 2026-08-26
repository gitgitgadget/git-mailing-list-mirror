Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514D4457B7
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755146; cv=none; b=iM/meYcY/Zybh0AkJzfo8mXuOxPbbam10ybKKZXN8AO07SIyPogIG5wT4x7Uy1eD6fCvK6r0J6uijvlWSDJY7EBk4d3PCWtkV/nKlhUxgHyKjFn9rQR3Ylrwio1LAJ+jdnesS07MOm0xIO1TYrviF/fuznVA8c1v4h1cQDfvwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755146; c=relaxed/simple;
	bh=U5lDdlFa9nTfRMJOoz8T4ZnIir/E+ZundSVK04LeubU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XNy7asZrSy6ai0DM+z6UVkuThFoyN3d0Nx8hSEGNSLkSKObNyV1SgsLGGdgmLbX13n6Gz9pxR6JbRBcppjv9Ny8uHB9FyyydnCXE7wCQA9U7GtOa5yfqMw1jRV7F+CXPQfFwp3Nsgy6eRjw2j/Cy9JWtAVcMNDtt/EUTZif915Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fpUfpA1U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMmgUW3W; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fpUfpA1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMmgUW3W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84C1D7A010F;
	Wed, 26 Aug 2026 10:39:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 10:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787755144; x=1787841544; bh=U5lDdlFa9n
	TfRMJOoz8T4ZnIir/E+ZundSVK04LeubU=; b=fpUfpA1UTs3qs41Uer5FR7eLTZ
	ePOaoqniP9wR3swqy46XqcRsmJS8axtWYayPyNXYY6RQNwjLb56S4D2BUhY4pPVz
	0UVlMoQJF49SXy0BGRWSmVEQuXJU/JoUzQLVmkGSPMAcz+iy50etqsD2zWhY5Ade
	fF5U8ccbUfm6PlIOQAD4TKCu8ntmhNlw6215mi067ypbPsEF2JtgEapQlOm9p8Kc
	NBwuY18BAcIRKo4wvnPjl+3+8yFNfd75z5WvzyzM9MypNaoXTuR48WS+FuKsKYbv
	TpefJhdO11NoDNbk91D5OVWKaiBNyLAd1J//CLZo7UoPQwBdaaOE2+RqXkuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787755144; x=1787841544; bh=U5lDdlFa9nTfRMJOoz8T4ZnIir/E+ZundSV
	K04LeubU=; b=IMmgUW3WoAjiTbvhcoN15+dYbVQ0LrPXwnL9xwrn0G5WYaTuqOI
	K7oWodGg8XDHO0ICLAQc/sf/oxrFrsQ2TIzCvbQ3TY6QbLU4YlNqyOsMebFQJSuu
	+0TCJ3BM0XzxNmp2AXZzqQkB0FnA+LIovjlmZfx+tGqMBz4Sh1MOFcZKCmZVTbEn
	To3rI7hg2jDduNJXhq5B49CCxoQi9QtZDbAkXgN4HCkaBWbkHMP9PZRYTRnRilcK
	BGXCebTDY/T/i9JpwT9LG774Y1zgviuiD/nb5CS4r8F9FMTnsNzKyiYLj+n5pAtO
	akyfjOOh/LDjEqoR6oi+B4Y1EwehnzlvcSw==
X-ME-Sender: <xms:h_qOajZrCYEco9zwycNV9xVPhsj3f1TyvI1mDJNryFh1qiq9MHtJEA>
    <xme:h_qOajGYzJ9bDCVQu0ulnrJbFMrrAK_uDZM6RooQ1Zst0vyAh9rCd0Qi856dHtCiG
    TS9A5MFbQWag3pB7KBTRwpIZGEQzYy6KFioFcfke-S5kgv9_fE>
X-ME-Received: <xmr:h_qOakKnue3LYSmQnjHG1dZcOcmd4FzsuTUpBsbkpR9895sZYsHds7UqrfwkGfQZal2lwxPbBphHgcEm9q2M_3FPqxxi2mm6rg>
X-ME-Proxy-Cause: dmFkZTESzX/wwwS5XJofEPrqZusSIsFccs8ImgDistxKf/Qgzw+iiGfkL4jgMyNPr9uCNa
    xCDPBVU/R4KrxNRpOPmPJphcMinkTgkWt9qSV9UP9v5316pREVu7u/DUixtKaQRkKepare
    pjIi0uBQ//ZnFhWl5bDkyQm2aVFqmKd4gveyxWaU8nfAndLq8aTjiF+7U10fLZ+wrhBBGF
    mn93WY+LRDf802l+vawtvkn/4oRBQunzlCLPanvPMCZKX+MK+UWmEan/f9g4yGpGHc8G+0
    PMloIOuV+ibhtFSceXF91tei7GdjOFcuix1fDN8aFaaWz1JQq/fCIE4Ael6AiCpXDEyNVu
    82bohOxDL4HQ0J55uOPr59vTDIp0+SyOYAjiygop4FkHJAIztZnKxDCBZgyBvA3RME2WgB
    UHv/pbMyeCYjnQhz34KdgTn/IIhSoXE+QxwYz7BAxM19Cnj2d7PYF6IWZmM3kqQkkCJ610
    XEjD1vjtLNrY3SPwNQ+hpqCFeMR2LrhIfyMFThExxvz4+OVPB6+CaLKcXTwhIOE939WO9l
    sTLpKtjXmJc2uBZnD9MuVGW2wVsUnj9Xi/q0FW+lZfWEZ95pnUU8DCBDdki01RaivK80S1
    dxdaz5a+q292L9ktfBQxpt9RuqvVmaETom3Bliy6ufb9l/sUdynWqXEBDmgw
X-ME-Proxy: <xmx:h_qOauPidsPm9-B8LM18kildsW2C9jTRW6c0WQW05hkmmpMW0omJcQ>
    <xmx:h_qOaknolIA-zYVEPUgcs1Uj4ee0-icGE_SpurXEWEgTp2b3_bMndA>
    <xmx:h_qOai54zYdFu0trs-dsSCaeTjClbZ9wcQyuED0mWs-2IUkwBua0xw>
    <xmx:h_qOao09aq4uT6HjXtSOo3Yd_iDN58IfApMwh6pRsw9_DEpLGuaM0Q>
    <xmx:iPqOanW5wAEThEcMBbYpqmRpy3GG_BYtXzTu1JcijZ3pWXrXV3ex1SzI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:39:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/3] hook: introduce the report hook for
 git-receive-pack(1)
In-Reply-To: <CAOLa=ZTN_95gsySKqA6Tm2daaKYNcM+V-sPeBLup3vDr1BznYw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 26 Aug 2026 03:35:53 -0500")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
	<xmqqv78zr0pa.fsf@gitster.g>
	<CAOLa=ZTN_95gsySKqA6Tm2daaKYNcM+V-sPeBLup3vDr1BznYw@mail.gmail.com>
Date: Wed, 26 Aug 2026 07:39:02 -0700
Message-ID: <xmqqbjapj69l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> This has some interaction with Justin's pluggable writes series.
>> Please help sanity check the conflict resolution I did near the tip
>> of 'seen' when I push the integration results out later today.
>>
>> Thanks.
>
> I had a look at the merge and it looks good! Thanks

Thanks.
