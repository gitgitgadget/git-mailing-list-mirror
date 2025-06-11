Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034752E612B
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641735; cv=none; b=Uufh9/vHc0T1Vb4otTB7jA7cVcH/65Aadpz+cXQW1cQ60vkHX3oWW1YEi49bnN0kaT51D/M009hPvVrKSCCySKULjnzNMZi7A3OFw8td56e2niJ02oEqIMxZv3BbMZnzddTQdImdGxKzu5G25YcGlitjZlXxwkIaErMwei2JxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641735; c=relaxed/simple;
	bh=FxkIQnYa/Mg9Eat2iuHKHJh51a/gi4qMSRa1HJcqI3U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ni/haYoQUaNf6rbB5a7KzKFsdHyAK67FQD+tTpGBz7H6v6dhOMUtKbMFqIOI2k6U13ftN9h0oWSOCCPSfxl6EGnHjIJnFrTb+l/KJaDX3OOuvtEQ7NocsLH+VpKgQ6T1zSbFdTbXqN0gjiygEtnoV+lsiqzgLmXYve+NMGAGaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dzPXiPwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiNPEO96; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dzPXiPwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiNPEO96"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 174041140265;
	Wed, 11 Jun 2025 07:35:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 11 Jun 2025 07:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749641733;
	 x=1749728133; bh=qR7GSMGySJAEwkE0zx4p2lyqpobEphFQTVV2jrJMplk=; b=
	dzPXiPwHMRB5pEmvtoTf5ACZmZcuUAPlPIPlf4UAL38faayBYKai35stHNGzJrTl
	p8fKHNjylTB6i6AOebcOaVV/aVGH07/Q3KBxYplxfHAfkfmS1g7/86h1P5rVqQed
	TqDxBbSbKCs3h3ttioY5HDbk2x+5FECIG/mH8h2FmtMs03qx9v94iPItpkfu6m0o
	irrxAIMRY5CaOwPyusuz+IrOSVbvt4gSH07xdvFJjj2cgVsLQlS9TvRacu7oWjpg
	XvywyGshdQXXElE/9/1Ityx/u7M3N0oHwUmUP4exfhn9bMhBScyOnQUTAGfaZpuD
	2YFH1Bm2Uzi6pO4y0kOJ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749641733; x=
	1749728133; bh=qR7GSMGySJAEwkE0zx4p2lyqpobEphFQTVV2jrJMplk=; b=h
	iNPEO96i4e8zH81zTbWk4sCpuCoLWZ9kbwcJrvUckGc11n3vRYoE9tGy6OCblh+X
	XvRko0YKWmptf+LyUQXd0qkdEjpvZ3LtSmkMb4116joZ1uDMNJoKoCgQ9i5FkTOs
	RfyX1xWZLhGDE8jVZwalku7qzPPsok78EA6/EgYXVp7jZUHm2n0zpeBHU0H40bh+
	+74qmu7TEzVkEv4L7imrAOnh9Ttd9fGrrlmEx8tu9D9xAIuXuRcjUav+CZ6Rc9yP
	yLEbhsm/NZ+9K24zgw2lNx/7+aFS5G4cPI92bGYqX//8gCMbqO9ZuJacb4trcMXo
	vjwgPaOPKOSs6aTTI0Ebw==
X-ME-Sender: <xms:BGpJaHeY3eUO-2XebvzDmU2dPS5U2TOFeDwT3FlUh9e1mx1FVKXeLqQ>
    <xme:BGpJaNPw_v1ZAq8vj7EyKftfjhzE6FDxV8rN4fX3tOJJsg4U_m5KHyafHcr_W0M4j
    MRiwkFpoOHJGyNuBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:BGpJaAh0ziXCfsXmmEXW5XMhBRTo0tdzRGxF8SzNjRz3hYUWjqfG6Q>
    <xmx:BGpJaI8DasHW98p9O7uBVUZkwhlN5orT8ltib1_ll2kOgTHPV-nfLA>
    <xmx:BGpJaDvCbR8rnxTz1bTYDnKqGiOT7zYFTdwrDx6OnQZTyM8TMX_VKw>
    <xmx:BGpJaHFRh7fupFDQoWqkW54box8ZJhKn60EpyXwLDLahz0O0EqAgUw>
    <xmx:BWpJaBmuzwrWh1epC80bYs-imDDMTYzvjo2LQ2WbUZZxgcJYzCA3S59M>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4E551EA0061; Wed, 11 Jun 2025 07:35:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1f4ad51783597734
Date: Wed, 11 Jun 2025 13:35:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <3526b0c0-7020-4c39-bc09-99b63a58db8a@app.fastmail.com>
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 9, 2025, at 01:44, brian m. carlson wrote:
> Stashes are currently stored using the reflog in a given repository.
> This is an interesting and novel way to handle them, but there is no way
> to easily move a stash across machines.  For example, stashes cannot be
> bundled, pushed, or fetched.

I think this feature works well.  Exporting locally is simple.  Using a
whatever-ref to export to the remote is a fine implementation.
Importing locally is simple as well.  The `--print` option for
script/machine consumption is a nice touch.

Also I think the DAG implementation is cool.

-- 
Kristoffer Haugsbakk
