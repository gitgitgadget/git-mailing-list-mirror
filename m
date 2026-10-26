Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035346;
	b=AQn9mMwRMIR8xrwZf2bPFK3xp2UkOQgxJ288YLUqEonxO4IzZjCyO0xIgV8wuF+0DdMi
	 lohg5lWH4jfOMl5jLBQCRWtn+8+SO3USGfsv+e4juFH8907nJ71zweqDD9n/fajPmmww5
	 M96N3c/JqmQ8PfyWabPk1DiIjXM5NzwpeEYj6PRppWdKxQWaJ/jOF5KrGoIFEEz+ONUnD
	 qIpVZP4C1DajldfxUEjUHzLOez1jw3SeH4Xl4nINee7I4kFAcw4zdapLrfmjawKvq8FQE
	 XVIuhRCZuWmbVIYMyPFa4G3rSYhltCkAQ5sOh/VNUFDFLdr/CCgzlmhiLsM/eeWFqew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035346;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mWg/tTAONqiUyAL6JNZSywCCOq+WiOJKE2l4efMUSw0=;
	b=ln6jy93O+vDxXoZgMruWxX6hP6IFNo7/WiINJ/HTRHGjhp5/Mj7KFMvA7x7+VrSmmjna
	 DiOzL1c+IyAsq2e5D+EbOQN6QyjnGzZo4fv77N0gc8XNliHxqEzrZ00KTp5iw7gUbDsZi
	 FrqBE79cgEvyWiMXUWYmwQofTTmp/Le+mNuBds+oU/W/Uvdt3fbGYcVHBB4LNMpE8VcS9
	 xorV9XYjI9o708SPHlo5GhurHwt4RvRyonHYSQOnpxviWXLuLtLM4Lr4r51EEv4cSf7wE
	 ldRfN8xjJz72syIvNd7Rpzpq/6Kg4CShhDMKFkfns8fKKjoEMvVlL6wiqh9paQDx4VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lmd9fI7O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="HqwAL/52";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB95606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lmd9fI7O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HqwAL/52
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B7E61D0036E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:22:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793035344; x=1793121744; bh=mWg/tTAONq
	iUyAL6JNZSywCCOq+WiOJKE2l4efMUSw0=; b=lmd9fI7OCrtWRqgrXrq4FlOl2d
	PB8dYNxOEHSVW+bideOZmq0Wh6q/pQNfdfGmHrtwd4Kf4gj4rwWJhav3MARrereF
	qFvJ9oKIeRz2bLEk5l/bqsM4QYuymyctVSyn5wuq0FZkGzcWX8zoEntvtT31QKOE
	i0t1HIm5fMmvkbC01LrqbciYuGxDrFJLcsRS1/3ikhDF2a2ruKuPChgaBgPnSSSF
	LInm/Umx7s0LOeh575QPCv/FWuIKxYez1CxGPLCvIITLxWcSQDuPQaHNHa4GhWtz
	RHmCl6smavP7pZ9kGJc7qAbZjomFB4ZLgrbP0d3zyk1/k5Xcsr1x18nAYOGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793035344; x=1793121744; bh=mWg/tTAONqiUyAL6JNZSywCCOq+WiOJKE2l
	4efMUSw0=; b=HqwAL/52xgczOl0n5s3GEDzlKAW//fY7LdSRG9WZQjIBvham20B
	GkXrzXe7u8zKKDeA0NGPqG0gRfEPVxJIauWBhGp0nbjU4TBIyyTDTlHKp3hc9r66
	7YdLLR2FAj0oZTVFMFxD3BMD7orQrGU5B/DbKT7HBbaRUvsnjPhpRNIxXvFTYoUD
	McUdeZVyIjnniZHT5uk9xKqR3kOkyNyAwZCWF4+uefPjys7eI5XdVclj0n7ioTbX
	8igvxnLAdFwsX4DQNiPOscj1q26WkrHYvPlPWXM6nBCeDgZVAo6gLYugkxbXcNqR
	m3A1kf8IR4UNEzbu2ZkDHaIKOtW7FCA5W+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793035344; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nmC872SRZIUMm7DeJ4bRszff/NvvsQ3LyIqgP3QA8C6q5AS
	qiVptuzxlXv1ZDNdmD5dLJfdEg+oJBK1U6ND7EhFdTvxlIP1+0du1Lmi0n/uN8H2
	tyxmAOPr/aJFZE8n0LOH9FUkhPvMGxHojdsTvdMpyAfwG8JDpi2pgWhiAIjsTXw5
	vSWuPjTc7xFbKVpiKn459kugriAFnxNkW4OIUeD/1SL1Jg+n4tRKC2NF5CWd8ZhY
	Qu8TZ9fHo2Pe69w0mtU+uzX90b+1tDU81hBCtzfzCqAdE91KOqTpBjdElK+7yKaR
	p49BDOrbGaaphTog2BWYLR7Zjgwpubxxxnp/QoA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KKefGeO4XQ9/vbj0FopDKOoMaA5iovz+HC3xdij5oQE=:4BlXQDbRHqjRaLkCOTuSxDrPoRHS2OzxteI/MmQV0Ug=;
