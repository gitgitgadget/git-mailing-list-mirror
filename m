Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBA15DBB4
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790100; cv=none; b=haFRXtaINmaVMTzHgJFe+x4+3R+kdBLR9NTACByvBrzbA/K80pWrp4DX6pEnG0otU2Wo+lXuJX2BnLzFlgixQxWGNjAr4qwodEKqgxTWLQR1lIF484uvVrC0FpxhQSHbCu26ywAu0xMNBK2SbKBWkVVFvwSYV8rq5tNoBmvKK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790100; c=relaxed/simple;
	bh=x01FEF1Jz0U+2x3r2Tr6wx8EF50T7DjVsS5J7Z11H00=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XB8vTdFbSbjdP6kB+lJDBS7fqZhIsDUrwOmpKvnAyNIraaGEil3APZQJlijTZtZP03o4ikMh/pz2GYDayiFVgfI4By/+P8QH+UnKjBJRhaH0itPRyh0sxym8dlJg5zzbbNnZYB4moxiyl1zYPsnedDAgMG4YzsRf8WDuNqlVZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SuVEgPgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzVAhIR7; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SuVEgPgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzVAhIR7"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 21A123200AEA;
	Thu,  1 Feb 2024 07:21:37 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 07:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706790096; x=1706876496; bh=x01FEF1Jz0U+2x3r2Tr6wx8EF50T7DjV
	sS5J7Z11H00=; b=SuVEgPgiHsUJDXLYeLOzptIjpjMY8sbSxfBmZ/EsERYWs2jE
	a7GpPoSyE+GCF80fcOYu6BQxtRNSf2LjSUFok1wiAJ9C9VmDlVWZh6b7JltkmzbX
	pdfPcrbxYihWnR3wpB2+vgOPq5TKxklsK59znGO4K8GUEm/p6Klu2RgV63h190ra
	iiE4veIrCGd8yn7pkpNCVNpxhkcEWMFQPDGqqN3D9GKcbp46kBDLZLrvsY/euu3N
	9N0Jgjzz9msnE4IbgYlB4Z0kIvZvx/rnq564Jnla5oAsnzlzjaYZIhb24txbaysn
	U1pA4AUfdZi/02dLhhAfigYZADfRmUQBMqmbjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706790096; x=
	1706876496; bh=x01FEF1Jz0U+2x3r2Tr6wx8EF50T7DjVsS5J7Z11H00=; b=V
	zVAhIR7QI+VqJKRJ14vw+tWDboLEa4nC5xdbvRlhGMeiHOeqK9ymRReJEgmuleQP
	RyCvRY4y/Xb8o1xEdRJK2dJdJej+njzN8vLeut0xEeLkd+avzZnP/bJn7YfiW6HZ
	rEdo64+uYNgiO56gLDyo/rkLsWfvOXZnovoWUzyG1meI+cpSXiqqhUXZNLhGD03B
	t7zQQHjIEx5GGvs6ji7zaW6+/0nDIGgqJA8cf/CHqCTL4DXXmirM5jZx7CCbxfVs
	UpgDrgJqh4OxiT/wp4lRzf9dlnXnb/0ZTBwtcdpoUgahTNtbBZUW9JgQ2oA4RFoy
	zFSRjT0G1zLo9AsJSA9rg==
X-ME-Sender: <xms:0Iy7Ze6XRH2IE9m_yws5Uup4aN_566AyWbRXZSjgnFw2JvSVKWDnkcU>
    <xme:0Iy7ZX6gErLu8Ahkqm4PvSVMW9c6cj3CPa1AgzwNs2iTInL9QXXcn7SwuQQh2PaGu
    EAXMvYnjasS_EbhnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeehffeitdehhfehfeejheeuheejfefg
    leffgffgtdehgfdvheegueethffgtdegfeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgpdhgihhthhhusgdrihhopdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvg
X-ME-Proxy: <xmx:0Iy7Zdfhp70tJIysnKItEMvGoi0MKcRLL9QDOxCxFhQqYJxAtExhpQ>
    <xmx:0Iy7ZbK-eX5bxxeOkZZ_r8R5CPtiSWW5GSn2m46okT7e4Z7MKkCtnw>
    <xmx:0Iy7ZSLihZ88zizvoYoxRqcqbaw0SDXl-_RtFD1S9WFLQsqBCQKndw>
    <xmx:0Iy7ZczCSA1ueAzCQd6a64JMjq0xo1YDBxS9kJ4dzoGTN5VhR5OxFw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4E57C15A0092; Thu,  1 Feb 2024 07:21:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ada5564d-d810-4707-83b8-c00a7b5aa79f@app.fastmail.com>
In-Reply-To: 
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
References: 
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Date: Thu, 01 Feb 2024 13:21:15 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Hans Meiser" <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Feb 1, 2024, at 13:10, Hans Meiser wrote:
> Hi,
>
> Regards,
> Axel Dahmen

A relevant discussion seems to be =E2=80=9CImproving new contrib onboard=
ing=E2=80=9D[1]

There=E2=80=99s GitGitGadget for people who want to use GitHub as a brid=
ge[2]

There=E2=80=99s an unofficial issue tracker for project ideas (not for b=
ugs)[3]

That=E2=80=99s what I know.

=F0=9F=94=97 1: https://lore.kernel.org/git/ZRrgMDacYpj41DcO@nand.local/
=F0=9F=94=97 2: https://gitgitgadget.github.io/
=F0=9F=94=97 3: https://github.com/gitgitgadget/git/issues

--=20
Kristoffer Haugsbakk
