Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199094;
	b=aCi86AwhzagqKClNYbXSaPzABinVF1NTx2a4MaDd5tebJF21YRmmbBw/QlKmH83UU9lc
	 T/jD/QvjYZp3zKWcr381GxsN65vLdghmwmn/bnbjVfIop+V7UJakMYWS698EudnxthBtP
	 JYIYLsxb0/kd3ipxJkGjFPv47zqOl7PUHYl1v5TphnhNLJwLRFdzMlakDDKrLfFit+IYd
	 0eSGpJ0+Q17agwgY5fH9SG+OblXfboazc1upgM65nXR2s0ByJNiEpT0ZsTnbWpeZpCSdZ
	 ItCJInkLpzFpUy8bHM44tR+HP381/TkovjYhBuJq5ixJ90HitutbdYMFX7B5M5lGG6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199094;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xdRJTNAT6y13+jZmGBYDzkxd0sSIbr6FkWIE9HamXEY=;
	b=L45FwHaAfCb+c2DsdbawX91Qd7ibQuEiQRQV3JZ5BjcoF8GxaAJ0guff9igS/KJA0erA
	 8lLJNAdGYtxGeutDfnUa1T/4JBwrRhAU9xfmIq/queh0mAXqPRPKA57iiMmq2GLvHE0OG
	 RwEJYjxiOe0M8aBadT+jedDpAlaZLrJ73io8B+zVCnJiuezn+9m6hHFcohFa/52HC5IVd
	 ogbZzdnX7zWplEGXYlyVgc5pTlHa1uXtOlHHlH4O81e+dkawcXYXAnAnWgmfzGVZ5W0+v
	 cU7w1BUoAC14qLAOu1plfdpS1ezaWbOHDWgsrI3RTkD+p1j2nmekzsCD9Bpa+sUMMPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MXjTplm4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gy2uZcWJ;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6867606A333
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6867606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MXjTplm4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gy2uZcWJ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C7863EC0A58
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 13:24:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Nov 2026 13:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795199092; x=1795285492; bh=xdRJTNAT6y
	13+jZmGBYDzkxd0sSIbr6FkWIE9HamXEY=; b=MXjTplm4P0/rs/LZGQy2UXmwYn
	pjzW0pHC5jSOKPAxu4bmZQCn6kye8UA34yX4Vf7xbzbBTIGXL8iyfa3NGqOELqtT
	32ZVRizOYi1cbc6FB20kkA14j5FyNinC9YInARQsGVILbP/4LQy4rafhIMcwCx1J
	jn5fJk6z+eTCcyWJVlsnJl3n3xlJeunzlo2RVWReQ/DGJVKBCNF/TQYKOhtJAHqh
	rWYoxtkPwI5ZEhtSh84OrXgHVS2vVeD59qBlzI24evwmVLRYxG5Q3+ZFae1jWMzS
	BojynTDI2xuRrTLx6ScBiEtIvUcv2ytcs1aqsl1JnIuIzd5WatW5baE84OLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795199092; x=1795285492; bh=xdRJTNAT6y13+jZmGBYDzkxd0sSIbr6FkWI
	E9HamXEY=; b=gy2uZcWJpie6tv4iMyPSBNwfQqPplXFBeZmQkvUQHIqGEIa7KNl
	k3+uUrocs0TMuX4gtY4UVW+DPQH0hwTNtugDAQ+KKKuh384+/iDIJh13qLLewYfT
	wYbAF2USeI8dr9R4QuWVLSP95MYFpDRPB4hCL21ZI4rnQX7GMOMuVoQNHIhajqPP
	bq6bQdxo4F4HdBYcX4JyQHEeMnB8DuTfLUbUiCNJENMOrMM4qURgCDMbo/QGSRX1
	wuudmQgcg5KqUYrO6WwielrrURHlauixcHJ+D5pMq4smJED4xvf2pm5qrHKLVYII
	nbOnoaskchKIFSdpshT/p2pWlI6+mXh1IGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795199092; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IVf9a+8QtCF3hTOGQHrjumkierdXYTKTFOfZxk+CF9+WPS3
	E2+C9rdpBnxpX5L3n/VxZ+dor0rNtsB9fovdtLq26WW/OSgamMXswp6oxbRULh7N
	alkR6P3u5sRLgdmeSLzonATLhY0yxFZaRWcvFd/jTWZ53eKMYNHiGcqbxP2ul+b9
	lQlPjrtT4eYdqp/rsq/WaDqdU8iuSHtQ/NxpZv9LtjM6MU1iVj9XnNwhqxG0+7sK
	t5Y1A+dGtX+bDar8W9yHONYWnojFghEifMj27tLG3REImanLT4Vq3xxHphduBGxT
	vcESem3zj8icCpbnV5DKSiMjyFhrwxLURsjKRqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dIvJHiK+kOUC8iYY2+cjv3+Mnj3Pu3HJndHAOpvH3lw=:l6aD4pyUTE0PlSFvpmC5xE/er6mEbN6HDimJ9cuAefc=;
