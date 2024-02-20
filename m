Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905676C65
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446048; cv=none; b=WfHG7AK9zK6u8UwgYRcmkjJs65IRw3UzWkFEa9IkhbJyY7+SD6i34iV3j0aQrn7BAxh2A5jg/afTGAVxKuRh/G833uGnp/kn8EDDC+DZF76E5ptD/j7egRIeIn1wOojaKQ5fxxtaycxKzvacnpjo4dwfpgcSMGl2oppFlZXdpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446048; c=relaxed/simple;
	bh=GPNUUXvW9+AVBahkSK+LVBo+Tstbt9PGWLjBFLRTRyQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dZe9A91tN9CBm7OByGaqM1Bla25nV/mM86TNnSqxVSZLAISVcFVBCxTfHFi3yGCIsh4lSytPA4h3ej61rUaFAGttGf/+NQe/G3q9M8MYWoK2KmkWtloODEs1Mdr+4cYV5MpWytCWUQIxmYU+2tmQlehvLnb1JH1fgPkN/EoFTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ENMWzhAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fv6OjmjH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ENMWzhAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fv6OjmjH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1976313800F4;
	Tue, 20 Feb 2024 11:20:45 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 11:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708446045; x=1708532445; bh=GPNUUXvW9+AVBahkSK+LVBo+Tstbt9PG
	WLjBFLRTRyQ=; b=ENMWzhATugb6tF0heHrUIdpJV76vBl/bZm9xLaGAndqV1nvi
	96fDPltwQMBeTYJPZPe9m2gTt247yvV1YQo7r0AxqOv1pCIX+xocPTqX1V4igIgS
	43uy5TPrmJoHFqY1OesIlcNuWvVpErqHrsXpBiaEaoW9Ri2fmQCxZCZJKAoBBb7P
	ij0DA54g+bhoHQIbAGD3FOqHl9TMYC/kY5Sz7FtwkEMx8ni9rlJAHk4Pq+KuevYK
	j0cttHTG7x+mx8to+16f0wBwBWvMKIi5B0w+QQj8fp//y41L4BTbQaz92xLu6hdo
	HTT3TiJi1ss5z+dlIrALkYHekLxmsu5jw2uYrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708446045; x=
	1708532445; bh=GPNUUXvW9+AVBahkSK+LVBo+Tstbt9PGWLjBFLRTRyQ=; b=f
	v6OjmjH0XIDc+rIdzgLDp4NTbvTx1ZoFdWEzDav/Mwj4IkhpexoQufBMtZILT03a
	ya5FjdjZnKtNsX76GtwxuTO9FoN3xU8dSyaIh5JxdSDHnLpoyFdOFWaIr8pkKUl1
	Cxnvz0KPFSA9Myh0OHCQsEHuFYmvdE9Npp5P1f0LnBzXdsUkFkO9I2jH8fDdhydU
	Juxc6Ijxr8O+KNxs7vfFnv2UaGnLKJRe/YnGgI5eH/OVt0Yh5BmxwMTlFHF5VLyh
	Z7lC40dl3PoiC5QSERJZj4bgkm28grEH4SccOyc5ScinNn+CjHcRtE6O2SB6NjwC
	ssCquHi2o6hB/PQNv6/Ug==
X-ME-Sender: <xms:XNHUZdg9f3gcW4TOQsrwjvOGQd_BKUXwY9d5rrkjCokL7JndOgU1HII>
    <xme:XNHUZSCB0zpL8sdr_g87x60VjvJVSvHfIW-hjTwQIx0k_-gh6QFy6YfhsK4qsAPS6
    WamzqAvRsbxu3PLNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XNHUZdES8dJAkg8wcjNYCK8WrX8HyNJ3JpqF35xBm1Fw53KksWXS5g>
    <xmx:XNHUZSQ1HENfF8Db3qzXYzRhKnYp5weq1xQnxlTl-9_TRGxAMrkz-Q>
    <xmx:XNHUZay8NFzsHGvehgHpjExiu2BcA9ufZQe2CI5393uEf_hWCLgdog>
    <xmx:XdHUZUvZKO0bx1eU_NEQhvLKECFOBsp-Lf_gh_M-fw5RwwOYBsdUww>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9CC9B15A0093; Tue, 20 Feb 2024 11:20:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e6f77156-bac7-4ee1-ac88-64627e629401@app.fastmail.com>
In-Reply-To: <dfaed16c-5e24-4dfb-8afd-b703134e5ada@mfriebe.de>
References: <20240220092957.1296283-2-matttbe@kernel.org>
 <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
 <dfaed16c-5e24-4dfb-8afd-b703134e5ada@mfriebe.de>
Date: Tue, 20 Feb 2024 17:20:23 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: Martin <git@mfriebe.de>
Cc: 
 =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= <pclouds@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore experimental"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 14:32, Martin wrote:
> On 20/02/2024 10:36, Kristoffer Haugsbakk wrote:
>> On Tue, Feb 20, 2024, at 10:29, Matthieu Baerts (NGI0) wrote:
>>
>>> This reverts commit 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd.
>>> Version 2.44 is approaching, almost 5 years after the introduction of
>>> these two commands, it then looks safe to remove this experimental
>>> status.
>>>
>> Is this only based on the amount of time passed? Has there been any
>> relevant discussions on the mailing list that discuss how mature these
>> commands are and if they should be changed (with presumably a =E2=80=9C=
no=E2=80=9D to
>> the question about being changed)?
>>
>>
>
> Isn't the absence over such a long time of such a discussion in itself=
 a statement?
> If there had been need for a discussion, would it not have happened by=
 now?

I don=E2=80=99t know if there has been an absence of it. That=E2=80=99s =
why I asked.

--=20
Kristoffer Haugsbakk
