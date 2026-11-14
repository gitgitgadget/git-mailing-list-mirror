Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794623313;
	b=tI2sBWq3adSyvqYPQtcqYTOVh1xDY4C2SIChfp0Myrr+rWgGoP/3lFHzB4om7qlUqQlB
	 nQMvTECjJf2Az8Bc0v8xz3cv92HeW3PbcnVDH199z//L90OSzwKxydjnfF7owQOL6uuWO
	 JCWHLNywvqvM/EW4sgW4uWZF9jFi7B9/PdeS4EGUKJfBLRT/4/vOYgdOobwxBVKyMLkRH
	 vDtREfY3yXi8+LFe2fsiSTq6J0oS/8YipG75ZtAr38dS6LRgPj+gtb1j+enG/UnsI0Vdf
	 Lc7g44LRENwhy8ok36A06pNNT3D4VZYmFuEH1LX793t9+9oN6NkvOZhtMEg/FyT3wdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623313;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/ufIzdaxayT3rn34alq/TOeVh42TIJKbPC9On9MUC10=;
	b=qE5dF4UWCoZjCXSxOcYxcB2IvFlZrdsU8t5K8yWe05X0dQq75jK3Rr/OdpdOunDqKBR0
	 cnbz4T8rnZY8uxgK0WKoazjQdMb8oQ8JzpdJE01v4mJZxHakGQ7E8ytEdLZ/LKTtHEybk
	 ORo8HiTZMsf6jj0jJmXYybp0YaFbJv9a3rLQyvBf7s+Cm+KCG25VBGgly5P7BZvgXYhR8
	 ygRRrMPbN5ZWFzjLgNtgBXTsvZd8FOLgPcgejUhbT/zlCOjnFo/22O1jdFI3fpNgzn86g
	 n+bnqn0yp+AFPbDFEX1ZWHlbZZI4ZmOs8hZU76P2Ah6hw/ahJiPsajRMDOXOCJRyitA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Nzycj9g1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2pcxy1oT;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C975606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 02:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C975606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=Nzycj9g1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2pcxy1oT
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F586EC01A3
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 21:28:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 21:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794623312;
	 x=1794709712; bh=/ufIzdaxayT3rn34alq/TOeVh42TIJKbPC9On9MUC10=; b=
	Nzycj9g1RxvnIckVtXv1VF0F+w43w6dgkZNZUFJ3CaX9lkOzYdtAtT1QGzBZQyG/
	x5RPJQLKMO2fDY1b84HiNI/CwW3XvYzb+JKYMPyyFA73Z/mS19dc7lvPzp580uSH
	P5abh/bj7HGFv5iCfc1EjCpvLM8yfwdEFdhzvwuQVIGA7mgYUdCX5YjaiyO3lIzT
	eiyNbzeFv38Dum0lCsSYcAgclmyWBE2jWLLoQH6Ht2277HeXv+V0yDNTtLuF/Oy8
	oYz4qvlApPvBJNxZM5NFDxU43CTp8vqNKfr7A3CqlJ94aW2CR3z6GrvsZjNyLnyw
	O5bNQcL0rU5cjvZBjnV3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794623312; x=
	1794709712; bh=/ufIzdaxayT3rn34alq/TOeVh42TIJKbPC9On9MUC10=; b=2
	pcxy1oT1pDkpZ2fYJ2EcSsvzIK1ILWr4FOD7z5bFgDLd1B4w277u7+Z4Ep/ejUvC
	KkNPssqGP7DqJHaVTwf5XkoOze8ezhGE+mmhp7bEs9NOhZbOHqwfi4UVqVsKjwB6
	3AXVMcOzX+L7vwWvEaoLFS85yKhyQo7ghMSINbkM9tQkayO6sZ/jBvWyvyVL0x5a
	0AuDEv8D/9xgpLiIvKYmoRwL1U7qkrv7jujb/vRysXfxq9ddvxt6sAIlYZFhHxOL
	bNrqfrFXykbUgCmsgdAz2u4/rT1/wxSLMBk5C/z3Cam67c1wCnHKORTm9J3ddfgD
	dCPE5PxbIt7N1X2HDcnvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794623312; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DsTlNuXapprMGMGWZ6gQU8SuQmqnmfcumFoykrMEaBXJMnO
	BxVepf+Yh/AdJu0i+9eoXERnOO2X6bDF+TButLAC/5mlsb1Y6EF7lIyV/q7P05Jv
	VTZS6T81SBmCfpppr4P/2NnZXekbDcrO6f8CsyfC0M8r90LgijHMrnG9wdUttKKD
	0VqbLquYefVq5jZIXsT+NOXdWaqZWT0c+UMXPbE5RNMXlW2fkaYyov3fVLNClo6o
	mfNePerNUWBgheWPj1naGqrMfjfOr3tV8k1iESZsWOhYpfRz1zPv9cLC4B7LbIeU
	hlIYqUPmzDD+oC82V7UPwWLUw8SKV6iofFPy5kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FYMChASrB2NHgCkNg+iip8JzND1KLwTyuMzzMc665EY=:+BBRQb9qREMIBG28lWW+pKbGwWpsWkDX46+yjwjILzU=;
