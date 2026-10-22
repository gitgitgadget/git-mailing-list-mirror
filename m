Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654219;
	b=ZoKJj85DW+mp+jH7XljaOFqw/NDTguGC1x6Ps6Xw8qiG7YNftohwz21RsUq0CR96qnWx
	 5cxdMGPxFmhw+JALdTtdPJMfzU2NdyEofjZFkiqOOW7retjMPb5ozsyiYaWbYIY/3jASs
	 6UlTDk5jIS2huka+OV3SJuuRDYPG6l4afxsO+vCEKt8JI2ZvY7f1aBA6KUhxVqi0NKY1e
	 I0riXS+eiJv7Ww18qi8rR8KWv/cEJr2LZGbutyu4RZ6p1gcptIqTNfR7yQcGCOp2TJqUN
	 SBWa099rMHQ1mKh1qVwarOo+GN3Ni38ZUG5H1SKSb4NoJ+egOQruN+nV8vSG3gO8qtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654219;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=L5LJ+ByyEWbdQ/y9DWvA3i1OSIuzCaIIpIaH1rEmhKM=;
	b=zAUldiGXH9LW6VQgn/Lyn+Dz9SoedLEeg6eq2BWp+ynItlQCb1fm58E+8PeiN/BivqVU
	 8A1kCwNQyemk/M7YVR5v7kCzG7i/dW6FQ6kEd+dKU2W+pB75/j/9i2qjx+V/wLfExoaCp
	 BDRRDgnB4quOhBXkIKmIiq8LhBvyLaixk77omG8Pco8NaS3+WFKNP+A8O7bE0jhxXziKK
	 PaBnqRPQlbCgtIck750PmMSIZtfkGkp8PzBZf5FVsaNn/cuP9QU7xlRCfYXyoc/bptq7O
	 smy6/TYdN/O5nkhThMuC6TcovaH4+UDZbkU2FyhZddyJrKgprvCFYbI3A832h42u1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=i0qQyRd4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PMVykVLb;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C800606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C800606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=i0qQyRd4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PMVykVLb
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A926EC0210
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:30:18 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 22 Oct 2026 03:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792654217;
	 x=1792740617; bh=L5LJ+ByyEWbdQ/y9DWvA3i1OSIuzCaIIpIaH1rEmhKM=; b=
	i0qQyRd4ct0NtZmvOjOFH0ZOH5pq35IOfDlN59/rPGE3STZkUg+e+lGp3PSjTstP
	qDxL0m1QfNqPRLXeka1mCmzric02YLQ9bRY4VFpHnWaM+Pp+7lQQDALF/m29/9h3
	eK6fmNHQURODo4WPzKqhLEhc3scdnz8UEa+x/YWXhH2OUGWUplkxFZdmPHuWamwu
	57uB7aKOuf4gUWJOIXG7eR1LSMI6WXrUm27OFVGgdh17OpWMbw0Ka9HqAJ+1Xqk8
	QPa5hhBXzuKXwZyrnN6/LZqgomMhLkSoCboqnrrTemHBEJ7h2ObAGqMLHXkHh7UH
	5FjbS3Tb8VyYjIBuFGk0+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792654217; x=1792740617; bh=L
	5LJ+ByyEWbdQ/y9DWvA3i1OSIuzCaIIpIaH1rEmhKM=; b=PMVykVLbaoMVDzpJY
	6gc5cqesk02Nqx5+W/+Pm5h3XjpdTrHPZx4SVWYr/2WCnGLuFnm3p3PQaz5rJYXx
	PpWNOjwkF7pJHFItIhMdm3jiY/fT6MF4GBX9xQed/cyxGjlBKcxGMF+nzKBjvzZH
	Vq4KpD0cUR2kke90/o8zdAS6qdoUjxG8i8JgXGXMM6xrjLBiBTOc2r0SO+tCbIqa
	XKiViqehWMs/rfwBCCWeIqyHY+uybIfOln3t1ozQfNwAAT65hDwLbQCLAeWSYIFo
	+tyY70R2hClnHBRwQpt7eFj95cQBCPO0rSfc5xzCAtg4RyUUqOK1eFOGlHPjXos2
	u/KQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792654217; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ebECc9QqO8LWQUCdwKKu8IWK+2ESW3Czrc8zAAiooa44MdP
	w3XAg0ks3iFZRItVDQDqh8ttXoXtS8X/Ps+jOTaGzljT9KszHck01AiLBzQONCdh
	Mtrl+7yoznPxq24Sues2yzblCAZ7SPESkzr9ItCk5T3hVcT7W+dJvf3PmM6df73o
	F3xkagpFEBO6eVoKXAJFO5z4+k8e1zyI/bvS6jT+bGiBjtq3hEVtdYUR/OZiN+uT
	F3nKWVoFOaIrYBnTJ7jEfVz9TI5H8HIrDPM5xQ7n1yWr0RO0z7oH1LDmD4DkYu8q
	U88vEVJY21GNiPOFCX/LlHcmTPlR4+RvM6BYdBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HaWXLKrPdWONojIjqsN74D7fC+Bzbz8g+cP2TlV3PEM=:L5LJ+ByyEWbdQ/y9DWvA3i1OSIuzCaIIpIaH1rEmhKM=;
