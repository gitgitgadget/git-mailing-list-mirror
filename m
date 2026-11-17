Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954889;
	b=HfrgetzFqrlvrc4T1frDqTXd271dEKgsG1cF2WwBiBtnAB2XKh9/nAspURqXM2m5XvOw
	 fH2w60WdyT00lm1YMZxdxbhOXItXXk1MWFr8IXpb1U6+6cOJqKsofibOvWiIw/quqllG7
	 tOqoCDZZjY+TsO0VehtlzgP9zhQfHLLG5rZUaCOJfGvB1G+0E49+/DdPd06zxtkN5TJFY
	 XwOAk1k68iVj72yRpQAS5BDkahEGq4+t0JjVcCK9kz6kfwrdqf7Ni1ppvb5i4+60+vhDT
	 +KLjPKldPq/qpOgsyNe8ndrz9FymyDrN8AXan6VyblnjkLIV+qpSmT56oB65OFSyEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954889;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aFikHiItcjNYCEYqmxJbU2zAvBEtkmA00SNjFxaNFoU=;
	b=1ygG75rAt4ujd5/cawX8xHqKFAVxK3d3N992TnW5brFtzSCu0+fbp3+F/qk3ojd33rbR
	 ibzfi5OVvKNdVz5IJ7OQtArJ0kipX1wzDiaPYFF0T8I3BkkS6mR//Sa3d2t0J1sECA9hy
	 bS/zcCxQi5/Mo6/P7ypk1OsMkD1CPkbQtyF3kP4GVuatqbsNge+DJI/kBpW8KG8i82WHf
	 1PgzY1ERYTzsNRh85r9WsBYxShyky9Qm2jAQC1q1IHcxAHLZ6KdzjkDz4gAMiu1ntw39c
	 rBZxKLK13MDLM3Cz3SjSZYvEFBmhAOLd8Bx6y3hEBxlGKN1uBzaSlAfULSrj+rGKxcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fQ6zBxnj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2fJEabXS;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC7606A32F
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BEC7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fQ6zBxnj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2fJEabXS
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 856C41D0023B
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:34:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 17:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794954888; x=1795041288; bh=aFikHiItcj
	NYCEYqmxJbU2zAvBEtkmA00SNjFxaNFoU=; b=fQ6zBxnjAUWPDomahHsKWHtQX+
	+y7Cg5ijd8p07zyuB5YF/k5KWisV4jfy5pCwBgdVWSMVQhAslZkerlqekvbHyS6O
	60EKlYJe1DmCxdA/FSQtOnTmYlTFjleE+JVi4tsjbp14o+tjPGjB7um9pRz7PyJS
	Cvy3ucjwz1dxoKALYC12ttplIfJB2mDUygKgHlrBlEBwz4n7FaHph5wGEGUqM3TA
	uJxsk9XM/X+iDHpAUGuHmQrRwJRMMlglvLbZnpwZCZW64kXrC6WIcXRbYmjQFJpv
	Z0HDWGiUxQOoKTaY6AlrdWGNW/XnUHRxI2yg5Hj8gk9xI7oSN02GrKsgrk/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794954888; x=1795041288; bh=aFikHiItcjNYCEYqmxJbU2zAvBEtkmA00SN
	jFxaNFoU=; b=2fJEabXSp7YGXz6rqyWzbJ+lJb1VfKZ8UqQ507ESZYUT10JzhbR
	kvDTYzVtrxDpwzshdilJyUwYqVPQpfweqPpJiPv+duyICOZ3OY1N83zRz6MrahgK
	So6Ls4zGNYzdwst5WE+Uh9j4Nz9+BEkshqkfXUiJbYGnfZwl6jS5RXMS1lJuYSzO
	RVNTXLWRYZXt0DagBd37fricowFFUEf2TW7FXSrbMfq4MTmqK8eH1PZCqZelT3uq
	g3MNFfvenMY01J1EfEc7S3PEX7pKYGu6jaYJPLjqI+x9DNiY4ItG/FGIhxKqxqPC
	UqqpX/eitrAh6UAi3EAcMRgVfzul0JC5RKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794954888; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jsOWoRa6DRHBHSIrXkW3SLvYxX+c4QIipeHc42kK7mP512j
	HoU2UUlAjCIqXSaH2KqZf/ZHUKr2W13oPMWOgmvlveWOBhCTkhP9RlEX+rp611Rv
	xb0sWwjofxjx2k1IwDQiSwYAjiPMNadEaqj/MK7nYeftiCk/YQ2G2VErjALQsQDB
	cmy/Cp6uK0ATGAZkHFBeDQU+GCCSDW2LESX+A8YK/bBcButLjbXBzV7OQaQ+feqV
	/RZN5mQDVuXy0gfhYAMgGxTKxN9oB8PJx3SKNASd+tl9oL25R+pBW4Md4cW6UZ3T
	PAEpVyYbky3q2dq3ff3Q/UX1EWSBy2d4hXoGsLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:E3enIvowmr1mve3sHb7g+2aVsBujzW2D+EgMDzNbX80=:vSGGRfgpZyGf+wHU2waSgtpkA8OSpFRj7U2bkbqvkaw=;
