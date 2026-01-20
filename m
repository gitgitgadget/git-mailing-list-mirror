Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DC11C8603
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917193; cv=none; b=TUwKCtkjdj0OisXVLymhdItw0QDE/mF8FUNSAJ2A1tZ4J4SRnQmzTg16Tjq5O4mPgdV/IY79kMTuwU9iOi8CZ3bqig7BGxvPj7qupykqE9Iqxdhoh+zK+VWVqh8rEQEn+67+OhnQcB+sXuDXx0THbPLNVr9cQNWVQZvDw7hTQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917193; c=relaxed/simple;
	bh=UWur8W8cKOiAjiWqk5KHLWu1G2QXGTx6NPL5mJXpPF8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WKQQvAeRWw/RyAultMTI+ljDqln9mDnioOtmsw0YJaLAzxDRnbJe+fP7/hk/T0gEDQ4KbC/OIc4L+CzSwrdCt3MaYfkaFuD/mlUFKAcWMSzpU9RJsMhFQ0G+/dJQRX1Nkpy4OGZwqWd/rJZ8hkyw8pF0P1q3Uc8jQo5YPncId3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RwcRnp9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFG3sHAb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RwcRnp9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFG3sHAb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA1AD7A00A2;
	Tue, 20 Jan 2026 08:53:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 08:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768917189;
	 x=1769003589; bh=UWur8W8cKOiAjiWqk5KHLWu1G2QXGTx6NPL5mJXpPF8=; b=
	RwcRnp9qCc2tfNmZKIByQMlV9CFDirQVQAiHEaenqCWY2tDqG3BxnUdBBZOz5f8Z
	DSMUspCi8wkAF4di99oGtTVIPgqDguhddTR5SKfAVsl5Jn5DVVj5+THamT2LyNJV
	h7b0S02fbBVj5x91kxgS7fyG4v3V8qL9AzetvpCreHNhfWCb0SgPKUX8UCfl9bic
	ZXnHVaz2lzbJGJseHl6kqkDpaJT133CD9yJO4k5VjZ6jPr9AArA54zP6rDClPu/i
	uKB2VdRAGJrAbR7gGwH/gi5qOSC95MmjWMKajSVovmTLQWXI6u7G5meOikytmqzk
	dj59cGEx/hlNUbHYigl8OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768917189; x=
	1769003589; bh=UWur8W8cKOiAjiWqk5KHLWu1G2QXGTx6NPL5mJXpPF8=; b=D
	FG3sHAbzYpPivm+Otabq4Vx8IYFn1MqiDpxAVswSFt+vT9JMnDmFcHa/DBC7C8kj
	YBJxfKUcCTmeXyqed2qxMVO/wabcSSfm/UsPUFZD4KZfYT1myzyXsekyK/EoYt1I
	ZU8Wuh9UQwnGOcn/7mtq5l7Sw7HCmu4gxzYKVc0KI+GgWPf1MMcl1AQOj9AAIwHW
	x6TDbfmZDt3Z2Vpm4PmRkLDqErj+YXD/RJeOLyJZIuKYAVtF3ry3OXWbBL/5R5Pq
	rWnqeEVjt+JRIT09i95WQcSlMn8l5O/NpxpCyxgW6rPDdl75t5hmhJKeR1fyOssY
	SttcUVmlV6zzL1dVPOqlQ==
X-ME-Sender: <xms:xYhvaWFa8q45thBoAGOrJR_SOQQIBiRki2KQTMthbNjhg7Rv1DTcFoY>
    <xme:xYhvaSJ1XoV2UHm2y5BjdDLYC834ql9EVjVr7Ceo5ilZle-58J6mOS-d1rqCOjlOf
    FA-NgaG1vZX_cE3ApijrO6dmCn4PgU-EhOPdn2hOGg45xx_eSo9YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xYhvaVOk2aQU32p0P-3VO4ZIM0hHbh8JmY9FHrqQRzzO5PxdCg90Sg>
    <xmx:xYhvaTbXZ3-QiKlEmQlyMMrFQoE3c7BAdOgkKGHW75rz42PXrlyR2A>
    <xmx:xYhvaXw5REx1AngyMM68-RkJonDNPIX9Zz3PvFpuE0J0cfd1jiEF3Q>
    <xmx:xYhvaWLILmaALEQcFFII0bAKpfidkquar1pEM8bwMAXKVAMj4JjSUg>
    <xmx:xYhvaWuLn2WUdcBzqzMRct5bffvLDY8s-v0hZfaPvGH3d9lnPWLGBjpF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 381321EA006B; Tue, 20 Jan 2026 08:53:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai8Eq8lg8y5F
Date: Tue, 20 Jan 2026 14:52:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Git Mailing List" <git@vger.kernel.org>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
In-Reply-To: 
 <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
References: 
 <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 20, 2026, at 12:01, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> While all my commits appear under the same address, other addresses
> appear in some commit trailers. Map those addresses to the canonical
> one.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> I'm not sure if we actually remap the address in trailers but
> we've certainly talked about doing it in the past.

Yeah it does.

>[snip]
