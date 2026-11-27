Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806821;
	b=H+WV82rtIByjmZaulMmGH2LmbppMEK53B2MmonuniW/L8qFDajQEhl+o6dQpQiyVHWu8
	 14zMmhN/MDSxih5DrdNOGv270sMc6eXXjuLVFJKDYeA2wig/7MOjo45QhiyxvNGA9hFrW
	 w84UBm9eqsZqWLS5KCR/ixV9h/PL6208ooiNTEciCBzaqapEPd2+/Y66UB6Wtci8eU0gB
	 zynzmSEUn7h7CydAEbTXDreMf/RShQksoRNLLAeRwACMxJLFMcSOVZcrRWd/YK5UeT+Oa
	 vzrB4RmIYW35QWircHmoUlvV4GQTQus8pI5P15CMOXXp9TOIW/6KnsTkkIgoDFr8ZiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KBJHiTGjVhkKDkyVOAPdLtPbL4WT15RohjZBObIQmW8=;
	b=g23t2UB5aIjxtbvyOqsDqLIrl1KF6ZGb55x8cZCdjemm9chHJVWbwFechOKou0vu1quF
	 cF4OBR42yXgalBXij/PFmHAzfrifBCeuujz37ZACfW3GTWIjISudcXp6b93zf6g/K9V7G
	 DOqMlg5BtqaaBsa0hh0xZlIIXiVaOltQHcUdM2J2v9E8owc7SwDVxYl3/h5/eG0JIPd77
	 /FlyWrynpITMp6Fw2727TWAmoxSAM14cfwIbf72QB4GBKVG1MJr4Dz4vLFA2P8QFfg7UW
	 lOi+Y8MApAAlltmZb4s3SVDZ/+QP07T95jUuYKk+8OK9F1EJFGBhkEyv6LAF8NwS9xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2VITFkb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZJ3Ijibx;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D2606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2VITFkb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZJ3Ijibx
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8169B140036B
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:13:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 27 Nov 2026 14:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795806819; x=1795893219; bh=KBJHiTGjVh
	kKDkyVOAPdLtPbL4WT15RohjZBObIQmW8=; b=Z2VITFkbU7krT411gImv+Edewv
	GMmAW6AGHCDyolx3XZVR40XywU2TC8Prf1usFCabbQpCqFP8DYRVIcQRMD+GJPdm
	kjRvuGupgmu7NyKI5tOvnZxhSZEEsfyu3vWp+MrkTEw0wwARdZUl+d3n/xiA2I6o
	vwY9Vpag6dm0eYqAkcvF8ZV5qcuRhJH6St+xDyipi4S1cRV7AbKHPeJlbAi/i2SW
	pU1UKb3tUngBDq4BrMt/zIW9kxnV91w77V6XG4DguYSj8/++lkfHkVAeT3vly3YM
	Cu5Z2ayabU6l2wOmAG4HenoCyCXpb0Q2q3h11K4VSqf5KP6qVSD2vOiE+CGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795806819; x=1795893219; bh=KBJHiTGjVhkKDkyVOAPdLtPbL4WT15RohjZ
	BObIQmW8=; b=ZJ3IjibxzZc7bCiUI5jzI4WB+MrVNepHYmZz6k5ItjKHHeBsTA0
	djpa9GfhMBuHAcLbtxu59Zpud5EtYxn/0Ad80VcMmIm1szJxAqHPywDPM4YGT+iU
	GFa+4dyqkjyl51UHERQc1BjRS3EGYCSe5ZDg4u3nhB0LToZBA7ZIQ8URN9sGo67h
	UyWex1SlwFYDOIQkvdldM9Sd/u8wBujvkaZc5YRETZspf/ikReEaN5URfbY1087Y
	bOKFI2tAa14pD8v227iuSJ9k0a3cFlliHd9qMdy6Q5M0VE9XtvNdKvCwS9HreYdS
	y5Ar6JU4HFBSwmST5O0W9Akf/aQiMAT+Aew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795806819; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VSktpnLKJGqwPDCXIF+RFVPHWN2MCRuFbZUGjEW+rYfaS2H
	N04VohGTGsaPF58RuE3K5Q3XP7Cwg3l0Ahl9gEfDGZX2//3dW5yjVz4o/zvhhY67
	LeXUGClmkQA5vRyvTosVDdB1jlsGoSBx50IYkelz1PVuP35pcS4i2QIuSZu+rCrO
	mfiip5sgazPSk9qPNxSY03WIYYBfq2pRnvIaqX1eiJrWz38OH8jf+ajPZoHv6WYV
	63oWW8Ea7mtSC986WNUIXEhrzxLmf17YCSZdYt1s4KW3LpuRXafHL/qLZmnvKZhx
	+u2ZhIugWV0f+6dB48HznTc+87p+K6LCk3vjhIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Z0uzL2HUbC1+5LcMCsxAA03oCM0mCz58jLS6Spj4zCM=:Xs0f+OSH5Bsu3GxJWsnwCVmS3dKW/4ufchbSrUxzrlA=;
