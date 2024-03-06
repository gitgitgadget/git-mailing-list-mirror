Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E071C68F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765402; cv=none; b=iheDsDdMed9ff7SAhrr2++VmyJ5PFTC1Dha6FeQjZdjJ7KWrnlzhOC8740mc2DtJpbwR9j4WalRhsDBAph2fxcQzILWw47i/tdDd5iO6B5aPVRJ7RT/6rAYAK0gc/WXGkzQojH3JkDO3BCgW/Xbe1JKxMZIS3aUlSn4+uETeVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765402; c=relaxed/simple;
	bh=yrS2EEDTEHdUyNOGpnKM7cTJcR7mtFjolAebX1a3V68=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aBVNl+PE80ofKTE4LzcSw7aXItdRh4VyvFE+lQneKqwKaB3FfFLHUTWQfAV17FSTgElVMWo3NmibOfQqRGZuS6TkmdnUGuoEpUtQRowkVmG8Jtbl6+3YOmSesu+j7w4grN3bA6o0yW4+3zKyBwbYWdGM0jQ5/VliraE2RFEKAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Po1od2Cp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glGvhR3S; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Po1od2Cp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glGvhR3S"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6F67A18000A8;
	Wed,  6 Mar 2024 17:49:59 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 17:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709765398; x=1709851798; bh=yrS2EEDTEHdUyNOGpnKM7cTJcR7mtFjo
	lAebX1a3V68=; b=Po1od2Cp+PFMm/iidpka6a9Y0qLaGx4CJKTnquRj4VcmQDiY
	T5lPyzNhJFpPaiVHy1lJsIk36ADvYl2d+qwAd+f2Ocr37DIl+HUi1RmxwLmhx6gG
	B9NgCmsORFpOvYnQZbjUpSygfiq3Dvouo2Ly6SaogZ7HWub8l8Qv9RU3SJ8nzt8F
	H3DGhfhjMtXFRbFEdlfDa5r+gDMUSoDWVL4a74vyyr1b0DlEJkzDSSpS2p+PxpUb
	izx7QgfgqMsOB+yyowvntolTfOPO80ctzAXhA3lM89Zqpka2Iv45sdtij5Ej/3wR
	JPxxOTgEOGE2AeWScGUMZFOlgCALz7sBemtBGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709765398; x=
	1709851798; bh=yrS2EEDTEHdUyNOGpnKM7cTJcR7mtFjolAebX1a3V68=; b=g
	lGvhR3Skx5ubuzreq+PTISG6WuM4lj67NM04FlwLZcW5rwDpU+DCUbrURYswXqiY
	0o2sikFkgkM/8XJYd2+Z9Om4jjHBaGmy2qbvPpTKhDBpNwLFRwDS3EFbai1NTk8c
	ChOfKdA5WoQOu08TsHfzlf6CIOrTPQzixDfausy49UbtY4AodussODZmXmd2cl4d
	k2SuMOhLwZJZjizBA+egVw39Jmk4B6HUmGQsMIA5ScVCaFDe0HpxMpQ7r1Y32Elt
	JasPd7eI2h5ZlRy83xIJeFUmUEjSOYG3gaUQn5WTlAxNJ2zVaFFobYhtSp7YXQc1
	xqPL4K6RHUfGxSWqurHEw==
X-ME-Sender: <xms:FvPoZXQ6Ayx0zwZS3Y4txbtgHwvaNHhTdmL7qgn6aj1iozN2aFYDxQg>
    <xme:FvPoZYw3ymat2cdgP3_UHzevs_Nuh3Z_dQOg6Lklgk2gELwqI-jagSE4C_H9Gx51U
    fBT3DJRZibFCQ_QZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FvPoZc3GcQYLQHIQe6UOmXCMIEiAVpPbgLX4QRjU_7NMl_ePylteWA>
    <xmx:FvPoZXA_7UaVgBosQftopnpzmW2-GGFu4kaN3MeAy9-QUDhvoIaAOQ>
    <xmx:FvPoZQhnhjGgJeMvcOpGSpwGTsrLTcUSwjlWSB0sHz0ADca8OEXq2w>
    <xmx:FvPoZcbIglXps8RKpyHvxZywbPptskTuwLlytDGrqg3rWlwGvtxon2hhPoQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A97D915A0092; Wed,  6 Mar 2024 17:49:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d01b506-f3ce-4485-b9b1-c5d3ac976c00@app.fastmail.com>
In-Reply-To: <cover.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Date: Wed, 06 Mar 2024 23:49:38 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wow, this is great. I=E2=80=99ve always found git-config a bit hard to u=
se.

Thanks for this.

--=20
Kristoffer Haugsbakk
