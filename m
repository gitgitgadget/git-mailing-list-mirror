Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CC3D45DF
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463718; cv=none; b=P/swmAsUp8IEvt+w6aod6gayxrVyVZylQG3reCo+pD2+99h/5uQmSCoi3MRQ5fYUlem0nQQAubibbMBO0LFBY7SsoqtI8CgAuIQ6lqHn2uISIj24mAI4EHEuVhaJ6kwimM97Q0PL1GnSpp02gQ1Z6HJxLDEmYN2jg3wCHtY31wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463718; c=relaxed/simple;
	bh=EJfOyM2YQXi7DAQL45Mk+i4GdGi6SdsYMH9Yy3AxKnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Td6Z56rMOtPeXSI4xgzjsjm6bU9MszQB5xHIATL/iTEV+Nq3u2TN2/6u9LrweRDhRUIr5gNnPIHrr+r/p+xGGfgJdG+B0ite7NZQCkAqRKe9so7FXHVsyNms56ZX8aNKXBJzVgUH/rEbgJQFlJr7Ux//6cC/CJPgO7EdrvLwIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uARJtE0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJ2JTIRV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uARJtE0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJ2JTIRV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D83EEC00FB;
	Tue,  7 Jul 2026 18:35:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jul 2026 18:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783463716; x=1783550116; bh=lLHrw1c2tb
	N6Le0kUJUWdB963FJQ54Djq8QRJ2RFCL0=; b=uARJtE0LNFrxyt2e9Nuuk9vPSl
	oXVspjVr8HQWnVOIIcBqFp282FOnxhIeoMGBYC4dszGs0UfiC3E720x1mc/pqh0Z
	v56J9ApzCD/ONL57zN44Z8nCZvk/ouUJAzTWpg9JFqqlOOgjODT2HCkwvV/vEZTx
	xVeGuVIUICgkQB9jH1IgVELKimCqLTBx1fxRgucUsPeoFvPiwiObxJDjwW5LY/+3
	PXEEOZB4LXzgcpiPex1zWXrP3IIKob6FqvYEANZ861sfA4TNnE9bMJcK1AWl7bMs
	TTOKHyI0dmh6wqN6NB23GEt41wC/m+Y9K6+suYLG5U4XggZXPNp/MVEtgTew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783463716; x=1783550116; bh=lLHrw1c2tbN6Le0kUJUWdB963FJQ54Djq8Q
	RJ2RFCL0=; b=LJ2JTIRVVUTpOwKwXl/LPFyusUwoYTCWSLhgaqvXFay91fyAgUC
	YNokqE+YFVrBkbQ+wqj0daaoGwHdeL9mZaeVRXuzkZe1B6x79gmmEoBaxnRjSiyZ
	pSe6+kD2Ip7Q+IrDJYRQk3DuP/9I0m6j6Qe7V+UlQhj0QeWl/plnb5yBPrsZwNvl
	8ILGJBGUM5WPY7mjWQ+3OqZZNulvVtu/6cv3OdIvLw70KaxTGjzxl3kSq3kCTFDe
	iHQwy39YYEp12nwsrzOUmvtvzp5BHGWmdvAZ3RyyEGktGW+3zY2ShnYZc9GuI9Gj
	NWNKM34lRNdHoUw2Dfm2bIHvq5LZR84USYA==
X-ME-Sender: <xms:JH9NaqpvQ3mCaKA7LeSejWbBRbiVW3ycF-9PB4iBqeVUFA02q7e7Rw>
    <xme:JH9NavoH8PdjWjMq7ofOF13dQ1Idj46srHn1cbw_aiyr-b1VUPqCRAKxRWCHho4Gz
    3oDdhMn6O6fkMnHdz0ee_xdVtmsBM3BmF_CMKYlaOmLLry6kqeX5A>
