Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC634A79A
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629939; cv=none; b=Tl+UeaStDGpQTuMU3O+Sz+lXwUdfGSW1gufS2y4BhfwKiIK98bFoyHhv1QcmJtcUDCbSrkClkUlGr7aRXg8Q+CaRz1SfSQ0NtW/Wt3o3Pje4KHxrRxUEaqnd0CvoG6gjl9TtUsbDzWToslUmeL/GzK/iveWxStPvIwFwV9F1grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629939; c=relaxed/simple;
	bh=Q8/DvNVQDvIe5QNohcbKCun2cvs8ME+sb1kcini3HeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEmyLRSjiTjljtXCtDliGkzzcrfXAINU6vCa3EgA0WECrDEISZ+uqACTBW8TdraqVEy2nwqHRz0ye13x6pjM7lCS3DRl6l5ZkT/DF+UTi2QX+PgV+VyGtfe0GEvzglp3gdpJZ/CIo4jF2zV+bY94KLRr74KRkd3pgHlB7xsuRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WmhMHsjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTm9COYP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WmhMHsjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTm9COYP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9473D7A01B9;
	Fri, 27 Mar 2026 12:45:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 12:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774629937; x=1774716337; bh=g+52aVn/Py
	o4OF/QJFriipqn38oydBYCkMJ7tlsYxgY=; b=WmhMHsjHPE6q+cD09yKTfCNqbF
	2RAfv1J7qntuBlfc8uFhDS6Nb/bRUZP8d5SsyU8rX9w1/M1GlxDvQgvgSUxAnaRg
	oq8MGKxygJ6mGaDtUM6lk+/ciBacwbkz0Tmuty2d5rrntTvE2goFi+e0HuRZSfAC
	Rth2C4sCLvqncR08w1aQNI4v7SeI0LR55I8mh455MiMDkTo0xFqBMs06AJltHZLP
	q4YXdjd1fvvEoL9eB09xQWA8zW1a7x3H5hjl0OnkiqeBIBr/eqV51AYTkr4jzhv4
	lUz0Qr1mbJ/iW50imBkYZ57WF3YI2xEXV3qv3p4E8a4+E/xsgAmIWfKpIadg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774629937; x=1774716337; bh=g+52aVn/Pyo4OF/QJFriipqn38oydBYCkMJ
	7tlsYxgY=; b=iTm9COYPfUy/6HsBIpf/EkBaY7+UIF9/0jPzXy8qNN2VyU/b+jm
	16cJmnHRwCe9lveok68qq0zxA7NMKDMc1P5pJyT0KDa2HKuIIrWeyyQLJo5urGPb
	HMdtSvON604H8aNQiEh7yI3LTQW2+e3FyvF/2c208yj+/Vkka/EnPjuLD+//YcOn
	Cilh6n2QEExSBQMVSsljKrQCHoRsuaHLauD0wUNe0irBxZNwJ6nh57Q6fQUb6Hc+
	sOejklfp0qiujFnnj6TE9yLVw0yJa96VLhWHKBpbKMJeJc7j+KVRkuahv1JRBPbw
	t97TGCgRPQ+8tuI9UTztt+iVo6XNZVZwL9Q==
X-ME-Sender: <xms:MbTGaV4ymPvy1HobxbuOtFDrEMx2i5JvVbfKFJHoDpPzVZYO1USGQw>
    <xme:MbTGaZzM4upKcWvRUhAOLQkMqLSKMxPp60vAEMGYS0CSXwirY3a7W2FYoMFUieF2L
    nQdCYmqQ9DZwZ_o6JC0u5Dbv0isrbfP1CLV8DYZ3mnVauitiiSOsw>
X-ME-Received: <xmr:MbTGaUzZR1EvjCOiMpR0hWn_CJ0POHkL9EgG9FKRfmpNOUP7ioYvT2E-NU0mstivuIi5O_oR0IVevniJ0srnlPwCHmek-gBUyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MbTGaZz3guhsw3_RRytbOmcCq6PlQPRoAICw8pV-8XA8C7_W-FGEfg>
    <xmx:MbTGaWZSH2sRFIrSUZyA9WvGIP3lw52Z4qPlExBg1GmUCynZLQJWLw>
    <xmx:MbTGaSUTYi6W9aigWX9KRqfDHND1VK5Z0C_7oXTqG_E3YvEZML5ayQ>
    <xmx:MbTGacisSu-md_gG-SPrQYPPbVrl4XQtlSmDZv0Cfin388lavaBgmA>
    <xmx:MbTGadMr9EeaKUq42VnpHO70HlStxGc0-DSWXHoWYjzeGWDEWyaLJ60s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:45:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <87a4vv2ada.fsf@iotcl.com> (Toon Claes's message of "Wed, 25 Mar
	2026 16:32:17 +0100")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	<20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
	<xmqqtsu5xaw0.fsf@gitster.g>
	<CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
	<87a4vv2ada.fsf@iotcl.com>
Date: Fri, 27 Mar 2026 09:45:35 -0700
Message-ID: <xmqqfr5lkyq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> Maybe something like the following could help:
>>
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
>> `git update-ref --stdin`
>>
>>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>>
>> +Note that `git replay --onto main topic` replays the topic branch starting
>> +from the root commit, not from main. What you might want instead is
>> +`git replay --onto main main..topic`.
>> +
>
> Definitely would help, not sure it needs to be part of this series.

Where else should the patch to add such a note to the documentation
go, though?  Without this patch, we do not is because the command
will not take such a command line.  With this patch that adds the
"now we allow replay to take a single tip commit and replay the
history leading to the tip all the way down to root" feature, the
note may become relevant.

So to me, it looks like it is either we will never add such a note
because it is irrelevant and everybody should know the consequence
of passing "topic", not "main..topic", or we will have to add such a
note as part of the series (if the note would help the readers).

Even though I am on the fence about the need for this specific note
in the documentation, it does not make sense to me to say "this will
help but we are not doing so here".

My comment on "might" in "What you might" in the thread still
applies, by the way.

Thanks.
