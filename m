Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E63FB0E
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264191; cv=none; b=FGTTQ8eqvJ29OHd1ck0uA80yj+rGB4ibJQx3YJ8nHzxedZSQ13UR/kOvuBuoeJBSfuyaU1g1xC68CUwq9adr2PTpTLwKr2LOmCBTY78qD4gTdKRr2KCdKQ3DNcaoaCxllYE6yc9IL4SCiP7UdRw2pdsTXsVSWf3BROhgKlf7myM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264191; c=relaxed/simple;
	bh=K+Yxt6AYGl5bkb6ZcauyuLgwXKdmj7CHGmK+ru8R7uA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emnaILPDoPB74O7UtjDbGbxSh+L+RVlaDkHASBDX+qzptQbALBb/f7EqsKq4MUhyEfORRyZkVyz5PeO4MQ4S6M4f2UhE/rdLrUklNDojFpbxi73lWxAW9dxAuQqF24OACHdi23D6ISCZje2BSjBjj7m4s4YrV3OmswElzrpvwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJd7Z5JZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJd7Z5JZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83D9525400BD;
	Tue,  3 Dec 2024 17:16:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 03 Dec 2024 17:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733264186; x=1733350586; bh=MaraINSUuT/i4AoBV3lqaaKXLhUzYnQNu7z
	D4V0GgyE=; b=MJd7Z5JZnFmD0888aLxD7M2hEfsYTchWGc4XXPxnPVK5c2MKEXM
	8VXjOgnpSugi3tOSIhIeAOPtiierEZIVbSqaoFjdKSikolbU3+ltDXJrzbhNXQr/
	jjDOy5pqKOT2eTabWlA36uPWwNNHn55xx2YqDm2CBpyfkQ9qu034Y5MduEsfnL+d
	oEnmzRc+7/RrIq40bn6bOlGz0V15MDzYOiDUF0s7VyOaTv4gklpGwh5KLiQdSgHm
	1/aZUnTH2uDk3hvtCqWZaN9N/zIBqnf/cXr1VFQIpNra6pQbgXREQCO/sbn6Yd9B
	QZZl49uYu+LtePuk1VfzazjsWICPrCutjCw==
X-ME-Sender: <xms:OYNPZ7khKIOszE2Ch_mzFjlb8LL4SWHZIfths1uqKLSkJ6LPyX-EsA>
    <xme:OYNPZ-2t5LL119tKMZn42s62wGdGsXvI8mEuMnMXunPY50TJg6Ty5XFDkECnf9Xhf
    9bwJsFYxqrulRpx8Q>
X-ME-Received: <xmr:OYNPZxpUfXOxQeuaneOEDmEI7c04GFnTSYAlXqvY_MQp9sv7tt3CD8yO5y72NfF4z-kppDyBTyYgaIomXGsVHrrGabh1DHlVNmcJrrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnh
    ihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OYNPZzmXxx6Uq10nnmamaW6p6byO0P11sD-_cPg_xg-ZriFQpp14Lw>
    <xmx:OYNPZ51dqH9eCgpLjWwBiwY3AyRQ_dDhG45DYpaG9yrER0vEDeWnCA>
    <xmx:OYNPZyuGbZII-XH_alORhSDoC6JwsHoi1Vxc8AgJvJ45ZEukzSA4aA>
    <xmx:OYNPZ9VTbitCmhdV6-27QKhNDYI3AufYHtzmGnvCjvrDOPU7mY6FjA>
    <xmx:OoNPZx-zIZUBTxphJ2vLIWE8pn3my6X57VuqD7qJG9jSfABzvigIsBqx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 17:16:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jonathan Tan <jonathantanmy@google.com>,  git@vger.kernel.org,
  hanyang.tony@bytedance.com
Subject: Re: [PATCH 2/3] index-pack: no blobs during outgoing link check
In-Reply-To: <Z06ejDgTnC6gWXgx@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Dec 2024 07:00:44 +0100")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<300f53b8e39fa1dd55f65924d20f8abd22cbbfc9.1733170252.git.jonathantanmy@google.com>
	<Z06ejDgTnC6gWXgx@pks.im>
Date: Wed, 04 Dec 2024 07:16:24 +0900
Message-ID: <xmqq1pyocszr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> The benefit of doing this is as above (fetch speedup), but the drawback
>> is that if the packfile to be indexed references a local blob directly
>> (that is, not through a local tree), that local blob is in danger of
>> being garbage collected. Such a situation may arise if we push local
>> commits, including one with a change to a blob in the root tree,
>> and then the server incorporates them into its main branch through a
>> "rebase" or "squash" merge strategy, and then we fetch the new main
>> branch from the server.
>
> Okay, so we know that we are basically doing the wrong thing with the
> optimization, but by skipping blobs we can get a significant speedup and
> the failure mode is that we will re-fetch the object in a later step.
> And because we think the situation is rare it shouldn't be a huge issue
> in practice.

That is how I read it, but the description may want to make the pros
and cons more explicit.  One of the reasons why the users choose to
use lazy clone is to avoid grabbing large blobs until they need
them, so I am not sure how they feel about having to discard and
then fetch again after creating a potentially large blob.  As long
as it does not happen repeatedly for the same blob, it probably is
OK.

> Without the context of the commit message this code snippet likely would
> not make any sense to a reader. The "correct" logic would be to record
> all objects, regardless of whether they are an object ID or not. But we
> explicitly choose not to as a tradeoff between performance and
> correctness.
>
> All to say that we should have a comment here that explains what is
> going on.

Thanks for reviewing and commenting.

