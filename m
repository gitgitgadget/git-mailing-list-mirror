Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01B28640B
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157214; cv=none; b=iSRrI2s8g8gI/4kyoIvXSxyNe/l+RdnbDZJ14sNseGt0UbYNQBJXklKzSfMJUyDJU7eZx+bIsMOa73dx+d2nMm8q/mgZpqTTEDjuQsxJdSkfPiPaeJPes3ooXqaw7qZ/4ocMBbzFhQiRJbBIw/sTr8hz99VjiTIrFJ2sbiwXSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157214; c=relaxed/simple;
	bh=YBmsS2qp83UVTSbjXbr8NlBiu1aEiFGFojka3KvtHFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M36avkZkKOaGoSFV46wTwpb65H8GdNHNrpBbruc8wawzqLQwAQhM5d2RRVx1ADQsrp3VofVR7OLIfieRcO1OSC9MAWCYmI4zadTJf2EwX6x0iMHr20rvB2yLCX2CFC7JmI1UNtR+dys7K1AHGfcgQrSvusagwwwS2c6itW0HZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FYD3m6/Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHjLhCbh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FYD3m6/Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHjLhCbh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 294471400216;
	Tue, 10 Mar 2026 11:40:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773157212; x=1773243612; bh=YBmsS2qp83
	UVTSbjXbr8NlBiu1aEiFGFojka3KvtHFE=; b=FYD3m6/QgNJUU33GUCJ9YSrDbj
	bJSMhom3HFJ2PzMFEB3WgYZWVp6wS2nW762MH4VkVy2H2LCifuT17/NZT7w3u0JA
	2/KCIx4Pb7f3+khiJ/iazaAdONa8toolHEtM8TgBukJ8f2c00PWkVO4YX3xxWbCt
	jt/eyOBvLwxlrFpQqvY6FaxAvy/+KMsoJLq5kuFIKYyc7guaOBTUlOw4h/9lpPNB
	hMeLfZg+tck496qEva8SNNFH+zhGqcwaxemOwpAwBNIhT4NZ98Lr4GV3w1TneNIY
	Q5qKd8UXo3pQDD+AckwE9Cc8uIhBIPhLwHFe7sv7Qi8dfioz2iAO6wPYrtdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773157212; x=1773243612; bh=YBmsS2qp83UVTSbjXbr8NlBiu1aEiFGFojk
	a3KvtHFE=; b=QHjLhCbh6cjGRg5qwDHCihHLjnSrtiX/4xRbvBcvpErETZuoJKi
	jHWdOI+5bXxarrilZ+c/LVF5fNNGBt88qp+R/Y54EgAzvv/YWeVc6YRnocuOPCVW
	aw7FE/XMdCydKO2ifB/tdolk8ZBgso3JMG6Hq8np4AUagq7CjpP+y7G+6Ma7wWq2
	OgKE4jSWrDHe9kfNdmaQmRvQsZGCU7Gi3jA97DeTbZBIAjkg0VhXkSrZiv41ZP6j
	OOvAP3TrD848kBJwQYnO90LowqhFWCvcR6YjNv9uuFKI++OBHevavIxLtCQ5WpHL
	2phBwJ+dQanp6073UjbMuATnBPxIdbtLj+g==
X-ME-Sender: <xms:XDuwaeQwX4IdDPiQMEBlzz0uacyxLYaIXTBQ6NwVMX-YGmbxsCJqvw>
    <xme:XDuwaaqP0e1O8T6CUwe3OG2LefVrb12MjWoMHut5wRC61_Tbkuja9r7nfF_K_PC44
    K3LGobwkR59J263AaIN4FKBQ2j_84mYPzV0o7kMeB_C4v53M8FVEA>
X-ME-Received: <xmr:XDuwaUJ6FwkhGp3aPpv206rxY03D6PRofEhqTIXeBWiCxe7vE47mTVFdR9H5qEF_KwOB8b7f3GBHfJQzAYMeUO_8I6vCnyg9Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XDuwaVqET22awOh1yAlS0Vr6-10HXEB-vc7qFF4oeKjsF0hkLt4ZBQ>
    <xmx:XDuwaUzz0T-UdKRZavnsQxDFYa6_bhxJrZ79phbkkPuxCvDCeYdQfg>
    <xmx:XDuwaRM5BwOmQVTdDQoao0BMrDD-lY1YWEDLtqqvmnyMX2Ez5peXbg>
    <xmx:XDuwaR6nFzUkBr4RIUhIYoI2TlaD5tV3ltljRA93-ARxm3LmJ6P9qg>
    <xmx:XDuwaQ4bw2SApGTHqFQGTPOiYLuPbw2wiTIgIL0LB6INvMU14wxkW08P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 11:40:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Arsh Srivastava via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
In-Reply-To: <CAOAgETNoQuju_RWbe=jo8JF7J2+V_pVoyr6FeKw8LwYKi_HipA@mail.gmail.com>
	(Arsh Srivastava's message of "Tue, 10 Mar 2026 19:10:20 +0530")
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
	<5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com>
	<xmqqzf4fx0vo.fsf@gitster.g>
	<CAOAgETNoQuju_RWbe=jo8JF7J2+V_pVoyr6FeKw8LwYKi_HipA@mail.gmail.com>
Date: Tue, 10 Mar 2026 08:40:10 -0700
Message-ID: <xmqqv7f3wv51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> As per the recommendation of Phillip Wood <phillip.wood123@gmail.com>
> I have changed my files and added git checkout -m after understanding
> its significance :)

It is a given that you as the author of the patch understand it.
What I meant was that the users who get the recommendation need to
be told about the potential issues.
