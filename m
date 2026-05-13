Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B6388E6B
	for <git@vger.kernel.org>; Wed, 13 May 2026 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666792; cv=none; b=akj1SHxvTYZkXLzJPUWyf09GeSTNQOuSE+jp+TA2BkjI7xsaIhZcKQlD5m1w0o4ZZdWQQNDI1EqAgtJbMXQoUl+mz0MNMI+QE//KB0FymL7tGjRuJ5mg5+eFM16VGGYDAwWy+lUjUxukYrAd+Prc0fbLp62YqH8yi2JWxA5zGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666792; c=relaxed/simple;
	bh=EMdrQnCunWkO+8PzQ/MBrSkjpEW1zS4zEe+8QteQDhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USECGvx7iSC5ovCjFRFSEFK6jrIP3O+LCnwArlrbEXqkGoKVc9qzRHEEOzoUzVQi6ZisB37Aiqdl2WkNMMCRKZmrnx9eWiySw7kWJro0juFDXw1hpcIp7KtcUOeNrK2d/WQAL06zAePOuYPgvggAijuom2jz3jWGmRyMNGQOT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fgHPFbLX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJan74Mj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fgHPFbLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJan74Mj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 39801EC0260;
	Wed, 13 May 2026 06:06:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 13 May 2026 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778666789; x=1778753189; bh=NMBxsxxJlr
	vlDUXrY22oTfXcf3Na1Tcc4+GlwrtrmDs=; b=fgHPFbLXP+SqReUbox1uFTBj71
	yDVBJC2d9KoIVmd3q7C4RLfmW0TdtzMM/I8QpNzLGfl857rMa549ifh5zhQrlePF
	u4AMEiew6c0fldOYCdLXmwBLrQOiKPBW/SoWYEtfSmPkJsr/g5v7zzKGA2Btss29
	WIxcg835C7Mp1b5njwq6zJxW0YeUTfHRhJAg12x8p2Mabx8HzP34ZxDnk/uglEl4
	ZIbZkEQyUOmV7bw2o5ZBjQOPJC+RViMWErEAGUIfG82Z/v+T4CLPZYpAkLSYy4LZ
	jRLWGMPiYRV2fno4QSNU+Tz20yJPU6rkUrc9p/NlFhgoh8oLu3MK+UDOs/xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778666789; x=1778753189; bh=NMBxsxxJlrvlDUXrY22oTfXcf3Na1Tcc4+G
	lwrtrmDs=; b=OJan74Mj+JcrhSzK/gGpqbJ4nxop+/oZMkCSvRAEJFfuuzZDFSz
	YHT7zZh6jRMIyt/s5Y945WwEoqVLD4priljiFuCcaAkKBgMdm4Xg1pGZFILEiRPO
	6eLib/Z86FLOdTOXp+XGF7SjSmsyKBj5dXXM8uUff3lEVvhY0A0O9dL8qQfBXFEt
	J6uc4k5XgE7r0+st3SlvqAQ4i72nPyN8E6u+h8Ou2s8WM8ZnuFGsb9V0PZw9l070
	+NuhQOaAG7Hz1NS3nyM7GF1bTqa56Bx3HbmjXtn57rhxj4VqwSOJd4GUbot2Y3xt
	38z8HGTr0oqlba76OfhaGylR8Nlkq539mqw==
X-ME-Sender: <xms:JE0EasHI9oeoGFloybUblfU78w37Fj9PZQX676ykKzBu19pQvFH4Ow>
    <xme:JE0EakbbxZqPYL6BfU47N03_byc83ohr0yVJ0P6XY7HylCaZiktwGJi2ZxFsRApH6
    0YyQM-o40IhW-0T9Bs52yabq12LJdKKuMbnqwKbSk2fKUWg-baaCg>
X-ME-Received: <xmr:JE0EasX-UxUA6Y4uxsEMvp9W-UKICkcllp66pLGxAw-B-FqILiwQqjEjLlVnBKmv5K8T3PM6Wm-wGqwm447rBRjwX8ZtSsQaaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtthhiohhnmhihshhtihhq
    uhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JE0EaqmVLbQ-Bj_CGfH7EVmwvj7pI_9HYg0HQpPGLzm9LPi2SAT1dA>
    <xmx:JE0EanAd6VksEq3yJPQSI590mvyeDTUFAP7oapDQ0vDVJnzYvg7LGg>
    <xmx:JE0EapgmrNwzvZ7m9a-kn4I4eU4kXsECCB82xHXH8d-aBJ_WNPsCsQ>
    <xmx:JE0EakxP3IbE1zlGecMPniQQhu71Zo3exGn06FAnPwP6HvU4vx-hBA>
    <xmx:JU0EaopHImysOfXXmYqg8dZ134ycoAgyaIvAo-gAuD4hJL2IC0KIBXIf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 06:06:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jean-Christophe Manciot
 <actionmystique@gmail.com>,  Mikael Magnusson <mikachu@gmail.com>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v3 1/2] builtin/maintenance: fix locking with "--detach"
In-Reply-To: <20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
	(Patrick Steinhardt's message of "Wed, 13 May 2026 09:31:13 +0200")
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
	<20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
Date: Wed, 13 May 2026 19:06:27 +0900
Message-ID: <xmqqy0hnipy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that this is a broader fix, as we now always reassign tempfiles
> when daemonizing. This is a natural consequence of the semantics of
> `daemonize()` though, as it essentially promises to continue running the
> current process in the background.

Exactly.  I do agree that it is the right wy to look at it.  The
process that daemonise creates and leaves in the background is
logically the process that continues to execute the service the
process the user started, and unless the original process explicitly
says "we are done serving this thing" and cleans up tempfile or
lockfile it needed to serve that thing, it is natural to make the
surviving process to take over the responsibility.

