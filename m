Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDC27CB35
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229652; cv=none; b=N4lxeN7A7kVAxGP2QDjaFhCoQZvHJhBkucjLQrYRw3esMHoJTWoJNawy2H8yXSLo2BFOQCWbw6xfraI1y/hh0KIAMGR0R+KnTFT3TNvRVp9swWT7RDzDGLpOw577Z02FaQHFj+/dVhfUtKvPs7xNoGW2Qx89NsN3s4DRQQXK2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229652; c=relaxed/simple;
	bh=jqZqJrpx9nPewPRZRgOEeGz35FRIIN5P7l9P4co07uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5an4Dh/XiRG/fwJia2WFO3kuEcNlm3QU6xVFGrSSZihbDs5eqjQKJrE0yyydJS0PvWXKtUnn6CyITmhk62cfeEEuu6YPd4nPxPkJojIUUoItt+sZQP8lYGO6PHha5/4hN/PY69PtCAo5D8dx3xZm2uUKTs+q/Ab1jyUMucPG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MoiONJLs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmVNb00y; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MoiONJLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmVNb00y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 055DE14000C8;
	Mon, 12 Jan 2026 09:54:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 09:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768229650; x=1768316050; bh=McQgzGS1Gm
	06Y+tObkADyb3lRYWIu7OJ3kYVWrU2+5A=; b=MoiONJLsePz9G1p/J4Y2Rusxw+
	eFq9LahN8dhSot7ViCDdS/F7E8pWh6Ff1Bs5g22kOVLgzMyR5ORslvROidxkxPln
	8IIfxpCDdKpedq/ZViFk0A2vDSXOZB/gkaH8WbQfzMupJ2LdyAkOUM4Bf10jaPMu
	7bhE+hWD7TmjkHGZ14n1BT0GIKDoG3SSSNdTvbnkCKgyfYTgJlnizhRPUp2h4ML8
	mEOAuwPUtU+icpdrwp81GQNkQ6ihiWoJFWUfktbmkF5HUV/QIPB56zWID9us5WHV
	/IKSRzraRvDVTCfq/wLoXjujis+IdvR3doeFaj3bOZ0Xx2rXty5DZhsojG0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768229650; x=1768316050; bh=McQgzGS1Gm06Y+tObkADyb3lRYWIu7OJ3kY
	VWrU2+5A=; b=YmVNb00yuRaDprIhFmf2DYnpbpeeIjdGSyv8qazUyZu1kFrBM6J
	frLLkIHoImUou3ZtomWQB6p4eix5F/ZagU0qXn1/s4y0tDiHKJ8x0GJnaREYW/J6
	tgUhA7eMc17jueJXlzmPUCzgPKxyNtBNtdEn+2mC0+tiuSwCNaq/hUIGRnRpSS/v
	WbF9b1ghuvkh/dLNHEIEYIVLXF79GQn7TQLdjyrWUH5o9b8EbcRMkAgAaJqTyX1k
	6YTcvj73yJib/mer2OAyg7pnD74WODLs9ClwBR31POiIkwtIOL4l5pNMGcWYkgez
	mRyR4lRoSYzAMgmm4iB++KGrKwqpbtKlp+A==
X-ME-Sender: <xms:EQtlacgkJQF2A3mOKzo13n21xyKbQf9MzxZv0U6vHf75PTTy6SpjXQ>
    <xme:EQtlaUFUpcJvaad5TX8H6osLGZb9oclyq44AYO0ak0onVuVGYYW8TjYJWJleGaESZ
    PG62YbfDNP_AWfVqzIvmLoiY0_LEMrn-wRtIPuv_Yfj-5eYzCx_BQ>
X-ME-Received: <xmr:EQtlaaQDkAcBY8RymjzmwFKl_wryVVtCucCUJ-q3uIO2CCyiIFztIzShr8ziNO7bzv_AI6FT7mdQCf7VBmlofl5yedcXvCMSIY76pEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepudffiefhvdefveefhfeigeetgfejgffhudethfehudeifeevgfeiudekhfej
    hfdvnecuffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EQtlaZwCsKP-8S1bFrW3QD7wWl0tWROLkvH0zZ8dzifjD06oQvZNEg>
    <xmx:EQtlaefSV6wUpSLrj50UU9FfnONmSyF2Vi_Az-gYVDoL0-yfKIH1-A>
    <xmx:EQtlaUNUjOikezVvOjq8og3M6hr8dpcvkHi3BU3qQQlCTCYN7MZvRg>
    <xmx:EQtlaRtj-2G3GyvWT-UjSzdB7ehH6qdLXcG_r19FMTRfbIYR10lRaw>
    <xmx:Egtlafhbwx2rSua4dNKlG-Km2nzd_0BsRyNltFMnE6o21GorQU0O4UBk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:54:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Toon Claes
 <toon@iotcl.com>,  Karthik Nayak <karthik.188@gmail.com>,  Matt Smiley
 <msmiley@gitlab.com>
Subject: Re: [PATCH v5 2/7] packfile: always declare object info to be
 OI_PACKED
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-2-9a6124e95bf2@pks.im>
	(Patrick Steinhardt's message of "Mon, 12 Jan 2026 10:00:42 +0100")
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
	<20260112-b4-pks-odb-read-object-info-improvements-v5-2-9a6124e95bf2@pks.im>
Date: Mon, 12 Jan 2026 06:54:07 -0800
Message-ID: <xmqqzf6inapc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that this also fixes a segfault introduced in 8c1b84bc97
> (streaming: move logic to read packed objects streams into backend,
> 2025-11-23), which refactors how we stream packed objects. The intent is
> to only read packed objects in case they are stored non-deltified as
> we'd otherwise have to deflate them first. But the check for whether or
> not the object is stored as a delta was unconditionally done via
> `oi.u.packed.is_delta`, which is only valid in case `oi.whence` is
> `OI_PACKED`. But under some circumstances we got `OI_DBCACHED` here,
> which means that none of the `oi.u.packed` fields were initialized at
> all. Consequently, we assumed the object was not stored as a delta, and
> then try to read the object from `oi.u.packed.pack`, which is a `NULL`
> pointer and thus causes a segfault.
>
> Add a test case for this issue so that this cannot regress in the
> future anymore.

Great.  Thanks.  Will requeue.

> Reported-by: Matt Smiley <msmiley@gitlab.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h                  |  1 -
>  packfile.c             |  3 +--
>  t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/odb.h b/odb.h
> index 014cd9585a..73b0b87ad5 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -330,7 +330,6 @@ struct object_info {
>  		OI_CACHED,
>  		OI_LOOSE,
>  		OI_PACKED,
> -		OI_DBCACHED
>  	} whence;

