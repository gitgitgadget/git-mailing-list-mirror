Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19478171A7
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660245; cv=none; b=inAKyqeiu+PaZ62VWEe5DruffQb60DBr5H2ftn8PMrjpf5cWkvSOmUCTPSTh76vqyzfP6dGsvtZk1t0ksb5RAQpc9jIzKOtYFFXtS/yjTm5BvXNh0C2SvhVGkH4HvA4NMEZx3S3qfQ0ts3h8S/Z2PciJJMSYrRWJkr43YqXrI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660245; c=relaxed/simple;
	bh=h9PmVf9ujw5TffymamU34HlZWdqK8ZAy1iehUeoZK+U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UUHeyUkCg1d+cDygxjQPtu2smh34nnYbUln6tKx0fPTxM0esM3Q9rKXS6VOzD4Kdw7nVSLVjYdkz12O05Y9L/PmkqJr+ER0TQlEhtG5Daznz6ZluktvdNgoAH38FSxuSgzN51XNkjIZXTN5tkezy07KJDX2DnMb7uSmcRTeZJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=e1kaYlw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdqkeMQn; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="e1kaYlw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdqkeMQn"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D6FDD1C00096;
	Tue,  5 Mar 2024 12:37:22 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 12:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709660242; x=1709746642; bh=h9PmVf9ujw5TffymamU34HlZWdqK8ZAy
	1iehUeoZK+U=; b=e1kaYlw9zdUShdyw4qgeB+adzdFglpLEji+jtGbOYYr8Svzw
	GL7iiKWJEYZr2nVrytB76/+tPI4/cjiaQcA/iqvOtspJIBHQwr+rik6P9ZKtBoEo
	LdOjn/+CQqIgxTCYDhnoi9Re7gIc4EpzHFBw1P6pPaDD9mnV6gTuJlo5FFxIHMH7
	cBJPYN7KDoA10VFkkhipiIfRlIVIqbZO9WYkrZ8DInwYZCnOGlJYRGJ+Sn8mhPX2
	BMSfSGhMpqBnVl/stsH1QpUz86L4yl6Le7uajsiUpbxKZwbSUYVYV9OjrGW9qFX2
	ajkcH7hhOJ2a71RhhZGY/qPDYjhpHjD1JOpf+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709660242; x=
	1709746642; bh=h9PmVf9ujw5TffymamU34HlZWdqK8ZAy1iehUeoZK+U=; b=k
	dqkeMQnWocVyNRqEApBGoeOUWhfmpITAEb2uNIONK/540yCrM5tuUuJJvDgiV/AC
	33AZMo+w00VtDzza0jjycOL47xcLwy1e9qkD9PHV0Cfj4YS965dcD6P5ntPxGjUn
	zkIiTu860exwMMk6KvREpMtbk+WoaGXT62lfB3gn3dutU/316F4qC993n9sM3Ndx
	TzLZTim3JpBkwTDaTCRHmT86FvE0wd9mQx9oig31S5ljp80S+bDTMXx9qbu14sBN
	KJgcU1RTJH8NrfGu5nf57OtBti6XjdUa1X0UOe9nmsoXILsfiMLmtY+UQDV5GRNy
	0ixjgXcCeuhi/YwQVCa+Q==
X-ME-Sender: <xms:UljnZW21nfxr7dUHYSVFoxlG4NplOjv0ggUafxtwS0jANs9buUp3-gA>
    <xme:UljnZZFJmE4SVaxrxXhij2r9mGBkTsUADyqHn_tMH-L7UXvuHeWigk39-yGiJRxpT
    NOQbxthavxxcaR-rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UljnZe7w-8-ZmhaphL0rfooW2wQzHc9gAxs4P8Cd3P0kyeMCzzq9yQ>
    <xmx:UljnZX3VBq314UgxFQPQe6EAZqi7324uRUGpNg4gWDU1Dawf0YLhOQ>
    <xmx:UljnZZH4NkGTAyJHlSz-Y6XnPDBahqEV-P3S4JRgE1HPb22TlOJLGA>
    <xmx:UljnZZBwCI2eW2r_jre8_ac6p3IrfWX2qX1MBATRKuK_KWJ4CW42Auh4KcM>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0E02C15A0093; Tue,  5 Mar 2024 12:37:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6de8764e-9764-4c2b-ac2e-ca5e8480908a@app.fastmail.com>
In-Reply-To: <1e71ce757c3d773fd7354cd12473b851@manjaro.org>
References: 
 <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <3bef4fef-0a00-4ed8-878e-372c4d8f552d@app.fastmail.com>
 <1e71ce757c3d773fd7354cd12473b851@manjaro.org>
Date: Tue, 05 Mar 2024 18:37:01 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Manlio Perillo" <manlio.perillo@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: Clarify the meaning of "character" in the documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 18:20, Dragan Simic wrote:
> On 2024-03-05 17:58, Kristoffer Haugsbakk wrote:
>> Personally I think it=E2=80=99s okay. `%` for example is a good candi=
date since
>> you seldom use that as a leading character in prose (after a
>> whitespace), and it seems that `%` is often recommended as an
>> alternative.
>
> Isn't '%' actually an ASCII character?

I wasn=E2=80=99t clear: personally I think the status quo of only allowi=
ng ASCII
characters seems fine given that you can use something like `%` as an
alternative comment char.

--=20
Kristoffer Haugsbakk

