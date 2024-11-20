Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979B175D5A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092577; cv=none; b=oLTaePWxuA3T0ouPPtHc6HlVtZV28mFl/CfEgwehJC/5FEvqe0R1esTWISnLfmNsvezjQwbnZZrQ9nMrwbS3OwSD/oxi+EzEOl3lob46m6I13MGDjHYqxdMW+btKlUuNTdp3hgUZ3UgttYltDxDzohoeGT7bDtDq3TKicW+zcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092577; c=relaxed/simple;
	bh=bzN8AKQTB3rYTkSwLIPa/Ad4Y+3rsomv0rYDtBHFhhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+LZwq4QHlXj8RZzTGnw2rRcF3YsKnuc5cIY7NRTED0524FJz2zyfTyCBp0pgQ64lCCu/J8hweTHls6OK7I1qXPbPRs+h1CMq0LVu/T30srQg/cxu9d+RJ4JU0SA2WLmqB6Ljjr5rOIjCdqi4XvtPp87BHnSHtwM9MpgDxzEUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptwVzW76; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptwVzW76"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D364D254021F;
	Wed, 20 Nov 2024 03:49:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 20 Nov 2024 03:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732092573; x=1732178973; bh=tld8CnNWa2FTiKfQNGnEe1wj1IR6Fa5HnSk
	cPFtJ/gk=; b=ptwVzW762qTqATEC1ZBOcO3kRzqGyl7eC2qVkUQ41UmqrfOGO/4
	sAGPnSzxsZmiQvE6YpWdK667mzCaTzUIyo6DD4eRnpNso9FbyK4OoLRUtibG1oFT
	vhcC+Ag98rNJgJwTytWgM5ox7Rn0IHjWYLPpvcknlzZTDSs1Csfxcf7xnCAEcMxy
	aKfKOuZ5MywJIjHkHDLFuclOT3IE6bmEC4ntjmVkmeKqqWU3Idqdc69cE6XmGuTJ
	SPXHWPhGLyju8taxUIyaUCPj/vZ5rrGfRDguUgQI2rb6WD7Ys8waJs2XgWLthCbb
	BsNnbIlH2jd/p1pWeROZ6hTIoGmn43QLlKA==
X-ME-Sender: <xms:naI9Z4cCoeJE8PEQLLABxQgZstofYGi1u7t-G959keD3C-mIP_l7ag>
    <xme:naI9Z6N5PdX6lIKVJJYqUPXswGrKBQ371nf47zIar4A95k0w5HVnPGeewAJc3NlvV
    z6q1BaHzpwn8UN_lg>
X-ME-Received: <xmr:naI9Z5iUGXryeJC-22KU0kxgH2flKhTDasHuA1gLU7UpK9ZNFo54BY0xo4ofzWVc27hpqzJIPT657X_1rppybqxy-UXv6NGS9jRS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:naI9Z99AaAlgJOiv6Q7LQrfaZGe83IMmDDA0HBDpl7yMgl6vxvmMzg>
    <xmx:naI9Z0u9gxcWa3gPAw8xNfoB2-3yvI-Q2FCRWpxI-b5J5nhpF0xXXA>
    <xmx:naI9Z0GXM2uzRPJdj7Pai3-IzPzqdxcaVf47Kb-49qeiha9LNvAcbQ>
    <xmx:naI9ZzNeZT9hRWL4NNpDBfefdN8h4g5r5cYB8mqVv-lZtraVmblkBw>
    <xmx:naI9Z-ULCXSkGBscbEaEvWfIK6nyNDfy0vEYDV4yH4vdXzFswtGyJSGz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 03:49:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 00/13] midx: incremental multi-pack indexes, part two
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com> (Taylor Blau's message of
	"Tue, 19 Nov 2024 17:07:16 -0500")
References: <cover.1723755667.git.me@ttaylorr.com>
	<cover.1732054032.git.me@ttaylorr.com>
Date: Wed, 20 Nov 2024 17:49:31 +0900
Message-ID: <xmqqttc2i92c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> == Changes since last time
>
> This round fixes a small issue when writing legacy ".rev" files outside
> of the MIDX in '--incremental' mode.
>
> The rest of the series is unchanged, and re-submitted to solicit review
> now that I have more time to focus on this series.
>
> == Original cover letter
>
> This series is based on 'master', with an additional merge between
> tb/incremental-midx-part-1[1] and my newer series to fix a handful of
> bugs related to pseudo-merge bitmaps[2].

Both of these prerequisite topics were from August, so we do not
have to worry about reconstructing the base anymore ;-)  As I do not
have any trace of this topic in my tree anymore (except that I know
an earlier round that ended with "fixup! midex: implement writing"
existed in the past), we could queue this on 'maint' afresh, I
guess?

When merged to 'seen', pack-bitmap.c has conflicts with other topics
in flight and what is annoying is the lines involved in the
conflicts are rather on the overly long side.

I think I resolved them correctly, but we may want to correct these
overly long lines if a new iteration is needed in the future.

Thanks.
