Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47546AF39
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140404; cv=none; b=qssl79bqYhzY1PnIgbCZKyltfC3Qz5mrKy4dCVhj0AJEHSKovAGjkHluEx7GYvSKNBSQbel98tSsUH8XU4cxVIc+ZUrJ9jsCJo38U9gUFDI6z0ucK4hlLZy6LVaZ/Y4XCG9sGrm8OqgAWEjfF1eK2zOHL1qBbdVBMhJJbSptGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140404; c=relaxed/simple;
	bh=FiDvBWSKIj7lrLNop0h426WaYSRRIsQ3mjfdwxlOT9E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N2PqAS2P7Ig+kSJkQDiorTdDEGe8e7JNQKD0uCcYweE/Ow7TVr+Ku9QQLdY298VKzXwKvlupo5AE0+D3VjvKvYAsCNjKvRbVAn90GZ62PP/2gVBo21jW/5zN2FD7fQSxH5cYgEaGC4lxE6V0kFvy3u+uCB6CkedONCvEsm14MZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RMVD5cCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kK0uQ4bh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RMVD5cCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kK0uQ4bh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D5AC7A01C8;
	Thu, 26 Feb 2026 16:13:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 16:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772140400;
	 x=1772226800; bh=FiDvBWSKIj7lrLNop0h426WaYSRRIsQ3mjfdwxlOT9E=; b=
	RMVD5cCiB6WF3X7v9yEdHZaZvdmQBZEN/EqysAmwONs8fAaB1csQz/sggPoYJ5An
	qy9xBt6CJH8tJVDVYffY74q90VFBB9wEVF5P7exapwlwkUAXDoL83oMt/54q8szS
	GwBZbd0N0a56UeilJODeufaQSdDa2ghSqPdeGcSlB7AQTk7tWIsYNq3J51IB5nnY
	uqrDXso0ruuGZLhMId0/5vft8QKFhGqdJ5q5f5lhvR0xfgCBa5fLqvNvozC14cEy
	sUDI++miKAVKCWzTHdhm6PtHy9k8FaqJ0/vv1NdXagRMQO3P8otFa/TrXQEdVlCV
	FvCL2XkUkaeZyWc/k0SVMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772140400; x=
	1772226800; bh=FiDvBWSKIj7lrLNop0h426WaYSRRIsQ3mjfdwxlOT9E=; b=k
	K0uQ4bhsAJ2IqFZRwARYquQw96lTbA9lU3pFKVT1mcZr9ErMtA3aCOjZgSTjH7oq
	a61+Yxl7YCDwAfG4737iSc1yX2+56THiiB6F9RmtZh1jSOYQFEEtBGYsqVb6Ocge
	2Acm+DOzbKvAsXHSUTjdSJs9OKT/08MNLILjGSR+/gzWvS5SOkOgFI55611K6HzG
	ws/qdw60kj2IYnSbj+44692pkoxbM15Kty87ifglvlhlzHRw0mm+pryL0D7BmZ5G
	/XdOoW8jBJirA+xOx6m+u+/MpRiVieb4Q9+VhlmZb3CHBRxsBrNmVsK0OqDUQgvi
	U/65Rwo3p0sSmXOIHyBSA==
X-ME-Sender: <xms:b7egaUvV16kTHtqA64v7pyH8togbd4BIy2dq-aBr-lPGMO44fX9NERs>
    <xme:b7egacQGOsFk_gC7H6PPa-vYq-RQzukG4zVPnvBfq_j4i-E0xAjPA5xiR7dZg2tIe
    QWXN4pHBiCyONLJavtJ6EQOJpEqpZAizxrmZivDgE85zF66JXZB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b7egaa3b4NG9hLV08_jLAq1LVVlp77DdGLuiVHMPUOf2MUjMzT6uTQ>
    <xmx:b7egaYhELTraUCKAbp5CrKg5acd9_yBN-Xk_CAvDtZwEGonNgO0fmQ>
    <xmx:b7egaWZxIxaD3ALN2gpAI4ULYmBWL4X0sc21kJSrP2KWojjHcI71KA>
    <xmx:b7egaQTTLV7Py6MzbunPX-QU0AKFzXoVcH4Z5nBwFBAN2PdAk_IyKw>
    <xmx:cLegaUMcatpIZwJuCvMIYJwjfGcpda4cK4NfVxfeIAfhWGZcJpU-t6qD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E3C51EA006C; Thu, 26 Feb 2026 16:13:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am6sP3XKy-Q3
Date: Thu, 26 Feb 2026 22:12:59 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <b3b12e9c-bd4e-4585-aad9-24e2df6579a1@app.fastmail.com>
In-Reply-To: <20260224070552.148591-1-me@linux.beauty>
References: <20260224070552.148591-1-me@linux.beauty>
Subject: Re: [PATCH v7 0/5] rebase: support --trailer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 24, 2026, at 08:05, Li Chen wrote:
> Apologies for the long delay in sending v7.
>
> v7 is based on origin/master at v2.53.0-154-g7c02d39fc2.
>
> This series routes trailer insertion through an in-process path, removing the
> fork/exec to builtin/interpret-trailers.
>
>[snip]

This round solves the documentation problem I was complaining about in
the previous round.

Thanks. I will make use of this option. :)