X-ME-Sender: <xms:Y9YJa22dN0Y0cSZl4oMt6nKBob_OQX9lzo6glkb9cAhOJVPL7HEuVA>
    <xme:Y9YJawG2yOboacWCdS_plx_6LvHMbQeWsWUEBY-pd9eB8bnL1q8Ci-C7zlEYQ9QRt
    2YACOB3zgZuBGEsLDl1sVI1oCBWHHM5EU5gk681wyv2Hti81AR6pA>
X-ME-Received: <xmr:Y9YJaz5y0KuwylUvs6Lq_plGAS2RLwI4OHMOqVW31l6gLAEpCoieA7vnlzEFZzYI96LVfhMz57XU9iqpqrWqahXMVBBerwa9flxwpKg>
X-ME-Proxy-Cause: dmFkZTEXmMjNSRB22vUnDriLiMKrjh7arvhBxvyAdLe8oruvlEwbbP2Oeq3FwrpWIE+gWM
    shLnXyONCdbebQRpdTgi7TSigla1sEJVSeqYh2EGr59ZCkAu1HNS/ZKnkTja7ET3LAle97
    i30KdhDufeaYFW7sphsBjyCa1XPIMkzLIgX/ju+l7T+cikVtUXGk0YnjPNw4DK6bdvIum/
    R9Ny+FG4zDucrs/p7TZbmVFaOtSFSMP8QipODUaN5TLhqQkP1ACfa2tUHpNsAwTzPwfhfR
    0/4hhKODHi5kNUMei6N5Xe0Ebzzss/rybuRWYgyTHVR6eeyRqwCsq4H+ffKA8SvNz9d8tV
    XakiyEEqn6NLlVvYH7rix4AsPooRLy/intihNsgJXdf40HsS0ojMKmxXmnf7sjBa1OvFJm
    MviA2CUhpjjjU71g2QyqGpN7gurGm7QSbHh0Ut3+YzQN3u+oCUD1xfV9zlvHcuoGtGOBXq
    nzTQ57+J6JTTW6Y1REdgSd9yrnsMZDxPg/w580u0iASSBmWGFzee/4peye/FDWH1bWYt/P
    2CCmnjXfFbY1DoQ+2/l0AlzJAJguZeXcmt0PDpC+ck3bIWyfp4ODX1OV9aRFN7hXvAGPRV
    T4RSV1ykHXhNCAUuVtvi9td5Bv09YStYJ5pcBA6Tma7H4NZVCI8I1B5GbagQ
X-ME-Proxy: <xmx:Y9YJa2tmrFwrscgCZCd6-qW8iM_EyIouEayjgfdwqvi8TIKVwBWt-A>
    <xmx:Y9YJa07zUDuLscNc2jzxGoyxu-EbgklTC9ijD0r30h0G35QpO5H3-w>
    <xmx:Y9YJaxX6jTr_RQ1g767yRUaiX5_uXPAqqO4j3pYx0JAo6KmA8poLlg>
    <xmx:Y9YJa29sacaSQPD5xfQ--P3txrla63SBcOYhVR9VFgu_GhKRvRVcbg>
    <xmx:Y9YJa08ZB8CuZJkEmrfcs5VUDIvFywkOR2gEHJCqPJ6YOU-LoJNRLE0T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 14:13:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 2/2] lint-docs: ensure command-list.txt lists all guides
In-Reply-To: <20261127174223.Yr6v-%taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 27 Nov 2026 19:42:23 +0200")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261126201110.9046-1-taahol@utu.fi>
	<20261126201110.9046-3-taahol@utu.fi> <xmqqy0aecnyd.fsf@gitster.g>
	<20261127174223.Yr6v-%taahol@utu.fi>
Date: Fri, 27 Nov 2026 11:13:37 -0800
Message-ID: <xmqqse0m84v2.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b574ca2044..0ef57503a9 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -532,8 +532,8 @@ $(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
>  .PHONY: lint-docs-doc-style
>  lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
>  
> -lint-docs-manpages:
> -	$(QUIET_GEN)./lint-manpages.sh
> +lint-docs-manpages: $(MAN5_TXT) $(MAN7_TXT)
> +	$(QUIET_GEN)./lint-manpages.sh $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))

Yes, exactly.  Then extract_variable does not have to change, as it only
is used to read from the top-level Makefile.  Perhaps this patch will
shrink quite a lot.

Thanks.
