Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E33D27E
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657964; cv=none; b=lel4CUSxQmM0W3zfe1rcARfY0aOUqgh+XBByBiPy8kVW9VS6Aad3YqaCw5xaaPT7ma0F09Pw8SOBrawlU8wz7uFYJIW0eDIMofyBsn51MKKzznUCZjo7p4EoFIjSiYq6y19K0HdeHjnh/zJc25s3M4Gug+YscVmoPcR2qRwpthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657964; c=relaxed/simple;
	bh=wMjSqkSJq4uwo92JU575NuaaDw+tl08IRirqpMmms60=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kX/KhxiYkaK/P90sWLXP4jYi9dUwK2sB0j6bda/jAFJVqMpz0nTT0ioVA/v7DFUsC2ZlwCP2Wa/g308l56gvGOVUndRxPnexixsrLd+q0ik+TfHfLkthiLiErGtiyvxruz4toU78f7826tSC6U4OvOwHh7DpgOI7wL2S+qLiTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=YIc1eOy8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGYdqf+5; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="YIc1eOy8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGYdqf+5"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 366D318000BB;
	Tue,  5 Mar 2024 11:59:21 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 11:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709657960; x=1709744360; bh=DB3D5HyYJbb7ATX7lgHv/FvmKPmlD6C0
	PBdG5a4OFi4=; b=YIc1eOy88pflmfAouddO84oyYsn/rBC1zCAaT1Lpp3C6hAi6
	sgLtCq9oCNXcHlcVhWGDU9n+pkoNfZ7qnQPlidAFLa6GgytoZooybBV+myD9kVsK
	BgTBABGNswUOZbxD5azhgZTfIBMaLbJce3nKie0Ga9kNCvh6cWVYKmQ16YjnF5v6
	O2sSyNRYlMdQlrvpaTQkDoJWnPZK3hGpZqQQpMV1Jmz3QQD3jbHqO+LSvB3eAm0z
	c2yDBJ3Q0icEJbwmBbPhRofmT8pPhrH9BnkaM14/k15vV3yAa4dk2PwCv6cvVzCl
	QcZ77MaX/lIctBhShY6Ng6PVtJ5CcUFNzVS2dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709657960; x=
	1709744360; bh=DB3D5HyYJbb7ATX7lgHv/FvmKPmlD6C0PBdG5a4OFi4=; b=V
	GYdqf+5qALnEUr0OrjwT9R8aFIatvklZOStq0WbjYd7HV19kgX3XySzUWglj1cuD
	zSUsKHmNwcYfvDFIGPP9aN5AP10KkYQlsUdKwM53PI24HS0CEsbzi3jwYPlreyvH
	Yj7QbuMhppBLOhidA9GLgneogfhW0fOrYQ/PfkteW/vX6NKk6PpwAdtP/AcRglAi
	jQIaobwv72DNFMnn4wi2LC4N/agnvvwFkWoZ50y097chsJ3olhzbdzD6cvE0hkvP
	NkV4aLxbbybh9ktABsQW7ON8k9hkq3vWxVUK5vOyRSeVmOgOtu6F6UEM9a/LMRe0
	mY4vYiX7T1qsptalabjpg==
X-ME-Sender: <xms:aE_nZX38PlK9ygB-D8bx_8PpqliviufMAmd2UGcXKZkDcangQFDo7eQ>
    <xme:aE_nZWHr2wy00K9iPYHoQmPEQKmZ9cmvkugzbU_qUevL76X4Elr0-q65Om6gt04mu
    vmaqgrlm_3mOZ16dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:aE_nZX626CGcnuBryQP0jXEWHKm6V9rnKLpXRLG0-w80JE2HBJAuNQ>
    <xmx:aE_nZc1TFkl-lGTDLUj-bJoLffO5yMKp4EbDgl-QDdkYINOMm4pgXA>
    <xmx:aE_nZaGgC3GS6ZizJBztSfkZ4Q0dk-tdE9MgUalzgm3ZovI2GRTZQg>
    <xmx:aE_nZWBp89AXRyWLDq0Sq3Dm648Ox9wXISkdxv4Kb3kFnDnNwZ7kVJgYB38>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4ED7F15A009E; Tue,  5 Mar 2024 11:59:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3bef4fef-0a00-4ed8-878e-372c4d8f552d@app.fastmail.com>
In-Reply-To: <52d6850914982ffaf15dda937d611ffb@manjaro.org>
References: 
 <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
Date: Tue, 05 Mar 2024 17:58:59 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Manlio Perillo" <manlio.perillo@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: Clarify the meaning of "character" in the documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 16:42, Dragan Simic wrote:
>
> May I ask why would we want the comment character to possibly be
> a multibyte character?  I mean, I support localization, to make it all
> easier for the users who opt not to use English, but wouldn't allowing
> multibyte characters for the comment character simply be a bit unneede=
d?
>
> Maybe I'm missing something?

Personally I think it=E2=80=99s okay. `%` for example is a good candidat=
e since
you seldom use that as a leading character in prose (after a
whitespace), and it seems that `%` is often recommended as an
alternative.

But if it doesn=E2=80=99t make the code more complex: why not? (I just
personally don=E2=80=99t have a use-case.)
