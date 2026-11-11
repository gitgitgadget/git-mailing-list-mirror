Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404334;
	b=IabC9w3ornYRrpSsA3mbiKk2f91Mw+17ivyszaF5uX0gldCLAjhVRVjvcmCdYaVYxGlx
	 pMmhggAbMaRNYdz72yS2ZsQCiF32JlDge6/G0/18iQsNozocs2EBjdqgBLyv3FoJwXpEf
	 Q9tGwAPFqxaQmNQ8XS7CLaEj+lbTX0WaemJEA+cFZf6uVO+/0dSrmoKMn0zsH/rIO2dRr
	 2LgxjDoTELknYrzO+4RqUiHH1SOtJTxY7XA8LZ3ZVVwz+dG4Zgomdy90hzP6CCaMpwI6B
	 II6RQn0q/L1NY1EJWvr/rOMPneJhHSd5uoyZ6w474WjoyDvVR2aBSaaUYIQWabHrYqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404334;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6HQqN2vf610RbKbnDTJS8/SZyt2yJhygLD8E9jbHvQE=;
	b=0YMKTgW9cbLTlqDJY9sadQIBVEPgy7EZ3JPZ88Hr5SEmostgK4B40LLS4g36D60N5iqZ
	 j271QYPM8thrHRt5HMNkQsERTIiFT7T+hGlOfMkEZUwRkUTLsDFbSaqbducB+mcjOVJSm
	 pgKX6ww+PaNW84w8/eETBBiR6tJxFXPMSW6Sv8U/DdwM5CXLyykb29r8pB2xf9m3Q5uh6
	 2Gzj3olqFd5BHeg7BNmgOKp77GMv31xv/6jADGSsiYdiYrUJf2mxdR+lUczIpCXrxQsFq
	 fQ4ixWxlxgbh4a6m/CaAqSpMJi9qYXA4bmo/v3ZTlleVfC3+KKaQw5MqB4801+YbAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gv5qH5tQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DmfG4Bty;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16808606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16808606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gv5qH5tQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DmfG4Bty
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 724B17A026E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:38:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 08:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794404333; x=1794490733; bh=6HQqN2vf61
	0RbKbnDTJS8/SZyt2yJhygLD8E9jbHvQE=; b=gv5qH5tQ5+5MqjDqgC2ZWd1ge0
	5zHAG6y2Isi4gqwu6ozcjachbWE5RFsivoWQ04VznvBQJgC1BpBC1oQVxpdMnKe5
	0Jst/0ED7OqA4vo33r+YGg1LnOYR+X8ysLFVbI/iEkHJke9SVjUeqaPaiRcZG+oB
	SSefksiadwJuCfuSPcBcpgOgOCYbpo9T2zbuEDFbh6YaLlvkN++QSz1HopvXf64a
	6hndlEtfKm85vm0WK0rKB8r9OLGH600+pZGr8aYf/CtOyou0DObeHi1JYtJPGqWP
	iUjVtNfUAKDfKOPOHkt+bn+4uyDZAGyfNQ3NQxhZD8Epk4j+Rq26pjpNDykQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794404333; x=1794490733; bh=6HQqN2vf610RbKbnDTJS8/SZyt2yJhygLD8
	E9jbHvQE=; b=DmfG4BtyPV2Au49Sqtefw9LAcxm+ivmdIRFtzIFcZSJqZvUc0J4
	AujgXfVROMIPRmHevIsPp2q/waXwEntrHlI7FKzS1i4k6pahyMMCOPI5aiaZMM47
	VqQmWcP5pTBc9mEvG0ZJQoCBbyFsMmIXX0PkLDAQf8HKp1SYuogXnv10/WpR1la2
	35FzVU0MJg8OVj9oHN8bJzYAdlcd+hN+8+VfNo696QuDGVzKHSU073GiJ2j1O6Hi
	xWxdVlfM8jeAzOy4UR9JKNS0mOEsRVCOAruYNlCSSKxcRMUSSrQHcaWS+jsOVfQL
	2rExSWfulL+koAq6OG3LEbIjCcVuOJcU/2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794404333; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:jDpPpZRTPV20RP1/WtqGPbG2D83wvBo12P0ZfXYRptSCR41
	9EzDKNNC7kZpK3gxzXQtw1OLGdhUUkxIG7ofQaabqr0mGHVcV1/JdWsazFWkhgMk
	JHoiOCl3/BewEruxyOD2rxlCzQhJTrbJXw4sAQa54Q9B2ZUKElYcN+QoPK1wuagw
	M57XJncNCztt+Rd3h2LSiHJbzlxzqhQd5ventrWA2OVEJUOwDmdfkYCMHs4IWVB4
	Z/+dh/C9jtzsVm8CsPnKJCSvqjzaDcSZXYusHV72d0gZsty9W5HOscL2DeE3pNUa
	DLkHlqplaKjTgyyf6v65DQwhVRqwPk1CQmhAI4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Zs12MsirevCQOVxMfzG0thhC9FCjsqBzNV9QT6jbMYA=:3ldEfMpQo3dMn0gmxG+J1aRaz8h/g9wjW+Q4wNzMZFw=;