X-ME-Sender: <xms:dJAAaweCdPDY-oSCDPXVvRnRy-8lzoqX3q_6yjbIjGnlFN2D_yqBmA>
    <xme:dJAAa5NnEGIJvX4hTT47cZJiGB4VGK7hUHlLSeYnaq9J0-50ebvteUyzBJpmpVr1V
    _QqHzTQJDamxS3B7BYYXbR1JsgLv0Jvtv_gR-CZniu_lDLTXI-7YbI>
X-ME-Received: <xmr:dJAAa2g5eOHDus7BTEBJVL1B9jOtSspt-fS-UbxAZ7goo0HUunHxQeNfxoUe89zgVTWfD_lYo9kWz0guygRHoc32-peHmNl5Ee-1>
X-ME-Proxy-Cause: dmFkZTFv5FRvLBh0bNQfqUbfVRScG/Hee3FcMJ7cltbxuYlPjnBOu80mxSFxwDcQhCTZJf
    E+S9u2N6q2BN8+RsaXhuwC1WJRSI3tLi+vMj+0hyWJV7vHBvjR4ggUwIDDUjFk9x+GQd3m
    XLT56zUZ4Sq4hG3zmAx8nB53VvYJqlvYGTAz8V2UCydzJOXl0b2UMgcluKEStBTtXbu3AN
    K+aq+ePdzeGAl0b+qXItPenHr4fOuvTXCffWU/XKSCIfdn5TDS3v0dkp1ZH8Ho4mKOciW6
    DylM09Ai+/rbLIbWrqqAgYyv2u9zqJlp1Hf5UzHDXpQPYGYqoSdjVCIovVSRG3cqO5vvmD
    1LpwIfRRvBPPE8OFImMjQ0esqFMxum1Rhue53SVqh/A8aYczY45BAfQGZF67bswiTpibWR
    E63uhgHfjrjlksKbX8esxxxYfH7qUB+j3jR2/u6vbnv9k3RfCjxm7oWsONdsU7aeSvZWlB
    4Y4B4jiWn0HDg1CMyLTuktsXW5fV3fstBdY3Mq2S+qvTBsSb01LuyauA9vlJq5BKRISapO
    qa4Q6KHSlXYLCdFZdz/24d61UXsJk8XqszDKbX7ZvjOQl+rBQwJlmPIprQNxx9Rz+C5zDW
    YqoZpnzcrkcmNrtcHjuwWbHbUnWqf5BLlSEEj5sW7byXB7uemNr8TG0gn7CQ
X-ME-Proxy: <xmx:dJAAa03vw_in93U_3aNrt1tCnVQRMT0CuX6aH6_XRQN2gGZlqr3cvA>
    <xmx:dJAAa4hHqQJtOM5HjX8pQQVfCNHjtqvSrqcwJaxjm6XsoI4j7ncMrA>
    <xmx:dJAAa8fyTWhspuR8r6NCg71ZaQBZHAvrHRqgrz9ActRl_rtDsANelQ>
    <xmx:dJAAazk8rlpFKYh6D3LpeZmED7hSxVRcn_WG1CZTuPZiR6DhOjYvOA>
    <xmx:dJAAa6AxssSkzvI72SqMsMpTdW6kjnefRSZbUT4OTgK2PJZpwhhHPGCC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:24:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH] doc: update README file name in my first contribution
In-Reply-To: <pull.2495.git.git.1795194253192.gitgitgadget@gmail.com> (Ophir
	Bleicher via GitGitGadget's message of "Fri, 20 Nov 2026 17:04:13
	+0000")
References: <pull.2495.git.git.1795194253192.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 10:24:51 -0800
Message-ID: <xmqqbj7jqs24.fsf@gitster.g>
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

"Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ophir Bleicher <ophirble@gmail.com>
>
> The translation notice in MyFirstContribution.adoc referenced

"references".  We refer to the status quo in the present tense.

> po/README, but the actual file name is po/README.md.
> Changed it to po/README.md.

Have a blank line between the observation and the action.  Write the
action part as if you are telling an imaginary person what to do,
i.e.

"Change it to".

> -localizable. Take a look at `po/README` under "Marking strings for translation".
> +localizable. Take a look at `po/README.md` under "Marking strings for translation".

Looking good.

Will queue with commit message tweaks.

THanks.
