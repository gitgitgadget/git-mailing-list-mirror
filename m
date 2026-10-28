Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149721;
	b=Fnoe15D/Bpi3EkffAElJoylg2Dtt6KsXRMLdB3QB2vfpBLuMZ9P+olbdf/34lDdgfSHK
	 bVhRtG9HE6GYmSLMHC22yG6wy3EMWKFiPVijeb/LxSYz33KNtXN3c0Hl1GGLyU77Qhwda
	 ZRrorzRg85XecmhB2YAkot1iUHo5vpX6M0WSefR7ZOVHjvlVhilnDJHseHqAspJlxFsiR
	 CEjfnaFkRWv/Ockdhwn+Rywtz/wsqpq0YAhzRqvysWuCZWmzIu+Md+6MqmXevO6RGDenQ
	 ALDWkZc3tHyG2tvQ9b8NjK0nIEunWakZuPmPqnnlHa90rEYjkLSFSo6fUp3s5HNgXJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149721;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LM2WfhcZuobf4H8qJ2Sw2YTpAYDlXBryUsdPSR7pnOk=;
	b=bBwT8QLzFPF3k474n1XaA2BOVF3SDb9NEhQqQ3P03RbUU2KGDxgDLD0/8Qaa/EHd2+NB
	 4t5cOfnOk2kBiO848Aa8Qj+94lAWn68taVDYmBBBh1qvEDZ875wEnrntQEWTTvqdxbpPO
	 a8O7+InJGJFobFXboOyXktxzcwjcBZN99IxLDDIr7hL1oxEpY8b8ajnii95cypHDl467r
	 RwIUcOFD/FZBOA6FswAg4hbC35NhwcAwz/An6bmw+eb3rx+NVZDx0QYXuxPvX5oyn/vrX
	 dv3xfHsK3RSjIu1ZOfnHq3PleZYfvGYBehbvc5sOlxkfYFCRRfboKzt/9tk3so55rFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A8X9R9qZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="J3QWTK/b";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88C606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 01:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B88C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A8X9R9qZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=J3QWTK/b
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 856001D00132
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:08:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 21:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793149720; x=1793236120; bh=LM2WfhcZuo
	bf4H8qJ2Sw2YTpAYDlXBryUsdPSR7pnOk=; b=A8X9R9qZ5b+ygKus8st+ngonVq
	vZsFA9IYMAWZ4oTYwx46+mWnHTYCibuz9Gj8YbYu931+/sWvP2mD7/i3ozcIaavQ
	inZeNeN1/kxk7GoDhrdaqDx7W6I6XN8puQ/hB3CcEWNOyEPGv7+j1TsuFOxhZRDL
	0/69D6ZefLNebmu5kBom01XIb9k272oYiLMXeiCZXU5uxaH/gndxoUAzWN06tzc1
	X/2zFjYCE1tdV6pH1oLa1Y2e8g9kIi/DXj11resHnKHz+heIyNqfxYeb4XEcOQQ4
	JWxMCt0PPjvkLTsTIn/uwa5ESmFiwvGvUIZqwLTln6JYCjVVwlL4GFH+PzUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793149720; x=1793236120; bh=LM2WfhcZuobf4H8qJ2Sw2YTpAYDlXBryUsd
	PSR7pnOk=; b=J3QWTK/bgYshjJwwjinJpMVpOroK9/5t4aL7kuSeMrVeTM9V+Xw
	PhskomLnWhU1qB4en+89nlrOtiBX66IXS0zLCiyY0IUTpE6rc041cnJeD2yHaViZ
	K28B+GLeqbHjYxI6r4LQ0iCD+XuMeQ2z49YG6UksnA3BGmMTpLxKmh/A98LBBkzi
	uIFWAGnSwjqfPKCZJx7tcuB3nFzBtXcEKGbZPMCX9UHeXAR/1NUhkFzd6XSs/yvf
	U20gMpKnLUpB6863K/eQVEz2GI6ts5v/pI9lTabdBRIFj5uvSAmKblRtfuVKNnXB
	ej+3kOhavBUcx+32wzMPu76sBFv29wEG4sA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793149720; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZBHAhsLohhYsihJBruzTwy/CkzGiZ9a6zYNO2u17fdOy5PY
	DCopO+ghdDteW5EPlV7O/u+1EiQ0tPVXmUC47UMxIhyPtdIxL2/MR3rAgMftvJMq
	J9RyRVnj382cTL2ttZ371IyR9mLKR1fmAnS7TxFOsdOVslIslmVJpDc5giDiCTLv
	q3+eaL/mKxzi0UqXtCDlARA2gi4DUll049rlq4P3myc0sU7GpKUgC9t1Z8qcSS+g
	YYmz/PAQ5Z+5ehhCWzlCweMXmq5i5xhZifJrR5RlnzK8+mdxpOmT14P8UVZzE1kv
	4q/Y3BWAnZRC3S7NcH1ZE/CvI8ucsYzTx2JEKJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MJ3qKLsRkUdawCMCE8eNwINssoFQhBZfPq03LU6swgs=:6MuU00NWhlw3kWt6NuDyBR0MBRBc/BioP5qYOsZ3HUE=;
