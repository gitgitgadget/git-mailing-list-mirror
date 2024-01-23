Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BBC53AB
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044045; cv=none; b=TEgLCsUv6ItVtPX/ZSgOHEWtMg8hXKLOv4PjB3YUsXuZFLbznaD7zU97u3EYbwYOi19FjJF3ulOhpQ5tuVtUJMEgJvxWXwR1yiuU/43oxr/4U37/xPgYcUqC4lO6HJ694sLkxJF9YQ4yI42MMWKzrbeSbprktg7WoQYKzHcSZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044045; c=relaxed/simple;
	bh=4JkvJA1mdwmde2Dq82+/3QyAy8Fc/BqtDm0uO/hJzBU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZZt3PU0wKRtMM1UIzzmVCvtPaHtK0A1CkJrMtZcWZ7J8NX0q3fbHO28cnZV3dkZ2lhhKYYs057q5BK7j+xedTTtD52DjCpIPBMjMbfi6SAuGiH0xIBie+MaEzBn5uxNvOaPFlMi/ICKWLnmJKP4Rs/Lh9+D2pKPnZ3KxbY/I/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=EVZNY8ux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x39mGjPK; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="EVZNY8ux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x39mGjPK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BEA8B5C022B;
	Tue, 23 Jan 2024 16:07:21 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 23 Jan 2024 16:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706044041; x=1706130441; bh=4JkvJA1mdwmde2Dq82+/3QyAy8Fc/Bqt
	Dm0uO/hJzBU=; b=EVZNY8uxIUuDv9MwPPL+VqDGeM21Tqb4e6JpOBbazQhzfIYC
	Ajn+XWdlHEYt7MwK36MXTRbpMVwArekMrHVJuoWHFj1U8zI39vx767uRZLi1uubO
	RzXUEcAAtqhr+yqlvK7mhVazwoV6v+ktITFGHGkQo8BkmVGr39H/F6OrSBPkmD2V
	if2eXr4aFXPyb3eKcCWX4EG16oZ5eL50PaKTU40a9C2n/JoucY+KuEcJBrqS5pFC
	jQ9IRZP5ox4SmwiRsBvRInEpzVumbWeAgPx2qK2tBkAAsAhjYFlBgjQtbkX8rR4K
	xabLYxvvErVVfvFRXXIhTk5m2mPBeGS5cG7Qiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706044041; x=
	1706130441; bh=4JkvJA1mdwmde2Dq82+/3QyAy8Fc/BqtDm0uO/hJzBU=; b=x
	39mGjPKG8tOEQ1EoHnh6KlUj8NDM1bS3BulC6LPLRhtU7jIjuqCB3OgBxgYJYIiO
	LiZTHBU4AwEqXjEwHyAloN+cygrZgbGkkVRrG1qH0bkUhEP/RsCREiBJBXDRb+hO
	R8EXWJIS5fMa+V1gK9ohU9ObffuQcNGTg8HFDnOFp573UdR3QVQI1qTbXzMJ/1/v
	MGp/1eZbVUzUnRQWvpU8FwmCpIKHYkuZ+D7NAfmgpMcY3/ZhY35HzdqdJm0aEoCl
	P8YHWfMwBWh19Mf5nxfRQyFM/ng+jCQiUR2MsWa3PD/gJMaRmBq3aqKZU/u4K5t/
	NDmsGHfHzmlbfJDUIQm+g==
X-ME-Sender: <xms:iSqwZef9TV12j6OYhRWQxQckk4QXlNc12HZcdy0qAuQLmlSu1vM6k-M>
    <xme:iSqwZYPBPHeu92krLz8oycQvt-0UHLapx8G7nxsUjpwDH_UljOA43es2zG39dKoD4
    tzWtbPKHLyI2p0N8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:iSqwZfhu3lAc3qnM7uaE2-JKKzNeAtTgp_yzvSSnXdsjI_hb3brImA>
    <xmx:iSqwZb976-ceWRUo25xJzQrRIIE1q3KVpeqDtJjylpBxuKQAxxLHnA>
    <xmx:iSqwZasOyUKWU_0-JVVU6374BW10KSBK1ua6RfV25IrKBsm5hi3UCg>
    <xmx:iSqwZQ1zvc0ryg1bA8ekd-32Dj32-ffx3B9YnBYsbhWZAxkgjoeZxg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 797C515A0092; Tue, 23 Jan 2024 16:07:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200cff64-cf53-4f91-bdf4-5afae2d2a127@app.fastmail.com>
In-Reply-To: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
Date: Tue, 23 Jan 2024 22:06:18 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "John Cai" <johncai86@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] reftable: honor core.fsync
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024, at 19:51, John Cai via GitGitGadget wrote:
> This commits adds a flush function pointer as a new member of

I guess you meant singular =E2=80=9CThis commit=E2=80=9D?

> This commits adds a flush function pointer as a new member of
> [=E2=80=A6]
> This patch does not contain tests as they will need to wait for another

Out of these two =E2=80=9CThis commit=E2=80=9D is more true for the futu=
re `git log`.

--=20
Kristoffer Haugsbakk
