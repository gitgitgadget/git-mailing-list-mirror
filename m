Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395505;
	b=eMiz/8oG/bYE+c56wiN3S7KRq17ygw6/updxFagxur8xeiV4GDhJhzipgRJhrWOrE1U2
	 eeXi3t29TK4LrZ/WnKmpZDUVHz8e3lbTzzdA86/su9kokR5F9+fiR2Z0673vCNPpUItyN
	 Z3hTnIzIn6kvZrmKZB3kE+26Wk+Ap7vdFjGTxmXtNpShLYfK2GLKc1LS+7vYxTPiNgOGd
	 tsXc7FdfonnTXY5oCFOxbEUrnT8XVAwqJSiqCKaJ+J0iFI/SIKHXOTYAw34dnq3+U00nS
	 V8Ft328kyxGSa+HRyPxVmGm1gARtJGUB7Lc0V6w/eJWBakw1mT8nE6frN5FJWr8GOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395505;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=czKxT4YUpK0bcFHJ0pnlWDjD1ITUZyIXBths4kn0t4s=;
	b=FtP4zz2k6H84ER+SZ94p2TT0j618WMV78lBZcllifFWy1MSJTcfHATs2Dn4KoZuyafUv
	 bG797Jj+MUzRcL0JX/wq17288G+ovGQzva37jUwQJ+91/Ig+gDMpt4AHav0MBoHsxTPfA
	 ZqQV2lwjXIvSqbQM48KD8eAUUsMCV66lJ2BF9p0rDTNTjO2wN7mAeibBO6/XaE1FcYH5c
	 7KCKF+ggUAR97pfXl1VgPqtCXB5JciGEpcZX8KO4uNctj1zpXkqjuJTh6TRhmBrmypRPB
	 66/Br1if/NLVtN5+QaWlsFww8vC9bOt2VHTQZcshKuyNIfJBSP6lYEMKmBdz6YdDLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aKSARWRV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jkT0NsyK;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B76606A98D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B76606A98D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aKSARWRV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jkT0NsyK
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A19F7EC0192
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:25:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 17:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793395504; x=1793481904; bh=czKxT4YUpK
	0bcFHJ0pnlWDjD1ITUZyIXBths4kn0t4s=; b=aKSARWRV0SL6Nmf8yXlVrTRby1
	+T3wzULAMI1ct2/wixhBnVRMbdk52z+t9nz2AmGTX6Lc3nBX2zBg5lSfjEYe7VIa
	oTWuDqMlKlFdC6zwwqF4wP3Cqgk8oZdhrt35T5WQjsJ3yyEDRWpiPA/8ZPoWNZwA
	GPkzoxIPeVScSOF/sAeMEyyp3LSF86q6cH/tNjNEVBjd5DiiZTqB6tByyVM65naH
	jdEtENI7z/KQ2x32HB0b3iq2swHAeVAonwk0DnHncAlovEalkUwC6SHBNsW4bZmc
	oJveSubJYU/Xpq5yLZCuXCAIuZi9rUlCTlHoO0bhit1QfNk9aiKusY3e9+fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793395504; x=1793481904; bh=czKxT4YUpK0bcFHJ0pnlWDjD1ITUZyIXBth
	s4kn0t4s=; b=jkT0NsyKRj693N9H/20El/uBdB/Rdgha4xRdKY/0RWyZRwMAZ6y
	nJeE/dONDBPfEcwi6vpbuEnqOeuSAZvmQb0YnPL1+vKGJ7IY3Kn2EWgoHy+tdRNp
	dX4KCZkLDPM3jmFbjCypYB+2RGxp+p9do98wBgZxP61aa84bEWy3DiWwYdblkeSq
	uYQHznGnlFKfQ4fPKvrDjkpzCNGs0bNvInLMzclaFFIRW8e27TtJemjw8nuGIRsK
	OCKaO6xVPIo7QT+o+VLqJWfJNM1DzK0YF/24qQG9+a1imPk/tPCfx4MEz+KzF0mi
	FlCQazLo5e0oMFWz3FxNmX5Yf6XrCdcRvBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793395504; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eaZEH9Oh1gvcWox2uY4Rs5VEKfVaxxXaNndLET/oDudNFz7
	5wT/W9RIVzkiR6kk02rS0da8XlC4HNISXhT80tFdtwgkUQ3siBCemGUKEho2h5Yb
	JjPHGLTTYRLCpr9ejav7YFcEl/TH4tgMmQHXq10xYmti0Wqdn1OGCzxmtLysQsvq
	/RwVjVD5RQDDGphYH5KDIg5MT6qridUj3S/+pYunadDVMNdyM9o8X4WjuQRHvYss
	kslnLMa/EbRxcoFSD8CWjinFosOuIjqxbQ1laCtFkEyy+mzRnKpawcQy2Ami/Ql6
	kbErYXrydK92DaUCu7pBSK3RbX8mIZ9Lf7U04FQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ioOWhLvJk0VM6xyvn6HQ5BUc9zwzb4efnUBi61tB7MY=:zCu8XTyK9a+ws0Gx+BQxD0AwFEKDMUb1tiPcreOKkk0=;