X-ME-Received: <xmr:JH9NakMPwMzPV7GxTg_TJWWZeJuKKfJxxWgKPFI4Pgj6j3v66R6BVf8wMA_H8WF4CEmSMDx8hHZqDYsjmEHdK3j2H1weDRdwe_fiIjU>
X-ME-Proxy-Cause: dmFkZTGXwBN/lM+AQWEMb1ptR2gNzITHw6AxpqQ0OEGBmPhwPrzewWw87wOFK4vTSDbvuR
    CDYu/4547JUeR9Oz3HQU/4YtDCO75XAm0vgfcOqAThN4z/P1Ui2y25SgmRhwrcFuRC7Mjs
    brrzJOCP5DdLw8xnGFh+LAxbyZ3VkQWpTFwuOKZ14oWFx5Emg6r8Ej28pcCTzetPDkmNBy
    RL/LoeMzcrzeZx8GZjNsAWnMV54sZ5iKkVUNJvKcpYw2DPQhSNxRJWmT+lZto/G1xUuM2x
    bRp2dtQnXMgRhGWKkCfv3hAECvtv7zkqiQOfwM0fLkzaouoAYvr1s8NdZ7vdQf66S4xLr1
    Jw96hj3eBiHu7E+VBgNH5TDhZlNE1cRvU1gZtEfhrN2jFBJ0o9A266gV3DIEPY1NNPxq11
    cdHbY8EjO8CdNJ0+O3w9NXx4o8KBL/bCBvRSf2lqg3oWuMuNb9YEqjuhM2qHLUz1X1KGJ3
    QMsJvM3nRR/8Rm8ef2UcZS2EBcWoTKDVhvjeEVFT3U0dYQBvAoN+ssYXQnSlfjcgVT6Fix
    J3Hkzb+4voxJgVh7sPd1xX0lxqRl7E9hhvaUtU4AAJck9W0ISOB1nQr+50FBuDzozVMDzy
    gvS99MiMpj/ArKcTamD2i4FGioEOHgKVb7AsUzN+L7K6JZ+YAzltuGEJ6HuQ
X-ME-Proxy: <xmx:JH9Naoy_YMDWoXH1TYP8BjCjvdTxk2cnyDpiA8s_qR8OrimvvTg8jA>
    <xmx:JH9NaluMmn_w-qt9pc308ni1VSpW5O1Hdx6Xh9f1Ub9YfCBrE6qmWA>
    <xmx:JH9Nap7SYctpJKQPqNYwxAbig_IF0nZsH-FsGdMjaxCX3yG8ir6iOw>
    <xmx:JH9NasS0czHTLLb5vqwp3Gz-lh4_4K8YilU7TlKZ1RGAP0ndvPbs7Q>
    <xmx:JH9NarRDAD710DUqjXEtsCUxfJf8-jq3_E2opAtk21fmkaMxouHnPoIT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 18:35:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org,  Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] http: preserve wwwauth_headers across redirects
In-Reply-To: <68c2b88f-8976-474b-8965-97733eba5a99@nvidia.com> (Aaron
	Plattner's message of "Tue, 7 Jul 2026 12:21:27 -0700")
References: <20260602161150.1527493-1-aplattner@nvidia.com>
	<xmqqpl28scll.fsf@gitster.g>
	<5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com>
	<xmqqo6gi3905.fsf@gitster.g>
	<68c2b88f-8976-474b-8965-97733eba5a99@nvidia.com>
Date: Tue, 07 Jul 2026 15:35:14 -0700
Message-ID: <xmqqmrw2zavx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

>> Did anything come of that discussion?  No rush, since this change
>> fixes an immediate issue and the helper suggestion is for long-term
>> future-proofing.  We can treat them as separate steps.
>> 
>> Thanks.
>
> No, I got sidetracked with other work and didn't get a chance to get 
> back to this, sorry. It's not directly impacting my users since I can 
> just tell them they have to use my server's FQDN, so fine with me to 
> treat this as a low-priority issue.

Understood.

I hate to leave a topic backburnered for too long.  As this topic
unfortunately has not seen enough attention by reviewers, between
two easy approach available to me to deal with such a topic, namely,
merging it to 'next' and discarding it (with invitation to resubmit
once the author can spend enough time on the topic again), I'd
probably choose the latter.

Unless somebody else steps up and promises to usher the topic
forward in its current shape, that is.

Thanks.
