Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796774;
	b=HsQjMqjjNM5IKo6FSTvEfhJqIe0bsXXLulGZesoBqRdfPSGk2Vw39AJHMSKXI/OSNYyJ
	 gzOeBIOSbIvQZUPoMMe/ZitM32P0ZJiTiSMcx92s0pMuiPuxmdiwPP8+levuDKqUjpocy
	 JoXeoCt3ejAFGlAen5uhSnTaGC3kaN/moNw0k05hnv+67tUZytBPXWoV5QFDGDRmRI7Y9
	 xvQOUejY8QG9LYT2yBen7/O4zAHsqST5dO4VoM8wZla9XlYEBMCS1Q0LKpLv6cVfdHS+Y
	 UB/TDvo9e+zqiXqB/kA4gfyWwE/V2zYZc5pIoNp+mvLb1nbLVEFgcFk/L7x7VWuhHFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796774;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rNNCSW5o5otFMwThCZCSB/6KiGp45xnbBgtqJaTdNl8=;
	b=ru3mFpKuYNzJmmjJ2hT9tkooUcflVMQxdVsk5vrNBp0I4z+QV66KCf7G48vFt6qgMM83
	 lGwa/WL1czj4xUkNd94T9TSlqfBUcbquFBiu8HQkRj8dM/CT+hSJtJ704y+WL+OpuA9Jb
	 gIA7/gP0LIGqfkIsO91b+PMpy/P9xaNSWbaWDBxwvRBMW5F/T3guLDeebpGSo2s6/Ty/8
	 Fr75u2j2x2U90WaqBuJlHgbcWHsFyvpTc3gOQvt8ACazpAlHmd6CERY+5Rf+4x/rwETI9
	 Led0EUhxkurEKsT+763ZrsT/CPKshF6eTaQ/DRx00Cx5NADriU9q/Pwiu9/8n1XCzgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=D7yul4ou;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QCOGP9a3;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06184606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06184606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=D7yul4ou;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QCOGP9a3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38E2F7A00B8
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 19:06:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 19:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792796772; x=1792883172; bh=rNNCSW5o5o
	tFMwThCZCSB/6KiGp45xnbBgtqJaTdNl8=; b=D7yul4ouUu7FjzglP+FxeaUjtm
	6Q0Xmx7DgVtPywR8KWm9TNPgxzG6e8gpvWjkh9W7C2UQj9y638IW0KnluMRsgQK4
	yZjxeQoMUnsruz/ar2rYC+liTiQN8s79hUMeg2ZxTD/JOlmo/yWFEusUKzZampo4
	U0xTkb6xVjRzLTkD5gVGWQIjTwTAUqPPX5s20UmM6Qhmp0Dint9E91djpYxaSuRL
	gBjxNAWLwrQMDpK0Re/DaRDfFKhbJJuBSkFxcUVNQibo5ig1hlw+uHMawtRzUQp3
	T4GimzX6xIDAT8wyg2AoQX+tZ2pETpsu4IErxFEoEifaKRjxPm2LUrCmfYPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792796772; x=1792883172; bh=rNNCSW5o5otFMwThCZCSB/6KiGp45xnbBgt
	qJaTdNl8=; b=QCOGP9a3udsECnyNrdwnAeP6OksYgGvqX0miP88e7VuCDBqBo/f
	iNrMewwYXo+CTpZiU1oMtZSxU0BGdzE8zI6EDtz9pd0PnLQRUvSLWRT+/0ftFU8T
	VS25XjfmcMyMWIsEWFAUrcBJFi3DXJqJKTGbvf5oP/sukxhuPO5pfLPt8OeOiWZu
	WfdgFB9oQIFgF4zrfnS/XhkMeOVQ9VFVuCEbzbOyPsXIobjIvqNYP/6v3wn5zucp
	/1be/gCceZtXSt1gT4YA/FGWoniUyocx4HbHzv2xkgKkCGg283XKK2dm5f2AxTyu
	JCX64d7TvEdY8U+yCvFl+RbpBUvJGfTD6Pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792796772; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:S9MeoffWloV8+GJQgY7+dv3kEp/qJFetSZhGrZ8k+Hapyr8
	23hNW3zLodr/3qYv4Vd2HSmS8ubHvaZ7Sggdzt3D+PpFppfCWTYAC/gQ6EYm6XpW
	kr/XHwLpOw8vZukGNK/+JSPb4awtVGQ5bHRFuuCXJg5AiylwVvfFVjINgE0WqvO/
	hclLTo3eGpaB72RqyCEsgEa36TEPcnmZES/HUm+iXYctri0AWhKkQObVbbBd0g+8
	D7+hyTDo53kGs4FuDHow4TwsuqOtN552MWOuvmFfXMEvBQLUWZkHZb5IfBpihcI3
	KLyeHWOuYq1XZPRBXOIyObk39gUnGpWeoS2DtIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eE13MSqPsizKXY+zhktPQLgReLHPklvMCdCPzn1lHCA=:AeYTVTzBu7v6WKg0A0IxehdA6w6a15mZ2VROovlg8Gk=;
