Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92C2673AA
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022482; cv=none; b=McQNCCSurPtULsNzoNC1ngPttvImiAnrHbZ0Ue3pf4/VRT9zVvNWAPNZZ1j5Y/xYzFQEdaXVf7IHrD3FXlzgXj/uVBT8xNWsIuNHUcSmQWTIb52NoLKkH2x1mUfZSkAGQ7Xi4XmMvooLj7zi9UrYqMovnAZm33H0xCJtZC+M+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022482; c=relaxed/simple;
	bh=vD9fzFfJ3eUk7bx3dEqe4WbNsq5w2gBA/zYGrmKWqDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxAKu9BqgurbSm0geDMsYZw0Cb2GSCjlyHj001lV7uuyjxxuz7dx7CUT0y7E7lpDsfQcv05UmIORAvkSr2NydcjYjJWw4k2RF93TuuZSUMppHY7CdaOVD4TNnRQg8orUZ4Mw7vyAbmMGz1VjrX9SGwR4WqWwSaUnhZfz786RSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dbhlErc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEQV+d0y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbhlErc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEQV+d0y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2AAB7A0187;
	Fri, 13 Feb 2026 17:41:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 17:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771022480; x=1771108880; bh=JHmn5w/zWT
	1e11ZHP94FYZ7nO8BXbRVDuSRR+bf17FM=; b=dbhlErc8YyhmJEL8+WaW04XNFQ
	wnm8sn/J7cZsdmuN8Tr2FaDup9U+DlaO1KieC1rGAG82V8Opag0MZDYtMS4k5PwG
	SGpwOfin0L7ZA37ZanVNcqndST4/t3866acA1gEEHBOAz9MAa3mwxpv6WowN1dRp
	izpXYZOKFbZKKK/EWncaDdiRt9QMtdxD0IKOadTyFTRwouORxsLiD+lr2Zxt6VKr
	uel79SbzO1Mga89V5OZCj/wGdWH52Tl9NLKmm7vOj5FD2z9uC3Zvyfitct+VmBV4
	ee64gi0Ntx3JumwVgxZfnD9rs1ViIDVoSlkdaFP21FdxtfH2/CXuGtsxRYaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771022480; x=1771108880; bh=JHmn5w/zWT1e11ZHP94FYZ7nO8BXbRVDuSR
	R+bf17FM=; b=XEQV+d0yiyKb3NCGWxHu3EPDvaC/PSSGbPXHZ+JomPT6lS2yO1G
	qXdp8X6hbfOni0Gx6pJU6N26y6zXfPLapfTJVR43UVpJnVObyDSbgH81o5C9a1wP
	ZEERk6zXGm6ouOISKGRKkVi+Vyx//PBYDHyXSdmbmXDbrKXqb9V4nLo8dqr6AQRW
	PgkCwq0lPB8vqejBtRGdZu2LF/+5BpWZA3N7VLGH3aMeMdkAGncuXIGIF9zT0Gdo
	rOe5n9tY88ljeaMDdoGsbZofu/bfowk209RefVEy0eh75WrEuRf24QhviKAxZQaM
	UBlJIGAYuDNRGjD5q4THMv4jxvhQTnkIRyw==
X-ME-Sender: <xms:kKiPaYNuByImTMP1i_2zUFyznb_4uFFiE15grMqPTQ8ZsqmKTuRdZw>
    <xme:kKiPaWa3CVc7JGX_S6fmHLU9gmz3eIBX3xYvhG8YJkEBGLHmKYYLq4mTu8xt0lHSA
    lRWW0WfYZS6ormH8Q2W97yD7PvLxZDxcRY6TIKGYOKUCv0ELrXNRQ>
X-ME-Received: <xmr:kKiPacrCboQBTMFdCK18DrhTRhOq5oXTWWICTHhIyFLiODD40Gq362EDKFsXvzENYjmb4jFo-BejDrXHtqQujA63d6sVk8y01Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhrvghgohhrsegthhhkphhnthdruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kKiPaabvLI1AHu7kBwoiNFldUm606R-c6LmyFSnDen2MdL9SQ2od_Q>
    <xmx:kKiPaUSp2saSf574LgJf51RIcmkx2nYY13fZpl4EkD0tm_nx-6xNPg>
    <xmx:kKiPaR6rbixUMK3EsSknHf6ok3mNTPj_iXGFRJJkmcwf__jfPENyMQ>
    <xmx:kKiPaZzZVorpAcBHodxi38dPiKnz8ndCYQEOfb8DFSOOAR0mZTuKMg>
    <xmx:kKiPafGOyRe5A9Yh_yKlkFbHSVduCqwTIk6fqFa7DQG592NgtNDRMxAp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 17:41:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: gregor@chkpnt.de
Cc: git@vger.kernel.org
Subject: Re: Question: --since date parsing uses current time instead of
 midnight - by design?
In-Reply-To: <e5904a7b-c146-4c36-8b87-c5c508e14cca@chkpnt.de>
	(gregor@chkpnt.de's message of "Fri, 13 Feb 2026 22:09:29 +0100")
References: <e5904a7b-c146-4c36-8b87-c5c508e14cca@chkpnt.de>
Date: Fri, 13 Feb 2026 14:41:18 -0800
Message-ID: <xmqq8qcwjmgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

gregor@chkpnt.de writes:

> Hello,
>
> I've just noticed how git log --since=<date> interprets dates without 
> explicit times, and I found the behavior seems potentially unintended. 
> I'd like to understand if this is by design or a bug.

Looks like it is very much designed, ...

https://lore.kernel.org/git/Pine.LNX.4.64.0511171505080.13959@g5.osdl.org/

... at least to me.
