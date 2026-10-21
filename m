Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621249;
	b=FsXn2nj3iPmA20H9vZzrY5fcGlPnBB9aPihbe6qN/oEgL4YZH/amIbwqe6H7L6FM+D8r
	 dKnf9uBjy0iF8z0RkdfN/E377QpXLpmy3Sve6aUsWAsAg8hwPVliriJ/CzQwLFzUffn5b
	 oK83ha2NX9705NWHozpwz1nDd/UiSzrv3jZ7o7FsAct69GzsurvsPMyTHkw1jY5qXBLYE
	 PAEFZJv6K18oHCBFmpxrEZJ6m/0I2ogOeTOdFbZrgw6CErFflKpoVYcx95AdVJ0dKBftx
	 I0hiK5jbOWt6HPrCksvr4YEZrnmr5GtRp9SeXwDVwkMbVpT6MhkCF7b0vOe/cGxTbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621249;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=S2ZnThq/4U+zkRLp0PY7PPPGNAqnmWBeyFaVn3dgUBg=;
	b=bSfaM4hAosIqomC5lbAffoOOqDahFoVi1oy+KTtIs7djsn0PVOsK3KgNge/S1Z1Ax6Uy
	 uhX35PCqizBhE8nCvhhYdf/cjOh8sLB+h6AO0RaxP1LcbH70PyZJ2SbhAghHqC4haJ40a
	 i1cC0wkHExwj8GFJKUIy6sKaieYFNOKQnVkfckL12jldvQOg9eCAfUDN5WKzs3uS8zk3Y
	 egTWhJOoFbIpYHb+WvnakzluinvyPdoOQS6ydCGpvYQZQBkrMsQW1racgSzxhRpuE5UUR
	 gI1bqeWy5aCSjxfN5eJ8nSacNVH/CyAmU9GEeUut0fNHE8uO7Pw4LO1U+0jNumA0cJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QjRqRnIt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZHrStyGz;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBC606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24FBC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QjRqRnIt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZHrStyGz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81D347A00E1
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:20:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 18:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792621248; x=1792707648; bh=S2ZnThq/4U
	+zkRLp0PY7PPPGNAqnmWBeyFaVn3dgUBg=; b=QjRqRnItD/mhX+sC1IB3cXydB0
	7Zw4PZxoScXI8lSzfXdIWTaBaYjE6hU08E3/1lY2uz8WYMC+jC1WCFgCPS2nmkN0
	YSqBaKnax6Ofce1bMpq5es5EDy1pt0F5r7ZirfxFZyofMtEqTeAQJk12vSOK/jYK
	FYtWsDrwfMiDPgbOOeGeS4qYbx8r5croZqE8rUaSdPaRWcvalQO4hn+6AXo3KCP6
	VFqrMug72z9PWsBl3AVwvvzIgTPLJ1dlH7WCB6vOMErdGIudjzTZy9r2NW7gWlQ5
	UeBjj2o+HOwHlRt6Eoz6mrOj4mmDN2ujzclX7YLupise2LcTN8sci8mq4avQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792621248; x=1792707648; bh=S2ZnThq/4U+zkRLp0PY7PPPGNAqnmWBeyFa
	Vn3dgUBg=; b=ZHrStyGz7IkWyhDO+J0oYCYFiGbEwWmnlJZ3bPFEDUB39qwpT8b
	fhgT4IsqcETsBTV2MfKgBAUZAtX6IBt4ZKVsJRFD1qy86/6A6u/IVN0pP4ECVeV1
	4pCkQRgxJIk1Z7kc+4swjCv6SdnqwHX/50QH+G3/flhBSai0Nu2FsfujH4DTh832
	dOfiGfdbKOUxssUVPljnMJF5DLgXGNeie86ETH5QKGZSwWIGihlkpIEqiaWWF06G
	5wZZ9cYEKyvVuUiBzeYPRLhTfZGxdOOtyPrLeRTsa/NDRxNzWehE9UoMvnADW1/f
	iBee2YjUz6YJ77CtSWbgvC4G8bUHqNSfKQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792621248; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:emi2pEdIowe/eWTpI4aut0M9vqY4fqfyxKiYn7ojMq+P0v/
	YUDNiqENYUeG5fjWE1LokD3sE/5IgUi51vR99ZGf5vWTsOGg6Ou1nYPfAsy/GSfX
	/eTCezOWJMlUss2aBW9+oAyqi2bMOC4JijwQg2cN39gm80oTTcN0ZpM+q8Gkl754
	bL2fbKw2UgCyEj+9lHYmWtrsiGig8hs2Ye3UrTBy+Lw3NVeEL69HkbTX5eX08Oln
	XnGkAivBUF5LEquVy/8lk/2LgTUgZV8foHsovDlOQojo+s9iMwX8mG6atwobbGQC
	qYW+yJY14Z9CUr9Bv7M4/fcRDAtFpM5+nqxqsUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6RHQR/HDADNfANRDxvTc5Z6UOD4keIFvQsQaI+Jkg1s=:fZvRSGWm/dgy6uDVty/AGT2ZwLZo0K+qkuJqTKcORsM=;