X-ME-Sender: <xms:MAvlaoxC8BHhClzENyi5w19H-Sbq9MAmOq6LIcoF9FozWWo2FfpCxQ>
    <xme:MAvlaugh9D47A0N4Ul91XW_TtmY1Cg9P3UqHuSSYyoCsxXAur7OjnNvLyL62ggHX4
    TH0e1wjqpSWe_g7jvznBRqLyud-PzO6VwTvqA5o4HTblP98lKc20A>
X-ME-Received: <xmr:MAvlasm7jIHEjuoi9RGq6Yacj6QjQSU7UZuujXJoQNDaaHyzTY7s5v6-zkBCq2NS74UDYbqxMOZiWrN65ZfsiWoYfmKSv3QdWFy8>
X-ME-Proxy-Cause: dmFkZTEfHnoDFc/gpmJqVH7dDfa8szJEg0Fvas15hMFrvKebc8IqUPiiDf9cDGprgE7yXH
    AR9ML+FUz0gsOT1Z5iBy31Fi0R/akEH0stG6vu7nuTdQasa+F1BYJI32eUWIGpPUP2JOE5
    srVujzioOuGXF8VBZPu97zJOT8GynECb+8rcf1z53GIHjaJQOpgeaw4s2zOawJuX4JN46J
    eIhjdlNSSSU1SS3qTQikrZActWMYYIakRnwt8xOLDWWlook39e9yWRsQksRBzdDw/qLn8k
    U8ATptne95AsKPSXM0UALlsPdx2tgk9Hd5aK5j4L2vQGRysjOZ6da/Ege1X9StdpIRlTSN
    b5TZh2AhqZ62p4X2j1RpOlXduPxkd6wyY/DFmg38Kvm5oS6UWTdr0pmyhhK4fYxN5L6WWg
    p7Ym3CEkub1aaieVLj40AvTlbIu5Bns9BEUo4mMZR2YL/ssUrwpcdt3fDeIuvswnkUB4lR
    ZaYkx6p+ZQ3oOGXkTqy2eR/o9afWRu9hTpuy/pvqmGMy7ylphsgcA0RT3M6okFYIit+xZ7
    aRcsFd8ctesmgRD+r2VejpyrBhG+IblHwfHpWJvhPcN2yO02arUiHxDtSywXDFRxslyrZb
    GzNDyx/ZrZCb4NOYX+VCjO+kWh0vEq15CxpRu3Ht1zBEvGDAk7yRxsMdxpzw
X-ME-Proxy: <xmx:MAvlasj4nZNxPv9UuvBJoQ543cLXumPq10CviEM_YD23s153sAu6Vg>
    <xmx:MAvlao1x29dpb6ZXmme-c56M2D3iOzg3T5AEwM3W_LuHFfhTCNULAQ>
    <xmx:MAvlatJmvVZ6ETBQ0q6-6uu4wwEb1SmYV_gI1t6ZJMvqdPk76mBCbg>
    <xmx:MAvlagzPd3IaBVNjIMZE7Vu0msAgO24Pc6WeeHDZtNDg2JIhGmJIjw>
    <xmx:MAvlasK0IL2pC10AQ1Rw5mgDAB1u-XtvOK4_omHYhWZmArt6PTMAjrmR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 17:25:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Tuomas Ahola" <taahol@utu.fi>,  "Richard
 Kerry" <richard.kerry@atos.ai>
Subject: Re: [PATCH v4 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <xmqqik2ivqht.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	30 Oct 2026 14:16:14 -0700")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
	<4b40588c90c82549c9774f14cfeb4e4741b66386.1793198687.git.gitgitgadget@gmail.com>
	<xmqqpkwtag8d.fsf@gitster.g>
	<13af97a1-a86c-4077-9136-204c74f3d625@app.fastmail.com>
	<xmqqik2ivqht.fsf@gitster.g>
Date: Fri, 30 Oct 2026 14:25:00 -0700
Message-ID: <xmqqecd6vq37.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> If you ever need to update the topic, please make sure I do not have
> to add these fixup commits.  Thanks.

Actually, I missed a few more that would affect check-docs.
I'll come back with updates later.

