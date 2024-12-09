Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083F1E48A
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788064; cv=none; b=MUthBoMmeoMcVP0j3a3+o6eZ/hn1bmoTA2vAueOIU6d6n/KTiyYbqOIoAigiEVZqubS8vYT50+4AIklM32OkHEuv374bQor9pIjo3lGcBzVzzY6CCWWMk8JzvEK63mJBsHQCgRRCsQA23FD6Dp3bG6oEarplx1/xAbH+h+bvzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788064; c=relaxed/simple;
	bh=TaJpv3MdPk7TCBaNOCXc5SEymZqh+FHIEw2sBQBkfNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/wnk60Pb4oA+hD7M8Gi51354KdQ1bzzQm6J+2IsW49UyueQgfgkLUIh+2R5OOL7/0DmmmWUTtmBVPvfUoavMs3BVdeI4V0LE2HdxYsVZ1qIEnIbYZnkPm1/I+FkemxegOyviPYLfa/mT+CMEYxZjn4mvt9TgQVWQJdLovS84I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j96bmIFa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j96bmIFa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 043991383FDD;
	Mon,  9 Dec 2024 18:47:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 09 Dec 2024 18:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733788062; x=1733874462; bh=xsi4jnI0fvcwLxQR44Cyo/zuVhk+3UmJOh/
	/yWMnPgg=; b=j96bmIFaCMTlwsK98bWoACQUJYYmOYL9ZVonvbTsIQgBSWONcG7
	BNCCw1xrAhjPeI6kQ453m0jBvWXf6JohrjcT2bZjMyyGslaJ0a0WfO1RyV4uHQWY
	eYgcdjC4azrWT6fMDF7MaFbMGKHmZycM5I8ZgAlqKOhUu62QAciqprCGaM/HQBr/
	+g55N3Dup6RIrQPxEDHChDTrbMDYQaJ761s2IkhywcvSWZS/OL05DFKfFCWcNnI5
	fceAaaLw4Onnr+fklQFVycuopxCQLsedZLZBtDl+uYTYfjcFFhDov+IJ8YiQPxYO
	EidpJzQm6WpCB7ukbGLzusFvl5uNTXj24qQ==
X-ME-Sender: <xms:nYFXZwwJ-i9eONrnGy4nV4COk7r6x_4E-uosZTNUQR8zs04A1v7ycw>
    <xme:nYFXZ0S-nBjOLzH80iGV3YqhNi0tRkFLhnTdpZegAOEUKR_MRMlOA5e3_eSxZZdit
    0pdfeiqgJFgejfZwA>
X-ME-Received: <xmr:nYFXZyVzvqMvJF1z63hCMbzo6jDzQlBMNXzdpvZ_iRKZOJNSpr4vx_JDzNwwvdFm9TR9LoMHcuOGy7N8aXhTu95yJc23R8HYLg2byh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlvghjrghnughrohdrsggrrhhrvghtohesnhhirdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nYFXZ-iwiVSbn0lQL8AOnzojBl_4OH_6qAkWVYgPMV7z3rWkGS8T_A>
    <xmx:nYFXZyCHtDWUAD4oEalvdBXHTkX9ortVkgRRYRy_Mtbt4w1E1pI2mA>
    <xmx:nYFXZ_LkquGf5gGsjHzEy5jRA1T7ksH_DpJB4a9n1tp102CosXWXZA>
    <xmx:nYFXZ5B4Kv2odtfAyEpwujdBXjq_xNHgDfJwUq1xhOPCxJ1y2cn6UA>
    <xmx:nYFXZ57NbnpoPUDr9NMK32wEuPaCXa43MUNbV3_jRFfcxgQWV-Q-0g0a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:47:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Alejandro
 Barreto <alejandro.barreto@ni.com>
Subject: Re: [PATCH] Document HOME environment variable
In-Reply-To: <pull.1834.git.1733771894867.gitgitgadget@gmail.com> (M. Hickford
	via GitGitGadget's message of "Mon, 09 Dec 2024 19:18:14 +0000")
References: <pull.1834.git.1733771894867.gitgitgadget@gmail.com>
Date: Tue, 10 Dec 2024 08:47:40 +0900
Message-ID: <xmqqwmg8mnab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alejandro Barreto <alejandro.barreto@ni.com>
>
> Git documentation refers to $HOME and $XDG_CONFIG_HOME often, but does
> not specify how or where these values come from on Windows where neither
> is set by default. The new documentation reflects the behavior of
> setup_windows_environment() in compat/mingw.c.

Makes sense.  As long as the logic to make this fallback is in my
tree (as opposed to being implemented by a set of GfW/minGit add-on
patches), its documentation should also be in my tree.

Will queue.

> +System
> +~~~~~~~~~~~~~~~~~~
> +`HOME`::
> +	Specifies the path to the user's home directory. On Windows, if
> +	unset, Git will set a process environment variable equal to:
> +	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
> +	otherwise `$USERPROFILE` if `$USERPROFILE` exists.

I wondered what the reaction by the readers on non-Windows would be,
but hopefully they would read this to mean that HOME will not be
mucked with, even if they leave it unset (or they take it granted
that HOME is set somewhere while they log in and they do not have to
worry about it), so it may be OK.

Just out of curiousity, is Git the only thing that uses $HOME on
Windows?  Or among may other programs on Windows that use $HOME, is
the way Git gives a fall-back value out of these three variables
unusual and deserves documentation?

Thanks.
