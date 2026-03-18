Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A42DCF52
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848258; cv=none; b=tiWrfaqEFUGMFiW+AWc6XVmoxFwQGTdf2RE3DmKpfy+/EZxRiotfRFZ6tkI+P9qqI1uUTGWxYvqnpKItq0y4mQwIpeoXpKoJihwlwufKJDRpN6y1xpt+q/t8ETxVZGkXWBcI5lXdy0cBEIdMyPNpXaWe/flI62dG8DNASAVK9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848258; c=relaxed/simple;
	bh=nl2sPUCdEg0qGMr8xtYwP0QbUk7B0Bs3HaDUvgZZ3HM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZW1SfBCHap2V3ETNO7J3c6QKcPmEqtpZdG0kUYIi1fCXdiyzG2DxdG7dKdlDiCOF1YQzDwrXFMrgv3en43+6iumVcW2XvF0J/qFS+4vKY1o/CaRZFCP0z2VCmb5fIjZKN7glOjNwf4HcQBs223XHRLC96U/6GnPwMl9etKPDWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n7s0zyj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+KeQ5fW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n7s0zyj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+KeQ5fW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A2D431D00072;
	Wed, 18 Mar 2026 11:37:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773848254;
	 x=1773934654; bh=gylrrAILwn22X7ijJSsZ54cEw5XvFINESsodTfcltO8=; b=
	n7s0zyj4zQ7Adv2jh323piFS6oaps3OlVI7fGadqBx8QLi8NODSuZJCEbjCs/PsV
	ZO7cX5PaXyHaZfKiQw8LkiJi3SVdaMl79yiRoWX7RubFhjgMHkwXM9i09+ElKDMT
	MJPTR9J9UcAWkCi2nBRqTDfXtsEyCEfoiUP33VmhA9swE5JjPbXp9q/DvR6RbBFA
	brp7WWV3nYswxeoyLoAnRAE/gz7DroaRDW0F7q4YokauIWfRveQR5bR8GGyB2hUe
	0Tkj4wieyYaJjokDiqlE1mu70G45qI9GWEhiS1kALy4ncmUIsvZqsXSG4o++yV5W
	0X6wpwNaeM+YKJLXUVdcEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773848254; x=
	1773934654; bh=gylrrAILwn22X7ijJSsZ54cEw5XvFINESsodTfcltO8=; b=l
	+KeQ5fWmZdALXCuvUz7MyWvbIbIKdgae3H5qE9nTZruOERmbRttXjz7eOztTZm7+
	BqKrnTv9ezRyklQvi0xYXTqpf5l3mYVKJ8ugPpriLn6nLAIIpAY3frN3kPV6Kwyk
	Ysn4OUlpw2QpEFyfAWeset+0X1/lJCDbNPV6GM0Q7iWsgwixtS97j2yW0MeTrZAE
	RaRh+A44xA0Jsi5g992wPZngV5rmXULxYuUMa3E1g4MHjqmGrq7+i6119s7t5E0Q
	cvBDofbnNfTs/jqb2xk/5hdU9+gVJI83VgVerEBKxsYvg3IG2AQY0mlQELqm0xP/
	2LmE7DJXx4vKCppOdniww==
X-ME-Sender: <xms:vsa6aVD_Z6DwFy2v991uT27Fcg3KvTydKD2aSr3iDjB60y7G96twJBs>
    <xme:vsa6aeVo-FQbtzs-eiUiLRTHoPDGs2xg7NAq2kqW4Yb1FjzvbFq8-kpbp4I2Ci2Pb
    UhXa-o_f1PNXw8a37zZulHHlFj_pup9xUai6SoUoGLgifwUK4bnGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vsa6afrnECYuBdB5Nm5Z5moZDW0dh9HjFjQlEM2BOESdKGNw8G-5kg>
    <xmx:vsa6aXdvNeUJIQrMJ5dSK_hcd7EzVVNsDmPTU49Jq7MzNt3evc0opQ>
    <xmx:vsa6aWqV2jqH4VOX1__UkdPab_1N2UrCEfvCpsWt3wW0wc_i56psSA>
    <xmx:vsa6aQEonWmA33bVty8Ku-pnlwZ6N87Qkhmfatmv1VFQ-H8ehSdTjw>
    <xmx:vsa6adPFp7SRLpyO59NAyu-Kguqsa9koyY2fHDzyTAth5-hJ4vcS9qAO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 56E6D1EA006C; Wed, 18 Mar 2026 11:37:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkH-poUvedUk
Date: Wed, 18 Mar 2026 16:37:13 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <b0a73540-bf56-4c6d-bc67-b94a824ddbf3@app.fastmail.com>
In-Reply-To: 
 <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/5] backfill: accept revision arguments
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 17, 2026, at 01:29, Derrick Stolee via GitGitGadget wrote:
>[snip]
> diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
> index b8394dcf22..fdfe22d623 100644
> --- a/Documentation/git-backfill.adoc
> +++ b/Documentation/git-backfill.adoc
> @@ -63,9 +63,12 @@ OPTIONS
>  	current sparse-checkout. If the sparse-checkout feature is enabled,
>  	then `--sparse` is assumed and can be disabled with `--no-sparse`.
>
> +You may also specify the commit limiting options from linkgit:git-rev-list[1].
> +
>  SEE ALSO
>  --------
>  linkgit:git-clone[1].
> +linkgit:git-rev-list[1].

Should there be a comma between these two?

>[snip]
