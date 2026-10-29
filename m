Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261150;
	b=omBY0kt47WNhI/QPMB+VtXcgr8B7Gm7ue/krO98gbMecvNNnUA09KR0iwg5ZFqcx3XOm
	 qq8AcZ5AZOhusUtdMF/0IpBw2rOEAZPG8vgYChh3Vdrrp71PAkcRiouS3PhVSEYEVEeNZ
	 IA/lZEG7AI5eat3QSwPJPieKFHGQDS1pMbB/r+minKrIsDp4U9T0QMPdpTFSSn3n//rCW
	 bIIE/+G7boLzNJt6p9CHxyJZyKLAa2FXGu8qL37BLIfDGsWg+tkC00eNRMV1enZCVd6YE
	 mOrlz5u65pxCOn3mkflWBzXjZggnF+Opid5AJ8u0lAILWVV8SobJRjiNzxscsSv+Pzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261150;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+j9TK6U8th7Lay9mZQIaAL7GGv4pQ9ZDI/7ReT0M+0M=;
	b=3Tm/co6/mWvhGiIw9KPjGgY9pNnWUhEiZ0/JD1JGzY7K+0SVLq9IyqjGBTENw6BoTzDM
	 iS9Dvg2f28s1nfsWtVk/Li7rb0jGM5BjkHx6ryIMx6DVtMjcPaoQtGrvyo5bxwRDManMP
	 XE4Q012oqspJTR3yv2fZU2UxMUJizHsDteyB+YDxqI8uDutPzcx+lcW2dVi/SGUtgoDrP
	 9rXVN5at8d3Fz8C9de4gJaEf2IMIYG2DS1KQCBgONhloyTXBwVaMB0KOMl+ugAjGyMXE+
	 webmywWGYpYtxDEGSG611PHQ6/NCQO9qAOxcjC3YVNmoRDko1wUQ9WwZY7/3QmiZVtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="QDtNKR/S";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bxnYgB53;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CB606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F8CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=QDtNKR/S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bxnYgB53
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56F617A00E6
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:05:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 29 Oct 2026 04:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793261148; x=1793347548; bh=+j9TK6U8th
	7Lay9mZQIaAL7GGv4pQ9ZDI/7ReT0M+0M=; b=QDtNKR/SBLjCj4zcx21dYyDN2d
	1VB4I+uU364ioNGODDqKKXze83M+3PtUMChBGbvtOREco9sfKsJJSTIX9G6Dqxyq
	tUmDL/g1P+KXIY1KbpjEkZ84jNXYpE1pxt8ZPiir7FYwxAmWdTdtEnD7zi6q6u1s
	dr4a3B2nEK/7fQauhnt1b42lF4qv4laYk2GZV0dp85sU6GQl2ZPmpyV7UlG/98BZ
	OlbxWYxwQvcU4D38BXm62nT4sTSuP4ZRlGF1U3P9E+UgJKvyoRFR/CgaEqEvX03o
	raGrFUaSCBcotBgv3m7jvqU8Ry3CFwSjg+GpLgx+Qzi1jWS4pqmQM+p3zx+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793261148; x=1793347548; bh=+j9TK6U8th7Lay9mZQIaAL7GGv4pQ9ZDI/7
	ReT0M+0M=; b=bxnYgB53dZObg5O2r/CaoBn5llThias+lwxZOImwBPMOawIkM/u
	zfmZBGhrIuTKQwI9/f1jZXF95dnh8hloBDn5beDL8/IktTXK2D415Ip0Ga96lpAP
	I5MQG2t6S9jxvlN/hSVMLrWoX0onmydrsWn8qbdhwZpn93rUq1NbioXdiers6vII
	0zgVOyJaPFYa+1ffZcUzRsiJgmWUBSnKZI4a/Hp94rTYyILfYQIeV99XxS9Pv0Pp
	nKq8dBR1LF5R/ileIuNEk0g56wIjGeEjdaWXPD1wSLg3S2AARgwzPFLWvrMehjV8
	E0j0wLZsgC9tiyX1WgwEHncERN8Xn9/jQQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793261148; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BKRAFsVibnEwJOGeR/FFiFYTLsnvphuptvExsUkW9/tZLNn
	GPnO5on8fDqobDe4IKC2ol5QidU+GBjIsHxZA8c6lQe9ovr3vLTFby3G3Ovyu1o/
	eStfU67sgG7K4Nm7m50U7fNrB76QIvv7Gwd9404qiiU8ULXYECVkTx2d9sk6x6uF
	+tztgsskrNwDVJ4uQDPRoN+poKxQhSdu0ZredRIgyyaBwURyG/6M73dHh9QlWLYo
	JFrRbFTrC2/4QM0Dz8Dt5Hu8GbpSFwp4FulNhbIpRcV4icHWK5cMzC8fYskTVPkU
	lerl7nIFNfgCAz95tgFGntZ2gbvc5roSN8YCQSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lKaRGIHPucLiYBYd7jvnHwHq0haANQ391b5ChFsjv5Y=:EFpRQBmOJEDijudvaOaFGrGFV59wZj80momRBDrLTrs=;
