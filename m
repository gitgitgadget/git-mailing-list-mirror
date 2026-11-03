Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716599;
	b=JpKuJS9xqG1xSL1l7RT78HM1xiFc8yot0MuD6Mg53W4He/QM0pK+rRN3gEWgSniYKFPh
	 iaPGZfwEivs2jZ1YV+FY8UQg8dNLDjuzLwifQmATrVEJZ+0a72U56o07u9Q3UAq8LWkB/
	 K0rnscUfWXra+yW63XPmPCtph2AIsv9OV1jQ3vGGOZZ7Mzc7uyk+9cpGLkMTkxn3w5I/X
	 MjTUnQGmF+GwWcqSfKksEgd1b/1cXREwK4v3pYPnncnaG+MZTwAwP9JB20ZaQRNKMoGCj
	 MBSz6WSBWiprMS2N3Dnk6aG36ChU4WdbmBrsuG0pdDyL2lnpLCg2dniXL+pai/cbo8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716599;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=5Fp9fYMrjzyP5O6dcjWrG4QeI0Gb8Gqao7NDAOlsNTE=;
	b=OlbAmnNqySiqpoHkPVXtqegTQNZh6CARmA859vOTwaXMTM0TI6tYY1ym8x9wGU7V96Ca
	 WF0k5TDkJ1MGETilT5I7acdawgmVenVTgo2rjtEXZl+D0kmRNA8wrrZEUqzuWutCh73vo
	 sFO2Ruzb0JcoTSPSRpfKNycMMnRo10EOTowoCaj3hmZRDkR8qMFSOkmmiWiMSzmWfvQ0k
	 soLiASdjBH/08DLjEhLl1Tz9chS/1eXNLX3nBTNZpnyqztRMcJqxXqRvvZPRMq1B8rt2W
	 pQhb+Q7OpNMi6z8LqNAVMhvnCuxHMjCyqlKaF7pGjBsuJROR/y5VWd2KuwVMhXdQV4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=dh++cC8G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OY18bzuI;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A4606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F3A4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=dh++cC8G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OY18bzuI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9B9F14001E5
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:36:37 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 09:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793716597;
	 x=1793802997; bh=5Fp9fYMrjzyP5O6dcjWrG4QeI0Gb8Gqao7NDAOlsNTE=; b=
	dh++cC8GeiQc3vidvMETvQa9XDvKM02r6d/343PWr0S6hadspfMLAm9gmX5nHZ5N
	B3ZMHo3xSDMZvvHwPTWdWgjJMg3VrbCJhFD0zY56NIugw06J3+mB0j7RiR2uO78h
	lyZrG0D6FO3NBqqFBMCp/NncvVdS3sXz8o6+kbvZowQskKSnjAdV6ZcGcwztJP/7
	KPXm+8ct8gI1NXQd+ftYyWf3CjyfV/ygvuqUnUhW7BMfpRAGBsBPoIL8m9y9nF8e
	sLxkjp6uJlk2w9B6a0evqFCv0Uwl9yZMNt2Wp/znV1x1KPkO9CgJW/8OXa+l5JlB
	tokvhIycQzB42SjOlXizXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793716597; x=
	1793802997; bh=5Fp9fYMrjzyP5O6dcjWrG4QeI0Gb8Gqao7NDAOlsNTE=; b=O
	Y18bzuI9/REdzaPnhjtnhk1FsdTIs+gbIpEqSLBrAeg+YbwhQTJz19qrsXEB17Vi
	OEx5+vPV3AMxavj95I/cIkEmwYnqOroO/sftkyqx/U7WkGIz0cm5TUFs8L2KAa5I
	VkSv4kQsAajuZ7mG3B/RJ65EPzJtRfb/nOE4WvVMEK2A9h3Onyof1szBTBjzQsGS
	R5gzYpWKWvrvOkWQnIiyuwjPEw27O255FEHIVswqRUF9llAsGrNsRkIT6IW8B264
	VaNsOPqEEame4fYc03lIouLbpe5YDMyfkMMjn7wpUSK8vAocTFTvrNNta2HiwiLG
	f+0ULvfOiXyjwZE88pvAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793716597; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Kt7tGywH1tKKnz/rIWjOydmlyw6jhMaNHz4hb4gLXwVZv9u
	OB/7hniTpWo4c8FPyW3Uxr62MwaMb5tr26XQVkXt5b2Svgy3uuPDUz5TAMs3bJ0A
	u000E9dwwO2sam3OwjqDSutXS7CP7AyXzLQGSMkrUaNByvEThFGy04jQ/y+wGsgw
	EyhkcG+RrLyXzuCXxu89AhfSCBoT4Ox/DhRyKL8fAj/o9kpsA2HPWik8mBMO381s
	ebUd1Zyq7NFmJDZtLnSNY6AnLENePyMljRxARVTnaG3945UaolkYvAVH78h88y7J
	X7XBA3XMjUG9Sp3hug8e7w2lkKrSrqqY/T2Z+2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:So6kFxUmAE7hESGlQG4vLuqVHo6be1Qtq2jEMomXV4Q=:U2et4x1Or8kAR+irSIkD476RPFZaU4xAM6wC1jSEbCU=;
