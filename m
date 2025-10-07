Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D52DE6E9
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839680; cv=none; b=YzGA/ylB+0DX1yIpSfmT+JSYqYUROE/gjHDT8oGWbpDmurd0MvFrr3v0agU0OZWLLJW/Ryk4DU6gsCcKgFM/GplCT+hgrlR/oaVcafSXrn6vpHcUm2v3alWW/tO985wQPsnNtSlM1Zz9wEDH5R1FgCD6ibTd74erRtsjrNSdHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839680; c=relaxed/simple;
	bh=vZQSUSRkqUH9nfE8Gc4oxPoyF2OMinZI1OCZlMtiqq0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YXF7X1O3o1ZsbV6fo/mXIGwSu/YUMbO2uuu5f33L760TiDH2gvX4L0xzdsTFsR6WBSJVAIVujWrU+XwwZrwkqlpf78+Oa+6iHLUNlXn4IQzv0X3JDPH+y3h9mv3iMmNPGD53Rr0dcPzW9nvWsW+2eNn2msP/K03hW+K1ZdNz6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Dm5mQyh8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uOJ9cCl9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Dm5mQyh8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uOJ9cCl9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 149ACEC000B;
	Tue,  7 Oct 2025 08:21:17 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759839677;
	 x=1759926077; bh=vZQSUSRkqUH9nfE8Gc4oxPoyF2OMinZI1OCZlMtiqq0=; b=
	Dm5mQyh8u5DjfwMDEvQQA+UA7o75Abpt1yVg1JRqTMUZCYL0+J0oNvBCAb4hjDo3
	1hhRCccJgHKYFTkLbMFWsxDjwdL6mJ7VfKB2aoT49jAoVE9BPlkzF1X9YwJ2eztD
	aYLK2OH7es81qtpdVe27OAe4JwCKOVrycm339c21v5t4DDgFDQD1Xj3zIRrvrFo+
	yOxe2Zk5khG9lOoV0oCwA+y+GUPwUt4Mh46Jdica2kSQ7WGs5MydCyEhpGKDVXqi
	e8xbZnYXPIlYohGOVbIltDPTx8cvhSQ/yoWyVecN0r09v6c5kz+xuChIQv7qijmy
	WGfdNIdd2DvK1ifhBC6BNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759839677; x=
	1759926077; bh=vZQSUSRkqUH9nfE8Gc4oxPoyF2OMinZI1OCZlMtiqq0=; b=u
	OJ9cCl9RV+YoxGUzofzZ1rjdPgCMk7C5tPjkogoB/kYM7glOubDmsJQxbJmwMbH6
	LyM8C1YICBR/f81HLvIbiKSAFuchBUC/4k3k91D1iaWAu0ss5slWixgv6KkG6r86
	HmwNAE+i4UNBGnHJvWJ5Ovko7IkEDbFlY2V9rVXu1lHTWu767LDNpBHvlI8nQIzo
	84e9Su+gaWfYGtKJeKR4KX255xJLOSX5mvE5fD44w1NrDVXz1KBJ5rDpgTP+SAew
	kbOdf3nOAcsaYQ3ThY7zK1SanwQrqQVfIy9bUS1/hmDfi6rHxPXAqzkP15/E9aaQ
	d4zd4X3FOJ/Hq2sYNEK+Q==
X-ME-Sender: <xms:vAXlaANLsChGxSLAagteOeo7Z0TCb0lD9rEvXEM5u9Wz9PvIX8UyuLU>
    <xme:vAXlaBx2x1Ks21pDBI7csRj0dat0O7a0UNDjZRRsVDWiuBwvHXtG48RBDCwiO3mn-
    UiIUS4AotGVKfb16qDA0ulno1TRi_utJfh4uFG2TO4EkOTSBzof>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vAXlaHtHIXDQUaCumpgVMSvj86orf-FTwg_07BPYhFqh76GMyv-eeg>
    <xmx:vAXlaDYQ-MLGAf0hOaMhCO7dfuw6HgSHqeVxwC2iLXV3W2sTeWZDrw>
    <xmx:vAXlaJzh_7X2DwGNn4tfkmN-rLUkEiWd2NkkyG6lqgAuYkFYPkK9ug>
    <xmx:vAXlaLg7Q6WwlYnHS2gXHJ4AnF7KWGlzbxV-Iue9owqZY8U0ba9DKA>
    <xmx:vQXlaMKzAcNQSrWXtwQoEOIJhdZUJi6Yz2nKNjh5biYHFR82Bsw7Onir>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 475461EA0062; Tue,  7 Oct 2025 08:21:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHzS9LaTdmnB
Date: Tue, 07 Oct 2025 14:20:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "GIT Mailing-list" <git@vger.kernel.org>
Cc: "Patrick Steinhardt" <ps@pks.im>, "Elijah Newren" <newren@gmail.com>,
 "Derrick Stolee" <stolee@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <b771b1ca-96a2-4dc1-8c66-0a3006f18565@app.fastmail.com>
In-Reply-To: <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
References: 
 <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 3, 2025, at 00:12, Ramsay Jones wrote:
>[snip]
>
> In order to address the first set of warnings, simply renumber the list
> from one to severn, rather than zero to six. Fortunately, this does not

s/severn/seven/

>[snip]