X-ME-Sender: <xms:XP7iajn_iQ87pTkarSi-NlJBR5RkAGp-sAnU8wPChA2EaYip0XVB2A>
    <xme:XP7ias2ALigWBqBi_3lqeNON-Z-YE08H0Fi4dT1May9xNEAMI-KlRpaLkV9D6MoYS
    3spcxlqXrAqBUGfF-tJxx2D6f5VjLS3FVmgHHHTUbjWidLpJJX5voU>
X-ME-Received: <xmr:XP7ianT7yZrlFBJcy-2-GSN9JPK9vKhegysInt5csnfNB6l5LbTG1w>
X-ME-Proxy-Cause: dmFkZTGqBlAqV5NiPaa2IyQGyoZVMr4ZL4JDnXi0nb5q6x4M6k+yOgLMgSRaUvsjw29tp9
    6ybOws7DWbWyzf+luHdxEbKGlJStYsAD7oLLBZc7ETC4zlMdss5nr/U5hmYznZA5qCPNcd
    f1Zk9M21/LWK5YT0/36Th83QHawa8BLLwkRULWf1K7tkeNPMShhLWuBDOosOk/9mArOgAL
    MqDWHvMXDQ+gZ+QHj2OuQ7G+xzSer8Hn+FWYikzYA9WrsW5fVqjAZUlfoVA5DWnrru6EZg
    BXpAeuJ3F85zRuP3bLgfmvjr0OCs+Sa4n4EBJOY/g7dVLuhEMuEHDhUbUorG2QPwyy2KYG
    /1Wm6MmVbzPGFADCZiQk/4VUyKJ1iCgvW/71hwXpGU0Vp8+cbQjoq84dMeRSg/esnneqNO
    SH9GvRSeumfoCna/GbtaJe4UMIcPr/IgCDPgba7ju+zyEJQHQIgDFubT1aSr0/YWcK0pRz
    FEI8zheFi5AeuACsjPdxm+Cq0lAORJmBnrgvWRK9EZUMIQoHnlYfjjFO0QiwnElpUgLVwt
    d5xzyRq6boM+Qc99lZKTv2X/gUrI2O6mBFaGveWQWuib8VxbkiHAEzJxzWFozQBaWPEciF
    NMkZpkkuFBXjJ9nVh59BGxOGE+jfuCLtbnfl3cRZSMgdAoVXXsS48h0SPPAA
X-ME-Proxy: <xmx:XP7iamuRtO4EbSRXZVo4JnXdfF2l09Fb3DUCnRlxU0-iswxZjJBgUA>
    <xmx:XP7iakaK8p-hHFfki5c-u0-Wv0qo77aEqb5HFh_43ARbWcyQd2Eo4w>
    <xmx:XP7iajuvn8xSmT3i3L4Nl-_n30ti98lPQVztikSHCXlqbJUUP5kFtw>
    <xmx:XP7iauFQZSchhLPPKw97jFJg80eM3HRWw_ugesoWwIa8jDZtATcRrw>
    <xmx:XP7iasWFRNmS1iK-99e3581MmUZiJTSi6DgxXNcGRUgmfVxEeGr8AuLo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:05:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32f5d47c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:05:44 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:05:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] loose: use finite timeout when locking
 "loose-object-idx" file
Message-ID: <auL-Ta8DTicSLW7W@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-2-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029002413.3291184-2-jltobler@gmail.com>

On Wed, Oct 28, 2026 at 07:24:10PM -0500, Justin Tobler wrote:
> Loose object index file writers first attempt to acquire a lock via
> `repo_hold_lock_file_for_update_timeout()` and specify a timeout value
> of -1. With a negative timeout value, the lock acquisition retries
> indefinitely while the lockfile still exists. If a process dies while
> holding the lock and leaves a stale lockfile behind, every subsequent
> writer of the mapping file hangs forever instead of reporting an error.
> 
> Introduce LOOSE_OBJECT_IDX_LOCK_TIMEOUT_MS to set the timeout to 1000ms
> and use it for all callers that lock a "loose-object-idx" file. A value
> of 1000ms matches the default timeout used for "core.packedRefsTimeout"
> and should provide concurrent writers sufficient time to acquire the
> lock.

Right, aborting eventually is way better compared to blocking
indefinitely. Ideally we should also make this setting configurable. But
I think it's fine to skip that for now and fix that at a later point in
time.

Patrick
