Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FC72627
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354902; cv=none; b=UAdTQBx6iR86tFaeczB2OOOw2zy304FqabMiBZHVkAWtJ1I/9HBd6rzC0njHisE0xJ2rtOp4KgUjgz3j98HJkvTBTB6CeKHGEPBg4Y+N11QYjaoVuNhzJcj3PRflUoRrqTAjq7mPrSJiakZLF+UU2El9tZTwh9xcn4gtW9UUcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354902; c=relaxed/simple;
	bh=oMHTaTO/i0mxIh/06skNYw05fhG66PlLAM5x6+08vQM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kQmuPejoOXD7KG4OK2GDIVgUyN0agVISfRwgS96NxZqCCOLeWimPCcBm5JvDdg0z5EGGBX4eAwLGWQ89XmxocMbygPFExYlEHkxooERAFEdaqTkFVAzcYLpsVFrAAm1/PRlEV5PA2lFWboo8mvSNSc5/dFAThKOye6I8sMoezB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=1eGMWd+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpByWmED; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="1eGMWd+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpByWmED"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 718497A02C7;
	Tue,  1 Jul 2025 03:28:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 03:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1751354899; x=1751441299; bh=DdomYhGp1YwZvbFfTMFy2jSAdLzeEax5
	DTLGD9CB294=; b=1eGMWd+JY1a2VYViHJMyM8pWNV3l4u6q52hB/N/tlsKqP8Ji
	1V8zwQH8bitiguj+tFIcUXPzUtUwvqLFkEf4izgYBB8TaYxrO4CWQ7Ae1nGP1IaR
	9KgmYZ0wCGHKV1T+rp1EVd/mia+UjCmaYubeUuCZRmIseM7RQ81CuLI7wnQRO37n
	P69gKSd312MZg0Acp5W83rPrJMnfvNvmubHcLmCYBjDtOReboSXijQpSBQgobmbP
	FO3YkAgmC+57KUBpLPOzrPFLUdGphLRAb1EWqeaGi9FqFnlcAl1RMF+kgSelwbPH
	udY/pu9nrHhz1ECwxsIlpJQxHtqI87+PUwa1mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751354899; x=
	1751441299; bh=DdomYhGp1YwZvbFfTMFy2jSAdLzeEax5DTLGD9CB294=; b=H
	pByWmEDaLkYMoXMXRpnpFEfGjMgIZYIjtnFfRldNLy0WL3/RhrERb03R0N7IINCS
	3Wk3Q+RSUp18OgTaXUI+GbIzIKnN9KQjN9p/3+J1sPBCVNPm6oR8vN/O4u4CbiVe
	sGU8/t57qDRdiCqetf0h91NwF0IKLR4PHe5PB2kD+faSsd7ZWtt8FkwI+F0BdzA/
	IJ5mSKYxszpVHyEazCICSQge4X1dvqEmZGZWUeQ4a6wFoy6YipRMulRcuYJept+L
	t/9QekDqcpjTpHBOCNCnJtQdxoskbVlpoE9qf9yWHjKVbblUfeelMSjhsJPlaTbB
	C8o10eCkX+xJ0Oil3eboA==
X-ME-Sender: <xms:Eo5jaPD55YDOwjebfNcF5K19QmQrONYCmm1XzLeIa3C0fdzN-3OI-Fo>
    <xme:Eo5jaFgnr1Gai1ETRXJ8QOs9LZMAVDz8uTBC80ZZvNf5K03Jxrgz1kiJhZAIVRova
    7lh1vFt_sAWy0rmoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Eo5jaKkobbESSWPlv2WCl91Cb2GE1ySYZ8H7EA3mCvEJ30iKwBxB5w>
    <xmx:Eo5jaBySsexC3awWOaEKaT7ZXpEKk1zsuuQBaFpoP2bCDgYNzF9jhw>
    <xmx:Eo5jaEQi9IaOrHuvx7hQt6SLiTvyrn3Y6IYccxel1FA7njTlx-A5gg>
    <xmx:Eo5jaEZLUtxYtL7nvhCSL4eQe4dQeveB-q8jhe7ouKriLvx4cvHhEg>
    <xmx:E45jaF2B5abMDrvvENqUOdgB3HQiMl6QJYGS8eP4kzC-eKHRFlvkKsYt>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D24FB1EA0066; Tue,  1 Jul 2025 03:28:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb0b14b73cc505ac3
Date: Tue, 01 Jul 2025 09:27:58 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <c61a5f21-06c5-40d5-8f35-f478a1db83d0@app.fastmail.com>
In-Reply-To: 
 <a52322528dac34827abd5100a2d3ee49e376e2ed.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
 <a52322528dac34827abd5100a2d3ee49e376e2ed.1751310455.git.code@khaugsbakk.name>
Subject: Re: [PATCH 2/5] doc: config: use --value=<pattern> consistently
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025, at 21:10, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This option was introduced in a series of commits from fe3ccc7aab (Mer=
ge
> branch 'ps/config-subcommands', 2024-05-15).  But two styles were used
> for the value provided to the option:
>
> 1. Synopsis: `--value=3D<value>`
> 2. Deprecated Modes: `--value=3D<pattern>`
>
> (2) is also used in the synopsis on the command.
>
> Use (2) consistently throughout since it=E2=80=99s a pattern in the ge=
neral
> case (`value` sounds more generic).
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

This missed some `--value=3D<value>`.
