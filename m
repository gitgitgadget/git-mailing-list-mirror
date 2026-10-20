Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501684;
	b=WCp3x4FbFmJ20n8pbxb2hicTgxf+CNreZGi/KPijjvp7X8UWNWjFblsgwXx5RP29QFgL
	 82gxahRQN9p2mCVjxwYsJFAp46SnES4QdS/Bq1m+wF6iKKtoc8omNGOn+Ms6eDSQ1hlgU
	 NU6bs2Gvy+7hlyewoNGwb/xt7o4FMmxcc+wiXae+4+8WVbZYTdL8W2PlHsP9LLH2nwMvF
	 xVRnmwkeAk4hubEjGmTpLLImI4etengeod077hs9fJdkueqydb0HxQR2JW/6reLX5q6qG
	 l2Y4iPBKruXFrnxUBs8A8hHL0+zq51oTRHBwobQihXABfMPFZBlR2sYDJ4USYfpsb8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501684;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=GRoXs5uV3fiMTmdK1g/eKCj9iCZGsUOTBuxVHN4UJsw=;
	b=yXNYSzwM2EmAAUhBVk7eMWhGisjWUrbEslsUQ+7a4hq+e8SHf4I7py4LfGE/3onXU6pj
	 lT8MzRRh2LRwnkI/7AApgeRTzrmSLHLeyhfsdlqJz84tik1eYlJgLBQFeAMvS7g67dQ0P
	 Tht/fJ7rQmuAjtIGGTvxP94e6eAoWIKZItS5CHsEcEaI8C2WF/4Xa03Y+36Htgxhj+EWA
	 bOGr5weqQACHg43fD+rpC0rgjy2fLxVDy77yWPDBe/E0mPs9ZSv+AfTLyN1/8n8vGbkh2
	 MPHCnvcaBz0QMUlR2hHTPvgGN8z1c4apgjTnqzBk6/q3TqgUb90DObZ0ZFmu/qpDgag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=kPoLX7Mh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="dnP/cqgu";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD0606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFD0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=kPoLX7Mh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dnP/cqgu
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21B667A011F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:08:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 09:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792501682;
	 x=1792588082; bh=GRoXs5uV3fiMTmdK1g/eKCj9iCZGsUOTBuxVHN4UJsw=; b=
	kPoLX7Mhrzqz31nz/MSHgBLkryQrOlgMniNeRtvaVjePMysDclAW7F9waTKi6jSy
	fJsBUrH6s0glWVWite7QB84tBh8DkhKCv31m3dTuKY/yYRMMySNWfiYj3AdbZASb
	bY77hWYyoRGaRbO37W/NxIYevH4q2rRBaEipRH5+8s1zmWRbT+tFj7qZX83YjWAf
	MAKHTWiYJuj5aDik2Slsf0dVMO+HudEzeuaik8tvM+UsznK5lA46xvqYcPYKQ3LP
	I7N7M0/lZRrAf3voeiNO8yIMY/d/CUeGv0hxJZhpW/syFKy7BEwahU1/Mymgf2aw
	cVOuC7gyqbneDAgadGbAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792501682; x=
	1792588082; bh=GRoXs5uV3fiMTmdK1g/eKCj9iCZGsUOTBuxVHN4UJsw=; b=d
	nP/cqguo5V8zEv9PtgyqAFX/94BZJ9rh9sE2ZV7dIi5VdiHpeTYrpcvxkuDFWMUA
	tWZe9nSs5YJOq8qj5lgKcafXUTKlUzBfbtEL/VV7KHYWKmF6lUOKo4v9prTjPuw/
	CIZ9l9RKaD4YsUwnALnA9hCb3aIeIo6HiQj1O5wSPLVrDnbSMrlMiAyBQl8Nxi8g
	QI3Vbfn0IPbm/rz2Fk2uM+qFC2E2KZQvf43HL6PoNLxml+H/s0wKnsBkRq0r/5Lz
	9ChF4+RmNzHnDjo809eZedllvPv/cLHNwDRyWJRFrjSiujNoSUaqn6ffT+FdBnZ3
	O3gxwaGx6uGolOuj5ipCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792501682; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aFlo+b1WALCEblRhDJYcz2G3eLfUMq3740G6pUSMWadfeio
	QiLTHUhavWKDOatXIxqgrgs/P1AAPLBDrMCE0x790Oj5/K4atb97TCneRXUyxWw7
	bREbEL8qarz+ibcQyx4We8q3kXWl92vEZMO+Mp8lTFAjjkuKnUtmyEeRhutT9i9z
	pHOPQoz230Nk+/SSLlFAUkVchu+kgIuM4sO/AUE34VtVa3xzo2dp/Vj2t9D6kfR9
	FNGHMX6OEVK7fitqTDVBDzJqDnisr9SyR+5wk8fEYgdjggzU/7rtK/mN4WrzlhTs
	vnQEhXUB3cRcPLsfuHFmbHhanrgrqEw1bttiiMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jBE1/zwDkVQewdTQNSJRlyXozBjlsOFtCrnIE1NuhnU=:GRoXs5uV3fiMTmdK1g/eKCj9iCZGsUOTBuxVHN4UJsw=;
