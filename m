Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376305;
	b=HFkfp8/FQoD1hGiga88v0skYvYqgq5hYsSuoevmH6DYpdKYKpViC4kgxgwDhtjgv3Nh8
	 0SP4V01D1k9FyGzc9jSavI7iQCuiKmFlMN0/tIJkiUa/QuNK/zR+IKIusLmOPyKCv05j8
	 AMk/dsD/dZSwCicCDwflEVg89eg2G//UU1g/plokECM9axaf7HwRHvqOldpuc6rcVfEh9
	 8X97kI/oqWhpIFG2tC3vVgnaP6IjGpQLm8Tv5268Sb9GYQCtteWvJl/TGWenTTVrHv5Am
	 IeChR5u7DsDdlChXZOlNdMGlevTkXPN/WXOZ/oFaKqq0Xq7wr0e8oFVKa8siP3VqLpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376305;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3OySYjPiDxKXamHoDOiEpbW9qHFQOg9g2hVFzAEHDj4=;
	b=QWnnU7Ltc0HUosZ+SyQluu8yZE7/fKjkTkFlZ73eYTWOHtdSjFq10wYTDqgSsaPZWAmg
	 NGGXtBIxhvS3v8B2zAa/mj+L4L+lbDQnyUJZSOoD00XkK7Yws2ef5+fXqxe8n9zwH4hDn
	 8Qpj2CvFcvR1wGksgz/wf7DlN2Gp+rUu6lKOfaG5uPAgWZkJihdmeEGAYcsDkIIgrXaiq
	 +mZeuer1HsmEqgP3QV5ztfMLBxVkUcqEbbpJS9Yk4Q5R5r+QDO+segEmCyue4wG2ln1n4
	 mvhxWwK9p1XG182pTI3lXke4K/fEjIfhigvXsJrcSAESs1Qx7wiV/s0x/xG0SXqUYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AgioIZHV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LbEXZUnq;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55720606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55720606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AgioIZHV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LbEXZUnq
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B9371D00105
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 12:05:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793376304; x=1793462704; bh=3OySYjPiDx
	KXamHoDOiEpbW9qHFQOg9g2hVFzAEHDj4=; b=AgioIZHVR7F2aIoqW7w4K8Sba3
	82PYCH834ULWed5d+QHEhOEecrngwEKUYwf/sQCVX/3nJFcs6AopmmMVlWcXLTel
	Y4jMthU6hIeeJI38Xk8Obz2rp4TU9DBbYkZPR9uJUBtQf6qkM3QmHz4G+F9qP6Wh
	PBQcyYnlg236ywwyGXYnzRcliGXfBvtjaCabEl6Ju9x+NDgC1EGtPAil6dk/yyqU
	6aeMl/QPb3mtkQQb/IVzuuhZHWZQS9vSG+APWHyqjg0pqCWM7UdmpsQVqDoezNfa
	cbMFk2PLy9NnfnJOkCKf1YuhGHuBypkG05RcLYu4QCH+yP0GrMU1QDDpbmKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793376304; x=1793462704; bh=3OySYjPiDxKXamHoDOiEpbW9qHFQOg9g2hV
	FzAEHDj4=; b=LbEXZUnqFXwmiFOMw0GiukKY0GysG3/KpjEfMizeIE+acboMh3y
	GKQyciNil0uVc8Jtb5nYApHjVTepsRIR15nmxJcPYt2IeBMEi2mh9I52eyJsqWrE
	qMmVqpYl2Stlbzw7N2h6hzqYsoSqSqxzDTt/H3nzAi/PfHxgjS8CnyCmx11l8bNa
	0MaxShrcqhQBsJtZf6Mlz/PvHo2B6cCSB3vyM0pyMkBIIzuMcocwugFhuM89W3gi
	DfZDHrBC/lBmP//O5ESc7keezNJozpbmZudsL701pna7WKvVhZ4F7e7eGHiG7gQg
	gMb8efw65jluDzxD4ZwsGNUA9cQ5m/DnV2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793376304; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jU+M8jVVmFsLc5AgK2jynRdBrZmwwW3c0o7+YpSr58+jwUK
	rjk2b38rRhbfo9ig7ereryLAHJPbVr19pSLpqh/AqwumsK7bAHGS+jkHKAijlV4C
	JRTanI6w6GIVhXCr1Wf0xbEADqac9nFNnlhTY8Dq3yktnaq68nezf/08gGBrIFCa
	4ucPQ6Kty+vOJqssX0jVRtT9hla4O0Jl8D5A3Fh8MbSHGkzMSGZe+4GA6Ymx8Ei5
	+11fakjwIHVl6HKtBds9EOxYgvOkJpDEiI7oBpcCK9x47IoX0DIAOI6aoT8k4+5t
	pzvHJMVdRpHYohowR9O3s2pjA7WReCbzeRWud8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:L7IwRRuffl4fbNSVXxibxVVe41+hrzOgU+7GCA66Knk=:7HKuivIG1Ec1XKKmyi/WR4fmaUIQLhEKFG2bBUy66LI=;
