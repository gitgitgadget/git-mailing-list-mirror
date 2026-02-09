Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C91A267
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666607; cv=none; b=aL7VYGKQ6txKQO1IFFtFCw8Q8DtGg67W6OvwrgaVbB/MPZbL5EmOO8cSpNSzg0PHD3obB7+nSCSbPCjU1pLfwWzhT9jQYCw+pbnHHlsAn5Ttaq6LKP/M/MeeI9DgDBGP9dl22qHKcySQchFv5jyQ6jfyI+Cj4EJgkWpglBX9Rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666607; c=relaxed/simple;
	bh=3evYLbTZXlYV3/hqDCtt65/+yHhRYtTBUQNHqvrrCxY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=COVYyxmFigMONyVq84FZRfaKdGf6xDq6tzrBkBGJn78E6SdbEYOTIc6g537tH72D2s1gSD3CrFhPegN8tlSIXk+jymBYlP+Fl4p6ey2ytL4YIp/BOuDB0I2lZJdoUfKRK03VnHf+xGu0nu8/bLLHUg6rkNnWobEILNh5ahpMW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=iEhoJEVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+syvUC5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="iEhoJEVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+syvUC5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EE3A9EC0585;
	Mon,  9 Feb 2026 14:50:05 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 14:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770666605;
	 x=1770753005; bh=jBa8jOBc0tUVe1iyMSsXcIkI9T+2a8/bauW5LhaOSwc=; b=
	iEhoJEVkSKvqlhxE1ZsTM+hM+vj8qBa3NSMq/wJqXgX0x580OKwZ5TkYqhkU4Mie
	L4/tKJox+Z9rKXKDhKmKehWpO2L1rOhx4EYd792QFrTimnj7aDXBw4ymLkrjMuMx
	cSliRShTHYhBaohHA9eraFk/VZELs24PtUY4YUgr99RBi3ozohgAxRM/mQWZTpCL
	l47TQsykzLcU9pBwmoh+fr3NifMgBF4AYoRynOqz2lLZ5fNPWa6Mj1dho5bN+rLv
	2RQX8QT8ci8WOto0eT3et65UCW4gmJpa9W2p8ehhgYLNP5gxxONfM05pxt7/Y7bA
	Bc/kyDLjrPrCPlcFMy07wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770666605; x=1770753005; bh=j
	Ba8jOBc0tUVe1iyMSsXcIkI9T+2a8/bauW5LhaOSwc=; b=K+syvUC5lDxpKCjAl
	gQ89finIiteXLHcd1tsDw+eJw7bkCYwmuBUcJM9zZhCcGLZkMrnDlNss9N05wuWD
	LpJEq8i3ahGvOrzNWkz8x0Ily4bk6PLCE5F5v6gOPTSyETOSLdYSg0AbJxwZaHlR
	xlFQhK+d1RLOu9iCa3Osm4rrR0K63hR/wYVVPBmtuppmN7DrIDRTjYNu/KruA+/V
	KUwuuKpnMqN8Qfc/e5X390JfQ+WhQvaQh/jXaAy2ox53So9eS5ard9uqUwKMVweU
	JEbD8lqsCCKq3dA7Ce9bJ4GQaVcq83rZeVwdHMx81h94a/8fYfMDQ6rlRyb6Ixy8
	rqPkw==
X-ME-Sender: <xms:bTqKacApcSqUwOUx8RdOKjRy_oZWipmHHHxPm3npWUoPJM31ZQKB_LQ>
    <xme:bTqKaZUaQJa8CF9TZ2oy4ydl6tbyIvREYsOWMXlqRlsnFvYBlXX91Kt2kPN7KPlkZ
    6GQkVNxJ_25lnBCAtb9vhGlOLR0E4CaUTad0Iv5OccMd-4zZ5JBBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueffhe
    etfeelgefgfeehkeejkeevtdevueelhfeuteejteejheektdefgfeigefhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bTqKaeuAWY_GSYoHAKWsR5Nq7AidZhPitvFwIcTF_fEBcusxS_9vjQ>
    <xmx:bTqKaRZPbT3HypS9nCzCULxYwOPfpfTetOfENn3NX_zFI3hU7SfgFg>
    <xmx:bTqKaRXupkIbMnlvUMatXCiQJ7u_JxVB_y0kG_Sl-GOVJIt7a1TWcA>
    <xmx:bTqKaV4o7qlmrxEPMSxhULwMVHZe_pL2anREJCoe2ZD-QlmLd56S3w>
    <xmx:bTqKaWHPLnMP1Oc5DacIby671xtpW9poT166OMQ4HKFDqWIAa_4YmOSz>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C75591EA006C; Mon,  9 Feb 2026 14:50:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A05Gi23CChc-
Date: Mon, 09 Feb 2026 20:48:57 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <e14ebaf9-0035-49be-8321-3449abcd9c6b@app.fastmail.com>
In-Reply-To: <xmqqikc54vse.fsf@gitster.g>
References: <xmqqikc54vse.fsf@gitster.g>
Subject: Re: [PATCH] rerere: minor documantation update
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [PATCH] rerere: minor documantation update

s/documantation/documentation/

On Mon, Feb 9, 2026, at 19:27, Junio C Hamano wrote:
> Let's not call our users "it".  Also "rerere forget \*.c" does not
> forget resolutions for just '*.c'; it forgets for all the files
> whose filenames end with ".c".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>[snip]

Looks good.
