Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AED3F9DB
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374263; cv=none; b=nosNL5kAHwx0BZAoECFunnXYDac8adEf0TvoNMfR+d8TjfRoX7lFZ28itLcJt5OHDBblnDRMbI9CG1ekrZdnUJRYD5eaw4y11e5HYFNiKMG4736yFsy3Y9vCfH/YaFTBs8HGwELK+XBqHkOxa9Nt3SI6HzklEHNTfXoKvY+ndTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374263; c=relaxed/simple;
	bh=NqAmUGnnnQ8EZBxjkp0T9couxyz6gfzh51F24TckRU0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=De1KDPOH3tTR/3x1BOYuxqO3eVmhxKZ98zRpfpLWkMGZNcC+r7E5VQ+ijucxRUFzo6iQHP6wY6KKoWSt3lhxVZlW37yBqEvysniJMACnpqkbt5fiTgkkIu736tfsrjzRGFzZHl113+jXesDyhKI5+e09XwGwkwo4B2wzxcX38Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=JzDnTpyv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wAeRZFpx; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JzDnTpyv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wAeRZFpx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DB4DD5C0152;
	Thu,  8 Feb 2024 01:37:39 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 08 Feb 2024 01:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707374259; x=
	1707460659; bh=E3UGQBA92iHzRkYjzCm6vExtfC5DBN1jggqaKI6KS38=; b=J
	zDnTpyv2lf9J8dNDpyJxFYXt0ZEkmbVh2x0L6c8Liy1cQrV3GbN9UNoz5jngUIEd
	cJxosIHywZuct0tn4e7pz+2Phd4C07F91/gkfxHwueubS/teLjWG7h/lXiNylQRd
	f4Zk8EkWo0P2P9weNPP7bhzaCFlwpJ1kIhfl/rgj+SEYGqBNHMWUmoiVS+xpnO5F
	PtLZFEdS/gp6soiqUa27h4qFJEBZ5i0H8kacPnFfhq445+H7XIIVE0LYXtcfrHTe
	dm0XC9RzMhFOShsO2KdiwdLd4o890gAjCobDbNVEJXFYiYVtCJTTAyJ5ISzyYDcG
	DwLFjSnCBDyR8EYy4SqbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707374259; x=1707460659; bh=E3UGQBA92iHzRkYjzCm6vExtfC5D
	BN1jggqaKI6KS38=; b=wAeRZFpxDvD4RJbdZCCuQAXsjErdFqm//WpbEqp7ANeT
	yCNhh3kIWUfHoJWZr0lEz+L1ERLru0T+X6us8sl9zkRw+qMrOwFLtpit3xixxSzX
	vhmYNZC97syimpcksTfp4SR44iqRnIfpPxWSkwPKN7ZQ0Hp5SlGHqJeLNq6KlHuH
	FKudkZ0vY6pYaRmM/c2eSoV4tFOtllrbvykNgjPpIRM9d7kYSDPoFbVEI6wFGwPQ
	3ZwtXZkSz2afEPdsPY6QgKCm5EXxF95ZEr2hSSz8fmd76WjGl3oECpRcrl/Hab/l
	zwzir/sDkeN57oOdNnJJVBzzZZ3Fmn2bd8VTyXGJqg==
X-ME-Sender: <xms:s3bEZaJzBoMeUaR3nsF7CODrwGSHfMkOdxxRfzPgt4FQmniLSmeiyLc>
    <xme:s3bEZSLk8PKYhEP93XvDLLQSP-WboQWzVRaThyFhETuhRTsN6LnRBnprWcpcn440_
    TpLLkQ434XmXkyAPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtsehttd
    ertderredtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptd
    ektdejieffleetffehieehueffgfehleeufedtjeekueffgfeihfegkeffffeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:s3bEZasGQKCPIFh8dvJG0gA5isUrDmG6oJN9TcQPTxNq2aZPEmcGuQ>
    <xmx:s3bEZfbkx3VzUoACvOBA-CMpiC7bvtOwgKp5jTmnP3bC9E_XoD-eig>
    <xmx:s3bEZRZF3WDCSBleX5AHcNwPTlSTCEhK8CoNE8iggUGPBKR7sRaPPQ>
    <xmx:s3bEZQxZ3lIQeOqMAE-hyA4D-cudLyQBpJDPbi21_m7Njq9ax7HfPw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9EF3A15A0092; Thu,  8 Feb 2024 01:37:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a8e67945-153b-43bb-b1b0-ea24fa786097@app.fastmail.com>
In-Reply-To: <20240207214436.538586-2-gitster@pobox.com>
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
 <20240207214436.538586-1-gitster@pobox.com>
 <20240207214436.538586-2-gitster@pobox.com>
Date: Thu, 08 Feb 2024 07:36:55 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Matthieu Moy" <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] bisect: document "terms" subcommand more fully
Content-Type: text/plain

On Wed, Feb 7, 2024, at 22:44, Junio C Hamano wrote:
> The documentation for "git bisect terms", although it did not hide
> any information, was a bit incomplete and forced readers to fill in
> the blanks to get the complete picture.
>
> Acked-by: Matthieu Moy <git@matthieu-moy.fr>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Past tense? How about:

    The documentation for "git bisect terms"---although it does not hide
    any information---is a bit incomplete and forces readers to fill in
    the blanks to get the complete picture.

-- 
Kristoffer Haugsbakk