X-ME-Sender: <xms:UIzfaoLWbr_G1jb5MAna8i2ZB7cqeCAKNEsqchZnMGytpcniaa-YZg>
    <xme:UIzfaqYlkJE7hABCKLLiRaE_Ivw_nursS1c-ghcs-HHK2n77Ljoj-Ilh5RsWCki0F
    YjugV0vzzqJWX9jjJ4DiQDi_m8LVPFwxbF4dRzO_8ZfhhjOJ3ZJ>
X-ME-Received: <xmr:UIzfaq8HfxB7dZS6CFi0zDsHwq-8jDdwVNBwhPZGeRvJWejHrUYLwOrOJVakGq9lz16Q9veurrE1KxOyRL8FfEOQL-XdXaaLV4Gj>
X-ME-Proxy-Cause: dmFkZTEESVKGHDUxn4maj8O2e7LIF70ZKo6J6DawGgf/vCpNIREPR5OFuX7fHaVFGx8yh/
    MkQrsIlMtNGIfHtGqNzuf0h+DSqY8MEouR5jfkddyS+g6WMTRbjaFRoF3F++9TwNzfsmZk
    k6xx5GsXtsGXIiNGLuP0dASvlqFqbpdES2+/gUV5H1cchBbi7BgtwqxaeFX9kKUrsvGlqG
    kGvxZ8bThFIW6lfPiu7qmhVDrHsJQYqkS9F0GDNJLc9YFhJ1vQ3IDwg3WGTLF+n8ZrPYyH
    e2bc/4bx60oemNiASwPKztZyTa0/lXKqh8NirQv0HE0CoOmDkQoK0iYE9VY9ZquvE8pAqG
    V2SBHI0CxV6r27/R1KV/sRSUezi+Xckr4zXujTGF6GIjXPB467rAZjzHtGXOqN5DoOH3cX
    sk9xYCMiD9QyJ7Wcxyx5XXY8XSE3ODSVQZMxJQC/pkokYozCB8nPznZgDjpim423+UYxxz
    AktW/kA3okrDIbVg3QiQqJdJs/cUgKkUcJP1BBUByxNmEZCzGyYdKbn0Ui97rKlHkPvXog
    2YesSkl5k7N3UR0UnycrWHwCN0qQzVV8MkbfC8s8NN5Gg/O037LbhWcvzDcYsUZLRoKT+B
    fm/uRC5CU7TLpmR1YHSWnEF8FQV166NwCwwqJn61cvBnY4HCkyCznMkExJKA
X-ME-Proxy: <xmx:UIzfarbtAI3bRV7ijjhADMz0JRdF5_i670wpmujfn7svOnk0vzmX0g>
    <xmx:UIzfauOOcx5iVCLVH1ybheLXv0vVIZgwAj2UfnGkONj98KU_8-7ELg>
    <xmx:UIzfanAoJa_8B6zBCs6K0cMI_tyzpSL7Q0WopngYrxPuK83g4YQ1ng>
    <xmx:UIzfalIzQdAPRokRdbxX7zB0nWUZ-fyTe34_GT4gRnd6JhWQATdRjg>
    <xmx:UIzfauc02_pESMF60xAgqVPl0p1Cm635NFHsQEtfmIfd4rRpf1e9FpdM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:22:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Jeff King" <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <d330a5ba-cefd-4a4e-aef5-972a931d4d8c@app.fastmail.com> (Julia
	Evans's message of "Mon, 26 Oct 2026 10:47:33 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
	<486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
	<xmqqtsmc44c1.fsf@gitster.g>
	<2564bcc2-2f78-4ea2-9b6f-c033e95983d8@app.fastmail.com>
	<xmqqmrs0v87w.fsf@gitster.g>
	<d330a5ba-cefd-4a4e-aef5-972a931d4d8c@app.fastmail.com>
Date: Mon, 26 Oct 2026 10:22:23 -0700
Message-ID: <xmqq5wyos7g0.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

>> The value I wanted to bring on the table was to point out that the
>> changes are not just "one side did something", but "one side did
>> something where the other side had no opinion on (hence it didn't do
>> anything)".  It is the basis of how 3-way merge works and helps to
>> resolve the example for removal of both.
>
> Oh, I see.  This is such a simple example that IMO trying to explain
> in more detail exactly "why" the resolution is correct risks confusing
> people. My goal with saying "one side removed 'banana'" is just
> to give an example of how to read what the merge conflict above is
> saying, since the syntax might be new to people.

OK.  Other than that, I do not think anybody saw an issue in this
iteration, and I suspect that we are reaching the point of diminishing
returns.  Let me mark the topic as ready for 'next'.

THanks.
