Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B543EBF04
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645213; cv=none; b=mKqG76BVPDGqkASRiieQivIJek+VXNRjQji/ph5BG71lvWtmn41w99AB1np4H8Nd1KcNxv1OlvHDLp8qyrhX5ap1oo3OCSw6M1rGba9Yk85Op7+/HI+ySmQ1NXOHCyCb2ebQvPwJ0yzAv+CctUG2uat3tHuocJYpdUudahGJHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645213; c=relaxed/simple;
	bh=t6W9zfEUgDwr8Icl0qG9XNo/KjiSWEjor03ORLl3KlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQSm3T0wy9KZGic3mvxnwPrIkmaW2l1jZsWbihQtaHM0bZVlb76XHnYDHSSi+MpgCPw4YtxlzrPUjqs/nrBF/ZzcoHvAn1zsahObkYLBwO0FYrASVwwOUC93+tTYuMRTHXlZB2JdINJxo9DDRi8v/Tr1pXNMCj3HmL7v7f+C+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RoLlAMJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9U4lQ8G; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoLlAMJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9U4lQ8G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 223711400045;
	Wed, 28 Jan 2026 19:06:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 28 Jan 2026 19:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769645211; x=1769731611; bh=OU3xlMWy4E
	lbPsdYeKVqaGmT5TQIXCdytZr/fNuOdSo=; b=RoLlAMJQPwzpwGE13uk9ivKJaK
	onRSA7NuXDL7gyFr6UN22MCIjehOwXDKX5jzpRa3T8VlteSHFwOX9xB8nZ4sYua8
	6nbXJQkDp1Vg4wW7ncd/OcqeQns2HCDXx85q3tVUTp3j5WYchEXz1BZKs9pRgvwa
	6ITNaGozMK7ZuLwYBykNrfJjuChDgbEr4b4lntsi4O1uWyYKS2/ArrnCiniArMju
	10tZvWUHcgJ4qjC75NWpySFeVChsoC0Ki65AEooZIvWNt2nwpOXMysOjMqUCY7aa
	S8JfhT2m8d7jnnDo8EDChN/I3BQQoCnLTd7bmqjrdpPsbFSB/EP30zenApdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769645211; x=1769731611; bh=OU3xlMWy4ElbPsdYeKVqaGmT5TQIXCdytZr
	/fNuOdSo=; b=v9U4lQ8G5XPmXUFc46ipv5cVmr/nKfdPiR0UM5f5TA2sAM6AgA2
	M2AcBA+Z/Aepw1pf6L8GRMwR0/EreM1DazCU3HIHv6KbM7K+b4yKtuos7mzKEM9n
	rv3lwhtEyUgPYAaHMl/qwt2R26n8r8yWOd3qnd39j25hhVqX9Xivmb6yK8Fh9qbh
	H2Z/RSgIto4awMgstD/WBPoL0Y6SieOGXRrYW8CnWJsCO3P0MtpR3Uaju2ARuzX+
	s56iWYySioWsuUAzKP6cUygP86fSYO7G3ArVvGrHi9TLSnFRKGNVZFlJsI3lz4ou
	O0aqDzFsTjVBr1j5NI8b+fz3C7nGqaoY0kA==
X-ME-Sender: <xms:mqR6aYfdyaIoepwbhDDlTFvI21kC2uzxulVb5x9oCTbtFRsGLDgedw>
    <xme:mqR6aa4KHoYlrwXq9SWDWlIiHeyWHaC-YVNecKzHZqexxTM5G_s2Iyk2LGfoJsWBh
    L0M90JXmUKinVEIeSwGzBU8NKfKx9hyZMKE8tDde_aiG8d_8gfeWg>
X-ME-Received: <xmr:mqR6aXu0fxwrU_ua1NC9IgQsqiZvP8ESRoD47UNYITDHAGFjdERYaoEGLpeLNOYQCPo_BhdPCyUGWvEdht5k4WOMJkw81ka-biH3PTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithhhuhgspggthhhrihhspghiuggvmhgrsehprhhothhonhdrmhgvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhhisehitg
    hoshgrhhgvughrohhnrdguvgdprhgtphhtthhopehprghtthhhohihthhssehushgvrhhs
    rdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:mqR6aSi6NzwtqvypJ5aGZh7twLz5FWyu5tvD7iW6FT8vlePj4e5Y2A>
    <xmx:mqR6aaqOtHXVaYriX25tOJpiCZIu-aYs57v3p03VM2JIT809QF_DOQ>
    <xmx:mqR6aXt1LtXLl-qlRMHWUyj1J1AavOYAWcygyMGegRCb3m8yC-xZVA>
    <xmx:mqR6aVZFRQ3p6OF-Crt_yuUGjcs8LIZZaA7_-gUS151b0R18W9mnTw>
    <xmx:m6R6acw0wvVfTwo_FcgMKNcnNkQze6jChFDMJnH3bNCZBnYKbXdupg2x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 19:06:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Chris Idema <github_chris_idema@proton.me>,  git@vger.kernel.org,
  Michael Lutz <michi@icosahedron.de>,  Pat Thoyts
 <patthoyts@users.sourceforge.net>,  Chris Idema via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
In-Reply-To: <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org> (Johannes Sixt's
	message of "Wed, 28 Jan 2026 14:40:02 +0100")
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
	<xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
	<71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
Date: Wed, 28 Jan 2026 16:06:49 -0800
Message-ID: <xmqqv7glcmee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> I think that these values for tabstops aren't optimal. It does not make
> sense to have tabstop at column 1 for diff output, because there is
> always at least one character ('+', '-', or SP), so that the first tab
> would jump right to the second stop. In Gitk, the initial version looked
> like this as well, but it this was changed soon after.

True.  So instead of setting tabstops at 1, 9, 17, 25, ..., gitk
does 9, 17, 25, 33, ..., which makes more sense, but there is no
practical difference, no?  Because the first column will be the
plus, minus, or space and it will never be a tab.

