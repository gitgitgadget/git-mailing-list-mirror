Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909C8BEA
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732582134; cv=none; b=kopzsXaLzpFzvL2E+ARxe43EyTIWMKivzfxlsCiGrA/Tcf/on11fyuw27is+djOXZB9Nh8zImIy41Cfwg2Qk4WXYqbFb5bRePBEWxoydepmKVve7cwQBaO6XptixdD29r9pX5/aIQgNzqNAFsYMRSfnHHq57U9Yrr6ye1Z0PFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732582134; c=relaxed/simple;
	bh=0pdCBZ8cJboDM3R9j3UIYiM2ZQLJhhqiUif50SpwS70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJ3i45M2zldkYp4/GZZ/j8UamQUzFu8oNjnk26gRDzY6pfHUGYMNw+2N3KE1Fy0u/ICx3KTXKldpToBcqArnp/SDyFLRBFtfatV63faCQlAWGUNiC+iIMjRWX6ZDLIn9ohrjtF13kjZYPSi95BrA18tCzcNsGQ6/QCI4wMp/PgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZ0ez5JH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZ0ez5JH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BF76813805EE;
	Mon, 25 Nov 2024 19:48:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 Nov 2024 19:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732582130; x=1732668530; bh=sGic/xVPSZbqTCFwXXiG8g77L6KY2sxtVcZ
	2U2ManH0=; b=mZ0ez5JHXSGtHqmXxRWArCp86RIdTNnv3/IdVN4T5R7bG0lAL2O
	hynNa74v9tNox1cL+PJeQLg7I163eGIcRtqjOmJZjcIfnf70bd6IxjsZoIWB6ZIM
	GlY0VnkawqBWgvH46BAtTPT+gAcHMZ0pFsHpEFs0HODmuoIILy+UEKZBgad6wwGO
	8UXfBYtNB8jRi7WyTF8JXmO2Qp4Yw/I5db5A1noADTDsvAVUdL3DKCnydU0LfKnT
	BOErRbABFF8uXQE5Mj2VtMq2QU1kMzrN5rqkjt6o8MWVr2JA/CdzjkkbyqTbqGdV
	GvPhoJjWndtzjQY3jNIgzM6mjONWTSplpXA==
X-ME-Sender: <xms:8hpFZ2gTuYerxzYcuik35eG8RHSOuYNRDLkw6afDzot-eVNYReW__A>
    <xme:8hpFZ3DPEm0BErSPLTXN5DZv_IF2og-geO4E6UrTJrxLZSZkkzKXejVeEdKE-eIdZ
    Gqh9UX1taiARY7K9A>
X-ME-Received: <xmr:8hpFZ-FKAapulf8oXGpI-NkSs2d-Q5c5dDApqRd1nVUhLTqysR6sqvaxnLpoPfWvj8RQnbL86dZpdtCxep1OtCP_ON4XOfWv0WXDr7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:8hpFZ_RzIvaMryPaMP55eKTu2dDQy8E7ceP_jHACSO-tcRggat68ng>
    <xmx:8hpFZzxbDHpV2hHxOx1jgtj165D0v1ljhl1xiTjl_HTriGF-qSFvqg>
    <xmx:8hpFZ95ccbXfzx0dBz1GEp20FbHJDDVbYtO4mj3p75OB7Nrps7jZ9g>
    <xmx:8hpFZwyQ-a00fWSA6InnD8HBMivDIIxAGsrn7i1hOepW3ssT9WYUlw>
    <xmx:8hpFZ1uUUAitC8Vuy_kRqq38gRkf8vzrZjICCy4kIo0Zg1Z03PiSVFgr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 19:48:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 4/9] refs/reftable: read references via `struct
 reftable_backend`
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-4-1d7b658e3e9e@pks.im>
	(Patrick Steinhardt's message of "Mon, 25 Nov 2024 08:38:26 +0100")
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
	<20241125-pks-reftable-backend-reuse-iter-v3-4-1d7b658e3e9e@pks.im>
Date: Tue, 26 Nov 2024 09:48:49 +0900
Message-ID: <xmqq34je4y6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
> as input instead of accepting a `struct reftable_stack`.

Hmph...  am I supposed to be puzzled that the patch replaces A with
A?

All callers of read_ref_without_reload() now call
reftable_backend_read_ref().  

The former took <reftable_ref_store, reftable_stack> while the
latter take <reftable_backend>.  They both take <refname, oid,
referent, type>, of course, because the former is replaced by the
latter.

OK, so we introduce a new function, and instead of passing ref-store
and stack, the new function only takes reftable-backend (which has a
stack contained in it).

The old function used ref-store only to find out the hash algorithm
via its base repository.  Since the hash algorithm can be found from
the stack that is in the backend, the new function does not take a
ref-store.  FWIW, the old function did not have to take one either,
but since we are getting rid of the old function altogether, that is
fine ;-)

> This allows us
> to implement an additional caching layer when reading refs where we can
> reuse reftable iterators.

OK.

>
