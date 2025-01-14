Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4120F97E
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853275; cv=none; b=mFrpifeoPZ5mTU6hgMsIU2c2ptBx1/xk/la+sxmd1NaSE3ZH/QrxxWZ3g0H1emR2qi9S6gilCWBOAm+D27aaKZAvH9RV4XDax7wZwuFg0i6dlccgXqxCfzwJz2DjisBTdTxO1lmQARdzyc3OrfkGUjPQlwyaStY0+kLbsf+V1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853275; c=relaxed/simple;
	bh=zsphjrcHp/sEQ9XIGG/l6k2WQO/28GdZ82jzRb+s23U=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NbHzlGKLLQ+qe0OpKZ7hCNt5qRPDCIsy97bMMaOpk1QUlwN4HZjJUnM2HsE5M6TcBYVIzEnfkZZOZyMb6YOS0Mlu+44rMDMaX+fAl7q0zXrukW2MrXhsL77TDYSNZ91FNwJr1ZpHmHdyotyEVDvLyaKBuEfIXKJ1BznC8VdBppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SNXsMvgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNc2Vtyf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SNXsMvgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNc2Vtyf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D3B6A13801EA;
	Tue, 14 Jan 2025 06:14:31 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 06:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736853271;
	 x=1736939671; bh=zsphjrcHp/sEQ9XIGG/l6k2WQO/28GdZ82jzRb+s23U=; b=
	SNXsMvgfQZPpmD93HSTNywqvdR4nT/fOyXlxgLshszIrgb5gwxDPXp9zQ8Z/86ao
	0A0HHMtecBwwsAUpu83JLer2LsL0F5ILK57Wu3jd+SOAb38KQCCXcFzaJrX3/RKP
	PNNOdECz8FahR1xN06mSXFfLn8RQyDV+7w1mhHOuNgmZSymWxUirnMlDcS1XmRGg
	zxCWL6gaKy498GSl1Wx50YpWPcyr8pq77hcmkuxwY82EEwtCGQ3Rj+GgCMkmBn3B
	KAhW71IYJg3142cWKV0HJDvzTYvxHbTQxB6x1lZkV2RmVuPH5u6mq4fgE9v/UMoa
	hC2RzlhCJ7yYouvtxHq3nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736853271; x=1736939671; bh=z
	sphjrcHp/sEQ9XIGG/l6k2WQO/28GdZ82jzRb+s23U=; b=XNc2Vtyf9JzIU2uVQ
	wcZ7huKPQYzNaFzIl0dZnUvq2zJsrJel9DeLD64rtDLid2/5BtTuQEI+lnyh3Jjx
	6sy7LryzZvxj7ngnuR4cKqXxLEHXxJRGiSfCKxFCSNXEjd2I+gNkr0Koc0DJ3qDB
	c9zk53Mr2iE9dlv0l7ttakuuxG/8q24IpjDCXxRiPKaUdCsWGFX1wDfCI32LNUyv
	x4sOJMM60BEjeYuRaBA29UX7cIzste7Y/0EYLB3lPP3mUKRxhoOddum1fgBvw4n5
	fbRsmiCiZ8Ny33CJOmWgQJOzR+HGJYCCIjX+xCpR1Lix4ofHpPBc5aCMhymB8oR+
	9R1LQ==
X-ME-Sender: <xms:F0eGZ8rTr_hgthZpr17z1dF2maRL-t5rk5KdP5uFnmG1Tvf-7evCX04>
    <xme:F0eGZyrFUo2NzNvQYUyRAlX-n751PUnAfBslTihuIRPp8_QrH4xrN05XCj4OBq-QB
    _pY7uUBgNQ2BCfiHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeifeetgfehkeegieetudejgfev
    hedvveeileefieeitdettdfgudfhjeeigffgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhvggsohho
    khhofhhunhhknhhofigrsghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F0eGZxMHeq8GAK0VE5_Z0wuikOugaxnydnu1cVGTBMYOIVsBCbcz3Q>
    <xmx:F0eGZz6Bt50msOPiGiJtDeW15FHRRtsfPfsCnxUNv_eiF1tMP61gXQ>
    <xmx:F0eGZ75_qyq4ogZOJKyjoUSaN5Pg1EFaFIuOi0Uic1Sc5atZg3NTYQ>
    <xmx:F0eGZzi02Ed58YigPbY2T-m9_oJYE-w9vlN17kz5wdflbAIPTSVqQw>
    <xmx:F0eGZ1Q2OpkJgE2trQbvUBxZ_FPP83dAVurJ_OcAAYqZep5oMAAbyP51>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 930FE78006F; Tue, 14 Jan 2025 06:14:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jan 2025 12:14:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "tao lv" <thebookofunknowable@gmail.com>, git@vger.kernel.org
Message-Id: <85491d3b-336c-4b48-b16e-962012b4f5f7@app.fastmail.com>
In-Reply-To: 
 <CAFePT4w4hHZnS0TXGA6-_sA-Vp4f3H_sY2Ue1XreFM3SEM8i2g@mail.gmail.com>
References: 
 <CAFePT4w4hHZnS0TXGA6-_sA-Vp4f3H_sY2Ue1XreFM3SEM8i2g@mail.gmail.com>
Subject: Re: Feature Request: Allow `-` as a Shortcut for `@{-1}` in `git diff`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025, at 12:01, tao lv wrote:
> Hi,
>
> I would like to request a feature for `git diff`: to allow the use of
> `-` as a shortcut for `@{-1}`. Currently, `git merge` and `git
> checkout` both support using `-` as a shortcut for `@{-1}`, and I hope
> this functionality can be extended to `git diff` as well.
>
> Thank you for considering this request.
>
> Best regards

For what it=E2=80=99s worth: a patch to add this for git-branch(1) was r=
ejected in 2022:

https://lore.kernel.org/git/xmqqedwgfpkr.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
