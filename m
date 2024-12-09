Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84256197A8F
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788402; cv=none; b=uLkRGvJnvKlUUxm2UUxvaf7xYdoJ8JcMDLs4oW7eFau+x0Lld8lOTi0JraMXeTKphdA8TtvB8AFGhNjCxaXmcR2buIPvvowYDQoJC7lAAxUXhoe2P6dB79T0MmQxJZBT0dStHcRmeffMhiAPgoDMB17VjylsBN773sPjK3U2YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788402; c=relaxed/simple;
	bh=l/1pkf6dmacOkWiUmALPWdF74CPG+T/JZ5Ny+gEAgnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MszZxUrB3RMZzw9y9lFqCMORczLHJNJtL+l/o1XKA4XCmZrj3ssmfLxzt+kJ5ewSSd/TJRBnxI7Csub6kY4HpuJBKHeoq2W6M+Kg+zKgBZi37zWW2VSSknN8FAFBJuI4ROJPM9dt7VlnEj3FAePGBXJph7uqShBI3GW+WIKleSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/AS8VJa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/AS8VJa"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 723161140102;
	Mon,  9 Dec 2024 18:53:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Dec 2024 18:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733788397; x=1733874797; bh=Z1l090mkvrN0nCKx/k3hbVsGxnzP/BjWKRZ
	0nQwHtW4=; b=c/AS8VJaWyN6Kd4La4uYXzgA02EKDXRnTVHHsgDkjwK/cYJdtta
	HXarvz0Bcp9YS76VgLSRNpgbc18pslTdC/Oq7SPIeevIabU9uxORQ5N1jvskGjfp
	80zPXDNCa1yWVOB/imP1ejhW8Vf1r/DLLXfJO0HLwSFjUPXrVDHoCo7m1py+K81I
	5Z8Sog54Gj739qmpUkcmQmwX+f3fdfWOoXlA59fvL6woSubWy4ojG7xZbQevt5JQ
	1zv3lMJ2yQrBk87lWG0RjSBcP7rZPWIonT97KYPSQiDznZvFUq1L+KXKpLzFlLV/
	DAjC1+Aspzj8zds6kdKoqmp9ZFiqhGGxnTA==
X-ME-Sender: <xms:7YJXZ5EdFwTVOgJ8jkh_Ng7WLz3MxHNVUBA02NZ1U7cyTqOCVB86og>
    <xme:7YJXZ-X4Cco9-J5P-PkZt4n4BhnbEBApRtqFjNktU0rTrkYg5R_oHwHdmCfvhmuls
    x7pyYjh_f7joTCW5w>
X-ME-Received: <xmr:7YJXZ7IPWfyjzb73VsLnqFrK5n3LYJm0o2UJebUQzuR9-he0NzGN9X1z6rOmVzzPMsSg_3jw8SUYSk7-PQ0QLFQcCeHy9uXbDDJGahY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7YJXZ_EGAY9BJRAf6pbfNTC5tHqOAqqSm727pZZ4iweNJ2Xlt-pgzA>
    <xmx:7YJXZ_U-HHDEDhyT4m04H9IqPhQ-Sa8aLbBw0lZJ8C3ZUJrj9Yzm_w>
    <xmx:7YJXZ6OIWR2Ztb0f0epWVo0hSYvmLEmerm8tQF0GJb9ohn9Sksuy1g>
    <xmx:7YJXZ-0ww7JHe6zPHlqUP3srgAT7ZnDkyil54PkmLreiXU9VAssHuw>
    <xmx:7YJXZ6Q_n0bixyoc-rEYcQUhE5FaYW-p1lP5uZPpquajr27JVgpbzuai>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:53:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #03; Sun, 8)
In-Reply-To: <20241209203958.801143-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 9 Dec 2024 12:39:58 -0800")
References: <20241209203958.801143-1-jonathantanmy@google.com>
Date: Tue, 10 Dec 2024 08:53:15 +0900
Message-ID: <xmqqo71kmn10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> * jt/fix-fattening-promisor-fetch (2024-12-04) 4 commits
>>  - index-pack: work around false positive use of uninitialized variable
>>  - index-pack --promisor: also check commits' trees
>>  - index-pack --promisor: don't check blobs
>>  - index-pack --promisor: dedup before checking links
>> 
>>  Fix performance regression of a recent "fatten promisor pack with
>>  local objects" protection against an unwanted gc.
>> 
>>  Need to squash the fix-up at the tip.
>>  source: <cover.1733262661.git.jonathantanmy@google.com>
>
> I just replied [1] to what I believe is the last outstanding question,
> so I don't think there is any code change needed besides the squashing
> of the fix-up (as you said). If you could squash it locally (onto
> "index-pack --promisor: dedup before checking links") that would be
> great; if not let me know and I'll send an updated version.

Thanks, will (try to remember to) do ;-)

There is nothing in the code that needs to be fixed, but we help
compilers so that they can help us.  Let's merge it down to 'next'
after squashing it in.

