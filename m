Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029868;
	b=x79H7+byS+8vJtj15dP8Xth0txBgSfq8WiwhKYjA9i3nqNe1TJO2UHEYTdnNErDGGFQF
	 +aLCJsVo+LmfNKX3U1S9ONg4JjpsUz+sx27CBnI3BVtvfq33vTyldMz3kMJkig13tsUed
	 TSXkwTNvS149OLJR5+OAOFiIBavyCrdbwNQtqz+PRA52cOtUigPu2M3wXkF+E8WGLEcQs
	 2YDRsIi3O2xfF4lqbolp6IEZyovf/Kb1BLxLcrr4X5MsL7ivT5Euvm90uZAit8sG4voLG
	 Q07PfYgZgfbsDea8egxfEAv/HmF7FuPYQ4NBdkD6P97kMZcNdllLQLBfyzf1ex4R6hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029868;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oq2PLKsf6nKwdGlyP3IOxmRi/LU7fKum9CEj0ZjwU88=;
	b=koHH1QvkWkErEg2QYNXukleHklhXoj7y0f4/5uTp5BrX9QLrVmDQX1Nf24jPHYALNuzz
	 iqdkiolVGSHPeHIafi3bFWZnxireX+LigPnfEGeTVVKjxYZcHP54xyYiHv/+WotvCd4s+
	 EZ1g5c0BCEht9smbP9kGujmNG4StARTr/doh3nJmcCtel8yW7cfKu7JhOiWACEOFKTlnv
	 zliHVfC5GbiCSFJtZGsG7QuusVKHExNwJiXE4TLR95tti1QEzBHaKO5sP6z8JsLKHRrrY
	 Tmtw89misHV4r/swYxLdmdLKSihecyShUwhRmVQKA4FIxFcO1oBD/R2oHfvYpB+pw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oHdBA7gM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vHKHPm+b;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73872606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73872606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oHdBA7gM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vHKHPm+b
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C2E3E1D003BB
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:51:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793029867; x=1793116267; bh=oq2PLKsf6n
	KwdGlyP3IOxmRi/LU7fKum9CEj0ZjwU88=; b=oHdBA7gMVAQu5sisgrlhkKctZO
	IKPvpDVcsBcvOrPy0gVfIx2T25yFqDxWVZWOsnxG8eC0YiWQJxDoNDTCCWuhaorb
	Sw5ER+s9XHh6sRc+5LQT3WiyKevfGe2URXR9IVqW4gGmvSF3G8L2MXnX90xMi4e/
	hhnCz0Nws1auYObPaXEe+Vr3BKXggbmgweajh0QopqapC7NHGBLAPYuLWa8551uy
	jtJpC4sPoZ5099gb1TMTVwxXH7pfW9PXpfgl7hVg6LSEhmszDZAkvA8U2wQB0wyS
	9sAEAQyn5a3vq/TcW/XrAvmGLKI4drqTAi7DeQLcUdzinQlBEJHYKRtMlX0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793029867; x=1793116267; bh=oq2PLKsf6nKwdGlyP3IOxmRi/LU7fKum9CE
	j0ZjwU88=; b=vHKHPm+bxSYF96AqEn1AFZZ9UmyAKRSMaRW+659ec/oUsIliK9z
	Y7XhmZl56ClfecOh0xOBoBaRRLOYuHbUnUSUFmiCx+rVRyN0zz20r/BxAWB0LIFn
	MSyEssGJ/LDfe+EKwt5x2x3MmZsgM2Tzhw98jZG5Xs8LHznFoQsG2SbMzaNS4pqV
	sjbag52yZwYPqHSGIa4RJBbGtRlS0cYqJmtDLrjN5Ucm1VvLudu2sw7XkPK1UDHU
	Q3EsST52gXjwAvJug2Yt2eW4BK6uikjdFtl0Zf37m9F/EbmDP4DfSl7E01Rec+H6
	nb4AksOo3AR+QgB0I+f+FAtsr7onZU0H90Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793029867; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:W8uEln8oEK9QXIOwqtCNiFJMdcVIpIww3RvJrJntvqn87Ng
	zT1e0kg9mLqi6fy19d4lexkXkR25E9m8azzL8HkH2TUI5dDkue6FeJ7TI4e12BMa
	o7uRKOy1c4sRGDK8GynY5MkRmYbKftCaDiOKKc+Y5NCIqXS14hNreM3uXfgTT7uq
	poPSCim6QZ4laLC31aLjU1YiwI70aGG9Nv37wokYIc4qWPnexglgJKO+jhg6iGB4
	p9RGwMaFXptZLh+ZckhbtBZlifgaU1s+GmW5Yf29au4WHUpmL+OiEXh9XADwMTUf
	XQuEWly3CP75kpY0jr/9+WP2lm1atrGiYqWouhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:OwPgkRGmj1346YFErRjidlnPdebxoKjY4SM3lq42FEA=:+VA88cZgZIc3q+cuTqdjxFaF269nrKXIEykLE8RvHYo=;
