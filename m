Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639008;
	b=nuHFwcPLpA8xtONQ14QNb08nKBsY3QPvprjluBjMhXV8R6YtmvBd68BM4IYPqRy36Ts5
	 e+yRXLNC6bCD2aAJ9KuZm3ltRCR7hsNlGh7j+4kS9JgXhhlOPSVoWoANJ/nXHK8D1FBw0
	 txE1Pn0I2Z5j5F7234wK4gjH3qF5K28ut4ywSWVQ3AJMf9sMxP7naTDM0xafZnZ/T17TL
	 Uco+zZ8KqT2bgSMQAvlLqjXgLPzCJiiCYDDpm/2hHAc9+bP0ui7MqT2wUy/Y/okVNNMP5
	 QpDD/eP5XDqbgtkYMAeRonC7EUPNv7M1YwcjP+hph5YsPnm/kTPFPve2OOUu+henXOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639008;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jNasaJGoF9Dy4qJ/hPpk3lzcIEdR6jG9X69pdd+SlQQ=;
	b=vAn1tsAq+MTMThpDXldXN6Xc6LT6i4xaTFYdZVaugw7yfoD8aMZL369C5VryhNxU1fqt
	 TmkIngyAcyRJ1yyIykP3sCGhkh9nxKjfXp13zSkOqXzRsE0S+NRKi+VR49QUjlGze64C1
	 2FbBDhxklkUkFTYILmdQiSrezNzeawDFGa4WS4dAtI2TDCWr0FOMvHXMa63w5O0pYccNR
	 HXEGyco0YBvJZ2tkos+IQjaa9lQgcKw5B/EumM6v+tfHKqj2d91NwA7EFWBXuTsUHIyTP
	 Q/fRdiIlnEl7mOB25ooLFsQCELkz5jKK9yx9YbzNh29rxkikc0MlQt2D8YA2WkBEWPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kfRX1oc8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MadLDgWQ;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D19606F3F5
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D19606F3F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kfRX1oc8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MadLDgWQ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 16C661D0012C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:03:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 12:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793639006; x=1793725406; bh=jNasaJGoF9
	Dy4qJ/hPpk3lzcIEdR6jG9X69pdd+SlQQ=; b=kfRX1oc8xV4Wy9ML49zTPS8Uyk
	2MDOYNlqVedqVoelpNDsRnCy0C8UHPXn36JvMyaKRI7MkRqGZZIPIEPovhtumFDf
	Ys3HJx+yaMoqX44Fuc8M9LvNml1Tj7sAAW2nHnMcQvmGM810Fum2itzqg+S7OeIx
	jIM3DWPSyUDMyB4+lrvBxmj2sxJ4ZLxlRHzbYfMYp6HJ/yDhx5eHGZbzh9dQ7eBf
	f7MAdneUNxNc4f3W4TVSgJeC1y7vsiTX0qeKwclXGLzSCF5Nesn6we+WLzDOVDyN
	EqE8efsQFxoCwcUycEwSS0iiMDDJ+2csJmXncpFYQ0ElMAih1dqVrhO9FF+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793639006; x=1793725406; bh=jNasaJGoF9Dy4qJ/hPpk3lzcIEdR6jG9X69
	pdd+SlQQ=; b=MadLDgWQjpgYrLofKRht16it9wGZYl1lMsLlbOGAQDkSbyQMB3q
	uR/flcOzU1xbgpihh3sA2XWfwxOQ+K0Ns5vKqDJesUad6tg7pkOIPVdAqcq+OZdg
	qBApgMkCHV07KYy5PJLBiEOBzhey6s8FqKZdjGHe8lWqi9HL8wIxyxe94O+H4QFX
	7dcxHre6pOE6hWMpcSOP5DXOOLYguhLXnLXDA2AaW+At8MMlfdXCkSVY4dOpJIyB
	UB2lpGXXdWjQ878vm+WPdrfTeyEhbnIkdSclj7thKC2wyxkyhbf725bAYxGVSxrS
	wVB036LW1Iq4WHRvYnePDDXbr3gGb+/wxZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793639006; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LApmTPouyVt0/FdefNskWiu3bo15gnsPviUn7exymcXLXOM
	bVG0r7bGrZQ58sECFKGcbgtjkxYm0gNoODN08OjGCCDbyi+VtH8mmIGdXdalq6T1
	oJyoZWFLM2le83JU1AkpISaC1mZdAxUiHwjLvqYQLXEVAc/0bohVASHoeZzO2X28
	vt3WADFszExxX1g0xQk/+vwTBDSoa2rxk1e64cWPtN75VZdKP49JgmZhJixMfrtf
	q9CwhlPzP2wN6aAByTf47PQ3C+m4THqA7ZARCh+f//ZLX7hqc5NvNnN21ZFsU106
	pw9Qd4FcqSbYbrPpy1AbjLOLy4GsRbt49y26shw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3wkKlgAtpbWsnH0yj5r4yLdHEzF5Hzq/T7sN4Vhusko=:dTHrvdhsmqodPqkV4CsxdslkuLvpEiK9lTkc2VLt52E=;
