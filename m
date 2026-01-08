Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019D30F536
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896332; cv=none; b=eFVGpyntPcINgRewO8isEDqVXidTBTf+2KETXfFs/uQJzHmGjjPNxNKUOGYl+ONyaBF1tKrkuJMrjfWCp28cO32eeXI4Lr4HSa+d5PBuWsyzamR74IwG677dG+A0c6EN5TvBjlEuoBgtqvMFSGLJXHIGAzYYlFffs9cFjbcfQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896332; c=relaxed/simple;
	bh=hWV8/B5qYI0yX4OKrwL0uWwJH1/YzukJJu/Bop/oBVc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BVPI/hf4I7OyjdoMRPg89wAx5Ug+UHV8RHW9FPEpYcOLEzGG5NItZ1QXNjjJBTFsS/JZDXQwy6IjUdTj+ueSxcM8imMMyWP/0XNibGoCJ5ScEvYd26tDbanz/VVxku/axGW3JX+WpwXFpbpAroyqxKow6g4QP/5JtHfg8pHYm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=WgZ9GMgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNh2ClUr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WgZ9GMgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNh2ClUr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81C001400090;
	Thu,  8 Jan 2026 13:18:49 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 13:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767896329; x=1767982729; bh=hWV8/B5qYI0yX4OKrwL0uWwJH1/YzukJ
	Ju/Bop/oBVc=; b=WgZ9GMgMRsa7s9EBmDvNmEE136O+JTydima2JFUQzrMkZZ+8
	ywAfwTaY0utYU2OJmkmnnpf5hPzmXYX8+Nvx4yauDaYnbMjmtJeAhLkFgNWHpkoN
	99qZxs6of+PRA+gp2HZp8WVuTt2K78I9HbrxHXomJ+UZ84NWp8EFpXpE16kFUEXh
	8I9m/TjSezwdMs8LPngKdhoBll9Cj3MxelVX8PxbdUgYA+xjQOzLTp5CRq+D9Zvd
	JHLSSFAjHmnZGt8NXoYT8DKcliEo5rLfd5SCR2TljTwAc6WrQIEH/e3rDuADpInj
	2l6RBTr0YixMDhcVpo0pyLeTlne50onTZq16ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767896329; x=
	1767982729; bh=hWV8/B5qYI0yX4OKrwL0uWwJH1/YzukJJu/Bop/oBVc=; b=h
	Nh2ClUrUOO06FhVB8b/zh9H0OGXd8QRgmYAJ7kgwt6uEFHzlnwdfCBMAkptK5BSu
	KT8jgvedFzYDI5JpkjqzNKEFdx9202Td4IrhHE2540AoHmhAtslLfUzdbl+MJB/k
	w4mpgWzNgR9e+OXDKiv9kgH0R8ppdPwCZ1Fhw322rKHBZM7Et43nYBUV3wGZNqD8
	ON75eLdWvAnrnLvsFW4fWlJsbJfsXIfoK54BnuFkhYEQ8n6Rhkulhz43QsBFHB0D
	FmrcJcBrgd8zUNDxzOEusr4sQuhNQYSGvwlbESm+FXW2FGIeNo0iHb9foBjE/Z16
	gVby8UDGT+JZjPkSKtcOA==
X-ME-Sender: <xms:CfVfaSkyvuDv0-wp3_7RYpB4FdhFmn-pExg6y--uk0_slIaqKhczJas>
    <xme:CfVfaUoFZzkZbOowfHMTAQMLlTOYNkniclPCRbhD75njK47rbo7Ecxuh8X24xprYa
    wUZbFk7pHjHJ3wA_SdF_Dwp0K5O8M5wLLP-4n48maRL3dFYexI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehp
    uhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CfVfaXjw9CLdWdpEkCukRDh3l0MMpSLYPIWrt2d7IXUWuch02B81NA>
    <xmx:CfVfaby2wJlxCGiqVzmf3Z0HeilzIIW05VhdpmJ2vbnnMR5K41OMMQ>
    <xmx:CfVfaaIx7IL6oV9EiN-X6EZueXVw87VVoqlW8ut-uyQQi9a7hOkllw>
    <xmx:CfVfaSQvEjsewi1BW_3w4dfSgRkI0wkz-fDtL-ddXcSRS87byTVJJg>
    <xmx:CfVfaXdcHNS31hlPkF9fHs4maaMqdDIKSzC0c_9dH6shxmwQhQeX5hR7>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48E061EA0068; Thu,  8 Jan 2026 13:18:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR3XL2-KD6pJ
Date: Thu, 08 Jan 2026 19:18:29 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Pushkar Singh" <pushkarkumarsingh1970@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Message-Id: <ac9d5639-47cd-494e-9665-ed59283e96b3@app.fastmail.com>
In-Reply-To: 
 <CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfbXCHrAQSEyDoA@mail.gmail.com>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
 <--verbatim_and_--stable.1b1@msgid.xyz>
 <CALE2CrSu-JW___Lav0SnLPfwxB8QCRYMKQgsfbXCHrAQSEyDoA@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: patch-id: --verbatim locks in --stable
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026, at 19:15, Pushkar Singh wrote:
> I read through the entire series and all six changes look correct to m=
e.
>
> Each patch is small and focused, and together they improve the clarity,
> consistency, and accuracy of the git-patch-id documentation without
> changing meaning. In particular, spelling out the `git diff-tree --pat=
ch`
> form and documenting the `--verbatim` / `--stable` relationship help a=
lign
> the docs more closely with the actual behavior and existing code.
>
> I didn=E2=80=99t notice any issues with the changes.
>
> Thanks for working on this,
> Pushkar

Hi Pushkar. Thanks for reviewing!
