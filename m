Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7C3770E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511845; cv=none; b=csSlMn7lQxISkhFhxh/s1X3tPwra2only8FnKfIIibILh1B9GzACsJZjWlbms+R5b4xoGDCXVfqsfL23ze7DNsVj2ZXCOjvkWiXQhBdL5xaxjz6FaHSRb334cmdSyu7UWXyGsZxcvs9S1sO9vA3CiEpBPCVkZfHcJLmUREZr1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511845; c=relaxed/simple;
	bh=JZ8lUIn2PQWuofY3ERGUROOFXDFmLS0Bey7qRF8IOt8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UuszNDa14BkKZaYXLR10qh08c83YInEiXb5730lz0eVC+eO6Bzpottssu9bZYnAm/3x4pm0JtRzLIUHxe6KRPeygXeEZZ3BvCZtmfBloaZ2BC2fHCDxRNNM4aD5PQBQE0a/CaOxPJaN7SKVXgvyHSLwrIAsRe/O7SOWT4/2Adhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=KQQiEj2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLh+Q7jP; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="KQQiEj2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLh+Q7jP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id BD0161C000A6;
	Wed, 21 Feb 2024 05:37:21 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 05:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708511841; x=1708598241; bh=OSoIX5mloOvbm4C7Mak/+lHmI7wN8Cgl
	bY1QjG/oQUc=; b=KQQiEj2pX7cPog5l4KjqRx+VTdewdV2MyBubx6exOwAOvoJl
	c0emfdcX8VhHEow7J1t5pGW9U3bkTIPaOCQskXoixTAZi2u3ql7x+FwYFcfR5w7t
	xMADHjkwOiPOgy9t6ynhLweihKeDrXNFzEti4mZxrgZzU8RL+TaPU1Olr1TnLuOH
	S2C1KD3lhOnWAD6lZYvNZkRIOwhfkEodnKEo16Zwi7pfrYBXcDv4lxBEsPGTXqsm
	i+b0ByiPv7YjYVoyJhstKIPO2Kb8bU1DGBHNHJhMlTmGPQG/1LutCRSxrKAHyO1J
	iz0kco1heKZGZERUAHCXcWx+FUoc/oCeCGy6PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708511841; x=
	1708598241; bh=OSoIX5mloOvbm4C7Mak/+lHmI7wN8CglbY1QjG/oQUc=; b=g
	Lh+Q7jPuXt+JQXV8SAJl7lIp6bVYUIzlK6QBMWnUaK9Op7WXreOrExMFMN5t9Gu1
	pvcE30jqcQWRQYwfb5InkFc0lPSKUPwavMXRAGB8mNYV2Gi/efhYuzvzyWiik/G8
	/CJPbsAqTSRXmm+zENJWMQcZXyb0n/EZ6W3Zt9mnK6UhpRu28ny2V6Wlx+HnzePp
	pjf8C5kRovRFWG5du2g3RzZqbHGZDHm0bWYSi0fTU2JK8pZa+HWGcCsj+Qp7GlOr
	yzLlefoWSxG7ikaAk93moP8tWzA8xZ6hawOdT3SUED9jlwJrVogEfokBzUC1YW+u
	2WaBynwSvyJna9h+BySPQ==
X-ME-Sender: <xms:YdLVZfsUxe0a01f5wQIMQu1-fpPYmesq94nokPfnUdraqcuxo_MW0d8>
    <xme:YdLVZQeNHZdyPzXjDgMt9pzrdoobv55o2YZafyerDo0FLSvE1GB8Np3v2GZUX5jhb
    rBvfJZb34WhRkCG9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:YdLVZSyuHfDLHCTX2L3ak8Xjs7y8M6gVcLnqP0y8FhOuwBIMVA424A>
    <xmx:YdLVZeMckuTSQzbC5zlgVIBLDj5aGiqkYFmgVDQ3n_WMD9HkJ4s4ng>
    <xmx:YdLVZf8Csk_TzRONWNR8jNy2zb4pXUAUU7eXqDl3_Y5nxuxqy_ZzfA>
    <xmx:YdLVZRLRdGK3HOihxLxC0m2Xvp6gzrRnJjUmFAknorSU9hMSmB55oosh49Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 086CB15A0093; Wed, 21 Feb 2024 05:37:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5856eabc-63cf-48a0-94a2-7f6d62906aa5@app.fastmail.com>
In-Reply-To: 
 <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
References: 
 <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im>
 <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
Date: Wed, 21 Feb 2024 11:37:00 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Yasushi SHOJI" <yasushi.shoji@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-name: detect and report empty reflogs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 10:56, Patrick Steinhardt wrote:
> The `ref@{n}` syntax allows the user to request the n'th reflog entry
> for a ref. This syntax is zero-indexed, meaning that entry zero refers
> to the first entry in the reflog. The behaviour here is quite confusing
> though and depends on the state of the corresponding reflog:

Maybe this is obvious to other readers, but I sometimes get tripped up
when reading about such logs: what=E2=80=99s the =E2=80=9Cfirst entry=E2=
=80=9D? The oldest one
or newest one? How about:

  =E2=80=9C The `ref@{n}` syntax allows the user to request the n'th ref=
log entry
    for a ref, starting from `ref@{0}` which points to the commit that
    `ref` points to (zero-indexed). The behaviour here is quite confusing
    though and depends on the state of the corresponding reflog:

--=20
Kristoffer Haugsbakk
