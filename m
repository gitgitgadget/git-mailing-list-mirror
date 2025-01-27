Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE7179BF
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973171; cv=none; b=b2CqN8AW/vVCg6+DZk1aU3F2POk8vsrYdOrU6Q0flusbse+BlRKNTA5XmVNWefCNHRX25ii9q73Fgy4g2fAWvFuk/NMCog/SEweN2jkv6ILbXoPFfxeQtGVWQjTi+4BQ+EXYVfTk9d+yYlLWtJ6P7oN4N0ml5T7V7jM69Cv/WdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973171; c=relaxed/simple;
	bh=E5kXjQisbsE2oaSUo66joRpCNKds/1O+gvJAiHEOJmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl4No3qlgQjMpE7UqrC+7lUKk40L/YXj4gXygH8CJ7KVWH6s1stF2FE4XMAxkEeEupCHVBntFNEaj7D9Ykra/QZRkrfrmtDLyKgg2iHGOP3A2H7X3GCwhyVNkz51Yg6oG++bM6UWCpRRf1DBjPLwT/JWnKU/kPbVt/8kI4IhDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+OjWA9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsOYEZhj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+OjWA9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsOYEZhj"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9780B11401B0;
	Mon, 27 Jan 2025 05:19:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 05:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737973167; x=1738059567; bh=E5kXjQisbs
	E2oaSUo66joRpCNKds/1O+gvJAiHEOJmc=; b=U+OjWA9SgOhXBOUQR0CYuUc8vm
	V4HgwEhAKT9ApmoeD8xGH7cpb+8n4wRU3UFmF8UcxeM/L7beHRpK0IxOMnCmaXfX
	NqbGBH2HhQaf+KYj08S+UlK3U/AQpxFzNFukLLh2ArI8cmjqzw6nx8ipUKwCELff
	WZNWdt42VsIg7OWOZSL8qi/o4iYY4Tj3wEC6JAF8JAp/zOEafsiXR2n5P+K0vODy
	9d0RDhdupC0Vyvt0lHyMJ/K4OZGhU4u88S16Lg8A6PoLUz1GBOSXQb2Lydw7c98y
	pel3ahgeXN1FQYDtH0B/pEJD9LQubJy+/DX1GJE4ldznUZjmj6sOK7ARNCoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737973167; x=1738059567; bh=E5kXjQisbsE2oaSUo66joRpCNKds/1O+gvJ
	AiHEOJmc=; b=OsOYEZhjXoOEf9iugtwfItt/wpPer3cEMWy2GBiKst0e7Bl+jTa
	SwgZBg5hJr3YiwXMIrPGgn02fptgf5b6yoWtK7G2+JIdaDs8AAy1ryKNmsa9Qxtf
	eAfXc9R/ye01C8bB4ElL1aUARwRfpax7LhLtLczqQgJLvcNCa/+p8lx5mfX/AfzL
	DBi/Wu03/sLl6z/ddMN7ou2P8Rwlzfe433DYfLLaxm0yaufpphnhjQ0Ckf8M207N
	Oa9jqeBwgHybPFjrBy6GSlF3E/B+Q8pOw4kL9Za0+zNitAyvIgZb99hV+g0vgxIr
	+7irAqISABriEtp/PICARICk4eZXvc4OlSA==
X-ME-Sender: <xms:r12XZwAiM36wErqYpH2zTsB-cKH4oJJUNW6df3bHmkjOknXLe6uHJg>
    <xme:r12XZyiWR0wib_DxU42QAs-IBC2wMaLIpCi9jA3HJ0_3pbtGroVFs-xJ-7YWWQAhA
    -iOSfEWKUCcxFoR6Q>
X-ME-Received: <xmr:r12XZzk3o99DMt9J-RppizHPeStGy7guOMUXF75BagqYYaJZYz9YjaytsKp4KeYGJuJSUvmQ10F44BDmG9-qbaH6OseS1FwK7ytTqciikUzd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:r12XZ2wli3dzoXA35xZJCgL8D27If4yXvvW-ErPXKJ9UxB6YMWyFHg>
    <xmx:r12XZ1S7sU2UD6dRC8oeJA_8npjRoBl9qWBcHdnz-sIr5SZjmRuQNg>
    <xmx:r12XZxbXUM1vqU9egGYhHFClHGDatK0W-rgvujpcLJE1BKvn-6ty6A>
    <xmx:r12XZ-Tpjtu9qLa437SdzLrGkzHtqT3sk6gB3rpclY6nCFAKphAj7A>
    <xmx:r12XZzNRls9f03QJ0zbbjW9gZQIdXwLPxJj9LX3z7wmjQTHtf5W2V_a0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 05:19:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3efb636 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 10:19:24 +0000 (UTC)
Date: Mon, 27 Jan 2025 11:19:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v4] refs/reftable: fix uninitialized memory access of
 `max_index`
Message-ID: <Z5ddq3DE071XLzEg@pks.im>
References: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>

On Mon, Jan 27, 2025 at 10:44:08AM +0100, Patrick Steinhardt wrote:
> Karthik is out of office this week, so I'm taking over this series for
> him to ensure that it lands soonish. The only change compared to v3 is
> an adapted commit message based on my own feedback.

Ugh, sorry, forgot to set the In-reply-to header. This was meant as a
reply to [1].

Patrick

[1]: <CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>
