Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093808;
	b=sfn5H4hSvwhvw8cwhLaqvtLPIb++bjmDE+Z7D7UkEanYzRTy3rp9NIYYru8LpWqnQqAJ
	 zJiF+J7yO3wXDa2RbmESDCx3ipi06oAewpV9yN7FaDur2AVW6tUlIcR+X1nu1rFPtBz9I
	 VUpKOKEc4sYDE9JGxw7qu7HK87K0iO0jRCCg+3VNJFlAooF01N4X/Lb0g6VctA1kuoyvt
	 IuvXf8iVHz2fvZWQ9i43xiV6eBSMH6w6qwyfjYHpWwpG0iYJn/b5VJkuSqPoAnrTc8tos
	 lcfLhe3leTC/JrGQjMRKjY3UXX05LV6uxbnoVhYtAKSIgQDnDKNP8/mmis5AAsThCHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093808;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SxoHI4oWxmowHPKzpm2Kd/ZDvV+RNUwEU73OGM9Zeg0=;
	b=Yn5eDozAIjtu54WL6PQ5Y6rQUCBf/egcfWFj+gWDUhCVgF2aii82UlxFAXGocHVepkYL
	 ZXnMLQm8rdf010fOK+jhSEhJ19FY7rg7S2fWUCsYXhbzB4SW0s1XHH/LOe2h1Vl7fSL7Q
	 ux2jwioOrWa+ISQ0ZchXVfprYuqXXuGb8YA2TvjoAhQp8rjd6ur2XJ6bX+PqhjrPvOkuQ
	 tN0Lh4bJcI+FHItn0Qd+V8oASeOfmOImx0+xhVJaY2KnuajyrGZxET1pf13o8p49QdPsT
	 EGlwgfWptnttnQ9lxPXCOspzCv3yMNs8BCZaeZf3WPIbrabebHIDUk6s0yTAicRnTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hdO9R3Z0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="ldr/4rjo";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A105606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A105606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hdO9R3Z0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ldr/4rjo
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B95B71D000DE
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 18:23:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 07 Nov 2026 18:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794093807; x=1794180207; bh=SxoHI4oWxm
	owHPKzpm2Kd/ZDvV+RNUwEU73OGM9Zeg0=; b=hdO9R3Z0dj/TtwNG4vL4HZ1h2B
	I04hZYXCwQO3eJIhtngn9X9Pld1nCLKbIaoeAjwhX493vaXzUL1scqydi3HZ24Mz
	yETkR3EkVv1BPxUVDXpV8v30ia1h/FEizP/TDzg4y90sPlRJwhOfc2VicEZyUELQ
	RYdiOhm04zeWjfULZP0B/CEtFPYJ5WFRgLM5CoBAAHoeV/950ixnxxTwj0znjgHt
	6UY8rXxYkDdPeWPBGGgdsgLm4seHRHzqsmkHEEgrIPfGb/mLpDmL666GYZ/1I45n
	mvvUKF9W78gp6q6gDJurZgtY0nfEWtmlF7xiVaz7doWeXdv/A0IIhsj4r+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794093807; x=1794180207; bh=SxoHI4oWxmowHPKzpm2Kd/ZDvV+RNUwEU73
	OGM9Zeg0=; b=ldr/4rjoCatVzebBwFXvILQRp2hy+XkrbuvAUkDQHnBXlK1tdWE
	/SNdu1oD6Gqen9/6T0IwDbr8nSj/ChNfWtM/93jRCymnoHVBkFfnh1PqZ0FsUK3h
	rcTyB1RgXDWfuSh1MYXPk4ubYK1Pg61OCbzs3jQ0Ma8SYsbR0YROGfrHuZjSaq6l
	IBh+KPAXa0RQ4HJBv/I4V41L9MRSY7Da94FIVI34pkPxEW1sfnEx7PlmdTwgSx8f
	VpPvsHu+vV4gvnEjYh2kPVtNZQtfPZU18Tv1ecBJZkjF1zlwi/88PsGlD1UD85U/
	3Q/eYznI9lh67ERPjTawcELABoodryAEZhg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093807; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XJMyzPVMA5k+tEX2sCdp4vTk+bWkfNcuq4vnvpw7737OLXp
	JEOaxo/VTa6dubBWe844W8Z6Gyk5z0WIKRYC352j+2cjw7xUBmgmEBX34sN1lmaS
	R/ti2mMDIqLQd5ni+l0Jl5UtBF0F4vL3CttXlFQY8nI1Hb+N8LpQGoqGdT2jTYPB
	8q6+iNec8p4BM3CMpphxcFpREaHta4ZaJrTv8hqWcfsDxYSZKzGizsnFs7hcF89v
	I/Tse1rdnjUmcyDc89qb4tXzNRoWv3tNm5xZvKkv0EsvNSCMxrrnEDy/JL43Wjyi
	V6K0C3TwR2ERBkI3k5emDJ7fDRs83wNojhsc1vA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:E+XXjYSBB/AcwZRePCfeonPwOCspMtrmDh7Ne6QVQA4=:kqoSRKSygGpTue6kwvT2ndpomqW5hS/7f4qtOE13xYs=;
