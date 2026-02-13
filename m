Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF92DB79C
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003253; cv=none; b=mx1IE+HEDhnqbeu04X/JmJ5+9ESuTUOmFCGxR1UBWwJLWsocniaJ1TV9OoMIHrrOkcZeBqLSmkqKZ17wtvDOaJWVoCX3Lj16qHfWPVLvTteDh2lyaPghQicvfbDA3+a+Bw3UQPAYc1IX7mhUQh9sq5RMWaR9TgewPG1PTo5UAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003253; c=relaxed/simple;
	bh=U2vD7wxAzuPwMiWcaecaZIIT3xiUxNOCPYXlxYMSDnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unVjxM8qCNuMlUJZCJIZjm7s+cVlDAzmMoN/iqF/4Cr48RueP8K0tJHdYoyM6xrXIOntGzQdKIg5rg4dh75dn1gTP3ZxYPunDDuot0x5mFIf0s+Hnd2RB8gApm2y6vJSyFfGRLNYQGPzi7DXCsQki82fTsq+ZLmUCW79MVj5QXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wkp4wGcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hI55wdkY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wkp4wGcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hI55wdkY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF0237A0087;
	Fri, 13 Feb 2026 12:20:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 13 Feb 2026 12:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771003251; x=1771089651; bh=YniMQzvFDV
	NbyNr6fVV9D+wdXM/3jAX8uEVfU+yTz4A=; b=Wkp4wGcKoQFNOOElTferJPIgo9
	JF6HUfg+tPC9ztW+uuplUOzKSi7nRzxyXrVak8077aiHx8NSt9EO/P7E/NRXCBbL
	rOYPv7jJOdferKKkrtidtzRqBWmkQs7nID/nU207rkRGaPDgrJN3yoLpMlzJ82ht
	b0N6Jjyz8qe4WJv2ZY5x79sck+nEzfkmJ5MZgkrneHc9iNvg9QMG2olc5VQAsWIM
	ZcWZ8/gEbzO/pG0kuvAbsE/CPc6FxEIEPmVjT4wMdG9FG7WT32695IakvHxpaqaj
	+jNaKE/Tt0YFB9hU5bZh3Q+2stSEbAZyCPxR40i6mjG/cQK+mvCOt2VOiglQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771003251; x=1771089651; bh=YniMQzvFDVNbyNr6fVV9D+wdXM/3jAX8uEV
	fU+yTz4A=; b=hI55wdkYrlelh2X+D0/og1doGoMEgRsoLpC0BilH2+EDZMgwLqD
	J4Zplam8HiNuiLQtuX6FUaWdZPJ6fj3SUYCCnt8cjSrlLKyvZ/x/wGzStlavq2he
	wTZaiexsGXXjckYwJ4CAEFWOKsNePRrBp8ExgsB5xfch9vt6cqfefmbbmNVKMmkG
	c3ORSv+Mg7SjfQQgYDdGuZwgc2Vv1Zn4S/SozOjfoIGbrTmdUKU+nKg7oCv2KskD
	SfjbFwQpbVXNscVnRzhpMGxqEAIDqQ/E7QnH232NMcM1+G4vd8hAOE5wCTwdVDC8
	D7/RoZClffSqRfR4LrSe4gOq+a9nFJdx2tw==
X-ME-Sender: <xms:c12PaQ43J5z01w_J7qrjSewh0mCsnuA_SpOi8VhcWpFT5CpUiHTAMA>
    <xme:c12PaY7FPwDRUGLyGvT8iS2neHhhasfoCxq1yFC5gpsiKN5SfSvCIRNGNnZfCUHDn
    n7JVaw5EW9jhbZattBSmgRbmcwtK02j8d3GIxfN_HtBi7l4rE-Zxw>
X-ME-Received: <xmr:c12PaUe_dhcx6vqdX3_ID1U-bVK7qrx-aX5VEiNyJkbVlcwk-AQN-Cy2_91Dj6JyZRjGmHa6WdRrV6Iy8nmm1fykjKpL7m-2ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c12PaUBJ_W1vwG8vMk5AILX0LBSAr_lVORUzHgsiW6hvM7F5L5-L5Q>
    <xmx:c12Paf_l6BihjBfuc4-QpyzVbwsaMaeskWqWaWOvhZrpiwnQLs2qLA>
    <xmx:c12PaXJVd1HaQ0tp_qNH89iEYKUp_YEyQ0HfcdVp_5IhvT7W4Ial0A>
    <xmx:c12PaQjhlg8vyPvz5KGsHrJNVytWYo-xC1BCaCI9ou4YyXUVD7QT5w>
    <xmx:c12PaT8koGjGMiAOA-cvqvxHqEJ0_STIPe4OT7hlechGJmY0WFzicXy1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:20:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/5] builtin/history: perform revwalk checks before
 asking for user input
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-1-756ac376e9e5@pks.im>
	(Patrick Steinhardt's message of "Fri, 13 Feb 2026 10:12:47 +0100")
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
	<20260213-b4-pks-history-dry-run-v2-1-756ac376e9e5@pks.im>
Date: Fri, 13 Feb 2026 09:20:49 -0800
Message-ID: <xmqqseb4mufi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Adapt one of the tests that is expected to fail because of this check
> to use false(1) as editor. If the editor had been executed by Git, it
> would fail with the error message "Aborting commit as launching the
> editor failed."

I very much appreciate this new description.  OK, we expect the test
to fail due to the check in question, and ensure that the editor is
not invoked, by looking at the error message and making sure it is
not the abort due to the editor returning false.

