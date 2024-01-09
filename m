Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853C39ACB
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemon.garden
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemon.garden
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lemon.garden header.i=@lemon.garden header.b="hGkq/xOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3YP9pMUE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 073343200A81;
	Tue,  9 Jan 2024 09:42:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 09 Jan 2024 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lemon.garden; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704811355;
	 x=1704897755; bh=+2sYR8gvKDpjNhVLpp2tJX4asNhXJFkeb8qeLkeE+Ds=; b=
	hGkq/xOG8UuYuttMprh9jEAdieQyIC2eCLlLfmL4muEznHdC16vaLu6/7S8V7WM4
	heCPZdjv05XMI23E+EhVrxRptXXltYOwytEzWQZFLKDLIUyoolklG5OyT4k70k1R
	PaTJb9ZUxaNIKMBpkUVoB3r2KKNZi40GPDln6qbb9b1gh6lEcvmVwBlK+dl2Zii8
	hc8cYMav0MkVIE4ujfyB8l8n+Qkk0XCJEInSO28FoChgMRhuTbCBXZmNyf4BDheH
	UL3c/HVALqcAwWQdV6nN3edY9aXfwH6q30SvjbueyIeZpLNpu7NTV3gqVr87oCg6
	+vavSi2rQ7/7AETX8aJWfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704811355; x=
	1704897755; bh=+2sYR8gvKDpjNhVLpp2tJX4asNhXJFkeb8qeLkeE+Ds=; b=3
	YP9pMUEEzJqwMrRvGFwUEYIgoYvOwf00f+zrfdHcsuFNppweqoWmM8oW6MuxbdNq
	c8bpZqDrk/6TZnpjgCeAsehBzn0tC12/HBi2B00NG8YNcGJfnkzX9jzhKDWLOXA+
	8YmjSC0JCMuP2mWpQSjarsbi/7zRMewj5UmGzxEvGvO6GnpEVqTE3kd/dNG7LWiB
	rFx97q8Xg5IvF5MfN82u2XIEQvkR16/XPI+iW4ED4ntnd1jE8VPab+NFrOn8pf/c
	iHgrFTvJCZo/Uz00t/SwCk6J1UUJ3Lr1fWF343DRbUPce3jgTYRPIY1elJfxXF+D
	bHX8FZQPa0wh86cbe+V2g==
X-ME-Sender: <xms:W1udZcs00LafruacTM3J_LGG0jufgMYlv_Z8ArXqVC4mmQL7-KN-rA>
    <xme:W1udZZf4LuM6mWFPUq5fXwvaBqomWyUpwyd6FLzLYICH77zNPRW9kCKK4HPKRHyVr
    T8K7RmNS-g4BGM0t5U>
X-ME-Received: <xmr:W1udZXza6wKyH8wJHTx6xB7yRG45MvpxZ8a9fleSkDMQHVkr6M9gYqrgU03k7Eq5MrlsMGsdaNesCC93GrgMUXPm8gr5wiPiAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesth
    hqmhdthhdtvdenucfhrhhomheppfgrthhhrghnucforghntggvrghugidqrfgrnhhothcu
    oehfrhgvshhhrdhtrhgvvgefieehudeslhgvmhhonhdrghgrrhguvghnqeenucggtffrrg
    htthgvrhhnpeegvefhueehkeeivdefuedufeegtdeuteetkeejhefgjeektefghfehleef
    teevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfrhgvshhhrdhtrhgvvgefieehudeslhgvmhhonhdrghgrrhguvghn
X-ME-Proxy: <xmx:W1udZfPa6lvUUFEpZ68nPkgEQWu3CEzMaLu7DRUKK-c6qfx1k7Dj8g>
    <xmx:W1udZc9P_fEv96a7Uv_o6zsrwP7VCkZFabRv1JDMVr4QqByKIfu9Ng>
    <xmx:W1udZXWRSTSpbN2ysXh_5uylMHkKv1iAsX54Xns9_wE3kGdFl08Nrg>
    <xmx:W1udZRFLU529q9KXfnULxNNedR-tBaWFkqx29c85B-J0JkhprHDZBg>
Feedback-ID: i28a14937:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 09:42:34 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Analyzing a corrupted index file
From: Nathan Manceaux-Panot <fresh.tree3651@lemon.garden>
In-Reply-To: <xmqqh6jnk3i8.fsf@gitster.g>
Date: Tue, 9 Jan 2024 15:42:13 +0100
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <29D15110-E308-475F-A722-1CDD448CACDA@lemon.garden>
References: <B38C5D82-33E3-4D10-8119-7E0D59DD3DA2@lemon.garden>
 <xmqqh6jnk3i8.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

> On Jan 8, 2024, at 20:51, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "git ls-files" with its various options is probably the closest, but
> even the command is not meant for "debugging the bits"

Thanks for the pointer. In the meantime I've started to make sense of =
the binary representation, against all odds, so there's hope for me =
there!

