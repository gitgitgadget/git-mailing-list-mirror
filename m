Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDC311C0C
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896879; cv=none; b=BHqpFM0T+HRjLVsgsSa9PuqkCpyGglhhlFBZ5YTE2x1s40cdfIIwgIOP8MKDCPAJ7nq+J5+6GHDlAKS5WLp/tw8dK62rtq8egYMD7psx00IXWVE2mGMSAZ+Ug7I21YTgH8jKgk9l7UVv87Y5VRdHTxm7urJOE4uknivGrQki1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896879; c=relaxed/simple;
	bh=P7jxSm3CFX/OIV16Y0oEtr1krpnlY2kx1ynK+y6k3Vc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ay/5rbHgRG6rECcPkgBCoTXMzY4tcI/TdDFD/a1n86IOJzsZ8gjFS7GAstMSy89+3JKM09v3m8SgDJfVtD9WJnZFlMTCvfrk6cJRfBmeNJa4QmWtGUpeN6L9PtWAH41JrJ0zeYfOcG9nniMQ+D9jRl0ue7vRRly/tRaCsggJgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=uEdmEJQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F20M3cWE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="uEdmEJQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F20M3cWE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D820A14000F9;
	Thu,  8 Jan 2026 13:27:56 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 13:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767896876;
	 x=1767983276; bh=m5UDMF5AgEEfoBWNnzQadcRyMW2SNjTXNEwdfmaxhfw=; b=
	uEdmEJQrrcD4SOWsb7r4xx2i13t/ky8mtEHSm2pSCHSVHzZwSBlEdpTjRkCC6+UZ
	3HYqiBe5vspimQec2n+C4RoYrKnXDQneZLWqx1YT8J1yI0JZjEdpZuSXv/hAaWnE
	Od6tuKk/e6TygGbHrxlp0nIvyMNtaLl8V+e3kpIjdxeh2IhGJQoZ02ebIgZWTsBB
	YiGc0pQiL1lgoPhXeLYomz4Bodq7X1mYgNMuscomziGE4z9c0gKgi+i+ec/Vj2Ua
	Azqk9w97gLT19AGjuBD/yw9kiYYef53ImxWm+VygEf4fImVNTfMaV5lRUfq5oFA5
	wyD9mgIUTj9bbwctC2M85w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767896876; x=1767983276; bh=m
	5UDMF5AgEEfoBWNnzQadcRyMW2SNjTXNEwdfmaxhfw=; b=F20M3cWEzxzhj+tIu
	4fL1wMqr5YMeI8JZ0b79negCPcVpQm5+5viseKGq1/ANCIXPasCCSVrnkqmXAfgy
	Ehj2feKqsFinn0osJ22Mi/ax28lk+3VasjkTcc5Le+u0ZOhAUmTpWALctxB71w2u
	Kh/JM+2248yXkLtp/gaTM+7eClCt1HEIxbXksCUtCITxNgyJ90ax0VqX34UMyrI7
	TwQfDFpoQ8SBbZ6wl84JRUW24Yt+T9gBuCD/kqUtKFBmzojsnguow/lNlxH6caqg
	H16JaXXx+2SpzsUKsw0Mt2NvJEGmgg/56PlAGqdRpygJlNDGNeAbIdniMCCDqUCb
	RujVw==
X-ME-Sender: <xms:LPdfaS0jcrPrMiucGVoL0gUpMsEFJn6Y09WCjLWIrcz2gxkXIqdofvY>
    <xme:LPdfaf47PkIQU5c7gUnx1JZ0h53C12dU3ENgTrx6soYtKqY6Jr3kUR5Rj9koKdBWy
    -hH55AFJdD_qwNjXekY91uLPcSC73GgkWgCOjcwWzIslsrIAVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepgffgfe
    duteduveelvdffheeltedvheeufedtgeeikedtkeeigedtudefueejtddvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LPdfaZiv7z8aXkMcTpuBeVorNrI65vSyilv1H7ENia2MhyzbD0YfHA>
    <xmx:LPdfab-cymhY26XzkvgqTao0rAAo0_PeWMbu3qdsgNN_YKcFj40jcw>
    <xmx:LPdfaQrV8rJgkonTO_WI-Vrd9jJc_h2GbFkVVCB78I6iX1waQfyvnA>
    <xmx:LPdfaa-cmwtU5VYXwYNlLIi0nF1iztq10Nl5xdjY8drgfex4b3gxfQ>
    <xmx:LPdfafoEFobJqB0G79rQt1bfZQQJDVzDgD5t2crwFhAYBiFT9JxTaawy>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B64691EA0066; Thu,  8 Jan 2026 13:27:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR3XL2-KD6pJ
Date: Thu, 08 Jan 2026 19:26:51 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <52c8f9e2-2287-4a0f-a262-869562cb5695@app.fastmail.com>
In-Reply-To: <--verbatim_and_--stable.1b1@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
 <--verbatim_and_--stable.1b1@msgid.xyz>
Subject: Re: [PATCH 6/6] doc: patch-id: --verbatim locks in --stable
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026, at 07:28, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The default `--unstable` is a legacy format that predates `--stable`.
> That=E2=80=99s why 2871f4d4 (builtin: patch-id: add --verbatim as a co=
mmand mode,
> 2022-10-24) made `--verbatim` lock in[1] `--stable`:
>
>     Users of --unstable mainly care about compatibility with old git
>     versions, which unstripping the whitespace would break. Thus there
>     isn't a usecase for the combination of --verbatim and --unstable,
>     and we don't expose this so as to not add maintainence burden.
>
> =E2=80=A0 1: imply `--stable`, disallow `--unstable

s/`--unstable/`--unstable`/

>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>[snip]
