Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263049;
	b=qmdt0pPAUCwajVSp74I4trv5Ppoy7duMoeP8rmV4Ca72TUT+JsOvYeYCl/k+5QzkDGt9
	 0cIbMRFaNJfNdcbcdLD98Mf2MVQG04dF/EoS49uEewUL95dSyoCSabMEtMwp+Ufs4EkpC
	 I4kLXuB6AstEX5rlSL2psIp0nzdWpO7qpBVF7BlVttRKTkrpcSmrQAQxYGUl2LrQNOcp6
	 9Szvvos0yMo2MnlyyG3LZ//vzwAJ2u85tqaypn8ONnCXeWVtJu0bIzwE1TalfVQuliE1W
	 PejtM+I7cRJjsiIHib3JK++NwPeunYAGKz+s2zS88IMpir8F9T4T07Btwkpx0oKZ+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263049;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7sfFy24c5ZRIUovU8j9wLf6AhBLgxW/QF+le4BQTz6Q=;
	b=Y8bajKUUS9Zh0v4e4O6ih34b6NossrRXWeYcfytP5kpcXYfURUJvAddXRhlrpnT2Bii3
	 zZ9Ef4r+6173G5A13rasY6xRg6IZGni79BUUU2JsxCw9qEb7HvsnwbrE5KCn8ReiAHenV
	 4sJKFtBerTACql26uxlI5xwmMazwxVQYBqwQhjKFEGJWIval0sWLMRAhrCc+ocCpl6ytY
	 zd6rN9dwq6m6OiGxAs7VtomR+2vTpM2nxwYneK8X40jJr513OVa3jQtGIFqsjNlIdWVHk
	 VmERRTqoLJRvq14ZLe0A3qS21zLI3ZyYzeiymLYsBPQ3dcDeaI2WCiFgSdUIahA+8Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AuNJ9FSF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=InG11FUy;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C7606A329
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7C7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AuNJ9FSF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=InG11FUy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C8651D000CD
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:37:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 04:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793263047;
	 x=1793349447; bh=7sfFy24c5ZRIUovU8j9wLf6AhBLgxW/QF+le4BQTz6Q=; b=
	AuNJ9FSF701vCd1DFoXLhR2BH2bUMnNolByhAkPLjpFHIK6KMZLtPcLbLQF+SZoE
	2bnThdT+1xfIp9Xkzm6wg3VfN/n1g+e5Q0xckS/9xo4zko78Crz9/6IGHeGOp/JI
	iopM+HEF4coaADbOtd/v7uRTFHKvV+sF+xLtS8ENP2Xlkr1XJXpqJsB63Oi++oy9
	6Nns7KBsa2mnMVrxjdDGT48JX91y0uzf2dcwETJMaHrUK3UWeB248xr4kPOcN2KG
	00gG6ckeEeYUH33XrsNxHEkybKa3k84UCSg09Xv+2pNYAVypuM/S+3OSQD5AsQy5
	kDe6BrLJl3UICwrp7xKN0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793263047; x=
	1793349447; bh=7sfFy24c5ZRIUovU8j9wLf6AhBLgxW/QF+le4BQTz6Q=; b=I
	nG11FUy4T/R9PkE0bNpwJBi0YT2Etav/cueVbiikgeVLn58PKidjgDmE2KmKJwJK
	8JB1Avi4DLPKViJYvUSbpzyyjSKS3ACLsKJeTu6uXyN9z/hnknw+7Xw1Iqp/V2kN
	gCoK5lG7hzQM/zm7F2H8PZeyLky8HQRRX+A7rnB1cctXpNBXUPZcV6zmxxGfTwwX
	QfQssQu8gsO/4/tVXgc97IYO3IGp/iLyyqy+dOgA6zO7HkfQ+bCPLtwpIrapM0pL
	ymx66oIBjaA8PqGlHykNU9w6FytHbtZ5qqYU+zdDGLklgo0avMXLbsvlOXB90PkU
	cXeMcGSl4WlBUpAEe7EtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793263047; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hMcJ4GPkoBceSdjf+qDBSUkiwr/qsB1KYLVuHBDTwpzvLrW
	roZSuYiBhV+U860AmluKRnBup4BBoBdMYFSDx8HNOx+1l0DBpG4eqIh2GUm6v3X5
	6pKg9TUbsqQt47gltRrtcpQgBscOuIXZ5uv83TdVM4gbb1wIVn3uU0rhccHmckas
	+wFP1mT4nhBpkkqHxdmid/nBS1zHJMJ0jJlAWSCP0J88QPq9tDMIURfBc5XZG/oj
	P/0aQIR6JiZ/ULqB85gns/Eemel0gFH7jyGDvohDEYYcLxkjoHNWnpS7RQs9Samb
	TiRFFFBEKAI9XWH2+bHqoAciDHs3fiPZhdtkeCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lU+HKm1ikiLPw+Z4G922YsNfgnmZ6jA2SVBrR2MKoxU=:TOO1b61M1daeapCABO62RAqsv+TJricFThBr9c3b5Ek=;
X-ME-Sender: <xms:xwXjai-Abo1Gp-sp3KlZHnxajHfovogG1fbg-4umq-NITVU9rBKIBA>
    <xme:xwXjaqLFXB4d_8bki0LZ36pR3KB61cERlpf9QxHRgrEu9r06iPIevMnJM3Cyhk4gl
    t0Gmx1diB8qDCBdbCfRKXrnfmEWQHgsnkZljNGZf_swa62jIHpDiX0>
