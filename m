Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DA176FD2
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264178; cv=none; b=tItUPxmMhNhNb+ovaa/nLrJ9YhTl+aixl25orE4ed6DGoRBKeCx2VkWendqiD7Joisol2Fkf0LG9F7+kKTufablfWsEBmPrOTbvbqGZl3mJnvg1nVaG2bygrSUOFmKp8ZDoyd/u2eqZUAU/gFW94+G93ZMCvk0eUAURvaq5Z9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264178; c=relaxed/simple;
	bh=pddE3JXMCmp9f2gbYY9EdEKrvalXzNkuo2J9DLRA3T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaIIsWcMm7fKNq8Jh2hi+xI9DFlISSqohdptXdT1KxLtfueCQbIeyrkGsH6JyW4xsL6gqv46XDPwKPaahifgXXwjA5RSJW6Cgpy2XJvu0cMceuX17LxCPjtNcoSjhrTt7CUz43pqSmSmB3AlmvPUQ99dBiey7QeqppkhNUvzeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HsKORw1W; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HsKORw1W"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 288372540227;
	Fri, 22 Nov 2024 03:29:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 22 Nov 2024 03:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732264174; x=
	1732350574; bh=eKOE7xzC5eVtJUnOJESi3z49zp3MRSIq0SU4mfjjDi4=; b=H
	sKORw1W6Ffp/h3RLEB8X/W/4CE4lMzcTqSvCBzsHso9mmhgd7/0RddtIn1q1J5ZM
	eRcZEyVmUAz909en2eB/tTf2ArsBmvmuYUbL9i1gwq97/JZ7gAcFsOrT7pgD8em7
	nR6fCT8dM2qrlz6RmWDlByMjQlEgzc3186p4Gv1YxfaRt0CZFGtjCEkyASyrkH4q
	7u/Mwi80SH48pyM0QXEb8TPaRktrm8OvXburRfmJBk3MLwLE1VHiShBO0ky/BkE+
	wG1acoKI6IJgGq5uLm+Hi14sUbHuPlkp5uAms3ER26idpQpzHKpHPH7lSwcNoe8+
	XXyOZXfwSe+PMjMhkc4AA==
X-ME-Sender: <xms:7UBAZ8GGHSx-5-y1OPZ0DHLQ_ea_Ou7-PnASXX3O6gqXpK3LEnBOPg>
    <xme:7UBAZ1XihS8-RuKCD8HJAK1LUJulIDc1aDzb_hPQ1fQ3TwfuUxUPHl6smgG5lsXCP
    4cEOCYrtSy8bb6lUQ>
X-ME-Received: <xmr:7UBAZ2IUFtlW0cjmemwLSSGCWK4EqqJ2dfABBeZ4erZVOLNkxk2vZW0ZXGlNxV5N2mgp9fThYHgA4DY4LoD6tz8OgsAMlfO2Jdh_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrd
    hkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhihrghnghdr
    thhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghurhhkvgdrlhhisggsvgih
    sehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7UBAZ-El8k_-kvKjW7txsQ5kvEcNxzJQJiJrsIAmiq77rnUyN1ZEzw>
    <xmx:7UBAZyUL0t3hHspSYVMl6nRuSIFYhq6Ku3iKKP6t6r4fFSPAwcvVEg>
    <xmx:7UBAZxOZdAW7lvRRIShenDPq0CNLYkM6VtNtVszeeZfTwyACYq2p9A>
    <xmx:7UBAZ53QTR5t6-b4tNPYZMvZqaEDQDwNW3axctsPXf5OSrqgwAxyHQ>
    <xmx:7kBAZ0IebonmgoNnEMl4fiPjjT996PjVYzB0sMz9eoBUjX4VkW16tQw3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 03:29:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  Jonathan Tan
 <jonathantanmy@google.com>,  Burke Libbey <burke.libbey@shopify.com>,
  git@vger.kernel.org
Subject: Re: [External] Re: git-blame extremely slow in partial clones due
 to serial object fetching
In-Reply-To: <972d0904-650b-4161-a13c-e3081d55a212@gmail.com> (Shubham
	Kanodia's message of "Fri, 22 Nov 2024 09:02:08 +0530")
References: <20241120185228.3204236-1-jonathantanmy@google.com>
	<xmqqikshikgz.fsf@gitster.g>
	<CAG1j3zEEN5EJwTsM3q87gCSqXG4+=DZVvcQdDhoj5Epe-S0nPw@mail.gmail.com>
	<972d0904-650b-4161-a13c-e3081d55a212@gmail.com>
Date: Fri, 22 Nov 2024 17:29:31 +0900
Message-ID: <xmqqv7wf8ydw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> Junio — would it make sense to add an option (and config) for `git
> blame` that limits how far back it looks for fetching blobs?

No, I do not think it would.

What would our workaround for the next one when people say "oh, 'git
log -p' fetches blobs on demand and latency kills me"?  Yet another
such an option only for 'git log'?

