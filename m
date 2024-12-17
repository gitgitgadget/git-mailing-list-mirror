Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274481EE7CB
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468577; cv=none; b=Ev47zzv27zzzybNJswRIixnDCYeiJM/fS3bPaJpOBYAVPZvcprUQ2Zk2Fy4UUfj9n5xt26Ij1irRTdPAW1z/7JJ82+rWV3P1jcg6I2EtMHQ6Ti3VCHwWt+ZtZkFROyEnZcPA7XDDt/pcqNS3LkmQiNIKArcxU1ySHcVWfD8xVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468577; c=relaxed/simple;
	bh=Y56MoqAVT9adzIA6ppFSE9Zrz+jV8VZ1zhs7twQBHv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qEkN9LbmqL//h24Ou5xOYCej9GpWsKYjCwD/FOHQDQ+ts5BiVVafew8NAqmh+BjW2FMpUJiXEvL3utJdtxV5r0IMSjAHeqMmEydemvnjc79+1epWcEpOrYQVK5g7++uv782fS1Hsj8QzCDnocYUFNWz2gC/McpDPsQosorytjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CQnw8slp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvVRWa89; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CQnw8slp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvVRWa89"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E21F114006E;
	Tue, 17 Dec 2024 15:49:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Dec 2024 15:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734468574; x=1734554974; bh=Std1QiXAkA
	8IFWzPOxMg1IuUKeU92GKH1BalunRi3pc=; b=CQnw8slp5Yw1orcmF1xbpALefE
	v2zreisTRI/L+BeoNDDInU+z6/94kb//jW4kuHFl0qvoyvMFpJ1JTOs6FtNI9xxz
	p5J6YKu7pGCd+rKuUQiaR6klxu21/Yfp1kU6bDuTWqi0OTHJlh+eclIJp5zvkhfG
	CrTlJSVQjTAtdlR0Yr5jfVPDGl1JKn6GQoictwiECQ+L8UecQnelteu9YX+pelKv
	UtQzLcSusb1iBqoNygxd3DjKhfFyC35ikcUPMjCv6A7ftF4HpG+S1nrTCF94ctUa
	JnOOlWx2vhgMT32HooQl6zh7fMcoh21x+XlKv+12GnMfI8qPVAZWGZS8sMcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734468574; x=1734554974; bh=Std1QiXAkA8IFWzPOxMg1IuUKeU92GKH1Ba
	lunRi3pc=; b=HvVRWa89Wh3rR1KoJZ8GqyhYb/RxQxud+iRJy3G5F/+yLsWNH+s
	VpDhOQeaPmACZJRSvtO8E8yCrQCNApKuXxen+FnygiwRgHKPB4n3T9UxvEeOo8SK
	34tUSAhd1jJmua354WF6brImPTRGBz4aogU8tPUvMe6HJursGu6xV62a+cJj3kX6
	UO6cnbkofZBW8nxHm4D0h6yrhm6oEwGIYfBZn8fuyj9O6IUvsLqm6rB0rKyGkT0n
	Ry0Rw1xW031CrOyxNaDUd/wjxd1kRcAAeIMyOo/UOhIYGfTqEcodUlaxSTQ4IiZ9
	vwm58FAeTXjI5b/Mc6O2qyYll68xJtveQ5w==
X-ME-Sender: <xms:3uNhZ1tYY5MemlCTzjICajgjUciRxL6Ed1Pp9bdNjdsYSizl9aW16g>
    <xme:3uNhZ-d8iKhSKFHZgZlTZpQb5HmUBotuQbX-8YqEjPQPF2xxdFGZ2E0K9ISleBP8B
    LMCUCChL3KwJfM6nQ>
X-ME-Received: <xmr:3uNhZ4wQqdDNogo9DHGIg3BU6yPx5IUF2bZ-UGKQ3JemYrwNjave8cS8gMNlHpOWsYVKsCxqvk6_LcZP0VbCvdN4w8PJrwhwErbUgMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3uNhZ8M_zapuOvo8TUL6I560XDgOi81ac6mXpssT_hZmEhE-mjQo5A>
    <xmx:3uNhZ18ctT4xCdEUAhXYaU5fRZ3tVCK_txE1tAzfZLYbz7YuI0SwdA>
    <xmx:3uNhZ8UKFXXe8otSuLMDbwZcaUwF7rmSU5A3MqwuATuVz-OWcISZCw>
    <xmx:3uNhZ2cl3Pey3suXeef77IRl5IESRUuq8yubHcSCfkuzld-it4NExA>
    <xmx:3uNhZ4kVVwkyEfqJ_aI3shbHeL24tz_MiQNe7U9NWLrOhw_rZxFVDc8p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:49:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] ps/build follow-ups
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 17 Dec 2024 17:31:56
	+0000")
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:49:32 -0800
Message-ID: <xmqqzfkuxcf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> These patches were required in the course of getting Git for Windows rebased
> onto Git v2.48.0-rc0. They are based on ps/build.

Thanks.  Let me mark it to be fast-tracked to 'master'.
Queued.
>
> Johannes Schindelin (5):
>   cmake: better support for out-of-tree builds follow-up
>   cmake(mergetools): better support for out-of-tree builds
>   cmake: use the correct file name for the Perl header
>   cmake: put the Perl modules into the correct location again
>   cmake/vcxproj: stop special-casing `remote-ext`
>
>  config.mak.uname                    |  4 ----
>  contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
>
> base-commit: 904339edbd80ec5676616af6e072b41804c1c8eb
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1840%2Fdscho%2Fps-build-followups-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1840/dscho/ps-build-followups-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1840
