Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7C371D09
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992950; cv=none; b=uu9Tt9j/Gw+g9OMQCiuqcfgkGDjHmqBCpr6xgmmegkv2xYNBcGNcb3UJY+zWSxnyjfUNUkRAD6RTpAAihpxMvXsYU+TROC4+X64W3ooc5fYQrBN+aTCOcyWLXc3Kw+3PjAdoEACEPQrh+yW04aP/nlE6G2df/6dUoMCL6E1BOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992950; c=relaxed/simple;
	bh=VzADNIit0WLEtJ8URDg4VPTgxRQOBFhD6DWgvL6ykoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVpiIFM/rmjjF96emxiUq9NOOuDym7EPBevIEt5ZSV0XV2XghP98fqvxxTh4KBtmLs+E8W5UdFfHQzg7GfEauzBcUxrmJXfhKwMN6zfN5qUfHU9OdTpRoN0YS7Hbr4zOh3H6J7NMbUUrsP+aTwIka6DSQaCfcEpm9Vz2bXcQOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xHUfanIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IM8UGP0U; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xHUfanIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IM8UGP0U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CB51E1D001BD;
	Tue, 31 Mar 2026 17:35:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 17:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774992947; x=1775079347; bh=kO+Qa5edLt
	X3mS9r4R0K01kujnTQfle4AphME1s9Jmc=; b=xHUfanIuMH7+98Y7Y2SuxjCiSW
	h5JE46hn1LC/d6okGKU5czIC8n/W4dCa5ejAIXW4N4DKUqa6xUk0EqkyXhWrkSz6
	clbP40JCHhXSvzqfZOvc9NZYXpQFidZyfPbkooS1IPF3nS3zI9XWQ+R68yyTvskl
	nV1AI3ZgFyqFlsUuT+ahB1nN1x4pL4wpB30iao5HXWZ9tIdc0Fs2AZlJPE/vAN78
	2n0UczLC6yfXEgK/JKlTN09BP9wMZi/Vfzech96FGtu8nhGmuEnNmI/ZBVSXzWrD
	IU7vRK8IY4hhd8OIiKPWWm7ycHHXMgPboZMNNbTA6uXlPwawgB5S01SRlh5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774992947; x=1775079347; bh=kO+Qa5edLtX3mS9r4R0K01kujnTQfle4Aph
	ME1s9Jmc=; b=IM8UGP0U7to6g8kMJ0v5TlgkwZNSOmlWSkcNdPofTf6M/dI5UNJ
	unc485RL2HVhY+xaI3p6GoEnRRA59lISk0V42DCaz18TbXI9rOQytf42xkmeDWde
	4do7tSOLqzL/4evw3LgpbcERMzDBabhaSSr5m5hZdLg1oFME3EaRO4mJ/F3k/B5D
	GRU9lOmcaIGeyyWyrKVMhI3nKvPf2pFLy3zmcSeWgNfsiDer0aZxDBUksiKDHzUc
	4iftf/xyGi7UUBhk7JiBZ/XhDzsGhVtoYHBYo+1eJvIdl3OetmMwBzRsrsW7VBk2
	k/beovJasHIr36xortu/Qj31NS2MiQA7/MQ==
X-ME-Sender: <xms:Mz7MafZTaeUkiX1gpVZyqvH_7yvvLnVK1bdCr6NUUTaFXfpt3_bWpA>
    <xme:Mz7MaQrI3QiCLidAe-lFtnJ0s5_yv3D180MDSAWkqXJv4dEB5QZhes7LSPuhPSQFF
    LpT-TSuHh-mx18GsvI6xPcJyba3PN2A9MfUwv-2QcCc6oUzwotNU6E>
X-ME-Received: <xmr:Mz7MaUMEowh8p4GmEOj_3n-zuzl7ze7_lydLY0kZaD5GrUb-iMd4I5t0tc6QuQD9XHbyqVY-x7Oc8pnbtkjuBee_zY5eQgcphQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigvshhhuggrghgrleelse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Mz7MabpwsLmfjxKgTzdXxyJ5xp3depDegKiLKdUThysrT2Z5REGl-w>
    <xmx:Mz7MaZfvkxS_V0dYUCetTy1Mo_I-bXDTce7bpHo1oLG8uDZ4CvBHZQ>
    <xmx:Mz7MaRQNwM9M95lu2HIzKm5GJy8hBlArQqK_cMK6PXc1FxGNg24-OQ>
    <xmx:Mz7MaSblz9qffrBnkd-QjCVWjOWFW88X7orpXvFP2q1XGonwmvgrfg>
    <xmx:Mz7MaVdiIjbVXZ3FkuL_j4C0JZan-D20V7CWrIGnAbXflW_lgx0u8wKe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:35:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v2 0/2] unpack-trees: use explicit repository in trace2
 calls
In-Reply-To: <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com> (Jayesh
	Daga via GitGitGadget's message of "Tue, 31 Mar 2026 15:34:25 +0000")
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 14:35:45 -0700
Message-ID: <xmqqldf7y95a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Jayesh Daga (2):
>   unpack-trees: use repository from index instead of global
>   unpack-trees: use repository from index instead of global

That is unusual to have two commits with identical title and
identical proposed log messages yet with different patch text.

Do you perhaps want to squash them into a single commit?
