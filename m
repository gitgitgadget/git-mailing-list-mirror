Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736B2D3756
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227337; cv=none; b=oxvAAMDlHAhDhF9X75KCaWn21hkoptKkBNWn0PRaZ1VaZN0Ow2rkC4Jgtfr0A+qmVloMuTQIkVzLsC0FhVn+qLdp5wpMTEDHNOk40yFvNB1TNnfBqijQCq5MSvk0KsE/czsIXpMBbwPcl2xqXJKClFqw+Xni7AScF6jxS+gV/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227337; c=relaxed/simple;
	bh=yGmmmg0L7O4amZCaN/6ACq/cOLtB+ze+3Nxfr8bSVVY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TkChYJgUNji25Q98en1q6GcuxKeXnFg4PBO2BqmCz8IKFszOzv0Fy+3p0gMl8EAFaP1pwlQwSkWoekd4vO9eX4Vc4HxSUge/+Z0n7IyRWeFINIbZlkdWBjkynNC4eda3b00HrQJPTVJcWFox7c5p8dzlhxWrcCROjwaaLrc6jvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=EKexFMg/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiZwvCNt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="EKexFMg/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiZwvCNt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 474FB1D002E5;
	Thu, 18 Sep 2025 16:28:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 16:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1758227333; x=1758313733; bh=luIEry6HpbLpGhQat6uvRNxqyJNhsuKT
	J78Cjys5EgE=; b=EKexFMg/rCDrm8V8YMnHpwdwc2JKuQ0N2Isrc+aoMQFtddFw
	bC7NGBBHi+ktQUcetSDtx5PKaJ6C77QzvUF08fkVWv/gFgvXG/cfHgqXaQCzpBzx
	PStPmNzMPVDKgZ/Z7eDj6bxOdr5jRUn5ACzAiEZx2P/EFXd1wGZHIsVmevIxEhaN
	rBLav3tprcm2/6E0g+/2N2wNrnf41J9b90vLVrccEqK1e/XEUj+GPisWh23gPTSj
	k0Fjki4qv+rVFN+FdqcaY0WD65vqMlowfqWBHZnJdftU46zqBEbSYLdqt0TmqO0D
	I+NdauqLoTrlhKAOUspRjAMCZ1U9Cd/KzV2AuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758227333; x=
	1758313733; bh=luIEry6HpbLpGhQat6uvRNxqyJNhsuKTJ78Cjys5EgE=; b=X
	iZwvCNtGZvHgPvgTvwtSW+r/TiVEudYzBs0PGPQPmCcxT6VoYZgtLoNignTyhYAt
	IUObcqyQu3hlo6N5UxQmEs/BOZuFAaOlpnROO5PA7TKUd7eskvgi+o4QvOgP3SCx
	XABxGJpP4aijRjtPLVh1tMj2rG25QU9TM69EETji6C+M4exAJBq6Rv/3mQjf1q23
	B168TwkJATfxaTFZEyCWsbTJLh9Yb+xvcNmSi70RHObfnubQV/Wb4KqbpFfDZl2r
	fMNx+UwgNl+HSJOanfKqRfHtuVfZ3SE2wNxjEfyOOPQgcjSxaah45zy6ucIdbvyE
	A2qwt1XSyTJhfnsUGDHOw==
X-ME-Sender: <xms:hGvMaJddFNK2ngIf42gmPz7QCWbmuFt4IcxbMPyltX_zIKR51Mde1JU>
    <xme:hGvMaHOf6z9HrG5ztcZ7xdu5yL9JuOZDghn8zCKeFa4rqx18Xrk_eLA887QEbYr6b
    u0XMK00Jge6NfsAcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:hGvMaF7-4N1_SrquzYeui0-GZBihNrFHeogI_I1hVRsaLBWNMqcT4w>
    <xmx:hGvMaDqRcgaL18Bu1c6Z3-EF3VNlf7A7byOYnLgVr0mv3fMVXyo2Ag>
    <xmx:hGvMaIkQ6mnUeh4G81BUqTEjCFJbCoqU-lQi2jOOi4vNINHKzrgQPw>
    <xmx:hGvMaPOW2H2zrBCv7sggN8a8MlAFcZ0LsIGO_El32okEEXkYPUwaRw>
    <xmx:hWvMaH4CrJUy8GFmpu_ScjxBVVW2LoB8AvEqI5Hc-O1J1fa8uAPSgGIb>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AFDFF1EA0068; Thu, 18 Sep 2025 16:28:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlY6N3eOzH-Z
Date: Thu, 18 Sep 2025 22:28:32 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <c1392238-4869-4fcf-9d3d-5c7882167024@app.fastmail.com>
In-Reply-To: <20250918183117.GB1184978@coredump.intra.peff.net>
References: <cover.1757879060.git.code@khaugsbakk.name>
 <cover.1758139856.short.code@khaugsbakk.name>
 <20250918183117.GB1184978@coredump.intra.peff.net>
Subject: Re: [PATCH v6 0/9] you-still-use-that??: improve breaking changes
 troubleshooting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025, at 20:31, Jeff King wrote:
> On Wed, Sep 17, 2025 at 10:24:10PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>
>> =C2=A7 Changes in v6
>>
>> Use Peff=E2=80=99s patch to get rid of =E2=80=9Cthe extra output=E2=80=
=9D.[1]  Update commit
>> messages to not mention that.
>>
>> Also use another fix from Peff (patch 1); don=E2=80=99t list git-what=
changed(1)
>> as a builtin when `WITH_BREAKING_CHANGES`.
>
> Thanks, I looked over the patches that touch the things we've been
> discussing, and it all looks good to me.

Thanks for the review!

> I am a little troubled that even after your patch 1, the test suite wi=
ll
> get confused by a stray git-whatchanged binary left over from an earli=
er
> build. That may become an irritation later, when the breaking change
> becomes the norm. But maybe it won't be too bad. At that point the
> matching entry in .gitignore should be dropped, so at least "git clean"
> will find it.

Yeah this seems tricky.  And this in-between space seems difficult to
deal with even with all the tools like gitignore and whatnot.

> In the meantime, building with and without the breaking-changes flag
> can cause confusion, but presumably people aren't swapping between
> them too often?

I for one (and honestly) only did it now when I was informed that it
failed the test.  I=E2=80=99ll keep it confined in its own worktree wher=
e I have
no qualms doing git-clean(1) every run.

> And I don't have a clever idea of how
> to do better, short of having the breaking-changes flag explicitly
> delete git-whatchanged from the build directory. Which feels a little
> gross.

Not that I know anything about build systems but that doesn=E2=80=99t so=
und like
a bad or unprincipled solution.

> So I'd say to call it good for now, and if it comes back to bite us
> later, it is not harder to address then than it would be now.

--=20
Kristoffer
