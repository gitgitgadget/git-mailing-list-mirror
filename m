Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707525;
	b=iKOJeRhHmnLdRsxuqQZosSQI/OrQngcX1nMjm6sh/n7/z+Sndat3VqlO9CTDlByTk9cj
	 7PgOHoyd5Z2iFqT16vY6sN+poDz0Rf5lnazaBAcDmIILawMsDD8S/dPjLE4o1/26ZOekW
	 dsVFPqCAdZWgPtJX28kw5CmYiXv5qjHP6HfiQqjRkkB7i1y6KQd1+1CnuQDQrMpxmL7zz
	 gXJNDuEWfbVKscnTeOhOjGcomuT0nnHHBn87oFMa1xtrG7HjoBZ+/2KTltRTKGUgXzfx1
	 QOnDstAJI9JdgEKXV341F6YMbY031Hjv/ioiAsycZ0PxRkVGNLVyUK/yoi5Yj8GiOSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707525;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yaOagFavvLKvCNUfcbremh9xBV/gvqo9Jr3PEyUo8Yg=;
	b=KE5zTdOaAjwyJszcYQFz7taUvERayaCV3ELnNGFlEFaaCqUqA2gLlUmTdqVumqE3Fc1H
	 r1p5HF7COF1eosj+Gz6RUIoZOQ55YXHJrF5lD2dKemZuxEhS2CTpOom6d+zuwjG/ExBMU
	 nIkcnHSfKhfLIXhzuaVXWjJj7qATb4h1yaNXSR03JXJnk/d5yo8Zr7CiP1DmFZHaRMGjq
	 s1dwk74qEklQl0Zl5u+cvadvn9gTssYV/35vCWgRjctcRKAN2/tyG/TyfyKlrs0rzg82v
	 3vJ3ANJL2CH14KBEpw/oyK6p06z6CWYCLxfOKkwGxKInTNek+5uvMEciODasG3T8YUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oT0zc++r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FitktPRY;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A55606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A55606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oT0zc++r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FitktPRY
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E8121D001E5
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:18:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 18:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792707524; x=1792793924; bh=yaOagFavvL
	KvCNUfcbremh9xBV/gvqo9Jr3PEyUo8Yg=; b=oT0zc++rejyvqLkvC2LPZhHKfL
	uevqjTFPXWRnmj9Nd2hJMiA/TBfY93XDmT6a9epKDu5TPq5DRkuHKB9u95hdqA82
	EHRyqp6nPrKRFtiGvIcfYESPZYOOaMKhwo91HLPiSALPPmi54VpTT4ZKgERToSDg
	Mo1jOZ1AhW7i39ziGePVPIoEpvoeMLDtoiiueAJRIBy+X0mhjOqRn0LwFEcDJZth
	yviD3jtK3+XN1B9WwwAP4R00HJM5LTK4+ZrseZEYvt6KpQ6T8ufVXMNZtUU6Hqvf
	cafXErCeKxo0E+ffD5tMpy3195kLuPENImuTdvPjmveQNItdUrd++LrF4NTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792707524; x=1792793924; bh=yaOagFavvLKvCNUfcbremh9xBV/gvqo9Jr3
	PEyUo8Yg=; b=FitktPRYkduRL3vwacDRI0AsFkz/U1BtWbM+9gv7D3rde1kVgZD
	f6sTci2p/NQ5wWhrulI/Sm/DPzOli+HIJmTn1Th8a8IMlFVru23cCNzwBjmUCHFH
	TJEq4UfHICfJO8U2mpdoRqcPg5M/EJePEJnXi5dOm6iSr1jkeONR2AxpQAOxgNIO
	hT3YgHkgRoazczZ0gHOV3BayIaJKf4KwmFSPO0nDNGWaiyyCAneFgUc4heZ2kiDn
	DVqdqGHVC14kmeYMV1eFqIgGMA4xP7isb5kLKpQ3hwUX1RQDQe6dxdMhz7UWKvsC
	OtjlcQjCQENXA8u2P1W3IVV9saZar7Bmicg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792707524; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RWzqGKj/eEuF3j5gIzK2xUx8TnUoFpjNfyAgvg/ZDfgGifd
	7TFW8nHHj4GY5avURN9vQJ3b4d3H6jas1Of7SsX/BRMhe9AmtIU5oi+uoMLaCALf
	E7/C1EalGCY3HSaxbF0CQj+AptoXC1qnlSunjt6I8FI2yFN2tt0+Lbjqof3IsCnJ
	/EFvqpNTGjCE98oVUiD/rABwMjqqlDcVTtY/9/YGHEb6VYQ2m2r3bDyF80YGe4vE
	VWWG0aMeD3VptIcKtieamTJWM6RpSnZLrEbOClf2Pn4ygaycTcimNPjpMW9D+wg2
	LJcHAuAtT+6R1/mTWjgGoD5/4ook/FnLS1q6sIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SirvgwxzBo1U3a11WAucbmUs9vZ5pynAA51LndMWdzw=:f/3SewhVf7GFUvMagQc50sczt7fgB+na+2YnJYl1RWM=;