X-ME-Sender: <xms:F0vhav7dBY_EdYdELmOVjlN9uVOxdTX63Xx7qj5RtfS78JnbPgk5rw>
    <xme:F0vhaon6igy61Y_HqPqRCl6ENY2N9IbyYx4QDHgnN_yiQ08jFnijqzRY24C_8DhoG
    Qxuu0-Uomo540-CU2muvxGUGr3YuGlGm7VaA7P4PP9Dl4bKx3H-ebE>
X-ME-Received: <xmr:F0vhagQdU0GPgidUK3vq8O48TSfipwpER40PJ89dzbrinbSsHzZ0iwoua8z_MJrrMyuycTgFtdtgnvRdPsIHloXWQ3EjkJitOHyZ>
X-ME-Proxy-Cause: dmFkZTGodCj/EXxdkHffASHjZvaO5vSWg5bGQp3RZXwbODgZBmcZ/mWRDEk8lpKVuqHhDo
    1kp63rEul26yVs4iUxROgfFu0jVJTALgZsrksHOa01crcrEp3XaSIDrGFbCdDsIG9L7kbs
    VsuGD2e/GF+PZO9OnasN3zsq2Py/XyPVcCKwBfpnFYUTcobn7/nfnuj3Vz2BX0NTzS1dTZ
    nQJg2MQ7Qun02b2ZxpTHyFcB2jwbr8vfwVXrQ4d1J43L4vNOviGXG1UQ885jD28/sDm7vD
    JIcz3M9t5nORUHigUS3p5YYL4DEfzB/0Br80vyrsK078QmijryXlY8EXEeJj+iZU2LxASm
    D7UygH7tGzNsdbwSaRZONWheCA62a4Rxs82mSlZ1CW6gVjlYLzx4/dUy2w35+TmFFcKzJK
    lIgigRQ92xdBRFbqW1C/HQIsY8GuvLINlP2YH/gLdj3OVDIO92xK9lxq3WMt/VhT4LYw8K
    hMvsBoi7lrlgv52d7LlSkOKqfZgjV3P2IO3/5pgFNdSUSBxOKw3ceUyHam2EMpaoTBkTKL
    FrTNFJJVvI4n/DCeKx8n1YubOUzo/hFuTFiEtl6xzEhJ4qoDuqf94Nvk1pvuPF5fw68gFI
    BtcB3dxEuW/Jjy4N9a8SinQS5fG5Sq+hB4eVPaflm0EDY+P+dnMjMIa2oYvQ
X-ME-Proxy: <xmx:F0vhanFiEpjixKtCzYjXT2LtxcmxX2AMFxjBPfr2HDMSCGgIgPiX7w>
    <xmx:F0vhalE_52hv7QiV6A6G_ytAnFOxQ7TSXSHEU7d3q9wKItQ-mNaOBg>
    <xmx:F0vhalTaNJl5jk0XSEAhmxIfKWo6f2wDG9IHNkTNdFrSy-xMebOiEw>
    <xmx:F0vhamLkIOPx_dVWwvYPNsSyCPyQ1TRUaX6u3foqEHAr7iXxeexO8A>
    <xmx:GEvhaiCl31J1-2b289F9UyrM12N_Wz1WkajgrF5d3vanfqerffLq5V_D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 21:08:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
In-Reply-To: <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 27 Oct 2026 14:00:12 -0400")
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
	<E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com>
	<xmqqh5i7kpc0.fsf@gitster.g>
	<CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
Date: Tue, 27 Oct 2026 18:08:38 -0700
Message-ID: <xmqq33tqfx7t.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> There may have been other discussions, but the discussion thread
>> that directly led to the said commit is:
>>
>> https://lore.kernel.org/git/Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de/
>
> That historical context is certainly useful, and definitely explains
> that any work in this area is fraught. Still, absorbing a discussion
> from 2005 as a requirement for making improvements might be creating
> too much of a barrier to entry? idk.

I do not think I ever hinted that it was a requirement (which would
have meant that an author to post such a patch without studying the
history behind it was somehow an evil person).

But now all of us have a readily available reference to the earlier
story, we can make a more informed discussion.  As I said elsewhere,
I wouldn't be surprised if there are many places that pretends as if
ID or Hash were canonical terminology and confuse readers by being
inconsistent, and we should address such discrepancies as we find
them.

Thanks.