X-ME-Sender: <xms:77LvarkOyH9GIzzI9Q_lSbNw8egCfvMsGF1dAEEoXueQdPvJiia3ZQ>
    <xme:77LvalthIUHJKyOlFxUaIAjAsR4h2df8gXWaFPbhreLqIqZNe67QseHVhMhb2Y9Ao
    bEsLx8boDqPVIcAvO0Di3GFUBOcM7_tTypXoC5F-JQko9aHKaLL__g>
X-ME-Received: <xmr:77Lvap_IpAXTvinplwRh1NuaZQyJCC4Kgs6wHIbwZs0JqKZmJrsIVzoxAaxtO1851bo88LRIrQWdicFfIbZepctN6xZeDTM1fux0>
X-ME-Proxy-Cause: dmFkZTFzUL/oqbkjknCFSob8Co8RqyfhtNiOH1N7n0NmpPSDYKb2dYu1J1xwKkjJ+cU7i+
    OgRKVj121Ah3eQcKOyWw3pr5lqcY+WF+6PFxZT29mo5KLYsC02FTphXceJNHTXjhcG0L6W
    2LadCl3QZoEg8GUwv8lznEuf2ihNLofiY72mWQOXWsXbEmUrJcRnQJm3ttGvGRiMk5WbIo
    VrAUYtxsu+8fgiDwykJ5amiTZgBbQrjzHdczFE4YJdo+Co1nWrDO2ABAoc7fObOn3zBHRw
    uNl5kPY3sMM0syWEfGDVXIMNWAD242oEHYX8o1eZMP6RLaEuK4RtOPLarc/G0FzjPpkKIS
    8RoLv2O5cSx8kjLhWqPdai1aUFbYhRjHy0WOFTjuY87hoBFa4llNRTx7SR+5u6x+TdrMtA
    3tVkLbru/5TXHOiDDDgoXXPLkE1CTzO6Udv0dNgHCrRSoyu1qHLH+8xIlhPP6r58kX7Efy
    730zqxtZQxU02ElfHX68KyHu5luBnCpjId/NULbIjdhakHaT82t7yTU7Ow7deFrX+YP/J2
    dLfADpNXoSQX7ctz1sIxpGi70W+Q7JlaB0L0CVfb4RJ5cLImRaOHbCNnpYjNcvpRUXlMRh
    3hl5TBFVtgWdPATLiF6ooSuWMMmJFJQ1vitdYO6/k8gLLGjkt0nbEbAoCktg
X-ME-Proxy: <xmx:77LvavNvnc0YM3rQXG87M9FstEECSSW79bksjSVQqDSBlQo4pTs-0w>
    <xmx:77LvanG5tiGT6siXQEAoKz1ypylig8ctBmT8roEnNa2glKunguEc-Q>
    <xmx:77LvatTUkHuiu7oAPTO2QmFwU4E_lUYgZohAm9vXKpimW93SCJwSSA>
    <xmx:77Lvakteih3OLc4zkyWnzbpETUvd3bnZvaLtmX5sH5MTqd9hL8nA1g>
    <xmx:77LvaiNc8HXUOwgP8-dOv6fZWIo7O8nJ3l8gFPYtU6da0e6vxzfyMPXQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:23:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sat, 07 Nov 2026 14:59:22
	+0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 15:23:25 -0800
Message-ID: <xmqqjymo8bv6.fsf@gitster.g>
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

> Open question: is patch 3 wanted? It folds "genzeros" into "genbytes",
> spelling the NUL byte as "NUL", so that there is a single command.

I would suggest genbytes to take the value of the byte in decimal or
hex, instead of av[1][0], so that you do not have to treat NUL any
specially.  I would actually think it is even better to limit the
input format only to [0-9a-f][0-9a-f], i.e., two hexadecimal digits
that does not allow uppercase to represent values 0-255 (inclusive),
without support for any other input format like decimal.

After all, this is just a test helper, so ergonomics or flexibility
do not matter as much as simplicity.

> Some other decisions that may be worth pointing out:
>
>  * The buffer is no longer static: it used to be static so that it was
>    zero-initialized for free, but now that it is filled with the requested
>    byte on every call, a local buffer avoids shared state. It keeps its size
>    of 256KB. Smaller buffers made no measurable difference in my tests, but
>    there was no reason to change it.

Shouldn't matter.

>  * Invalid counts are still silently treated as 0, as before. That could be
>    tightened, but it is unrelated to this series.

Shouldn't matter.  That's ergonomics and flexibility that we do not
value as much as in a normal program.

Thanks.
