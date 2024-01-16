Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D120337
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441621; cv=none; b=cNJYFd+gRm49MKtdlppwcaVnLq70HQCV7qWkoT6umzATsXBDe17VAHVMmn6bC6LLbC1OiRXflCPwewTbQcNIVC5K6uESpRCsJDJ/hKpD3/81ltFIRQIMgW0bSIv3UBiEmgTkfz0GdKAYJ+bTYijVINAuMXljEhCDqRrF/4F6x+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441621; c=relaxed/simple;
	bh=WOgbSNClKgvtslFVzMIoidzbLM95RIjTBOGz4cr9nV0=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 User-Agent:MIME-Version:Message-Id:In-Reply-To:References:Date:
	 From:To:Cc:Subject:Content-Type; b=EzTnyZj62083PUALq62yxnpmEiIUz/ZkBJx37zbJU4X2al1NoJ9jbrrAPnreqhQOw1Iz51kuudDI3jgQkFEOcpAJd4SnjukG0SnzEQy+XA9Rxzo8HTDBWnXRiDtH0h3MyMOrQyloMXLZRzvCekv9fdHIGPNSsemkmq8dS1Bayx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=LLG0GVtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gb2uMai+; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="LLG0GVtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gb2uMai+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7489E3200AC6;
	Tue, 16 Jan 2024 16:46:56 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 16 Jan 2024 16:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705441615; x=
	1705528015; bh=RdoPUmOxxsb9ZIYOweIGrlAkONsUOZsAKoAlfDxx7NA=; b=L
	LG0GVtEwSEbTY/NO+GtpuFv/DHfaFKbXoFLITbZTVG8+Gy06cvH87Y56xYls4oo5
	pJKIjOsteWIwJd6a7LjtsMpS1WRdH/uF8hr6SWruUFfSkcoFG0Rjt8feBYY0Lp1X
	Clo40whM6LPtV/WMCjyUatXDPw90Iamx4YEWlnDPSGaHF23m5IW5zEHUCnz+v3vf
	kxdspJlRE5MwDag2y6SKRi3rDWMcmFlsFwsQcx9XiTeQmgfynJHPVVHYjSbE5qui
	Y0ErnKzyYDbvQnHkguT5CaAQIPxoo7JT2BGTV90bT5ydG4jB+fIRye7al3vYthhB
	tl7vuxr1VhmoWln/PmRRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705441615; x=1705528015; bh=RdoPUmOxxsb9ZIYOweIGrlAkONsU
	OZsAKoAlfDxx7NA=; b=Gb2uMai+IBQwKXD1XEarAaxA81FGvuohNHB1p0/AN0Uq
	/L/qWCg2GdsXMGlMGfWhYEMMf2KaxjEF/ycYDsC5bkXokVVjNPNUYrcShIMn/KwI
	nT890t/P/A4/tluycJ8m2rx3xYoB0AZN3kNPMapiJgEkKxJT9XowbEAeysLPD4Je
	m222f6nItW2gz3oPlSO/JS8ATfMizzIxxGrD57Dj0//MQit9zShppRZwiqUIYYPM
	SLgSvxPP9/QHIgvTV6o/Co0uDdUU38yVydD/gPIu2poSFBdjPz1iw3AKQX62kRc4
	3Ql3DDkt9uSFBbDoch1Qx5Sa3+b0YbMW3wXXYg9FQA==
X-ME-Sender: <xms:T_mmZfA9kK31JCzSUnVDoT8I_DjoybtfBeSpPLgyUh0TtUMzGl8HS_M>
    <xme:T_mmZVgbRv9nTuRAo3sKPWfeaWQzSKY6tS6j5ag-nOR-QPmzwNLh28hQaF_cJ9dlt
    yVdxNxO05O9m2FurA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:T_mmZakM6yl7eWpeo07s8Ja-4ft-BBxn_jUYHewvLWa0vCIhsroC0g>
    <xmx:T_mmZRymI4VyGhjrw7RbuJRNwIyfXNq7TRMFurjtS-uJ2aL8kvPh1A>
    <xmx:T_mmZUSmfl3zE1nv0hdD3VfJ4j_8vlv5TeXWICd8JpPK7SXfLVXX9Q>
    <xmx:T_mmZadHRwQDklqmkuwFD_IY_0yE_vzf2Xqaj1_gBamCf7GzKpPhSw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9BA9F15A0092; Tue, 16 Jan 2024 16:46:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c87b3d93-74db-4377-a57c-80f766d46e7f@app.fastmail.com>
In-Reply-To: <xmqqcyu1yn36.fsf@gitster.g>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <cover.1705267839.git.code@khaugsbakk.name>
 <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
 <xmqqcyu1yn36.fsf@gitster.g>
Date: Tue, 16 Jan 2024 22:46:33 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>, stolee@gmail.com,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
Content-Type: text/plain

On Tue, Jan 16, 2024, at 22:39, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>>  char *git_system_config(void);
>> +/**
>> + * Returns `NULL` if is uncertain whether or not `HOME/.gitconfig` exists.
>> + */
>
> Sorry, but I am not sure what this comment wants to say.
>
> When $HOME is not set, we do get NULL out of this function.  But
> interpolate_path() that makes git_global_config_paths() to return
> NULL in user_config does not do any existence check with stat() or
> access(), so even when we return a string that is "~/.gitconfig"
> expanded to '/home/user/.gitconfig", we are not certain if the file
> exists.  So,... it is unclear what "uncertain"ty we are talking
> about in this case.

I'll delete it. It was an attempt to refer to the comments about
"It is unknown if HOME/.gitconfig exists".

Cheers

-- 
Kristoffer Haugsbakk
