Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769761C27
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731889627; cv=none; b=UMIBo/HqdJDhpCFnxyCO01/TPoomGWyVbf4ySknLQrN4VQ3j5l1yuVW2yhJCYw8w/oDT32gmljTbtMOE/VowMofKJAFvExcZcvQmNGCvAdFtVxxzhucepVcHvgNgmkFOYGHrth9nC3/yYfXzEFu0vPzgKYZk+AfymhidpbovJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731889627; c=relaxed/simple;
	bh=ekRob6k6qzO0sZYv8xzgoaQRKvUikTjagmsXOu1ns4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZhBAUO7Pw8hCobvh4XzJCHVDNz1z27+2yEGNWAGqkaBta1Ri14WNMta6ZPlfMlPJ1/yy/fV1s4NJd3p17ul4IaVgSLQHC1u04kdy5cngNsWcd8vlRy+4oEdJI96BPGz7a3Phh3B10b+bqIGSN752QLIRBsQpIYI6dB1bkM33Vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eiBVRUqV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiBVRUqV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E38425400F5;
	Sun, 17 Nov 2024 19:27:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 17 Nov 2024 19:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731889624; x=1731976024; bh=f9D8u5p6Y0VjAwLNxlJbIa6cYWowatf7csv
	icnLLnTo=; b=eiBVRUqVMWUeG/Su0H06kLX5auud5RoDK0G/jZUN+Q9mz2UTs3L
	pAs8aTmSN3re5QPwdB87jRRYT5LYnGOsL+9K8IXgMsjGFE4GzqENgnDwXtZ2KKyY
	G2PotOaJ/3EQ4+UwHxo/SPNVJJTKRYy4y0tDcUNKKhPxXjd/gvqzn5FeXkWqD/CR
	Gxq1kmsXWqYhuD1qHX4DeDUcBQl/p9CTylDpthGwEuMKkTSkZWZQVCUYEa5E5wxK
	HloTMZpG5tp5xOfJnKaeN0+bvtReoPZ86C6HVh9uM7WBLxCSd2phKVwJYgJv6Efg
	/aSyUSaa5ri9qVCAqtqamDTV7OlkN0HDIeA==
X-ME-Sender: <xms:14k6Z0gL0_3wDx8Pk8Iv31r-mzo3Pz0f0dclDHu3x0IPZZjHDdNNpQ>
    <xme:14k6Z9CZVM1VVzoZXO8gYNSjRvKyU7X5j0k8bO-U8IEZhpDlmhcmbs7l8SulkDw6o
    ZDIOtm-KbeFI6PjMg>
X-ME-Received: <xmr:14k6Z8G1VpKIvdyTn6jspKo04U168Z43YUCGrendzFSZkrXiYeEeJM0Nu-dAAfjICBBwQWrSxwydFO3ikQc_ZhnQV5QW3wmwXT7V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:14k6Z1Q1BmcXJ_v62BxhwIwG7dgnljENP95PPhE_QIZkYbeKnPMqaA>
    <xmx:14k6ZxzxQa9S--_XseEB8xyNydoMM7vOkoYU11L6A1bnjcURajZRHg>
    <xmx:14k6Zz5taewjDe9BWvjiNHxPyFIHiUghnZeLR1hiSDq-HTLMQcAqOQ>
    <xmx:14k6Z-zIzkwvrzIX9Xu-NwPGCgCZy_YbSYxBi6hwzgj07i7h4lFesQ>
    <xmx:2Ik6Z4nSueC4I6pkNLiU9IgrebxFW-o823h3fY9CpVO0p1-HZvUlbjKr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:27:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Patrick Steinhardt
 <ps@pks.im>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] doc: git-diff: apply new documentation guidelines
In-Reply-To: <7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org> (Johannes Sixt's
	message of "Sun, 17 Nov 2024 15:04:13 +0100")
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
	<7f24a030-bae2-4712-8593-61a9d4089cfb@kdbg.org>
Date: Mon, 18 Nov 2024 09:27:01 +0900
Message-ID: <xmqq34jpz8ru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> -1::
> --base::
> -2::
> --ours::
> -3::
> --theirs::
> ...
> Next, since with such a scheme all options are treated equally, we have
> to ask whether the description in the body text makes sufficiently clear
> that they not all do the same thing (it does), that there are actually 3
> distinct groups (it does), and which options mean the same thing. The
> latter is rather meh, but it is the fault of the text and can be
> remedied easily.

OK, with that, making the 6 as the heading at the same level becomes
feasible and the most simple.

> Finally, with all this considered, I think it is not so bad at all that
> all options are lumped together in a single line (or remain on six
> separate header lines, depending on the processor).

Yup.  Sounds good.
