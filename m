Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCC13C81B
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135828; cv=none; b=BdsT7g5uclOcjjY2nP0B3K9DAl6CzW+lhl+dLfvFfRtyITggzzvq/2V2zHK+QvU6Hhd43MV0yMBaoEGqyVq1pOeOI+QKfPjbPHMt4DHEuXPlWQWHuWmm3ZtoBw7D7itBnL1ywctq1pUnX5jnoSofBRdxv6VPyf3+QrjiGRFVtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135828; c=relaxed/simple;
	bh=4e2Dq6k00tMfFJclx3CP1BGOwxbVQZNd+mErzTj1J44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUIMuprqwb1vO/teuucazR4KPGl7FqSbld6KYHysvOasflQPXDaa4zjBnAwE8NTjvgKP+As0k5PXpVIGfTBwb/4gLB1kBw6oqkApEpECI6Xx1j0Yc4TgzqrPKFdcEBRQsfjIo2rkl2d7EGDTOuvrmPReefQc4Cpc5pMsL0WxH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8JAQ76c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CI2i9rTm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8JAQ76c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CI2i9rTm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BB1214001B0;
	Mon, 21 Jul 2025 18:10:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 21 Jul 2025 18:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753135825; x=1753222225; bh=pwZf3PkiQg
	QmSHXYswIdpg9jPlmqmER+qbHE2UqeZas=; b=V8JAQ76cZTh/yvlx1c5DymDvpc
	VzbMg/136z9yz9K2/XvAbkDpJvIbug/nSsLvcivEWtQEf1Um+pEO05aO3gsf3de2
	DxW76UUqmCHGtgMnRNhi4TmUBfhmLFDYPzyOC7hOUEOxf2X/io9WpaeYBP+au9Wm
	vOwBCoLWtb+JjEj+/WRCDrReU5wyTennfYOPEq4VZUKDuICfVZuhbS+lIe1GKi5c
	mDI4RK/n0VmzuyWIJBHghNkrPLkiWaLmXXJ0VVsuT/zJrZPStRv8aR+67jkQjZbe
	VBgiaqblnxCbnpkLuycSYKRiWM12C6I+SqAdOB5cucgYLeVHvywiX2dOpTRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753135825; x=1753222225; bh=pwZf3PkiQgQmSHXYswIdpg9jPlmqmER+qbH
	E2UqeZas=; b=CI2i9rTmSfRpcFgdThclDgAJrk+UmUN2nXm+bXvbu2SPG0HWOx4
	e4tX9RnTN3BnUsNlBg8evC6V1nJcM3aGP4KAO0Rw40kLZCxcOyCF2Y3pzeCOzpgv
	qIBnRFfDW86a1qeA+Y19sbuQzleREfIUgI0WsLK7LM+apUru0tDE6MYAlfcVnyaN
	D9YLnDqlBBB09BiGIkNzmO3PpIHMByjkBb5V7Y+NWHl7Q8Quva8sUU8SrI62KPOx
	Rusv0vDmp4mC5DqzZIX8V9QLw4DDOL9PRK2k+b9JwDJpj3CAqFkSwD1HoSo1FHZ1
	exQdkv+54iozvnEcNsSC1A0iUfpCP6m/dyw==
X-ME-Sender: <xms:z7p-aFatjQDoPMYI9HlGoGPtB31nRsQlCaNcGCdsjHIBTzAqabimYw>
    <xme:z7p-aE1sGS6CZsaY1ES7IW8tKj31dRqHiMUc6NQATO4jekjJKrclFNhDoisHaFJRv
    5tPcr7my9MQCbDCxg>
X-ME-Received: <xmr:z7p-aIa6Cfk_wvhMLQN9FbIf6ZBnq6-SWTrV-OFrbm-4PrNU7BP9Or8PBOJGMBKuKjYc3_edJ8CPhCQX0W4kQ4C3M3vTidMiRv4uhtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhiheslhhoohhpihhnghdrmhgvpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0Lp-aEKetlQDZK-dDinqgsl30pSnbceJybwJ-AAe4qfC6bDBQc5fmA>
    <xmx:0Lp-aPHM-NO-J2JUJloBsVtQVsgY_nmDiYIENvM-1oIqPfo7kkJtKw>
    <xmx:0Lp-aDs_RMNkn0qmG8eRSC3K4QJbDyhdUH2x8WX9lLj5O_RHhSLdwA>
    <xmx:0Lp-aGvyD-jPYasEtfXw79BSNfgkc8HWm6vuaN1KugEXAiTXPGxjTg>
    <xmx:0bp-aJImMNImKKUwIQMuiP_MWIqmpheDLyfAMYb8A7Ajfv_UZA4NpE2J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 18:10:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@looping.me,  j6t@kdbg.org,
  sunshine@sunshineco.com
Subject: Re: [PATCH v2] pull: add pull.autoStash config option
In-Reply-To: <20250720124334.12045-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Sun, 20 Jul 2025 20:43:34 +0800")
References: <20250718035221.2293-1-yldhome2d2@gmail.com>
	<20250720124334.12045-1-yldhome2d2@gmail.com>
Date: Mon, 21 Jul 2025 15:10:22 -0700
Message-ID: <xmqqjz41w5yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>  Documentation/config/pull.adoc | 16 +++++++++
>  builtin/pull.c                 | 20 ++++++++++--
>  t/t5520-pull.sh                | 60 ++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 3 deletions(-)

Thanks, will replace.

Shall we mark it for 'next' now?
