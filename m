Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B95768F1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457464; cv=none; b=s5AObsfRhJy/p0qD9RZ+jRfVqQDS/L4EVJubVqiKqNDLVpsjrGp9n026nXsZr1n0VKNNYx7NgPQWuq/zbvEMUatXGo2X9R1MO9z2GpjS3a1UJfCVEZJvWcIP2qF0IP017svXmnM9tjpqYLVeeE9judRoP08UWDRFFhmIRahqQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457464; c=relaxed/simple;
	bh=8RYLhGWKTp1gFS7lcTk8H+wVH3F9xan0KG+5o8k+yyc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IpWLwoLKbaZ/sguOZP2Jz95wUQi5Ed0p21/glY8zggLhjZashf5EykZN5wYfCEMrJdSY/BxV3FyfKSJl42S8uSZ9MyEQyX3gzMjVFS9l02aVPE2JiF0GwqVtIVdq0qKE6fBOknyPmIcyKS/k/MzDJew/KteCWFje1vNqWiem2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=brS7D6SV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgSZ8S68; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="brS7D6SV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgSZ8S68"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A64FD5C00A2;
	Tue, 20 Feb 2024 14:31:00 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 14:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708457460; x=1708543860; bh=8RYLhGWKTp1gFS7lcTk8H+wVH3F9xan0
	KG+5o8k+yyc=; b=brS7D6SVBY3GGUFpwJKR+3Uy3B6PefdXwaLWywPtWBYZgBqk
	OBtQg7w734PpgiWvbZBg9VsaoeXkq6Ux3VuDCmQR23OyKVelQZgItPFucMN6ekyX
	Oxsg6p1EHDsYdnyOaYLXd9gp0ZRXjQDCxAgJvv/y7tVbxP3e/f9pNNf0rQg/XzrL
	XN1nnDJJzQkQczUrIF6XMfiXaxioXXXzVXOA3VueQI433DwAHcDH8HnA62U9nzB4
	4Cz+RhTxPmPY6EZKnxsxv2xdzz52+PGC58XSqRsFX9HYlY85yW+3qWNddJm7ahON
	koSOAWaR+s7YfP4g2KWf+/qtPwQzC99FvJK/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708457460; x=
	1708543860; bh=8RYLhGWKTp1gFS7lcTk8H+wVH3F9xan0KG+5o8k+yyc=; b=G
	gSZ8S68M8fzCoXBwkdaqNvpyPpaqf9yeCLIFQKKeEhmj9W3RgVDBW9L7KZCCVSzs
	n6ZEpRaGQusuCZNGLLUF4KbBfMVNr6iNAGWBg5HuK2mOIhCJqZNNcFLDEUZJvsT5
	6RRwhKVbvbjbu4mdFPGiLf0E6Apzo7T1qbV7huGTiFwiSigUYFtvVM9pJja5LM4x
	eulII5Dpj1JbyF7FoigZgGmOt8R6hd7jEybDkeZLSSeKVfHiJavj3XI9auMRt1pr
	uLVLGMHFmMX5xtwAuTMu6KBSqN2dXuTUWG4kvXkjGAU55QZqwDqSeJgKQ8bAHt2q
	LRCnjYJOKvl1aYolU07eA==
X-ME-Sender: <xms:9P3UZQO8i4uPgjo-675j6OPmZVKwT3t0_xXE2V7YtGPXfjnFemdbWls>
    <xme:9P3UZW_bIyqtEReAwbtQYmSDb0UXtHgDfUVSzNZUaDin_vi_0Z28aGnR5GhWLuHEu
    4o9trOnKRM6gn1ooQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:9P3UZXSAHqwcoF-Lmz2D76ws_CDQF6qGJO12QpUy_LW1lWRupE4W3A>
    <xmx:9P3UZYtVOPgRTuluFp1PbGkTxI8XgWj3MAJdUXv-QlfYUpob4ONTiw>
    <xmx:9P3UZYcSP-8HpNF-RlJJjkCDQ3o5VSetwQ3DcPchYTYABF3Ruf0yvQ>
    <xmx:9P3UZZpJ8UbXIb4t8S9Xdot61stbSfvbCL-OG7Nyq-3gWmLmrSoobg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5E6DC15A0092; Tue, 20 Feb 2024 14:31:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14a10788-37fb-46ad-91f4-303703dbd312@app.fastmail.com>
In-Reply-To: <31135b8a-af7a-4d73-b3b3-d91ea8d3d5fd@gmail.com>
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com> <xmqq34tnyhhf.fsf@gitster.g>
 <1d66eb0f-077a-4a63-8acf-f383538a41c7@gmail.com> <xmqq5xyjx0jc.fsf@gitster.g>
 <31135b8a-af7a-4d73-b3b3-d91ea8d3d5fd@gmail.com>
Date: Tue, 20 Feb 2024 20:30:03 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Ricardo C" <rpc01234@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024, at 04:59, Ricardo C wrote:
> That makes sense. Do you have any ideas on how to address this? It fee=
ls to me
> like providing this config option is fundamentally incompatible with r=
equiring
> backwards-compatible behavior regardless of configuration.

If my armchair also had a time machine: one could have used an `-s`
option to `git` (`git -s stash`) that only reads a few configuration
variables, like `user.name` and `user.email`. It would read none of the
variables meant for making interactive/custom use convenient. This would
be meant for scripts. That way new user-convenience config variables
wouldn=E2=80=99t interfere with some `git -s` invocation deep in some sc=
ript
somewhere.

As for the status quo though one seems stuck.