X-ME-Received: <xmr:xwXjala65ShzVzYDWq2-lkmpHL-w-e0s0f-Z9kyIfLDBtJGf1lH1xg>
X-ME-Proxy-Cause: dmFkZTEmZDcAzw2CKITXf6i5OowZXswcEwRiKSzjPx0WGnwnVQxHelsKOQ9aTGGyqvaWk4
    obbJZBwi9mLv2sdBNUyUe5Z2qtrCrzCQAcoXj3szY5+iVI44gKQ1DPeHpXVg6ttjmnCooR
    XKXv+2nL0yFrqOOHWTInp4LLXnUFs1xgm6+iE//KVUfKouXgdTzF3vC5kLW/7henEA7OaL
    2XJ3SKJMI/wmqoM3sZrinkDzrILe6AjQiF5NGJnbY4FwnYCE1fkV9pHzW1+7upIphEGWJq
    quEbiEQ3yLaHqhI75+sFRBKjAq2AZZRStBzlRgrb9MF+CpGGfdN7XY0P3KQu+eWW27bqqF
    woZ7yYrb3VsTNdE+27hy0mNtaJY7/MvMdvqw1/lU7h+BMlWtVIKBQZDWCwzNeoUwpbXVxX
    wfYvd5XqPTVAZzkrYMNxgluZp2FCMISXRSgfpq6eVEPtygof+Qh3eNwJA0saDnX+wxLnxZ
    Hi+Eh3ZMCCbJleBq2dB4jdtLgHALzwitTmrdtRJLZ9aIjWB/Q76V5kUHrwS8nULgcQ5kSu
    ad+Q4Uis+v3/4JxXV98szpiekhVhTB1tz2oWEKk3xuogoFjMxDO/x2IC8IYncp1WgMf9TB
    Pelc/MdLFd0YoSVGqKvvmEP3xYBs1j8BGFZ5Qoz88KGDVSp+Acf30fPwdOtA
X-ME-Proxy: <xmx:xwXjakIeTBO6z_pc6BYJ8avxfgL70NcM-LA2sQ0OZS5HVj7yniN_jQ>
    <xmx:xwXjarCp0SUKPE167nTyILk0vkcYzN6vJfAxqnS_rAtx1aFD2nRX-A>
    <xmx:xwXjahrhipGrwB3XXf4bAQP8V-1sa7rgqmS2q0UkFsqoRXaY5t5vpA>
    <xmx:xwXjaug9KjyBkyh49tsJW67XN-7BnbGN51bOIwOnwjlqac1T1OGAxg>
    <xmx:xwXjamIOO2tXjDxtog-8EUUSLDEo4ByBWqA9HZeAozmmAP_UhpnQ2L5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 04:37:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 026781a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 08:37:25 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:37:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/6] odb/files: reload alternates on retry again
Message-ID: <auMFuqIR_2ltdSPY@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
 <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
 <xmqq8q3hdcsg.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8q3hdcsg.fsf@gitster.g>

On Wed, Oct 28, 2026 at 09:12:47AM -0700, Junio C Hamano wrote:
> H
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > 3:  da5a24624e8 = 3:  8882555124e odb/source-files: reload alternates on retry
> > 4:  13e4e857f68 ! 4:  64d76b0ac94 odb/source-files: simplify directory duplication detection
> >     @@ Commit message
> >              Wall Time    266.5 ms  ±     2.8 ms     262.6 ms  …   276.7 ms            -7.8%
> >              Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +5.1%
> >      
> >     +    Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
> >     +    the newly added set.
> >     +
> >          Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >      
> >       ## odb/source-files.c ##
> >     @@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files
> >       	/*
> >      -	 * Prevent the common mistake of listing the same
> >      -	 * thing twice, or object directory itself.
> >     -+	 * Prevent the common mistake of listing the same thing twice, or
> >     -+	 * object directory itself.
> >     ++	 * Prevent the common mistake of listing the same thing twice,
> >     ++	 * or object directory itself.
> >     ++	 *
> >     ++	 * NEEDSWORK: we're using "core.ignoreCase" to deduplicate
> >     ++	 * alternates that _may_ be the same. This requires quite a bit
> >     ++	 * of boilerplate for dubious benefit:
> >     ++	 *
> >     ++	 *   - Duplicating alternates should really only lead to
> >     ++	 *     regressed performance.
> >     ++	 *
> >     ++	 *   - We don't properly resolve symlinks or mointpoints, so we
> >     ++	 *     may still end up duplicating alternates.
> 
> Good thought process.  "Mountpoint" is misspelled, by the way.
> 
> >     ++	 *
> >     ++	 *   - The value may be lying, in which case we might
> >     ++	 *     deduplicate alternates that are in fact not mapping to the
> >     ++	 *     same directory.
> 
> This one is much more serious than the previous two.  As an
> optimization to avoid repeating work known to produce no new
> results, deduplication can tolerate false negatives (e.g., we
> thought "DIR" and "Dir" were different and ended up scanning the
> same thing twice).  It cannot, however, allow false positives, which
> would lead to "missing" objects that only the mistakenly
> deduplicated object store could have provided.
> 
> >     ++	 * We should investigate whether we can remove this whole
> >     ++	 * mechanism outright.
> >       	 */
> 
> Sure.
> 
> I guess the previous round was already almost ready with Christian's
> review, and this round addressing his comments, we are pretty much
> done with the topic and can mark it as ready for 'next'?

Yeah, I think it should be ready to go by now. Thanks!

Patrick
