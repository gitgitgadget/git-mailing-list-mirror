Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6A30C343
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869966; cv=none; b=T8GUZM12DhbfAP5OVxa3saRydanSazbXQ36e/Ei02VE2ZyUHCrySp6OB36UxkREc9SVJlwFvqq/ddUVSz1FCcn32DED4xQ/HaD0QWGmb7jwli8QIRhHG6GIJPTz212dX0HTuJbTkg45MiYtdsJlNJkDWs1ix3XDew+uhsIbl6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869966; c=relaxed/simple;
	bh=c2RgPs8/gZZBoFG7aIVjYQOk7loOgMHuxYttzOdUhZ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sfLvH7x3PBsz83KH0IdyjKjp+IL2P3lkVQzSxTHdXnncx+b7QMd9D6Oz9v+ZcQ9d8R86IZuavyDGtuqH14ic2IXo7VbyZ56r0QvfX8BkgnQ/HuJignUwRIWhd09mV0e3ZvZbfuugkYVzqdzYGPw18rWykUUZ5echXdaa9tQHmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=UJcwRw4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMI2kCs9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="UJcwRw4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMI2kCs9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AFB2EEC05E5;
	Mon, 23 Feb 2026 13:06:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 13:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1771869963; x=1771956363; bh=ULkL96S1hdHn4Dql9N8m0X9kvNZOoQiL
	SN22BsZthdo=; b=UJcwRw4v5DgOp4afQxmMWEUCLZtVZO989ZuswMNRUuftJqRp
	C3QlwvDBS2upDreJVaQozIen9Q5vRVBb3WedUB00Y5lo+vkCZ6bFuL1N5635uLag
	znN25LBo6fFDAwT64+XYIT9NmOEa3jwpohD9CMHQbShvvo/9Rq7ZH5GmoD4U8owH
	K3jKTxHM+GrfoAVCSutK2BUVzVYHPo7eomHi22GlZdPCIX/Nlpwo5z9GyiWKu9bQ
	xTOA2xh5r8eYCGKbdpM7k6DPCuR2vBfgevs7ha5WzzgSG8+0wDeDwLoEZza+2gd2
	8mpnqkkLSNjYDIeuSDY2g0cY14Dz5LyuZglZrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771869963; x=
	1771956363; bh=ULkL96S1hdHn4Dql9N8m0X9kvNZOoQiLSN22BsZthdo=; b=g
	MI2kCs9ml8XnwAesADTXVIWvDKyy2K6bV7aV1DCbanRfjwOpRsoUzV8QFUq2PGIA
	PLWscmunzADZm5PyuXASHE/W7XZAIgQJDoWOS8WYDv5kZOgcCD1pQmjl+UQhv0p7
	FkgOKS3R10w96uVli4qvPJNGfjunzfnU+8Z5WWklHGSFBq8qbvkxW5sjfWK+zjt9
	eoSDzAxVpRTYmthKxpNmRVX7lIaE7lL1Szv6at7IKbAuKBUHL2ZHlm1KiNnQVSnO
	Eu0UGOAfV5uhXSU259sS7HfBPilKURVXWp8VWpnsdLkCJi8p7sWnLtIroA8BBuWb
	QuZK5d++m5A5mKQpfbQlA==
X-ME-Sender: <xms:C5ecaV2rhCHmXyGHXwZdVP8qk54FGewbT2b5HH5UxfD4422qbeuDnV4>
    <xme:C5ecaW5YvfIb733vWGJDj_Y0lYY3R7pnUTkrp71J9n0xQwwQlUq8rY_rxbPpZthpk
    FcWSN89ya3XUgOK9yc4faDRJJK8b1Wcsdv3JyBXW_3HprQ7BxA4wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepleeivdeijeehgfekveetieeludegheehtdej
    geeigfelteevleehheevheffjeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpth
    hhrghnkhhsrdhnohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhig
    qdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C5ecafbd8VJEz2i4HPZvX865KtZFy7q2F4dw9RqQ4IiZqs0WMTK8xA>
    <xmx:C5ecaf6vzxbfi8CCXhucBWuTnwuHTFEbJkswvAPvTZtq2Md9WEegog>
    <xmx:C5ecaSDgyQUydjr9s3NklUKAr2zmto1AYR1YQ-I7RFiMmfu1fIIr_g>
    <xmx:C5ecaVeHzTdYXf6HPTwOKjAh_OaiHH64RKrZXx4pasMU0VgO0oTviw>
    <xmx:C5ecaSGYD2y6CE3A1VhOgKp1gKtajCLUeCfeldy95f7AZyw2iTfE08Qe>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78FB01EA006B; Mon, 23 Feb 2026 13:06:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtIroVKetKJJ
Date: Mon, 23 Feb 2026 19:04:01 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <af41be2a-daac-4d23-852d-61ff7e0dae6d@app.fastmail.com>
In-Reply-To: <F628C3EE-0600-419E-8D85-0CEA9EEA2243@gmail.com>
References: <xmqq1pifvyhm.fsf@gitster.g>
 <F628C3EE-0600-419E-8D85-0CEA9EEA2243@gmail.com>
Subject: Re: [PATCH v2 0/3] doc: patch-id: explain how to map efficiently
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026, at 03:38, Ben Knoble wrote:
>> Le 20 f=C3=A9vr. 2026 =C3=A0 17:31, Junio C Hamano <gitster@pobox.com=
> a =C3=A9crit :
>>
>> =EF=BB=BFkristofferhaugsbakk@fastmail.com writes:
>>
>>> This is the fourth patch series for git-patch-id(1). This one focuse=
s on
>>> emphasizing how the command is an efficient patch ID=E2=80=93commit =
mapper and
>>> how to use the patch IDs to join commits in a script.
>>>
>>> =C2=A7 Changes in v2
>>>
>>> =E2=80=A2 Delete temporary files at the end of the script.
>>> =E2=80=A2 Consistent footnote style: https://lore.kernel.org/git/c70=
adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com/
>>
>> The latest iteration of this series has seen no responses.  Is
>> everybody happy with them?
>>
>> Thanks.
>
> No /further/ responses, perhaps? Unless my mail didn=E2=80=99t come th=
rough. I
> completely understand if my approval was not weighted particularly
> highly, though, ;)

Thanks for following this series.

I was wondering if a relatively lengthy example like that would be
accepted on such a small (doc footprint) command. I was ready to drop
that example patch/commit if the series didn=E2=80=99t move ahead.

In general *I* would like to see more examples and discussions in the
docs where commands that are better used in conjunction with other Git
commands and general utilities (c.f. git-commit(1), git-tag(1),
...). And in this case, this =E2=80=9Cwrite a script for it=E2=80=9D com=
mand, as it was
called in the linked email,[1] seemed like a good candidate.

=E2=80=A0 1: https://lore.kernel.org/workflows/CAHk-=3DwiN+8EUoik4UeAJ-H=
PSU7hczQP+8+_uP3vtAy_=3DYfJ9PQ@mail.gmail.com/

It=E2=80=99s a bit hard to find information on this on the Web, I think,=
 because
=E2=80=9CGit plumbing=E2=80=9D has been SEO=E2=80=99ed into the silo of =
=E2=80=9Chere=E2=80=99s how you can use
three Git plumbing commands to do what you can do in one Git porcelain
command=E2=80=9D.

But I also can understand if others think (maybe?) think that this would
be too much verbiage.

But I see that this is in `next` now. Which I am glad to see of course.
