Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB926982C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960277; cv=none; b=QhUeHJNHPT39vJ/aG0H+EI4al3QR3HqIuuvLFEKigPkJ/YpADdO9bjoM4+ApxpZnPiWx9n4wV4vgvVDCEl6ufkY4ihLbeRQ03WmvycX3WyZ4wALJMEc/zGPUuTj4/0FNlLig2+sR9EX5RWwER1kCGt/wjLq4b0al4X+RLxmFHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960277; c=relaxed/simple;
	bh=T0gqy5ifQu1aDYq6NhhpPxMKQNCIR7EOGKT2azHypIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LMh7uOFmZSfTTTiEhf4KIjQmF1OO+yKzfPrTB7rF5LNq4YBh0u0hRM6OxE290aUbhPlCFa/EakcJ6ofQ9fPnG2sGR3QYztHiaoNg3OEsVhjkzLyMEqt7AU7BE2icwe3YWK6OEQsCrBYrzAbtTgvelDQgbiZhA7JVQG2A7JkmVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Ly7rN8Z0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovFwZphV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Ly7rN8Z0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovFwZphV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 019BB25401D1;
	Tue, 29 Apr 2025 16:57:52 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Tue, 29 Apr 2025 16:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1745960272; x=1746046672; bh=T0gqy5ifQu1aDYq6NhhpPxMKQNCIR7EO
	GKT2azHypIw=; b=Ly7rN8Z0faTBMfgv1js+Xmthzh3qP4daeIC4YBTbBuR/1XSh
	i9/VK1JZokZOMQC5t3ybr/rnrN3tJhWDsX+h58sXHgwlz4ka4ca8GrgItCQ83uz0
	X0mK0Yf5HB5XXUIhk0pL5Vi0czt811SGut/9oH2hKiV/6Z9MdBVjxVlrCwunJx+k
	NV2rBLWuLa5jhjo1du0r/dbUmAjIwG1IHnoHdIXBq0zQHe23MwPw4tglVxGS6QTi
	0ZmtxMrpnQS+pY0XC1MbwP5GFZMb9I2Bo0v/mR6uUP5mS6AqJdqKX8mJtmK5vGXo
	PspFWbgO/YytGAPIR2/DLd2WpHOr/YJi+RkTgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745960272; x=
	1746046672; bh=T0gqy5ifQu1aDYq6NhhpPxMKQNCIR7EOGKT2azHypIw=; b=o
	vFwZphV8fW4KGo8iIA19MUJ/fMsprmub/pi3rz1EZkV9FRiBsN658zRp9X1WE419
	GJbHZAs8116MqIGNT5zn2e2AgXirx36dElQLXWMDFljW6x5jwBecJmqYs+B7e3jr
	SRSd23+N2ajZI/8WrmzFPTOj1t8Ikby2/tJvzAKvyXCYQip+7yFAxJzkaVZ3yGP+
	MBr6/KPfL7PLsQ+Myk8UGBSNqUkBQDAVL2ZHqWhZqW0AakYZa1jIkcLbIbXUDuP6
	3vGAzIcr2YbmSblaPUzFYEOWdiSjrWtkUE6pAKpn6kbBc7346MEIxGTwFKmX4P2X
	bbGUH5wZolySonY2+rKiQ==
X-ME-Sender: <xms:UD0RaOVCXZy0rSYXrxMQPi91pDdxHFwb9Q0aZPR-yTRsHWLsoTBRK5Y>
    <xme:UD0RaKlV4eZJbXQ5qgY4ohRBCHBMPvSJxy-oZALYWjMsHYUP8BFMeiTOgGfgEsYvJ
    yvk7BwRdtJiLgKtBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteekfedu
    hefhleefgfeuiedvleelvdejgedujefgheejtddtveelgfelkeeiveevnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UD0RaCanEz7dYfULLZDCI8uAL_RmQ_xTPGZwkBnbVWmKarcdrjzYVQ>
    <xmx:UD0RaFW7dWZh4zMF6XqjqurrKZ1TFDWg1JnTsVqgObET5v6f2AJGkg>
    <xmx:UD0RaInlDguY4lTuMFKDHsjbYK_q6bq_vFrZ_jj0riO3GpOsfAkaEw>
    <xmx:UD0RaKdtwwByNwwE8SupOz6msELEcILDAU4am2a3TssBqAREtjHvWw>
    <xmx:UD0RaHFQnNAu7ZYL6GiTFF8YZnkQIIADHkJzb8Mi9RWSZx30O_jET4kB>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EFC9780069; Tue, 29 Apr 2025 16:57:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tca5bdeaf935be78b
Date: Tue, 29 Apr 2025 22:57:29 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <527d6cd3-185c-47c6-8c02-7e023b6dcba3@app.fastmail.com>
In-Reply-To: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Apr 25, 2025, at 17:05, Johannes Schindelin via GitGitGadget wrote:
> The reason for this timeout is the test case 'nonsense mv triggers
> assertion failure and partially updated index' in t7001-mv (which is
> not even a regression test, but instead merely demonstrates a bug that
> someone thought someone else should fix at some time). As the name
> suggests, it triggers an assertion. The problem with this is that an
> assertion on Windows, at least when run in Debug mode, will open a modal
> dialog that patiently awaits some buttons to be clicked. Which never
> happens in automated builds.

Sorry for the trouble.