X-ME-Sender: <xms:smfXajzM7xdKpV3elLWCSDMa3RAhChEJUV7Y1zmN92_0WekBQUVTAw>
    <xme:smfXamGxds2lm0p0U9KV7jUdcbfaaZAiYVLqA5m43YymSYqqjCv7mt5-7yZ6nUv4i
    D8sKb3UpR_s4ZGJ0RyvW9y8sB1jRbfkonQmpKl02shASkpwiY0j-d5z>
X-ME-Proxy-Cause: dmFkZTFMGjxX5uPH095JUjjMks0mew6m/KnyRAOwNWsui9hAIVJuTffZ9m74ZK5AiOdmnE
    scX2KQ0406UrXdWUBoc1oaMAyAVtFsDg3YSJhIoMXESkiJ4bYPDEElb7HuUWIRfelTIqpm
    lxzZ1qSzurXj0viEoHzMQOVCkUhdhdjYifPsed7xs/ksA05JxV9k0sZBDtN/BY1KRP+jxF
    XZvh9jnYggQLThU1z+VP8I0/76fBD8zP7e3Bn2hYbi+gfFIpbOhmxg/W2CwCS/2ouxDSIR
    Yfi2cnQ/40QaFXXzXOUS9k7LC/LE2IbkBRgd1LNLcNeNCra/ncNJgmqJIN6R9daug1KdH+
    vpiwppWl4kNWXsFYbYaKoOe1wuIAo03QFTnIzW3lZ3gjYQTgXVUrxyVWG/Hxb0r+bxsmxF
    7IhDQTzteI1JHu9qIetitgFaYCdZ2lawl8pU2GDWfhIx8l0qKttxDunWaNKdcznagcIkIM
    EBephSMEivsr60OV+pbiQcGNIOLlV2BTQHKcVLfELdB9lti16edt8ZCHTSWLndc1v5ZQRA
    X2fvfc607GoPukAg3PQ61jN8016jDDfcT6jjlAbCjLgu8R7Ul+ulKdq6dFHqB8+IC0L3KU
    o7m/a9hAEyR+FkuffIR1BMXBeqQ8So6Qw6trC/MM9JvJc/4c+9pRVB4yP++A
X-ME-Proxy: <xmx:smfXarOGcCE7FSDqVHTjOR096qTobf94A6s9Gqz7z3ULCcUeY_gMvw>
    <xmx:smfXatuvvKUyC6pAP75pj0Y260YdT6BvoWqRvYp9oxRRAVK9TYdcPw>
    <xmx:smfXatUdm4n2hrwvQ0eHroOSXTO5IKbe_Gq5KsJ8ouciOSPV1HfiQg>
    <xmx:smfXatuSxjTqgHxAM5i_QczXfxP9e92pe6tSzZQLlEsLbrhuWyIiLQ>
    <xmx:smfXalO9qq0W8W-ufGHD1XuwJv7wTmGIFCYYFPH8fpG0bAo0k41XqvIr>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78A63782738; Tue, 20 Oct 2026 09:08:02 -0400 (EDT)
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
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 20 Oct 2026 09:06:58 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <426b0cf4-d37f-420f-a7df-48bd6281818d@app.fastmail.com>
In-Reply-To: <1AA9F133-4B0C-4AAC-B296-5C2543C642F2@jvns.ca>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <xmqqik3da2bs.fsf@gitster.g>
 <9c15d34e-406d-4702-b606-da102a340e71@app.fastmail.com>
 <xmqqcxt52xkn.fsf@gitster.g> <1AA9F133-4B0C-4AAC-B296-5C2543C642F2@jvns.ca>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> I agree these kinds of comments can be a little unsettling to read when
> some of them are =E2=80=9Cwrong=E2=80=9D. I believe that these comment=
s are from
> folks who are quite a bit more knowledgeable than the average Git user.

I forgot the mandatory XKCD here :) https://xkcd.com/2501/
