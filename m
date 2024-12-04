Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47E18C322
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346309; cv=none; b=a3PJmn5TkaLF1dDTPJ8v1dibxxCNTHeYXaTrNc0+SfUBRKORxU82YDXNObfW6yiqU0u8ZSL8qcnae7mFjq2daUP7JG+HRjsNy3ONjm1BRaXohTlM7Yhu4tVJlfpuXEQjxpKUVhfX00D+4bvBAb1QtRMy/3GCG0oJU8jeV6VE4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346309; c=relaxed/simple;
	bh=PC60oBhmlIpwW1HXn41fw7Fww9reI6oqYNXBTFSH5lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMUT9zEGgASIUY2OS0Q97NmOeB7xUx32xYaLr0BHZSToSHNGuDbfxCM7jDoeQv4m3rEy7K/fHRuaCPhZNLKSiaMnQKzz7GgEMvO0MdI6FK2uastMDjg5VP6oZPOqAIpWDSe/rOOgCqNQexjKLa3NIXl62uQrLX9IHEOmTeTBgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoVR7eZU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoVR7eZU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E2CBD13806CA;
	Wed,  4 Dec 2024 16:05:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 04 Dec 2024 16:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733346306; x=1733432706; bh=bK8/O0cTUPuPIPCjnUgwDhEP772e9gFgtNy
	UJMIYwes=; b=KoVR7eZUO0ce9qfDdP5F4CbR2hoCijchKDoAvjXxZ6iW+U8/boU
	OlO9DeDJ2mcpWAQF9wSc8ZzHEgSVGdKaHU1frdv0BrI3Rur7yrCxRuF654t9/Ldg
	KXtfLTocmTBXp8O8Mj7WRjh5OiujgjK86lKwHFyks2DcsJrPAIUCCNzIEOC0rr8j
	5amNY7rN5el4qyCvZeX2hPBNYkBds2EdxhQrB5VXPOJy77tqAC9s8Z7N0syrqERC
	C8vy0ULQsiwvDVzarTqx8cSZ1BQ/s8Dcls0Q+qs5jrYO3ggLRyX+OTVmmqD83n+o
	sbHoJarSv7WXQOs9aYRKIPb8wI3IZACQWzA==
X-ME-Sender: <xms:AsRQZ7cNb3eJZ9bpgIbT0f7ZRuL47zE5JmWZzeemq76fcVdnSXfspQ>
    <xme:AsRQZxNdRT9MOj6_VD287aE6ds_Wo21X6toB88_R4qeyzjWpIcPNS02CRNKIfTz1-
    9fzminPqKIM-MUQ0w>
X-ME-Received: <xmr:AsRQZ0gLDIEpH8_YbUlFf8SwqFiw-_9j7Fl_N-BQUPTuiwK6f7V2eRfrZb9FLZE8F7YCo5hPOm3Ie0i2oeYjS9VQzPIM1eU0eM2QrvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhho
    hhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:AsRQZ8_pht9DyORq4Fkgm7khrqeixjjdjjyiE9QRs4iz52dWnHf1fA>
    <xmx:AsRQZ3tLmat0ouciuS5OoGNJCbRzSsHcuegdE4uEjxvdwPCMbD5mCw>
    <xmx:AsRQZ7FBYIqE4y_C6VdTFyZQQekTvRMLLKf-r5diIlL4Kodyu-9cvQ>
    <xmx:AsRQZ-OPyuVjsrcfvUXEUCSpANypVBfeYnvvwXlshWEjg85BvLYkfA>
    <xmx:AsRQZwFPFufdr-RoZ1hUcS6ecEma6DZcOShmrPLJRHTfB1BUyRIXN0OL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 16:05:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>,  Jonathan Tan
 <jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/8] pack-objects: create new name-hash function version
In-Reply-To: <CAOLa=ZRTgJafxDTB_LWGJxGZ_YOP4fO3=s14BHNvPaHEqf4Q_A@mail.gmail.com>
	(karthik nayak's message of "Wed, 4 Dec 2024 20:06:48 +0000")
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
	<CAOLa=ZRTgJafxDTB_LWGJxGZ_YOP4fO3=s14BHNvPaHEqf4Q_A@mail.gmail.com>
Date: Thu, 05 Dec 2024 06:05:04 +0900
Message-ID: <xmqqbjxr2m7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> 2. Generally in hashing algorithms the XOR is used to ensure that the
> output distribution is uniform which reduces collisions. Here, as you
> noted, we're more finding values for sorting rather than hashing in the
> traditional sense. So why use an XOR?

I am not Jonathan, but since the mixing-of-bits is done with XOR in
the original that Linus and I wrote, I think the question applies to
our version as well.  We prefer not to lose entropy from input
bytes, so we do not want to use OR or AND, which tend to paint
everything with 1 or 0 as you mix in bits from more bytes.

Anyway the question sounds like "generally when you take tests you
write with a pencil, but right now you are merely taking notes and
not taking any tests. why are you writing with a pencil?"  There are
multiple occasions that a pencil is a great fit as writing equipment.
