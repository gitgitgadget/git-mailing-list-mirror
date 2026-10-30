Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381999;
	b=3SWPTGuj0QoDzK3y4ixB1UpI7JeRiyzWIQtzDA1XsVtgtdFMLkwwEwin+iHttv3gIZnI
	 DcAQC1+h7DNUX65e3ycZfgns7mRX1ZekdBaZr9MZAF51ezKd/43+4oA0Yui8w4VQaOAEj
	 TDtwpzaRD/2oF1e0bpuyGvRls5ZqPzCveXrJIvkuCc0Xx7dkZ0ZLQhe2IJP7FC2cw2iP3
	 AK0PZ52xDjz+GrCpY1qlbQFHMPxOs6SdFVrTYillRwYoDrcncyE9jo88bk0aof4K3ZePl
	 cJVEBCMnJKMAd9Ms+tr8lD2HraKNK/6qH7XwABfttmS/59XjNqHUVbeHzORzYDjvjvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381999;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CZh/8gKs7truupv80/SmJH3P4jXFp8G7PRQQmCCMpno=;
	b=PZqBkBnVb0QOJj6YG06hfLPxcqMeIsr9/YewZ6rhHMM38ooPDAf12bObRGpw34AsZErU
	 bn3Qbqy0lXGiP8sBJarHlKsP/yvgREuPH6EAN3rB49Tj7wgVqlGhZVuUnhEQO/YXzwKRm
	 d+sTrzjwLfyuz5wAKZfVISsRr3v2YfnBH1Dcfp1gTva1X56fV4HruR7cY5zIj5vN3wPIx
	 oKNKmIprKLinMu53KAiTOjmkwHCooEf4/pd2EUJdVFMPyoOGnF/Y4knMOtDRFpxF6+dI1
	 cDD1S9wlaUM4IXpJutCNt1CbrbBF9EIWXr6Bq/4CoQtuPzzVLkAfRaxrPOJSH/n326g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V8hMj6pY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="HiTZ/vTs";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72899606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72899606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V8hMj6pY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HiTZ/vTs
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7E597A007D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:39:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 13:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1793381997; x=1793468397; bh=CZh/8gKs7truupv80/SmJ
	H3P4jXFp8G7PRQQmCCMpno=; b=V8hMj6pYDaSnnFc2PgidJRSZL2IJSLaO8kSmv
	xQD1Tnut3daXChgiw0pDsA1Jz/+EbJcJWfA/2t1dINKIItfM7ZoBUw9uRGObtYyL
	aBux0np+oajoFJV3gcCpO8k1KjttmeDxCX+FlvoKpETaBH3ocOS03Wf8JIA2S4rY
	JBArBeVfqMZSlMndXvBqJ5+peJwGnDDuOt0mNW4QHc7da5m5T8O9/9lgBxBE0Rqc
	hb1suTNmF5czdMDPjmJBkod/vrcUU8lGifWp3d7dcdGPRbX23SHhpIgeGKl6JVL0
	+nXxE5QrpVrEr+EpPPMNGkWdzVsMxX4QJ40VCE6V3dwSvKfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793381997; x=1793468397; bh=CZh/8gKs7truupv80/SmJH3P4jXFp8G7PRQ
	QmCCMpno=; b=HiTZ/vTsDFKzLwMVDSZLtAA/fZq9d3z6pPcY54qXji+9O2hP1dh
	af7J/gnvppuV/d+oEjPcwEHtYXw5mzZYFi5WFaBHc+zEQ/9efm9xVzF1X2c8cdsg
	V8fv5smtJWiG3F+eoSTVpQRZPStGaoWTKsu+LU6ALQPxHGLJZuntF7tupvrx79u6
	Kk5iCowIiBKgHmD4jVEHg8o7P7IKbpS40r1irMALUJH9rbE7LOP+xhQmpiLC4va2
	r+2M4J3b+9oQZvJ4dtX7dNwuO3TAE5YOAzM3H/tIeoBUaTbV8OzV7pptbih3Oa+H
	eTUy/IsrfgLHimTiloE3vTY4jPJrPN0vX1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793381997; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TfG2CfutMrRsfitXpzo79kUq4ue8zyQMv3v5jO+axT9U2yU
	pEef+6wC33hXlY5Tr34YWaiuXX281glMzizTuNtm7D6RCSZawOAMNIPZ5UhY1Hm/
	pVQLWjCo8AKmxfDK2m6VM1H+d18qjdGAiuaT9VriUnWOh65XAYLd5bxM8Pq3rLE1
	qSC9XsVd895fHNKkAhsmvzoo6rjG/FFnrkeaiILJxXIZ3nDEj6wcYfqumEZarrSo
	JTVrkRYg1bki0TjprFLVLfYqlNS9OxiKuIQa0B+uknOiPevZpESrc6fJuOiduv21
	A4wFGsFQOYKARvfCxuK8LEai6rr46VyBbPmz15Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=8;
	hn=content-transfer-encoding,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:Ir98YZJA1aLgbAvAPjq4L0OGPSvBR06uo7aeEPaJ+Aw=:duIYimcgn8Hyx7AHxZ2B+MP2Oe4gmdBUNPhkMy3uZf4=;
