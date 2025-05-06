Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349551FBCB1
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561165; cv=none; b=QxQp+Yx1ZuZY+DN07aaFK4kl8i60ZWyK/jZ4IEuD+UFDb5nAza1vS5X73oCSflSAlrTtSCYiupRVZHJypeIBmQGDGS9H6Vzf91ThXrY2kzwCHvUy2DEhNGH1wt4KAb9Cp6/cLGQwRbav0vEKuYbURPbt51SJW1XkKyW9MrKC2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561165; c=relaxed/simple;
	bh=U9JdN0eGoklN1x+H5wovOm5qhkZMmPEYkjp+rZjZhvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eou4RT7xBrl0MEpW8KJWtrncOAbVlKO626oJowTtc0nB6uVOGCUOSqs1WvxF7VkW3vnv7IomA1a0w5pBmBaDotIvaqrTNdlSXQwlIKAt0xZCpp9Jid2OVmApSTAkAHlzSAzlBuecUkdgHU4++ZxI49QpA39pSC7dHFQMQqevPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=akDyL5lQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqlwAV9O; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="akDyL5lQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqlwAV9O"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E366254011F;
	Tue,  6 May 2025 15:52:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 15:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746561161; x=1746647561; bh=WbFAdrDEQw
	30EibXoxf6IZmy1BlSjmxKTW1ON9caFeM=; b=akDyL5lQimUOmcvcESqRUhl4kX
	V7jL0w/LVxs1oZnPGhXAkfmcKGK2rK5CjAAYRZFgGX/YZZZY73HltlZGsZP4wdgz
	GJbzWZ310DTf7ziV0udljkNWE5itByeGt4uJwuTFhXzYgDWWu0S1CFNOUJY00z5f
	rvkpfsFvwh1VF3oRzs6I7fm9RFfiLY74j/H4EfHVT0hMPeA/6MTJ6yMVcPdmv9hx
	+IFRcZubCtspXUcMo6G5j0zecuzqwOde4zSpde4eJ1MgUUskAjQjE48VEGDDdoLx
	g5/Owsu0xjILKWXgxITdG3cBT5rMyawIFMN0tSiry6f/5/u+sItTu0XbnUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746561161; x=1746647561; bh=WbFAdrDEQw30EibXoxf6IZmy1BlSjmxKTW1
	ON9caFeM=; b=dqlwAV9OI3qnV+2dnD5WozkWh5Lde9TFH2Ynxu++csY0gDowrvC
	I9E4uN8fVoOfr0IEuOPX7JnCwFz09hKJnfDaui0dCRInzpCXG8oAoTOmT6RxVEVP
	omkt/xdoJNnYsfN9kSLrVpBFkefj0x31DPrXBS/OGDptr+7cAcgiKN68mPTjRKi5
	k5yefnOvRnNGs1IWJ0D3olYu7neSXOA2eOcoXYCIqNVwR5efXbjduhjd2RA+Ue13
	InrVd3pI/kXCS3gdddXQM6ao+xdRsM+xurJaLfVEVqyVVWbpofbAcKDgl5BjZxWe
	Uj5+sr+CIFc2fiPQcuxsEEeTTxshIECbQRA==
X-ME-Sender: <xms:iWgaaCmWNCnJzMQJO-ghy92DGgL3akhaqGLI0fWAEj9ZN6rvNbrzBA>
    <xme:iWgaaJ3hDg65x87hRjVYj0HXwSOKCuHIi_d9H7Ml7mwpCQoe6UG_rtrad8XqPad30
    yT0yKTDYq9koj0_sQ>
X-ME-Received: <xmr:iWgaaAp2JXXQ40_H7u1OdJp9dukwGsBDInBI_kBzTqnDYIEAdEUoBDuU328bWvEYModtX50ZU6XXozEiA0Ox1lCKlDc5ZbLD8I8v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iWgaaGmqG0vOT08ZBxvSjA2J5b07dSJEYQiPo-Gfjfz_DMlFBCUsag>
    <xmx:iWgaaA2p8ThtJ7y6wuDrYdO6BwnTvt22KmmMCumlY7fHHJfEBsQqqQ>
    <xmx:iWgaaNtEqfvOr9Hj5K0YTFEkQYAJ327xqtQUSdsSASG-ZCaaxCEUAg>
    <xmx:iWgaaMWkcBG7wqShm35tzr2CYRv9LwqVHEv7Vq1CYFAXIrJn1RYvuQ>
    <xmx:iWgaaBXkPQTnlE-KsezDQkU0vb5kxNBOfOxt5eSNoa3efc9Z-1o_iFWT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:52:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] contrib: remove "remotes2config.sh"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-1-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:34 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-1-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 12:52:39 -0700
Message-ID: <xmqqr011ikjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Remotes can be configured either via a repository's config or by using
> the ".git/branches/" or ".git/remotes/" directories. Back when the new
> config-based mechanism has been introduced we also introduced a helper
> script that migrates from the old-style remote configuration to the new
> config-based mechanism.
>
> With the recent removal announcement for the two directories we also
> started to instruct users to migrate repositories that still use these
> mechanism to use config-based remotes. Notably though, the migration
> path doesn't even use the migration script. Instead, git-remote(1)
> itself knows how to migrate any such remote via `git remote rename`.

Makes sense.

This logically comes after your series, which ended at 8ccc75c2
(remote: announce removal of "branches/" and "remotes/",
2025-01-22), lands.  After that, we can safely remove this script at
the 3.0 boundary, at the same time we clean up the code paths that
are conditionally compiled with WITH_BREAKING_CHANGES.

> Furthermore, the script hasn't been touched since afa75bc8aa1 (contrib:
> Make remotes2config.sh script more robust, 2007-12-02).

A single-purpose thing that is done correctly on top of a right
abstraction does not necessarily need further updates, so I doubt
this paragraph contributes to the decision to remove the script in
any way.

> Given that there is a migration path without this script it is very
> unlikely that anyone still uses the script. Remove it.

Sounds good, but not right now, I presume?
