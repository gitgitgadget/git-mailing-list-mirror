Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EA163
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002999; cv=none; b=eIDs0BkT53Sj/ST4aC3kPgPfxKYwsY2pPQKQC99x2zJPhDkMVWqdMuN9ahtzeHFCjPqTWH1vSXNS3+kA7gzVygYNekgOv+R20Qd4xnT1I8VkqXyFhbJMssvFuBIjuSVNEgp44gbl2e69n4b8CHxHCrNlgKFx/JJq2tXyY5GzeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002999; c=relaxed/simple;
	bh=l84KkF1PC+AsHkJ2PQDg1+Qjm6V9/9FdWTEzpUujY3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MRn8sstq1Jl8/4YnP4AqoEHGRW4aZdOt7Y33T4iofVPxcV+QVH7mPY3xZK/yR7atbxEDQaFc/4/YdPcZXar42ypt6JqNCWnLDQ//yCjaN7hxq5kEJDpxk7fxZuF35efEZvV2YXub4+GDXolGRmZyMRAUz84/PKxbHNUD0A/A7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BjnsZYQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anLjv8YM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BjnsZYQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anLjv8YM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E11D0EC0254;
	Thu,  4 Sep 2025 12:23:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 04 Sep 2025 12:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757002996; x=1757089396; bh=yiAQxBRMg5
	cNxmYAqwSA4RS+RNyOfx2BgEIyvUJ4S54=; b=BjnsZYQpH35zcokMqIaZjzShO3
	SIBlyXItAA5aZOlpabpwOZVCalFBwlDCIV6snRyW3LqRAq2lVvo3ckaAosu7kbwK
	2WdpQVpWvvMZxbOFCIgqq0edvCfobhVpV5chXUUVVMFCpztDsmUqFvuHIerTNcfp
	6YnTfiZOJhG4d0bboxLGjnp7RMmaIgfPwe1DpigLOpYfAatxRTkAZ0WLgM4ctenr
	ck76PeXwzL5QZToSMwhSc63Cd1hMy0yzc2wINrrv18taIdkVCP6rcU0oSOBMizW4
	JG4YTfZz3xRQ1I/zMiP8OqOyCqJk0i5GmmSkinR827yWlV6pg4rdP9i0OU3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757002996; x=1757089396; bh=yiAQxBRMg5cNxmYAqwSA4RS+RNyOfx2BgEI
	yvUJ4S54=; b=anLjv8YMSp+ATGUzNYL1QNo/LLGwaQDkqsq/8bXmdE2m8cDPEmX
	Lnyr4y/HJGC7AA3Jklk2FWf2J2YOcDgB4NfO47Ld1SVo8gcyDilKaM/Cd8Dd+MMu
	bCXq+Zz7K2imfLyOhdnvtRl3/DE4gvHSwKrJdqobNVa8DtClMXE09R32GStEi3wR
	l6TbG23Bx8rigfWW4sb7W+NIKjVzRkD9hhKXkzKTYLlSpnlZEEPgM8VtDD19dAta
	kEhJF8YvmddUFC6+cnaRsG+OOWlfsit2b+pVYMm8kwV5k/H28g61YL7ulGV1Eqv9
	pGNwJS+KN/Hxh+NUkzhlLOtldbPRv9hgQ2Q==
X-ME-Sender: <xms:9Ly5aOT5rruZq7sUdrfP1BhgzAGxAiBDDcpz91NnhIHwti7M_iUE7A>
    <xme:9Ly5aHBGsWgDty_FInFj8hkxGbvhe2hHfTVKKGQ8NIM0clu9_Fkmrngp3lLZLJ46c
    BKnTeshSvShRUzwmg>
X-ME-Received: <xmr:9Ly5aFQhztAyKW8qwaSgLEoerWZ7_1klg1KN_7lX-eW4CTHNatj017_VrhqAZJ7IKA2LzVoBWaB7Tw7AYJCcfe0V30-Za5z6_vdAcno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:9Ly5aFokhxXA7CTHU4Ub-GHxTS0I-y96sxP7cCQcp50PGD88EYkjwA>
    <xmx:9Ly5aHzXvC6aTqJOCo0g-5E6ED3CAA-U0i5PZBGNkcCLi2BwRv6Qqg>
    <xmx:9Ly5aKIxJCzW-dgm0RaLXal0oEVQ8cjseaLmvWhXEsZ2JkBz9USPLg>
    <xmx:9Ly5aJJuh_B1d8vfSHhu1Nlt9sNHHtHfyFSaGekctHoGgYd3D69SOg>
    <xmx:9Ly5aGkJai_K-Ladd8ER8PKniifKkQoEn366agJfHvrT-1d4K2UsJty5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 12:23:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
In-Reply-To: <aLmhjw2xAbUogL1L@pks.im> (Patrick Steinhardt's message of "Thu,
	4 Sep 2025 16:26:23 +0200")
References: <xmqqplc6byai.fsf@gitster.g> <aLmhjw2xAbUogL1L@pks.im>
Date: Thu, 04 Sep 2025 09:23:15 -0700
Message-ID: <xmqqy0qu9ogc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 03, 2025 at 10:07:49PM -0700, Junio C Hamano wrote:
>> * jt/de-global-bulk-checkin (2025-08-22) 4 commits
>>  - bulk-checkin: use repository variable from transaction
>>  - bulk-checkin: require transaction for index_blob_bulk_checkin()
>>  - bulk-checkin: remove global transaction state
>>  - bulk-checkin: introduce object database transaction structure
>> 
>>  The bulk-checkin code used to depend on a file-scope static
>>  singleton variable, which has been updated to pass an instance
>>  throughout the callchain.
>> 
>>  Will merge to 'next'?
>>  source: <20250822213500.1488064-1-jltobler@gmail.com>
>
> The series looks good to me, so I think it should be ready for prime
> time.

Yup, I am fairly familiar with the area, and I didn't see anything
questionable in the updates.  Let's move it forward.

Thanks.
