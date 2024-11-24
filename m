Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE202500A0
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478310; cv=none; b=gQX1F+MikzBI8P8m22WE2rlhZIj7kqlLZGXSjN/XhM2U81+KOfukIm8uaQfYlPd0vml3XOP0Ve+wNsKpoqxasGKmg7UDMODJzq/JlWSMTbC3x7gj0t5wiyp7p48Atrre6v5dxHarL9W0v3B8LJhaGNdGw9qW1gwiWvLOyYkUvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478310; c=relaxed/simple;
	bh=4L9Wgr4l3AINqSihMfm3DSawfBUs+EtUrjn/BU3dInQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fh4r00iJgczgvu3Tds2RF/7JylhekZjr1bcE6BpkO8GHgzFk1ns+ZSnK2IYGRwZW9CoxXsk7uBTRI/sQgN3yKD4EM8V9u4/eiCgT+CT2bva5OxWtfKR7Rq7/g0RC5emLSvl5uLVjpXSzZq2m0MADsu8W3usLtGLq/BMi1pj9hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E1UkfSUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtNom7VP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E1UkfSUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtNom7VP"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80CD32540072;
	Sun, 24 Nov 2024 14:58:26 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 24 Nov 2024 14:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732478306;
	 x=1732564706; bh=nfxFGStgamVEwGtaW3TboPwXSwW1V9rQwq1GuRrgEc4=; b=
	E1UkfSUGykmiCq0I58OOIBb0KASCGHbWs/oogKtb0BxuCRTJfm0AoSS49o9Z5037
	8PqSLIQyNOPzPcqaS0pLP5X1M75F8KYSiOJoeCK77a7FUvGmi18srxjkfIEMgdJN
	j4n5pcuKE4HPr3GzqWFWpQmxJYAawE/kClCSfaf0vtzJvGmng4ZLvchywmkAXKAF
	8xrAuCtr8xpdKy6PEoVlp+Z1vckOc5smF5pfvwOs0+micynCc3n3FIbSo5Ri8vjX
	3gYgPTiFkhym8zjAr9EMlwt7uIG59CgH0if1O28b3w9nldSfgUfp62DG0ehg2Kpd
	JHq0oAmZvl19i5a9KM+nNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732478306; x=
	1732564706; bh=nfxFGStgamVEwGtaW3TboPwXSwW1V9rQwq1GuRrgEc4=; b=F
	tNom7VPA2iWqFkGRykV2ZPKGowl3A+fqXNl+GmyGsEAwap1YvYgCBlyrm0IHKZ0n
	C8IRZvjXPtqdGyuyozT2NlcbkJVH0ySu020rbsWRiFf8OpYs7w7SSm4vE6GkHZWo
	RYnZqaQBqwr9nljBzpBS+ob0fSvttWZzJmVLcbqWMLnwwVOJ6SlmnPe2XyaEwv/2
	cAanoGHzkgQX1weWN4mzzuPXlx4laMsfNkqkANx6vdDW0EjfyrRQwehM2JyNOz23
	EHqf9+pLNCB7mn5bgXhtB/WkCM4pFI3yDU4bFVKxZ3LGtBs4cfqXJb0XSImGm3ef
	9bwTebkkRfGWhhSdSD2lA==
X-ME-Sender: <xms:YoVDZ_3-wZtIpRbiD8czQBOmb8tRgwE4lJrfgajHluFG1h8olmFRMt0>
    <xme:YoVDZ-H74lsD9Gv6FrDtasnD6SViePGodhpesIPLa8b6BTq3-_EpAWmn8dRT9fEkJ
    JoZF35dUCKH1mqtrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YoVDZ_68vVadAXxSvKrw819POmG8cFqpmxXAz8qdBRJt4Cu4y9TWag>
    <xmx:YoVDZ00YoSkOsm520S9JLyh-7Y3_jIrABSlkSm7p7V9IfrngcHCbnA>
    <xmx:YoVDZyFLrN40T1YCsY91bv67Sk3Wk2Nx2PDSrBbEaZk975KOFkm4NQ>
    <xmx:YoVDZ18_LvynG7me8HYZZiCpRa9-eCLgw8MlpPQOE9Y_HpCs_-e0Xw>
    <xmx:YoVDZ_OnA_5BlPERLv2nnkDAn928juAa4jzGL6Mj2CLzda4QkDbWlImY>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E08B3780068; Sun, 24 Nov 2024 14:58:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Nov 2024 20:58:05 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <abd3987a-79a8-4e7b-9737-4413a56e288c@app.fastmail.com>
In-Reply-To: <711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name>
 <86b4b485e0b3ef023a5d559f437eae22f2fd458f.1731406513.git.code@khaugsbakk.name>
 <xmqqpln02bee.fsf@gitster.g> <711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer: comment commit messages properly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024, at 15:49, phillip.wood123@gmail.com wrote:
> On 13/11/2024 01:03, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>
>> Describe what happens when a custom comment string is used without
>> the fixed code in this space.
>
> It would also be helpful to explain how to trigger the bug [1]
>
> If I remember correctly it was Taylor who first noticed this [2]. If so
> we should credit him with a "Reported-by:" trailer.
>
>>> Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> It seems odd to me to have a "Co-authored-by:" trailer without a
> corresponding "Signed-off-by:" If someone has contributed enough to
> deserve "Co-authored-by:" then they should be signing off the code they
> have contributed. In this case I'd be happy with "Helped-by:" instead
> but feel free to add my "Signed-off-by:" if you want to keep
> "Co-authored-by:".

I=E2=80=99ll fix that in the next version.  Thanks.
