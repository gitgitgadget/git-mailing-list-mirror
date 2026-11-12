Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511335;
	b=crqDNWCX7eBvnfecZWAmrygzRKUA4cf88/BMseKTiT/ryxqCteq2CyoPxjR9RQzvy93L
	 LzrhqUoRBeg4u3rMkmfy3XjDkFDajoeZeuN6heQgXrQ7SjslnSokeUUU0/m9ubF291FXK
	 Xd5mhxw/0wcbj4ar78XSleW3v+A+Xs01RZjPFMe7C/uvwt/yNZwrfV476gWLlWV1Q/ZOp
	 gWfzvE6EhhIXBOHmxbsf1iMEKN9Y2WfsoaXb+Hpp6RgoJ2NYXCkwMu0qm13yMG3y/YgXD
	 nhbt/ZnRldQcEyYr4EZrDda0EhzGfLNaQo02BpCCPxlIolBkbIs0H7TlSe3xepws4jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511335;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QIDMAy6IApHsw5g/OD4zVc540mO5VeHf+nNmg/V45PA=;
	b=uegp+FcGJIZMjBfBY/EK5UKdNtQyva092eSVKO7Fblemv4NEws3WtzNtkIb/QZZ4IHfn
	 e8EyeBBBK+rSsrYTn4DzeqOMjzlIuvF2mlQBhiFmQXXAldQRTGk8FXt3UdJ6UEBZQJP3H
	 7b1DlQNyJOWkGqMw94xkxMSfCD28S/5kS8JMfAkkHs8rWtCxJ3K9M2KShH+UAKTHIf4jX
	 WKvHU+3LUYzBfnKgk7kchhsZewPf7qyuZM91e7Au5gRnjrPy0MUbroo5mfpvan+Hq1MjW
	 JMrKjT6wQA38NnXngSW6vwlmvvV1NH0Vt6t+QLQIgdwBCfqALquM/1EChwW+cj2QEUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PpC5Lqz7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=phRHj4DE;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EA606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PpC5Lqz7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=phRHj4DE
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D8F991D00259
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:22:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 14:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794511333; x=1794597733; bh=QIDMAy6IAp
	Hsw5g/OD4zVc540mO5VeHf+nNmg/V45PA=; b=PpC5Lqz7kTUTUA3eRQRROJKGVN
	0fRnHm2x3i6/joiluTFizIV9XdIGzpRSpfWNmQ5LfScRyNBy1pA//XqBIM24oz0k
	+jX4RivYYNQMjCkmbA4hpRT9YYC3/+SfxwiWiHRoYVdDYuPj/CqVc4PUDXn9SogS
	9yEnOWktRgEU1pYLSy/KEN6wgsn2jB30J1PV/bf/LPhdRe+AkWjd4+7y7jZJEOv5
	bV75T1hIVr5DOl+G96Y8wlN+vdR6ykxUGduyjlXo5jLNkqgwQ3b1fx/Ya2LlfR8S
	d6/Sla/iB94TePF4uY/cOuChqSR7hQujC6klWkrhUqvpz6Xzx64T3W4ah57A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794511333; x=1794597733; bh=QIDMAy6IApHsw5g/OD4zVc540mO5VeHf+nN
	mg/V45PA=; b=phRHj4DEh6DAmag+LMWsE4p27XA2MnyfMVzQhy5xsEslK9XwJcH
	ktoxh6EhBGsp7NqmjE4aryKWeadLS77uV4Rt5hYTpmf/QCgX8m/Ngo8cSyJbmBlP
	J18cysCTicQEAu0vVB/FhP0ST14eYwwnaG/yooa2QHee47A9l4IBnK4eJPcgY8CN
	CAcdoSzl3rjuuwn5WMzg1MyqAC2FFPP2s0SFEZecxobdM6LGl8g2j6bWBSq2ZNgB
	Me6nZdUOYn0o3hnyrnVMnrS4L5Azs0FtDo1BPV5mMhM7O8JrtwpB3q2EW3nXj5hq
	X/X57FqV+TGtVH9X4JFdkEEccGKAXdDXfBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794511333; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jGAQpDq2Yt0ok9Z/JU07hWN1bhoxVeXWCWmRYuwL6cPsroK
	Z3T+c2N3XjgRKlFc6LNH/xZ/tFXgwAsvPNyxtMLiXp0GyJNuET/Aon5N4St6hpMJ
	UB04+eIjjlmzdWMVEnJk+hQK2NMB98g5p5oZIQu1/m0G49hfEQlW2jXnYPoMa2Rs
	HfcRxaVTs/9F1nLoilMkjLDhIzE79ZFIncINoHiZKcQrjdxA4MCSKc89CQMro/F9
	SS2o6431RtpFXj4OXRkpoV6u9SZunEh4XIkIfuCJeO1MYRzIbV9aeRTMvoiyB+4b
	u9HMcVrxwbPG8IG2tKpfjDWhBBrJX9/07o86Lzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4NywTD+8DgNQNZFUvJJvqF2QKUKgfwlI2hCD4jbslVM=:G/qqdaT+Yp5mlXzLdOMu/T1AS5lAaMh0CYCh4yX1zb8=;
X-ME-Sender: <xms:5RH2aqlURfHc-tJtSOJsouQqGQ5qikwGG5Ub-84rtEL0VRd7M3plIQ>
    <xme:5RH2aovIjblqMjeEc9c1KATK6IsyyIyKbe4rxtwKThatgby4ywjWFAUluGW1zvDmi
    -aZELmhqEeMEZ7XQ_isNU_TDVfkC4bPl_zDkzLjhwfTRR8f0EZ5NQ>
