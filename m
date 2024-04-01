Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671E42056
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999876; cv=none; b=ZJq/IBTgLQSMI5jjpHPTHFQJvhQzEhB6GMELkgG6fjbh673ePN4yINQHfjGM1YKWPTbKZHTjUFApYgz55DlkGRy+iydXmFEBDS0zcmTqXJ+InTFTh6EzjmsyNcNbhG/tzypxkYQq8OAr77vKzihE/SWCHm4PjnmOgYCoF1hDrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999876; c=relaxed/simple;
	bh=uEtkqy7TgJBumWejJRoTifekE3A/oMx6FflRvfudta8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FsSmS9aMZ7KzdqZ98IXDflAyz2H5J5KjO/4/S22+4+WWV5ooDgAdjbqo/ZJZ2d+yDdsu+GcTmkz324jTvO7lKg6p7G/weHl3KYdKT/frD3C5CHmFZhw6nK28RVaDVyoIn8lUOhgecbm24Saa8pSRcZNlqtxj3bqG4MSstfpsijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=D62vk/Hq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXILCGsr; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="D62vk/Hq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXILCGsr"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7D4FA3200A0D;
	Mon,  1 Apr 2024 15:31:12 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 01 Apr 2024 15:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711999872; x=1712086272; bh=kJ0pVPsreMMZdd3w2n3vWiMGKkXgNVJC
	CqUsYwV16IM=; b=D62vk/Hq6VeKn46or1ecH+LG+gpKAfoxiE4Zr2liYeSqM/YB
	CZjWVo687K5f9o6Tlnt2PVIIxHWyvLllge9R0FxPYk4K2HZQzkYLv6FVOJ+/fxW3
	hoAL8ojRjbpiOjbcAnZmf9sQ13lAecIZKnDYNodWJsKVvcLz47+Ff3NifASSNxlT
	ZdbmvF2ftWb1vhWGUqQB/PuJOZkLOxSkaGX+u30Mwk6/a/gupDMphhPKl/amaOfr
	Lk6dtDxlJ1kPg3WAIvOTOJDKtP2BR7GktV//Zg82sCPOvww3dFoygp91v49Ksyf4
	wuDnspccnElnlo4S1zWvaGeCy3uoLb1Clw2BhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711999872; x=
	1712086272; bh=kJ0pVPsreMMZdd3w2n3vWiMGKkXgNVJCCqUsYwV16IM=; b=B
	XILCGsr3Zlu2ZtNW0Ece7qp5PP4E8/ktHAHIxLIuD6ObZGpJQLLehrNsChwORg8r
	5jv8SD0ADDyfOpi154vhd+nxpDZviBcmwme1NZUHz8jr0yulIXqagu5dydgqdu31
	wh0qPQ83M6y/xqAHRvGjOaesi4GthQROM8XS1OoA2ddYYbEr6ib/dNXKcv7aDp3k
	Ywd3RgLEfABS0LrgBRgyI9MddL0Q495OkqpKcxm7kMOpjHy/b+wzzVfDklgef9WP
	BqnZsIr5p/7ik63Y9moH5MV/8inq6DvB1SOwsgM2cdpmTW3q5Z2dl+EzDVP12RRW
	wfft13ADE1bBhN26dOK1A==
X-ME-Sender: <xms:fwsLZi86x-P3lJn-KY9fb5hMt-be0k5hpigJ8XVs_kv2ygSzf80GLuE>
    <xme:fwsLZiscZKe4ew-I4YxJ9dEU2G3YBSTu9crIiVpnBfe-gRXp6TSmXz4j5hQ4-DPda
    XSQD8-0dABHUaw_FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:fwsLZoD48m8gA7zm8WoLC3lVdyOEENDGijBbvjm8XPnG3j_k2p-O_Q>
    <xmx:fwsLZqc6mlCV-wUYzKLoilHXQkBfYufQxVADHDSG_jbt_gddHv_jYA>
    <xmx:fwsLZnPHlAIh-wmEAvGvDnI-JIZdGa4HAQX3CtuHBsdW_RJLypXVUQ>
    <xmx:fwsLZknadN3qVOoxow570fDUiSI44spVxaZyuHddVbYm7Ry-Zf8LLw>
    <xmx:gAsLZt1TyXw1T-6GmBvBDcHkroqL2Y-VZlh4CufrD3VEbCfBQrKFrg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D125915A0092; Mon,  1 Apr 2024 15:31:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb4cd824-c9ca-4adb-8339-885273aed9bc@app.fastmail.com>
In-Reply-To: <1117b5b1-fb9e-49b8-b1c3-47b985adce35@gmail.com>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
 <1117b5b1-fb9e-49b8-b1c3-47b985adce35@gmail.com>
Date: Mon, 01 Apr 2024 21:30:51 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: "Git List" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] bugreport: add a mark to each proposed questions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024, at 18:36, Rub=C3=A9n Justo wrote:
> Include a mark in the questions we provide, to enhance the readability
> of the reports we receive.
>
> Of course, the user has the flexibility to choose a different format or
> rewrite the report entirely.  However, including these marks in the
> template may suggest that we value some structure in the message.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>

I like this. The questions and the answers not being differentiated
makes things harder to read.
