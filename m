Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805057;
	b=CwAHgEzC8nmsUJsTxP2eDmF9Lsx2J8jyeSTN15HLT/j2fZUQ0S1It9asn7QXbQ1VRp2j
	 OsEpe7Wyy82FeRmvPgPTFxpvmlTJ3t1EfevCbsNjeRrUYT7yWsd35ZzzOFkw4/4Y/klc2
	 ncXCoDIK/FTwpjEyy35OhN5G3abN5Ktqidp79OCIhVbScCQP4gDEbwxFEequXfuW1+W7Z
	 bEWMf83zCPVEKlf5F5vrfr+xC5hIcq7vbdoAs8+z92IFfG0dQU/lLIdXNmW/CSRr/gRoJ
	 Wr4+zklwM/VysqQRM6a9BNyekBvqxmdBVFBbva9VKOvGyyuNo9oAyyX1E2k2xzSiORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805057;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=n+SpxTdl/5m6H3oT4rJP3h6ByYbRra3T8OArQf5Hjno=;
	b=IGMgnfDY8EapalWVRoGqWDAGKvpoC6xLrDilsNaRQUeWY2RIig226+renhY3bpyUP2Wq
	 8wMFGPTvVFn+VSWQq8cKy/VzlF+FoKpOx3bZ2nPa9Ajzih9hx5HOysDCWFw+D5ZIalu4Q
	 MN9YJ7AUEMqBmFGPnIJ4BYO3rdAmLmcnFMcEhFVTcZ2OPFTgylQ3lAF/YGULZIv9ahFUy
	 nh7VbUOAfoximqjS0OnthHPqRKI8UlYhSHFuJFksb9ckW0eV/6PcMqLDqXmexTssnW1tT
	 oNALX7bpNd0nCQ9jMdcR/wVC1oXKlPejV8oNtvDMfDAdneUKE6vgD9gIpiWQNPQ0FEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RNPcVX33;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1E8VOJU4;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AB606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RNPcVX33;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1E8VOJU4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 92EDBEC0C30
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:44:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Nov 2026 13:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795805056; x=1795891456; bh=n+SpxTdl/5
	m6H3oT4rJP3h6ByYbRra3T8OArQf5Hjno=; b=RNPcVX331LKw6T8f7E9M/hp5bc
	z8XXqy3QYEIQD1xLABCksL+PCbzjnCVZwx3PQcgYSpf0LaSz53BZujVpKA2tVJAq
	zGZGp9uJValK4eWrTZHN3rgCR7h3ftEgtT5UP4HPQ6rBwEQm5dzjpghywN3Da8cG
	CnUPb4Vz/+Y2yAlqKy4T/AB+IiJAAoO9Vj076J3yhQ6DKWDNMiSh5PmWenNWJpQr
	yP24uSdzkMs0Elb6K8imnUGj2QiRxCmQjoRi7paZdJoME8JlVeyFrsO05/5dTfhY
	HQJZv6OfV4Tv6jhkFVyY2KNF9zvQ7RFmyHYoB32ZUcey52JDfDz3n4gBHPJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795805056; x=1795891456; bh=n+SpxTdl/5m6H3oT4rJP3h6ByYbRra3T8OA
	rQf5Hjno=; b=1E8VOJU44c4ADgw0lysBeGaGr/4Cf0TYlN66cfRX4qYSky6JrH2
	DYGp7iUbQ+UcMpSmVLfwxUuk95HzC2D49pX+Q1G0exB2qMi6FCaBMtPy+KQjH8pZ
	6Dy2X2h4JeupE6gvHubUdA6LTMM862K2FZP1kN6WxM78c70PI2cpz3lBxmXIMmgI
	YsEg58fy+TYNtqH8gnm791fdQDSB7D+dgAVudD47zBdNf6qd4cM1DZUFVffSKieF
	fWsdiTKuGHAYPg8GBPdaISDb4EDdzkypmAXYBea4pmgLaBF081JjFYCrAfjsr+xs
	hrZ6eC+lZcHbdjecxhyFI5gshg83nJV9PIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795805056; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WSg7zCzeFWI0zddE88kKxRPzbrkE6NbhpgTvlVYfxh8pOUL
	8AbIElzYOnOI/rOFI9L3Oi3evIXvMyxWJtCCokiE6ENuIQHLrw5Lt4JYr4W03Eok
	9QFPnDQU2b8oycb0rkCHytKkWX5km/3wgcwApYmDBLL7CH4QPWG+L3aJtpICBH4i
	xI3dgpPPMaXfKBFavGIf1XsdXFMtGn02eqgMJzdNiG4uFgR8wfGA5aghQHgVwj1V
	uU/7aWk13Sy7ut6ACVeSPraN7dx15ws7vZZIf6GxP9/cVa3rYCqsJDEZWdyeLllv
	gCd9vz9lGCC+DJ5gnYMIRk9iHC115ftGeT5pUAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vlgjJVrsK82Ufs/lNPAvbalXvvs3ek3lyt8is7S23+c=:PQJ69it/3j01kDCvl7Tz/2zz1nOL7hRF4dY5gwaUKo4=;
