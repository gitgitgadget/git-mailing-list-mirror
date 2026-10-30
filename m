Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375197;
	b=vhPYGBap2SxcXLcl7FC806oityOWd8CAX56ik1KL2L02UPA0XQcMLa7U8IyyxcDK6soZ
	 4UoUjj5RW1NbVPT8YyTaLP7mfGMNm0djOAWrvIUVVr1YH7I4cfgdLo5ROF5icWFuuT/kp
	 FC1a15qS/me2kOK0ilM9NqGY56Tt1LVOSmtkG+qTbx6xvxuMIwMalkOGO3p3zkWvzg68G
	 fecjTPt0uL7CAzh6Y6XSD9R0PezOgz0sP7yxojjWrAhRFwohbZY5LAoeMHZWEaRmcdTTH
	 XZfBi2Pc9syzPlQFLUBnUnBN+B6nYX3uFyu79MquICs/NA7XnnRwodUMSJ2/oAQDFYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375197;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qNxhaNFuAPnP+0cGJG7LT+B1V6mSX1KiiUeNBVohKeQ=;
	b=b0mWMHTYrEz+8C91fIw1lDBwRLVA7HrrXvFrr/P+DmbMhxS1wFpU1s5PokkxQZmrsDus
	 UWk3w4dJ3HpPGM3fIHpI5PEp1p1FTbhETc297ZR3P0yq+yLjWVwC8h/LVpngY/myZAbER
	 HxeWwhNLACFT3W7okM6SDFNvTeUHGV3PLhHefaqTx6sivwaPgcZIlevofrX0MrhB+WNmZ
	 WXgX9GmWdtr++/MbosCucUiJRlH33RhNXfdXqWx89njdhvwEl3IUmymBctCtLZnVPbTRj
	 kVaGh97hCMsCrQsejukRvJD8isUA0YI4ME9uA+asNxMqF/J+ldXeajc51yzsj66KbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XpYUsmU3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="aI+donK/";
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C063606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C063606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XpYUsmU3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aI+donK/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 61DC61D00061
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:46:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 11:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793375196; x=1793461596; bh=qNxhaNFuAP
	nP+0cGJG7LT+B1V6mSX1KiiUeNBVohKeQ=; b=XpYUsmU3LnD+ORi4BK9pfCSgs9
	Nc0UTyc3UBMsjmzqhf4izhKV6Y49AR3Z/PoJQiXjUX6l3oaUVeH5VGFLtnwh2U3q
	6XAI4GG7139VGihVobMVkkCddr/0oU7jLykvwBxnnCSMdqNG+mddttELKR72uYex
	OZi+4zrF9mL7cJEsYZn2q26CFAFPPn0nVgpGqiJn31MjfaSMHd7R7eQKEymtLaj9
	HbLo1iFBszDOcaEq7RVNoiGbTphqXY/xjQy3P/TdOYc2Pe18p/m5lXU8bvrnZot/
	jv4L1ANyMe+df9e9xbIH2za5Fn7SeTt5L4cbGky6VL9PxU42Qfhaf2Y2UOwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793375196; x=1793461596; bh=qNxhaNFuAPnP+0cGJG7LT+B1V6mSX1KiiUe
	NBVohKeQ=; b=aI+donK/YlF+hU1NL41+U4sLKDjp1e9LjQMrylalXnbHVUsWZVE
	DQImPE+VNH5xJjUBrpqEyk6rICIbLFhxljSG2d7P/8sejSjxVPspHaqN4wuWqJkc
	AsYdWoFowd29xBC3bCYXQvQ544TmRpy1CJf35VAFzVgFTjDg6ozIenJnKr8jSmzs
	MQmTcdhE+hHotCUA6V/8xXa/Sa2WFWYFEzuF3thwt+oXIThlRKgEwJ02hfXIlMFW
	nCP8BqQrIA4NcXoXWAbPAPAeVfkK0gRoCMY83yBycgIogrcD0bXNHiWtM7H+6XAh
	K/9epAmGtPMIqRRzl+2XMbOQ7XVsB5Yunhg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793375196; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F5aqy1m6wRKuZr6RE9C66m4XacVrjVyjuCqfxtP/Xe2LwPS
	jCBhROhpM53h9+wN72zxylM7e72jU8m1bQIG+RbQ1DyfRbIBQmMttP+Av6aAYQmt
	m++lekh6g+gXUpc8TDvEJsogP91QG0Kh/XwwZh0O4Ozgdy22YjQcgtlPmZ11aJOX
	4ejU+mIJEEMFbrX2gnhEmgolTU2Hg2fYBn9x4lFAXoqr2QeeBb0tphDbzfAAE+9C
	GsX1ukE9NRUqUyvGW8IHsKwqP1vZkuYzDs61wkX3z7EmKsn00RdYYDXxv5FFngwK
	IxKodFEBbTn37w7ckzzv1EVT6GkGdbiu4ebTRWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:a+2fJjW/INEyWlgy9R+v+kRk6tycrcGGHrZT9BmXC3g=:B5gwn3PIx8HZb+FqI0I1MEYuXSilzPZOXzMA3HKBQQg=;
