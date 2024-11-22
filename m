Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBB10A3E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272687; cv=none; b=Rj2dgXah4hvB+GIYrgAcNPIB55twsVLEKm/xET+e1NyqAq/nK68jYzROluqMnxrc0xBReshLuf1qUKJZ1hpqqErZsIjAttLSzSKMlAvZSWJR0tBI+6RkGzqXcew05wPBjJbi5z/nRrQjeAIYl1h83rbkE0K9FR/ZMccgza/N8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272687; c=relaxed/simple;
	bh=kUql9273jr5gImVUhQA/kRFJ4QYF1lVKD9xPgFEXbMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oeEjuNYUPRbIynsNc1LIdCrHnFp1atiim2o1HrMMnBf8W4E8KukvYiRIuHZuaY93vYI0hMaEHa68kEbw6bmbihN0RnWg6AYj8y2Sf5bC/xPRAfuRWz9yAPzGZMrEEt5TjcYcePpZS45a8tP+7uhSp3xqDUNOvaXwt+7+Kr6ej4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDCU49lP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDCU49lP"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7A6C25400F5;
	Fri, 22 Nov 2024 05:51:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 22 Nov 2024 05:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732272683; x=
	1732359083; bh=YHwi/bJRzt0s+01LPqMvke+8FY1Z+Ld38VsRi6uPtJ8=; b=E
	DCU49lP9QHVdra9ekKoYeWIYuAibSnYE5pGKCUHcNbFNx5h7Qo1bmmcGvNZxhMIe
	vj+aQ1YQF+FWiVZLpCrd3sfBJUwfG8LXPaP69g5kkAU3eM8whpLyWBUISrP3M33p
	xx9Z4EUQyWCOGKStzSFLRUoNVCy3KvxEo5wZhoUXq5BxsSrVfb3yST9vfbh0RZZD
	mPA+1Ag8ZAr7Otb0BTYYVbC7M7wXZNne5X7N3MoyTnJFjCHCTo0IqN33ClbxWSP6
	KiztBeT9QlspPgGzBOQXWvMkjKD5bTm68amXw2WcGoiEa2dnkUO3wzlTAj1AtB7P
	05A9fl1pAK7wcWausEHgg==
X-ME-Sender: <xms:K2JAZwzv6sIeJCVrlNU6y77W1qKZx7EEFfTiRDACwI7qp-CwMUvp3g>
    <xme:K2JAZ0Ss0h8COZCrSr_3ZSxMoSRSuoyRJ-Ua-zUrSPEU0KVFU-jNuGOZWDeAnvead
    Y-fsSVq9AeiqIwAag>
X-ME-Received: <xmr:K2JAZyXJiJEXoTNxxRraHCfOcs5OduhlBvIuTzlgNbsGcAXDp8Y49bfPz3sdIEk8b0VV4kV0u5O5AzIQzo95VXIShFtCKah7lqJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeekgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhllhhirgdrsghosg
    ihrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:K2JAZ-hO9KS0PVrLu7rSqGc_jR2Aixrm7h1tS8W_hIqRmth0d_XuEA>
    <xmx:K2JAZyDNDeVfQ-V4gMqggdxfweQpOIqr964OJQjZ-DUGhrjNTxaFrQ>
    <xmx:K2JAZ_KykUcZEd9OEPJhWORBVtrZmmC7XzEv-eLG9ILw6Yz8RNw7EQ>
    <xmx:K2JAZ5AuhKVl9cBbqqSJsp2N93D-Lbx4gvV9bcR8696IsQFbrc4LdQ>
    <xmx:K2JAZ1__tu6I4lrU7zlz-pGSILTeOvDcC_G-ceeM5fO8LIRwTAVORT0B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 05:51:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: Long names for `git log -S` and `git log -G`
In-Reply-To: <470fe577-b26d-4393-8fa6-8f73ca4302de@gmail.com> (Illia Bobyr's
	message of "Thu, 21 Nov 2024 15:31:00 -0800")
References: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com>
	<xmqqo72bev71.fsf@gitster.g>
	<20241119185817.GC15723@coredump.intra.peff.net>
	<470fe577-b26d-4393-8fa6-8f73ca4302de@gmail.com>
Date: Fri, 22 Nov 2024 19:51:21 +0900
Message-ID: <xmqqserjsfrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Illia Bobyr <illia.bobyr@gmail.com> writes:

> On 11/18/24 19:52, Junio C Hamano wrote:
>>> `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
>> That is probably OK (even though "-G" is not exactly what the
>> pickaxe machinery wants to do; "--grep-in-patch" might be closer to
>> the intent).
> Imagining, that I am starting from scratch for this functionality, I think I
> would also consider "patch".  Though, as we have 4 related argument names, I
> wonder if using it as a prefix would create a more consistent UX.
>
> Something like:
>
> "--patch-grep" for "-G"
> "--patch-modifies" for "-S"

Ahh, "modifies" is a great verb.  It sounds quite logical, but "-S"
does not have to genereate a patch internally for it to work, so
"--patch-modifies" is a bit of white lie.

> "--patch-search-show-all"/"--patch-show-all" for "--pickaxe-all"
> "--patch-search-regex"/"--patch-regex" for "--pickaxe-regex"

These already have their own established long names, so it is
outside the scope of this topic, and I doubt it is worth giving
these additional aliases (as you seem to agree).