X-ME-Sender: <xms:gM8Jaw6TERyNEDGG4vRux5gYc3djXiAxZXUs2t0Y99WI2LtYpTkSog>
    <xme:gM8Ja4wXr421MacppaMfdSYjWhsc7aRAdWLspFAKDwdby7c19E-K6olRgF4Mw9PSa
    lWltnphJ7QaipohXurLL0wLaNt_H-A7bP7vS_iYbVZ9HXo3M74Ze6w>
X-ME-Received: <xmr:gM8Ja3xh12LbKtJLz2phqjXjsZBufSJZEzkbJiDlFY0b1MpOsZGnkQWWrF-vJ8M0VW7C7qaBQG0gL45wE7x7H14EKrR4sAnYfliGJjQ>
X-ME-Proxy-Cause: dmFkZTGiBDW+fAx+U59m5UQ2pXFU3/OHsrGYeLCbU8Z75vx3g178cTEKT70I3Np/P1noFK
    FcsdsBR0k8iHONUOJxYbQyEpokZg6T95/eRHCglkD3shWOna8d4P8wf/Pd21FLNg035JzA
    zu1+h6C8W/hCpZbZW1PbsBwkNkZ9VOa3ZTaY9FUJDkrnfqc/U5a6BgWIbK9sbsvY4ZXgSm
    tEP+dYfwZgv6insy2tJcLyakfMIEWd8YPnlDcasYqeuUQ278MuFCgua6D1ON4S78GwcjvD
    uI6oa34yNnduGhKfPzHLLdpw7ZgBq66Saumg8O7pmdbZod8FVXhkkVQj+zKt2UMqbrEXIk
    0Sd+kJR3e2iUlRRWKCuLQj5yYxYLSUWRjHMEaaIywOSETjphzs/wLiF+7FycYqbMKVVFzP
    VV3Im9w0wk/stvmzm7BvN2yN4hYPfBjVGBJyRJXMBwdLl7WgjF9LuqSPDE09E5dP+oqODq
    ZTvn292JFdfWFrk+dkHGrPsqiA4HFge/JJprgelDA0BQ2GZlgyfcIiUlyU6PtfOjeTIkjO
    2ZPFw32FIbo1l+rCYzeaHLOiJtiZ9iL/Of/WfO/Ex7M5WdBND+m0JwCtkoKSVzpTgmDqlz
    cTWY66k1VF5KgXUf2lb/eTOZJPRy86CUs18P3ioj1H3zMw2MadXcHTpd/b0Q
X-ME-Proxy: <xmx:gM8JawwUO4Pu11kLrfDqyMiN-jHpDIAglUM5_zLtAKI0CvrXGtatgA>
    <xmx:gM8JaxYOUAzFmUyOkDWmK_SKy3XNKo1PBCAr773c4BtUAf_SdXiORw>
    <xmx:gM8JaxUdAj92XE0zVS9NDR_Cv8TUkHthGvMrrwzejXbuKz0ZfNiveg>
    <xmx:gM8Ja_iHnBXnygGkgjzSZU7KOUMCPk0bDaKZirxeu98ofO5rjpbrHQ>
    <xmx:gM8JazvgKt0CU-xiJRaSwVZdABS7Zh6JRNF6H0h_vmCvIPNbSK5UIpBY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 13:44:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin" <bupt_xingxin@163.com>
Cc: "blanet via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] read-cache: hash the shared index even with index.skipHash
In-Reply-To: <5dfa732c.94b8.1a21d16a974.Coremail.bupt_xingxin@163.com> (Xing
	Xin's message of "Fri, 27 Nov 2026 20:59:14 +0800 (CST)")
References: <pull.2337.git.1795701443098.gitgitgadget@gmail.com>
	<xmqqld6fjt55.fsf@gitster.g>
	<5dfa732c.94b8.1a21d16a974.Coremail.bupt_xingxin@163.com>
Date: Fri, 27 Nov 2026 10:44:14 -0800
Message-ID: <xmqqwlpy8681.fsf@gitster.g>
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

"Xing Xin" <bupt_xingxin@163.com> writes:

>> the most from skipHash?  And this patch is breaking the skipHash feature
>> for the use case that would benefit the most.  And not hashing the index
>> files that are not bases would not save as much, since they are expected
>> to be much smaller.
>
> Per write, yes.  But what skipHash saves is the hashing done on each
> write, and the shared index is only written when it is rewritten,
> which the split index is designed to make rare.  The frequent writes
> are of the small split index, where, as you say, there is little to
> save.

That is a very good justification to give in the proposed commit log
message and also in the documentation (the behaviour may already be
documented in this initial version of the patch, but the reason why the
base index ignores the skipHash configuration deserves a mention, too).

>  - index.skipHash is only ever a configuration variable: it is either
>    implied by feature.manyFiles, or set as index.skipHash, by the user
>    or by Scalar, which writes index.skipHash=true into the repository
>    configuration and resets it on "scalar reconfigure".
>
>  - The split index is enabled by core.splitIndex, which neither a
>    feature.* setting nor Scalar sets, or by "git update-index
>    --split-index", which stays in effect while core.splitIndex is
>    unset.
>
> When both are set in the configuration, there is no telling which one
> the user cares about more.

Isn't that mostly a defect of Scalar?  Such a tool that configures the
repository without close supervision by the user should be responsible
for ensuring that the resulting set of configuration variables gives a
coherent story of what the user wants.

But by going the route of your patch, we no longer have to worry about
these two features conflicting, so I would say it is a good direction to
go.

Thanks.
