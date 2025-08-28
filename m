Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A43594A
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362687; cv=none; b=fj5KS2J6CWs/nJueVBQN9GEfw7hgtaqAXjUwTnnmVgJdCTJilnD3FAiBNrzYm8sAmZwBjaFHa5wwPefLTxzhIVeQUVOjvtTelhJ3EnTjtwttElfseX62wZog5yL46HJaxK4tiOtOY+kWruaUbvs42pcwIrUo8JUnmu+8Zf6PjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362687; c=relaxed/simple;
	bh=+gOWwdTxrmn1PqZISGfgjbBMw5y4Qi69IV2xAc3A6W8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aT51qR51rCiUO4r1QOYLKqezBFCWTT1XwBeXEePH288uiNbNb/IomCNWqaBjBfwea8fq30l1Sz0T5NgShWEXxI0EMQIrlfkyPtDzqJqS+B9/DUYzOqvG0z+c9cCL0aGDm0MUcQWRsYO/jxyyazfumJmdNSmXlWTQhPm9zKpY9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=G5jLNUkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5n1H86V; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="G5jLNUkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5n1H86V"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28C1B1400055;
	Thu, 28 Aug 2025 02:31:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 02:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756362684;
	 x=1756449084; bh=Ra5G858BMeIzK+//paXMkylyLRLhWJ9HZvx1nXoMyYI=; b=
	G5jLNUkIuXiY6p2ugb1JxgztNsOdQQoWNdWHu4tSV1YVBPSHq7q8p31+NjssDGa9
	cyg9uvCTRI10/1CRJS2A50LvQ9efCHRolR03MLce/q57Fnz5YWtK2QGNXTalTncG
	jFFg1L30vMxfGio1rEs5r5+XwPpSbawDati7qIKAkV/DFKTqEASdahAkIMU3TCKn
	0U/AISlXxErR6ScPIE2OW1SG/mLXpxsbU7pOWoShSZ+gfJXJpClBXxs3vUuVMRK9
	/vrvNaCA8CJidWbUT8vMlZq0G10WPppQi565FEtIwPpae9E2wGs3C1hCVlFsbfVA
	1k3Q3UGl4SJHf9VEh758yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756362684; x=
	1756449084; bh=Ra5G858BMeIzK+//paXMkylyLRLhWJ9HZvx1nXoMyYI=; b=Q
	5n1H86VS/80qrUB7imJGoFsPpAlmwq39sroXnk9FpdjTDshnAWoHOb+1J9wKw7qH
	sKIbnHFlzSfH/DMTp0lAz/9vxerQcwhBOrNQxIdAKkg4uwEUT2a2NPrmWAjhng/l
	zqzAd6xhjgoR4qFf62YOBHfcMCpa3v0c2Z9zsc/KAwmff0ubz39OFBOWZMivNnTh
	BZK5GI3J8jUcoqZ4XofLbbsiPIDA0o9nrFJ4XoVPmCcdRUJrB47uwBwAG5NAIbXp
	TuGnmTmSMG7tXRvblykI5vZbUuH+clVnVudj9jZ5JSgK2CpSGhzlTtNKXYl2xq5s
	C6eUdUqgxRPlW5rNbwilQ==
X-ME-Sender: <xms:u_evaBBDbi63Lh1Ns5Ye0Sk5k842aWNuzFBUPpY4T6RZjB4ehQpcvH4>
    <xme:u_evaPgJ6c85rCYHm65Nbdi7_W8ONC30twvimH760ex6Zn8vL5VjajKGqC9JO-b46
    QZzl8bi5w6bEsMl1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegurghnrghllhgvnhegieesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:u_evaFGMMrWdZyzJeJ6DMUkHmD3tmRGrVd8FjOcYtIwMj-nNlUbAKQ>
    <xmx:u_evaDQCCRPowGlBG2jGQ0_iYS0Z906Sd2Ipwif_AbItERaiIJhvAA>
    <xmx:u_evaJGTWPA2iJVwjMuHqgSYxJ4gZAs2X63TIa09pM3dmovdJIOfuA>
    <xmx:u_evaH_Ni40SiVufoMPkWb4c7kRVoXC78BuVuNrhK5ZBM5KSDZMvAA>
    <xmx:vPevaLObr7Jx1ZrcV6wQS2c7DF0HmIXv4DgLgws1JceY120M5jW9OuhE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DBF511EA0066; Thu, 28 Aug 2025 02:31:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgTgWjfOuUnV
Date: Thu, 28 Aug 2025 08:31:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Dan Allen" <danallen46@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <d13a0a0d-4d62-47f4-9908-5a712e250856@app.fastmail.com>
In-Reply-To: <280B51C1-CE87-4953-89CE-6310ECEC9D61@gmail.com>
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
 <868d0df4-992e-41a7-901e-288a4ff8527d@app.fastmail.com>
 <280B51C1-CE87-4953-89CE-6310ECEC9D61@gmail.com>
Subject: Re: I use whatchanged!
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025, at 15:52, Dan Allen wrote:
>> On 20 Aug 2025, at 14:46, Kristoffer Haugsbakk <kristofferhaugsbakk@f=
astmail.com> wrote:
>>[snip]
>> According to git-whatchanged(1)
>>
>>    replace: git whatchanged <opts>
>>    with:    git log <opts> --raw --no-merges
>>
>> Should be enough.
>>
>> --
>> semantic drift
>
> That works!  Thank you.

That=E2=80=99s great.  Just remember to use reply-all on this list.

Cheers

--=20
Kristoffer
