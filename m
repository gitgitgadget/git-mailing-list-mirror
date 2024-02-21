Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0055E5E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523743; cv=none; b=B0cm0p2Bxc2QKcJ8X1dAQlZgtoFWPI3FUYhkPDYxbF7ma8YNfwT6VB0/aZ25f1seZEspOheUYZsSTFfEKR/vPHNBCdX3FXmnBCyhORgbzOR9YEAnEqc0lROswOR8mde2MjklZd5Fl+xHU0IY+9nwhgj31M+NwomYyWVtP0svmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523743; c=relaxed/simple;
	bh=DdT80pDIpii+mVl2xZwf0h+l74HWGIDcBQm/FbUX8FE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TWsme83XIOEoV4QzZ25sKJJfYWoXUrF4K8h9IXXRttCGnbpnE79Nk0xyIUaYMuYz5am7NEt/SDSw1TZ34EJ8wpm1NcfH0t4Q5yCd+AZV/aLVh43Tee5sVDvKM9ZZ/GZ9oLMvv36kaFdA/Gz/GJDhHRaY7FK+cYSGo0HVCsX5g9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ahbYQFOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g6XMKCRq; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ahbYQFOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g6XMKCRq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9645C5C0097;
	Wed, 21 Feb 2024 08:55:39 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708523739; x=1708610139; bh=DdT80pDIpii+mVl2xZwf0h+l74HWGIDc
	BQm/FbUX8FE=; b=ahbYQFOVO8nFEoVZootW70VCMeCW/7KfaDzvVQ7ZFBEqmu6o
	PyVGS7/sSg0ER9wDhWFTUTb6i1Ps0SxUv05GDHeHf8UkTJ5XCsPW9S2Apak08w7O
	Yt+VptfvcaKcpE0eD7Kca6kikpv8fad81hU2X8GaNR7JJcqGZQpb4m3RxhZHYYZw
	5OsviixfoMsDEbOV8eaC9YFtMErgcajcQGF/szqRCRgT5myAohidtl60WfdpmVwd
	2qgxJUJTlpsUNPhgS4ccqmSzRjKtDOf8YYahiUD9oNio8/6kvcJfthGKx0Rp03gl
	SWjdZXPcT8TsNNacfyJR39E5tpXisBl7Wo2XxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708523739; x=
	1708610139; bh=DdT80pDIpii+mVl2xZwf0h+l74HWGIDcBQm/FbUX8FE=; b=g
	6XMKCRqhi5K1XtRUJ1Uo9BPQMnE1RpLBHhIjDmLJVT2HH7UzQ8nqibtG+kkjU1Jc
	gCTVqujft7R493ChwGQ+ppl2VFc0A1P3a/crXHFL/869saCbgX88yg689Yl6oHTP
	tJl89UUq5pj0t5obrTwRBBn5ZAc/YoQGJJjw0c+E9sfwWVDf6RaK1VbgHsP38Gv0
	sD1epbvrLB+/+cIqsAbzNnYFx6TpomF0xw6pDq85gaRj5syYry6wcgrU89L44Sed
	vosfLSiTBgFB/dCAEFi2YZKWgZdBFCjeQelTVgryvrpazF/g93m46CJvdJpYxj9q
	Bnh+wWLLI1MNJ9P5BMMOA==
X-ME-Sender: <xms:2wDWZWVvv0keH3_yE5BxZoVEPgXGWl9EhtWtEvQ-6U-MCSrB1cdbBfc>
    <xme:2wDWZSlIqfObiMLAlCCJaf9XOMNbfiYsNF7qvVm1TOTrw_DXBMl9VDkTt5vFjFefS
    uO2cWz2M8eCs_k4EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvddvhfekkeejhedujeefueetleejleeu
    geefieehffehieduveeljeefheehueeunecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpmhhoiihilhhlrgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:2wDWZabnFOFVL8vS073ppuNUbTYLc_be2IyAV_mvzeVC1Y08wNG4TA>
    <xmx:2wDWZdUx8WPWaPOtWcLRR1JpGdCGHBgomVW7SNf-gUV6AMr3JtwcKQ>
    <xmx:2wDWZQlaFyOblG5u5UvV2z9IcRn9XNyvSvIFyB19LEb6Q-gXoaalxw>
    <xmx:2wDWZXsT3bxFlw-Jr69TLuf0ezFXGkknLkPrH41U4ySfTKsnAoRj3g>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3916B15A0092; Wed, 21 Feb 2024 08:55:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
In-Reply-To: 
 <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
References: 
 <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
Date: Wed, 21 Feb 2024 14:55:18 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Maarten Ackermans" <maarten.ackermans@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Breaking change with "git log -n" since 2.43
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 14:32, Maarten Ackermans wrote:
> Hi all,
>
> I would like to report a breaking change with "git log -n" introduced
> in 2.43 that's causing some trouble:
> https://github.com/git/git/commit/71a1e94821666909b7b2bd62a36244c601f8=
430e#diff-380c4eac267b5af349ace88c78a2b004a16ed20c2b605c76827981063924bb=
f9R2222
>
> To reproduce, the command `git log -n 9007199254740991` fails on
> 2.43.2, whereas it didn't on 2.42.0. This specific number corresponds
> to the Number.MAX_SAFE_INTEGER (2^53 - 1) in JavaScript (docs:
> https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Glob=
al_Objects/Number/MAX_SAFE_INTEGER).
> The max value that is supported now is a signed 32-bit integer (2^31 -
> 1).
>
> I suppose git simply ignored the extra digits of the number, as the
> commit message describes.
>
> See https://github.com/intuit/auto/issues/2425#issuecomment-1956557071
> for the impact.
>
> Best regards,
>
> Maarten Ackermans

I don=E2=80=99t see how this is a breaking change considering the range =
is not
documented.

--=20
Kristoffer Haugsbakk

