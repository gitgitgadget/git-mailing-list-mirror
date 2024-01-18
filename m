Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879182E82E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591549; cv=none; b=UcezfriiougmHjsIHCmkK89xuP20OC150bnxTH8/2HKFTdDEzfnkAUbdVUxz0JrwEBhMW7S66NVmmQdWZrDHXTjeevr9u5nyeBWAttso5vdMNcgA5uoAUXVMmdQivZSKdjMle9+Abzqzz2tusJMnpn7k96JyNr9kPSeMAn9FEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591549; c=relaxed/simple;
	bh=Cui/eiZAgV71Igoat9OivRLnQaCCXkm58az5pv3l1Lw=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 User-Agent:MIME-Version:Message-Id:In-Reply-To:References:Date:
	 From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding; b=lENM0+Sr1au66/jXsTC7fDbQCqy5aYRqTeDXbn9cyu3OObBfUDjn0pkoqH/dGuFS3IsRzmYMYGCQ1j8zy/QzuEZ3CMyY4HNGdkpat+QsBOoQkdpa6Nl5Y1xax+fp8N9PrVnLyZJrrYBwjLxVs4l82o9+hOcYNpbCHtGKp5Jc+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZaDyH/Jo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ioJ6Ri/f; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZaDyH/Jo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioJ6Ri/f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5C9675C01C8;
	Thu, 18 Jan 2024 10:25:46 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 18 Jan 2024 10:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705591546; x=1705677946; bh=Cui/eiZAgV71Igoat9OivRLnQaCCXkm5
	8az5pv3l1Lw=; b=ZaDyH/JovRpwe/+H2FqnNVRWJiFYJb9yiu+P6w7FSU81rG8E
	G6cOLuBAuAQYLwhm6Bi276vqhk8nJYEy2Qku0FurtX/NZOEWR9JOQt89Y7z64uFk
	5S0fAkKoO4p9rF30pH9kV3qYvkvuIHBNdD7hh4OjTGJyeYaotuektlFl/z+itUTp
	y9gSA6bputlvBFuqmSxLFptdRxOPiVVJ3bp5vlw+eN9g51CUFDHRK1sU1Eip4BhR
	LTOZELRnXCAmv+7FNXV/tBAmm4R30IxnI88Mh42WiviGw6H/f3WthphCrPVNYrvW
	NVZKZOskSSrSh5xoEhhzS3jP6Fr9Hce4/EUntg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705591546; x=
	1705677946; bh=Cui/eiZAgV71Igoat9OivRLnQaCCXkm58az5pv3l1Lw=; b=i
	oJ6Ri/f9nC6PPFH2EADbqagrwbrYPWBMq6FQX5kCNkd8y1vZ72y6DQSTZHje7P6i
	sBb3vN61g6rz4B1oJ4TCG+V8B0MLPCJeP3RfDwWdl+i+RQScgP1M9Q77IVAsN+Ri
	Hr1rBX8b7BaYQ3kweFVVhb1MjrZnwiOPwWzpqUzOXJJ3lUiuKFMnsc0Np7TKliR8
	yuS/5F2AQip3v5AEsYrN7hqyznDOI8ocmvJpl3LdMcvjDDaGUA4C1KhDYIwOQ+eL
	yIKU7CwERnPZjOJCgA/I2hTdDOXjjTIKlZ3yMyxMS7fUJea1Hhf76JqyCjp20sEO
	nevooTYdsq6McV5fjLrvA==
X-ME-Sender: <xms:-kKpZVQLxsRU3u9w7McWKMrq8ZEQIvrPiMmr_Fl2r8rdPHgZ-in-KP4>
    <xme:-kKpZexm5kd80Hs8ocs3mV5Zmp9CUJbW4sej0dhax8rCcNIbZad2sH01bYZH8bMCy
    s4Uioop6Ax173GUFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:-kKpZa0ygh4yzAFNSjAdkQDwWsybpxi8X-Pys-8Rx6yeis64n6HIDQ>
    <xmx:-kKpZdBtVvkHi98PCKCP-vPcUcbeVUpFftVYgInZNoUKh0RtsfXUtw>
    <xmx:-kKpZehleairZG4XGnQC1T3jINryfUIrowvJrwY9HbqMFTBSUb5SKA>
    <xmx:-kKpZWIYkLrDp2tcHOPB6sz5qPsdyFoi3X-On8Sg7qBJHz2Cysh6AA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1635C15A0092; Thu, 18 Jan 2024 10:25:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <549875d6-b9a8-4b0d-8eaf-e12b72a20e16@app.fastmail.com>
In-Reply-To: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
References: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 16:25:25 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Antonin Delpeuch" <antonin@delpeuch.eu>, git@vger.kernel.org
Subject: Re: [PATCH] merge-ll: expose revision names to custom drivers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> are working on, so that the merge conflict markers they introduce
> can refer to those revisions. The placeholders '%S', '%X' and '%Y'
> are introduced to this end.
>
> CC:=C2=A0Junio C Hamano <gitster@pobox.com>
>
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---

This is gitgitgadget but `git send-email` would probably not pick up the
CC here since it is not part of the trailer section (because there is a
blank line between the CC line and the signed-off-by line). Maybe
gitgitgadget works the same way. Also the space between `CC:` and the
value is a no-break space but I don=E2=80=99t know if that matters.[1]

(Also see [2] for what it=E2=80=99s worth.)

=E2=80=A0 1: On Linux at least this often happens by accident by pressin=
g AltGr+Space.
=F0=9F=94=97 2: https://lore.kernel.org/git/xmqqttwzded6.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
