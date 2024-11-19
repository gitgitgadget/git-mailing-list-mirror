Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0776DDAB
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975417; cv=none; b=QobWhXQ0QkLBrczpyY2QXlg3KhLx7RSgXZ6eJTKp8O57ni5D3Fq85wCEyn2gQ4IUxYeSCeoGR81Y+NxLWjRE2DiDz9riuJGxsDGsrhl9xtz6WPGFnUxLEI/E2p5BXWQEVrlO1aPpr4qiU2xCy6fSfSny8e3ZbU4LNkCXdodDw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975417; c=relaxed/simple;
	bh=5+Kvvk5fZV/8tXQNt1XXsGBqAfuZDuq8xt3Nzaj1vDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCBRoR7SPlltQXCf8sgtDpHQ+K9H/pNJGgv/LEnH+VjOWK3PIuR9pogurH2fPc4FuqtSJFMA+uoJDkFUVwBoGx7gBwCIHtfpo3FdgZBucO+F2M4mUH6Dr8LQEA9+daovLG8NT0lUL6MrBOexVLsYpRgI43s0oLLlvgkA+JGP/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPbs0h40; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPbs0h40"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F6D12540162;
	Mon, 18 Nov 2024 19:16:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 Nov 2024 19:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731975413; x=
	1732061813; bh=QZ0qeWaNH1xg0UF7rp2rsn/c3Fx5IcitE2BnEotHgAc=; b=g
	Pbs0h40RreqlxSfYoTcgvHgPoD3JaU0LjbAIL2XiN//XDpL+PuaiAW6bF8DanWZM
	JWyvlNuG7sTNx+4/ustohT7EGaKx06vpZZXW6J68i2L1yYDF0RqJYCHgrMPLdQ4w
	xdQhQONQRbDb5yodgeaFADY0Qq/3txXQmox7Rri5pDWCtEKXbWO9TxTr9M+c4ou8
	SG53psfw1lantop5immG/CaJ3ZfvJ7Dx84fLzc6Y8NGDr5b7LVE5LPcnxDu5m2xR
	L9Jua2iGci88BeB749incZ86cY1OpelfTqnoN09MpOLqhZBg+X9ND3niqxH4wp1H
	pZGCM6hRvdxXvYnDUwtYQ==
X-ME-Sender: <xms:9Ng7Z_LoCxIj-BVOgCJWwzLW-pz7IhYi8xSC_-H0YwWPdDRC_fZgmA>
    <xme:9Ng7ZzK3aUW3KwWkghyJ6jyVoWWJgahbRdb1nySu2KKXW4h2kW4JTkoVZkUUaWT7W
    YZx-Y7IOr_i512iXQ>
X-ME-Received: <xmr:9Ng7Z3tEEr6aL92_3LK21PidEBUM9VjkRZX3VcgDWuNoN67Ya3pAXSqZm0L7xlspMRYObBTGK3C4l-aqLuHcASqrwlLBp3dqw-Ax>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgf
    dtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedtgfehtdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvrhhitgdrphgvihhjihgrnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhn
    figrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhi
    esghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:9Ng7Z4YWlWf8wNY8xdENf8r5mbYeDy9KT27GqEw0TI97BoU8qMJldA>
    <xmx:9Ng7Z2a_gkC2HXh4S91nsW2dPwqO14UpQSpSv3WlZ-VTMQsESKX2yg>
    <xmx:9Ng7Z8C-j1ZsbsJw2bCzXnVZGOzXjRLxi3W7quAJpsjKNa8PsgKUaA>
    <xmx:9Ng7Z0ZJMsw8hX886YTxRv5kYs_ON4MrwqLAFzANSmKUuGC27AP3Vw>
    <xmx:9dg7Z8nk1AhxSliK8GubQsw2l9Ge7ZGMVmMxJ026e3oyVSLk9B6dtgCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 19:16:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
	(Peijian Ju's message of "Mon, 18 Nov 2024 11:28:23 -0500")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241108162441.50736-1-eric.peijian@gmail.com>
	<xmqq4j4egza6.fsf@gitster.g>
	<CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
Date: Tue, 19 Nov 2024 09:16:50 +0900
Message-ID: <xmqqplmshybx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Peijian Ju <eric.peijian@gmail.com> writes:

> While the “fetch and locally inspect” approach is an option, it would
> undermines the purpose of the feature, as highlighted by Christian’s
> partial clone and sparse checkout example. This feature is
> specifically designed to provide information without requiring the
> objects to be fetched, making such an alternative counterproductive.

Thanks, then wouldn't it make more sense to say, because support for
new protocol capabilities on the server side would have to happen at
a lot fewer places than the clients, we only work when the necessary
protocol extension support is available, without any "fetch and
locally inspect" fallback?

The above is after reading your "cons" here of the fallback.

> Cons:
> - Implementing a quarantine mechanism seems like a separate feature.
> This patch series already introduces a number of changes, and
> including the quarantine mechanism might make it too extensive.

Not an excuse to introduce incomplete changes that are not
sufficient to be useful, though.

> - Based on Mr. Patrick Steinhardt’s comment at [1], since
> remote-object-info operates only on protocol v2, adding a quarantine
> mechanism may lead to differing client-side behavior depending on the
> protocol, which could complicate the feature’s consistency.

Not doing quarantine would give even _more_ different client-side
behaviour, though.  When talking with a server with v2, you'll not
see a cruft object left locally, but with older servers, you'll see
crufts left behind.  After a failed remote-object-info call, you can
do an object-info to figure out what you needed to learn about the
object, but only after the failed remote-object-info was against an
older server.

So, I do not see it as a reason against putting temporary objects
into quarantine.

Not that I consider it important to give the same client-side
behaviour when talking with older and newer servers, though.  It is
natural for a new feature to be available only with versions of Git
that supports the feature, after all.

And if we throw that away as a goal, it starts to make more sense
not to add "fetch and locally inspect" anywhere.
