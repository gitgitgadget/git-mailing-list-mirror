Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656877;
	b=RLkOVAx7c+/7YhjDKhoxuyzQHRE3eiNZU+Xjpna+lIy1f9tXTBOna97MXrGF7dsP01Ru
	 gOsUog4L7JruBwiHaWYem9abhpcodQBFqtyXCELO7cAaDzNz0DviCaXbIjRquaSKwtRC8
	 YzBeIAibYjrdym1fEEoP+3HqRQvuaNmZjOfCaUHP9RoR0qNYIYI+/WozF/72XnnHOzfKI
	 YWL2ncGDB2vBTg+xIZMTO2a+skG4BYqQOOrbS7LHu8jcnHP0j12YCHyJX8nklNTuizVWg
	 SzwMkdydREPYIu7AaFbDQwWQvkhmtkRwqt23JTPANGI5CiYZ16MlWZ3dsBDbgwlj+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jgMz2qbHCfdF2APOiU8mzCdP/zvQcwUmN5TjALnro34=;
	b=shMT3UxgRTZrAnjNckH1YpDh5hK1hkVnzqU0iWbCu1NbQDrWogTO1MRPZLo6ngqCVgxV
	 i/9taT3GogAmz6HOW+btQAU4lwxo/Jbwv8259XnmrGpR2PmGdpt/j4lPpfiUvi7Hlcpff
	 rNPe2RBAj+l7UAduv1SjC05eRelABHBN4bQfY9SBWMbHXMtlNjHzzBoRPsPa3OteiDGhC
	 2p7LPXaxRna5WOZoLzfHZnTfTDjuSzbS8Us7CVl5zAIK9WSg1o9uH83NcdNOqsOp4Tvmd
	 mRZChkazpnMX2igAUnXEQvWZv6CrBb7LftXdnswlk8lZqSFMec5PdOblSM+7vDVodPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="MrMJLp/l";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iJN0O9Bq;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF7606A32E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACF7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MrMJLp/l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iJN0O9Bq
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A5991D00175
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:01:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 17:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793656876; x=1793743276; bh=jgMz2qbHCf
	dF2APOiU8mzCdP/zvQcwUmN5TjALnro34=; b=MrMJLp/lrMNFDRjMk0FRAVn+6E
	2Ha66cRXw/ztIPeSSFBZY5S9pTf1nA6QvxwP05LVjq02Lyl+Vj4XEM5rbdRZ9j/M
	29yhB7N296CpUmaRcKgl7R2di0AVJMNKJqcuWCxV/aMJd6tT5HOgYP9sh5b3PdfA
	W8g9zJhF8cRMbradXOUKoU3uJQ24dhomD+KEvbUqLwNJ/BxEaDVPS23/UOanih9P
	7LsCYjAymKFYCniw/sGsayYXiOK0vuFd3T/aoldajfSEOJA6px6VnVbXajRHHTjI
	C/8fPrYDmNOCBeJEot8mIxlnpIBFNnpD/qZDyliraGX9eVnBzWaVVV7cXPgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793656876; x=1793743276; bh=jgMz2qbHCfdF2APOiU8mzCdP/zvQcwUmN5T
	jALnro34=; b=iJN0O9BqefF9Eyi6lSXk7+mjmLkEhjx0/PI4KCwfX452Zm1yHHU
	9GY5S7/dv19CRolT7MrijSaz9WgNVn+F2tyWywp1kuXrGKAYWZU9SqnO2EObN3ug
	Jhtw+nufAMWp1dFTq+0Aapkp3KqCN1pnfYn+ao4rU0Nz0CbAJMFUH2bIt45paWYX
	3Zt/dRElOpr8TvVi949LCPE6z43fxgxEU5jq5iS5Y8fwuDL70/x+ygR2AHdX4DPr
	w20WF2sGojPSmGGGfn3p82lKmsI1UHR2YofQM0jEA5YEl91TUhxd9DZ6WZek+bWN
	84TynWCaYglv5zQI3J3vLcesTcZ9c5/kkuA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793656876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EQpAdOSLf2O3v/kU0DmeeKOBuNC+ry+PGPEYMhobMKIQcV7
	1Y/k2LtrevnJ8RdxV8cVKUG+j/Qr4MQ1C+v8p+siWUtZo1wav/pA8sJn8yPMfY91
	O07TAV4RrC1wvdgIyoJlbUaB4bGQpNhzIsN9GOKCaeHzIWbQMBgEbfQRMtu2D1B9
	CpPjEhASj1Qqs2rEVgM4F1AFn3JJ6kpGg7PkschxZmF8sU1n+K4KOWhx7iwKFDYl
	nl1irzXd6M9X4W/fo/n4HelFatkwG7ILbKAE/1NRoXKX1Cg/rsfC0vCcfBe0Rvmf
	Do2hyj+Wbte2MLrFith3nviRUcaV4QSgFy4jplA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DLC4mjEgcBBzaUY/rXA5KpWDGudn948/N11bkEcY4i4=:ExPODBo6RIQ3J3dnNzwplje4A89Z4mtkaMprqVROD6Y=;
