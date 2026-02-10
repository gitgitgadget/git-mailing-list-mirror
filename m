Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D53816FA;
	Tue, 10 Feb 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743533; cv=none; b=jrbKk71KV1EPoPRrhv5RYSJuWOJSGZEnG+g3kCVWineA44jUyhgVQguQl67Bo1XG30nMniowSXzMNNLkAgB7A3oWdOQ2cPr0uD2+Uzs82ltTab48V69e5c2WuvD2rubRlT0T6QvqtxUrezUxthNDAvsMVpIXLYQZgaJj12yuhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743533; c=relaxed/simple;
	bh=iJr59b8sTIKisIMnmWAXIMyaR5zWDiBmFvI74XDgJgc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yuz7SZfwzmVfWEk2gv5CxzeZDwleVw1FQoPj/akh6DFWHpLS3yfVomvLpaEcpolgYIzbGLBAVDqtfnF2im9igspXEOX678+NbSsHXtWOpnZl9ZMv1abobm9vSkZEq9o9B6KneWhyPWWRGWxkNuKTrdd+nVtBCRv5fFgFqBz/aGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tjacu33Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pA+aDn85; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tjacu33Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pA+aDn85"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 46EE31D000A7;
	Tue, 10 Feb 2026 12:12:11 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Feb 2026 12:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770743531;
	 x=1770829931; bh=x6hN+TajK36EBH7K2CwyO4a4bC0cYUGum44S0EVLsdY=; b=
	Tjacu33QUTNHhYoy5fB2l+6lvoibFpyacXvyRrslPOajL583ZLdK9DCOqwGZEKZ3
	SnusPJAvwl9kq4oRY+iRX3vFbXVijI7+aCSyDn6ljd5TSRow2pAcai6YVVcMkiaz
	vvz46bAMbRFueWqzOQFRCL+Xb7YiCvrW9kKGEW4gY4n/gZr/gJOXsOaPk9L3JUHH
	Ld6kfmyrdttJl3lWdOCwgnO32etniVTzlRVbh/r7ezokp4OQv1Zw1AbmbN5/uMbZ
	w7dujGiUMl45+dzrft093KEtmSmzYAq/6JuQellHr9NOPNgrWmNZdAfhFAIOpets
	KctS5sr9tNK2yEXa7UnBtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770743531; x=
	1770829931; bh=x6hN+TajK36EBH7K2CwyO4a4bC0cYUGum44S0EVLsdY=; b=p
	A+aDn85NIG2cvVzz9oNv0aewk0zpsiakGCkf6JzJBQTbqN4FZ/6Ua8mvvZBIJT2G
	SZsu6K4jYSpyp8aJ1PMk4l2NHI450xy8KoptSo8nD+YgUZDwmOLLdDD2PJYuWpvh
	OnC8j+EKSbhPCzCa09qUZZ5ATh2iRuRSg49fFej4405NKNR0Lx1Uya408h/ATaZ/
	jf1WakTcZfVfHSgZYHVIUOwm/u3IMrUprJEm1EVyKksWdqZJkVYVnRQ+r8oHMg/g
	pWX4d9TSg9DSQhDW9IBQq7CNtY/GSrEqX8sbfefky2k/ICc0SXiL8RPjrn3KnCJj
	1Cj3HwzMjJ5WXf/toYopQ==
X-ME-Sender: <xms:6maLaSPGNpr1sMVa_YZQEBzPEk0aH_3c9Rz607p7i7xoANuwf58Qsdc>
    <xme:6maLabyiKL2JcRTQMRmsNX5Nm-5-JNWhwnTNR7s2mRNnhIJB8vYkVKOLvHYS4-YtN
    aJ2inW11_PA_rgoihyS9GW0-LqIZ0ADe9680YqM3SWrNUJaDNdOiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeev
    jedugeevfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrlhigsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnrggsihhjrggtiihlvgifvghlihesnhgrsghijhgrtgiilhgvfigvlhhird
    ighiiipdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmh
    grnhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6maLaUasetilluZrUWlI1-UOzigNOTmwOORfeg0enRwCzk89c-3Qvg>
    <xmx:6maLaYWXhusSFISWUJsmaLVcHnY6TDhYRp8V2DDFK_eGNbVa7IrAIA>
    <xmx:6maLaahJRY_uBrFA0lKCgPfSfWQKmjlukg9w52btdkinCDg167DkiA>
    <xmx:6maLaeuN_s7zK0tQ-VoCHupGs1tA5CkK0X8Hdt2onYbrkfkAXP1bLw>
    <xmx:62aLadc5QADXDplbIZocmTgFwikhlQZGDr-FrlvtZVPkxW-EFQ__x_Qm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6DC71EA006B; Tue, 10 Feb 2026 12:12:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsV1kM-kUU5c
Date: Tue, 10 Feb 2026 18:11:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Alejandro Colomar" <alx@kernel.org>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?=D0=BD=D0=B0=D0=B1?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-man@vger.kernel.org
Message-Id: <cf92ae10-7435-4130-a866-e1b30bf2b428@app.fastmail.com>
In-Reply-To: <xmqqtsvozgi2.fsf@gitster.g>
References: 
 <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan> <xmqqtsvozgi2.fsf@gitster.g>
Subject: Re: [PATCH v2] futex_waitv.2: new page
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026, at 17:54, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>
>> Junio, do you still have this queued?
>> <https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#m6f42ff4f0=
cb2d6dd1d68f12a533d04c822b68a80>
>
> Still queued??  Not very likely.
>
> It is a topic from almost 3 years ago, so it is either in an ancient
> released version, or it was discarded long time ago for some issues.
> Given that it is from Peff, it is very likely the former.
>
> https://git.kernel.org/pub/scm/git/git.git/commit/?h=3D15108de2fa0&id=3D=
15108de2fa0cd8f002a0551d14c84505a853071c
>
>
> That's v2.41.0-rc0~141 if my "git describe --contains" is counting
> correctly.
>
> My secretary will bill you for 30 minutes of my time and for making
> me miss a meeting with external folks with this ;-).

The email with the patch[1] seems to say Git 2.39.5 in the signature lin=
e.

    @@ -107,6 +111,7 @@ .SH NOTES
     .SH SEE ALSO
     .BR clone (2),
     .BR futex (2),
    +.BR futex_waitv (2),
     .BR get_robust_list (2),
     .BR set_robust_list (2),
     .BR set_tid_address (2),
    --
    2.39.5

That topic is not in any 2.39.* release.

=E2=80=A0 1: https://lore.kernel.org/all/se6hm5gnd7cyjsby5q6pctkrws5ecp5=
gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz/
