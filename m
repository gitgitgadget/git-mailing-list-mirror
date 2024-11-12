Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C00205AD9
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451269; cv=none; b=Wp9SHIgx+PpaHHGtMX16rHUbk8tGD0y6D4p1CCwLxNd7F8qovr06L/E9dA6ZxOH98snOnklaTgiCweDP0YUB9mJu2n0rOGdGhU5Te88lEm/ecryY6OjCVtqWsFlrH+zMylVMgSpi2d5Yu1+aOTd67RCz2i4wSNnn2oKPwjx0aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451269; c=relaxed/simple;
	bh=xGJTJScrjExg7u/kwW9fkjF4bRg0fquKZsB2ND2RxGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=czjsW4x6zFufwftN2d/z3kzrLdLPLFFIORlpPhH3nZRA0tkXvevwOPdOBtGEfIzvsKMatQx4wU0yprOpHY4xgJbAKeQZNGwWh8VjQ8tZedFmaHUmKJxecHmMttmMzk+SXcNnQLuVn9xlI2N+Kox22PwegsCypRrFjZqdfY0zBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhzeV78y; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhzeV78y"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D13E625401D0;
	Tue, 12 Nov 2024 17:41:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 17:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731451264; x=
	1731537664; bh=Xu0TMqL3r7UV/U8cwzS6dEYJgMplAMmpRaIm2Z2xlTw=; b=B
	hzeV78y6wv+9HJSOZZTk6sIVQkb3d+1ZPdYnOm9h7zzxxkS4/kIzm4vHC9dv+bxg
	/augb3Hyzsp29gNxgxEI8VaIWE8jgZdA0BBfcXocO/YM7EV/CbsPH+dvEw1LOdY9
	IUHjbTaNe82EZ+XPNK4Sl8v2nj2rLeieg4paDStou5U3XlWmmFFodrKoxRgrK1/I
	XNIwGlI1KZfVSBhPOq9LSktO8mWLGxaf/LEZQsEottoAiljEJ+XcoTkb3MwQgDhc
	YqRhToiXOALVx3g1d+axdWN5OIjnr8V/5GHZQTWhrK1Plt9VIjR6zewHuKYik8U3
	qjumytwa/vJf06jp69FyQ==
X-ME-Sender: <xms:gNkzZxuoSftVI9Aju1p711HGA0SnkdlXUJw-fH7BWvW29WeF03z1Ow>
    <xme:gNkzZ6fxPtasLD977da4o1AODVVjV3obhpJfpiQrcvC-TZJsg0WDgUu6nRukiZ3n1
    ke0X86dSfkhJys9lw>
X-ME-Received: <xmr:gNkzZ0xGPVXxNGllJPPxb5LcjNYnSkEbogQpfGKqTvkHB4BI3dRPO1octLXRXVaiy0YCkjDdlMx_XZHNyXMj4xweWFUqYr6Lqv-x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfeh
    veehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvggrnhdqnhhovghlrdgrvh
    hilhgrsehstggrnhhtvggthhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gNkzZ4OiMlP50_bvpxHz3YMwPUuTkFSjhf1zvDGAWDfNdHS6hhU0Gg>
    <xmx:gNkzZx-omJHqdS39FkUPW3fT5wTb93ZWokjvTUZvMysZGlZbGIw0wg>
    <xmx:gNkzZ4ULhoRbe-0ueRIm8M04xYjl86KVnNa9ONoJZco0vLxwR6TXyA>
    <xmx:gNkzZyf3pUItpl01bkJRrYgJFDbg6Q-N24RSrAH8eOJIV52rag4IMQ>
    <xmx:gNkzZ9ajevJYLbty3NHZc2osd_6h-Qm_kJfQu7A7PEvruvI3tlEVrlKO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 17:41:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jean-noel.avila@scantech.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: git-add.txt: convert to new style convention
In-Reply-To: <0882542f-8424-4dfc-8358-f5c982aafbd4@scantech.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila"'s message of "Tue, 12 Nov 2024 10:25:10 +0100")
References: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
	<xmqqserx8ewu.fsf@gitster.g>
	<0882542f-8424-4dfc-8358-f5c982aafbd4@scantech.com>
Date: Wed, 13 Nov 2024 07:41:02 +0900
Message-ID: <xmqqpln03wjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jean-noel.avila@scantech.com> writes:

>> This does slightly more than converting to new style, though,
>> doesn't it?  Is it so annoying to see a link that points at the same
>> page you are reading right now to warrant duplicating some docs with
>> conditional inclusion?
> ...
> This was already performed for git-clone (ebb55042a4) and git-init
> (e7b3a7683c). Should it be separated in a dedicated commit?

My comment came primarily as a reaction to seeing this change that
was not part of what the proposed log message said.  As you say, as
a separate and orthogonal thing, we could make it a separate commit.
But it also is perfectly fine if the log message explained that we
are doing this independent change "while we are at it".

Thanks.
