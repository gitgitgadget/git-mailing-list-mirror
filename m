Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438867;
	b=SJxiTVmYqMYllI+kxwxHdcuW65fMNlFN9B1aS+cxLjezHFx+7pBtZmpKZZcUhhW+n2vb
	 bjmTUbDX+bKHdwSCxPtb4z8aXyy+/WSu3pRRRLhRIZd99+EwD0r9ghC61UU1MaFQw6vYh
	 6QgJlr+QMmLJ9ZPyb8aDOAQk6i+uZCRyNKkrubAAMbygOGGCN0MDq2vXqNsVHKRp6JeYK
	 S3jkHNf2jZofBNG3/7jDqqHpPJST2aX2gKKwG9579YZ/tURH2IuElV+BNl10+fbZYGfkK
	 8ROqRJWdzXLcgx2UXIgMuwXL9dRL+VnB0ccJV9JBeqQohyrzsYa8go/AZAZZskIhBWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438867;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+uxVh7YGHbtcbIlox935DC+x89VvpRzQj0TYAHakGv8=;
	b=4QH77kXhk2OzNYietOU37FLOZrRTvG1zytszDuvzllluzdI4KxuU6LgWAsh5CfxTsb3g
	 5c6uOEAp3TFc+SHjFMp30hW/XulxSuzYtTpinCWAe+bXWTULwM/XWtMXp5LT/IVie2V5c
	 R5c/UkzkjuCyHRN9o0bCPHi3zj0ewEIzO8eVBx7B6JNRCjaVvwAIfsv8+2z5T7TPur94m
	 TP8UusfD+Yz5UzS6qWTeX0dC/looFLnPd+yzFyrROgTUNHE3mdCnjENuPhjj3wrbq7gfF
	 6c5BZuZ/IJx7nQ5u1WY8zGZVl9x2Q8MHRbqxGt7hGiexBfckx4zudtoaEcd7g1BozyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=i6DjEoFe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FYLZ8jKn;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A1606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 23:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=i6DjEoFe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FYLZ8jKn
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C93F7A0207
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 18:14:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 18:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794438865; x=1794525265; bh=+uxVh7YGHb
	tcbIlox935DC+x89VvpRzQj0TYAHakGv8=; b=i6DjEoFeaJX9MWUZ43GfmhJEjn
	1quIQUSXm9ZJCrxA79iiFT/iHHXb/wkx6xUZLfev95C1vQk7U5mSz2HlUv5MjJJK
	IyzZtkQFBJ9U5FMlFJ3hwj2Huu9A8i7mADV8PHMYMqz330CC77zsn/Ytwg9Z48NE
	Jva1TYOr82gW6JGhJwfMgJY7VQHLHzDplbUJb/q1Navpbz+4xBTub/PjQVDf6nyQ
	6AUEQxf6QhbeUcNjAa4xwpI/76UzLLiXOjtKwgCQsawD0to1Z0AEQWhQzA28Lqna
	NJtxeRvzxHIRqXPU+BqgH53sys3O7PfIfMoxGWveokGpf9b9L42THSlHbdag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794438865; x=1794525265; bh=+uxVh7YGHbtcbIlox935DC+x89VvpRzQj0T
	YAHakGv8=; b=FYLZ8jKnSZFUVXZIub/Nsd/Xc8PLD6OFwKwwXi+9kUP6vT0UOOd
	GnehsDwrmSV/EekgIQk+8kaNjHCHy5ugSytVseU7taYNVv5ePzEvXzyQ6Z+vURyH
	hQn/0X/jh8/27mQplJT3hJWHK2iFaxF7rwb6qjHFAj4E6YZPYyJeCwgdWNSUpaV+
	mP9OBnGb8phhaYz2rBGSIqbw/473EWhgM6BU4/rLJeQVJj6EsBBQIAdej3iSaHSX
	6ZrbHX6Bzy6mOyGJ37oMmVuj4Yn1WhTeoLeEwVsFn0Db37QesOllx2d0+oDZReT5
	q4O6/jEMTYRO4TUA6jJU6Z8QHHyZ1T728QA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794438865; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:H3rASrNWlksgrcn4e9DQ2yJ+iu3CGGsbK8chJ1wV6BOKG/9
	RQS7R6eoxPmYO4UPguF7PCmf5tExsLTd2KoteysmLQNtBmSlzt3OkikC4+WvX1Cq
	4WEeW5afM1yeZl/fAVvMzCdYk3Rq85ZP2No1/4og0eZLcKYFTczSDWQ9BjZJvIHW
	ldSQrKw0i/llAUJB1YC+xsZCQfN1RwPQ0HUheIprKle2YqfpmXcJRx1TQl8w/qv4
	Q9ukMP1BlTXtC+wvO82t0f3eOK1wEoPf2b1oc7uuzVIQFg5OgIw8qppVpp7sw59G
	5TM47bbb4QSzDgafc8+gjruNw+PI7GI52KHcZYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+ZAFuerORLmEPN1bVdKBXdBpIVYb1Tq93UueEETRybA=:gK/H6L9S1KixAk/x8lMHPM2xALVoRDQi6Ct+kWqWOzw=;
