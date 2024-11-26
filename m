Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F68F54
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605358; cv=none; b=IBEhpfkNMnUKeHUGZo//KJYUZW2hKaCXLAOkWb32ErXXAIKk943A2TgrkOEXWrObWmfRe6r3aAIuDcq9wPWYLX0ARPVp6540HjMXgKed0VUxeP94LmDUbJqUp/gO1wjlTvrphyyIoBeu9TyAj3X0JMAlS/D7VUiCtn6qDIMcWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605358; c=relaxed/simple;
	bh=pl02gSRy0Jm+DIKvGmrxwGUGCDIhX30LnyJLLaaav/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jENtRvOjufxeanEME3FgTWptDRnMw2kR61Wkn4BI0M45vh/HijArwp8wm7OC80JriaEZlMsDHaCfsTXOBeni/pmV/mpFa57KwFrX+9JZGcD9nCNdUTyWnI87pLh+1XzKVR+qlU3CLm3x7nNkOqhuReLGpH5rYzFNKFb7i2KrXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/TGXIuJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/TGXIuJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 81B5413802D3;
	Tue, 26 Nov 2024 02:15:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 26 Nov 2024 02:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732605355; x=1732691755; bh=pl02gSRy0Jm+DIKvGmrxwGUGCDIhX30LnyJ
	LLaaav/8=; b=W/TGXIuJdjhB4QSFwi6DlppuTB1SisrCj3HUD0cYLDNzK3caWPo
	ahx9IFBNs+6X0psYlNMjMdnSnUkexJ1oZM7Uo4+1Lq9KuLfwHFMmlnI3V6NNcOJY
	i0VkA6AKxPfiNgQvlCLoLvauBnZiW4l+dsTUf0XQJp6JeUB9GMUjhB9fo0f72FYD
	PyBxxGkfvIXZdOFPwdY01aMoUDcmpzCA+lgt3UieI1qp/E+gG6yilkylcn7n2Ap5
	akddp/sNlhIVEJlyXLIphkD6REY+BdkVHNO2DHgqP4BK6r/+CvF2cBKdCtrq3bqV
	YClnmVOCbS+uDpTgwvy9lPr2b1JyxqPf7Zw==
X-ME-Sender: <xms:q3VFZ1wIA0BfElXn3axWR1L7cfxHy1pxHtvJkAiZo_R1Tet22b5LFg>
    <xme:q3VFZ1RTk78DKAU_5yyII8LVMLM_KqZLISCLt98B-n8hi1FdGTIL8469fIMlKqCpV
    ijqx2SJw4hLjFRUcA>
X-ME-Received: <xmr:q3VFZ_VKaI8U_vfX__JkepdfjqK8xLeUSVXrB9mWfxjOcI2ZMxzThc1RIKdbWQZDyIEOoeU4h0jsgNxt8vCnNUM2JLdaVXE56ah4iH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q3VFZ3h0f5dfImucgdEnnNeJykK_aci5Kx7KgRrh6J_DMKramIt2JQ>
    <xmx:q3VFZ3ArzK6A6rutBvLRavkVgunnLV0paYAT9vUh10Ktr9IjY_5dnQ>
    <xmx:q3VFZwK7G4h3SAsRLYN7jM7oNZDYw2ORpAfnnZFhRMjdPAPjH4M1_w>
    <xmx:q3VFZ2D9R3JfPlznoi1llosNuSNqzCco-zJIVEhNi7vw2RdHs6c3YA>
    <xmx:q3VFZ5088zsm_zsdYmouFOo4m78-iNEioeCTyLVgj0uWvImCDbtCr-Z8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:15:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
 <jn.avila@free.fr>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 0/5] doc: git diff reformatting
In-Reply-To: <96157f25-655d-4d3e-ba56-d76a8f12ced7@kdbg.org> (Johannes Sixt's
	message of "Tue, 26 Nov 2024 07:55:49 +0100")
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
	<xmqqv7wa1up7.fsf@gitster.g>
	<96157f25-655d-4d3e-ba56-d76a8f12ced7@kdbg.org>
Date: Tue, 26 Nov 2024 16:15:53 +0900
Message-ID: <xmqqo722zcra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Yes, this round looks good to me, too.
>
> My comment about dashed vs. non-dashed commands in 3/5 hasn't been
> addressed, but this is OK since such a change is outside the topic of
> this series.

Thanks, let's do that.