X-ME-Sender: <xms:w4vaakfjozqTZ0o0YUUgpoPe1zF6StYKW3DRw_KP5CJMB6__butSVQ>
    <xme:w4vaap7Q3kRAR_rV-CglVW3UEMAzpRlmXyV3cx7HQAPCLhZ0zCl4lUaVLIcrgoWlo
    VWbxGSq3G9k2Vx2HJfFByJ8mw1Q9cTUhE4u75Q_9C7NVL8Yk2ji>
X-ME-Received: <xmr:w4vaavUhuCAwKs8tu86F62wWBFfzTtJVIVwGGHdlkbbysZamynPj-xzpbzCz490SBicoVKjnOsDP5qTJ7quicgJr1vG0HzXJcEsJ>
X-ME-Proxy-Cause: dmFkZTE2+wgr6lPGj6/I0g07qllMIsadGu6J28DShLNTe4ich0uM3Kf95XpYeGMGOfLmWE
    LYIqepf6Gb0ssElsn1Vjy3tWpfKYwSv+Uvy1D4XOh33s8mXs6yt1V+aWiHzwCLhJ9gBGLL
    ok0nW2Fnc1HErBJWQThCMI0HA20bO2LT7hm5eXpoahEmUIjy2T3LRc100o8V/uJ5tgywTp
    jAKo4PZtQXB3DPKhhMNQRvZnzMOIsOcVa9n2VVJz1bQmIOedrtlP4LD6rJaba8j93tkpUz
    OhONLM3ADbOGvhz3o1KdDeuFCjgkAFM8vYdCzOjomD1ZHjs4qYXxJHaY1NySIEy+JBQhTM
    ekO3DOMnC48P5AlNqrLeFjpezw1QBle6jAbFyFg45UbruEt7VD6X0LbnBpkkmmhPVkOmiJ
    rxRrgz6g9K/bX6urNmQkgbLsRk7NIZib04+jJjPpP+SKHgfuTDBKbXLujUHAeFkPF+9mXF
    1JVDcTjdcIbJWz+IPKq6tJyk/hhr4dOt2iSoRxQ2XD9YS2rIfL7g2NStNHgrjbMfNAzDML
    h6z8FdTYxvYyb9iEaYtl8oM6ex1u3APpXCzpdvm63oiP1QvXz8Cml1cZHMlIVfjcJ+01nv
    rEIcz69RdYGiG61PV9QJ7JRygNSAKRCIoCzauRkp6JGS1rLXymBoS3cOGd/w
X-ME-Proxy: <xmx:w4vaag4DsgS4UHcNqAPtsCkoXtWx8bWiPy8tQSWY3rZKHMJQ10TANA>
    <xmx:w4vaaiqw50ns09gJHh1FrheLXU-D8bPvEud_SZ4T-CX4jQkUDaQxdA>
    <xmx:w4vaarnc0wFbXZmfOYBR4l9KZdvlNTisLW48VRzhjJWWiT6Fpfciew>
    <xmx:w4vaamOnFxa0-s9Z72t6ATzK-otLwvIj_FaUm9d1qesQvis37chj4w>
    <xmx:xIvaatBstazzmAA92XFae3T3y0eS3vIQwJnIk27_jUsU8dDswl7unkbR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 18:18:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/5] root refs vs pseudorefs
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Thu, 22 Oct 2026 22:28:48 +0100")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
Date: Thu, 22 Oct 2026 15:18:42 -0700
Message-ID: <xmqqqzhhcrb1.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Since 993d57eded (refs: pseudorefs are no refs, 2024-05-15), the term
> "pseudoref" has been restricted to FETCH_HEAD and MERGE_HEAD, which are
> not stored in the ref backends, while other refs outside of "refs/",
> such as HEAD and ORIG_HEAD, are called root refs. However, a fair number
> of docs, comments, messages and tests still use "pseudoref" in its old
> sense. And while the glossary describes the rules for refs in the root
> of the hierarchy, it does not explicitly define the term, even though
> "git for-each-ref --include-root-refs" uses it.

Thanks.  Overall this was a pleasant read.
