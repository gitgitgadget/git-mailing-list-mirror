Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50192DF146
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299658; cv=none; b=hKEWvGD86KBUSJn3cxgQJkG2ObQ+kNx0gn0vJGGUXpeJZCRIYOZhOzCcAqcwXbIP3VjLtuOQoikBQX/+h+7aOSxjcYQFQ4sn4HG+lrjmcwcLhtFFHU5wIMigP6OOwfwkPyy80FJnHjCwN0xDLbNS/rs27tSEz9Qm1cYKpg2+FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299658; c=relaxed/simple;
	bh=Tg02NIM4qGHq4iBfIviMftaOYQSSEHxqVWBhBfFgmek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mu1Q4F4JkoTEh5uTNJaSesVmp9bJuZP2gG3yNo3gZv4kXI7tPkIwXZsluoC3KqYsfiESUFExQefumy3DadhjivxwjI5kiwGUX4xfonuVQhrjYrnZUGoRkfPGs0aNxI7Q3lQAlAwSyqukpmCYrrhGivFz1OzyJYnsE1poJB27xTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HHe3beYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQIOq4sI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HHe3beYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQIOq4sI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD1AE14002AE;
	Tue,  4 Nov 2025 18:40:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 04 Nov 2025 18:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762299655; x=1762386055; bh=awDfiZ/pBi
	8mPgn0BW2SC20QBqd/BzO8tRBMEwyxG9M=; b=HHe3beYfv4sEKoVnYepYBR6ydO
	xp3WHNVMHVD9UNmgbo5kMIgkdJbT9bCdjJ2JSQ4BStKycJSDiyRVHPmtgH9w0zpa
	mP/28yiDYajaohRwKMDYDCr7O1Z8IoK5u2/dvyyEqP5NL+IoyiYsC2CmH9tdaUry
	4wHr/ogmWE8x6dN0xHICA4Dhn45IfHAzoQjJf6qYo+Ty9o0WVl6dnu6FFIHbDjDA
	ujOYwfOPJ+/lwPBxExlB4J+srcF2VX3bemAI0NUtW8TBzwL/U/zKiD49ItTJjP7M
	Z8W4PmMVlMDs+vyHG0KPAI6NWn6FUIrnvXZheuimb2yHDrGrCT+iyTRsoiug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762299655; x=1762386055; bh=awDfiZ/pBi8mPgn0BW2SC20QBqd/BzO8tRB
	MEwyxG9M=; b=kQIOq4sIrP+rVAr546RcbfnBrWc7cVIupfR4n96dv6DAjKwuSsv
	SBQBIvNTkyJE+r9mKplvmJoETOLh49r476svXoQBdf/FDO4994eZRwkvCbeinX/C
	HW4oInW5FR86gdDKO4MDacKvjzh/NgLTk1sLp3O9FP9DPvD9xbNC0rJSzBU/E9D+
	d5bj2IM2q0YdCmSlyBkcO1hi0W/3yb3Tp+P8IdVP/1vNP5NNYvbZEV/fgkxHBUXY
	TRSIsPXm2e9UyO9toV7tbtlhKL6TnOG9UdCiAZ0v37/rYSI5iWx+5FLySZx459ur
	NXJJKUeLHvADQCJqIj/vL9cwzZmefQjHGCA==
X-ME-Sender: <xms:B48KaenSsS8Dj-robxMJmHw75CJRgRxsHY3WJhkfc0hp20AKaxHRmw>
    <xme:B48KaU4eaR3Oqte7Fn6MEP5pZkLluA5GuO0rbuvWWWUnaYa7qWlGOMFOjMa0viGm4
    eXEMke0MP5IJXw3l8a9G6kz3yVBj2Rft6riQguGWKBkl_sxqnK3>
X-ME-Received: <xmr:B48KaS25cB5i3CIRLKv_DTPEY43JHmXH87RBS1pz_QFwATO2bN-9DxAhC8zkhTdJVFl0l_1H-mez46L8nhMqoN8CIpnYRp5Txcye>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:B48KafFjwmx4ppzqTU2nW_ZQbQPb7k3rdrmiCybo8kiVeZSbL7KQvw>
    <xmx:B48KaRii-Tyqf5SVNFDxvZWuTGpBcVmQD0fQqNe4AhSpXH7oO6xypg>
    <xmx:B48KaSCSw1zBW9eiqgQWeFqxVSCAT7o_Wdy069sGT2OrEMEsDt5NNQ>
    <xmx:B48KaTRI0SzA11HGLbKqpFPaNcGZ8-jIo7vG8rdbFEOl-TSRTW5KhA>
    <xmx:B48KaXKQDaoRLMZNItm7gelIS7EFSNiNbrEqiiwYeMr4lILm6bwNHiWR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 18:40:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 14/14] ref-filter: parse objects on demand
In-Reply-To: <20251104220748.GA2638011@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Nov 2025 17:07:48 -0500")
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
	<20251023-b4-pks-ref-filter-skip-parsing-objects-v4-14-2be68ce82c9a@pks.im>
	<20251104220748.GA2638011@coredump.intra.peff.net>
Date: Tue, 04 Nov 2025 15:40:53 -0800
Message-ID: <xmqqcy5xnz7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Oct 23, 2025 at 09:16:23AM +0200, Patrick Steinhardt wrote:
>
>> -static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
>> +static int get_object(struct ref_array_item *ref, int deref,
>>  		      struct expand_data *oi, struct strbuf *err)
>>  {
>> -	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
>> -	int eaten = 1;
>> +	/* parse_object_buffer() will set eaten to 1 if free() will be needed */
>> +	int eaten = 0;
>
> This comment is surely wrong now, isn't it? It will be set to 1 if
> free() is _not_ needed:
>
>> +out:
>>  	if (!eaten)
>>  		free(oi->content);
>
> -Peff

Wow.  Is it just the comment or the updated logic is upside down,
too?

