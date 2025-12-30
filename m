Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6A32B992
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114228; cv=none; b=Qhr5RaXWeIztsyLkENFddi3NWUq72df9LV/tlQSSaFsmbWaFJAJswWC2Yvtj5rURTk5gWdpAVwMW/Sc4BTz4g8HrJjO+HsgxKBP16k0vHTV3NjDGEYVLBqEJzpA/3XB8+uDMRSQLVKyk20aHCdg6LAWtrIK2RVVnkdXIrAyqj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114228; c=relaxed/simple;
	bh=I4dKpT5J6UrJl4pnpi7LFpjgo/+9JS1hEtMUA8lOmJ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MJ1W0YGQVMyin2KDeiAuy2ZDUyOMbnKLDzLAoLStIZljMLm0Q6kKVsCjrUDtw2Bp6YNZ1KF+HEjjzYxqQSqBUhyssUy/s8K2OFCUBHbbUXdDOruXKLPblIbUmGqkI1jYwrEGWFrwzBGj2xxAJc6eQHZpT0rL6W5L2nDHA5DwXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PcCe2VSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kRLkuFvx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PcCe2VSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kRLkuFvx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48CEB7A0096;
	Tue, 30 Dec 2025 12:03:45 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 12:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767114225;
	 x=1767200625; bh=I4dKpT5J6UrJl4pnpi7LFpjgo/+9JS1hEtMUA8lOmJ0=; b=
	PcCe2VSz+vHrOlbcXn6+IqJN4YeRLPCYAH4uncF2EcGqzOlz5Y7jdNFWlNKJdXJn
	v05JSSUJmynSOSLZYRdZ3QJKwUbCB/9M9eesADctUsEgJwjK5Swl196GJV+qDksa
	vrxsrKS7btuVFpmVGxWQqJ7oMknyp6DSAcq/Xd86EOZUNPs6OluRj6Q4bZ/F28Vk
	SdQBoanREr90WpkIB+KfhZ4hC2CsMOsZXTFHt/6+N4WgR2WsaQGlICCe+RFW8CA+
	wUIwiLWeBKMASB0Uun87dWPoSobHam+KYKh/b6RBacqI/eAb97D2p5moa4td0B2M
	lYnNIX7I3GA0DeSHj6eV/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767114225; x=
	1767200625; bh=I4dKpT5J6UrJl4pnpi7LFpjgo/+9JS1hEtMUA8lOmJ0=; b=k
	RLkuFvxrMWDLMnfkdyNQ/DqltPjeJUJlDLYPc02yLT6Sp/p4HWuKSUsMzDjF05bh
	GfE8NwPOGGlm8Rl+WSZjNfU/v/jqobQWOPW//KQ8ICxK1enDDpIneEbxeEoi1CaG
	XRCb1lqf3g6FLi6WrYVFIhQXK2utHyaB05VIjClv8c4W6E/Bfpcm8/c4xZQsD0Qh
	pEGRIpeCINHD9mjinwPIaFI540Ovzj/mYjE5EnQIVP8odqQyOCHLelb+Q8wlvGT4
	IFjPbEiPIBnaxVtDXhyvj9Fi5izZHYkzx19kxd8gvQTZBFu9O5OQ4LTKfSbL7t+x
	pA3XXwFi2D2xc6zbxPGFA==
X-ME-Sender: <xms:8AVUaTzMaonl69cpqSKs7vYoe3sj3h3wMrwV8ng1952m8SLehNySHWg>
    <xme:8AVUaWGx1aBNGwJUP3ZUyRFMwNE3w7gPprXE9wbuqI_cN_N3EEgqJTN2UxdU4cU-v
    cInmtEAx1rxhsnpg8cl8aG-cGJIn6g0fvty9b2edLpb1DuyiJrtyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:8AVUaSaE2h1Q9kmrEyO7thV8wUWfiGSDhvtiqGvWtSSoI76Dr5HZMw>
    <xmx:8AVUaTN27KhHwC3XIHdWqmA0PbD86PuEz53wkA3NHj_hR22xn87nzw>
    <xmx:8AVUaXZbJT2Vn2RbANwcBb3DgshG0dbInn2XdKluYWVAVvdESMrJHw>
    <xmx:8AVUaR1DcoyGoMdfL1Irn4Z0vECNWbkjnOz7MdglbLBL5PNkUPuXUw>
    <xmx:8QVUaTz1090LcBn2JR6EAskcYt-VBVCR4-WOabCmKTqZORdiinf4Lr3t>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1CEB1EA0066; Tue, 30 Dec 2025 12:03:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVNSA-3X7Wfc
Date: Tue, 30 Dec 2025 18:03:24 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Plattner" <aplattner@nvidia.com>
Message-Id: <62dfd1ff-cc19-43bb-a622-af480fd72d2b@app.fastmail.com>
In-Reply-To: 
 <20251218-b4-pks-odb-read-object-info-improvements-v2-4-62e3e49072bc@pks.im>
References: 
 <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v2-4-62e3e49072bc@pks.im>
Subject: Re: [PATCH v2 4/7] packfile: always populate pack-specific info when reading
 object info
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 18, 2025, at 11:54, Patrick Steinhardt wrote:
> When reading object information via `packed_object_info()` we may not
> populate the object info's packfile-specific fields. This leads to
> inconsistent object info depending on whether the info was populated via
> `packfile_store_read_object_info()` or `packed_object_info()`.
>
> Fix this inconsistecny so that we can always assume the pack info to be

s/inconsistecny/inconsistency/

> populated when reading object info from a pack.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>[snip]
