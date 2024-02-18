Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78937140
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261387; cv=none; b=nXw26Dd7a2DqKmgz2ia0O8EHsbnCpoPwiKlLjJNOq6unZO+L+xcWeqw7uZDf00fX2fOU0gZDzRvF3i3CBfMYvwl9oRt/HrkWidMN92CKk0oIZu+ife7eOJOOf61TomBJbg4j1as++by8rFHtRKJZrIiMyFCiLHIF9JaFEwYoap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261387; c=relaxed/simple;
	bh=UvSGfRXWsb4rVQdyDDBh0urX04SUfo7fDAej0O9kpbk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kx38KNHNR76Pc6ZN7SQUaMWi+O/IR3tXwJGTwAp73ntWoc6uKhL7q/slA2FlkN1VR97bz1ZgZVR9cU4y2tf5FY1orFT6V76q9YVgpeypKPvruaXvVH2Q5dxPEc4QAg6AtUJwKVtiTuxikqu6hUW0CgADpzwFY8WdLF5Ugsijteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=TqbM4ALf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlQqFcOD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="TqbM4ALf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlQqFcOD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AADED114009C;
	Sun, 18 Feb 2024 08:03:04 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 18 Feb 2024 08:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708261384; x=1708347784; bh=As4T3C86BU8K/aIQ5vJOTiSRWy8HczQ2
	TF5LRdpybOM=; b=TqbM4ALf4k9r7MTIahsWYcGvXCXbwCadLxffWzwqS1oB2ym3
	plI748a/uJGfPtHfVeNXJpt46qmoxJKu5kTcyS68H2qFBeNY1ydEnEX2+YyR7k77
	zbQ4Xz11i9GgxJQ/9PUdY721UDW/2yMvLY4j/nGyYN3L3a2HVhKRu1UWnXvHy8HF
	ZanJM4EXGepWSRXojKMLjFiFTBwBigK8KA8ff4iN8TRMgGHU4AD6Mmp2JMbtQX/+
	h6KymkSEIRAUVgXx+ux8BmHwJqf4YFr2TBN4t34Ju0Dk2Z7MWfrpv+68RQJ2tG8j
	U+UZJc0fPjd347eYyJvIRL4MtYigXHgulP8u6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708261384; x=
	1708347784; bh=As4T3C86BU8K/aIQ5vJOTiSRWy8HczQ2TF5LRdpybOM=; b=H
	lQqFcODtrOIiWGeRxMWOkSJkmoH4651gV9e2ZqXUT57CQlYV2JD1fTtb3BNVc4Cj
	cJPaf+PKz2xUNeRerOu93jWkxwaoMv2jp/BD25BknRHDQeeL0Rabjzw77P7nwc/R
	YgGOoaFyOAauHQQoXu8sZvEQ24FCEhscjohwuUJJxB5l1mAjemIKukRF/EAjoLrM
	11ctLMkKoOkyNnzGaCYaeDQJtbWDqF0IvMbL2gTlRVEFmbXKqtG5HX3dc0uJ1x7D
	tadxAlgfkJeXzMyqzRk0ciliMepr78KQNmWzQdtga8W2QTW1Dpol5TiUycodatrO
	YDMepKReKY7Qhyg7RFVJA==
X-ME-Sender: <xms:CADSZSYU111OI4c6i99cjGM2sIh2f7akMjt-WSkKUL_wugHql8ETyHo>
    <xme:CADSZVbUq_9b0cweXzbFsxncrgcG3eezB5vJJxtSSHWuFV2FY8M7SRVCcBTNxSeVM
    1iVSuFbwqP1stbUyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:CADSZc8El4fTGtb2bxHpti8yOol1VSm7mo-51dg0ZmoJ2rWcNjhCqA>
    <xmx:CADSZUpyVp9xwd9KkPZwNfJ8i5r2WCMix4bGP-biRR2h7PLDADVD6g>
    <xmx:CADSZdrp-EYH-3ElGa1MFZJxDFQRkJSQtwqEw99akxmrxhxqnDxcQQ>
    <xmx:CADSZeC8KdHHNi0RE0ITdXL_EaadGZxE9vhrKcj-_ikeY1vNTRYjhw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4396C15A0092; Sun, 18 Feb 2024 08:03:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2359c888-a061-44ed-9d69-2aea9e1d3d80@app.fastmail.com>
In-Reply-To: <20240218114936.1121077-1-marcel@roethke.info>
References: <20240218114936.1121077-1-marcel@roethke.info>
Date: Sun, 18 Feb 2024 14:02:42 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Marcel_R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rerere: fix crash in during clear
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> rerere: fix crash in during clear

=E2=80=9Cin during clear=E2=80=9D? Did you mean =E2=80=9Cduring clear=E2=
=80=9D?

On Sun, Feb 18, 2024, at 12:49, Marcel R=C3=B6thke wrote:
> When rerere_clear is called, for instance when aborting a rebase, and
> the current conflict does not have a pre or postimage recorded git
> crashes with a SEGFAULT in has_rerere_resolution when accessing the
> status member of struct rerere_dir. This happens because scan_rerere_d=
ir
> only allocates the status field in struct rerere_dir when a post or
> preimage was found. In some cases a segfault may happen even if a post
> or preimage was recorded if it was not for the variant of interest and
> the number of the variant that is present is lower than the variant of
> interest.
>
> This patch solves this by making sure the status field is large enough

You can simplify =E2=80=9CThis patch solves this=E2=80=9D to =E2=80=9CSo=
lve this=E2=80=9D; see
`SubmittingPatches` under =E2=80=9Cimperative-mood=E2=80=9D.

> to accommodate for the variant of interest so it can be accesses witho=
ut
> checking if it is large enough.

=E2=80=9Caccessed=E2=80=9D

>
> An alternative solution would be to always check before accessing the
> status field, but I think the chosen solution aligns better with the
> assumptions made elsewhere in the code.
>
> Signed-off-by: Marcel R=C3=B6thke <marcel@roethke.info>
> ---
>  rerere.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/rerere.c b/rerere.c
> index ca7e77ba68..3973ccce37 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -219,6 +219,9 @@ static void read_rr(struct repository *r, struct
> string_list *rr)
>  		buf.buf[hexsz] =3D '\0';
>  		id =3D new_rerere_id_hex(buf.buf);
>  		id->variant =3D variant;
> +		/* make sure id->collection->status has enough space
> +		 * for the variant we are interested in */

Multi-line comments should have the delimiters on separate lines from
the text. See `CodingGuidelines` under =E2=80=9CMulti-line comments=E2=80=
=9D.

> +		fit_variant(id->collection, variant);
>  		string_list_insert(rr, path)->util =3D id;
>  	}
>  	strbuf_release(&buf);
> --
> 2.43.2