X-ME-Sender: <xms:wDrZar8TmAVXdyEc1f7HkzZrhneaOtxNDpVWVqW01kfBYWUEcEPz0g>
    <xme:wDrZajOVpHxPJVLhWMi2_BdZVy01v3gySv_X3-GRdN9IBxgaaIkpXelgRLBn7pW9b
    JuLS-JP5GoBgGB2Q3NSApfrxdQKb8-1TvNDqpJ5pY9Z9X4jN3mxIw>
X-ME-Received: <xmr:wDrZaveCxDo8mXxf4gPGeFbf_d0mgis6d_p0iaZjXO2sS-KrG8i8fCzMfEU727rhCm3bTtoH7USVk99TwUr17e_GXVv2I_6cFdri>
X-ME-Proxy-Cause: dmFkZTEf0qDGZAKpra9geQxIcE1+6Q9q5y0OcDcMWdpXB8MzxK6bWsmL8tGR7dAW5JWLmk
    imz2+Ta9tAOb8T1oamrnJ41LeWj+OHeOt1VIKZBU0RV2f4cYkxC5J8yTYrNpRZTwJTfGTP
    9ryjF+79gF6WdE25cbfWUQ3DNyOmxeOFlHk2T7BCxgnkSZAeT6lWaiO+63GvAfeH69DjcC
    nJSKBCvcoW0Vb7I3Io26MGPpnbu4clZoXVirwkKq/5w42jOII2eUEgiFiOMhcrF8XKFCw+
    B+dXpa6ew/97xku/RYjPCLcaqqwZHV0mh3xDQ4Nhb/+JCipXqUkj2vKbSYUa6vOpB/qap7
    b10TQKT/ru9I0uwEj2u+rQfU0Lca+lgsbOFxSa21wEjgpA4WPzQlbyVsQ6kxbqj4t6fAEI
    N3FvxbbhXC1a9pgtdcTKCPkRJWEZ11z2FMhzoCNZkLDI+r/kh/g4/L8cdy/Z+3CJ+6CVTL
    UPGdJ1WmTrAjmw7w3OUkmWXTmdICNRTB2fJReWuVzf0HR7RF4YUwM5lN3PLRRpxzMXdoEr
    eG1FLt9PgZO69zzZjSiaJyOcXQj1XrPcWxFf8WgboVEboNz2HoeI/yL+ISbYFVLK9mwmcK
    9FgcfCCZyijTDOObPokHLVrwcZ/QCPiuO++kTAHyxDM0xqxT5R7nPMAiZQJw
X-ME-Proxy: <xmx:wDrZaiVqH7aa3ztjB7I07L0Fzllj4ukGBdY3ztINN6TA27kuXHJnjw>
    <xmx:wDrZanjJ1bgd_1gdt4Fn4FMqY9qTzkjQ9xUYX_zX1Tup_rwUk3lRQA>
    <xmx:wDrZah_g4eYD8qw3Mu3cobLY_sUmlF2BGM8kQw-65ZyffVtGZjHm_Q>
    <xmx:wDrZapaIjbNYHjemMNufN4GCrL5Pk1XNh4KMSTmdRIhFzlxiGvwl6A>
    <xmx:wDrZatvrxNPZLvzX5f-TrAiV7ecHnONKb3ZY5Z77pT6IIu11GdZU98kg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 18:20:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  tsukasa-ino <inoue.tsukasa.4@gmail.com>
Subject: Re: [PATCH v2 0/3] checkout: finish switch when tracking config
 cannot be written
In-Reply-To: <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com> (tsukasa-ino
	via GitGitGadget's message of "Wed, 21 Oct 2026 21:35:15 +0000")
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
	<pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 15:20:46 -0700
Message-ID: <xmqq7bjalmpt.fsf@gitster.g>
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

"tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When the tracking config cannot be written (for example, because
> .git/config.lock exists), git switch -c and checkout -b stop halfway. The
> worktree, the index and the new branch ref are already updated, but HEAD
> stays on the old branch, and the changes are left staged. The hint printed
> at that point was also wrong: it suggested origin/refs/heads/.
>
> 1/3 strips refs/heads/ from the hint. 2/3 makes setup_tracking() return an
> error instead of calling exit(). No behavior change yet. 3/3 makes switch
> and checkout finish the switch and exit with status 0, as push -u, clone and
> fetch already do. git branch still fails.
>
> Changes since v1:
>
>  * 1/3: the test now compares the whole hint message, as suggested by Harald
>    Nordgren. It also checks that the command in the hint works once the lock
>    is removed, as suggested by Junio
>    (https://lore.kernel.org/git/xmqq7bjcup46.fsf@gitster.g/).

OK.

>  * 2/3 and 3/3 are new. They implement the direction agreed on the bug
>    report thread (https://lore.kernel.org/git/xmqqecdjsryk.fsf@gitster.g/).

I am not sure if these two should be part of the same topic as the
first one, or they should be treated separately.  IOW, if the way
these two patches implement the fix proves to be contentious, does
it make sense to hold the change in 1/3 until 2&3/3 are resolved
(and vice versa), or can they be treated as two separate issues?

> Making the switch fully atomic, so that a failure undoes the worktree, the
> index, the ref and the config, is left for a separate topic.

Sensible.
