Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D217C
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236429; cv=none; b=QHp1vsglY5UG/rcsZ34O8D2zwo5sLbzmQ6w8dgqmNtTfZfH5QiajJvsoJ3KUG9aDMAxWAtQXZ7daIrKcAkRlSvQs7SdACa0/UIxNbaqPsWZjVD2Jqbog14oagzwUhj0b8zZqZu8EbcgxgVXjMgMiqZM8KKr7s7J98A5kpel/hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236429; c=relaxed/simple;
	bh=bZ2bUj6NzmLCFQ585D2V7i51HdwTUkGXjtAbTWQykfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VfI9tMRQPvVKJ+HjiLhGsAGOimhjm6d4aTz4KAYWUz2vfuW2Bq05bPC5p3Qy7xoc/TyI5DH0xZWx1AXlEDk0bpRjPc3tpqisCOfvYtY9DQ1AsBxPcUjz6XePN8DEiU2prmg7LKulYcBoLJmp4BEG3QbIG6nVDaFbHGAtIb/v2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ESse1vYv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESse1vYv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA786138028D;
	Thu, 21 Nov 2024 19:47:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 19:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732236425; x=1732322825; bh=fGL89hkNMzq6AaxvzluyWGND+jsXct/upyS
	eiSdm9B0=; b=ESse1vYvWvnpE22NIkJc0JYJkl23r/QLSOQ+Qj32s5USwnjtIpF
	bVhIaIG9YT+MKZOlgg92qkOkRnp/bAkT0I7CRgfxM+loBFMgycLQUL76EIhYBwYt
	W8Ys+XxBF7lpPHXfCecIRWoA8Yz9WxhLYoruXtyMt1zfAMpzp/i3t+PLVarlcOSY
	uOiDP4MMu+WUoChPewykKx+yQTfysOrBdykXfK+SXnMFn7m7E1xvPZdhZUdhajTk
	ZkT4xI9gFwR1xoB5uT4QtpNiSAtySvT+0zP155vlXqHdZ+5dy59JspcPlZVZeAZj
	K/ODrli6CMLlyhkdfdTcO48lKxiLG68zSWg==
X-ME-Sender: <xms:idQ_Z1PPhrY6cYFNO2tLUgBDf_WUClM9tUFWscQr_TC-CpRFOOIJGw>
    <xme:idQ_Z3_0JDhMiBHt7fpSGzd10xV0It_oNni7YnHQ_-iR15S_eInAlNDx-qDhuvMnK
    H-iVIlVDY8oF7oWaA>
X-ME-Received: <xmr:idQ_Z0SM2pm3mVIkI58effbBx0_Pu6kva4Wfft0-KAjOlmstvQBmEA0jgeFGQs2ihuDeMS-WKrtPfC6aG4a_9twa9zEPAbPKbEcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:idQ_Zxs9pmfCx_pm43weHqdUGIIwFJy77elt8DtCUmy1V3WPObVlQw>
    <xmx:idQ_Z9cK1neW2HRMGSz-nQ5VXjD4IxItv2rEyHoGsUbhF9NjzZ1Ozg>
    <xmx:idQ_Z91j-kR_ZOnq5IE-YM-6CblFRxdTvPmkbVDDXcIFuIh8z4ce-A>
    <xmx:idQ_Z5-krnwEavClS20Wrb0GKNfX-2UQHB5fDM3j7STazb3prmJN4g>
    <xmx:idQ_Z2ET9ydvQxR4_-tc-V7LH8y-0IS0fgRDNTWrEdCEKXc1dUXGJPc5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 19:47:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] t/perf: use 'test_file_size' in more places
In-Reply-To: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 21 Nov 2024 15:29:24 -0500")
References: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>
Date: Fri, 22 Nov 2024 09:47:03 +0900
Message-ID: <xmqqed34dri0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> The perf test suite prefers to use test_file_size over 'wc -c' when
> inside of a test_size block. One advantage is that accidentally writign
> "wc -c file" (instead of "wc -c <file") does not inadvertently break the
> tests (since the former will include the filename in the output of wc).

Another advantage is, instead of reading through the file and
counting bytes, the helper uses stat() without reading.  For a
performance test that potentially deals with a large-ish file, it
probably counts (pun intended) more.

Will queue.  Thanks.