X-ME-Sender: <xms:h7vZauRqH57jXlhm7m2sP-QU2to5o34W4UQ_Eryc7bs4oRkQPWbxLbQ>
    <xme:h7vZaukuKKvvEHBz2pWqk_dV96h1HqS7nflqby59iUSvk_7OSkEQ86IFPkPm4WYNK
    dm0aHDFE7IXwj38O2DKqUFkGEY8xzHQSLoNDi2eMErShj6x9YzRFDCp>
X-ME-Proxy-Cause: dmFkZTGMNrvK8CG735RMO3A55ValMf42qdG1Xs7Fm2UKet1XIKVL8QRdLQhLvPfX2L9tix
    pMZkSCSrh50/Zh78m3cPfPrLlYbv2sla/6qZm7DNhVuGuGrwMX1qiX09WvbmKQOplrYNNe
    rmRoc5Sl9ezB1AANB9P1vHLnBIszHFRIHN0aGfsR1HaVDiS8Ttkmkfek2hkHSqhtcHtJan
    /6mLqK4Ldutp5o3HbmmpJhvTxyNKw5+kJFsy9Pce4hQihCCrmTHFZsgDjzDH++ym+P/EyK
    Y+3cSF4eIECDzqHbKPS72M26ZuK+xHw3iGlrcqpogtj+pc2gmO6wWY3KJpo5CNbOKYkIj1
    ztcczcV0Vuu+WYgPL1ndS+NduaX3S0/kp3Tv4bkAaCspCjRtt2feJ2vF8nQoxKsC8hFwRy
    QdQEfWZrT1fdle/JD0ZcbWEScNM+huLo3ilol3wFMra1Jjb8nMITUl6WwlqdMRD/BYmK6E
    9pp7LEQlx8Lkhs/HTofsO6pcFZyA8sDzsdOK5ze8xV/qzLGxkj62Br4X4Z/A0Mj3iB2DYb
    GQfyfu0cATVdXi81zvUXr+we/hSxxM9S+x+/2ZPYQK182GoZl1kN3D3caThSC5FoGPWdW+
    XjfcBufqPn+8iHoE3HW2ErT5a/xyI3diW97Tob35d38Wl3/JEsJGS83cYZjA
X-ME-Proxy: <xmx:iLvZag9Tak-YEDv1wkTXSf3xSZrAvcZs5-Qhg6qL6uDFaGNMMXDSCw>
    <xmx:iLvZamogkxIjWLvJnRka8u_Vd0K59SfiVv-Y9HwljT3TLnlzHi23tQ>
    <xmx:iLvZatmGQs-Bf9rzr4ykC08jgruGh1OJrXnYEZehAgnqr_EZ-Adklw>
    <xmx:iLvZatJLHiBRpwpkjoOhFkR-r1XPNAfKypM60-Z5ZKSv-39cgwtdRg>
    <xmx:ibvZajAHBjRmkhejr4YCL0y0pJZRvj4hs9E7znQa52cwVEh71rhQkVeE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BBB7B22C009C; Thu, 22 Oct 2026 03:30:15 -0400 (EDT)
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
X-ThreadId: AGAb6ilPifF3
Date: Thu, 22 Oct 2026 09:29:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Emily Shaffer" <emilyshaffer@google.com>, git@vger.kernel.org
Message-Id: <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
In-Reply-To: <20261021200341.378978-1-emilyshaffer@google.com>
References: <20261021200341.378978-1-emilyshaffer@google.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026, at 22:03, Emily Shaffer wrote:
> Not all discussions can be settled by community consensus. For truly
> contentious decisions we need a way to democratically make a decision
> that represents the majority will of the project. This doc outlines the
> methodology we use in the rare case where we need to vote to make a
> decision.

I=E2=80=99m a lurker when it comes to these things, but this is the firs=
t time
I=E2=80=99ve seen that the Git project aspires to be democratic. Or that=
 I=E2=80=99ve
seen any wish for that from relative insiders to relative outsiders.

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Hi folks,
>
> Thanks for your patience with this taking much longer than I expected =
or
> wanted it to.
>
> As we discussed in the Contributor Summit this past September[1], ther=
e's
> interest in taking a formal community vote to decide whether and how t=
o accept
> AI contributions. The topic is of course a very contentious one, and I=
 don't
> think that we're going to come to general consensus the way we have on=
 most
> other concerns in the past.

The vote will pass. Those who work on Git at least once a month work for
tech companies. Those tech companies are now AI companies. The votes
will happen to drift towards agreement with their management.

>
>[snip]
> commit outlining the voting process. And by the way, I do think that w=
e should
> check in the voting process; it seems likely to me that we will want t=
o revise
> the AI policy again given the pace of development, and it may be usefu=
l for
> other discussions that we've had trouble resolving in the past.

Even the Himalayas will flatten one day.

There is overall great acceptance from the powers that be towards those
that don=E2=80=99t use GenAI. Because either you adopt it today, or thre=
e months
from now; it=E2=80=99s inevitable.

>
> BTW, there are some parts of this proposal that I still don't have a g=
ood
> answer for, so look for my self-review immediately to follow, highligh=
ting open
> questions.
>
> [1]: https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttayl=
orr.com/
> [2]: https://lore.kernel.org/git/20190924064454.GA30419@sigill.intra.p=
eff.net/
> [3]: https://github.com/git/git/commit/5cdf2301d4a8b439f89fd2cdfed1373=
6ccd64a30
>
> ---
>[snip]