X-ME-Sender: <xms:bdbkasWzwvtoBw27aXhSwrUGT0PoIGw9VbXp8kEQKmVpjEhbsazKOw>
    <xme:bdbkamkomYeaoB0e5iEffRYRIn3LQ5EDaEUSolPfHf4oVFYWRW-HbEuz5OJ9VEKph
    mVGNR10YTwz5TaaRNpLzLF6knRmNHkiXF7xlP50ueaLE0fU8BEkfctz>
X-ME-Received: <xmr:bdbkauCAmdmoyRe4AfQLjgkfqTjawZgmprcrfmfgFThotyP5FjK73ojSGzbQBgXxYY9pUE2lx8VWib8V4bd1Qr3xRRJkujS8FjiO>
X-ME-Proxy-Cause: dmFkZTGRq7shiUjrqVju2jWP8FnQO0EgbLc2meIjqdTQQR7zMSVSO8QyDxgcXwD1aiYUmX
    DL44bxPE1LDYu4p72bRH/DFvy4YZ9pwHOLW3pc8kQ0DFKVpJdfaULGWSpcVn4/TZ00y3ur
    CR1rWN2vQyiFMioDq6HPCmv3q8oZwzFhM4PxiGwm2eFIbeRbEk667Xz7YWihAZWxymYu4N
    2Tu5cfZ313dqWM1mv/R4eAtMRgS0F3uqYAx6lu1VPg0mhn1rORhKii5AzqakRk5dmyRp/b
    mCqITPgV1RlgvNqXq1v3hY0nouNYwAcaQMzeFdSJMprVbSrsF6elJLVx3ZBbMw0xV8L8Um
    eePOrynK0Cl1enATtkpZ4qTn+0b7uDdW8iAYgjVqvphFaO2U67ldqiZNsMcHmUdkWN9XBf
    MpDenyE0X0VE7b8w6tx9V+4jzEXUoSDMRnryJwDDoUgLlNapHYw3UF+85AsOexa1lnmkjW
    SPbuFxJhuK0nlgrQ8+Df/TlqueFALAvoF2+Xrx2QD5wmOEjg36gPM+d7HpmewMwYj6F5VP
    ibqrn5r6Lq3rLrBmDr7AgVxZIUO4U9GWyHYlbafLbMXBuWnQMSM8RfujWTE8raz2IxtWq1
    rmtm5gtdHrFlTLtyqzHg2ZoPWR2qne9q7th0OkN5f+pn3I3bVMLGCw23VQzg
X-ME-Proxy: <xmx:bdbkamdof8bHTNLp9KjpJqTrAPBWpf4NmJiSIjB51F2xcREk1FRVYQ>
    <xmx:bdbkapJ7xnZzrRYJ-LAXrf7fN0JIjYK2N3ZSVdFIQkF1_e3iCnr4lg>
    <xmx:bdbkape0twn3ERBA61FTalfEGAfPIWTJnIpA9_QCF-Gz2uX18NNZSw>
    <xmx:bdbkag1BQHj_W9Cfd--WdS2n1VPPgwZPwuL3RZE3sSmOow2bl3j6Tg>
    <xmx:bdbkansI3ph99DXkPmt0pdJjpfL8ypJzeJ8W27N-5ynqUmmnSxZjyvlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:39:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] mark symbols that are unnecessarily public static
Date: Fri, 30 Oct 2026 10:39:52 -0700
Message-ID: <20261030173956.585250-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-486-gd49ba3b80a
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Over the years, refactoring various subsystems, adding new callers,
and rewriting them from scratch, made some symbols that started as
static into global, and some other symbols that started as global,
no longer need to be visible outside a file that use them.  Here is
a small patch series that turns them back into file-scope static.

Honestly, I suspect that [3/4] was probably better with a forward
declaration in the preview I sent earlier, but in the longer term,
readers would not care if this conversion ended up in a large code
movement, as they do not have to even know it.

 1/4: ident: remove unused author_ident_sufficiently_given()
 2/4: add -i: hide init/clear_add_i_state() functions
 3/4: read-cache: hide refresh_cache_entry()
 4/4: unpack-trees: hide verify_uptodate()

 add-interactive.c |  11 +-
 add-interactive.h |   9 --
 ident.c           |   5 -
 ident.h           |   1 -
 read-cache-ll.h   |   2 -
 read-cache.c      | 258 +++++++++++++++++++++++-----------------------
 unpack-trees.c    |   4 +-
 unpack-trees.h    |   3 -
 8 files changed, 139 insertions(+), 154 deletions(-)

-- 
2.56.0-486-gd49ba3b80a

