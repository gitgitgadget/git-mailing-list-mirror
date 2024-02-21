Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3E8004F
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529924; cv=none; b=YNBEsbW6kcEZhGWRlNMesKn0grHkrwCLR2ESVi3v6QixFSFgADLB/g+AxGfZQz8x9OVRUbjPTyd6zkmFTgW0k3SNgeag4T0D3vfPN6ngFB2d2kSL8Kte72PYJkigL+zWGN8Bk7IiAP2PRyLmtzl/6AoBYdankA8WKMrGVCR9Cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529924; c=relaxed/simple;
	bh=NOic8NDjk/ZevY7JIHNHRqY8auX0X5+AdQvjqOcijdM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PwGWKuDpDfsavT9WAGpUdfxu1S+pXiwArB0Yh22oQ40fnb/Aw+L40hEnZxXE0o7MGptmpB9SG1ehAhr3TlQ4FlRfYvyRiJVLfNX2phakUV/gpfq1Cuzk0GrEfY3J81AOIHSRoMvzfwQ9tGKkQSG9pAHtWHNfEOPpTtntF0skarg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=IdUY2ZWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyLXlz6b; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="IdUY2ZWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyLXlz6b"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DD0405C0053;
	Wed, 21 Feb 2024 10:38:41 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 10:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708529921; x=1708616321; bh=NOic8NDjk/ZevY7JIHNHRqY8auX0X5+A
	dQvjqOcijdM=; b=IdUY2ZWRyeXaKNc/cz1nhKyAFeb1nTU4b/PXcsuh9N1kDuC4
	BDoh9mzR/4yuHsFePX8HEOhbThzfWssELg2ZPl/lyW5s68u7uEHOZvGi2bhiFxiz
	5MXkD8BQ5UEu8blTzw6UMfccUO7RwkwFogcq6X2haELmjR+boc/fdKF5tGR1EJrd
	jdezyYxJtImKsgzoZf9dY0P/w9Ud3dolB4bcIoH05bfH10o6Wt/NgBF3LudPTLiu
	Y8Ckur3//ku5eDh5A02tExtuYynCysXpCbmuzhyZwXwu0I/Q1t/noHQ5N3qFna8F
	TGNhoZnuraLeVnVKjhzMQB92kVTAUv8Aiv+bWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708529921; x=
	1708616321; bh=NOic8NDjk/ZevY7JIHNHRqY8auX0X5+AdQvjqOcijdM=; b=S
	yLXlz6bSHwNTsK1ePRKOD2HzdpSwml15U6byZtFQuuqB00PJ5UAoMcllR9v78gTG
	n0ip/7RpvdLvV5Zm78s60ZAZGoJw1AV3t2FyVfMeUDJSzR9NjkC4wttc9yAb+uUd
	FgNF39fN7lVGI+/6duDvAJXbi/himmW0zh6nk5umawJeIGxHa1zA74/w7sAgDIAq
	OJPar4fvyZ+SfVs9ZYJoPY++RssAokd5Ht+uJ5shbo4rwKnvx6a3f0CHgqmxtiFU
	m6uF8q45I9XMjx7aSbcFbqzZuvVYcM3sM+QroVgSYgVlTK1FZQ4lx+M5NYjISC/c
	tM4EpFYhMJXAvPrbh1/xA==
X-ME-Sender: <xms:ARnWZQG-HVtxRLxEh4rdZ1XxtBIv_e-qtYpHQeLOfK7Sy1v8q3rNoXQ>
    <xme:ARnWZZXoQNMB96-iiDszyx2VWvOzSbRO-Mfl-f51Tm4yQpQxtoFUtMHqQi6w-eQlb
    ZJXJpnj5BLzowPxtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ARnWZaI9Vdrsw_s_W2iWwKWpsQ1nI1ZjJw2nEeYUvDV5tdbVhW2S6A>
    <xmx:ARnWZSE25h1ltcCRdDvu0-wk5KSg2Ojb3zDdhtI2Pc1WqX2qu41fBQ>
    <xmx:ARnWZWV2VlDrCisTtYdlBCtCUk11PGgccMfw4t3elrksVIfU6_4WXg>
    <xmx:ARnWZZeEZ0Pi29YbQc8BW-af_Rz_2ETBqttBMPFX_kvcuan8ZFYzfQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A47C515A0092; Wed, 21 Feb 2024 10:38:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89622ba9-10b3-4f03-8088-881a7e18a07a@app.fastmail.com>
In-Reply-To: 
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
References: 
 <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
Date: Wed, 21 Feb 2024 16:38:21 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Maarten Ackermans" <maarten.ackermans@gmail.com>
Cc: git@vger.kernel.org, "Sean Allred" <allred.sean@gmail.com>
Subject: Re: Breaking change with "git log -n" since 2.43
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 15:21, Maarten Ackermans wrote:
> Whether or not that is Git's definition of a breaking change, the
> message of the commit in question acknowledges that the commands in
> the "log" family are the oldest in the system:

I was assuming Semantic Versioning (SV). Not because that=E2=80=99s the =
policy
in Git (?) but because this problem happened in a JS app./library. And
SV as far as I understand it define _breaking changes_ relative to the
=E2=80=9Cpublic API=E2=80=9D. And for git-log(1) the public API is the d=
ocumentation,
right?

(But maybe I=E2=80=99ve just never managed to understand SV.)

I also see now that this is some SV app./library.

--=20
Kristoffer Haugsbakk
