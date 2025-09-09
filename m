Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4630146C
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399153; cv=none; b=K+A0557/ev8SnUxbs+tdVZw0PpZ9O2KoqwlZp5fQT5UQ3/LsGQVMx8/KAAMr8QpCYowRFBinTXdjfI5hTpb9Vmc72FURdg1qahJmcJZr0DbF8Yt0U4CEC0bqTFx3XaKWbFKphKYFo90pDtaWWrmOIzPjPChI4Z1sfGXkQx46MUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399153; c=relaxed/simple;
	bh=m6D/j23SYeDnWw6zegiWN3LWPnBbLvZ3tsvn4N2o/0A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jBnpls8tpVKhTTEQRd11FJNHNE/c1CVBETIag02dSAHzCBMlxd2ZGRRDqs4Fiu36+5g5hv4PpDKKVPy/5yemAbXVvs+Pcbs/WKxJHCI2jNzj+7kKGU6IewCCUKHI7fkQZ5KThW2/cDA3FgXF7JWsqQSwYg6w+HRVdy/qD/oJ3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TzjEHydO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TP2Fy2V4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TzjEHydO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TP2Fy2V4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C984BEC01D0;
	Tue,  9 Sep 2025 02:25:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 02:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757399149;
	 x=1757485549; bh=UUYl2ZG/bWXQdT6a82l980VQ2mNWpSiY3eXGpTWUxGM=; b=
	TzjEHydOMtV1IhuuoPWKXontN9MkNJnlbkEOkr9Ap4E+XUhCHM59Ta+ZoHfbp/wK
	/wQx/JQHizSxaCvahoZ8T8De2QNCXx+HV0p64hQvalu6lBjBFY5xsW+lBCwdMlMA
	M5hiNOnYyrD7XJDxvY8qrT5LrELMXPRebif+wFrNOO7fsulJ/megIdAnRKLSmWeI
	/O4k7xIBHzXcOfHHsDQ+k2G6BzTaxqTb/vS7DJMvEN52g5njWGLENTJx64vjyeFn
	hTm2SUp4JJlSE+/07P67Hs8A9fSdv9vj6BczrNLuLFgqc31GXnIDugtlxK4xiUQR
	WpfasZArsizgaWSV2UD53g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757399149; x=
	1757485549; bh=UUYl2ZG/bWXQdT6a82l980VQ2mNWpSiY3eXGpTWUxGM=; b=T
	P2Fy2V4a0QnysINFM7RF3PUJzYn+UQ96rGdJ69i9De6WQAOCZ34Pb9aRT1lK2/A+
	SwAMU4/3I8DusRH4OhGEhZtj4JI4nA9CIddB8n6XwHAYrOEdHmvYnkmNCpC8hfx0
	hEnplc42bVL2uIILNh6uQ6Y3LEPF38X33bV8G99Ml5RVokk8D1Gtf1k+UV2CBjxx
	vDuMOINBbRYXDhCj1jZ3lFz1+Hva5EhUhRy41fyh8EeH6+yfy6p1vjnVTNWTm9Es
	5kv2u7F8ZbVpixVdIAYdg12jVk8gkUkxV/h0OY5I2QR4IlaAcRxtZvDr6pSAV/Bn
	a/KW9y32FDSfj3QbZjzLg==
X-ME-Sender: <xms:bci_aKS_8g8AqMPOBJS3sycoji0h5d9cSigCnL0_AO_aWP_V_i2J3M4>
    <xme:bci_aPwMrw3uUjGars0KwrqUhEUeUMMyYLTMKAQ8AvjxyzS8S9QtXz5yytHJAGD66
    Q-gwf5phFBsmsdAbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:bci_aCSsvNyW3KtlSAHmWGjf_4VHDANHxEF3GUualS2dfmmzq4yE2A>
    <xmx:bci_aE5gQ53kVLUDDIiJ1Nhee3D0QC--x5BXSVFrSyY0clKC_jAjnA>
    <xmx:bci_aO1uGu74AUnVw1Hh8KCAMik0uZiJPqO1VGgMd38qksRG4FBxew>
    <xmx:bci_aPBwnz_qqX4k1Tf3B583xOVk2VU0IWyoHUiOHq1rTeSrzovCKA>
    <xmx:bci_aFbWutIbmIohAWkZe1mICqwKrAhFF4pQOY6ebZAVnNOt17rYZ4XE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F4AE1EA0068; Tue,  9 Sep 2025 02:25:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai977590-_NN
Date: Tue, 09 Sep 2025 08:25:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <54833b28-658f-4eec-93a6-74db11c4b9e4@app.fastmail.com>
In-Reply-To: <xmqq348wwqwb.fsf@gitster.g>
References: <cover.1756480827.git.code@khaugsbakk.name>
 <cover.1757345711.git.code@khaugsbakk.name>
 <eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
 <xmqqcy80wu0y.fsf@gitster.g>
 <20250908211141.GB1327610@coredump.intra.peff.net>
 <xmqq348wwqwb.fsf@gitster.g>
Subject: Re: [PATCH v3 3/8] git: allow alias-shadowing deprecated builtins
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025, at 23:55, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> cmd_struct were not the right spots. OTOH, it would probably not be t=
hat
>> hard to just do:
>>
>>   static int is_deprecated_command(const char *cmd)
>>   {
>> 	struct cmd_struct *builtin =3D get_builtin(cmd);
>> 	return builtin && (builtin->flags & DEPRECATED);
>>
>>   }
>
> That was exactly what I had in mind.

Thanks to both.  I=E2=80=99ll use that suggestion.

--=20
Kristoffer Haugsbakk