X-ME-Received: <xmr:5RH2ag_YwXCnE4yRZ6bNXy7I2zyi15WM7kukS8D0WNKw22OhrwJjpus_Jbk2UsZXaGwyDe5VtUX8Szp46ULbRHlOt7Y2ER3iQYF3>
X-ME-Proxy-Cause: dmFkZTEUGLahXWUO3LJeYRa258nOvbeDUU7zFDfAQ0kNRjLp7/XL7F1znvjiUPkIG9VgsK
    i35zVCUUI1r5iosuDVsVw0RyWLV2LcNeQ2gtV8+xwpQwRiPC7/5LwEth2+xSM7yll8vXPE
    eZXyTnVyUcLRXhNmlKbQZMoEEgeXNn5EpECFUO3YsDv4XeUuXnp8BYFY4GqeEDckXkVpHg
    5ljPXmP22+M4yfkNSFZdovRwXPWd51F/ly2t8yr0G9YNUtPqXc9smjLXv40nK3ag7oSBy7
    j2vXlklSvBG9FHs3Vqphx+Y+cgKI8wmxHzt5xTBhzYcr1lGj92lBwoWK7XM+hQfmpOe2HF
    lYliL/babZ9rKbJ3nxfjfDMx2cWUa1d7OgVlciWLz1mIwgafIR8oeMAPWa1bf6OfwvMVzM
    TI7zlJs0FSoZRXn0+QFJQzkFE0cM+X81WbfCqtbHLtd1bzpEDqprJbv/KOpfTAGKul1MDs
    oscwYSt/WCEaH1smp2Z+cSvzTvg0dUWq8r+lz17GAuk3mYzpeCnRW5Vvl0Ab6na+TSyMa2
    ixbFuUDq4lgujNQjOWjL5GHy6016HeAD3s1CqGlfxXS2PaTz96/tAxBok8yVqj1EJ8vyic
    c3K9oDUEbXIqsm0rd7jMePnsVu0MRCRC5EGpWF947JboAKEP4KgiNoms55qw
X-ME-Proxy: <xmx:5RH2aqOiG-ALAJsG7JVNggFCHEZ0lX_tgN1CGzPymrF3IWSrHTAh9g>
    <xmx:5RH2amFuPL1_rK7jmPlzZxO4sS6pwqyRboVeKsKXsAzpG9sbY7a3Kw>
    <xmx:5RH2agR_TsE4oll1bITRsG7TOCPLxo1B9QzEk81j2pdspHqvMIk9lA>
    <xmx:5RH2arv0crppAqeai18WsZLOPKfONu73uHNbuduRQjq33QSUPOmsCw>
    <xmx:5RH2atNpy0sFdTInWY79--O6JUrJJjm7AcrDpRxh8mjv-6PHUPlVHjT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:22:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH] commit: remove padding from struct commit
In-Reply-To: <pull.2309.git.1794500044740.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Thu, 12 Nov 2026 16:14:04
	+0000")
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 11:22:11 -0800
Message-ID: <xmqqpkw9j1ng.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> On 64-bit platforms, "struct commit" is 80 bytes, 8 of which are
> padding:
>  - 4 bytes between .object and .date
>  - 4 bytes of tail padding after .index
> ...
> Measuring peak RSS of "git rev-list --all" over an internal monorepo
> with ~4.5 million commits (three runs each):
>
>              peak RSS     time
>   before     ~849 MiB   12.8-13.7s
>   after      ~817 MiB   12.8-13.0s
>
> The ~32 MiB saved is close to the expected 8 bytes * 4.5M commits
> (~34 MiB); running time is unchanged within noise.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     I also prototyped a regression test that compares the size of "struct
>     commit" and "struct object" against the sum of their members' sizes,
>     plus any expected padding. I left it out of this patch because I am not
>     sure whether:
>     
>      1. such a test is worth the cost of updating it whenever members are
>         added or removed, or
>     
>      2. a unit test is the right place for it.
>     
>     I am happy to send it as a follow-up if there is interest.

The comment before this structure says ...

> diff --git a/commit.h b/commit.h
> index 1061ed791b..66a5d245f2 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -26,6 +26,7 @@ struct commit_list {
>   */

/*
 * The size of this struct matters in full repo walk operations like
 * 'git clone' or 'git gc'. Consider using commit-slab to attach data
 * to a commit instead of adding new fields here.
 */

but apparently it did not have much effect to prevent this from
happening.

I would think it is an effective way to force people to think struct
size bloat of important and populous structure to always measure and
warn.  There may be better ways to achieve the same that others may
think of, but I very much appreciate your bringing it up, even only
as a discussion starter.

>  struct commit {
>  	struct object object;
> +	unsigned int index;
>  	timestamp_t date;
>  	struct commit_list *parents;
>  
> @@ -35,7 +36,6 @@ struct commit {
>  	 * or get_commit_tree_oid().
>  	 */
>  	struct tree *maybe_tree;
> -	unsigned int index;
>  };

Obviously, ordering members based on size, not their logical
relationships, has its downside.  The "object" being at offset 0 is
an integral part of our in-core object design (fake inheritance in
C), but the updated layout gives a false sense that somehow "index"
may have a more important meaning than say "date" or "parents".

We may want to have some comments next to "index" (which is a unique
number given to all in-core commits while they are held in memory,
to allow the commit slab subsystem to use it as an index into flat
array of things) and "date" (which is the committer date taken from
the underlying commit object, without any adjustment), which are two
of these members whose meanings are not immediately obvious.
