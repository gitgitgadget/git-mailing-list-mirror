Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA23D8902
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025872; cv=none; b=ix5j3tY8o5jbllY6okTQqntst2XLVTsbRpCHYa6+KL10rai7P+8fO2lqDMvbvvgJWuSBYwJC2SWRPsN90qJM3NRa+tOYjeTudwrZChPVYYT7RmOeNNcgWQpHQNLmjYBkHt6O6o1hv2BImvthmdtlye6aQ4nllf6xItkuga3dTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025872; c=relaxed/simple;
	bh=4pB24lJdgEFA1H+YdwNPbv1kaJhmxWRJs2+7RLnh3UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/ixv1ZJtU+CMi4tHtzOE1WGwjmD9QjSt9tgh4N76s0lVXf8tyAi3hMiMY8Pwr0q7xtSQOZu014vCidy7SZwNtlavxyTCuNpGaIwx3iLZdQTHrGC/smRR4NRt3vep76c+VvIkvNBCTfkxRBzl65FAti0Hy9ztosOkiGNbpILGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YNU0G644; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qhygwm/2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YNU0G644";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qhygwm/2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 32FC7EC0212;
	Mon, 21 Sep 2026 17:24:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 17:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790025870; x=1790112270; bh=oZExTWDr7r
	YA3sxA+8X1gPe2UOowl2F+/jy4Ur/SoUs=; b=YNU0G644MyC22WLFVByV9QG+D0
	/0AzjEoFjGtfCHXnMHz48BVO/q5WGBZGUuLiSkfC59n7aQ0qVuG8wgMAwdi2Xrr8
	yqJc/5fMCHBlWzhi243CF9Jome+TFB8oKRLe/l3ufrBOGaHTdXy7+SFrwYvloY2W
	TlJccWHWnI5TrLtKJykTlCE4UTfxngw8z/mt7SYhLM3vAg9/Qq5ZTBFb8+GIYvkD
	IU+LbjRHOAajEIetBJLAXewr+Syn7IY/Ytutck/kv2GmnPvRlpA1EoKamosmzTMD
	ud4FNz/oeUnryAoW61vEu74xsiFJSXZ5b3yTlTSPIJ0+iX2dLdikdd7ImcFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790025870; x=1790112270; bh=oZExTWDr7rYA3sxA+8X1gPe2UOowl2F+/jy
	4Ur/SoUs=; b=Qhygwm/2YR3cDJgtdVA+wSM2LVcZxruo86hk+WmRv5DwLfiwUDP
	icTfcxP2H56EWqr6Nwx2lXMVrk5pACgIhl/SAD4KVTt2YMHZzQZNAHdRnJXy0Ljf
	U/VFeIii/eBX2yOre5AIdq5NL+eGH/5kpWT/VNQKomBb7Mlb648BxJTT2BwO8vxj
	eBiEk8QolNR4RM5s31E4CVEqJmh9KBEiNwIMOjLxttAMrj3MNrGiz6hK0+InXzw0
	nXnyjE2mR78mBUPHsuTX7tShw9Ik6f2VrwToU5gQ4QZiLly8p50AsoTM/n6FomjM
	OfljAzsEOgLhRcPyfdTSW4Q0Xn6NdAbIMFw==
X-ME-Sender: <xms:jqCxani1rD5PLR4kzunL0NobIgYrwXdXBgjyPE6AC0bKiF85K6zhKA>
    <xme:jqCxantVpCydSLjsVRIkAEhr2kOiMX4xX_98t2rPPrsa23rD1yTXpzn2cpMlfLGMP
    OPdlZZGHkrY27dnOFQ_Ha6wY99ByZ6ixG6D17JfMX2mXkcjH2VruzaW>
X-ME-Received: <xmr:jqCxag5C7GZ3xQix4pBIgg1yDu_CeT0B9lLgCJm8GtHNun0ESR85ro8hpaZObeO-WiiILWf83sueSWJdsmczDLQVKqWtJmRBckF9>
X-ME-Proxy-Cause: dmFkZTGWWBZQXIT5k7zXjQGdZRIAjiiLwQ9cpbZ4+558VVzE0gfl099m+ddXpezJDWxqtN
    awAXejyj5wzEyX3hMia3cy/OyMRsvdAkM3JnVZ1D0OSkO1FOQQ4/IsGEecNJ7OCHR+QL+g
    xRbzLh0KIZfMeZSzKV6s+SJZ/VuP4waI6gzH6OHU17rBuTWhjoZEENjIrL37s34RiLu0Kh
    l4k9hPcSDbxvt47PUBNk7xKf1qgTmqZb8rNAyRHQ0CXwNpKyo4bcxjgBgHtB4Nl0rXDKuO
    W3IJNLF9QxfGYhjins7XS7XKDC/ii8RoEtzS46KzAdSolO1T0dMAKg6CAtNStXZOuob/h1
    njC+Df/A70RrJol14ZRYJqwb4hghHesYpQXx7ElOV/h/9+9FubnXqJJneDOF54d4/E69pO
    XTCb3JDj7t/PQ+0O5sWu3FCWaqqMYdaVW5Elfiga14KRGXR0A8K7mqAIkA/bz8eaHB8CAc
    2vTSmlGAbsnIxkzOEmWLcncB4HRe5LMf0ILnUmFS6idxSPMva+MqAX3BzV1TKxE70ZHmEE
    5G/Wh99m+hgO8Krq0g1GZOTOCnaqd7CebBWTuIdwY4GpdpBysMLV7+XRYF+7JZvwSJeQMf
    WIG96bQfA0aztG9Xn6kuz78hJzg3ywNipBfEsJCZSeK5n3muP+DB+jPkyzdw
X-ME-Proxy: <xmx:jqCxarMjxgK9mmYVjCmB8rBsvuBMxFcYgFkIXGXCAuXChe9aTkYxGA>
    <xmx:jqCxamvU6bvD2WA4_i_3fMqmARc0T_UiynacH-RlY0NE9UTxH2vBiw>
    <xmx:jqCxamayO0Pgcxu5KUFv62c9r5YDH0xWn_ZjqUKAMbMGRmvx4aWv-g>
    <xmx:jqCxagwQwzpwax3tzEOx77mKPzGVI5ZUoDNyMNeOi8LSCMquwMcLIQ>
    <xmx:jqCxavQ2ar6WZB5-Tzpf4P8vXhyEWVetkZYba94732_MP2u2VEiU2TCe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 17:24:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 3/6] wrapper: create safe_memory_limit_check()
In-Reply-To: <3b3c67243d200a42aa105981b64228e2cbb35a6c.1789736540.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 18 Sep 2026
	13:02:17 +0000")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<3b3c67243d200a42aa105981b64228e2cbb35a6c.1789736540.git.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 14:24:28 -0700
Message-ID: <xmqqzexal2lv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int safe_memory_limit_check(size_t size, int verbose)
>  {
> +	size_t limit = git_alloc_limit ? git_alloc_limit : SIZE_MAX;
> +	if (size > limit) {
> +		if (verbose)
>  			error("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
>  			      (uintmax_t)size, (uintmax_t)git_alloc_limit);
> +		return -1;
>  	}
>  	return 0;
>  }

The code is prepared for a case where git_alloc_limit is set to 0,
in which case SIZE_MAX is used as a stand-in value.  When the check
detects a request with overly large 'size', the error message tells
us that 'size' is over 'git_alloc_limit', the latter is zero and any
concrete value of 'size' certainly would be over that.  Which may be a
bit confusing.

Shouldn't we be giving the local "limit" instead in the message?
