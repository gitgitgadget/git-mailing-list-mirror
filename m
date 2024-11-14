Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578E5336E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550553; cv=none; b=ZKM9RVofBoAkL7gnOscIuDpCRZf07olEGD8HaOkOcP7poYflTyYxa5Iuh3mjQzc4jKt/9cnBF1QJHf5YMf6wDP4Bu6QpcSIu61BqAeRrRoxdKKYzFq/8byO1gVl3+Gu4qFcHrt3I5moKPi5qoBMyA+0vpX4SM6eZ8Q3+DG+l+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550553; c=relaxed/simple;
	bh=UkvhqI2Eph7w6rHTqe4y4+IaXPx8lPYlfG2OwMP/p4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZzyNmROyO0Js+PKsQbyR0Z5uyHjEG81ZRL2y7HRqsXrJ5p6IT0j9HpUVRDZgwiW8/CIS6/BaH8WXNPc4HF3C2TP2xBZC8OM4CDnSwynVtSGjX4Hq7GkLsyJxJFMuhIRT8v1TRMPVm8ysuvxXXa2itaEDunJIVZ3pGNSDPXi0wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUOMWBZS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUOMWBZS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B4951140131;
	Wed, 13 Nov 2024 21:15:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 13 Nov 2024 21:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731550550; x=1731636950; bh=4GNYr8ebP0Vg1PAVq+HVPf46LgQzDi9qQlK
	wE7odS6s=; b=hUOMWBZSj76RXKbjM4kz5EaHD4Apkf9NAozutFwK6SI6M82HxlT
	32uVsHrGVVnjJK/3q97VyNJTNtR9MA2DBemtlvPxP3o2eLTO3kOl7kaPnGNpzXzw
	8+euoOS7nRIYYjXoEZJmmIOYvKAroEngzAvumAB71eGjzYtuSiNt2ENGUaIZqqAF
	JYG0mxBrJGlSK2/5EGK6ag2I4kmK4Ap4Xxae6j8PjDm/nKSI4MgGYkpAFMghTbcc
	8zdNYLBPArUDEUX9Dy34odqCvAW56NbU1sF0GqOYuiv9fm5EVwKRLXbpTE99yHNN
	IUTpnyZ6WjPQWzAN0G1AYvPHSL6oTQes2lQ==
X-ME-Sender: <xms:VV01ZyXW__CdS_KYSbCbO7UQpZuZg828g6P4PiJJ_vuHUq929TFC7Q>
    <xme:VV01Z-mHZT-JCyQwN4Y7ReMDcMmCjnH0YQux65u1a9HbABPD15zLfc9YUiioyMzJh
    asJV6tggYnG8EdYIQ>
X-ME-Received: <xmr:VV01Z2aMgoadOZsGP3wUsG6rk8eg31TVkT3g0FYYmgN-mp0FvcnFnftFi28Hm6dw8OEKT61d6gRVMG1gmGpA1T7QmrAgXWHFnTfW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhi
    gvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VV01Z5XXpLaJuLpj-drLMQr6WK36vZrTiGbVK9PtIQP0ygLAvqrQzQ>
    <xmx:VV01Z8lsfw07f8Ac82ua23IWWXl12xLLd5IffwpMWe5t2aXT-abnpw>
    <xmx:VV01Z-eDMFMKENpSJh2JYokMjLsmE_7qq_ZRBGYPyVDxvbPZPyaqow>
    <xmx:VV01Z-FEu1-XjJQLj81kYa1_nAKRJE2NfVNZLyG3mArIEPYHwyDuyg>
    <xmx:Vl01Z7vE5Z7NKe5pJSKz8vYYDnfdKtmfVEZ3WSShVu6iNh5L8WCJjEYE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 21:15:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>
Cc: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>,
    git@vger.kernel.org
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to
 issue a warning
In-Reply-To: <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
	(Usman Akinyemi via GitGitGadget's message of "Wed, 13 Nov 2024
	19:01:06 +0000")
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
	<pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
Date: Thu, 14 Nov 2024 11:15:47 +0900
Message-ID: <xmqq4j4a8srw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com> writes:

[jc: As Phillip is blamed for suggesting this addition, I added him
to the recipient of this message.]

> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Modify the conflict resolution between tab-in-indent and
> indent-with-non-tab to issue a warning instead of terminating
> the operation with `die()`. Update the `git diff --check` test to
> capture and verify the warning message output.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---

If the settings requires an impossible way to use whitespaces, the
settings is buggy, and it generally would be better to correct the
setting before moving on.

I am curious to know in what situations this new behaviour can be
seen as an improvement.  It may allow you to go on _without_ fixing
such a broken setting, but how would it help the end user?  If the
user set both of these mutually-incompatible options A and B by
mistake, but what the user really wanted to check for was A, picking
just one of A or B arbitrarily and disabling it would not help, and
disabling both would not help, either.  But wouldn't the real source
of the problem be that we are trying to demote die() to force the
user to correct contradictiong setting into warning()?

Thanks.
