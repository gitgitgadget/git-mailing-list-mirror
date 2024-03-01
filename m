Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F470CA8
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307003; cv=none; b=U+4/Hqz/08lYtxXB6DmUznDW9XHRh+zc1ECfYPVm9TFmRmk7hKTiF5miXThTLv9fTC4KkHMfuLL7URNjsIsFcSe55dsWnDM2xneqTGGshEWp4t8Ma8fUB+rxttlowNZlFcmAG/yMRbk7EOzvgsknxqzdcK828UO/8QKff6zh7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307003; c=relaxed/simple;
	bh=ArQ+ykASy33OulG8GLvu9eS7hu0DkpKiEpT734OZudo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=l69PB8XjE1WNLxBTNWfcgI5W+xi/+F4PJXcrEu5WCvOpK5BPqwClmP5KtFovhMYutmB3V6l9nKJs2RrJzlBAKLJYa0iKIegxlv1BEdidH4Sbl4VVHGpQkBNwidjvcKz1SGoF9FyXTnwCESnbEr8HVB2954ZLVvSkCjNIwtb5q2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=OgE4cQyK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCUnNrja; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="OgE4cQyK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCUnNrja"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C70CE13800D2;
	Fri,  1 Mar 2024 10:29:59 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 01 Mar 2024 10:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709306999; x=1709393399; bh=ArQ+ykASy33OulG8GLvu9eS7hu0DkpKi
	EpT734OZudo=; b=OgE4cQyKC4iD6dYP3q8QIzvE6g5G7xD0PFEQYAI8uxmqzvNt
	nXpY58vFCcAvpvp6uqxqXo4a0cUz+FIhsAVyAWxRXZOtBfI0nFjCeDOoA7H0tySW
	K72BHwMrjVEhAPU9CRHsxCwSmJmF9Hqc7SKVnYGF0yEWUfCN/LjpFcDIykxtzRSM
	fATR+me7zg29NYDlGrKXmS7V3nMwCtozLhP+2dpy6czOTciR5JupcDUrQIxJ4XFJ
	KY6p4mF00WUQEZeFaQdGTm1mb3fO2Ri/yVcOhFKokWnGS/xcaIRIbG04nlIYFGGa
	bwSzGLgbZcQyYlRqCjsG/7/VYqSOWKSjuIaoqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709306999; x=
	1709393399; bh=ArQ+ykASy33OulG8GLvu9eS7hu0DkpKiEpT734OZudo=; b=V
	CUnNrjaUEBo432Q5VCFVGP+Fc26OCwjXrK49fVBjNBiZAmoKs69xwFZVei6gh/95
	VAcF8W3RNufPs2mJtMZFisqygMXjlbQU1eRk2CZVqGtI5SaooliWLahX6ooYFJhU
	wKlxHTIGAZdBcIW1qOdt8kO54yWDLmdfk/eAwjctXFylZ/j23eHAwdcR1lmHmizl
	uff1rIOLzfJHnVpueWEP7W1d8E3CfIzz6dY7FmC8YlezM1tnEOGlba0INkrtJC3K
	gjLBHtvL5rgIHnhIPo6hSbDt/HCMzQYM62EPQSBSZbdVu1GpFWq/pvUIp/W4vpGR
	L8krrjkKHwOOpc8Y5j6zg==
X-ME-Sender: <xms:d_ThZfusTuETPHzMss0C9a-vfTN563RDbdgG8d3P6K3lmyqCshfLdqc>
    <xme:d_ThZQdFQwehdCngOxfJ8p3FWrMc_TfzYj1OmzuvkCXFkbCi-rceOjwu36XAVLvmC
    pJj2yD4bNST_SeQ_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:d_ThZSwGfTNPtllyLUurLs47loj7n-JZynRkmJZbCM-hcpUFhzuw3A>
    <xmx:d_ThZeOUOl1dS23DKV2fHTdCfIGLSQv6Me6KoD4uU5bBlJMhkC5BVA>
    <xmx:d_ThZf8aPaufzz1BaQmqlfDIFJY0E_4FugvzFT_jWVYMLRQy4VzNdw>
    <xmx:d_ThZSZy4qP9K2u_cB0QjhWiAUCjEQs24IRVRhKan6yFwLpKJcjSFQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5C40715A0092; Fri,  1 Mar 2024 10:29:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86ce3c89-4a58-42bf-a31a-96fa6b74e937@app.fastmail.com>
In-Reply-To: <87frxam35f.fsf@osv.gnss.ru>
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
 <51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com> <87frxam35f.fsf@osv.gnss.ru>
Date: Fri, 01 Mar 2024 16:29:38 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Sergey Organov" <sorganov@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024, at 15:34, Sergey Organov wrote:
>> Please use backticks for options, configuration and environment names:
>> `clean.requireForce`
>
> I did consider this. However, existing text already has exactly this o=
ne
> unquoted, so I just did the same. Hopefully it will be fixed altogether
> later, or are you positive I better resend the patch with quotes?

Sometimes I see widespread changes (like formatting many files) get
rejected because it is considered _churn_. Not fixing this in this
series and then maybe someone else fixing it later seems like churn as
well. Isn=E2=80=99t it better to fix it while you are changing the text?

--=20
Kristoffer Haugsbakk
