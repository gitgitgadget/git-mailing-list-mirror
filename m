Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDF2FC00D
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397329; cv=none; b=PHMuP+SWyViOrzkh5BT/gpvcx4j3KwJIFIaEKDlvuuTOOcvti/Lng6JRlgXiwVPF4k4NcQZfKv6nsqqqZDG1AMshv8kuEaIt2BCqSVaX5TyR+pS+EHyxK3s50qS6YzRXKqN98xD6l0kVkKXTWFE0B0+aIW8MO4AXMrQZCXZpSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397329; c=relaxed/simple;
	bh=ovlHA/5W6mnzv+ADRIxoQikj3SekkPlppK7eZqXw+GQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FZmIikPAupJ/bMF6Wm8q+BSOOE6hDOI5jc7a50/5srdUYZARY9Xb+RSH5gClgSTYbV9OXZAOqk3MXLlL6YKa9YTnw8lpt6Vpd9R4s2DAi1+qbbsDBjBJmdrcvg1jEgJ9aiRdHwesGjUGURQlmHQO0v2nPn8aZC+Z4CikChIfnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AxQIW412; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B7kfp3CT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AxQIW412";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7kfp3CT"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DFF07A0162;
	Thu,  2 Oct 2025 05:28:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 05:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759397326;
	 x=1759483726; bh=ovlHA/5W6mnzv+ADRIxoQikj3SekkPlppK7eZqXw+GQ=; b=
	AxQIW412naoOMIS70jKt7kYRtCNKsCiLAhOiXBlkOdCRagkAfynEAyZgmnJFnBiF
	O1k6Ooqoq6j+J7O3fbcux7iYuuraghLMNHgaq2tthKaJgEGljV8Ovy27WqjiZB+v
	f7zOhWCLBcDdYAALAaRcLkXdxtkeqNGIYOurvAEL6YXXmF2hyXXWbjuFgbNmGnl1
	CbNyXqIkOWitl8hfnZE8T+9A218jZsfkSsR+msEJ6MFgXWWyzQ2EzniElUpglMuO
	OjXcDYTEcsd8G2w0tGF9STaIDks4L/drvV9d2+XJ0kMzdQ+BuTdI91XjUQnMUfml
	nSOB8mKSZuMN3OEzVMFaLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759397326; x=
	1759483726; bh=ovlHA/5W6mnzv+ADRIxoQikj3SekkPlppK7eZqXw+GQ=; b=B
	7kfp3CT9zCQFPw5PgTiaamoTQJYH0x2nRph5M+5vijBsOfaMFkF37aMctTQBF9Av
	zI9C8ihZIPALotEqjS0J9FLmguFYBj/2DgrF2KgfeaMtKs9jF6oKETTOfn/xPeuf
	c1ulxl134PNLQBKDjkfasIiEGN9209+EFsV4iwPzHoqjo5swjpOGKfDv7wpZUaBn
	kjnb2ZC1kQyyabmEkMI5oyKL84AVE+WWN2ZnStYQsoHqfdpHQZXQ1NT6pVrUrC1Z
	s7ASCzYtIM+0n0cVitSgn87Ds0+fHXUK6KQplXGjexjT9di79+w7XuaLJ+bAnaya
	7y0FpJjEtPumgu9PDubMg==
X-ME-Sender: <xms:zkXeaHW5mGiWg-f3_gvXcrIk5gwS719BFeLM72SK6MOVqUcSmAncxKA>
    <xme:zkXeaKboEAkwx1rLxXt9qKT5OQEsIE9cYfzBaynn6WXE3iNk-jRUHy9ZkOorqwt_v
    tLo2UwFyJbAGdZma2BRkXLMKOThZaiJpTmadGx2WPN4ybV6Oh_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zkXeaKoPCiUxlKg-yQZ9dF3wlkwA9f32foORBHiAJW-bZ2g3UV8vow>
    <xmx:zkXeaCqF_CA2xwGfxMYL62p8FL9OXcRTtynXXS0Kt7U99RyQXmvY4g>
    <xmx:zkXeaF39HkJkA2CQzZldb2PFvNpcflmC7UZdVK5CUgivh0151jfDXw>
    <xmx:zkXeaIFsRxcUuHTJb-VLDwLH_3mvYjlwWuWXMNOY7Z081LeYTKrNfw>
    <xmx:zkXeaL1YKN59JuYzO1m2JoJZcUDRcbwEjrtXCBVtiKAAB9A0zU0fNkPV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28AD11EA0068; Thu,  2 Oct 2025 05:28:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ax0L5l_T7lmw
Date: Thu, 02 Oct 2025 11:28:23 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <1a19d9c6-f0f2-41d6-9969-63f6425b7340@app.fastmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
Subject: Re: [PATCH v4 10/12] add-patch: add support for in-memory index patching
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 1, 2025, at 17:57, Patrick Steinhardt wrote:
> With `run_add_p()` callers have the ability to apply changes from a
> specific revision to a repository's index. This infra supports several
> different modes, like for example applying changes to the index,
> worktree or both.

s/worktree/working tree/ ?

>
>[snip]
