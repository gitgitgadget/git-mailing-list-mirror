Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2252187FE0
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606125; cv=none; b=AeT2XclVRKLf+hM9hMn/2bQFObn0tiO3jPyB7xoo/u16NhLQ4pSXIRQjzG/bTc7608QoNn7wEpIa0yyx0cQX8X/Eb26/emJdY9X6OnQn80Hm2PNdxJBVhd1pur0BkFPrVLPkgsjSYYcj7qD6B5sfVUvxjM6hcL57T1mnS/Z65EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606125; c=relaxed/simple;
	bh=aef5BKz9+EwcNEkTzX56GHENonNmmixElw3fwZTDSfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=koFQsx0zyXOSsOlxb06WpZhzHpldTYka55wHxo/eo0V+H0trjDuFnwL4F2Awij5++XVWs+9qHGBHCh2/0WJ32W5UQtaEY99aw2ItORdtIHh+jIjjrGKOjaNqMUSXYSIT5BKs3Ajcb754/ppz2/n1GlYeVpJYlyhiO4ScMFqwXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cr9zZ5xj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cr9zZ5xj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB77311401F2;
	Tue, 26 Nov 2024 02:28:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 26 Nov 2024 02:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732606122; x=1732692522; bh=LZ4w72HuLtw0vcomInB3Tbsrw0bOi7WM9SQ
	buR/vXRQ=; b=Cr9zZ5xjZs1hXRdBIoo1H/RD5iyMYisawCHQ2F0gcBMM52M8KAw
	WyNwOZQWBWKBe2zWCPS9A/BDlcFGcvTU3chUg85lvSkbWkM4s481kAbBYhpKPIpi
	Xb4jED0iVnl7HRscx0/Qu+xHMbhLeKuubpUYjjxqy1K4/09v4ps6EOMueYyI3wIn
	V5C0XZLR0DSIKxV49mpA6sS35fRDul2Gk3ljHjTBeIxPVSefPvANmn7Hgr0Fpbg9
	04OGPp6l/6Wzkz6J4wVLhCZRyVq3vjnWQyuSsYKzHk6dH2Oii1GdDFTfLQKw7MqS
	Fd6b2NT/7CgwBdiNkp3jvXXPdGCl1lMINKQ==
X-ME-Sender: <xms:qnhFZ2tabQ929W6h3FKIKOGdhV7tWO0J3VXBwJi2o2XiI7qn1_7fDQ>
    <xme:qnhFZ7e9ZT1ZQc-0AigQRLdOrio7hPFnZotSpHn7S_MZcjvU8cro_AFrg2I3QHM3f
    LyCf6Bjh0odPrzWAw>
X-ME-Received: <xmr:qnhFZxyJ2BpDGmuZthhJJfSr5-0Lmdy_NTIZPCqLB5WS5LmjPN9sZSDDX4C-rqcKRzBinTqRJVFqN-NPU7ZPshEhj9nU_9AhspHpezw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:qnhFZxP1FOyvuEoECTfqkH0Riz5l8rLBz73qLKV0tRss4Iq46f1cYA>
    <xmx:qnhFZ28v4_yb2tcrE407ziE_s7JvDFtRBMc3AIGtsJUMoIVBEcyMMQ>
    <xmx:qnhFZ5WIk0Z-20ZDOtGp7hHqwJCZAAUGn-ZRnffgfEmQWsy61KJlqQ>
    <xmx:qnhFZ_eWgCuKmPXXhCu9ESQz5S5TTJ1MnykiiJ9L_T-0hQW4bATWlg>
    <xmx:qnhFZ6Zt-wizVL-kpiCxGFAsThytnEUm_S68Nhkmj-PlwUdzQU44hOJ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:28:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 0/1] Restore the ability to clone repositories owned by
 another user
In-Reply-To: <20241115005404.3747302-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 15 Nov 2024 00:54:03 +0000")
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
Date: Tue, 26 Nov 2024 16:28:40 +0900
Message-ID: <xmqqed2yzc5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The breakage this fixes was originally meant as an extra "security"
thing that turned out to have a larger blast radius than originally
intended.  I was hoping that many many folks thank us for reversing
the course, but unfortunately we didn't hear much about this topic.

Unless there are strong objections, I'll mark the topic for 'next'
soonish.

Thanks.
