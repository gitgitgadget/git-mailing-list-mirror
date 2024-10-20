Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C753232
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438486; cv=none; b=RRkN4zsaWqH/TxgwN9qhcTw7Jb4NIcAxBbr+xA4ISbsZGx1mWHAwyZH8t1JMjY6ByNPIosvLjCfdtIIEth1//ejqr+x9JiwOLmYhr3vKyu1PghNFeQEV++WwVVvCikgyAguewDEVGQ4ev9Vv8ofjiDwUI27ghZCuYaZwDeO74mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438486; c=relaxed/simple;
	bh=FF1dxTrye735f2+ZlRjRDG2RVE2xubLzqnL9Uwlm3rw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CzleHJcDxBCHzRptPljI02WoqrHihTWBBmyK440yRWxneBmmQDjcm/1qNdU6Pq6q2Ya9EhqKLtC+ebQ4piewag7ZwWNIEulc1C+ZF5XXetDbYZsAb8O1orDFFRIo0NEQxG7xpuoqcY88Nx7/fyilbkc7DD8aUCMsU6FpxC45xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qMB8rGI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fb/pHmOe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qMB8rGI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fb/pHmOe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1DA0114017C;
	Sun, 20 Oct 2024 11:34:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 11:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729438482;
	 x=1729524882; bh=0ZonRMHT24agadOGdiadLC+9TIZTlRm2WJHeLMGncxA=; b=
	qMB8rGI5immtxuaQ/Q3Fg/fQXhUTJgx/xvmAW2gkyxfmTMEAbnv0/9XcZFs4Vlza
	p59eHsZEwp22O2uT3TOgIId6tiw2q8OBwzvqNyOhltQ0mvvCVmRqNlNZwHgi50km
	sYrFd6Dtl/fg+gYYRD8FjFOivlPRLMEb+/94kVyJJyxPebXIwupHHgZecyAvcUmr
	a0SF1fMqtdaG6wohTZ/NdMYMK48/RmgwTvbF9HBAocltA7GAkFBXFzMSuXE5likV
	fcrAjHVjE8VrYkho0wBrYDHysSiioNs1X5Vezh1WaX/1cM+x/xFrKmpTXyxTL3D8
	rmHEGTuV1TYKu6OqnZXzOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729438482; x=
	1729524882; bh=0ZonRMHT24agadOGdiadLC+9TIZTlRm2WJHeLMGncxA=; b=F
	b/pHmOerTduy5ExILe/mrOGVCJ8LYkDSz7VM/ZS+QNyyHaNmFunibAEDgcpjFyFf
	4WpaD69LKxTIMdHpXBzdg4v0ga6Y1Zo4kUX249P1wllCwkn+cZPB31sjElTUpbFH
	ETZxg2VRLVnHBUA8MT5VMsGjp1xztXNkjPpQnT6J8TFtRQhBew/eH/MxML5cpGa0
	HI09+W+nJgAjodkSfpzJe8OOGvL2PF7yRar5S87XbMAPLp2/mzMIFq941MH4/gwZ
	0C+GQsuwuHMldazAcCvr1UrdQyxhHjR3Vxzb1gIRiWAWnAEloSVTuY4wfGlhp0JG
	EuHbUl3JQHdAXC/DMpOLw==
X-ME-Sender: <xms:EiMVZ5RdHgpoo0wQKlammSxbjhszs12lGNPnxUrHHnUQhCx47M6Bi2M>
    <xme:EiMVZyzsZnuIL2QUmTsotvya-Lyyyo57U2FrttDWOZnPYbaFBH5yoGqf8NZYYYP-J
    4b0Tv-DEzIYhNG-sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhguhigv
    sehgihhthhhusgdrtghomhdprhgtphhtthhopehglhgvnhgtsgiisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgrthhhvghushdrthgrvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhm
    hiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgvnheskhhmrghtshhuihdrmhgvpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:EiMVZ-1u8tqCLqc9yxSpB17qQXhpSATn4hMb-TknKHdCQIYGuGo1Tg>
    <xmx:EiMVZxCVQRZaqmIhoXueIcxNdcjDgIhVvVSMAshweCFcj6CgR5yHFA>
    <xmx:EiMVZyic3OxpOlwVaKaG50sTGGHazOZGRYUAZ3BJa0oMF6d7WhRoMA>
    <xmx:EiMVZ1oJATRreZc5gJnzy9Bn2bLBnIO95OakW_lnAc9IfAERlL_tLA>
    <xmx:EiMVZ9MZJtJfPyeZ4Vy5dyxWXPBhGzfQSNibBn3Eb6iHYppJAvFZeBsF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E8DF780068; Sun, 20 Oct 2024 11:34:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 17:33:37 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ken Matsui" <ken@kmatsui.me>, git@vger.kernel.org
Cc: "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Jonathan Tan" <jonathantanmy@google.com>,
 "Elijah Newren" <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Victoria Dye" <vdye@github.com>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 "Glen Choo" <glencbz@gmail.com>
Message-Id: <2a9a4371-958f-491e-b78b-6d4da51483f2@app.fastmail.com>
In-Reply-To: <20241020152323.90543-1-ken@kmatsui.me>
References: <20241020152323.90543-1-ken@kmatsui.me>
Subject: Re: [PATCH] config: support remote name in includeIf.hasconfig condition
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Oct 20, 2024, at 17:23, Ken Matsui wrote:
> Before this patch, includeIf.hasconfig only accepted remote.*.url,

The conventional description of the current state of the code, without
this patch, is the present tense.  What the patch does uses the
imperative mood.  E.g.

    includeIf.hasconfig only accepts remote.*.url

See Documentation/SubmittingPatches, =E2=80=9Cpresent-tense=E2=80=9D and
=E2=80=9Cimperative-mood=E2=80=9D.

--=20
Kristoffer Haugsbakk