X-ME-Sender: <xms:0Pb0al-ojurUytOQZ7iAgn5eyHAAIhlVX7gL_LhnTVa2I32wRN-3EQ>
    <xme:0Pb0atZLCJu1PVSS1g-7yBYhhY7XxS52-7lptfvkUtXziTv3-RRthWF6XxxFk7vnU
    5wVKUtpf1Z3F-t7MI4zEc5M5s6vV6Tl6JlXANwStuoRk9JzrVjYVZ0>
X-ME-Received: <xmr:0Pb0as3otTyPERQeHGidMnHj_VC_ezo6XgAEnUhAOwe1Nk1Kp0q8uJc9NqWFx7e6GrLestlO5GqreUL8A-GmDSqMK4rjZkj3RZlv>
X-ME-Proxy-Cause: dmFkZTF8Clpw46ez655AnCr6BqsFcBqyuR5y/JdrVoMqReJU+gSqGMvnfjhg0FRVJLPbvn
    svqlc0FZNgFuAsIUi2ZWSH1DuFazUejcXMWD4x7zZkwS1CA/LDnWoHIGO8JjQHdWdVCoPs
    SrIqzoWgHDOYmTmdr2VDUSS6YxXxi7gBCOIld0YFZ35EspAyxrqatzE0enbKOIO21NkC7w
    6CM6f5rEoqHOLttLp29XAFdJgSUj6770PCcociLUSn7J/3MMYha9wGU5QufhkgBxGRIiqr
    ENq+YAJ/6V6ZvfjugdypTTZorxMwjMFRoVFJxy7letcSoES5hPhBa79uMzTbhGVsEa2fmG
    FxOWl9b8XJ/DyZUvRpVjC9jr2aniVrMnVDemv1yZS/ZICUns3gMSfcDtcsm4ufhAUgRWmW
    eJMqyPnehaNMM8mBYAV4QtI2+kMrIa3HUcNPTEzMdrB6yqSMnp2BfwdhvCtC+nkVADCAgA
    H7SimetaAeZjYbhwSQcl6jngmJyq3X29TfJaNPVi5i9axN2IqO5N+XLymdTF/CMTUHjNy6
    aqpMbioKVVqIX3Cv4OG1ZXV1eSyJz+BRv8vtn/ZS+LEuVVknx708yJ0bNIpX4xqt6pLP3a
    T5hy7Bd6U3jfRufAGaJAzdBcwWkQ0EkYbwKS2P2EEAewN5/2D/8BC1ZyZYjw
X-ME-Proxy: <xmx:0Pb0aga9hY9VV2h135lWB40yXJFdyoFnKAoBokLfOcmAJWZIo7IbYQ>
    <xmx:0Pb0asKuwh9o34T5etp6_PMvLMce65s2QZDnbo1QErscsklJiDSTYQ>
    <xmx:0Pb0anHT7lQ0d3kHJ4WUkHHdfn_qm-CzsSuZwkFSAaJZp1EYRFjmFA>
    <xmx:0Pb0arsD3LOlGCDQM_xjrRWOadS2q1YKqiCerhy3PEgkx1p9L58Ehg>
    <xmx:0fb0amiZL_UMh7-WyJTVC3fcfGJc7DuRZpiP99qhltMYdSCCNDtbGdzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 18:14:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.v5.git.1794432869488.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Wed, 11 Nov 2026 21:34:29 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v5.git.1794432869488.gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 15:14:22 -0800
Message-ID: <xmqqqzgrklkh.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +current branch. Internally in Git, `HEAD` can either be stored as:

I am not sure if I am the only one who finds this phrasing awkward.

It is not like HEAD is stored (in somewhere) as something.  Rather,
HEAD *is* the container.  Its implementation may be a file on the
filesystem in reffiles backend, or a record in the reftable
database.  In either case, HEAD stores the refname of the current
branch, or the object name of the current commit the HEAD is
detached at.

So, from that point of view, I would understand it better if the
above said

    Internally in Git, `HEAD` can store either ... (branch name or
    commit object name) ...

or something.

> diff --git a/advice.c b/advice.c
> index 401d047391..8d2c1ff1ee 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>  	"\n"
>  	"  git switch -\n"
>  	"\n"
> +	"Run `git help detached-head` to learn more.\n"

Shouldn't we be using a normal single quote instead of backtick?

Existing references to command in this file has the command without
quotes, on its own line "\tgit merge --no-ff\n", or uses a normal
single quote as in "... use 'git add/rm <file>'".

People's terminals do not grok markdown anyway ;-)
