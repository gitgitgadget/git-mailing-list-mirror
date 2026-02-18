Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7F1F419A
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771394425; cv=none; b=oF6oy4lk0UeOCylVRju4LXPNYm1B7im/tpvL6b9Pzr1G/oBdMQeUECTzGDOOzUaU9lqsx5CEH50CzBe9ld4tCw7vy8sPCF7YSl1IfXJmvpH2RplSTx85mndR/37ttN208KMM5Zj9anF9dJeR5kz/xMPl9No3ZhCKZGdhUfkyonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771394425; c=relaxed/simple;
	bh=IW7jKWhKl4tfNYnVlmghiXXANKyxtPgRPcAOC5nccRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HFWypp4f733UwIs/rh6bNVpZrfKiFIFvawglgdSOH+DiqG4HN7jPwJAmiZeIv+Q1MkOB+dbsNjuY/dWXC6pUsI1h5H0/AJM4wF77owlKuGfgzmCR5ZHCr6zDwMFsxnn6sNa3G+w0wucO628HXxiNvd2YYjdz+yXyyyxdICZEDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pxw4FpMJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YN+5xPOP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pxw4FpMJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YN+5xPOP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8E207A0111;
	Wed, 18 Feb 2026 01:00:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 18 Feb 2026 01:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771394422; x=1771480822; bh=k6itpVEZxw
	b4rtZoOs+GObjj7xQcDTOZJpwIkEYNaAA=; b=pxw4FpMJUJwmS0D2zkEj/5i7lW
	j1saRaBZVteLuLZg5h9d9jxw+hFeSpRtF/SArf9Fsp6PzGaB5VIdYjgoYJoNbt9J
	bcpAidT3YBpzzvOioGWTqX797X4kTWOuuJBjZu8Yf2fZrHY+tiTRaZn3XL34K365
	nxuGJ+Hp8kUKX9ajHYk/P635hElYJVmXPEao/rM1KSuFRCtxfFeFn8Z99XtMYTpx
	wCNi0VFvFecQXxaLBlUor3g6OL/2ZTOe98H5Pg3i6MTeVJh1uNhIYqd3khdPEpa8
	XG7G6s93h4Sf18S4vNeaT87Cu05Xnnt5xrle8YhaXpSRhk+KKSz51UrcVECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771394422; x=1771480822; bh=k6itpVEZxwb4rtZoOs+GObjj7xQcDTOZJpw
	IkEYNaAA=; b=YN+5xPOP4TYB8N3+N+J9M3gnatAJZZImNNyaIUL43yddTjXNzjw
	p8H8c3Vz8w5/2QSUBmusy6Rb8aJ3BI9F1vE1+AAf1GcTyzgaQ561BdBczlyDtqM0
	BO47skwsa4dfGjyvfbyJKs5O1e0VisLXgMlNQQiNDDWNqlsmkIZiWz4oPROx/6Yw
	HbNL1Nqiej8VNUpg3E3VAW5W6IjzSOHtzH3pfPySMJRO6ZjA1D2dM83hUp8DyOQB
	uleazh640mX7fgnTV0h3tSAZGPwvXcUTEWTPingyyEQp2p4Iu8v+lxmsJl6j7poq
	3z4/Ggs0kUx3UIobdqFm7OMyzXYmWSY6kpQ==
X-ME-Sender: <xms:dlWVaXe360I1yWcuxHX3ZObdEN2OOCR4ZA6vdQ7KkA5iimb1eW97vQ>
    <xme:dlWVaUr_t0ro3IqbPtYeQh_ZeUT8Xuwjip694cWOgxiL8pwGJPDrFcyA8OQIPClzP
    LI4OO4O8ZI3EATel18pztzwKihZpOVNMPNFJwSP28EAIBs3B_oHgDg>
X-ME-Received: <xmr:dlWVad42atiJnVdN8pf6vHmFsJKezGbKAbc6AfbxILL48uwqCpotNLaFALOw5-rvoeE_av9hQOMvRWg2-XOnOB9QHjfqf3DNfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehloh
    hrvghniidrlhgvuhhtghgvsgesphhoshhtvghordgvuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:dlWVaSpU95O0Dgf3vjjsRcwO8jK-I-FBQFhz-vW8rEd0J20URQRQWA>
    <xmx:dlWVaXgNBqM_Ea4hhx_fBWMCbcoKxcRDIXKXJ_zsIfobdmPXGHf4qQ>
    <xmx:dlWVaUIN314ZPJb-OaQtIwmrdZvUTrLLddT4rZi2TRZgPHCAFBLWfw>
    <xmx:dlWVafD6jK0oRdRe3eL4FdJNEt0He2iIYh1Y2sQBr06wTqvA_vKkTg>
    <xmx:dlWVaR4YyQ0Lk5N15XNbzlt3GgOS8G26XhauVMhv0aTIlFtlRLppKnJl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 01:00:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Cc: git@vger.kernel.org
Subject: Re: Push Certificates: Privacy Concerns Regarding the "pushee" Header
In-Reply-To: <19c5dd32-6752-43fa-a664-5e6d29d9e681@posteo.eu> (Lorenz
	Leutgeb's message of "Tue, 17 Feb 2026 20:31:25 +0000")
References: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu>
	<xmqqldgrb1ha.fsf@gitster.g>
	<19c5dd32-6752-43fa-a664-5e6d29d9e681@posteo.eu>
Date: Tue, 17 Feb 2026 22:00:20 -0800
Message-ID: <xmqqo6lm8ubv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenz Leutgeb <lorenz.leutgeb@posteo.eu> writes:

> Now, in the context of the application, the global identifier of the 
> repository across the network, and thus the pushee that I would like to 
> see, is `example://foo`.  The path `home/lorenz.example/storage/foo` is 
> merely a local name for it, like a cached copy if you will.

"The repo appears as X to me, but it is known as Y to others" is an
issue that already exists.  "git pull" records from which repository
the changes were merged but it uses the repository from the point of
the view of the user who ran "git pull", for example.  While one of
my public repositories are known as https://github.com/gitster/git",
the URL I use to push there may be "git@github.com:gitster/git.git",
so if they were recording push certificates, the latter would be the
pushee in them, but that is not a URL random people can normally use
to clone from.
