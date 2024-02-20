Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96167C72
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467491; cv=none; b=a5Jfi7Zxr8g9e6DFflzj+wnzhYKgGPHq/tTuFwTWLZppnUUj9jU0PRxiodJ4WcSEHQU4S/no4PY6G3guHOzbEt6IpTryPN0SBkQ0F6JGvYao0LsxNbFavAluT+9gS3TBjB47LLKnb/C2a6stx9D3mvU7Z1Vq4OwYyiSJ46aMxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467491; c=relaxed/simple;
	bh=6eA/IsvdI6lpqt8QMhhPvFs2aYkWmn1hgmT30i8ZKMc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WsSajrRI5v6Yiv1KCezByc71q7UJMPJSUlUSxNRUbxr6JuZ9x1Jf5VL2RkSLtb0poFTWZ2241ccAsO7syfaLmNYn1jmxy7N0p8BYW78qi1lfoxeV6RNjqgamzU/byrWeg2S/+f9AHtpDmd8lkz5P0jqrwFkBY87NxRlhETTN4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=GcHMttIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUZZh/lI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="GcHMttIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUZZh/lI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEF1D11400F1;
	Tue, 20 Feb 2024 17:18:07 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 17:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708467487; x=1708553887; bh=6eA/IsvdI6lpqt8QMhhPvFs2aYkWmn1h
	gmT30i8ZKMc=; b=GcHMttIj2uWJT6ez3DuNH3FUDp1XSVcES6fK8+ZUHVgZPb7V
	KfGXuQGVVyX/YEzVuWWZXZSX4y5cCYIJ6nPgVDDBpyqOBRpwJ0T7WiChItg0Jnlq
	DtOQPwfrvuip52BR553wPxC1iehXoagZkvCTObc6oorEAtUMoT33BHMFM9jyj5f9
	q43dz8mZKs8he/g00W6KsFHnZ6eqFrzgwXtKvGrOPdIZ+ojGgeJWZGPn2T9wh6hH
	QSyPEOypDUqUVtx9VLM3YT70+q/Tw6Z+PQeEVUPomuyBcqe46obVAJQ52Aj/zdBz
	Ltshy0WqHBtuO9u5e5qN2RobuemxQDCZ8kfx6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708467487; x=
	1708553887; bh=6eA/IsvdI6lpqt8QMhhPvFs2aYkWmn1hgmT30i8ZKMc=; b=C
	UZZh/lIpHQkjhG9edRkCuJeB35vBbi77xIy5rc56NeqEJVzWYDPC2nra4RkZOTz0
	u8FdE8GXAK5HbHEjZddEXx4nLJtM5N0eFxHUP16rwfcgyqYavcfaRqRpZ0KFBjqM
	li0PCpub22GKO3+YfW0uZiLW7YAOlTzIvrwUGjK+lb5609TEsjJ8Q3Qz+EPGViA5
	MjUxoDk5eLm5Ia2KugbLBi96brdNE6R0dLP+yFf5tUFtFMs0q6VTYWHiOdBBL7fl
	bpmCJHQbTsmUWgcKr7k89x4+7nc+jB/2Rk7XIKF7PoEh+XAZZWuFWvbLITwyCags
	a2ad2YEqO83OLA3l9hbLg==
X-ME-Sender: <xms:HyXVZWzma6dMa3u9DN2Y-_tqbrC7lmzDVxGO74weP1yU7zkzlg2QvsY>
    <xme:HyXVZSRAfJWPVyf0l3Gcxo2fAOjrW2i_KfXKh0hu0zOM-v-rNnEiWvz82VFp8w-7s
    AiooDexemJGJ-Md2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:HyXVZYX_F5gq6QYzDLNos0sa0Z0mYMpCRfQ-yVjl1YtOmMZGNPkusQ>
    <xmx:HyXVZci1SHuVYV91_g5KWZqET6NkcDNFPDvMDIVV71R8Sxx36835wA>
    <xmx:HyXVZYDa6hH5u3p9eIeYSBAVSsAoPGBPcsrj-75l5hDPdHzcjoZwrw>
    <xmx:HyXVZbO3Rv6k44NzjfowWFikz0dNDrM4Z3TrsAHALEDcC3D5pv_HtQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5FFB715A0092; Tue, 20 Feb 2024 17:18:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37c0c025-7120-49f3-bc2f-f35249339f3a@app.fastmail.com>
In-Reply-To: 
 <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
References: 
 <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
Date: Tue, 20 Feb 2024 23:17:47 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] documentation: send-email: use camel case consistently
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 23:01, Dragan Simic wrote:
> Correct a few random "sendemail.*" configuration parameter names in the
> documentation that, for some unknown reason and contrary to the expect=
ed,
> didn't use camel case format.

Interesting. Consistency is good. Nice work.

PS: Please keep me on CC. I=E2=80=99m not subscribed to the list.

PPS: =F0=9F=98=89

--=20
Kristoffer Haugsbakk