X-ME-Sender: <xms:XsLoasVW-UAwTWD1EKgm9RbZjxwJyzjssv8jvfH-oIP-tH4hZyJwIw>
    <xme:XsLoaoDnjDNQIoWTNEjz6UFqqLjVfComJ8u7s-KgSeikMGF4StFbM4dRhX_iKaI2t
    Tiu5Cs2Iad8Zapp1RoeVuNmHHH1-wZssScf_F4MCxLBJz9pPTuDFLI>
X-ME-Received: <xmr:XsLoatyZeSkFgjpz4oZF7xDcIX9z4RIiUf4n5JNV_uIK27ITSLwGFgctKe0vZznbAH7af_iA4UPaKbJ6vG6OPseQEmT4m1yzo1Uf>
X-ME-Proxy-Cause: dmFkZTEl6AS//P8g276hz4dNGXZhcQYOEx7WSApGqJtY/p7XBxZcp/WtvovONjWPI+1W3k
    DBiFolj67PRYxORR64bvD7AamVZ8K3ctnIqqQHkB0EH9ljdeCj5nrRiHONYYefsbtAEzm1
    OjiXjvhky5DbvBsbUa9iMyYlQ76WRbShlS6OuQ2lKVxk0P5lsOlLfa8E9wjw1Q9q5X6b3m
    R+58pnwi5gY6EA9Ij3qiWQK7aAsA9i4+akOALd3aHZaujDwrMJ6H1zwCbQjKPQd9wKReZY
    uySlJ3K7gys1/t7EMgdVgXkFCZt851DhKBTHpwZ1LyVd52VSELIiSgGAuKvHIUo4lltcXz
    DTUBg6JCBzooZmd88vmQa1yVsN3x3QLYxmiCy6xMOcMfDwbYYwsIC3eLL4EtoQ8L3Q/36H
    sOufYfjWoWV//6+7aeM3eNAu984mAqNm0HnYprwwSWpzsDPATC/XTcDHAW26H1RbBH8eVM
    0oxknP3S42uAeViPft2MxTZdK+7xdtp0KqDwRaFHAA3HCrGgSf5kcYVM4JKke8OKQ7+/SX
    4p/xXVQ1ZqqGx97cIomLNbdXF7IjDAKh0hFcZso/UzKWwivIs5g4hXGXOI+ntH4Hc7zXiN
    chANv48HjCSaF7TRFGaf80X9yXGIJ8xiCagz4H0KiqSMWlN9cKnDvaVhUwFA
X-ME-Proxy: <xmx:XsLoalCunHCt_yQKUS1z4-5HAAwgUkx42xJhWYLRhvKKipMIUUsWXA>
    <xmx:XsLoaqaTczNCpc0-e4iy2GU3MXvEH1KBt0mUQvNrrTwmUW74BXhbRA>
    <xmx:XsLoatiCdtr6JOUsFsaX0lTCRHx2hYcahlacPfxTDNcwMBs6hQtn9A>
    <xmx:XsLoas7P9to2aFTIlBg6aVGkrO1FLVZ9Lst8CmYmKt0wMy0eejbLMQ>
    <xmx:XsLoasDxloj1E0qZ08GsOZMJz4C10DO443fZFQEeLaxIQEJpIhjP5wWm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 12:03:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <8fa4010d-d39f-4e78-ab01-be3e9d20a148@gmail.com> (Derrick
	Stolee's message of "Mon, 2 Nov 2026 09:20:25 -0500")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<auiGP4XhObUzC9vD@pks.im>
	<8fa4010d-d39f-4e78-ab01-be3e9d20a148@gmail.com>
Date: Mon, 02 Nov 2026 09:03:25 -0800
Message-ID: <xmqqqzh3jhcy.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

>>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>>>  	struct commit_name *n;
>>>  	struct possible_tag all_matches[MAX_TAGS];
>>>  	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
>> 
>> ... I wonder whether we should also call `ensure_generations_valid()`
>> here. That function is very expensive in cases where we don't have a
>> commit graph as it backfills generation numbers, and it may have to walk
>> the complete commit graph to do so. But isn't that better compared to
>> silently yielding a potentially-wrong result?
> I came here to say exactly that. Even when a commit-graph exists, it can
> be slightly behind the object database and so we need to fix up the
> newest commits with generation number details.
>
> The biggest downside is that it becomes very slow when a commit-graph
> doesn't exist (it walks all reachable commits from the starting points)
> but that's typically better than giving an incorrect answer.

When we ended up spending the huge cost by doing this in a
repository without existing commit-graph or with an out of date
commit-graph, I wonder if it is possible to recoup the cost by
amortizing it over time by writing a commit-graph out?
