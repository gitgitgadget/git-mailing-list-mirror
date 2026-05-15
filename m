Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D831960B
	for <git@vger.kernel.org>; Fri, 15 May 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888596; cv=none; b=rsFhJtxkmhCT0cUxEJQTfw6dFMC7eWdNSWWwBw57vZS1EauYn1NHka+ATWQ8O4aMW3krFd8H+50LnoK3BOfy91Bv7t84hN859YhKz2yTc1KpqsdttSvwkpuX5+8ULTS/mBknfwRr1W0feemhzC8TFbPFEyP6DlCNnRoT3pVPAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888596; c=relaxed/simple;
	bh=vIbuLb0IR1pHVzi0E2PfqKSL59Hp7mrQZ4i8HR4F130=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c1YaPzMmH5tiI+gIBiF0bQTNravu7ZQPJNmSixR/WLbvXtrt1CTnxxL8eBFlqUsnypSJMBX0W4w0TEGrp8VPRF/E3K4MY6jfNpfm0vajTGW8vfrHL6jKTu6DitqhbS0rzDmn6t4H8XhWAQwijtzg7C7SKEqhabsNFOYeXGxpiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rVzLa6k/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClpuwDc5; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rVzLa6k/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClpuwDc5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B118F7A0071;
	Fri, 15 May 2026 19:43:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 19:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1778888593; x=1778974993; bh=ZZ9rhaM8HdMbGTUgaXhS5WXtdPGPZ79A
	OOM3EJNrUCI=; b=rVzLa6k/JMMJZWCbX8F/W7J435+njh2xO7Y6lKX6NEZBuRlq
	nm1Z8neYl4jNDiVk1xqHmQqDO/VW0dJwhkDXPe01qxr0ZJ2yfQLO9pg3/Hz+frQ+
	mxVbZ6qxIcL0aYzQUhP+ArKoy2+KwRcBSrRFaYkCePYTQer1I2z6u3nf9x44I+FA
	xvd+BhF11n2ruDED1AubhuXK4KKQ/rW26HY5S6UG7zvHs8ytJfJ4f/Wm+j/Uo6OO
	TDsCMr6bSyiK1CFQ3V1TbNIH835hkoo0fqvNmRW1TeQCCDMgkgsH+5dkaKpCscow
	sJHzyyLQ9HBGvHBzPEIDljNlL6fwSvVRr9CDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778888593; x=
	1778974993; bh=ZZ9rhaM8HdMbGTUgaXhS5WXtdPGPZ79AOOM3EJNrUCI=; b=C
	lpuwDc54LNI8YgNuYRmpD52iEUFMmEXJu6of5dmVynqjkRWp8jsi/2lfior7nABr
	wMMPsK+HI0UE9kMO2zfNdXhRWRiTtQND6N5ed2hZG8/jmLBIrsj4JOME58Vj9U64
	RbTsztE62sp9fc5zV2IBomp5sXBCd0/sA3gwgfqIuguTFEz7020wFpf/7nnMmty3
	pP1LSiO4a+EJooMyM5o6EY7J0ZrhF78E9bwTZJFXJG2DYj1hCF/LIjRsZfJSLTrP
	SZbR/Kc4VdWnW3sRnncHM+3wPDMF0YspkElfxQ1HOVBQ0aez+6UxNLOURJ/8UTFZ
	dYRJuuCTHYz56CZGebTqQ==
X-ME-Sender: <xms:ka8Haq6tiuH3ULKB0in4dcqACYFAMENkxMTwkZ0jf9B8cGNRG7uKQA>
    <xme:ka8Hap7mEXlefDjxZg0473LMbAaRDDu5CSniK6slvCXo-fFp6wnz-GKYULsnxxJnh
    tyy3PDPw0b4VvK7GIm8j_ZRN4xGoZUaAeW0lmAEll-cSE4E0xYOVQ>
X-ME-Received: <xmr:ka8HanEbwnP026ASYBOceUnI3_cNdDyN80Fk2HDy7XWbZ8Sy8creJJq5UQcPbGv_pfgTycR3cTBobSOjfTGITaPnn7ymTtcX8VYG3U69uWxX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepiedtffeikeegleeltdelleegffeiueehhf
    ehvdettdejkedtvdffueeigeevieetnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ka8HaiR-UyCpQnkFWUZSJuYHELE4oIkUdrW7W63ThCRqXkI_OQxUzA>
    <xmx:ka8HaguL1zHn2WRWbTFfmF0mVQMX8XrFrkRUDUcCqRZ0KhODTpkiNA>
    <xmx:ka8HahwBbjVjfpzMi3wchU8shmJTPWqwSyOHGhYHrDxXVzmUBhUlNg>
    <xmx:ka8Haq5TOr6NUhMsjSqf-j7X-fcea0TEo8OrFkvbj3Dlwoxh0mJPng>
    <xmx:ka8HauQq3jjd6jsa8pPUAPQx6OeXY5Ub8tXgfnEjFNTWcyewTRukqzcE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 19:43:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: UBSan failing on expensive test(s)
Date: Sat, 16 May 2026 08:43:07 +0900
Message-ID: <871pfcdyt0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This started happening on 'next' that runs EXPENSIVE tests thanks to
Dscho's recent updates to enable them in CI.

https://github.com/git/git/actions/runs/25896439353/job/76110441841#step:10:2172

It claims that """

    commit.c:1574:6: runtime error: signed integer overflow:
    -2147483648 - 1 cannot be represented in type 'int'

""".

Another is related in the sense that it used to be hidden behind
EXPENSIVE prerequisite, but is probably unrelated.

https://github.com/git/git/actions/runs/25896439353/job/76110441842#step:10:156

