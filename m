Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2948061F
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529566; cv=none; b=j6sYmFlFpdypwFXdFPJRzWOyUHZob90NMJ9Qo6Y7fvLV1ll8FMsPGd+THye5gIwpu6lErOPYRJ5RDOKXVMBXQw3KMK7xjLTPFI1bsjBUsvBKp/MFu2AX2gJ605baHmn7PlzLLUvz8LCBIR2S/1kf3J9HemNrP8IsvapP7EwN4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529566; c=relaxed/simple;
	bh=qfYklG1pq063hWLPMyyBStxE0WcXHHP/zLxOhOG9V7c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WOkJ9xxiRuMcvqKT6F0HuDKcpUFbYXEZcgDTVTa602Z4KgRzGPX/8FJwk0vG8S9WMdZnQOREQcutGlJuvLrITzAPFleSmh27lWFPqtebqIbSg7kaHQ4tuuSak6TDPKtGUusbcDunWZ4ILgizR4UuHO0dbY4Pas/HiDWJGcBZkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=QWeFBBGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYAggEw1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QWeFBBGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYAggEw1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5566213800D6;
	Wed, 21 Feb 2024 10:32:43 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 10:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708529563; x=1708615963; bh=8uWuE7ZuO+frA4bsk52io/na6lr8D40I
	YbOAW9oM9mo=; b=QWeFBBGxLUoO70CQxdS79Ng5jjniFQqM7gHAILUMHeqLUPlX
	dxzP7wGy/n2s2GJY8bzDu64Ynzg5vVlZ0TfNqRdO9ctno8tvR26R6eTKiZC79WXB
	3bHn4ylmsczV70OQg1uwkyaSZ0jjwD30KCjulzlAEO32tNoxO+0QWidQHVmbzlUy
	NJW7m1E306e2lyIE2YeVRUa241g7WCOkLy82XmFpPj2SZr6w4EV8d1d3vxOlOb+p
	jgRnqIEECkSskE1fvUklh0+x06DoRfChjFNpr27OCQ6fR8BbubrTZz/PUMng3DfZ
	KxSnEJWY7890pvzEQtPASGGURj06rVuwWsQxnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708529563; x=
	1708615963; bh=8uWuE7ZuO+frA4bsk52io/na6lr8D40IYbOAW9oM9mo=; b=N
	YAggEw1zq4Dm84fHTQ6zIYYTx5glQhtTIpdVoU+mOjYWe/N+7nTQYmWL0y2maOGu
	S65fCATMdwCsYX6pF/jHrEQlHk1xIbFywU/rumqNsutuQ0wKgWD4whbFWXKdv053
	HJEBTr3/Z4KK2XJUWUuDgzkYPqsNkwY7qBGethIeUzpSxy4QjqZHNrQAO2GLeytN
	9LKAOmqe448f1+0ZsWobH/hn+6WIIamtOrnB/58qhQN9bpqi+dANeTo0xKSx81hw
	TrL9G50kzHdUCnxCjzefzDsfLv/tZMEsY59Jti1YAkOom3jfs1pPSgBLFY6oB/iw
	MhJA2ZTMmPGJR7SXrfd7w==
X-ME-Sender: <xms:mxfWZXv6wr91CNBoJ4FHZMJ8l7-53ctzg1mBsvdOtS36OcbF10kJafo>
    <xme:mxfWZYdEaa7FBb3jpxV1AbAy30RKlEmGV7HyE0LBHeL1BIA5HwXTx--P63SU47e1e
    DnQbMrA-2mGS9qiPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:mxfWZazPNwxiI9yjxfQBklInsI5_WS-XvNAOIUiI3aCTCWb1RjC96Q>
    <xmx:mxfWZWNgyzcuoGCdRqHDdZAw7RGeNijKQVSu58kuVV0GpYtWeOmHGg>
    <xmx:mxfWZX_AuGuIA7FGs0bJOyrXX-ZEQh3JmmBOo9A-C0u_gyt5neHrNw>
    <xmx:mxfWZZK-hRIZzx1TdfYv3naK8rSq1yvITsdLPHJssBAtpGNhPPpupA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EFE8615A0092; Wed, 21 Feb 2024 10:32:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <310b2dcf-df69-4984-9a92-b8485e0f715b@app.fastmail.com>
In-Reply-To: 
 <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
References: 
 <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
 <9c52ea4e-f84e-4c64-977d-14a468236c80@app.fastmail.com>
 <CAB=tB2tgbLjBPvgBQDoNJi7e8+LMzxHSbg6D2jKUSJXPmQFrxA@mail.gmail.com>
 <m04je1dhdx.fsf@epic96565.epic.com>
 <CAB=tB2uZb+8QLmrk_tK5PKJtDE=RmBr=eBBb7U7ygSmkFoXvWg@mail.gmail.com>
Date: Wed, 21 Feb 2024 16:32:13 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Maarten Ackermans" <maarten.ackermans@gmail.com>
Cc: git@vger.kernel.org, "Sean Allred" <allred.sean@gmail.com>
Subject: Re: Breaking change with "git log -n" since 2.43
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 16:07, Maarten Ackermans wrote:
> I would suggest displaying a warning in case of invalid input (such as
> this out of range error), and to fall back to output all as if the
> "-n" flag was unspecified. If more strict handling is still desired,
> it could instead be a deprecation warning with a grace period, giving
> applications some time to update their git usage.

From 71a1e9482:

  =E2=80=9C As a natural consequence, an argument that does not begin wi=
th a
    digit (e.g., "q") silently becomes zero, too.

It sounds like the non-breaking behavior for non-number input like `q`
is to silently become `0`.[1] But then that too-large number input would
also become `0`, which doesn=E2=80=99t help for that JavaScript
application/library. Unless `strtol_i` is able to differentiate between
different errors by returning different negative numbers?

=E2=80=A0 1: Or else you risk breaking usages where they rely on bad inp=
ut
    becoming `0`
--=20
Kristoffer Haugsbakk
