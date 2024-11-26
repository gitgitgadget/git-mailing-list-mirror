Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B94D26D
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584579; cv=none; b=DBnccXkwt2OwGf1PJFSmuXDJolSz+WkWvzsy06riMPdarg9dZv0v3f4zN/7BQ+ospVPDfm3/YPavXaVa8HgOyV4QGLZ47heXwDJdPoxAGsyfuxBEVdNIWI1lscP6pLgS3d4OgS99oRg08fjvVeAslHkDP7qa0TYM1j1NI2M6zW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584579; c=relaxed/simple;
	bh=v0RlbJR8w14/Wy4OER3k4T4Pi7vIQSgjHmYBirVDZRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jvwjDHEUUdiK38/54LEMAJvw/LD0NX7NhkC0ZJTxUWS+yQPDYLmWpXaOLFLwr5xyVspg/coOlzlgemYmN/C9scDXvbp1J/6XmDK26fuul+HSSksBCXwp7+wLM1RGSXqMwQixdG4fsdWLJAuSSTiBSSMGIMSpkPct6C99bbCBids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4G88L/St; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4G88L/St"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1F8E114013F;
	Mon, 25 Nov 2024 20:29:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 20:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732584576; x=1732670976; bh=v0RlbJR8w14/Wy4OER3k4T4Pi7vIQSgjHmY
	BirVDZRc=; b=4G88L/StPcCdlqmBq/r7ud/j2TyOwihb+TGB9XMS1wu5k1HtAAC
	RF8xUZ1kLVQqeA2En+47WKlcvz4k6TR/o4dkLLY6F+X7/gL8UoTauVKWl1H5etqN
	a8r/+wZ5Jk8OLSATPcRvB0GQs/WU9nlzRM3zD4+pXv4iFaiDKPCOfHXS/HSn5U5H
	/e1Y41HdmkIkM3nbpkf/G7W5Kz+SInl1CXAtR8BJ6UdA5pKA+nraThRnd8WVS568
	FDRo4Dq1edEPXHC9h+lykm6AWx3EVhaoXR12buNCjcb8jGVNaWkzsQJJnkIMoX9/
	pvD0fplYpeVw3H8r2xI7w9ssMUWaZl82vUg==
X-ME-Sender: <xms:gCRFZyxsx5h0MtGCgQnrk5tUiEYi4iqcb9m9WJ1qkvJuXHNxlJDfBQ>
    <xme:gCRFZ-SynmAsqeYRtcn3GiPYWn2O3kuOKzc09emKuXzFh3zddOB3_DwLsx1nGntuS
    ZV7DfvPQUd7URuAFg>
X-ME-Received: <xmr:gCRFZ0Vb21HzYhFTboqTOp52NKH0PZYzaMlYQhfGH6xBNPqs3m0MtJd2rG5BwoIsD5UFie90ML090-had04KZ4vVnyV4FnVIY1DvGV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:gCRFZ4hG5Sz43mVV_u0wX3aFZzuAwHWYjf-kSSlPQ6SewKLSO8BwTg>
    <xmx:gCRFZ0D8oExqh4WuukXxYtBb-R9eLqa0_HiBMZhp690sxzD2k_qXxg>
    <xmx:gCRFZ5KDE8-Wfp92_jXA7SIt3w2DR82uo13TUTNmwEjc_Pj5itw_xA>
    <xmx:gCRFZ7DCuQwjtK2O9Has5Gsecl5OEXZ9bMaMGm8UiEihs-DzaZCW0g>
    <xmx:gCRFZ9KeuVcia5Mfd3GdM1OQnHPyB7kOPt1gQb2Ua27PE71d3XpkUowh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 20:29:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
In-Reply-To: <20241125194541.809707-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 25 Nov 2024 11:45:41 -0800")
References: <20241125194541.809707-1-jonathantanmy@google.com>
Date: Tue, 26 Nov 2024 10:29:34 +0900
Message-ID: <xmqqttbu3hq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> ...ah, in this case, blob A vouches for itself. Whenever we lazy fetch,
> all objects that are fetched go into promisor packs (packfiles with an
> associated .promisor file), so we know that they are promisor objects.

Thanks.
