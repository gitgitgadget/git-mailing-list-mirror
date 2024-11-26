Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81528689
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650485; cv=none; b=rhItSIL790mks0jcocnCrNl0kw1CBtE5IlKisupXCpUgZ2g1xMTcTgvGlGH0JhQU3gMaRTzMkC+9jXCZksWBi79F3CYUp1hEfdX+gVUtzBYTTBQVHWVOBLA1xmonnv+aI8MpkfbqYtezMuH3nSnzQpEZ+TjlSR99eHbD4b1zi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650485; c=relaxed/simple;
	bh=g3D22M9pvanzFAYhKjr4xxZKt+pBXh6n7Xf0MCrOH7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUMaVuBsHd1hyWVPaFKFLUQuzWDGf5IYKTX6P2e3udvTBwXJj7+dAJpGkUxDHGQlvW1ajd2sXi/8a34sMGK6zh/m3zx0yOHd0TNU0ytBLicpeZsArnU4S3Jn2ERZLPwVlN8qAl738tbWdPcE1xl5y9kJoza+T/s0vNqiT+nnoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVwSIZvO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVwSIZvO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E044D11401C6;
	Tue, 26 Nov 2024 14:48:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 14:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732650481; x=1732736881; bh=t4QAqMdwJor3ALSp7M5aLA4Tiqp47wAdJ2J
	pZ1Bz9v4=; b=iVwSIZvO07i1bXJToW41z1e7FCMVha/2msMl61wU2cCPOHGD9qt
	EiZeJa4DbEPxF1XpuT360RNre4A7fr+KTTDO4fH9E0SrpvR5YbLn4cClD+nTQPK6
	ETybVUdVbJeZxZY2lM3wtVE4aIc3RncQYyYoc1whDpjmNKBVvoHNAyFW1S57PdTY
	YVkOdrGbglIzM0hdHHuRlIgPvkYzBCcz2DHFbWEumyD9ioZAp5ylEBk4OA3O+RBQ
	ilCobfD6YvPHLNRFcLOiEOlSAVQQG4epZtevJDX9qBZJryII+drIm6rMswP9x0Mp
	+ShlWZad1e4Bdks2YsTUeeOP7uGU5dXqlYg==
X-ME-Sender: <xms:8SVGZ4kZ33L_pSUsBmCxu8idLMPbwX9IhcpPozWogi-TuerN1XscuA>
    <xme:8SVGZ30RMfrDw8fmktVML4ynFkx7xytGzYWTVfoK9MDY__8EveEhtMw_yFuLg1DKW
    _pC74w8zkaPhH3Bag>
X-ME-Received: <xmr:8SVGZ2oYNxnJsiCkn9jyR1JpZTiT4uqkoe1FkRvaY_EdekhieQYSiQ5x2vNAL8HQmD7pEX4UqCq82G0LtZL3c5-1I9c73txgYES0mAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgssegurghsqdifvg
    hrkhhsthgrthhtrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8SVGZ0kNAO8AqsQOClge8bta2veguaIyJJ16FcyW0KcXz4fBdPW4iw>
    <xmx:8SVGZ20ChZiypVMXPvTiCKREwKyRRM_KB_usc0Fc-nXjw7_i_3H-SA>
    <xmx:8SVGZ7uSMrSm_jSaawL9pBUsha_Zsa0vKjq1bpnhcsMf2dAnl2KyHg>
    <xmx:8SVGZyUNXgpBQG2_M3B59z0yBnf5Kac8TGhLqxCgQ7EcqqKB5PliQw>
    <xmx:8SVGZ7x0VuNU-YsQPm3GAc9AafviLmNmn_Ez7J3TFDV9WCGLW_WDG8FJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 14:48:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Peter B." <pb@das-werkstatt.com>
Cc: git@vger.kernel.org
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
In-Reply-To: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com> (Peter
	B.'s message of "Tue, 26 Nov 2024 20:40:32 +0100")
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
Date: Wed, 27 Nov 2024 04:47:59 +0900
Message-ID: <xmqqr06xwzdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Peter B." <pb@das-werkstatt.com> writes:

> I'm evaluating and testing extended attributes (xattrs) for
> professional archival collection use.
> I couldn't find any proper documentation/information on how (well) git
> supports including xattrs in version control.

Git tracks contents, pathnames where these contents are stored, and
the executable bit.  Nothing else.  Not even the owner/group of each
contents, or time of creation or the last modification.

I do not think Git is even aware of xattr at all.
