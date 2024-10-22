Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BE130AF6
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632153; cv=none; b=LT/8+vjSc7lCCT4qYPPih3eRmUJlX84QZBUdTU0L/T8IoWOP4FSB663flMm/cwCgisILo3BrSpC5BhTe4QFYNTlkAB3GNOnyPugDIjjjFxvWz6WCA8eJp9Qut3SYcm0PtS99tX/AqkizhVFa3gt9fscwEp8dNvj9XCTSpfDx9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632153; c=relaxed/simple;
	bh=Io/prdBs5RPkDRajs2xB0Hx6IoodK6ueM7GAvf/+DKM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KXu2o6A3Gc+E8Q0MgrXpxNjdALKDXDqQ755mTSRx72J7bwq+GoJjay3J7vZsiO2CIa95gEXsDaFiBeOfp2iKBGM5tAR3kYWjxT+Qhk6dE7q3V9oCIGVLWIBXjFrpb3ae4Rg7HoVFOJKLLmOlWOrJKKAovnO0qgG7ysPV3bJXZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RQEW3kvh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSaevjYI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RQEW3kvh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSaevjYI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA0111140114;
	Tue, 22 Oct 2024 17:22:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 22 Oct 2024 17:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729632150;
	 x=1729718550; bh=OA+OfTeDnxb/QLPSQD5J9J2H5Q8zsJZmk1TAW/4LYzM=; b=
	RQEW3kvhbSUWaYzl+S0DR64KzGfeTVD49dOBhgxFCWPdzpEMUzF3qRW6n7Qe0jQp
	hCc9GAURNfmPKzBBqUnoRpN4yfj3ZDSxDvZBmE8aNHIjvyRyQfT7ETaoGG1yXyyb
	G5Te4mkO95/Bjc9uuvuw2SDvokf+bfR9nquo8HhWf6FfEb7ib8euPLr6eWva40N4
	q0E6zetd+5QOv2REF2OKNSceXhNWA0Nn4QKcdN8E76qOz5mRhbFPjzQ19Gc9iqo8
	5VPonNbRUfzD/wN9W9LYDiVmS72YhMxwALGW79KNJ+ECvIfHRKn4QRNW57z4d2rh
	CTXiYDYR0qfmppJY2djr2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729632150; x=
	1729718550; bh=OA+OfTeDnxb/QLPSQD5J9J2H5Q8zsJZmk1TAW/4LYzM=; b=d
	SaevjYIhhxpKc3bKmUDhfeVpz2xzZXse+9SLvOcsxs/phPsiLTMHDRYcVVQzEop1
	zQ883/QV2r8xA36MJWpqufOdYkSfghR7/Y8WwmqJhNF6HwzQmPq0u5GWJvgQHfpP
	waXIizbzOX0Y7d9bkk3t2SKQ7lpLNYxiPre7lAfHV4jAVb3EdVbp3kEJhF8qWR5P
	0ot50xaFAAS0k3itv9efOqFAqdyLbidFJFCP37E0r8OCd4FL0RuvWR58MUPvngYF
	LrGOVF3naGg3OwjYIljMFN4BD48SPt55xUixCs1iJlgmAcNMAjnN7y1nx47Me41w
	QdC7VQq6yZECuLTQhtRlA==
X-ME-Sender: <xms:lhcYZ_ODV-zrpsmLatLVNvX65xMTf1M0yPKSaAeujCsyP5H6rl3TCiU>
    <xme:lhcYZ5-cyec-2vutprI5q1fGU8zC74G3zNeo7y7wrcxFTacEQRk_JXcDTFc3VLSIJ
    WymlsRoPTN33SiO0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepleefjedujeffgfeludehgeeh
    ueeffeeftdfgfeefveduueelffegkedtleeukeeinecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lhcYZ-Thgg-aPPpIFKdxNW9AQUTlvaI8qhjM2jGhnPiGVDTsEGKgxQ>
    <xmx:lhcYZztywGw3CnoH4UXWa--ZWmMr7Xmh4tAa4JerIxJSrfcPj733iQ>
    <xmx:lhcYZ3dpOenK-lOk3dxziRirVAF9IlHZhmlVi0pCPNIwR6hMi_MHDA>
    <xmx:lhcYZ_1tzc58GygGCxDdXv6jrN7PpSGxx3sbtz7hUMgAub-lze-Fpg>
    <xmx:lhcYZz62BC5myTilK9wRlDmDwgd96eAvKfwrwkhnSBq_jxNLuaNR_uW4>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3E2D780068; Tue, 22 Oct 2024 17:22:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 23:22:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <ee292177-66ff-42be-bc87-11cee5d8b575@app.fastmail.com>
In-Reply-To: <ZxfhAAgNlbEq60VB@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <ZxfhAAgNlbEq60VB@nand.local>
Subject: Re: [PATCH 0/4] Documentation/git-bundle.txt: promote --all for full backup
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024, at 19:29, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 09:14:58PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The documentation for git-bundle(1) now properly covers `--all`, the
>> option that can be used to package all refs.  A "Discussions" section
>> has also been added to address the naive backup strategy of copying a
>> Git repository manually.
>
> When applying to 'seen' last night, it looks like this topic caused so=
me
> breakage here:
>
>
> https://github.com/git/git/actions/runs/11449483611/job/31855169149#st=
ep:4:144
>
> Would you mind taking a look, Kristoffer?

Ah, thanks for the heads up.  I=E2=80=99ll take a look at it.

(=E2=80=99Tis a shame when we neglect to run five-second-run linters bef=
ore
sending out)