X-ME-Sender: <xms:dfHpatnj7Lze1GPZpUz__fsDy3qViSmcQFG6bRLFEHoFK7rvIoa_Zw>
    <xme:dfHpajrNLFsTdLin_kwmlPaawL93Jj2NduFVW8VAmf_i2jnwoeUDbBT-vGx6HL7W1
    qAHTxkPwrBIPyjFmGuNbQbSt9A-lXEsIiB9ZXmTk38amkAeDN66pZOt>
X-ME-Proxy-Cause: dmFkZTGRtH7hLP10RaYI/Gc0Rvqx4wTAwFrMs0ZtzdckIy6Y2VJnnqNGXb02YmNU/lq3d6
    RI7xqK9H0ThWpsg9xTK0Uma6SF1teapXgNiU0nbk6ietFBPNiFJJTir+cRlYWwXupAShYI
    C4Q8bxNdwpiDMWLuPXuUzWXmrGTGwQKA5SFHS+JWUSU3zx/1Ze9amO/P2fNcAPPnmMwC9d
    dcl3CCXs39/haqu6kIxkXRJ2sW9V1E7kfxgXsluCN51MK5fI/RuSxlO4AFmZMA44kTOEVu
    D6IUKPpvK4M76JlgS8efXyl930tfh+gYZM8KnxrWm9/PHLU3VD7i1hv4XVRIh5vpZCyxPF
    LN2zS8VbHBhJyqIquk17Qg9sbtiG3J+Jooo0vIaPRdtKCj6xo5cTZYv8hcI/1lPkeuYGjA
    ca2Ccyglq1LM9khIiWVxmAUsnPPltQ3JdE8WbvwaaEI9DLAaIFfAaDTj4MhGgsTlMV6mPq
    bAzOrWc5mn5j1De6QoRD+QlpwwRy8dB69KK3vp8CG9nY7vLSLcbLGrQFC4dvM73Axd/oCN
    fBsDqr2a9eVSQ+EJfwO25wQOODlpqFwhBLp4T2XzOIbqhHzUJue02LYD2rpcwBCua8khkp
    E+qf6iv1ggwPqdP/mzcYz2doIQM/6DuzODlZPx0flhJ+7s+AdH+OwzwabxQg
X-ME-Proxy: <xmx:dfHpanP229BRhb4uH2ZwbPmS4mrGO9OlggTLrXu2ekYcEAjf_5fw3Q>
    <xmx:dfHpavxON1LtuNSnLas-7IbzrCeDplwFsw2yIymbgoweh7U6NlAg7w>
    <xmx:dfHpags_FLjJLSuKhg0YvIGLq2SDR6SBU6J98G1OGpih6zneSTmH0Q>
    <xmx:dfHpao4H_YdX7gRnkn8yHvZ3zU_gCEGiiO4RoBj9wwHmmwqX4KxmhQ>
    <xmx:dfHpatDk6uic675VAOBfNeLzPM-Br2SRdjo97nT4c738vmvi1gF5KWGv>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89E24782738; Tue,  3 Nov 2026 09:36:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AXlNo_7mn8GF
Date: Tue, 03 Nov 2026 09:36:17 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Andy Koppe" <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <d3878168-95b9-4b4b-bfd8-85d459122e5f@app.fastmail.com>
In-Reply-To: 
 <CAHWeT-YSK3xFA=Hztr3Uj5UW=L9JcC_0iOa5pUG-WGCpwng9vw@mail.gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-1-andy.koppe@gmail.com>
 <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
 <CAHWeT-ZdZ0o=_rPWFPcXqCyc-WV=fzmKVRVx2LetfQzgYkKO0w@mail.gmail.com>
 <f194e2af-cffc-4867-9069-7070c86785da@app.fastmail.com>
 <CAHWeT-YSK3xFA=Hztr3Uj5UW=L9JcC_0iOa5pUG-WGCpwng9vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> pseudoref
>     A name that can be used like a ref to refer to an object, but that
>     is not stored in the same way as refs. For example, pseudorefs can
>     be passed to git-log(1) or git-diff(1), but they cannot be written
>     by git-update-ref(1) or listed by git-for-each-ref(1).
>
>     The following pseudorefs are known to Git:
>
>     =E2=80=A2   FETCH_HEAD is written by git-fetch(1) or git-pull(1). =
It may
>         refer to multiple object IDs. Each object ID is annotated with
>         metadata indicating where it was fetched from and its fetch
>         status.

I found "Each object ID is annotated with metadata  indicating where it =
was
fetched from and its fetch status." to be very hard to parse, and I had =
to
go look at .git/FETCH_HEAD myself to understand what it was talking abou=
t.

It might help to instead describe `FETCH_HEAD` with an example,
especially since we already aren't giving a lot of details.=20
Maybe something like this:

  Git has 2 special pseudorefs: `MERGE_HEAD` and `FETCH_HEAD`.
  Unlike references (which can only contain an object ID or the name of
  another reference), these have their own format:
 =20
  - `FETCH_HEAD` has a list of entries like this:
    `d4c5f27105ee2e44366d718dbc5db95bbe99c714 not-for-merge branch 'exam=
ple' of https://example.com/x/y`
    with details about what was fetched by linkgit:git-fetch[1].
  - `MERGE_HEAD` has a list of commit IDs
 =20
  These are stored as files in the `.git` directory. You can pass a pseu=
doref
  to `git show`, `git log`, etc, and it will use the first ID in the lis=
t.=20
  Pseudorefs can't be written by git-update-ref(1) or listed by
  git-for-each-ref(1).

