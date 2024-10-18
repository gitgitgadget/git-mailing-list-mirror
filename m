Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6329F20E312
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270753; cv=none; b=LMXFsZkvH/4NnQ+x9t57/d4X8Ovxkr3AeQQiIhO/wNtRqvrq8AWHKW7XFUWg3EaRj3AZ0NXzgGnfzmAZoVhHbsilDK5Jxr6pdf/r4icGAdLiw5AxWvF/xcvtU2uFmXdfQIovsMAueSxYg25TyTh5Hv5uoqORl+AunhmWoBWF9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270753; c=relaxed/simple;
	bh=9FTXMQxkfjlWGGJR4NjM9bxAX5zWnqgsgAYkr69jpE8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TnbUiE5xazOQf1sImeub1vhgZJYByXljJH8nhQjV7+H0P5oE43/1x6XLgKtuAMwlOGhOVpjhKe4sorYxyTqpMmNji20PWbSjNuvHNu0in2YjIdfaF+gpDZ4ANOrPVLZ4M96kqRdigwgUaH6/pMTC58p/Hma+b3r9fRXKdwcICHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KFHdw2MK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgF2CnPo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KFHdw2MK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgF2CnPo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CA1A1140266;
	Fri, 18 Oct 2024 12:59:09 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729270749;
	 x=1729357149; bh=d51Nx6RQkwcxzntArYpluV4qq1dqQtd5P2Zgs4+vJfo=; b=
	KFHdw2MKy9elyweZzLLTYd1qi1Ko4cIA3uA6cICrU1NBY+okEGD/tdeJcJt7YER/
	t50UM07rvX655UccafJkue/NFaslYgJXkJZY9QF8LBLAxlSVDYlMzRyMs6KZi/ne
	UW65n3A3DgVraWGzl6qWlfqL9eReIN62tiwP/jYs/ZmW1dTWnFb1fjS2ifqsenva
	G87k8PDKgfMxtyJIM3HiJod0c9v9zH3xQXc4PFr8z7xqSNeIrZbydsM5b5i65MZB
	v92801KUKX2tC9anao/I8u10pl6NAMsPng//kIkxXHl0/aFxHa/R9IxoUASawJxW
	G+uP2olJ261KlanTiQnWcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729270749; x=
	1729357149; bh=d51Nx6RQkwcxzntArYpluV4qq1dqQtd5P2Zgs4+vJfo=; b=Q
	gF2CnPoxawsM4s9F8cK1VUxDGgXyOksKBJ4S/LX/OO6CnX5fqDR8njRmpb5pbFqr
	xrTGe7Znuskuz+Es5C0+L67bx9Vp99OEViDc3yarzF0GOXwpdCITNv2PH7vVdfib
	tOyUZCoboQu95vjzIqUDvaQhfrr6RXJ/bCD7F6+HAxI4GZIBke15z9TOEeCDVB+N
	t/+6B6q+ann+EVaimQYjGVL5LI4SjUmAu2jBJXbR/zQ0eDyCDJUyJabhzESIMAOj
	es5oqbFBQeaZZmsvvFGWIZUMwuoveTvHr6A2U0VNGLybpdMVYOqHey8FykAc0VJf
	cGGkaSQGAKJLANIVVRTwQ==
X-ME-Sender: <xms:3ZMSZzFQwcg0es50esKexYZHAuvimDs6baUgT7TrLBWCYgaogBzoXVo>
    <xme:3ZMSZwVHfdubHmCgNVoY-jovnXAhV0IQrg3Zfy6A4vAjEgOVxzJMTceg7UTcqlZK1
    P8k_Ipd3puzsPkb_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3ZMSZ1ITIshs-2bS8qvn0IQl6Mw3dNAvJBSEeViPZg2hcgWREHb85A>
    <xmx:3ZMSZxFSWQTMgEcjZy84v6S2lHK6qnALQAhcGg2CBwtMG_LbYb0s-Q>
    <xmx:3ZMSZ5X7srtfE_5D35aVu4q52jLC_z7z81auxWIk5SZj1ZkyyE-Tzg>
    <xmx:3ZMSZ8OYf10TWOx-e7ZQOVuyvnnms393g6teU8yZsATX1Iy5oyu7Xg>
    <xmx:3ZMSZ2gGqAAG2CBioTMM4fEaUEqIy43Xc-8mtxIUqYNFYDNPjt_KKBZE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25F70780068; Fri, 18 Oct 2024 12:59:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 18:58:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org
Message-Id: <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
In-Reply-To: <ZxKSFBl_pV2r99dY@void.void>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local> <ZxKSFBl_pV2r99dY@void.void>
Subject: Re: [PATCH] t: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024, at 18:51, Andrew Kreimer wrote:
> On Thu, Oct 17, 2024 at 04:23:05PM -0400, Taylor Blau wrote:
>> Please do not base new topics on 'seen', as it is likely to change
>> day-to-day.
>>
>
> Noted, thank you.
>
>> > @@ -117,7 +117,7 @@ do
>> >  		git config extensions.objectformat $hash &&
>> >  		git config extensions.compatobjectformat $(compat_hash $hash) &&
>> >  		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
>> > -		echo "Hellow World!" > hello &&
>> > +		echo "Hello World!" > hello &&
>>
>> Not the fault of this patch, but there is a style issue here that the=
re
>> should not be a space between '>' and 'hello' (i.e. it should read
>> '>hello', not '> hello').
>>
>
> Do you mean that '> more' and '> another' should be handled similarly?

What do these two refer to?

The code style says that redirection operators should have no space
after them.  See Documentation/CodingGuidelines at =E2=80=9CRedirection
operators=E2=80=9D.

--=20
Kristoffer Haugsbakk