X-ME-Sender: <xms:ZOjbarQz0ON-W5bp0LvVVbznY6oDxWlDDng4ocULbeDbRg9RSu7Q0A>
    <xme:ZOjbajqiNutZtx6m-hR8ukS6MC5vaAv65fJGD3L8b19b3ltPSwxHOHgOP4x2jQ5ma
    MaZvRuzjwxfJHmo9lEfiQ4FZyepWY97wzacw_L_TlMaoY2YI8gZ>
X-ME-Received: <xmr:ZOjbapLBjbjWAQtEXsYjamUP3CeUlIqqnPyqkqV0DN-D6VNbioHZQRZvANSLsvbj9Ww2u3S789BS16Bps2j6rshpDT3yMx1Qiu-1>
X-ME-Proxy-Cause: dmFkZTGfpdQNH96lEucDnFLKH7BrwB9+ZaYZSwy2kWYcJsbikH+O0/VdlCXg3V8CpyWqR1
    F+apmyX0NaJNzZ2aTyoNGqcMMhv0oqEQojVYvUiHzzwkpqCKeMopZciS2JLEf1GogJ2gO+
    QywelFmITYT5gIq7lSpL+uvqaGb/owA4iLVwlR5mKHhU045y3HvCqPn7lO80J60halshs/
    +hhL9OsCEJOld1d6BWYtu+s3aSXtV+75Pv2BsE0qAZaRess9QOtXZe++882XTtDcwLimhD
    xtSkMz6q8aAL3pTyU3U+I2c16lRr9yk81uTe33D7qE9COjZumBrHDqWu8WWdZgdFA1HcGj
    F0A+TlqxlHOnjQXb77NbRi6pny6NASktX00/g6vKmOT3uoZSAoi2uoG0MM9mAYEXRUNaXc
    slwxRS1eg0bYKB227xp6oPK1c2bm2g1bhL4AZfZI4E4XlRmAns3boJ+ZC2/jTrDMtEazR8
    4mj429VE1foctVNtTBtK6N5ghrvjAlP88aWZrGuYpnFpR5d+Qwxxzomvhi878IfTX+VJPg
    OhtQBuzioWWlVTUZU4+bZO9MdKUQAMKRlYAHiN0TbzNVtuQTNihIN0lwjacv3cAIUaWtoy
    rSh/AFDbziOMbcPl85zq8HqsemIHz3WB1ymhgWhBAX8isSWiCxZCB3kOTmGA
X-ME-Proxy: <xmx:ZOjbamrBfYRYK5xoLMA59QnJqHWKBfUG1tJoC_FxLdmNNm6uJ-yPLA>
    <xmx:ZOjbahxTHtR9LU8Q7E_puX3xtXuTAyQFmbJXNTPpswxWXmn4XMbM-Q>
    <xmx:ZOjbaqPkYHnJ_2vFAqMvXLYUgLlzqX5Q6FyimRorNBKvITTwC7IfJA>
    <xmx:ZOjbam4TKTLGcjSbl5hFq0PnjqHHraVHf8biS4HfgnXWIA6R0K-Maw>
    <xmx:ZOjbah5MKmY49PYEA59_uwABv3rNjXlbhsRR9sYlwdX_H-Cx9678YLHS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 19:06:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit
 fail to install
In-Reply-To: <CAHwyqnUmEx5ykHD03QTXeHwS8MiUnv9UEru0FBM5ixw-KDV4YA@mail.gmail.com>
	(Harald Nordgren's message of "Sat, 24 Oct 2026 00:59:50 +0200")
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
	<xmqqa4o43x6n.fsf@gitster.g>
	<CAHwyqnUmEx5ykHD03QTXeHwS8MiUnv9UEru0FBM5ixw-KDV4YA@mail.gmail.com>
Date: Fri, 23 Oct 2026 16:06:11 -0700
Message-ID: <xmqqld7o2f18.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I interpret this as needing no further action now. Is that correct?

Not necessarily.  It merely means that I just didn't find anything
wrong within the time I could allocate for this topic.  Somebody
else may want to give a real positive review to move it forward.

