Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2511185
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838668; cv=none; b=jTajJjndKbMclFF/jIFIC1+CYaMh8iM0OLg7oV6iMasRXKu3EhDtUfvoRMIrcCzOxArEnRKpz2YvsYZFWALiDt810QC0hWvG8v86Ta5yEV5WZxfQ1cCiTDDcSoVPHGC8hK4ffA8TowY2YgFm7qrRPFaaxVFhO/R1+pnrzbWpytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838668; c=relaxed/simple;
	bh=ssl98AeYsvTekpIJxKvPREyKOpz5DdYXxyY16X90TG8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LGiG0qvipBgFNTCtgq/qnqrrN71y+WtBf9YcHSVNhfvpQ2NHwZjUrkQ9r+lox93mBrG/BtiVy0tnh9vEVp/YSgt89lTOQ7nkUoZyBJ6Ssz9iMlcHYqoYt0Ypyt3kww2bT7s+Bcm078QuuIQDzuIMluNrrcJLQ7OkpoZVMsR44m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eFNlGIm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtJcIFuO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eFNlGIm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtJcIFuO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 39FFD1380463;
	Wed, 21 May 2025 10:44:25 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 10:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1747838665; x=1747925065; bh=ssl98AeYsvTekpIJxKvPREyKOpz5DdYX
	xyY16X90TG8=; b=eFNlGIm/7W/zkZgDLMH1Nrfmh53hcoLSkbR++xOESAtSWXF7
	2r7q0eM8iboRtcTw9v169kXSHx+oSg9HDa5LoOZVER5XinPEPQkcI7WAuG0ucQIY
	MkIrfR0UqvqZPYuykYQQCPgOEt5k+UJpDFY1JoUDCKjVq4EaxOrvr25tobVww1Lz
	BOpf2+gDB9cT0eFrPHm64esof5MV20/z89b4Qo8tSo65x5qdPxtWfnyDwGqZQewh
	NuyNtb2znK6bQm1GzcVH+LUZC4NEfifCimtsH5vNtC1gOXB8a1vU5ArfjCFg66J3
	riNHGvPm94u393HtDCpiDRqtrC1i+T2wcEGsCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747838665; x=
	1747925065; bh=ssl98AeYsvTekpIJxKvPREyKOpz5DdYXxyY16X90TG8=; b=W
	tJcIFuOoVcFXdr2fnX7g4h01Xzu6FmQ43In1PJRhe89gOX4FV+N3GAF5NF0r9a8e
	QOd4+Z0oXbwj3LfhBT/o83vspu9bYidDlnrjzFD6FitzId5d/1TMQCbblRS2U8ZL
	XMCzBTz7U4XWC+JWj3L3W89kJ0upUQVO2w7nHZBmFrjxHQr0X1+p1BrXCfII4wgQ
	svKUa+/6foR3RfRKpklcxvfA+S219WbvISjHKOo8bdOxivPoXHFhEF+yzzb9Nrq+
	eRyRTi3c/9PbkWOfpn5yX+RsgbYXoh6UIndKHdYYZx8mXRZiLvrOSHBywatfxhh6
	sFli+y3cYAHWNxjxazH5w==
X-ME-Sender: <xms:yeYtaDu8kCwlXfHyiIP-1GY6DUYhbMtdRmzFbHX0iRx7emrB0TaO_Ts>
    <xme:yeYtaEdDF_sCiRR0iUbQlRIVo988HnwuRyOhj9zyD04lHM56p6eE8fyyaxeDrxSlP
    MeG6m12Tf99jK7moA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgr
    thhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdujeelgfduffffjeelffffle
    dukeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhep
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yeYtaGzHLV7ZEXkiwTEU1ofx9k4ZsbXUrm_3tA1FfyeFVIykoxB6ag>
    <xmx:yeYtaCNdHP-mve6OH1hz1XrC_G7gFSjcdLL10kvRUBa1m-8_4lFd2w>
    <xmx:yeYtaD_eSI3vDEon84GddfHjbu2MHmFQls7C0naxq8lJRZxX3VDTRA>
    <xmx:yeYtaCXXraR0lsn231sSayZ11vEgjTCV96a494sTiFeUBXAx02qUFw>
    <xmx:yeYtaPUJdV7rgTa5d-TM-vYB4nVzzkXD0zjfzhjKoRGNpFR1Inm0ytQ8>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF03F3020061; Wed, 21 May 2025 10:44:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T35ee799f00e81f63
Date: Wed, 21 May 2025 16:44:03 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Teng Long" <dyroneteng@gmail.com>
Message-Id: <a9768fbd-7b94-4eb5-9906-0445c93be1d9@app.fastmail.com>
In-Reply-To: 
 <CALnO6CAMgA1H3_Q+H6WRchMo4L2j_Qu8fdT4JVnfXyHwu97enQ@mail.gmail.com>
References: <cover.1747763769.git.code@khaugsbakk.name>
 <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
 <CALnO6CAMgA1H3_Q+H6WRchMo4L2j_Qu8fdT4JVnfXyHwu97enQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025, at 15:19, D. Ben Knoble wrote:
> On Tue, May 20, 2025 at 1:58=E2=80=AFPM <kristofferhaugsbakk@fastmail.=
com> wrote:
>> =E2=80=A2 remove: mention `--stdin` on the subcommand as well, like f=
or `copy`
>> =E2=80=A2 copy: mention it as well under the option documentation
>
> Ooh, bullet characters. I haven't seen anything quite like that in a
> commit message in my short time watching the list. Neat!

They get through the reviews somehow. ;)
