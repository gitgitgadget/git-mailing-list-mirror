Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABEF2C684
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143928; cv=none; b=plCtkjtwRE70Uhpzzd/woZCitVrLE76WP2OemqYaABpGBtSmyicBjA5xVHmr2Ry4e2VTSgWeKMnqOLTOy0rbMzlAnETOn4z84zUsQ2CLqq6W2lWEQWAROGOQSRZpHskGM0p+daTuv+9aoGqPZ80QvJ3wOsaEUId00JBnUH2rI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143928; c=relaxed/simple;
	bh=I4ubgXwtuZX45teYCoHcfeCinjFe6QEz+mhBwbbjSQs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Vp+DmiHAbjAGkwc1UAQhP6TloMiJGJws5kap6kbEvVhxp3w0+EGUHUbbzEuGPBSjuAdXcQ69PjvV7cH2CblXXDyBziRkEhU5jIhHDehFIiBRi4VWJs6NWJbeOfDmyiIFnBDZSrrCHxTN03+acsNVFAUPAXbJoa5ya7tKBipj2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SoQb2Xiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdlEnsSR; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SoQb2Xiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdlEnsSR"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 15BFC5C00B9;
	Mon,  5 Feb 2024 09:38:45 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 05 Feb 2024 09:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707143925; x=1707230325; bh=I4ubgXwtuZX45teYCoHcfeCinjFe6QEz
	+mhBwbbjSQs=; b=SoQb2XivReXZHsYvUbB1Xle5J6R3wQlFEw9v+1Lo/Nctk+1B
	MWS2UWEN/Rl45uL3KMguoC3RiT6xAstQAy3usgvjXJOxlRDmOtLrR+Vj3UkEzrTr
	z8jZAoy7mfPoLrAVNlKGwMoLkxuUBt0Ckm9Fw0TT3iSXv6EmUCJak+V4VsJLjacc
	Uacizkxmz6RpoeHAaKraeAxB6Bl66RYZ4UpzLJkhAvhRYVVAfpArrzo8XpPleBj0
	0XEKX6z+9SpfAvZR5Uf3zrYO0cB9/bDq+urBMM2HJ1R3gGgsniYfOd4hsETacREf
	rY0g6Q/1hfoika2kWATnkMKKBEIs4RmxmoorLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707143925; x=
	1707230325; bh=I4ubgXwtuZX45teYCoHcfeCinjFe6QEz+mhBwbbjSQs=; b=F
	dlEnsSRh2pNA5cjSP7e+83C0VRhbKRPZW0z6Eg09F8v0m7Ug83bJK97rL+XeVDDP
	0ray8fCC/q6RTafn/qhyy5CsXa/S/jCerBzoNwPZV3a/HvzDZEzmTdTNrmUDwayH
	j13i7n/EYjVo7JCN158KcFfABL7SyiPD2u8LbahrxLX11YRSphA42LRmGIINr+6A
	5Ce2db7D2WdqGrRd1mPXaKePwRukxjMlgvEzkkmR5ftHWhqusclxOnIMxxt7FmC7
	4CgXitYUt+n+ayEmM3Kvyc3yDpVshWP0C07iR0yVjnfy7yA9VM8itAccmkxKEu7V
	l7JPmfYiE8+O7ttciCzqw==
X-ME-Sender: <xms:9PLAZamlQdUVLPghNXDGPnbrz2xUBmBpoxmbOhSiGcOLoO3QnxSgQ2c>
    <xme:9PLAZR17i1WZ2olROd-1Vszy26LK054ODDw2SDq0nfr2QOGBgj__B4N6gA6qqSbE7
    hqvQXlqj6Hc6DyIUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:9PLAZYrRG1ldV6X4lchWE3HcTGYLbsIWynnu-gDhC-LPMcrFFnAjqw>
    <xmx:9PLAZemfNQsTjkz9Qogrn0tKGDgbtBuA7dO4-jho-apUKFeacNIvzw>
    <xmx:9PLAZY0wkKiQrM-zzalAa47eLTaT5wTYOOrM6rNavlam3eEf-xqrQg>
    <xmx:9fLAZVysdvDniVmcuJAHA7gl6lqdxERMdOFfeZMEnOyhdRxDYUsrpA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BF84915A0092; Mon,  5 Feb 2024 09:38:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
In-Reply-To: <20240205141335.762947-1-vegard.nossum@oracle.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
Date: Mon, 05 Feb 2024 15:38:20 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Vegard Nossum" <vegard.nossum@oracle.com>
Cc: git@vger.kernel.org, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024, at 15:13, Vegard Nossum wrote:
> Link: https://lore.kernel.org/git/0adb1068-ef10-44ed-ad1d-e0927a09245d=
@gmail.com/
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

`Link` is not really used a lot. Junio=E2=80=99s `refs/notes/amlog` will=
 point
back to the patch (which is often close to the =E2=80=9Csuggested by=E2=80=
=9D and so
on).

--=20
Kristoffer Haugsbakk
