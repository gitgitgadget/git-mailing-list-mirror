Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318248;
	b=axFLinw7L/NUXOdS0JaLkQdkJ1MiqmufY4r/x24hahhlFmPlM8ypuzLL/jMm6MamlNCk
	 /JOZCthRrHnI4TlSPQmNl0iBIyXyfjFZy/K+Wft7tHUPgF2C6lROAKtgo8ao2oIP4DrUz
	 KNrD4E2KBEbDoqEWLn+1L0AU44EpMKTeBR1WjjIz1B8kPVLaM+SWBIF1kRYc4IEfYP4/D
	 DescVRtmQN88vNnQ4/5dQYDPzZND1bFm9/pPie5fcJ+AWB/lFmDJB1ykaoVgf0Uil4YS/
	 dDepmLKr9fI/WC++AFmBlOJD7xLhN3cugnIL/8sTtJOiMRnmwkdo9eP6hrWWgBv4DhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318248;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=sNGCJnfLi8P9jpy8b57kCeVXhZRHzfKBbDBB+m0Vovo=;
	b=yaQaicdnFr/SlzpO9J5FE51oGjK0odmBNfZaRp2UB55GO5CPiqktOZX2fQOWcX4Usi4f
	 7pM5+fg1MrtP02sMHUlXIXcIH5BaAC5wcBN2pmBxazWU+JoF3mUQConLwMzsPeqiT1+iK
	 4oZO4GvUYh/q4g5VSHgZshlceSnspe5/8l0onfCDSiAhvGIZv29fe9DyUm/prStaoMFS5
	 WxsfJdFyFodBvZtcesJ6k5Msy5yqtijvsg8sahX8aofYKe3oTFyZFUTmyAugiCZ7QWe4f
	 4VIBhC8kbyGcWguJICKq9qvL1Z0EQyZDpM5kuJEVi2Bw3c1R31U9KtpqP3yjSK+MTqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=g6Kk2A0R;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="vZGF9/oX";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE23606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE23606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=g6Kk2A0R;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vZGF9/oX
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 525527A0220
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:44:07 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 08:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794318246;
	 x=1794404646; bh=sNGCJnfLi8P9jpy8b57kCeVXhZRHzfKBbDBB+m0Vovo=; b=
	g6Kk2A0R4MrUUmFa7yLgMljoP7TYZbt/7B7lS3aiYLlztDwWyHnyw5dotrdU2+qM
	AD970sJ8O5ciTJwIiZCTT9zJbj32jVPo0SV7aNaIpG11R9dtSiwPBjJFgHNBXdXr
	r8z2qOg5h4e9/QlnvxPwpXo0PVIe3M9K/QSYXc9DELoJjj701MoOL2p70yr3Aqs5
	iww0ejuielXozs89UDYIn2MPW2Dn0nOhLSyqW84dHveTHjyo3OmgdGynJYiOuUZa
	V99Izg4AtvSFe0L+EK4/ZI7bxxgLQCPCxP1G01q1WFy4W1LsZ1ZLOJ+CSemVl3Vs
	e4LFZThlBCbp2z5ifthikA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794318246; x=
	1794404646; bh=sNGCJnfLi8P9jpy8b57kCeVXhZRHzfKBbDBB+m0Vovo=; b=v
	ZGF9/oXsOw7xoPWiPIwpGqprxhwJGQFGuqx+ISnzbztEWHM6Nijs6S1B68pdESEj
	uyQjRbX9+cQv2y1Akt3IRD7DdBSbpzCtmhdiDBlaEk6cegO0aU2V8AlF9W3kWUdy
	yvtQ3xzky5NNghGvvoYrMsBN5YfnkfhPEwYIakdDmcjjQqjwrSIdbXVfuoQ++hwi
	Mhq16SIUJSW19j0LocFr/qSw9Bnv97pgcsCXXxykUlH7W5OzvM7KVeYyXOgzfzJK
	pDazb7Bz08RajHGBDBuPWOW004Wln0tKLPU0b57ARH5N62RWaBZtrlg/ub2AkVnr
	cqvYOhcKcc92ktUgtF+vw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794318246; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FEnsXlVDATTz93UQOnsdy2wV2idSUMiTJzJF049GklrNMb5
	K9UbMToJVZoim5EK2FtoiNK2yGvAtqaRd+CH9ICIvkgENKB1TWH7ADbOZyvBk55F
	5mEdrDJJ9ZFmvVMkN+mfzJw3tJXc3UC26pItfRYwZfdhGg98PVA8Hx1N/UH/q/Sw
	yqhDawo+jAdiuCc1839Tzcs/nV16/gnWMuJ5jZHepbQpj+ev/wJ7S3VpF7GD8MzX
	IJza0lE9LUaOYNQmb+aKNwWb1zaebqOC0x+c5m1yuVn20+SeQZDK0q/CVhNXccJe
	nCx0NhXUnTDo9U6y3w+Jt58/xM8KPfE6ErQI36Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:++HcdCFbLgTspzv4vyzMiiLwdkbYHyotoCQ0Iq/+zeo=:AHqnas2KGb5LJFgdr0389HLPyHtW4UoyIuIsfXIp+mc=;
