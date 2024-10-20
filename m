Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1D192D7E
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452843; cv=none; b=upfT+/Ahmm0ROvvSoMiUytaexRX5CmF0heGIJtaHOO9aU5zcKCK4QqaKmfTu/xIb6vff53FCJukZl/Ihc4K9j36ermNXfX7F1HWxV3r3b1AJuCrOVVb3JKICRMymK2ib36lLjaUMSW+Z5c08QiJh/MF1FSOKx4j0f1oTYpT+9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452843; c=relaxed/simple;
	bh=FdxWKYN0ofBMgBdQtyA7ncjdirWkxCoyog1puPf4/UE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VPlFj0b5QhQh5dSdcmrCAl1vphguCQ4jxnPPWd4NbC/zh0fzXWOkh+oS6ha0meJd4fHvq9J6Nwpz6LdPfbcJlL9N8b1tQwo+8wF8NkRgbTLjSWp26lrpRwDb+9Y7qBo2X4tMOBl9fJzt4jrpkm09OnYksLbUqveabJEwR9o+f+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aJqTLUsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgvON8lg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aJqTLUsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgvON8lg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D9E41140170;
	Sun, 20 Oct 2024 15:34:00 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 15:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729452840;
	 x=1729539240; bh=maaR560uX6z8ik/9VPNHbdoWXraY9qGaDEPquCsYhfo=; b=
	aJqTLUsSV09EwbLTRMF7f4MTZvVm6MkdwHAhGHsrwyt0wLXetn3r3L9USmEje2xp
	nX7ZevdnIADA6JWgU8Xlho2pyxeHVwN2melzivULRHli0JRY16K1TxN+Oot+55vk
	5IhLc5czwmMlnFw5/UsS7bZpVF0BS8tBhZ5s5p8SisGBYpvrHxNHOHZzr83gUZmt
	XVl7Mbobqu0VtEERB74+6IcyS47NDB3iN+2yO+vVXwvnQXwAFfOCA3pdAS7eYbON
	wpXYGGJ3aFU4qnU/0PNpvd8EvF4Vxmz0fAKXuFlymJhQ/m6nnF59manpAeR0I3I3
	SHY904bQgozmAeyRE/NTvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729452840; x=
	1729539240; bh=maaR560uX6z8ik/9VPNHbdoWXraY9qGaDEPquCsYhfo=; b=W
	gvON8lgdCTSX3pHdkVjqiomKFsLul7R+oaV3xJI1N7MFUshzwK5GHIXIK0Izjm+8
	QtLejU8SjvcZYdkc0I4t0IxQxAzl/LN+ObZHxUdpHu8Y3LCMOOephGnqm5J0uB1d
	cCyPTK98TiuxPMPUBthnWDj7k6lYoo/ZExy3IXajTjL6VQsI57IoYf9iFUEgeJn8
	3FkkwVqpGUOZ3AMDQW6sqwMGfuzESvvhS+A0vAY0Md75Ewpu0V/K+dWSTUaXX9RW
	hkHkQm09bkC9v8RDWHAb97AJDqM3ewFNAT5GxFLucWh/MFhEYHSmwt7hKL6kTcxI
	6pFjCMz9W0L974jv/9Esg==
X-ME-Sender: <xms:KFsVZ53Hygl3p7OggJ--MpKeGNzFXdbn-z8VVE4EzeGjNtUMx3bO7bo>
    <xme:KFsVZwEoYM1Bz3xNdwsboQz9jwdNsoPj7R6aFVHC29jLaOQOuYP-V72A7YNWpTGkN
    FlM-cId9E6bbdYN0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KFsVZ55GLoy9xodxlEzW_GG8W99YWa4XJsEvbnOwCb1cAvee17PqoQ>
    <xmx:KFsVZ21xsaXOsEPXXpgd3ptkEomRiDPLK7LSt6nMfGrZziod-GohKw>
    <xmx:KFsVZ8H9NEvN2CBXmbZzX-4aBhdnOIlwVL5p0n_HVAIN9N05T2i41w>
    <xmx:KFsVZ38NXm6NzDdHcKqdNFZtcZzM4CDRbtVlbdfIs4Xso7zb8cVnaQ>
    <xmx:KFsVZxSiH-R-6lPWj-7sMVtB9RVPS7bPxoD5Yzh5KWuwaJgFJUsJYyQr>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52E65780068; Sun, 20 Oct 2024 15:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 21:33:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <0eb35890-6193-43e2-b3ac-7c26b2360a03@app.fastmail.com>
In-Reply-To: 
 <39bdc5941c7b53c432966984fa79b81fde978e86.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <39bdc5941c7b53c432966984fa79b81fde978e86.1729451376.git.code@khaugsbakk.name>
Subject: Re: [PATCH 1/4] Documentation/git-bundle.txt: mention --all in Synopsis
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024, at 21:14, kristofferhaugsbakk@fastmail.com wrote:
> prerequisites=E2=80=9D.  It deserves to be mentioned as an alternative=
 to
> `<git-rev-list-args>`.

git-rev-list-args huh.

git-rev-lists(1) has `--all`.  That must be were it comes from to begin
with.

That=E2=80=99s why I kept looking for `--all` in all the wrong places.

This patch should be dropped.

--=20
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com
