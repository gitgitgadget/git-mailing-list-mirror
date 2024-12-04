Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424B4C76
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278980; cv=none; b=jZe7KvdGaH+7SiBFxUl5JAZpEQxOYluFjHyxLpOuKpUdyhi8sAjqpM5oRnySZc+iUQzR/gDrW5RylQQvBLxtk6wB47gNfMX1j2YtWrg6AauzEeyTNuuJd9aAZXEn0flyeCeTC7Ib2uzZygspnBepCo1OtsvWvcVd5D7t1JJ6A+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278980; c=relaxed/simple;
	bh=aIXg4BpdRv7Qt2RYdATCooQ5o53UrJVNva8t6dVzVP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZhMiamrQxCGGoDbTJP5Onnf6/PdnhK1hZAJPaZ30+Ci6T4CS4iKvtGJPEQduZWcattpHkkoIrOaiRXZiPXHAvPMK8+UAUHpkfjuwLsnPH1n4QMnc13Fjhi5x2SrWRAbQJrMvSLKJ36nzvT5xYlnVHrdPC5NSqDqbZwIGZeq0d98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ov5pIWTt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov5pIWTt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAB601140158;
	Tue,  3 Dec 2024 21:22:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Dec 2024 21:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733278977; x=1733365377; bh=j0d0PHEjkRuSq/XLVJZYTskmO9e73aeeSeW
	R+D988kI=; b=Ov5pIWTto+WD1KXS4qvpeLASvlx+t3R85kbosu53Xt30U8xKV61
	OFft/uprb+/aQdQXwWu45F2SgoH0bxgwB8AOVnX7MpcpJDDvjnmoVbpmis1SbKZ2
	hdpqRO+20H7QGj2XnTmDNooKZr1JPHu5yB/AJDzx31SvjGwfIO7r9/DN/uhvEP5Y
	UWRqUYNj9NaXlhdV7rLJ8XCr422W99jYe3hGvkJbkLK/q1d/I0iiPIg67lkJwzZN
	mJxDUzyiClIu1TyOfYccYiPIVr2DgsqD0IWG+XNIg+0cdIT8vvVP3JCAaWdeExlF
	njUy7Ow7qz55nQLwEp/zVZV5IYGEaz6DfrA==
X-ME-Sender: <xms:Ab1PZ6r7FqFdtT84LFWyCHtt1u4vzajjEDTohSSjugISAJFyHFtWDw>
    <xme:Ab1PZ4r_kfEuPm2T0CZEUA3oKxjx78dc99luCzhx44lQcI1U5iMfDrroKMPKhH0Ka
    LIygZzA47fXv6xxXw>
X-ME-Received: <xmr:Ab1PZ_MhWD3JFQbFv_p6IEyKgbsgiRwOjbCjP7fW_W_xnlOhQL9GW-K6skD_3nHvbwWJLU33WZoM4m979_B7F14IkRMfWP5J_pdkcsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ab1PZ54y7pdcUs3EYyow7H4OSiJyI-VsKBy-8fDwU4iDTFkwHOUNZA>
    <xmx:Ab1PZ55F0ZuaGz3vz4f0VFJl3F7A-DcWwTaGuIjeME3mYZpyYXXu1A>
    <xmx:Ab1PZ5g0NQ--B85ec48hctgRo1hMDbJxIq8lKQNgZMJaqSShXxhpNA>
    <xmx:Ab1PZz6GpQXDt7Yn2j9hq97XfLVbcMVoq3KKcaXMqsgLFHF9h_SxBw>
    <xmx:Ab1PZ81ensZqPTo2iF5OSLZPf4v1jKO9zscPYVttxU4484lN3IV2TNuk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 21:22:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 0/3] Performance improvements for repacking
 non-promisor objects
In-Reply-To: <cover.1733262661.git.jonathantanmy@google.com> (Jonathan Tan's
	message of "Tue, 3 Dec 2024 13:52:53 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<cover.1733262661.git.jonathantanmy@google.com>
Date: Wed, 04 Dec 2024 11:22:56 +0900
Message-ID: <xmqq7c8g5gqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Apparently I did not save in my text editor (and didn't notice because
> the code comment was still valid syntactically, so everything still
> compiled). Here's a version with the updated and correctly formatted
> code comment.

Thanks.  Will replace.