X-ME-Sender: <xms:ph_zashGbv5CnbFNR68ijVxJUHfEyZThuKstdTz6BbM0sDfSdztrMw>
    <xme:ph_zav2mevRCjEFgAtAKlJ9Yj0UBqNV_KcJHs7XDGH3MI-t6a7jOi_lzDyrfQCzd8
    2cbrB8R-zFGebFEJDNAZFVbWuwo2aqDXGH5glnjmcc21oFIs1PjzPDF>
X-ME-Proxy-Cause: dmFkZTFlpvAEmwTdDOOTtkVQHPOyYI1eyoLXDsQL2vnWc2DDkApYVNPYzdPOmB2NbpcUKT
    PdaokilAnKiT9JZmqx4oGtLfbjoSQSaRjLU8+YcE9PsvIuyMODgW1cFD+yOaWF+TtGG1+y
    nISI7AWACaYSrXEckEm7m9PQnY7EV3bGQuPlYUVJN0hEs1q6bws+X4nGtrSTiMMuYhkvxI
    22LMN2Y6RevZolnvO9PiHDzh9PbBjLxCk6CaSW4zCJ8DVmQerNXCMByTARFGsCgoBYZaqE
    QwuOY9v2l69rO5NIrn7hbZUL3TjSGEwBgzRqvBGeOccxeb/k4a4Ll/SV17QNH55Y8AJmqP
    8zCO3L11NWRrlcqaeJu2voFbVXe/OuxvQeOa0TZB9oIk6mRamErOWnTfoP06Zcpu4Tcvgq
    CLOUJ/LityymB/rMgB/AOGsgaGo5VyUrBWKKq1oxHx+TFCaQPMdnx8ksni3rlmfGQ854N+
    RFF2ObfTY9o/G6LwwYeKOD1IoeAqXAFRGNqe47RdXe3K+uqbmHS/2FUP5mF2cOWKxC2jvy
    ZSuEWP0MZHrOeYta1BiRSUPg51DICwUvvo33SgvRK46E4sdIZZcIuCiO57q5R8yYdtLdzI
    NG4n/CGcIEYHb2eLXaB3zY6akDsBru/VSAIZV17laeQffkoWHpKjjG8GxDyQ
X-ME-Proxy: <xmx:ph_zavKDneHeQ93jEtEalSXivWGys2a99p5kLX1-bY2S9lFqqYO7kw>
    <xmx:ph_zag-o1Oz29ov4kLfhrj0trIuQ-nORUJmboNEXW3PI9BrLi0uJcw>
    <xmx:ph_zaiI-noJZoW00EiaQWhvinGhGuAHXC1c38i49Wbwq62mRS2ApOw>
    <xmx:ph_zallOIdsDDwaIrEwkgQBBSYiWXacd-TDjfqHvlwOBPIIXAz69Ew>
    <xmx:ph_zaqs0yamkP0oL7P7HepNnFzoyXTANal0Bn8A8Zqlaam4ho17iEkvU>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C570780070; Tue, 10 Nov 2026 08:44:06 -0500 (EST)
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
X-ThreadId: AEuMsLfrft43
Date: Tue, 10 Nov 2026 08:43:46 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <85cbf068-08e2-40cc-9460-d537bc61e122@app.fastmail.com>
In-Reply-To: <xmqqse1fuoof.fsf@gitster.g>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <xmqq33tfxm2k.fsf@gitster.g> <xmqqse1fuoof.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>>>      + git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>>>      ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
>>
>> or something).
>
> Clarification.
>
> The point is that there is a difference between giving wider
> exposure to "--staged" as an accepted synonym and swapping offical
> option with the synonym, let alone deprecating "--cached".

Sorry, that's embarrassing, I didn't mean to include this change.
I did an experimental rewrite to see what it would like to rename `--cached`
to `--staged`, decided it would be better to keep the scope small,
and I thought I'd undone it before submitting it.

Will take this out.

>>>      +@@ Documentation/git-diff.adoc: files on disk.
>>>      + 	do not give _<commit>_, it defaults to `HEAD`.
>>>      + 	If `HEAD` does not exist (e.g. unborn branches) and
>>>      + 	_<commit>_ is not given, it shows all staged changes.
>>>      +-	`--staged` is a synonym of `--cached`.
>>>      ++	`--cached` is a synonym of `--staged`.
>>
>> And this is the other way around.
>>
>> Other than that, the rest, including the resurrection of AUTO_MERGE,
>> looked OK.

Good to hear.
