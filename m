Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC31E4A7
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705874742; cv=none; b=XBhWk9bdKJyv3VEQ59KaZ3jXzt7RS6JR0TUByQZCJmwZdWKxOV869IHnk/7lrtriuEfhUdKLe3wJoupjpjBWDPeNJwmDS1HF7mKS5c2ak1XwiIiuthUVXPL8apfVpRjZ1op3hmBcje+HFjZHoux8mvCSkqBsQAG+wn1tPHneRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705874742; c=relaxed/simple;
	bh=2UbI9/FXMdREplqUeFENXpke6hrDXLpeXvi8dvWeK1U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LU+7RJjVqfl3iNJruUOOh2cRjOYj7HCu/Y2ZqnrquiSOwipm72hMecOYG35R4uTQL92yzI6GS877jxaLWlXgg4Vr0gjAxW/uxE8gcJOj0XY6xXZb+CjpuYswd87/KplzGRkvfqWIvqV70GdvayN+ymM1Mk+K4mY+ImGE9ICkLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SyE9Y3B5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU2/MmZg; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SyE9Y3B5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU2/MmZg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6660C5C0080;
	Sun, 21 Jan 2024 17:05:38 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 21 Jan 2024 17:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705874738; x=1705961138; bh=2UbI9/FXMdREplqUeFENXpke6hrDXLpe
	Xvi8dvWeK1U=; b=SyE9Y3B5ieqODrggBisjghSf1OIhCcOKol27bLO+o6OtJe3d
	MRzGz0cUjFaWGv0Ci7jW8WP2NRGmfHvY1UEaJxDbs1XW6Qn+KuSqgWIAN+CC8qAL
	HrsnN9R7+JmTz8hhAaK8CYYM43/tCIavPcU2pm5bF9MQ+e7wTdOowbhQ1UhaGmFT
	GnOszSGQElKIA8RJ2C/CkQbV2xCFEOGMyrE+YwrB8PuTe1AkfcC48BkwJCaGakFU
	hav70OL+ZzGAcfkiLHTytiYG6RO0U5LH6FuyqhpLoRdJ3imD68Wg7hXg6zXuQIT4
	SU+hinOzQ8i6n9ZJSee+WRSw6oQ7r5PoAF38cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705874738; x=
	1705961138; bh=2UbI9/FXMdREplqUeFENXpke6hrDXLpeXvi8dvWeK1U=; b=a
	U2/MmZguYD1/tXhtOCRCqSbYiOSu07M59xP+wWxzJ3xu1pqNVvjUr1x5qfwKdtSJ
	j1mY1bSFnUQ9jqpMrWY3+dYCZhOevTtU55QNJYUSUOZQ7dBP2bmWtpNah6AQlbQv
	HYiV3melfuHW1bOFzRthZJ/rYb3Bs/A/mu42ZaHXmCIw1qcMMOUpnIrTX398EmSB
	AU6VSpGXkwMCNFHUt1rwRsjuLIJfJe8Gkq4sZhaYMfBSfJec52khz0wtLKb/a6oV
	YTUf8NAMpIpJzWz0P61/lOFdpZhZSG/kpKq9Fb8/fYi2p3f3GCIZwv9KA7rZxXZy
	cKm4zglYBqCdUXpTJJAQw==
X-ME-Sender: <xms:MpWtZVX9G4HguVozbv2W1cAK6OnD3DbNG4EgPMOWgemyMFwzLgKSWDM>
    <xme:MpWtZVlX16axtFLan-CwBCKXcFnlIrkdt87UWGVym6zOQcnBhSVQSznF55tYziZV7
    OFyVgrXy8N11XuBxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekgedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:MpWtZRZ_li2Qko-dK2kCVgW8Nyi7731KVKfAF4qCjCDhCie6fWXHOw>
    <xmx:MpWtZYVMbSDf3e0LjvtqGBFR_bpELzmuvcNU2XSwQui2UvaRNHeLvw>
    <xmx:MpWtZfnWKB5WmGsQTRylwG2ZK7tqgit9NUgZMBGAMw5UwWGXxCIAXA>
    <xmx:MpWtZXuDLdbeh_8ReWxqo3lAHzIZsImGlZ7Zmd-OGcVuqiOpds3DjQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0557D15A0092; Sun, 21 Jan 2024 17:05:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca810226-d626-4437-95da-f6a071aff961@app.fastmail.com>
In-Reply-To: 
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
 <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
Date: Sun, 21 Jan 2024 23:05:17 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: brianmlyles <brianmlyles@gmail.com>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant commit
 handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024, at 19:28, Brian Lyles wrote:
> Is the sample pre-commit hook the ideal way to prevent this in the
> future? Or is there some config I could set globally to enforce this
> across repositories? I was having a little trouble finding a good way =
to
> accomplish this globally.

I don=E2=80=99t know of any global config. So a pre-commit hook is proba=
bly the
safest bet. Personally I set all my editors to remove trailing space and
they very seldom mess it up. :)

--=20
Kristoffer Haugsbakk
