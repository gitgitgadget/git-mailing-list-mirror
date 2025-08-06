Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B95292B35
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494840; cv=none; b=Kq1OlUNBBGOU56u0xMLk9m5yPG3qKj9OVVXQy4659CvUOxx2IIyQ9gPKrNoE85mrXUbjbrrIz2KL6Tdpz2mcv80GK/PWIFKRLqyXnaxiGzHeDESMRlxJXf8nkbTdSTUC0XxfoRP8QfEECfOKl9rLBTDxAkrrVUhXSmVJG/VGKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494840; c=relaxed/simple;
	bh=LQNWmd/Wh6l5SnQeAYTUdEqM7PC6h5rFQLaO1cmlqP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aIYUb2pCHA7UKeAeNzcx+G1QtsZpdB0nJrv+rYHRc47aWlph3aAD71iSKppnMyQCxNTcp8BFen1nvwwvgo9+vz6MZU4aDZvNukNhKzRgqFs8mJC8whcQcBEAZcZX29oTR+EOWLVUJ+pJ4fcafCHArbzTds9JAyXBnBrN3MP5hdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M3dRQK7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kk7C0Z1u; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M3dRQK7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kk7C0Z1u"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DD891D001A4;
	Wed,  6 Aug 2025 11:40:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 11:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754494834; x=1754581234; bh=DxSalu6XqV
	GfTVRWXFraVQYGIpVthc4Zzp2YIykLRcU=; b=M3dRQK7O28M3oUi2CAzWCtxpCv
	Vyn2yflQBlDA94cIDvYafjWTNywLwJWnDsOGrSfKAImmSI6OsbZCquJ/+IOFH5fH
	uMU6aFif2WsJyqwgDRCHXcqBa/UFm9wj2wPlB1wFRWa4/8VvCY7JoweH3a92Gyu8
	TEtH8VCBowWg/Tbhy54RYQRA40bHD3dGTzD+s006tfFFqTVHhymwdLeM66pSh2S9
	HDM5fTa5Cth6chcWgOpyu2JK9iNStIZXck4Yew0eHGMAaAAytYedmh4dw3YkG0up
	XfyjNvMi2Bs0qqZTXgPx1say9q7pf1sjRyjaqMxffseEnvj5TvPjuQq3xHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754494834; x=1754581234; bh=DxSalu6XqVGfTVRWXFraVQYGIpVthc4Zzp2
	YIykLRcU=; b=Kk7C0Z1uuQ3OzBSOSgpV6s/yMV4FSOOdIWoMGPFVHKJjlkUBsKc
	Pu9+F27B2RVJGoIvNiWI4R7NpMHV2QRfkCQU4/IjdNMYHK/+s+meUBqtH5zGLZyA
	azotFJVM8jV3q0/+JSnpdxiZmfRg5+vbj1UTwxxX2Om942tWhOkbjV0AoD3Enqdl
	wksztVvk/VhGjcC/VfgOYJgqmQXCGBav51hL5HtODVuOxkYZRvdL4T9fwyPZnxFI
	bvhz0tP7QMltEHiNSMe+rkFdJE/cckSnlFGB2919Phsswnyt5cbxFzIvNuWTlaPk
	kGH85rYtyAxPkrd0QcMuecBLE3Fz5rRE2ZQ==
X-ME-Sender: <xms:cXeTaObg3AEGvSVu_NAm-G5G8IgJPnCMbnotTTJGVwPfmi3jJmbOWw>
    <xme:cXeTaJ3A5U0gGYBbzEv9OrTXlI8RlMULphRBliXxNaQD-3wkip4i--V8F48sjwwZ7
    LIy_RCfNDmh-pFvDw>
X-ME-Received: <xmr:cXeTaJaAiTC0jaHJbrkOpSyPxJ14xqHFbL7VrXeSfNRXxPahYpo1E8Vpz9_vQ06Aw2EGGtdXCyqdeb9JY4xCyXrqk9pFTZxi1rAq-Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cXeTaBJT0DiG8NR_FafNOi3t2mpbQfF0BYzK_RJ98Ji9S6DFetTZwg>
    <xmx:cXeTaIGpHRtQfqeLra9N0OTZFhoa8G362eYdVVSTOekCEQSGT-X2mA>
    <xmx:cXeTaIuI32BnF2yzWbmjsmv_cCf5xaJNMIg9DYLKCHo-i9Cj2Hs4Hw>
    <xmx:cXeTaHsJzHz___ptetZ2lE8bC4A_5l54KmW1wAcPL96KNNn9MM6PSg>
    <xmx:cneTaCDdZxwgykrOB5CZ5VBIiAjmw6n_crvRkVwEo6wOsC_tKNEdn2L0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 11:40:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/10] commit-graph: fix type for some write options
In-Reply-To: <aJNLxfL5ElFAzNz9@ugly> (Oswald Buddenhagen's message of "Wed, 6
	Aug 2025 14:34:13 +0200")
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
	<20250806-b4-pks-commit-graph-wo-the-repository-v2-3-911bae638e61@pks.im>
	<aJNLxfL5ElFAzNz9@ugly>
Date: Wed, 06 Aug 2025 08:40:32 -0700
Message-ID: <xmqqa54cwj9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Aug 06, 2025 at 02:00:08PM +0200, Patrick Steinhardt wrote:
>>+		OPT_UNSIGNED(0, "max-commits", &write_opts.max_commits,
>>
>>+	size_t max_commits;
>> 
> dunno, this really seems to be crying for OPT_SIZE_T being split off.

Or just use "unsigned int".

Really, what does NUMBER OF commits we will handle have anything to
do with how many bytes of core we ask to grab from the system?

This "we count things in size_t" is a superstition we should stop.

