Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D31D90AD
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354901; cv=none; b=Xbn7ye7ya15U86n2sf4li4mWzgTErbt1hqeQkwck2XC0Q+uvkWy/IRHbFiwEHzRHIApCRvDMNkK2Uo0MDxppZTHG5dWE1BHXQNh0q1nAxl5c+V2ESu9Jbda7qybfXEv28oEzwmaMWXowBvn7mKkgoq2vNOoLjFEAO1//fCLswQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354901; c=relaxed/simple;
	bh=fWUmZiidEllRtaIAibc2A6dL+BBKz57telhsWmtxOng=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dI3t2A/0ZZgUlejluw4WyHbv5vKs/Ofj4ga8PESryGS6pTqYCQUyLzjPzKA3Kq/4g5u2ISErxDTxjbRkdTaLiAP9EFI0K7MVooht+6pcgLhES/p1wkaAABb2hQC0Qp1M9t8gjKVKo/w5hfFImNcTfg7PTiuqRn1jbm4hUfUTC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RVaSY8HE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FV1B7pQS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RVaSY8HE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FV1B7pQS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7926D1D00101;
	Wed,  5 Nov 2025 10:01:38 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 10:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762354898;
	 x=1762441298; bh=fWUmZiidEllRtaIAibc2A6dL+BBKz57telhsWmtxOng=; b=
	RVaSY8HEmLzdYAyd2IPjyqjtW3B3KGfGqRmYQIgSW61ZfEg1Xc6g+Qg/m6G0U+7Q
	p77IiW9+d1Z0FvQtm25apIHUU6QKKmCkM0D1+wJkFw4iEjZNxaa0pGTgoMKsUEjH
	rTc+AkQfnFToi+ZO4RYBSZ9iYzSihIdnxIYnN135GVUFHhPZQD69bBZd3ZLsy6sG
	IIuSroua5TmzAYPNbZV1OvLPfqwyO9BxsWPivdYTKfcWJmXXHfZn+ZPi8Vsf4LJu
	59ctU1ps/6x8VOm3hlLIp+ZAF8KqvqgU8flvZrigtII0XgRz3aCwd8ob1HZR3YKE
	J3/QCHVoP8dNIAA1g5ABaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762354898; x=
	1762441298; bh=fWUmZiidEllRtaIAibc2A6dL+BBKz57telhsWmtxOng=; b=F
	V1B7pQSMXdTua89PXZpTu1qvSGxvLZ3hwo0F+hYDD2/phP+qWBBiSXUvNc1OcQ9L
	411ikyvbZdGV96XaaBy0ttzyal9NI/ofHfPHrrCy+BVrJBFU/kby4Pp95kj/fy7l
	ICX68uHuSp9w2AzU2l497cDBd1AEHMUcT1woa0axuocsfL/jJDtA80jpcolzeJzX
	nLoW2gcKKLdX+JGxQlcbhkdDXlEvfbTHInw9H3cLOLViGSxCcZetA+mw2pjpAqzh
	LDN9QMDTlE3AbbhpjL/D6bfEajmP4YQ8Wo2Z5/8ZD39BGS8Q8fmZbqpwVrqsRNkq
	C7sDK2cK9YmaJB/7p7skA==
X-ME-Sender: <xms:0mYLabLhpavwnG7jfg2_tgkwTmbk-8RXroUGbiiihiZXcfKqhCBJw18>
    <xme:0mYLaZ_YDWa-3YeRvlWn3At8Ru6vbeQYM-j3CujeFKVv5ueZ7O3ZuKI2NlMYqKGw9
    1Gbb6tMOWatzNikWy9IU1CEbVhpAYD30jKeqmAqmmbwxcqLQwGj3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepleefjedujeff
    gfeludehgeehueeffeeftdfgfeefveduueelffegkedtleeukeeinecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhhrohgrtghhsehmrhhorggthhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0mYLafld061hcKTDQavWDv4lYBmqq5vtBkICBOgycvf7ykNtwdTMLQ>
    <xmx:0mYLaak8w2EQpmmmcET6wD15R7z5Xpr3ANgoBncomsjOwYNWqahHbA>
    <xmx:0mYLaYslzuzZj4OAGtmdedrhjuns8O3hX19wqQZMtFot7PICRZQwxw>
    <xmx:0mYLaVlfNjql2m1p5mOu1OVzwXyJ7SMiWceiA52R5wTphp1HqlPp8A>
    <xmx:0mYLaRAdpeeKBQhLKrz6FNhMCU6j4G1Jt4JGyJegD3_EFHn_B9Vm5kBK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9AE91EA0062; Wed,  5 Nov 2025 10:01:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqulyL1FVopc
Date: Wed, 05 Nov 2025 16:01:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.com>,
 "Michael Roach" <mroach@mroach.com>
Cc: git@vger.kernel.org
Message-Id: <9f8acce4-1a4c-4f4f-b8f1-827d778fe6e3@app.fastmail.com>
In-Reply-To: <F8EAD922-315A-42F8-8E77-5C562B5041ED@gmail.com>
References: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
 <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
 <F8EAD922-315A-42F8-8E77-5C562B5041ED@gmail.com>
Subject: Re: 
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025, at 15:55, Lucas Seiki Oshiro wrote:
>> I have seen something similar when using the Delta pager. I=E2=80=99m=
 pretty
>> sure that it replaced a hyphen with a colon.
>
> It's a known bug in Delta:
>
> https://github.com/dandavison/delta/issues/1259
>
>> I don=E2=80=99t think I=E2=80=99ve seen this behavior with `git --no-=
pager`.
>
> I think it is a good idea to also see what happens when using another
> pager, for example, less (`git -c core.pager=3Dless ...`) or cat
> (`git -c core.pager=3Dcat ...`).
>
> Michael, can you run with those three mentioned options and see what
> happens? Last year I spent some hours trying to find the cause of the
> same bug in Git but then I found out that it was actually a bug in
> Delta.

Sorry, I didn=E2=80=99t see that he only replied to me previously:

On Tue, Nov 4, 2025, at 12:15, Michael Roach wrote:
> Just when I thought I had considered all the factors before reporting=20
> this, you got it.
> I am using Delta as my pager. My tests with other git versions were vi=
a=20
> Docker, so there was no pager.
>
> I confirmed that using `git --no-pager grep` doesn't have this issue.
>
> Sorry for the bug report noise and thanks for figuring that out.
