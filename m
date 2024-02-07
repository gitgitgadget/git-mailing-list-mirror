Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AB12FF9C
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342160; cv=none; b=B80vWCKc2DrvKvgzq8TGkNq2B1AOV50eaF7u9tHxnk/APjdmlCUxK+rXdVdjHokYRQeGtHFBrp2PuM3AOQ67SMhZpIyRUajm8BU9PNj+6oHSbUkIj6i+wflhOoOcUEFztxbwFzjrVFg2usteD18SYKIocgwtiAnM0Vo+AIhojn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342160; c=relaxed/simple;
	bh=zSP8KZh9peaUg0uxdWP86LaEfsWLkJG6TVP809Z3N34=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g3DnpSoA3OywFXA/Tj58dEaQoHLmGElUCn+cmwpfs6p27vv0p7dhZyR+jKM82vFX+ASiJUoru0HpHLOFWM+0JRB5+BMv4nbMyEtzr8Maftf8ITgftSjFcvmFOuNaVqVhvKWgcxQdWVpooMAUIG9M7OOCfojnOehVy/fTXcFcQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=LkgY6VG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl04XR5N; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="LkgY6VG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl04XR5N"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3402A5C0089;
	Wed,  7 Feb 2024 16:42:37 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 07 Feb 2024 16:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707342157; x=1707428557; bh=GQdHnjVFgL1HnwTe4uMC3wUyGzmVJKez
	PU3fe4aZ+Ao=; b=LkgY6VG2guyCpF0trmyPQAknZvqDloHD7SecWnn/SKFV88D1
	3XzyMJEF6jIwk3dICoSLUq98Iz0ihg9zyhu7R3mn1EMSbDcMr+cLKZoGiZyBYCTg
	DKdQzb/iTVz7HkT0CmZkHvYU8h5tZD/qUXB6Of/2XNDAKj/crenDy5jpBRFcCqfW
	DQtj7CcFXmIzflRIfcVC+HuTJuAZPE0BxwB6NwFeEOPYmJzXf5i0jYusmKTEv7Vc
	I5UTrAUjTt1EFNNq6C6YQPJqRiB6CSClE2FrrNobkzmJdLAaYYAs3DyDEwdIg4N4
	4bI5qq30TSWRuBcgUHL8QqdYX2KlWaRKA2t3Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707342157; x=
	1707428557; bh=GQdHnjVFgL1HnwTe4uMC3wUyGzmVJKezPU3fe4aZ+Ao=; b=b
	l04XR5NIKMhPYHSVT8xcKShSW4G8WuQkvr5f8czVaTz8z6pEre7eervh1MIfN5Z1
	1kcUiOMk0nLYj4EpYp9Nr89Q6eRg2n+OhNJJckq6QNPWGED6pFY3T3aySwnS2Iyq
	s0HhkpkhaudZyQ9aOfnoaMYqvvHmFJeVfU5QkfsmKtTDSBawQv9yAL4UNWXmdcBd
	dNB7IJYqo6WsvyUmyunbh33+6ihj6HAMThpabsVmwf8te7v39Y8X0V4FLLCL/TpE
	CTgljU/i77zeCSuPIYzU5DS6b/OBMzbjJkz41FaQBNMAiFSwJPZz9BP1ytA2Z8g/
	19qAm2fPpEjJCMtnds9BQ==
X-ME-Sender: <xms:TfnDZetJYb8DJK5-m9jk-6bs17yW_aj6EVcc7Xbu-xCkp58NYuTjHGc>
    <xme:TfnDZTe3bxs4WFfW36b3Q29YGITHppv0IrD-JUvMOb_ljFvOz_UNG3DHOI1Yd-mQ1
    EPK165Dc0Yts1iTZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:TfnDZZzEQJ32-DsDYnWVHrN8AWVhb2kF9GVkIxsjBBnP9WmlOkug1A>
    <xmx:TfnDZZNK6_HIWs6YExcPEE3a3nkDYdnkWTspN8OUjOmYAJeyPZZuFw>
    <xmx:TfnDZe-W9tvkCGsSQ9yYVk75rIeNjozPmclmAID7VZSylruIZq40DA>
    <xmx:TfnDZTFZT_bCWtB-9Uq8LeSH8lLBat47_aGjgKSRcJAU5jIbdbyaXg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EA60B15A0092; Wed,  7 Feb 2024 16:42:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7c895747-22a1-48f6-89ce-d518fbd32285@app.fastmail.com>
In-Reply-To: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com>
References: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com>
Date: Wed, 07 Feb 2024 22:42:16 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Ricardo C" <rpc01234@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Interest in options for stash -k and -u by default
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024, at 21:59, Ricardo C wrote:
> Hello,
>
>
> After some discussion on Mastodon[1], I decided to try my hand at crea=
ting
> configuration options that enable --keep-index and --include-untracked=
 in
> git-stash by default. I have made a preliminary such patch[2], and some
> additional discussion[3] has encouraged me to try submitting it upstre=
am.
>
> I am wondering whether this change is something that would even be con=
sidered
> for being accepted. The patch still needs some work (mainly documentat=
ion and
> tests), which I'd be happy to do if I knew there was upstream interest=
 in this
> work.
>
> I would also appreciate feedback on the patch. Currently, it creates t=
wo
> separate options: stash.keepindex and stash.includeuntracked. These op=
tions
> set the default value of --keep-index and --include-untracked if not o=
therwise
> specified (e.g., --no-keep-index) and do not conflict with other optio=
ns
> (e.g., --patch). More details are of course available in the source co=
de[2].

The way I understand it:

=E2=80=A2 You already have a working implementation
=E2=80=A2 There already exists conventions for using config variables for
  defaults which then can be in turn overridden using the corresponding
  flags (the `--[no]-<flag>` pair)

So what=E2=80=99s the hold-up? :)

> I would also appreciate feedback on the patch.

That would be part of the patch series in any case.

--=20
Kristoffer Haugsbakk
