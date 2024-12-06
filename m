Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3722C6D9
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525220; cv=none; b=GedY3KLNVAPbzLqHCc/vmSh2TQXPbJLS+z+J7gJ7Ht5HZorezYZJDfb1to61BguR8j4ZdoylUrYEU8PAydmPG6EHTAE2QQqEfPdfBMEo892pr9nl/xYeBqGUd0ETunzqpL0+eee0dPT49lZlSckwTmwZU9vo6MAe5HmhIP/c3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525220; c=relaxed/simple;
	bh=iWXf+8dnMMOpwxw8ruLGaSLAWmWN9YZYbgsoO9hkz8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHKITpXnfxUBdmgROIUblt0DP9r/0b6AIO1CuPfkx06S1k5KLgjuuJY2gPUfPQ+Ef1wrMIo5EUoQKx8rzGtT/UTHbR8vAd1fMVRWNj0iIX3VTGq5ROWZVT9wDAWs7Fs/diJ2R0SnZ9w9PRYPWhCv6Nso6KIPyBmEG7oMgUlibuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJz+XIGB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJz+XIGB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 51F731380719;
	Fri,  6 Dec 2024 17:46:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 17:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733525217; x=1733611617; bh=4MXe7hstf0WqCMDleqSVVIFYJ2pI9oO9tgD
	r0MF6+sA=; b=PJz+XIGBDoMcbsSjksWQZsw58Nd9i3wS4jEyVqXLoRIsW6huRlS
	WUgbAQdJLd7jNekTzLNncdL9u9CsnHHxjd/sVPhUcCqVODJCr/3VvmuBMLOXTgVc
	Tf9kNefkFEYOud0ENKPTPAZXepf5FaT8UC/KzdwQClw2xoH7ayeq8AwA8Qql6f0O
	DF6Mr8gFRniU71HEvd9Ogdn/ugfe21VBrrsl00q+PLuXjMe+kscCoYo05FG6x2Hl
	6UORAQot03wfYzeF7GVj5G5Bjhpmx1w7EuMxkjUIqsEyOt1oD3dHeEliEgkAQ4tr
	JK/w53IH2eH+nGEl5X7O4Zrp2Vq1AGXZlVQ==
X-ME-Sender: <xms:4X5TZ80kzS5WG7MA8EJ6cQ2Fh_fodlQtTI5d6PxixkfnQ4IvRHZ6KA>
    <xme:4X5TZ3H1Wjflm-w1nxnJeymheLBRU__3olXDXlk661phY3weDvHB-cfo03qMdMboR
    _fZB3rKJGCmt4m6sA>
X-ME-Received: <xmr:4X5TZ05fyoNZDPAfMM8eeCckXKj17xbD3FFIIEjsbSsrRNRpV3aFIoQkD6rQ_zfU-F6DBuoqIPnnPwyk0GBrs0CxWi4HBGBnfqNM_9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprggrrhhnihesvhgrlhhohhgrihdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4X5TZ10UlrMsaZPnXWBJXys2QYf6wACbSF6gehrM0WEx6jf-rt18lw>
    <xmx:4X5TZ_H9MfVs5nfKQRghL0qflEQXfyo2mBlqUU1P3THsVviet4CtHQ>
    <xmx:4X5TZ-9BgunfSmMj5Rqlf1GGPwflicFo63k38MphEnQNcxOZElaejw>
    <xmx:4X5TZ0lepPDY_pCluL7xTENTRgdPZyCSzPn06CaXUN3dMBKZmCn59g>
    <xmx:4X5TZ05XsbQVNMCMw2eXJMMuWiQuktHhlke62tSkTHzcByS_CsqFjYaV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 17:46:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Aarni Koskela <aarni@valohai.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2] object-name: fix reversed ordering with
 ":/<PATTERN>" revisions
In-Reply-To: <Z1McGsD8nG5x43g9@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Dec 2024 16:45:30 +0100")
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
	<20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
	<4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>
	<Z1McGsD8nG5x43g9@pks.im>
Date: Sat, 07 Dec 2024 07:46:55 +0900
Message-ID: <xmqq1pykwhsw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Fair, I should've double checked. Anyway, verifying the behaviour of
> both in the added test is probably still sensible.

I'll queue with this range-diff on top.  :/<text> is explained in
"git help revisions" as "reachable from any ref", and it is a good
phrase to use there, I think.

Thanks, both, I should've double-checked, too.


      ## Commit message ##
         object-name: fix reversed ordering with ":/<PATTERN>" revisions
     
    -    Recently it was reported [1] that "look for the youngest reachable
    -    commit with log message that match the given pattern" syntax (e.g.
    -    ':/<PATTERN>' or 'HEAD^{/<PATTERN>}') started to return results in
    +    Recently it was reported [1] that "look for the youngest commit
    +    reachable from any ref with log message that match the given
    +    pattern" syntax (e.g. ':/<PATTERN>') started to return results in
         reverse recency order. This regression was introduced in Git v2.47.0 and
         is caused by a memory leak fix done in 57fb139b5e (object-name: fix
         leaking commit list items, 2024-08-01).
