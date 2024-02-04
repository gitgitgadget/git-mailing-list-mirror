Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C71B5B3
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042400; cv=none; b=ZGbRntEWClzJ6MOx3VJsFXRRXFo/dWIdlMzcdQ4wJUtA+bOTlxQDnqbkEohMmXLZ2+2sKaVvgXbj2M+XeGui0DRR7p0etZzGBLSHE6VesCQWiAJlFhwzpq9ETxqEDk3ohZBR3iThS7Pm/0xgE1lsBbTb3oEfcQLQOkBpWafVGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042400; c=relaxed/simple;
	bh=QuI0V6aWZ6ObqNfP9ZAiv9G+b9U9xgy7DQkug4lDSDM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Dx2fewLi4vurTnBeDr/A82H1+8iCAoeliVro+3v7Rz4Hs6aQHaT67e3Sl8uj8aXEdy57HnjUKtWIIIw+W5hqui1q5Ul2V16KZfsEIT5qT8C9q9n0/Qxb1h2gW2gRL4Z1aPQGpNjBP1OiVYlor5VHmhahU8GSwC6FZdFMwt0krnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=aL+2VUI1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HU3UWnz4; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="aL+2VUI1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HU3UWnz4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 483F65C009D;
	Sun,  4 Feb 2024 05:26:36 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 04 Feb 2024 05:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707042396; x=
	1707128796; bh=WwM5y8xzGg6FtbENtaqh6dyroRYHNHZXHEAMcSC2Fb8=; b=a
	L+2VUI13SbQeMWSIfsVIcKseyhLrZB9q3NOSH5VFT311e5W9T1xg9kY+7lmjfkeU
	nERC1izvyvYV/Zmv2euAa4MMry4/25sMfKO2RHCBY421JXY+JNafFG/GAblqP9yM
	sJnuwTgctRDKRR62yYFCStM6AFsy0A0yMXN7Ynj1SSPAGdH/xa+VqchqyHFTGUfb
	0xR42hNSPHaFgtkz9w0LrEOBFQAjlZPNR0xby8N0zX0cDViwqDzKySCkStYIAjwq
	bElF38sB+vh9Fx3Y+iRUwVZH0QwIWY163fN/OSWIzc2GUIw9L/GP0sp3LVgcHPS/
	ipyB4PHLhCbGAukyqKYrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707042396; x=1707128796; bh=WwM5y8xzGg6FtbENtaqh6dyroRYH
	NHZXHEAMcSC2Fb8=; b=HU3UWnz4RH7SypuvnvaJqg+VOZzHcLMM7famUPn5tSVp
	f3pqB3l/2s6Ys745gAsXTxtwe+/yVyUTtGByQAUib4O3SPU421xrsQljvfps5xJu
	0JCgtdoQXmNohA5YZ2p8CNiDigBkS6KUKEWHg8IJNuUFtA+zD3nkJmLmF1I59MDE
	DAuOZD1OKxcmq1/iIVKcq8YV1NxYZ4cV1YX3Wc5n6QpwpJNJ1Fl3lqDxTtdADxHP
	BQOBw4E6JE3cu6Q0VzeKZ8PPbkGg/VU62xprBMUoZq/weZzUfR5pLrvMPBVQ10kn
	BWci5TEam3G5X0zebEYmWVnD5gM9Cl6toOUttloKAA==
X-ME-Sender: <xms:XGa_ZQYa1bqr0c8_aW3oKmgWdPRwxZ_cfxjxqZ_i5XYmA8K_TrXFCRo>
    <xme:XGa_ZbaUm3v7RnsEGJHQIfwfClTY-HT_V3qiHiQy8pH1kkQm3EwZV-hCzoTpPFf1i
    fQtq9iyfNveYE1mZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtieekjeffhfduledtteeludeludeuudegjeevvdefveetjeeujedtjeevteetvdenucff
    ohhmrghinhepghhoohhglhgvrdgtohhmpdhgihhthhhusgdrtghomhdpghhithdqshgtmh
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XGa_Za8tAkwwbiaaPyyFDz2danG5j2PFydXMeGtZvlPYHj6g5EmllQ>
    <xmx:XGa_ZaoZMHamBUdjQA5wFMrXJqTO4fm5RgKxElqyvgnbSWLEHlVjZQ>
    <xmx:XGa_ZbpthdosFbESQP4Dy_QLM-ufRyeX_Y0trO0MujySPiQ3h0irYA>
    <xmx:XGa_ZaSxP5pYCGRLnhZeiSGcwz0uGXGN3cD3AG4B9GiCzc09xkvR2A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 091A815A0092; Sun,  4 Feb 2024 05:26:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85658207-675d-4855-99fa-1c7bec18662a@app.fastmail.com>
In-Reply-To: <20240204084344.jzu2ciulbrdmxz4u@carbon>
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
 <20240204084344.jzu2ciulbrdmxz4u@carbon>
Date: Sun, 04 Feb 2024 11:26:15 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Konstantin Khomoutov" <kostix@bswap.ru>
Cc: git@vger.kernel.org
Subject: Re: git-users: email list has become spam-drowned
Content-Type: text/plain

On Sun, Feb 4, 2024, at 09:43, Konstantin Khomoutov wrote:
> On Sat, Feb 03, 2024 at 04:02:49PM +0100, Kristoffer Haugsbakk wrote:
>
>> I know that this list has got nothing to do with git-scm (per se). But I
>> was recommended by Dscho to raise the issue here.[1]
>> 
>> Maybe someone who happens to be affiliated with git-users happens to
>> read this.
>
> OK, I've posted to the Google Groups help center [2].
> I do not expect this to produce any useful outcome but at least I've tried.
> Please feel free to chime in on the issue to that thread.
>
>  2. https://support.google.com/groups/thread/256971101

Thanks!

https://github.com/git/git-scm.com/pull/1829

-- 
Kristoffer Haugsbakk
