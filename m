Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC15202997
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526242; cv=none; b=TLZrsxNNlu59RmjfpkvMBT7eHGb2p/cYgtDlaMMKrXkmlpBuTH3HXlpcSXHU2k3qporFyDt7WaudU/VAI1QD42xiu7lJt0uRChkyrZT9Vooh8JioEcYflZz6WZDBHg+rp5vxfLXNoG4gbst3BOSDiXWYGMTFNkqnXBvFIfawNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526242; c=relaxed/simple;
	bh=J/3huCugAX0+IV7ETJNa+h5e2ayInlnHwTRe0iS7V7g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dtqFUARiWpsVib9J8awSweZ5xgnRm06uX+iu9LMTMhkFpHaJmuIq+/oBNl+eryOFsCx4MMreocdbUrQWHyFjxQp3yRiSfX9ngHU9nKLnRSXadG5WWZs+VwWKhi/ZTC56+Nl+xFEKTnyM5t4Vj4rax4i2cP6E4BlC1S+zlCgsuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ULGQqzn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BF69USMj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ULGQqzn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BF69USMj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AB8FEC00A6;
	Mon, 22 Sep 2025 03:30:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 22 Sep 2025 03:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758526239;
	 x=1758612639; bh=zfo/7+Pxox/XdZk395gwNN1w9erIHk3IbtLTkwt1xY8=; b=
	ULGQqzn2O39rHPlal9kXimPsWkvKvoAc4FbnnRXoC8Gwc7DbBdkkRX7tSRDscWYR
	qNOYHyFcghCaaAOMl69fz9jp7aTIHGi+AMgiHlfu2EJO7S1L4GkeY/7DguT38rGn
	r5B/pfB8Ex7U6lF7etgTUdHIIInbL8aoWAE++gGzS80XU0n2qcoQ4hruvH5feG/Q
	Srq0h4UDAiyST6AnsXWkk/2Qu7rOo4W3Zm8AhVp4kX9NLcT2agub6mDA8GeGMbPi
	rrPj3TYJviIm+j+PvK0FhAuLoQ7UIVmc4kPjdSMcPH+XXOVBaIxkaCEf8FJshM7y
	rxpO8mtCfhio8strrwCrWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758526239; x=
	1758612639; bh=zfo/7+Pxox/XdZk395gwNN1w9erIHk3IbtLTkwt1xY8=; b=B
	F69USMjMlBalat7jL35ON7bWZt/4RpMk8Scj1DQt9IhZxZZGax7JKqSwx0a/3e6g
	9wT+5EzpvRlmWDRaCXP9iGPDy3OXRib7JBTuKFZTHPlFNo5MecIuaf6e4UzPs2em
	8aL/itnLFEHuUp+OKG9eS4mnx/ACsgIvIumtxgzm2uRBVxJLWSGptCKup7WZ8Mfx
	zpCc1Iu+kYdD+49hM2k14a5dLqzXrI8iudpF0PBmzNc/EnSBhh8aPvJtd6dnDeG0
	4xZXyKVvsyjAa1pOmP6+65Qeg+9QnPs/noyU6MqFTFUBWspb/YsgYExYjCpEqVlE
	/iMYaW03E+umZKsh88y7Q==
X-ME-Sender: <xms:H_vQaKqLRGJxagOdFHJ2FttJHiM-V8POKBxn234BGgfFkGPIh05mkoI>
    <xme:H_vQaIpPWOFKfFFQm11ndYpDo6ApVFmS-G00wAIQeSI87VKaJVvqpMnHRv5ZyTtsz
    NE1rMIE4vq4E8NU9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvrdighiiipdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H_vQaGsv9DAsL4QUqL4EvrDLavE9CJFNNNN7YhW3oSJweI-HzcS92g>
    <xmx:H_vQaEbQ_KSh6rHkBLWmPbQQ7dkm_7g1rMzDCfgMylQDo8L9d_cfqA>
    <xmx:H_vQaDt947Qv_KimYzsAwnWQ96Y07MLGROEEw30-efX81Cw6_LpURA>
    <xmx:H_vQaOEGWN9vrTqoFYfMtdO0Mhqde3C0PrPpTlSXo6XLS7AQX01VUA>
    <xmx:H_vQaGSbp5us0AOz78IWYQYLEKVRwNProqsUqeQR5EUikcxZsfqJVtk8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D4721EA0070; Mon, 22 Sep 2025 03:30:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_YGYY6EOHPJ
Date: Mon, 22 Sep 2025 09:30:16 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "James Puleo" <james@jame.xyz>
Cc: git@vger.kernel.org
Message-Id: <eb6dc2fa-d45c-4efd-9af2-93bcb72b06d7@app.fastmail.com>
In-Reply-To: <20250922000127.al45qxhhq4w3o27f@jame.xyz>
References: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
 <de3d58bd-5600-4bf3-812b-c329c4940afc@app.fastmail.com>
 <20250922000127.al45qxhhq4w3o27f@jame.xyz>
Subject: Re: git whatchanged: fatal: refusing to run without --i-still-use-this
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 22, 2025, at 02:01, James wrote:
> Thank you for the (indeed correct) options. They are exactly what I am
> looking for.

Glad this could be resolved.

-- 
Kristoffer
