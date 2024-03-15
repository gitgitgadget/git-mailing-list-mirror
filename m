Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA1286B3
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509443; cv=none; b=M3dof/UaGjEzBE6oEsJ3/3VkKGWjutmR8aPlOamwJQDbmh/6HFhg56H1hSHyDJsGJGH1vvU58Q/HDgJ3Bh97cvHvLHFktMZqEqqwZHzI45c72umUx1PjBMA+sdogwmKLVty7Wy0PjbdoQSV4HKFSlAZ3ot80vUppH4/DErrSdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509443; c=relaxed/simple;
	bh=8km5+mazjBsjpg10GIJsEBFnB2VTbAfPp98uwdg+YAg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UNZfkpQaYBLQ70jVrVfjBOa+v9watnhIBPf98VmKR0mSYUlwmd9guHgQEHbaVj1jR4ZAolRBR0o412KXINp5JModYzgqXP9Pp6Wty6HQz07EEfko+RVAkmjm0xVbFxEMik2kjCDzt9oNvMDy8v7Muk6/xL/1u4V+Q5dhVqceSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=BRQ/8qyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atzLu2xk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="BRQ/8qyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atzLu2xk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6682C1380126;
	Fri, 15 Mar 2024 09:30:40 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 09:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710509440; x=1710595840; bh=AdQiPD/ykrxAUgzuZIkGy8z48AoKBOOC
	4QFimVTVC4M=; b=BRQ/8qyyA6/t25m4f4Fc/PNhV+4DdFW8BYg7s63mCspuZanC
	9wYMX+65q9ZRj6T/oN+CmymT+d/MjMhlCIuiqMqkEK3mnXhEbc/NATvw55nZosSg
	DH7pkFOUUwA0cqtkFRIkb41PFnVjbK/JzzAF9epLp/5xkblhpUcgU9LjnUCOiH/g
	T/E761gMJkT960I/inW0HbfzWQdNuOAdD2YX2jGVEZ/BvjO13+vUKkXVJGqZqNQT
	yXMbf13ksBHLqTcMGPDrTpi6oovNv8Raoy3UT39A/zAjRJiSq0iSUmoKyOgGm3C7
	N3bvsDyLAN4I03TW7lD46h1XjfjMa4qSYziO4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710509440; x=
	1710595840; bh=AdQiPD/ykrxAUgzuZIkGy8z48AoKBOOC4QFimVTVC4M=; b=a
	tzLu2xk07Ua7vMjSa3fUEZq5J7vIpSDSHiowZULQfGPkLwHSD/gGYzNkWcL+cHwa
	DBDEArfbNImH5im8il3tiWN7rIRfDdQRT95gWUvngyZ356KRWQf1CbdJzpurvW9l
	GQirtoepsNfrZQSzJFh30vUvuo4mKL+gmboaFGf/CIw8ywYk69GQi9NJmpe02nj8
	gXQF5v5kD1f0fMumU31KDRH0Gdn7iCXzeTn8MuZ7tLYWmVMsWR3XKbnfuyNSvLLT
	ANKqcCnkQ7aKxUgrCD7+VWyXmgEJzOptIwKeFLhX2bbl1UyUUe7t/ZVC19asRwDB
	VXs//e75aOZ7ezbIjpXYw==
X-ME-Sender: <xms:f030ZQmBxBcpVwEmPvDfJAFUuD-0cjHOOQKKHwjMRjTQgkpZRxP0OkU>
    <xme:f030Zf0i27QLA6oychXUVYLFp4Tuummo9QeYIIIwJu2jADBlWiBF8aRxGl2BpanX4
    j1hF9ux1ggmncp-NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:f030ZeqLWYFFW3A9A0Tw84CrZ3YNHwbvZdZaJQKZ-mjjrvk7HG89NA>
    <xmx:f030Zck6cLMjeELP_yquiUVe2DVLo61L-2TPsMwyw6PvCgXPHKqyMg>
    <xmx:f030Ze1hKffEqtLTK3bICycF-cig4AbQlLQptcEtbMMK9vpUQBCuZQ>
    <xmx:f030ZTs8_LfNgaCKrbqLUVdraLGkF1kYc6acPgHXpw8DPCE5So7lfA>
    <xmx:gE30ZXlm9056hgelTDSR5PJ2-QuLNApHAEooImLC1KlfjIgH6rlLQA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 303AF15A0092; Fri, 15 Mar 2024 09:30:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3128984-3426-4d2a-bbd4-4d94ad43682e@app.fastmail.com>
In-Reply-To: <20240315081041.GA1753560@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
Date: Fri, 15 Mar 2024 14:30:18 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Dragan Simic" <dsimic@manjaro.org>,
 "Manlio Perillo" <manlio.perillo@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

> diff --git a/Documentation/config/core.txt b/Documentation/config/core=
.txt
> index c86b8c8408..c5a8033df9 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -523,9 +523,8 @@ core.commentChar::
>  	Commands such as `commit` and `tag` that let you edit
>  	messages consider a line that begins with this character
>  	commented, and removes them after the editor returns
> -	(default '#'). Note that this option can take values larger than
> -	a byte (whether a single multi-byte character, or you
> -	could even go wild with a multi-character sequence).
> +	(default '#'). Note that this variable can be a string like
> +	`//` or `=E2=81=91=E2=81=95=E2=81=91`; it doesn't have to be a singl=
e ASCII character.

This is perfect :)

--=20
Kristoffer Haugsbakk