X-ME-Sender: <xms:7W_0agEJAFwrAPSyWVvxZcRvlTcxdWWCiI7ZoZSdOAUzMjuETUVcSw>
    <xme:7W_0avVamjcuMm6fA3BBtXlSzhxNQfd8uvl7X6GWBUJ3RcSGXXu6ukKs7s_DX-4g8
    PJDjVa7bVEakPR0Q6my5wNpyyjFvBfE8YCrZAjLJhyNnTpeK2caqlE>
X-ME-Received: <xmr:7W_0anzOld6o9507F-q1Qp1K6RWAZ7jEtyOssaGuR6wM69fKor97J_hUe3XvYpNOwNT1ig>
X-ME-Proxy-Cause: dmFkZTEiwoLOlpwBOK62i37tKO98qGO65RGavbuMfi9S4rZlZ+FWZk7YzNg3xiVe4FBWOe
    JyszsbS+tey47rasezNlf07tfgECOzw3+MHyhubS/4/REAAuSYI4b6S4rZ8sOl0afK/pfO
    ieo+BIkoeWiroSwVQDRtmIueISmqy4p7ZCGb0PJFuYYlrH9aUSSX7gwNbHcgRY/ltVO3up
    rG2TUyu5w8HbEwz4K4BouKy4DVNsvbBYSMOG/e+tKlcpQ1zpvLhPv26gRf3km7gUxNaXlD
    iPYBSWwkh3k8JtFvCABcODe2TJPj7cdjX80SJd3El9zAAvr3nnDKMG4ZIhImCbUkBSFBqk
    qy9Amf1OVMzRswUck8+oQcWZmdQu+mxnyUWsSRGrsOe2lWZJeUxwm936SKtwzIHUVSHhWI
    w+T6CzoCVWRLiGiGy+Qy3LKoKHyr1t7scCvA2U26xdpllVGT/G85QkWa9Qx5/6AZry3FbX
    vTjuXmgHpKcrIGDsXfeueMHDRyegbcgEIUcQ3vAs4zB1F82TNFWkEw/5P9OLtA0N59dUyJ
    XrCZ2hIWHZH/YcdLH2JFWCGv9ciPBaOPNdcY4YUMHPxVB09K+DD69CgK4wHDtw4Ooo1Bvb
    n4vJMmHcTOdEyXMrPZXKwFhHKSK5mnnRPRqALPCbaKzbAVfjmJ32fb8OPnTA
X-ME-Proxy: <xmx:7W_0atObdmf_trOYlZV-BSLG8izv5lqWzlU43CMtMe1ZijIh9lv0qQ>
    <xmx:7W_0ao5oyifCUxNXYbb9ZXjmnU3DTPeW59ggOb83OAJUbb0oCHpIIA>
    <xmx:7W_0auMDnu8Lr7T2e04cUec4GevppFapB-WtEbm6Cf_zHmR5jh834w>
    <xmx:7W_0amlMnkiyOo8Awh-iBsmIDSMlcDNdfaUECpIm7n0UIaJKu8Vgtw>
    <xmx:7W_0ag3st7KzBNZrO4iYgbTn-a5E2x7ByQGIt-3DAPE00_YKE8Fvs4Gm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:38:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af63f48a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:38:51 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:38:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] object-file: move logic to read loose objects into
 backend
Message-ID: <avRv6ANkk4LoToQV@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-1-fbbc86c29693@pks.im>
 <6a4a230b-2f8a-4a26-ae08-8439a0f597b6@gmail.com>
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
In-Reply-To: <6a4a230b-2f8a-4a26-ae08-8439a0f597b6@gmail.com>

On Tue, Nov 10, 2026 at 06:40:59PM +0530, Kaartic Sivaraam wrote:
> On 11/2/26 16:50, Patrick Steinhardt wrote:
> > diff --git a/object-file.h b/object-file.h
> > index f44758c4f8b..65ab44542b0 100644
> > --- a/object-file.h
> > +++ b/object-file.h
> > @@ -122,50 +121,6 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
> >   int check_and_freshen_file(const char *fn, int freshen,
> >   			   const time_t *mtime);
> > -/*
> > - * Open the loose object at path, check its hash, and return the contents,
> > - * use the "oi" argument to assert things about the object, or e.g. populate its
> > - * type, and size. If the object is a blob, then "contents" may return NULL,
> > - * to allow streaming of large blobs.
> > - *
> > - * Returns 0 on success, negative on error (details may be written to stderr).
> > - */
> 
> We're losing these documentation comments during the move. Can we retain the
> same above the static functions in odb/source-loose.c?

Sure, can do.

Patrick
