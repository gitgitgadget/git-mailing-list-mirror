Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195B8BEE
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943867; cv=none; b=cPNcyHrqG9PDO+OCm02JD8dXRzIAbtEzKt2npCr2KZSzZwvSPloNfmtAu3nQv1p+gc6TxsbsIqcr025SY7jOAHPuCHk2Lgj3AXEaEPK3pVxmmGAOOhou6gRl7v02sFe5NQqCrYWU62RyShcE6Y/N3JDwKprZoKsFoIKuv+Mz8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943867; c=relaxed/simple;
	bh=IUHuZcy1zUa1GMtDM0I7CSP1P8nrbKY9gBFA7jkq8tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7v0hmKznkcj/sthbtFH8PqPqgoCTVJu9yR9HzFDerpSuu7sUIYjFKavGpzn/RBPCisbsKOMyyNzVUp8l9AfxeOKi+v3LKUF7zGGC2en92bocHK5f1QubQlqXamabJJoWgOnsn9TBr33sfcuzAHaCutwEvYL95M9PSQGJcTUy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lr9rqCr2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxNcJo0P; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lr9rqCr2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxNcJo0P"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53BA613801CF;
	Tue, 29 Apr 2025 12:24:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745943864; x=1746030264; bh=e77VgXJPa6
	aBx3Jip2Aa5neJDKzPb1V48aaRP7Qhq4k=; b=Lr9rqCr2w4sgNjrhA3MH3yLSNA
	6fy8Tfm6Eo2g4DABkHXdotyOiJyZTDTiI6qB4KxivSrfCxgy9Z/BbsLT3uG/EvaV
	uAn9YUe7K9ERJuMrNp6bzN6O7UH0bhasuSssGObXVbL0e9nJfdcI4icuFQx0UVdu
	Q+Wc7S89eWOD5iTRG/mQIRIfM8mhhjlfHrcgxD7tGrbzp0lIv9She+5P+aaxPBDW
	nRusyeMPf00yVxlSbhaVGuzLQsvWmTaBj5A1JoRN1LRH38s1MS+YmZCmV7SgBC+W
	r9YD5fraae3p98hZpKnykxMKGchoJwRs9PdcBCYY3uoGHfhf/gqW3hjRHzUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745943864; x=1746030264; bh=e77VgXJPa6aBx3Jip2Aa5neJDKzPb1V48aa
	RP7Qhq4k=; b=hxNcJo0PltX00Ioe2X3rV5UtOwhe2iGCimXnNGJow3wFa2tZZJx
	fTFrcTuD4D0/AMr3jP6Iogmq+k8T7dG1AJlo70p1iHrPCPfjpoVHLJCx2bqA4/BG
	IeP63syvCboVZo2O9IcPtIZUfiqUx2WDDHbQCKDsKbS2/mm1qTEJUhdlnY/X6RRH
	EQCcayDduFtuFPaik3znUdIBZonJIFgAubT8C2riEvT1b6qztrXRd+yih/+vBeFN
	LB9r51WiB9d6Q9/KhoutNPtxXe9cZ4fB6smCEOrXBPSa1t74vt2aLYr9ippR4LAt
	i9YRhR8ExVKHLnSG6NaaNtgOgMOUCV2z0cA==
X-ME-Sender: <xms:OP0QaFVqxHRJO04bLkiTfcbX_v284C-W6m-AYHRP43YTQs5i8y5Sxw>
    <xme:OP0QaFnAezPE_7Dthdit6uBS9ONiIv4yhBftbbyFrwug_v7eMtIu-kHAmL9igf7u_
    Tm_G8KHJrmpLpjdBw>
X-ME-Received: <xmr:OP0QaBY07ZEAKVhon-DnOSq_uPmwdMvYu8oQ4WFJE4QdVLjRlcT4M07ynPm9_i9A4JRNROpcv9QVL9mbMmT_qtuGED4DrFpgQ4eK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughi
    thihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmh
    grkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtghomhdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegv
    hhhuvghlshesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:OP0QaIVd9psAQgDSF-HHCuMpwO-9fWMRB5LiRHthDjXUj4HXl2QR2A>
    <xmx:OP0QaPkTy4gcOBsCGtecSBgYH8jidNTsGzJFsEQ-aO-IgmLzqFiSng>
    <xmx:OP0QaFfT24qDJroFCAibq4aBT1UdbuPwymHGm_x23qgjy0DGyt8MBQ>
    <xmx:OP0QaJG3Sljdo6FeCKNPjJGaXFGkXw2V06Qxax_WuHRbQN0R4eUKcA>
    <xmx:OP0QaNtAaVXrYDVSll-TXKj8MIFqAeIPwX8CGV5MVuV-si5hFtLCIqSn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 12:24:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v3] send-email: add --[no-]outlook-id-fix option
In-Reply-To: <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 29 Apr 2025 10:52:47 +0000")
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 09:24:22 -0700
Message-ID: <xmqqldrj6imh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +--[no-]outlook-id-fix::
> +	Outlook servers discard the Message-ID sent via email and assign a
> +	new random Message-ID, thus breaking threads.
> ++
> +--
> +- '--outlook-id-fix' will attempt to retrieve the ID from the server
> +  irrespective of the SMTP server being used. Use only if Microsoft is your
> +  email provider.
> +- '--no-outlook-id-fix' will disable this tweak irrespective of the SMTP
> +  server being used.
> +--
> ++
> +If not specified, the default behaviour will be to enable the tweak only if the
> +SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.

I found "irrespective of the SMTP server being used" part a bit
confusing, which seemed to contradict with the next sentence to tell
you to use it only against Outlook based servers.

After reading the "If not specified" part, I can sort of guess that
you wanted to "irrespective" mean "even when we are (or are not)
talking to outlook.com", but it is still a confusing description.

Would the following work better, I wonder...?

	Microsoft Outlook SMTP servers ..., thus breaking threads.

	With `--outlook-id-fix`, "git send-email" uses a mechanism
	specific to Outlook servers to learn the Message-ID the
	server assigned to fix the threading.  Use it only when you
	know that the server reports the rewritten Message-ID the
	same way as Outlook servers do.

	Without this option specified, the fix is done by default
	when talking to smtp.office365.com or smtp-mail.outlook.com.
	Use `--no-outlook-id-fix` to disable even when talking to
	these two servers.

Thanks.
