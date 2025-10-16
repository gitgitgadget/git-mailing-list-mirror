Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C83BB5A
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650159; cv=none; b=nEPWbkY6lCYk3JJ1blQO8pMrfVj59Lydkt4Ap0kQ7BMCfpSAr9yyMYELVQWCys2a7vDhmccCPStkVz98D97wH+9Vbw14mGAcNFRWdzmCa4go8wBUX/CmWAuzMkBMowkgL8g3GWNBXLKHuzuhixI2snECKZ2Jv9LZsuCzYB2cHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650159; c=relaxed/simple;
	bh=WWDzjt45jIMXgHqpogmOv+89JD3faM11VqskHmX9mWs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kxL+SHz6l6Aj0AmCizjoeIrYkiGt+7hXkfxDLcDqRFbuOzDVgzvq/3KqKaSEm4XZOqpyDN8zz7W6WaKtE6tC7CWqEWu5ZRNzpXwdy5FpjAR0HlV0zWveGhcJLwcIakX75CJPy5Zx43qmwx3R3l6NaRGWmY1rSgkmtWbCrgicaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WS8nQ2xz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u97Q7v7w; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WS8nQ2xz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u97Q7v7w"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0D437A00D2;
	Thu, 16 Oct 2025 17:29:15 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 17:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760650155;
	 x=1760736555; bh=xS3yNOsgU32IbJ57H9ajho/5eFr4ECH3v7oclBw6/F4=; b=
	WS8nQ2xzJ1V8EaPetyYGyc9K0w2B94LRauLH0SqoAK29R8DnN6ffyLXi28h5FGR7
	W1VO/XXZaLDzsf5ASobU1NeM9iXzUU8V4dgY3ha+NDYK8Ol0v35Ys7L7PwfdZDUe
	CtkYf6ikKKgkqAqVjC14Q2SJ1PRMh64+4MWGzW8zV+Y63FSakVyoSd95gWzM13u3
	1I3B5M9IgCc+imAYkNlQrohC0Xj2Qg0uOZ3AYOuSlonhqp81mSCjKdsqRtpKTibm
	wZ2/XXOOd2b0Hp/sExVfOwKD8ygfHqA/0feVwLtflet8+HVbQyCg6qLKNMzVkZfq
	aiFEpfhMJaJSdNAgcQN3Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760650155; x=
	1760736555; bh=xS3yNOsgU32IbJ57H9ajho/5eFr4ECH3v7oclBw6/F4=; b=u
	97Q7v7wSiw8LwibLpORMLSpD6cI6TqX6WLtGQNj4hM3oB9TnLYW4Vf0XB/U/ydkB
	YydavnmnK2yY/zYXPgIk+IRoDqhu1K13U67on78hwr6rmPzJX7vTcRJk2tF66qub
	g7rv0CDdywLVhJZI+EqZDYzRWKQrhxDkhTuZ4aLIqRhsqCTmxEMl4LpLYr2BIfnd
	xiObK+ZPuLGuKWmQbHp7rJkeOcg77atdKkr14U2KO5SkA+QUYIPi93XB8E59TWcF
	38mURY+BIBkMMeT3b7Ch2uyqzw2cXHg/L0L5ojfbtzdcF9fij5Xb4pbgiqDuBkXk
	fDVsN9qdQvZVyIpdAxzeQ==
X-ME-Sender: <xms:q2PxaCC7i_HnRNooxoLZGwkt-dDIMPfvGoXVDivYYkWyDtJmhiL0CiQ>
    <xme:q2PxaHVArH_R4zfa-tMuOHVWJcKs-mFGssVWuvbfNV80tGWBJ6TZxPHANGeUkCkaF
    KwvZwtWZwW8QnLjptwBw_HT9ZaOOHGJh5qHfaZCmSW-G6NPGzNklg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjrghmvghsrdgsohhtthhomhhlvgihsehh
    rghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:q2PxaHcXfBDcXB-ntpZ42OB5c53a-KrFyEnyPP-jBsHlJkTLOx0l6w>
    <xmx:q2PxaE9raT6zYOuMPr8NABmF87IC7WJu5cQetg0cjRnOys2RSzUIyg>
    <xmx:q2PxaDkmgSKGPkWD9m4DLVONmFViMNlWOEvEOL64NfQvT-M_veIPuQ>
    <xmx:q2PxaG_9cW4qw2_mXCYWn5I9SsU1AYh1p0lxY3GgWrmMXT_PdTX6Sw>
    <xmx:q2PxaB-wgvXIGFMCUzd7Uqzp6eWt8k2F6spMlK9vkXLBZWpvzxg_2X8U>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4BC511EA0062; Thu, 16 Oct 2025 17:29:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AThq61FNTfON
Date: Thu, 16 Oct 2025 23:28:55 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: git@vger.kernel.org
Message-Id: <ef34b2cf-e867-44e7-8c62-682f64f2fb0a@app.fastmail.com>
In-Reply-To: <xmqqqzv21r76.fsf@gitster.g>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
 <xmqqfrbi37v6.fsf@gitster.g>
 <7205e71da08f22db757b5dc0bcf3fef27db40ea4.camel@HansenPartnership.com>
 <xmqqqzv21r76.fsf@gitster.g>
Subject: Re: [PATCH 0/3] add a message-id header to git
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 16, 2025, at 23:18, Junio C Hamano wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>
>> So this one's a bit more deliberate.  If you import email and then re-
>> send as email we can't keep the same message-id; the internet RFCs
>> require us to keep message-ids unique, so git-format-patch won't output
>> the message-id.  That necessarily also means that the poor man's rebase
>> you cite above will still run, but it would drop the message-id header.
>
> That is one more reason why I do not want it in the header, or "-m"
> to overwrite existing message-id trailer.  If I received a patch via
> a message, applied, and forwarded it out of a commit I previously
> created from a message I earlier received from elsewhere, I would
> want the recipient of my forwarded patch message to be able to link
> the message I forward with the original message, probably in the
> mailing list archive where I took the message from in the first
> place.

X-Git-Original-Message-ID:  ?

-- 
Kristoffer Haugsbakk

