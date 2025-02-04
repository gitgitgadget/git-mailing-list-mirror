Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6513C3F2
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680508; cv=none; b=VOx2fXUWUplZqsx1LylPgPh+g6ni59Zeb6SuDDa0P4Te3eTOfxwn0byCR/cEkR+uPSln5nCmm/rY54oa9OQ4JBLHNuvNg9+FcXmlvJ1UfaubPSvUt2U2U6efdfeKOldVtOJgWRUufwEfVrDmhsaZZF1L+pewYwTYnz4GGY2iels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680508; c=relaxed/simple;
	bh=u8BHa32rvpBgAOUOTVmdceQKZL+qPe/renW7OK2AyBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNGmWo82ZNh3Syma0AACaCogoGTnT41cg6CmVCPwNG7fFDglo6Qvbpt1j/s7Ji8wG6EQ/eurbDBoc+Rov4GOuLcEg7hoPLkLMmO3ohQKp9SZlrtP/OF1dAnh6GeBvygd/8q5NcO/O34Z7IBkM3zoQgID0ZKxqX/V8QIIdPNfBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hT34dGKo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rd7L5ugO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hT34dGKo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rd7L5ugO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69C99114019C;
	Tue,  4 Feb 2025 09:48:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 09:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738680505; x=1738766905; bh=u8BHa32rvp
	BgAOUOTVmdceQKZL+qPe/renW7OK2AyBs=; b=hT34dGKo/KRYyDqD0ctRmdFIOD
	uPlbgvdMt4oPuaOZQEX7v2axwYLzl53IJ/eiF8+y9j7Og9rTqfMtDIWjTQuhEgsP
	Qe2pl7lZT6qJuyeS5XQupgvRMdUcIVF4Sn2RtfPWc8B3w14uDdl/4LMV5t6qs1yN
	wCde263u/tgdglGiSHcLrwphZXm2wNC7NZ2u8GyMi7F0817dX+mOE7YmFD81Hc8x
	2YyY8RICHZhqs52Rh6TRMATAY88CQYFVKwZGL21KxO4cCSsLZOdrTKHHeqi1bvCM
	XBp0zY3N1tUR5WdJiqcFTSlRsSXrEA3vuoAIUlZ038j5ZAWp70Gp9rOy+ltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738680505; x=1738766905; bh=u8BHa32rvpBgAOUOTVmdceQKZL+qPe/renW
	7OK2AyBs=; b=rd7L5ugOM7NiMZSCRDc0dIZreVoEMaMU813SVgnNGlbrd16FSjC
	mCIKlwr5QrMzlCwJvueSv5WHACsIH7gvvlDDM2tPbsXWfafoHntJGHRR/J8XQ5/V
	z9+fkg3Lj6BYqjMb/UyF6InFMNyHgJftuvSHFCNZjLLEoSTMvdyg9aGORoaE+2yg
	cvs14bsNpDVDK36H9cCl3C0f13g6095wdxbIjoTV9MpyFU91T2fSjlukHU7KoPXw
	9zGbplE2PdyuqZ2MH+cw1/4FaANm3oASViOn0+eDub5PMmqpkcZYfIh2A1AlERQh
	WJ6YptuJoilEbs5ix1FPbQMgidj4ds/AWDA==
X-ME-Sender: <xms:uSiiZ-Nw4odFLmDxg0McD2JwPkwt0-Q8SXSEgpuiD8BQng4M_X_Liw>
    <xme:uSiiZ88eEIBtV2YlLuoG-6QWJ55IDJjF4wS8etpXKgx9fNWgV751G9q0NGjL7ghfN
    8GoEWTEw8K4iOXX7w>
X-ME-Received: <xmr:uSiiZ1Rwv-KnF7TIMqDIvCqEbrLx2GNIVeKIxr4155xD3lmH2FGCKLQyyetoX01EQqmgUrwJ4AewjTBd8oBIXTjmkOsaT3t5GlA1rm9Cn3zOeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uSiiZ-u3wTR9x-UvDivqL_JMXhpYLvj515Ho9MUfHlEfwNPZF-m0wQ>
    <xmx:uSiiZ2c1oBT39VKSBcVlzUL3vL6iFKF4YIqVm3raJuGBYg5Mom8VZQ>
    <xmx:uSiiZy3jC8aeCq01qXOdA3J4Q1S4gwynw3lB_V9vi9yr5KVLVvTt0w>
    <xmx:uSiiZ6-5Q-ef58hcg6Dq5MuXs5ToQrqBASVzQI1ydTcMzwBtEVIKYA>
    <xmx:uSiiZ26hypdutt-68TdprY1rChF5dhs3eVSC4BfoH3UsPziRFGn-RZCn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 09:48:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e53fbfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 14:48:23 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:48:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC][PATCH v2] remote: relocate valid_remote_name
Message-ID: <Z6IotsaWyFo_4szp@pks.im>
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
 <20250204142852.13035-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204142852.13035-1-meetsoni3017@gmail.com>

On Tue, Feb 04, 2025 at 07:58:52PM +0530, Meet Soni wrote:
> Move the `valid_remote_name()` function from the refspec subsystem to
> the remote subsystem to better align with the separation of concerns.

Thanks, this version looks good to me!

Patrick
