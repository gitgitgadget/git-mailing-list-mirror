Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45D2C181
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865671; cv=none; b=QdbWBFDTQz/46EIKgH6DBm9XTPsI7q3RWwK7teHkdb5FpRz7fp3bxrWgcY1UlZTWBkR4vrKvImeYlQFgXfK4qVgUXudUaLYxp/abe0Ea3duDPBKjbCSsrtT5b9FPbBxbKHdEd7g2IbSiGfwsG3ZjGJ1GQqQn6m8uIkhD5/ygm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865671; c=relaxed/simple;
	bh=lGMI1ac/KChcPx0rlGpw9IJLm7IAl/ebMLFORsncbyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFsybk1OcGvHiQibAQ0a4TQMeU0mCu89XEJa2arX/fah5gxxVoRg4f90BVoVw4v/2eCvjsvb0XvWowlE1JbqBSgNlcbu+Am3Os4IxbeiYuWMN84C0VBoqHjFIexlNJ+Zp/RuXAZzkxMqjSz0vEhCwPr9O590V3UfDTqVa4BNBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cgsTYpw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=we7KDHQN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cgsTYpw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="we7KDHQN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AB9BEC0081;
	Sat, 22 Nov 2025 21:41:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 22 Nov 2025 21:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763865668; x=1763952068; bh=M+vBUzqdJC
	M1S+0kdgq9TFifCEOyEGM4mSBvq8PilgI=; b=cgsTYpw3lfKfb9oLzRH8x7KhB0
	4u5y+9hRyhE4w/yDZtFqTZyh3CZ7LVEUivRK3SjmdvHDxNdFaDzNQcBXLbGWTESB
	EIj6FpOG3rFjYbnS20fNh9j1+dW7Uk3wSX2eV/TScq8gklLK9OHP+Y+UrW2ZgBDB
	b77u+y6U8TNrBAW1X2tuTjiYx8n0x/yIsuVX6eKrUgceDJpgnsDRSGwq7j2MaLQt
	w9VCy92iwQQgS26a2eSr8Yh2zZr6M1PX2MuSK5loes1AhwQU+pbBfuTmOSvDfXER
	oIh9l+j3C5+6tZPH7czxzIcupAwItz5ocRGU3qwqKnHw9zhdGKMOcX7Ro7uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763865668; x=1763952068; bh=M+vBUzqdJCM1S+0kdgq9TFifCEOyEGM4mSB
	vq8PilgI=; b=we7KDHQNhjRQRqQKNVZRU8kNCVrgT3O4VtUJ/acpWFSA4V1rwWT
	f6d9rJZyitj1LewDHl+YnjexYfBK78h9juytWnQ9YS5eh2VA/3RQ8WPXPiC0Y31Y
	dfDeAocyEW618fqbxRygRwexTVOjlPsoD++QBGIBLpP/Na/bWE3CG6etyvfgem8W
	jTx10uNeeRqtjRhr5GysS82eR3at3RpPiLYHPSKiIDKkyxH4hxj8kn8he90nlv/s
	cfMM1uER820Ar+e3sqSA4uuutqc40nV5oq3zhiF2JH8dcFceMuwu89V/k+wI7o1I
	RDHyzDSsLTNltOyEl+9m0MxgVAj1Gk2/UwA==
X-ME-Sender: <xms:RHQiaV7kzZyLtMTPqOlHNYxEbIht9AufNHB6eaFLFxZo2My1gLb27g>
    <xme:RHQiaZ5wrSwkVGNsJL0-ZdV1Bpdaz6V7rJsz5WTUQhkLgSqJFhc-BVUwQKq4iVMVF
    t-UZUmsW7PQ3LtzmV3L2v8zrl2a79N2SM0boi7yoN2W9ZH9DZ9iERw>
X-ME-Received: <xmr:RHQiaRf1mBxWZlFy90cFQ-cqS6Z4Q5DYNU9lP60W6Zqz3l06riQMUFpwGGlMH8c6B1mMfPB0h0O7J8osQGV-xjoMk-W-aBbTXi5G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RHQiadASp1XIg-iBq_f4svhxJycJORjXbYXji1bNpcf1n2f44zLj5A>
    <xmx:RHQiaU8YC_j9NQceNqip8XPSqHLSE1ayZj0UCcqfW8Hf_vlf6MnBuQ>
    <xmx:RHQiaYKh-s00NERW1uEB22X4CTt-HpDR3kaTi7Jf40Ggxla_fW5hVQ>
    <xmx:RHQiadijlAhIhEl75-MV5g-rPucmkYAuIbkUg47IN-4j_uRk-NdsBQ>
    <xmx:RHQiaW36IZlHH2lPBjyjRYFsZnf_r2lQxaXCZmDmYF3I2JFDfl0tWk1Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 21:41:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
In-Reply-To: <xmqqpl9gike6.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	17 Nov 2025 10:28:17 -0800")
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
	<xmqqpl9gike6.fsf@gitster.g>
Date: Sat, 22 Nov 2025 18:41:06 -0800
Message-ID: <xmqqqztp1nel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> The solution is simple: make the file world-writable.
>
> I expected to see a+w not o+w from this statement; as long as it
> works I have no strong objections, but if I saw o+w without the
> above explanation I would probably have wondered who are in the
> group that we do not want this file touched by.
> ...
>>      - run: useradd builder --create-home
>>      - run: chown -R builder .
>> -    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
>> +    - run: chmod o+w $GITHUB_ENV && sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
>>      - name: print test failures

Unless I hear that "user X belongs to the same group as our user
that runs 'chmod' on $GITHUB_ENV, and we do not want that user to be
writing into the file", I'll amend the patch text to match the
"solution" described in the proposed log message to "chmod a+w",
before we mark the topic for 'next'.

Thanks.
