Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A01798C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918405; cv=none; b=GnOsig15XwvugQRU79k8wS+LG/aL44s+s6X9jWLlLdWPB4vO/CHnIq5gu+BJe7ImzySrihZJw4cA/Y8NV1l6TSVlXTCtY285+D9YJ3YWzMDc7F5R0pPwyWIGy3zzqUFwKt27ogRoIUZqEMOLOoRM7LXqfqE+xnyxOWsuFtdkiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918405; c=relaxed/simple;
	bh=X+VgPyybYaJmRfD2UVSzCFpm1uGwhPJqqCGOCF3NIEQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nJuKEVqe5jyLwWed6LLff/KngDs2rJ6Cu5eKrJztE6tnxajb4u2t4zXFsjY8LShurZ18CXQ9JJYCx3xwfm6yqC2mSst8+qgxt5X/RklbhKzMWZnrfPvSgVVZr0vi8hcx9mtb+8ZbzBp3PbRRaX5nF5U71EMG5rQWychfcOS+ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rX1/uZDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRYLqODy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rX1/uZDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRYLqODy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3CAB11400B9;
	Mon, 14 Oct 2024 11:06:41 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 11:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728918401;
	 x=1729004801; bh=g/UQ4Wa2xzdd8hZPp65f1gl6U7da9OFEtJMqAwD2KpY=; b=
	rX1/uZDu8gDrpYphM7FcW8RnfGYYJXMsvy0dhT7KMp9irtu1GXV9ZdrYFNGlhJR5
	Mq3eVbuB3Qzp3fCODvHLiGTa6wrdE5G+dlPvuHhgcVECn+9ONFypNqjAfuhNMiul
	kDNOuKITfRzbHFHH/4HEBWBFgilr2qiG2+V13CdKEN77I0smSBW/7zfZwN0Jr8uD
	rmgwpN5Gis9EGI3+PdL0b0SA5yKKemfnAWb2hlFNlhEVBK9b+2EZjz88ZBaU6R6l
	2xX5T/ceFS2y0EDlR0KjmKozeU84oSyWqtuYillyVHRBGAryK6vjqpF3MRc1Qkng
	QM5ac1zYXFVaf6uaaAibAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728918401; x=
	1729004801; bh=g/UQ4Wa2xzdd8hZPp65f1gl6U7da9OFEtJMqAwD2KpY=; b=g
	RYLqODyKgfi1vmMXV+ax4Kd1BowK869oIN156L5vzuqtXiJiM/PFI1I9wSiEYK2g
	41In+s/Ua9aLAnLDBSi8N02NDqdI7uq6Q/pX+iVwxYlGGavG0bNZLNPgrES7aFVr
	lK8XHbzTjnKcwsu92n34IleX3Xa2ZQVu/OV6TTwaUc4MiajCCPryhZilRoWt9IZO
	8KNvQKSAhmfkbHFKNz0TKOB92sJlxMDkD1+YNiMrIvlvncBHai5iy+drl6mADr2x
	5MHXPRj7y0FrDA/rrjVG/zkaajaLogt74KkVNJwqNaj3xvzlBXK/zIDNPO3TrUKM
	THivv5oaeR9AL+83h4CFg==
X-ME-Sender: <xms:gTMNZxPOu6yh3aDw94JDvjAY2cv8SiIxYE9BNFafH32Wj65rVVdjgqg>
    <xme:gTMNZz_slQLVQiU_yqstpyX1Xc7yVye8P5HedmXlDX2M2rs0WR0zzDzrmERf0TNwV
    vfUe_CwbuIE0xsKyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gTMNZwSJii91HoiFTqWZ-fp7B4D-YlA1PCGxZu4fX7aoE-3qm9nGMQ>
    <xmx:gTMNZ9taqcGoMgzOLi7EJVz9dSj3lFSDCVszxQBxIgYo2OLCKUwJ6Q>
    <xmx:gTMNZ5c15IRzBSL7BtP8phvWOpEi0fuNouga2noyURCHpaRhHIb7aw>
    <xmx:gTMNZ50Xa3dntMWn4eR7cFUdYuVVkF-qcemIrogfT9nvgqS2IzstBQ>
    <xmx:gTMNZw7puVnZDphEqxAnOG2A3L7kPX7Bh-DRrfV1_qwx_xVsm1zXgC58>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08FEA780068; Mon, 14 Oct 2024 11:06:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Oct 2024 17:06:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Message-Id: <756c9e41-f53c-485e-b2e0-a67fdc9372b7@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
 <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
 <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
Subject: Re: with git update-ref?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 13, 2024, at 14:09, karthik nayak wrote:
>     It also allows a "ref" file to be a symbolic pointer to another ref
>     file by starting with the four-byte header sequence of "ref:".
>
> This is added to talk about how the command de-references symbolic refs,
> but it can be misinterpreted to mean that it does support symbolic refs
> on the top level.
>
> Do either of you want to take a stab at updating the documentation here?

I have some ideas. I think I should have something ready later this
evening.

-- 
Kristoffer Haugsbakk
