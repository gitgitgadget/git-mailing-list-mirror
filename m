Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996013D3BE
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="niyzTRaF"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2E125
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 15:40:04 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C1E0A2C48B;
	Fri, 10 Nov 2023 18:40:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qIN+blA0EbBf2wbTAZIknt3XQN8O1gcDOEQDgj
	GULLc=; b=niyzTRaFF4NTuTXO8l2pbNm9a1zIWyNl/9y9pYpVIU9UrRZBnFr6RQ
	7XHyTHT1EQ1PRDz/qAyzojtANCYNM2oSH3Ds6VB1DHHAgywqT/Q/nt3ck/ZeQCQm
	/hEuLTydi3Br7qSQxRh3FbeNIuKqgzDph5Gp350OHVho1HEqchJ5E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA3552C48A;
	Fri, 10 Nov 2023 18:40:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A53C02C47E;
	Fri, 10 Nov 2023 18:39:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
In-Reply-To: <20231110220142.GH2758295@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 Nov 2023 17:01:42 -0500")
References: <20231109070310.GA2697602@coredump.intra.peff.net>
	<cover.1699569246.git.me@ttaylorr.com>
	<af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
	<xmqqedgyw6jv.fsf@gitster.g> <ZU5Z/Z4PcdNP5U1r@nand.local>
	<20231110220142.GH2758295@coredump.intra.peff.net>
Date: Sat, 11 Nov 2023 08:39:58 +0900
Message-ID: <xmqq5y29uqi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 764A9B7A-8022-11EE-88E0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> I think dropping those is a bad direction. The point of adding
> pair_chunk_expect() is that we could use it consistently.

I think so, too.  If we are adding a helper to avoid common
mistakes, and if it cannot be used in some situations, then the
helper needs to be improved.
