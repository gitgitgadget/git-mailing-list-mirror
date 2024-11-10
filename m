Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A413A25B
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731267527; cv=none; b=S7GAuPGITL8Gvs5MxkdHixd/VvOO0sdORNpP8NDRGUUmsaaJ/dpCtR+peAC0UUtx/3FNWP+JSUoFiy9WFsrMYbgiYeC2n9uGcKGyxF3P3VOy9tUv/xGRFxRLzo2KgLUeWjCJ7j6OAklF4N6fHRiUA6pRtG3+xHE/5b6LJCokYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731267527; c=relaxed/simple;
	bh=+qW9n3IWErS4CAQ9qCUl4wDGD3AGnX68s/4Gmyg96Aw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f2yjqbD21oPv0xyh8/uH5jI6ZSEZxBz03riGzX/MGJbP171nEf5lr0XvEu5A2PGQvDOMyPKDkITjB5RfSPmfovHOmJP/EslRwVWdRi6uwUJHKBuUW4CdONMtCKDRqIrbSv9gOLOIfRTI8G6O1AsMvtZvAC5cNCsDh/lUD5dTRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=aQVDbcXQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbLmfWjJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="aQVDbcXQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbLmfWjJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D8006114014E;
	Sun, 10 Nov 2024 14:38:43 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 10 Nov 2024 14:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1731267523; x=1731353923; bh=oa1io6+wJeKH+RSIzUJuuCwN2gEv8xYG
	zAItuMFP12U=; b=aQVDbcXQiigSyKrXT5u2HuTGc1DNLRBZhR7Wbk8+3N7uiBFE
	xTyd9Hgir1XeDRe4uNudpowHyOUVgKtWLvmLAN2iqbuwSQyzFeDa8E/PGchFsQXe
	ECNEfXeoU9dlAeqqedbdARmk198zs7YeGOWYQvT9uR6X+2nYLqHyTPPrmCWABet9
	wzeQlptkyQpdU+So2BuFKweub9u92XgRT7ZktgFUCOO3ja0nweV/5L+tjZi13ujp
	e0zKuMmXE70lXbKmA2P+R3AsjGefiQcj24f0J76cmNT6gVYSYUQq/Lp2/JZ3EuK2
	PpvlTYd8uZ7ixGcKK71B28Hxe2Utbc2ec5fUsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731267523; x=
	1731353923; bh=oa1io6+wJeKH+RSIzUJuuCwN2gEv8xYGzAItuMFP12U=; b=R
	bLmfWjJbgj8abxVXqfF9wrS/lzHk3LppxHhuTEbs/7LDPag3V/mkka2awHLMTmoK
	4x5aL68drruVPZ5/jnoTrCR5J6M+0WFCzFgg27H9QP/I+cfVRnIqz8A9ijAIUD96
	VUWJ4ob+wZbMjdTZWO5AXbE2rxaybJM8JzcXUK2usKaRIn2BEMTto7P6mF6LjFPR
	aDmY7lMmRPo9hQox8bK4GnsjxIOevkmZ1nrcBdQjn6iTIt7sNcveG9wUXTVHD65M
	HyxQBx2NEgIwe98TBnswSwjzWvhyyl2boeFS3V9/h0MUdS9QdykgkA1srrb5QN1W
	IwqCreeO5P57y+XHCSFrA==
X-ME-Sender: <xms:wwsxZ-pTI8E7T3qOHyJxI8UESmMRWa0bmKLuC6RxeWO9hcaMvjuVVz8>
    <xme:wwsxZ8oSHYkinVHRw0PrqaYgMQ7gj1Bs0DTqsJ2zP_t-yJ5W6uJa4T0olL6-6OsH4
    y6wj64JuDaujhxfhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenuc
    ggtffrrghtthgvrhhnpeetkeefudehhfelfefgueeivdelledvjeegudejgfehjedttdev
    lefgleekieevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wwsxZzPU2vXBR_gO5YtMdDQa4nIOujzd3807pBlEUQ1U99_Zpddo_g>
    <xmx:wwsxZ96XuWZIIe-2oAzbK94ozsiJhGUR5G_NWN3ToKDiNAk1RBbcfA>
    <xmx:wwsxZ97hYjx5rT95Hu8bM1z2x9lryFOsLT2SZCQ5p8Qz7dhLlY_RrA>
    <xmx:wwsxZ9g7lsrUWDScSHCcjiEbPQNQQy2TYJcRnpkuhMzp2rR7VQKw0Q>
    <xmx:wwsxZw19dkZUktJkDP4eUF-TW04Hpq4E-VdtZ94HwWF8W0IpqRQIn35K>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6039E780068; Sun, 10 Nov 2024 14:38:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 10 Nov 2024 20:38:21 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <d9b1dac0-5b30-47c8-af47-190f4ed96748@app.fastmail.com>
In-Reply-To: <xmqq1pzmqy97.fsf@gitster.g>
References: <cover.1730234365.git.code@khaugsbakk.name>
 <cover.1730979849.git.code@khaugsbakk.name>
 <b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
 <xmqq1pzmqy97.fsf@gitster.g>
Subject: Re: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full backup example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 8, 2024, at 03:01, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> +We'll discuss two cases:
>> +
>> +1. Taking a full backup of a repository
>> +2. Transfer the history of a repository to another machine when the two
>> +   machines have no direct connection
>
> Contrasting (1) taking a backup and (2) extracting a backup later is
> a very useful way to frame the problem, but then, I'd say
>
>  1. taking a backup, either full or incremental, of a repository
>
>  2. using the backup, either full or incremental, to transfer the
>     history of the origin repository to any repository (including
>     itself) without needing any other connection between the two
>     repositories.
>
> Whether a full or an incremental, the resulting bundle file can be
> used as an offline medium and then later extracted elsewhere, even
> if there is no direct network connection between the origin
> repository and the destination repository.  But you can extract in
> the origin repository as well.
>
> But that would require a bit more surgery to the presentation order
> of the text, so I do not mind deferrring it to a later and separate
> series.  If we were to go that route, it would be helpful to have a
> paragraph to describe how you use your "full backup" bundle to recover
> lost data from, though.  To those of us who know what is happening,
> there is not much difference between the extraction side of the
> sneaker-net example, but as we framed the use in two distinct cases,
> it would be helpful to make each case stand on its own.

Sure.  I should be able to fit in a paragraph about using that
backup bundle.

>> +First let's consider a full backup of the repository.  The following
>> +command will take a full backup of the repository in the sense that all
>> +refs are included in the bundle (except `refs/stash`, i.e. the stash):
>
> Are you sure the "except" part is factually correct?

It was in my testing/to my recollection.  Hmm but I must have managed to
fool myself somehow. :P