X-ME-Sender: <xms:L8DkashoPOstylqDWREIksBBo-vAczIOYRqEpjYayHtVzjYHw3gzNw>
    <xme:L8DkaouOrW4t86dx3C64Iwv8zFDSjGE1d8wGOBVahU5vz03VVB4-bibbvcuPOvGCz
    neeKsZYHXo5_a8txsWlzNv4AdHEZ1URUZ5-L4jKGlEmSUiQjRYlbQA>
X-ME-Received: <xmr:L8Dkat7t3UjIiKrUWpXuJ3FRePHWd4qXE9D1nC4a9Kxb_3hDMUccnUywftow8cB2g3GjAzy2aqeBBBpUeRWgn6GqUMlOQZDbfGnd>
X-ME-Proxy-Cause: dmFkZTEaxwuj0Hg4JegmVMPtK8J1h6I78NgOf5ehaQ4y9zYjBYPiromsEE4iYoFVQqIt2R
    d/exu8iNienCvHjXZWZFaCcLh1hAXMvQQO20ZNMXsaLPG4EhFtffEAl+JmdUdM5yx/axxI
    wrmzwGW9+yGkhrj4W54r0AWc8r3MCMAZjuWL1x9JPsp3pk99vrmncfHSiAd9QC/UTZMUMt
    IrCxl9i2hDqYEg7rx8hHIfVVDEWgf3LMF4aosxDIiXNc/tPJh8A/mP7s/Uq9FHgIfJJLFu
    EzZ3RQoFZrJ38ZHzRkGModHxelA/zRBKph3Zw62Xq/ikhGNuArEdXs6BXs9fBZkrXg1Mkn
    UXIYfnfn4PwRpb/RSQR1aNwOaUJ5YRtLciMIZabVjqJu8s+HhGmrNN+s6KhZnh6qUBG0CL
    dPRbaZvp0Z7k1QI/xtS12+PNgeLnD5i0MPfG3xhat9OxYLLZmnVxrP2NQHugo26jz92DRv
    bv4pf3F6eJc3WAgS+ydpz9zxNBYEyN6R7iCZXdrdz6oCzplTuRyJcG2gjD/Y128X8YpYYJ
    8+pGZuEJ9LjdOecTtuN/d+qbQ2ZBGcg+N5Xhy30BMJScIngx+3yFvNceLErn8YSVFfKa+G
    PeS+bNtjeaDRRSsLFggpgJq5AYA1Dzle1esuaK0lmZYLaj0wAkN3NlxCYGow
X-ME-Proxy: <xmx:L8DkakMryRoLpcyNBeGq63A0YIX0388N-aTii9coFBx6gOTyGESkHg>
    <xmx:MMDkartsv4YbgIOQC9DEUhv76evOmlujj2pR1fg8dG2QPfHq6RCxRQ>
    <xmx:MMDkanZsxVBHYgJUUSZtMfuLNgfdrv0RGIYHsIbqjwGqlgYdJFeKBg>
    <xmx:MMDkatyoUSLMk1PUWJrPb2--mIx_qFSsz4CJ_Thzptp-7o36W63n2g>
    <xmx:MMDkatUor6C4Y9y3-6HgramIgHEm5W067VpBsa0nKwbMDDZh5qC-RFDO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 12:05:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the
 quarantine
In-Reply-To: <CAL71e4PXZ8-T3RgLQQLtL2ASQMLbRrChfV6wAqxFSd_Tw7-2Sg@mail.gmail.com>
	(Kristofer Karlsson's message of "Fri, 30 Oct 2026 12:51:43 +0100")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<xmqqfqxo4dy1.fsf@gitster.g>
	<CAL71e4PXZ8-T3RgLQQLtL2ASQMLbRrChfV6wAqxFSd_Tw7-2Sg@mail.gmail.com>
Date: Fri, 30 Oct 2026 09:05:00 -0700
Message-ID: <xmqqjymzxjgz.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> Then I started adding a second env variable.  That worked
> and it was not _too_ messy though I realized it was a bit
> redundant.  We can simply deduce the real object directory
> from the quarantine directory -- it's the parent, based on
> how tmp_objdir_create() works today -- so I built my preliminary
> v2 on that.
>
> It feels like a slightly icky assumption to make, but it
> feels safe since I added tests to cover it, and does not seem
> possible to override outside of git itself.

Well, as Patrick said elsewhere recently, the entire "since we are
borrowing from this alternate object store, it would be nice if we
can assume there is some ref storage that tells us which objects in
it are 'complete', but because the alternate object store interface
does not define such a set of refs associated with it, let's just
assume the refs/ directory sitting immediately next to the objects/
directory is such a hierarchy" is an icky hack that is crumbling,
given that the alternate object store may be a part of a repository
that uses reftable.  It also is troublesome to "borrow" from a
shallow clone where their grafts are part of the mechanism they use
to avoid stepping outside the set of available objects, which the
alternate object store mechanism does not "borrow", as far as I
recall.

So until we figure out how to fix these icky points, it probably is
not a huge deal to pile on another icky assumption as a short-term
measure.