X-ME-Sender: <xms:6nbfan9mJ3yls9R3H2GqEfoBmasM4qaNvGBfldkt0qlcFkHw01_FRA>
    <xme:6nbfanb_YdkdBbUIqSgRgodq4hqxRNEqWYU6byd6v1L4wrX-GPifvD9ttLIA0cwKG
    17xcEeT_v0BMBcEulFePcd4oznSS3hKBO-InjvvguoiO0x920zh>
X-ME-Received: <xmr:6nbfau0jybcqDh6l5Bs8L2rQGYz-SvRqF6t5h03N2p40dYJffRB45IC1YPLX5ZJ711D6hRbq4h1rGKEJf7VEKt3U2vk7Vaf1vprv>
X-ME-Proxy-Cause: dmFkZTExevQgoDr1s6R2jVNvpzxONSl9MUlagBY9VvoOlJQCxQ18p3OxWixTmScsc7y8WL
    /D/cKvQHQbGdJiCbR9ka4RMl5hI2Ei6e8RAjTK8bGmL2GgENku+J0FPkNU3MJ0cG/nfvD7
    od7JQvlPIXz5VvjxWfWpZwTPUySpgotnOykCPiH5BLUUDeIfJ1kvgmfi4UWEdXq99uSjgD
    LT3tzi3tPLeNpbT8pWFRRSLK5YNsapMpHP3Ng2Tb51u6YelvHslMK0VfrxRREzXv7ViRN+
    CPW6M2nhwIkCjsrv7m5eJ1ycwb/7+qsaMgGsozea+XyJ5+Df2gr+9vyT6f/qinBRZHzsR6
    vgvtJq7fd3W5Czf+jG2mogMhmS64Aw938AEz8B3PigwewWzZSMXyD8+CjB9pxMkV/aNyV/
    fdARhMMudPRXrIXhnJdouHuxNpnjRkVkv10gTYpG+JnOU4pca4BvUlTGFk6SboMx6uYAW7
    7gcWf9oTiDp9zrQegT1wIRiJ/Sh3AaTQ+gMb1GEHrQcOX4epVwORJn1+KP8JSa9lVx0yvc
    J5hjcCBihmuSV3kRK6Rg2s+bFATJF0sM+tVSAVS5UdHV/xdGnuoa7RKOXpoDejAN5OwWq5
    m8kCelRgvyivMEzL0paHWeS8OmQucHAax89oTgIRVoLURWdbTVmee7Hrr9EQ
X-ME-Proxy: <xmx:6nbfaqapVH_NJ-StIFiwH2qUZXWcPmaz7sunP4r-EwCsd6crpyIAAA>
    <xmx:6nbfauIu9QZfvkfMZOYjlNHv9m6ip-IFOIjvzBbSXArU9Bjg5xdGWA>
    <xmx:6nbfahEhDAK576LK_HNU8rM-jwdz4Qnv_WyoBk9fPrS2GPcLmSoM3Q>
    <xmx:6nbfatvQkwxfOgwDdStdI4NQVZM_eLJlCPRsMJ4EJn4XoTLcfcd9CA>
    <xmx:63bfaoiBVxDeJUaXCyyN11axdReGp0o3YajTzpPfS7_97_BnPXIUMitd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:51:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <af521f7f-b05a-487e-9972-b8cc2dc02ef7@gmail.com> (Phillip Wood's
	message of "Mon, 26 Oct 2026 10:44:31 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	<xmqq33ttxw9h.fsf@gitster.g>
	<af521f7f-b05a-487e-9972-b8cc2dc02ef7@gmail.com>
Date: Mon, 26 Oct 2026 08:51:05 -0700
Message-ID: <xmqq8q3ktq8m.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/10/2026 22:15, Junio C Hamano wrote:
>> 
>> I just encountered a case where I wished to configure both refmap
>> and fetch at the same time.  From a second remote (let's call it
>> "cabal"), store any branch fetched from them in refs/remotes/cabal/
>> but I want to fetch only their 'master', 'next' and 'seen'.  I'd
>> want to be able to write something like:
>> 
>> 	[remote "cabal"]
>> 		fetch = master next seen
>> 		refmap = +refs/heads/*:refs/remotes/cabal/*
>
> That's a coincidence, I sent a message earlier [1] arguing that we 
> should have separate config settings for "what to fetch" and "where to 
> store it"

In other words, "what to fetch" and "where to store them" have
separate configuration.  They should be made to interact correctly
and the current patchset may or may not work the way we want.

What we need a separate setting is probably what should happen when
we do not specify "what to fetch" at all.  One heuristics is what
this series proposes i.e., "what our local branches build on".  But
that does not have to stay the only option forever.