X-ME-Sender: <xms:iNb8av7cu2ij8sv9No7fJlXQgOcnPL-uFR5SmdFmM10f7v-uTrwzyQ>
    <xme:iNb8aomNIlZt_xXUapBKUcNMGCohTsfRUeq8usqYAOfovhVrqQpDXYDpsl9IsUzo7
    sTlLKWLkIDdvYJpJzcFSd2RJQ00TWbVkD4SvaiVAlTB80gKvy9UrA>
X-ME-Received: <xmr:iNb8agS07kjs8OYzjjh-975Yf0N3n_NA3E4KT2rdRDv_qIP_CVEHdIhFrHEwE_EL3npjC1gER85FzHGHFKAMtCtt09XHlwZCFXBu>
X-ME-Proxy-Cause: dmFkZTEfdCeKgbxZd21F31/6wae/rNlGkOwz5cV95dN+4zuaV9MkWm6XLI1lxh6ailXehk
    s+DJ/fpIe4YcKkNZqIoRVI87896DBtb6pMN7viOtNH0htTyk6+S8aWO6jT4paY8mqO9i9X
    8LvJWchQEvAz0o1/V8l+sxnFvYX9yZa0CKvFckJFW/dVA3kN577xHuuPp55R/Q81uCBiF0
    U6Ep/xlYB9+G+Ta/z0qny1vfLSo5GoNbRWnEyzODh84AvuGi28N3vOFv8GZYBn2H5aKgp8
    aQ9Ut63XritiKCCq6ed3e5uLVl48S5qe+GCQZxQwv75Xr3q8/BGft7zCY+mtcww3eS+np5
    O20JhmpySTXrxKm38H0Nc57YUJ/Buz7RIbNOWXtxl+WqEcfIdYgJlBcC7EEsFvlZiX4PaJ
    1Ys13dorZKPv3MV/CwEa64B3LC7fnbD4Uxg3/9S7WP+DQgZvzxdRDZFx0t47UBRmwxA7BY
    ptMWXaKA/nopuJR55ixLdleL5QcEivpg/xpC4PqE5+xntzB+ciFPt1lwUk9nNx3lloe5CP
    oofNc/aeSBAHEgtwbFGIzitVYf/AyQzjCFREyMDrSke6eVtXy7EAIuvj7GtlPXLXw5aE70
    hR3JiL5KAktW0hToXcY+iVwvYqLjNZ1RTJ9W3iZuag6YePq/+5g0HILYZV4Q
X-ME-Proxy: <xmx:iNb8anGt-9LME2pvjuHa3SZzWe8heaZOVTTWdqxacqHj2d3vvWZC8w>
    <xmx:iNb8alEunjvkxgOPd4Ol0I_G1fVFaK9T-hbSQ2B6wA82ueoc9MVMQA>
    <xmx:iNb8alSd0v8wxgTgnOFnLtj3eiCtONsrW3949oTh0B1GWpO48GvxAw>
    <xmx:iNb8amLrfhXdqNn5015KC_E_MYz8PKdyU93ZBEjTVHIcRpbhwm9vIQ>
    <xmx:iNb8arE3hLSQ2HP5AFGyJ5I3egAV_aX8XQIKG5KIF8SyoyIQeh0Pk6vC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 17:34:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>,  Jonathan Tan
 <jonathantanmy@fastmail.com>
Subject: Re: [PATCH v2 2/5] object-file: use size_t for loose object sizes
In-Reply-To: <eca5d3ddb88e03ae647a66d861a4c89a4c490fd7.1794914210.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 12:38:55 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<eca5d3ddb88e03ae647a66d861a4c89a4c490fd7.1794914210.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 14:34:46 -0800
Message-ID: <xmqqzev7axyx.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
> APIs, 2026-06-15), parse_loose_header() reports the object size as a
> size_t, but unpack_loose_rest() still takes it as an "unsigned long".
> On 64-bit Windows, where "long" has 32 bits while size_t has 64, the
> size is truncated on the way. A header claiming 4GiB + 5 bytes thus
> makes us allocate a 6-byte buffer, the size check added by the
> previous commit is happy because the stream really has 5 bytes, and
> the caller gets that buffer back together with *oi->sizep set to
> 4GiB + 5. Any user of the object then reads far beyond the end of the
> buffer; read_loose_object() already does so when it hashes the
> contents.
>
> Use size_t for the size in unpack_loose_rest() and check_stream_oid(),
> and while at it for the size of the mapped file in map_fd(),
> odb_source_loose_map_object() and unpack_loose_header(), so that the
> whole loose object reading path agrees on the type.

Makes sense.  And the changes are straightforward.

Move from ulong to size_t would help truncation on platforms with
32-bit ulong and 64-bit size_t, but does not addres any unsigned
arithmetic wrapping around.  Are there places where we should
be using st_add() family of functions?

Thanks.
