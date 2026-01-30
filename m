Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0035770D
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792832; cv=none; b=Z7kBRBXgB+BR3QVjDrC1sOPFbtlVU9OCOKYGoj5HuNm9fO6etCgUvlajG4XmTKvYfoXPjNLkiisZVHU7D2PeD07lYmRddxQzn0Z1ukxPeu8Jkn6+Nslwa/+CL+J5/Os5MXJZfJLB+6Xh+Nd0ExUMgRFkP8JSIfZInjjN5LFig1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792832; c=relaxed/simple;
	bh=F5pS9hFVVFlASxFxcTZfec5jK6g98TNIk7WnpMVxbEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oq1kX9Bz2v2tV1sZhEFZgWcEA28YNcTVDP4y5/4gUhrQOXVGWynQZsGKAoKjYyGAgLifyCloL56xMStM82Ac5LBmhTV6SnzZocgiYdkKVBzxr/7dKevXGMYl8+hulb2uWxoxic+N3SiiDSKwlsC6/epma03VHNFmT50XzojU9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iay0hsrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XLNZUtOH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iay0hsrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLNZUtOH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15AB57A009F;
	Fri, 30 Jan 2026 12:07:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 12:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769792829; x=1769879229; bh=rUX+hdk63a
	tcbgmPjgAoFUX2O40S/S5PFfef0GojOIM=; b=Iay0hsrUg2MTfPgyHRUboa/DV3
	RAynBsOrJK4Ed8IL3QgGlzyKLv8DHtVK5HCrtHDYtnDY0Rcgfvr5l4yC3CUJzE0G
	XUtFODDBl/lwDWRW4C8Ze5bAxo5KMXiVLkSzQ0VerZfQOqVDLNWR2wd6Ipk/Q97l
	7RiBdhopV5GAns0t8emlq79izzva/FmqO+7orOP3jGv5I8CfUitoeEr/gCcTzQas
	z072KKmN7jRoVRrd6SdZgC2lkJS1npHzV9lUR5RER5nlp47lJSpUUrvJkvn7PRqm
	Y+0Zm+r07LvQNu6BkndWdz8Jl/lKL/Enxy0173FXawGwe4LXSXeVL+Df87JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769792829; x=1769879229; bh=rUX+hdk63atcbgmPjgAoFUX2O40S/S5PFfe
	f0GojOIM=; b=XLNZUtOH6w42hYjvg46Tx+lng/3bMnYmlodIFqI1Y3jE+Xr3TVQ
	OwgdGNQIsDW6/EYkQY0bDYdQD2PiUDnOG8v+M+TI1UW30iLE3JiMNu/H7Ra6gN3f
	cEY5xXGI5T3vfzOJCBgOBYLSWlRu/zS8iSMVGLtIJZBKABIUJ9vNIV4FxJRJz6Xp
	eI6zjtxcEw8cESAdmU59QQDZcRVL9gZAFK/tZRyS4FfgicbwFwgQiv4JzqOLRwEg
	9I3w+BolVruzVLymWSHWWFzldGnzIKrw+MBRbb4PtaS2JTUIZIhL7+HAvOJV7khK
	SnYzuWBeN8035b5NV6OgCFu1W2EUjYwfyhA==
X-ME-Sender: <xms:PeV8acEIYWtBGAqQ6L3deuNHgcxk7Mga5-PxfhvRTCbqgsdIoreBoA>
    <xme:PeV8acMGR3HFAb-QM7wdLXTtEkWr-itN_IWhZUghP1NRSWcD7vMhdNy60TlkU5uMk
    bNSRTf0_3s-Dt5R11vcxORpMA8Pq7QLlaBzQQ3xmanwmezmJHoDug>
X-ME-Received: <xmr:PeV8aeelJwSWE-_oGWkmtz9-uh2jriH4htB2eF66aqMfcKmRmPuxleHbcbOr3KXEElVtupLTRJtAMqezhWHjEzK0mz-09QBLMpNle1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PeV8aZtXhCy7_I6xTtoetspw72zCCq21dUm-68s5LqghBCG43LTgcA>
    <xmx:PeV8aflLCD00W1lZVJ9tVJGJKdEehX9-bvgkWW-_2rGQ-rQNKYz64Q>
    <xmx:PeV8abxoUmwKfLaUf9_dFqXSIc3BYGY7K8LVwweglCgd7rh04I4PXw>
    <xmx:PeV8aRPIuBS_G9sx1EAJcGg0gJUw8qRIP8CIp6WL-ta__wxrsh5HqQ>
    <xmx:PeV8aRfs90tKNa8HaH1VWGZpbD2S-N-1HFIxG38kn7ivjHXX7pasYZIs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:07:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH V2 0/2] show-index: add warning and wrap error messages
 with gettext
In-Reply-To: <20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Fri, 30 Jan 2026 21:01:22 +0530")
References: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260130153603.290196-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 30 Jan 2026 09:07:08 -0800
Message-ID: <xmqqikcj6ncz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Changes in V2:
>  - Split the original patch into two separate patches for better
>     clarity and distinction.
>  - Improved line wrapping to around ~70 columns.

Queued.  Thanks.