X-ME-Sender: <xms:Kwjpan2LG1w3l2nqg9wSizMPk7-qfIpvltTOWf6eRL_yAdWPaHsYNw>
    <xme:KwjpatFyd1e_DJsQZOHGXnG5ZkWCbIrWaLABJSoF2VVJyenGvj06uV_9y_2WF5O8-
    BFV4Ze_QtMFyh-BKE0cKK6cHgE3FWtGafeKtl6mwHi48Sztgvn-N9I>
X-ME-Received: <xmr:Kwjpas62mRNLgP4GScT8ob_sFiRsNphZeHOFRXzFbxmFOjpIa9PF1sSwX4NIyy5OSWqSK2PjILKN3vVM08PWpZ1Es1dTYRdD0YZQ>
X-ME-Proxy-Cause: dmFkZTGYE7rQ9p59Pgz6xRGlOT+FXghPyu8/91yOxYjlcV473wlLUW7JCJ59rvXqhLelKT
    2IM3bdM5NWgZ7fWqDUiM7TFYL6qfUftL6zbXO6aASZYUGMC73rbS1t5UTLQKKp1JeHhpLY
    6mYbLnFWOuZcwyxHbxJbymRtxfiD5rJpcXNeM+/Rsm0Rg4/d2c+bj3Cgf5AeINFhbfJqwB
    ge0JTs6tBxrWDJWah25/e6M0Hc7bkwRGkLrAuvp+hDbeUEZ05hTosYfRrTTQooJGRxvF58
    QgYrQXcRPI8C4DDqdVQKLRrN6ZVFcYtbI1pfbbhQ1MVUW32qeMzJHM8ILrPOc/Z7CmrDMB
    mczmc6oNpyawDPFbl95eIQN0EadrWLqSFQhhbBTbMnu1io4rQxODcEqa4AR+cFgluTc+Lo
    QPvo/+I9v0MaRmwERynPoKMEmSn+6FDpN2bfF9qxbyIe9N5fCVhL1NRKLHW9ER1qRmkc8i
    RX8B5Ogt56DgQ0BhUrKJi6+a8M/mxl66yJsaoW1UeIGgFmMLMpSOGcKDB1wBkYmoFmhSbk
    xOACNP07PS2eJ0UFSmHEsa/Ar6FwmXTqqFlButqze0F4f4NffOXZkEavFr7jI9WxbznHaX
    5FQ/ATcsRi8xP59LVVuiHWcXfjk84uPF9ccL79jFfCNV4D8Z432HvqreVNNA
X-ME-Proxy: <xmx:LAjparv3t3X5LNz_3-0J6cW_uRSuO3qca68MW1sdlVyldqhZ7skTXg>
    <xmx:LAjpal6yi5_ObWq9dTtMFma17A0Jz0DGZw-2zdHze54oS6ruawiwww>
    <xmx:LAjpauWz-bGOY37UkMf_LdWCyN9D024DSGx9q0BiEzZsT0_8UTkhoA>
    <xmx:LAjpav9p-BNV8gGx17OE6_2zqo78VgRpx8Qx-tQ2iSgtsiamD2GcNQ>
    <xmx:LAjpaoYqanc-iU3KQfK4r-O19WsDFnnxtyGYcZofofW8fKKxOnRZODSn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 17:01:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
In-Reply-To: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 2 Nov 2026 11:05:35 +0100")
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
	<pull.2401.v3.git.git.1789458703432.gitgitgadget@gmail.com>
	<xmqqy0bblhbp.fsf@gitster.g>
	<CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
Date: Mon, 02 Nov 2026 14:01:14 -0800
Message-ID: <xmqq5wyehp05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> This is more than 6 weeks old and looking at the archive, nobody
>> (including me) was really interested in the topic.  Anybody wants to
>> take a fresh look at the topic?
>>
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.
>
> That's a bit sad. I wonder if no one is commenting on it because the
> code is too trivial, meaning nothing that stands out to comment on.

That would be an ideal case.

> All it does is allow left_only and right_only to run at the same time,
> and the majority of the new code is tests.

One of the more crucial questions that the above does not answer,
which very often gets missed by AI review bots, is "does allowing
them to run at the same time make sense in the first place?"
