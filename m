Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160B12CD90
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484168; cv=none; b=duQ3CUPFPeUPqawSTBMniFRCoMrB7FM4TbvVDFeZcypjBxExmRZvGvnpPxBUOLA5SXahAhjlWPATP2S4Z5gMfxFpfTzxS26HSOOf1ZdJZ1sK1SpHeD+cKRCvIhMUPBkIYogCljI/wR7WleHI3JIf2DweUgiL/IdaZZDS7Db1eFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484168; c=relaxed/simple;
	bh=CPmQDpm0HCMeoiBlJtmRhFpzxYcdg47t4nGcDY46/hs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dQSbyjJcvx3ZCT0V6shpwOq864W+iIwjeHjJFn8IT6mAl4/U2sZTyNMqMAuG0EncRNURHlgJYIEHSgHsgoFFHl1m3ErAD2MMILrfuqpNMQJFOc8n7KxR7PkJMsJxBMWzDHXr2jjOZuExclZkFsA9YiXN4nJ8UfKeofWgS2XOEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VEN7d1eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XplA+25k; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VEN7d1eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XplA+25k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 8B6B41C00150;
	Tue, 30 Apr 2024 09:36:02 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714484162; x=
	1714570562; bh=bb1MumYyW9AmmDu/qLfy5ShXpGyHvKt5BkPNONRRs+8=; b=V
	EN7d1eM/YHLUVvVvOpV3+wwbJ8J66RFE2JsBlxqZR64a3l2c4VYRL+XG4HaA3S6n
	WeGzU+Nlu3/6ceqNN5B2z5qQTYbgfv8zKZBqlNlD4DZq9Gk50TP2Wj/LGnf4COR1
	sj9e7GnM0qEwDN7oeKUCz3St0CFgM9VxezNOKCxnCMPpYkGZiZGX8M9oZm8cHTTp
	mzVQxM2LPPOiCxu0ynnkYgaLUskSVJfKARfIXi6kd5xMbDSXXwR5DEDcBesMHXFm
	cUrr9fTCNsY/OreIrHdIdUPd1/CZoL9F57SAv0ALHsXj8Wcnf0pXhWTVATdRgr9O
	0+X1rTQoM6SQ810++KxMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714484162; x=1714570562; bh=bb1MumYyW9AmmDu/qLfy5ShXpGyH
	vKt5BkPNONRRs+8=; b=XplA+25knuVt93X4ZcScd5CydSqApw3rN9vgRrLuJL+r
	CFHGJ9aITcvp0LGeMRNb3Gfp1aICtplrGYW0IRRWT2O7FbSwAcXqL4fA8n5AwNhU
	9QCHyAJ0EkzpAmR+yczdj3oiSv38GtMCxmRHi2mcD3jDDuVHp4U5e6gufJKyNAGl
	azJ27vi4ToxwMKVtGNolHxaa3C+9f9SMyoUW3/eo/OZ8u0nkS0k2Pbr8ybywV+k8
	/vQ2fwkiC9kyu4J+Z5PM92V8Cx3Z/hSEAD4PnOtylHZYYxXUxAflQxUMFPGxT/q5
	8LGnCoI3H7Co7yIi9ilGEtU40tewv/rBTyTiZ3tC3Q==
X-ME-Sender: <xms:wvMwZnJ4fvxwoLcKABr8APeSTqoP3rHw8_aXkXZbESTdbwflZH73V1o>
    <xme:wvMwZrLQHU8BcXt9TpmDPufEfXzj5QJJpAfwHK88GveH8uMPi3wRNez5Sffuc01Gc
    RJ5NgM2aKiFbteb3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:wvMwZvsfqjCe_mkiIFk2F58dJRt-kq2kMV2Si4yG6BKQrIyixCwBMg>
    <xmx:wvMwZgaMcvv48hH4ps4bYeu0TprSYZpjd7Fl0J-cvE1-PWGpptVZag>
    <xmx:wvMwZubGXn9NyW76P4ICiexmyrYOcFM2AmSilp-5ZNAyS-MakxoMFQ>
    <xmx:wvMwZkDw-7ImnRkHUCChGv_R76QlXy_SJYTn_bdlkRpsrMpmPmjq-g>
    <xmx:wvMwZjPeIhg9gaXglY5EPvZgaHlrPKlaSik1X0IHNim8Fuj95fk737Aa>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E0AE715A0092; Tue, 30 Apr 2024 09:36:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <777fa7d3-17f8-4883-9f9a-c4077866d394@app.fastmail.com>
In-Reply-To: 
 <1f2f8cf3f2cfba65787551ce6571376275ef3a8d.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im>
 <1f2f8cf3f2cfba65787551ce6571376275ef3a8d.1714479928.git.ps@pks.im>
Date: Tue, 30 Apr 2024 15:35:13 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Jeff King" <peff@peff.net>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Justin Tobler" <jltobler@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v2 02/10] Documentation/glossary: clarify limitations of pseudorefs
Content-Type: text/plain

On Tue, Apr 30, 2024, at 14:26, Patrick Steinhardt wrote:
>   - They are not surfaced when iterating through refs, like when using
>     git-for-each-ref(1). They are no ref, so iterating through refs
>     should not surface them.

s/They are no ref/They are not refs

-- 
Kristoffer Haugsbakk

