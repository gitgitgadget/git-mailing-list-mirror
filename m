Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C013DDAA
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363220; cv=none; b=FROM1hIlq/PSoqYA/NCZwGyKi+OiZe+ESvfUe9uwF/b1QVdEgHwvHvinDhf9Qi35CA9InYGkWLd4pg0LhAF9geaiL8Am1DxVXsK82PTtP1GHlY4VC3o4SXFxhfFoUezP7AJA7DO3kb8YTFqoEpevyME4vVmTqANDz+2evySVCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363220; c=relaxed/simple;
	bh=gfCIeOnkeUZSB1nttd/Jz1hiBHCLSrczyCLR26yl13g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cwiTxzkUS/rFr1w6swNJ5raNAklkGpsJfSk7ybZZ519/IYWfUyCpHw2KDgc7FqjLNed67oYHT/2jZlkvwv2kscUhaxHNgT0pdt+l59vGbXm/NPN+eEpuMrZTBDBCa7hnOHjW1gf8HBrMqCxzMfE/7zn0NykdlpATI+/gxK+YZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=qOy9SrV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dy6bbZd4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="qOy9SrV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dy6bbZd4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD9B51400055;
	Thu, 28 Aug 2025 02:40:16 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 02:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1756363216; x=1756449616; bh=3hHg1mdpQEGg+h9nWMRsQr2X9DV3Nx1k
	xXD5gyBhNys=; b=qOy9SrV9x8rMNAEg6prNcKVeZRU4843fmALR9FEM2MdE/y2E
	Gh40tk7XZu1gsfQVSwhzCMlPoNRAS9RpyvDzLY63rWCZZEPkDdB1a0/Knxy3qUQg
	m+Mw0fT9thkO4CDhixhc54jlGt2Pw7PFK2//Z8WOZtulVGtjcWxipdCnb5ooR7UA
	a8Ahl4iJqoDxVsWcMNizuMh7icz/9DDE6pLTba7k10Ti2uf9dNDMpZI0fwrmlBxM
	TfA7gcUcGfS84XE8Cl4DQfhTXEpQORs11zT1qkFNUtCdz88FV/qAV9+KH3fgVdJN
	iqZJzfkW5pclrIFkolGRpveRMLJ2vbTsCPVrGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756363216; x=
	1756449616; bh=3hHg1mdpQEGg+h9nWMRsQr2X9DV3Nx1kxXD5gyBhNys=; b=d
	y6bbZd4hZCLEa30cnE/a6tzXC0bIamo7paSKN5uT6TFy68/J9ZpejoubFZ0rfe5n
	w7cPbrlEqnolfvQ5vPUstPc8jxcEq3IODPpcAFLOdghsYmi85fRWQyJxc/Ei8zVT
	lRKSQQkuAj/goxnDAXrVXjob0VxvOH8pGILG3rgWsO2U4QztiUGJorIykhXIJFe+
	faj0XmM6boS2Sb+uJq2t4tqh6GqemlxyXL7mHePLxExgTBxBgT0YZgz6Tph30mlM
	m5Ggi5R12JzjCz4LirQ8UtuUIfwQZMS4LqvdC3J39FSRXAfbGUX8itDZuG/TyiSo
	lEkCRKEBkLZRlO/pTgPEQ==
X-ME-Sender: <xms:0PmvaIgIEpatDcvSjhdb_OAmzmS7WeTtx4h-5C_GisKHmxlgwujB3JI>
    <xme:0PmvaBDurS7h3luAbw4n0t6jNdVzJGFODI_H2nCidpQy53Tn10EOC2ZlbzLDt9sJs
    4H25qDxo0B9e1xaOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:0PmvaOF-fp3AiOFnWJjYBpIaxApH7MjtcPSL6ZUmDUbJR6uMjdWDFw>
    <xmx:0PmvaKx53Bi9tKatkLj8wQq4tklRPT3ODZqmhNTsrrVvEHQxFtmj2A>
    <xmx:0PmvaLppq4WtR8sOxfVmFwKqmR-WJLqW5bKgk7Ke19pdwGCWVAonUA>
    <xmx:0PmvaMgGnsk1Inptnldn57mK9EljzyIem_2EFZIEm7tGIuuhsL8ozA>
    <xmx:0PmvaF70erjy4xk4KcN-A8x1k78BXhpyt1_L26Sn1vgkuM4xeS6_NRLB>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55E6A1EA0066; Thu, 28 Aug 2025 02:40:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Thu, 28 Aug 2025 08:39:55 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <fde74862-a5f8-495e-aacd-59429fe5cd20@app.fastmail.com>
In-Reply-To: <xmqqy0r4xuy7.fsf@gitster.g>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <xmqqy0r4xuy7.fsf@gitster.g>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025, at 00:26, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> command being retired -- was to reference the provided hints. So,
>> something like this:
>>
>>   - send an email to <...> to let us know
>>     that you still use this command and were unable
>>     to determine a suitable replacement using the hints
>>     provided here
>
> Ah, of course, yes, with Kristoffer's update to tell what the
> alternative is, your phrasing is perfect.

I think so too.  Just keep in mind that pack-redundant does not have
that part.

I think I=E2=80=99ll use that suggestion verbatim.

--=20
Kristoffer

