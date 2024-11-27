Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCD200132
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748858; cv=none; b=Jc/V4jO+os+79yxDoTlU8dB6QHNX/LeuVjFK6MDJeeN69on41SXgbM43xyhM3DsCCd/kcsJmlGBXsQbQxrSE/hhwpDGvargTQJMW9NCpqRfSzVrRaiJbWZHacDzCe4rjaGXntgWNXDsQwQycihFeDvjAfYo0jE3uMHMTWGbOnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748858; c=relaxed/simple;
	bh=L1/bUek6IfBp8DRlihRXQGctzQJ1LYAGRXj1r4/Hyp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERM/bW+K3tvA68pINdN94HjUKPTx+HuZJ8LNSUyPF0RIAUQodWUEw/pDVr3MRCbMD7mmn3vzEm3y7k7qhQbph0egDAIUeY1tDa1rRUG0BM8y1vdb6+uuIV9jSdHbauqVES/ZrbcwIMLiUjwpJCrCPnjxUyvEG82EdHmnhb2LhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xgvkygLX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xgvkygLX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 626881140098;
	Wed, 27 Nov 2024 18:07:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 27 Nov 2024 18:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732748855; x=1732835255; bh=L1/bUek6IfBp8DRlihRXQGctzQJ1LYAGRXj
	1r4/Hyp0=; b=xgvkygLXhnD3xZDa4gLwf+WBrHkcsRAGuUCwKTrtvWx1Hgtq1Yf
	K3ygcee/RbAuIUi6pYE7wbBQxeKd/rCObwtfycVtRHG+WBB7zsxF354MVEDuzXZx
	TimoZkpdQD06p8i0EajFFf3PJIcmgsotylhlOoPO9o3kAneEuJfxF3rIMjVAT1p7
	y3BpiaHvaxkZ4r0CGH7TR8kcv88anh2V/E2n+BrlVJ68sApqRaHi3bMwjQz+zrCQ
	JYkAIOQWXggAHl3PrTg4Xd2Wo10incb+YsZvSG6Amsz4X2TiXzQn+1n86OCqJscX
	UVzSkAqAzrazSh9LYfPzKnvh5P88uXA/LEg==
X-ME-Sender: <xms:N6ZHZ1sJrh38gx3JA_1gXhrO3hXUV4Wbs1G-HcsCJFwiOCfYR40P_w>
    <xme:N6ZHZ-fZW9HbJBEJOqwJmF0B14oSrrwRMOEkRBfbMdkvRJnGyAFb_TrO2kHnNRwdT
    BYxiSLSnaWYdLWM_Q>
X-ME-Received: <xmr:N6ZHZ4ypNdR-UfmzrR5xhJm5FFvFDkqGGDbp24juUS2h5QIxzmvDQdNmv2iDmCjzlhVwjeE4WvwSy-XIHoE10XhaKKkeO4gvRDUb6Nc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N6ZHZ8NkIIsWn_BHOeDtM5LrpJvIgTj4UJpUg-_uHHZMsebXne2fHQ>
    <xmx:N6ZHZ1_dWZHi7Z5ZnQrHGe1dK_pVqy9kdoIvRYJ9ewu4A3KKEAhlUw>
    <xmx:N6ZHZ8U3oZb1dylXogLY7Q34dm3-Iuzh67DKYZM8gmoB3OYZeniA0g>
    <xmx:N6ZHZ2dO-awIzdKOSnr5KrG08ixzIwNzLIfnteBkBcG3pMwrnpA9tQ>
    <xmx:N6ZHZ-OrGy8Li_UNax185HRGLNR7Z4Mkost9E77Cow5RZXGXzEcqlwQ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 18:07:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow "." and ".." path components
In-Reply-To: <20241127142458.GA1712@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Nov 2024 09:24:58 -0500")
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
	<pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
	<Z0Vxb4OVJYeAdgds@pks.im>
	<20241127142458.GA1712@coredump.intra.peff.net>
Date: Thu, 28 Nov 2024 08:07:33 +0900
Message-ID: <xmqqr06ws2bu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I had the same thought, but I think the right code to be using is
> verify_path(). That's what ultimately is used to let names into the
> index from trees, from update-index, or from other tools like git-apply.

Yeah, I agree that is the right helper to use.
