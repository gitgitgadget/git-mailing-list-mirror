Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108082BEFFF
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741254; cv=none; b=dh+KE1vrRf5MjaWDFiTC6uRI3b5CAwzwaxuA+0R7oE+ShQntUxibxu8D9W95k/Sx68SNoJau0mTIPU1OV4plkORNGCUP8d8S8/0ayPqJpwjYSDz1VFMc3kJuvKO69wIgDhEKarksEYLy7REYwS+hK/fk8HjEOQUpJegWG+JLUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741254; c=relaxed/simple;
	bh=9TGeZ/mbT/IuAhJ3c1duH6BUtXB8IH1lv0SI4SKUUho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d8zjMWBc7djKiiPgN5B4SNCZLxtk1bcEVRGDV8usQ0oIBje/9FofOH6R8UZbQFIwgLT1hZdcH8FR6zGzeZG2evGQkF88KH/nec6hC0v0GqWXZjJOfXRiKhlOv3eBGybxHnl+Ch9uS3Q7CX6PrclM9BAlW9p+48OxVgJhndME7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WbxrKjXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hy9mpI8F; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbxrKjXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hy9mpI8F"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 41CD8EC017B;
	Fri, 21 Nov 2025 11:07:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 21 Nov 2025 11:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763741252; x=1763827652; bh=BXRPxhhQpA
	1H40pxbqzoc3BoNVHYw3obPzoMhLFMcfU=; b=WbxrKjXO0sXTWUWB8UfPKtBa7n
	PqKLoP2+QNeDAyZMiKHpRqydt1ZdjoVpUvlpLbMKQ6cHP0jJNxH3eQQLtHvVZ8Jk
	p40xEYSm2MG3yfVYvrk9flRXMuSe3Gzrmixp7Elml/kpnneO82szym9l0/0n2yOf
	rUCzUbm0OEp+UWNM2uaVX+e9NaKJSzPKYLlcLIL4hNtDJTADxDdIq1fHRfjNOt1n
	V/NVNLMyUTkOtOrtZwgSrNr80Xc2Udxe2HaGCJa/FgmXMlweDISq5zwpj3PiE0BR
	eYQ3xUIJf5YvF4HCkE9h8BedyTFOMhhx4qdlGH65IslnaO/bOuXhT8m511+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763741252; x=1763827652; bh=BXRPxhhQpA1H40pxbqzoc3BoNVHYw3obPzo
	MhLFMcfU=; b=hy9mpI8FOlRS3s2BPcspocA7iwyzPQXUjuBQbEOUHpFuGeoNH04
	6zTtsk1WlW3jQ12egmfvmM1BGcisa1vn0SD4uarxdomVlSjWLPJsGi/sFPqbcDyS
	krvH/Z+YvMNlm8MAO3pX8R6bqZUkvU02yibrJBoH/nimqz6VcAlvdAbrD73CVNZX
	7U9Jq6lq4FDMFHbHG1cgObA45yJAJ74T1NYEmFn67eMNPgT0E1dM2XbUcPJm/pTX
	Xkfjv6O+X7mo8lJ7E8BM0U+qNBqbrg1MR7djhjqg7cCneOuf5yDLCYsMK7R4Qlz9
	x/9VWSTLOyETj7sQYUnukM/5fYX2Z+pdvIQ==
X-ME-Sender: <xms:Q44gadQd67CgWM6NTj5hAyELaOzVWPeJQtE4Qn8QHuOZSzQYA8CIZg>
    <xme:Q44gadzrhkvTcNaWas_66yrZMjsYuV89h9SfxP8JZja49twq_2n6g9G79V9_CrI72
    nsDAjBk9k_4tQlvJLhbTdnc9vht-EXrHPx4SVKLfOWiJFeR2MjIFQ>
X-ME-Received: <xmr:Q44gaX0iFAW2jdMXuWemezYwIUzJ0EkhAEFGfdFw6z97qYBUxZKaB9XDczcnhYlJ25GkOz3ok3tWb7hzx2M4adMAOE_iwCuZiKJl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Q44gaT4L60qO6bcZAEclx8TZwF3e6dXM4_8Ih1JXjvc-LbNgJfMJKg>
    <xmx:Q44gaSWzluBOQ32g1gx9jmIoY11xkQT7IWYZ_RA2iXMhfZdOFj2aTw>
    <xmx:Q44gaaDSz49qc2KIJPIjiQEbY3MmCxGdnu91DaJ2l0AEARKEo-IqJQ>
    <xmx:Q44gaZ6BI2ZGT18OtshIsovepY5itdKCDbpwq3OS4wKxCfOk8IiKxw>
    <xmx:RI4gae2aIVVEd1tzk4MTDvuKGE91HLGzokEWU1lzcLvw8XS0aUF2UiQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 11:07:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
In-Reply-To: <87pl9b5wos.fsf@iotcl.com> (Toon Claes's message of "Fri, 21 Nov
	2025 14:42:27 +0100")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
	<87pl9b5wos.fsf@iotcl.com>
Date: Fri, 21 Nov 2025 08:07:30 -0800
Message-ID: <xmqq34675pz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>>     <ref_backend>://<path>
>
> I like this idea. This would allow us in the future to also do something
> like:
>
>     reftable+nfs://10.11.12.13/ref-dir

I actually thought from Karthik's definition that what you are
trying to say is spelled more like this:

    reftable://nfs://10.11.12.13/ref-dir

IOW, the underlying URI to "reach the resource" is in the <path>
part (i.e., "nfs://<addr>/<directory>").  And I found it somewhat a
strange syntax, because the "to reach the resource, visit this" URI
may not necessarily look like <path>, and I also wondered if
spelling it like <ref_backend>:<URI-for-resource> is more
appropriate.