X-ME-Sender: <xms:27vkagLEIsTQcH5Ql7yrr4PHnidIUKVilJ6Zok8mctCxZOYOE8fvvg>
    <xme:27vkank4kd7BJ3wCOTZoL1qTziPyMCgmaEe8iO-A0kJqSCPcLQpmkOxUpXJ79pU7w
    aZL6JfuhSOoJ5npFqM7AngKX9Rb8hYN8q-pv1gCYwINFxMJJD05vg>
X-ME-Received: <xmr:27vkauHJm24SRmUHvq3HpRnYrFywI1Qv4f59atcgup4FpCkQ5YFUj5VFCwSsJlPytCZS7ZakaYbAhclym6_71LhI6Z8QzhcJOaGE>
X-ME-Proxy-Cause: dmFkZTEDxmzm3g73Fe+y75HhEr89roYB4576gzHMaftHe9wg3mxKniEDJg6CuS1bG77PNP
    bIYNR9WfBQfljHsweAexAaTa3piexJFpNN5FHw/zpMP5psNz/2lcAGQiWZ9oyWWKjmSNr9
    KkLy/hUxy0btT76bfRctY295T7DNxNKWJ4odzuPfm1a2s6V3v4ipc4ARlemkxW7xliMwUY
    +e+BwJOxdMI06Y29VS+trNlhGbVU85jrKXXnjVuOFSg5L7rA0d9zQ0/vX7ynBHHhLMGrEO
    R7biWbbmws31kAPGwHnbp34wcP9ZHQt+isa4cafVCQflU5E0HfCNVflORmorpUGGfwd1j9
    Lo21UGns8s8EprA51QndXk681DLuKIQ6BpT0IUuVmwqrOYQ9hAj5ylIPLSegT9V0CdQq1L
    +MALTDeCp354cOL+WrkCP2vh84d0zjlF0Mugk7I302Ascc8EJYLJTi3epk02NpWwQj9/mM
    pFTw/b3WfGYVrN6Cffva5DFtesyQYp/2EAv5WnBFNxmDz8jHqQdaZoOKoSMa4oZkLyhLKN
    O9RkG9/9XhYCyCcrBbWykyjXFmHGJHEVsRNZz0ViAo4rDs5A1mttfBi9xpwDhM0ryOlRGZ
    +9+rDsV/ZX5NuJn3yaBe9vvScS8DaKc5ji1S1Q7HLe308rLwqIVaBTojnRxA
X-ME-Proxy: <xmx:27vkanGe6zH_Gf5xsXAxtspHbps5gOQlIza9LHUg16QUnzmGfgUeLg>
    <xmx:27vkarN3OWqENGuLjiOwWdFWcVFh8p58TI3_GHPI99bTXggotOQAwA>
    <xmx:27vkamFKmHlm5mV9BqZquNdfQpKoAG7o8h0b6TApvghwjo7tobgFBg>
    <xmx:27vkaiPb6bXuLLyRQMGZhbEafWqARi4govfne9-pFM-lhWvKllp8gQ>
    <xmx:3LvkavtW1-VFrBhCjkriYsFkuNUPcLIl9Hzr-pa81C8oMaAF4KyFV4Ej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 11:46:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: hide refresh_cache_entry()
In-Reply-To: <auRm0Ohkg3OQIbWE@pks.im> (Patrick Steinhardt's message of "Fri,
	30 Oct 2026 10:43:44 +0100")
References: <xmqq4ie58syl.fsf@gitster.g> <auRm0Ohkg3OQIbWE@pks.im>
Date: Fri, 30 Oct 2026 08:46:33 -0700
Message-ID: <xmqqpkwrxkbq.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> Hide the low-level implementation detail again by making it a
>> file-scope static function.  The external callers would indirectly
>> call it when they call make_cache_entry() or rename_index_entry_at()
>> external interface, which "ort" (the successor of "recursive") does.
>
> Seeing all these patches dropping public declarations I wonder whether
> they should have been part of the same patch series :)

Perhaps ;-).

>> +static struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
>> +
>>  static const char *alternate_index_output;
>>  
>>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
>
> Could we avoid this forward declaration by moving the function around?

As refresh_cache_entry() that has mere one line in its body calls
refresh_cache_ent() that is a screenful and defined nearby, both of
them need to be moved upward, so it becomes a rather unsightly
change, even though nobody would care when they only look at the end
result X-<.

By the way, I tried "history fixup" to make this change, and noticed
that the subcommand ignores "[notes] rewriteref = refs/notes/amlog",
just like "git history reword" does.  Again, I wonder if this is a
known limitation, or a deliberate design.

