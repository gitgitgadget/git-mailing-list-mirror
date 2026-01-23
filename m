Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729B1FE46D
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185101; cv=none; b=SGL0MlunBdmTMGGmlmqdoNSzQmO/KM+Y/SjSVr6tLiZB0LZHeSRzDNUVcghPVaMxkvRbg6EOfaDNvPxrlESMkeB45FSkEGk1SUPnE1gjKqo/EVmZW36ezWPKbxQGI/v9ABqfURjTLrqs/5kuCD8AvEuYduGm6E2k7kS8phUkpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185101; c=relaxed/simple;
	bh=MGEknXFPnCDafldnDXYd6yuMlJx64GcP8iRO7ZkdyZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJMxMwzyYs+EoP0NlCugP8LExFuTVAhhD6qNuY4wTnAcC5HlbOo0PLLDpmwovn+MgA4NsGKNv+5bk/oNTJrOe2VBSmOD0ir/MgT3yB65mIJ1YolG0q86P3b5KPYd+41rWoN6fgOfF7qBEMjSAL/ZdM4lCWoCYRkWVu1Llk5ejkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fwsLbk1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zFTMIJMN; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fwsLbk1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zFTMIJMN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E33427A0096;
	Fri, 23 Jan 2026 11:18:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 23 Jan 2026 11:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769185098; x=1769271498; bh=uuMP7rPoSB
	71uylZ9c9gFeYZ27leXSp8lvUJ+BHuDYM=; b=fwsLbk1uOWYbfIvI1sEdlQcviJ
	GDnO6KFubfpedkzSBRLEm9pDQJex/wl050mtIR2u75gILwLq+H3jAJGqUgqohdV0
	U0QreVoidCs/2xBtJFAS4VVECSHtcgeuJ0tlXSpNW3Pj7+o0aSXKsQ3n4o2qYqsA
	DhVGVc4Y48AKDijsih+4ZZNlDl/eZBWpftZf7lT7wCvX51lcLg+ZhUk9EB05bXcN
	7/6WunxWGArEPn1lmnSSMpNUw+OHm9gRQXS5mwd2WvtirJ8Jaq5pSl8HHYKYuVjA
	oYmnNBcXMeSZufbAM16wklGFXi0QAa9xYgCEONb2o84JPDCv2RuUW8fLPAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769185098; x=1769271498; bh=uuMP7rPoSB71uylZ9c9gFeYZ27leXSp8lvU
	J+BHuDYM=; b=zFTMIJMNlQO0fAzmNnKMcUndeb2dJ3VK+xTjB5Ojm0on6eAymg1
	s8e5gLSSNhkXLL5W5zpY7vfTg1JqHqqIP5XJBlYr0k60RZ5d9PmrznnQlgIUqEMy
	Zo6mZ0Xl9eLdc3+6lDtUZeti+Fpd/Ik7WYLnsK0yc8dXX0N4XowUhGCX17tlEioD
	GmBlPUMhCzt7uetUT9xV0LYjOhivQf2O1IwnWWIYTgP11aGw2BK4Zb+ZspT2J0iD
	mHrpS6iaAy1zr4VZibXinE52aa3p051IPwejjchDTaWa/V2Pw/Dqlb3NB0ecKnpP
	AiIcd99748nU3gQzn2FwmBiGdjreCh4QvDA==
X-ME-Sender: <xms:Sp9zacFPt5gs_3OKMXq3LIngVB0AOORT5NSuy7bWpj4FblJ27-1RPg>
    <xme:Sp9zacUbz_6tCCR150fjKudaBZFRhFt54xMXtVVm2Cbr4idfBkyqSxZmmB15wkBBt
    cw2CwNwRic7z6kUJNGnIJO_ervER5JrTEezWUq5cowuSGale2BlLA>
X-ME-Received: <xmr:Sp9zabLep25Zxb8ECUX37nEBjYRvjpWxk97oU0qUsf3kn6QyoeL9VphDjslV_o_enwUpXodHXDuktZGsKgxu7Y2FHKPg8QH9M4tQwVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Sp9zac_LxXDLlYsBwZS3oMrgN_3_hhD1b6uNjt32XeL_7_zi3Pt5lA>
    <xmx:Sp9zaeL2aMvH4EoF6AiGK_l9lJbhmcc9gkP651nXtrC5q9ZSQ9l_uA>
    <xmx:Sp9zaRl4bsxTgduXeK1OPVRUNa0nPcY1rqIVkpHweg7A1jiWZkCPuA>
    <xmx:Sp9zaSOs5jfEHTzKLIm_6oPbmYuyrepYZDd87h-RTOUlNAwFmnY5aA>
    <xmx:Sp9zabHMDe0EXLC9xbOVAI1a-gXG3-vHhvAo6zPEXQTYAWg2yPNkYK49>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 11:18:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: "peff@peff.net" <peff@peff.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] reset: avoid reflog update on no-op reset
In-Reply-To: <SL2P216MB1885C5C9B75A38AE99E5511DA294A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
	(Pushkar Singh's message of "Fri, 23 Jan 2026 08:54:15 +0000")
References: <SL2P216MB1885C5C9B75A38AE99E5511DA294A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
Date: Fri, 23 Jan 2026 08:18:17 -0800
Message-ID: <xmqq7bt8joae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> ... or to rework it in a way that preserves the reflog
> entry while addressing the underlying concern (if there is one).

I am OK as long as this patch does not come back in its current form
;-), but it is curious what "the underlying concern" is.  It sounds
like you see some problems that need to be addressed if the current
"the act of resetting to the same commit is recorded in the reflog",
but I am not sure what they are.

Thanks.