X-ME-Sender: <xms:T8f3atKET6E65QzeqEccWeNOmlH11CVzbXFSLXKmtt-9u_3WVQv3ug>
    <xme:T8f3agAg9ciuWSZEuX2H4JDUmpZuRhob_d97LZ0dg9XQrQDbJ7U8jUTbIiDSMc619
    gI-MHEybm97O34uAbajs25b7zW4KJWYH9gxQDdTQE-JmjsuhtixqqnB>
X-ME-Received: <xmr:T8f3auAyMe73Hd-tD0Hm2192g4r_sTEx-BeMzFJFuOr-YW-_xcA1sRlR6wOQAjwEMkHaUYhHnh2XYpodDxj7V359iLA9PyAXV2lHX1YMigearLA0tQ>
X-ME-Proxy-Cause: dmFkZTFHQRd2LTsAadHi0IBcfvDz1iMqwok/m6geK1P8NMePdLIOcbLIr9ePZQCCS7QWm6
    h/klq5s3hq/FFNkv1w8kQcvS+EzuH9vm+6Rgo9T9SNy/RpbWqpPpd9s20D9NANmrm46X1t
    Wb3ZiWkqzWh4fC0wCIMeeMNSFy7mbV71tY3JccQh6pICxM3hrHumOWyJvA0XOuuEtKOggH
    h8VlX0spWH/R9R62cYL026UYFs13OBqVVDFp19Dlf4UmiWV7IDmks0/3N8AtdRKKGtAbL+
    jXEzfzWzHYm2cyAZKu133hHDJiL37iKGplFXUCblMdsatS4zAccZxMvasyJOJO6qM7kiYy
    u6dhtL0S+OmJpwK3f3cXbtbyujKdhrdv/U8lb9G9myFa+mI7TTISh8ZB0yzE7yStDEh0tR
    diVuB7qyMdqOijCKJ8R9cCnJbIiBrAwyPZC8d3zbY6uuExwad2qJRRMDCsfkJkgkxuxHv2
    pok58fNAsyjk78SSfSmmo8PQ671dz+M37JrhBHNr/9huKYKoBk/uFqZwgBXljeOwtYuw47
    3nn6+Cdis3aOIyoCIRdaelzUKOtEatQgnowSZjGnH/EYGHddp3lZxxwyWhDZh/uG4qu3z8
    cYOUe0iUZDs/wCXdQ8vwRChzKp2+j/Oou+1b/McGSyquA1BbAyM5lGVOeDEg
X-ME-Proxy: <xmx:T8f3aqATyUogDM0sTU0_z9FLxZphJgCy_gbWM17VH4lzOz0tpOCCYg>
    <xmx:T8f3ahrY1IvGbV3dMUpwRxOIGxJnZgTdJjPAqNIoWyawMNjgDUqVeA>
    <xmx:T8f3asm4u4uXtSZbeX6sZeUHnKEwfMaHgFgz8yqMDgVJU6CbawCARw>
    <xmx:T8f3apyLdySNzG3P3IVRlaqqtxnFbr_-IEYHtrDVdLC-2AP2dUhK_A>
    <xmx:UMf3atQ9CF3XrEUJwX7cXtYGn5dSvM0EIfJZpJWhS1PeGsDVnM6moYRT>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 21:28:31 -0500 (EST)
Message-ID: <b19ec7d9-3c9d-46cf-9245-2aefead7adbb@jvns.ca>
Date: Fri, 13 Nov 2026 21:28:30 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> <xmqq5wy2kqhl.fsf@gitster.g>
 <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca> <xmqqik21j1ie.fsf@gitster.g>
 <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca> <xmqqfqx5foxd.fsf@gitster.g>
 <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca> <xmqq33t4fxx7.fsf@gitster.g>
 <a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca> <xmqq8q2w89ee.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqq8q2w89ee.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-13 8:54 p.m., Junio C Hamano wrote:
> Julia Evans <julia@jvns.ca> writes:
>
>> Okay. How about this?  (the added sentence is between the **)
>>
>>     For example, a data scientist could use this to run an old version of a
>>     data pipeline or a programmer could use this to figure out when a bug
>>     was introduced. **You can also use this to make experimental commits
>>     without being on a branch.** By detaching `HEAD`, you don't need to
>>     create a temporary branch.
> Yes, taking the "data scientist" example as a "pure time machine
> without touching, just observing" scenario, and the "programmer"
> example as an "inspect and experiment" scenario, the addition of
> this single sentence is sufficient to hint at the wide range of
> usefulness to which this feature applies.  Nicely done.
>
> I think this is short and thin enough to be good material to be
> shared between the manual for everybody (which would want to cover
> wider workflows with possibly thin coverage on some and thorough
> coverage on others) and a survival guide for those who are lost
> (which can be more targeted towards specific audiences).

Great to hear, I'll submit this with an updated commit message that says 
more clearly that this is supposed to serve both purposes.

