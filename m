Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842678;
	b=VRR3g8eftTCX2wDH+kFu1B+Dg0fp0U3ffNpaAIVnMvlp75G+5+cGGXGXGou6EIlItVxL
	 2yoi4WEBlRfc3laW3l6/N34V8qEfdAYEJY5pBZ1x0e0X5+R0KOB/BlB8eNXo0Z4v71OMB
	 BGzxLC6gDCCWbN4ed+vV2k+PnGCC1EwmSQ+khZDXKt04QxisAHXe3SX8blQBI63p29i8X
	 uOyaoEv5GhkuqJYTKsENCdbvjSQEcYVtDnfA2RZdIY/czp/zPGakz64HdIU2OPVIqpS2u
	 Y/YBwBJuqcw0aTt8CUpGNDP+4sDOgfqxby/hOP/31f6dQOp8/4UYWwEy43qHnr4hK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842678;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=87ouiL7EWR+3EX04xjXOHmie6yD0vBaHM/gBa7PLluk=;
	b=w4igWFhF93T44H7CKpiVkcuqA8TlpYQBDhuGMhZIC4yt1JgR+O8ShKSmLIp92Wln7JWI
	 RA1aPx03Vu1l+9gaKwp7NXHOPOrfgEb+APYAW/TOP+AMZ2tMO8f7Ogt2AHerONwsXn0m3
	 NtEjK/7IqYkr9PImzdB90JC8mPcO2ldomyn4/v1GFKUZBEkELOt9apeOBBik5s4clVDZ7
	 /8QpXbSYqcBUiyO1FbR1Jm/dTWecizn2rEjJ+F+Q0MIQ/9OhkhWfRYDqbuVDkAQINhBs6
	 9CpmnGvfrV0rCQWCp/Wdagmmmoh/rQ1blj1bk4xs/HgVV84Jl36ekxx2HqT7a55t/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MNxPXP38;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vuR1ggG0;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6D606A330
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F6D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MNxPXP38;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vuR1ggG0
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 71EABEC0180
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 10:24:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 10:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794842677; x=1794929077; bh=87ouiL7EWR
	+3EX04xjXOHmie6yD0vBaHM/gBa7PLluk=; b=MNxPXP38LvX26vv1fy4tMZ0TX+
	P0ZCLll03Mavcn4Q8fE3vqoRVCV/+95bl5jeXnvN0mAsWs6K4UfhEm8D2v1MWJt8
	qvyI0lhge+sGAZuq6+kvFiyR/zgPP97J+WklI4yv7yTIUKrX7+qv5umqrDgYp1g7
	mLgViMYY01RHSQ1KN8VbGnjeOCo049f4fU+rtmj7nRlvj6HBmbWoN2snYpGEoRBd
	Nl7bv/wib9PpZt0VrcwgZ6PWGcOFbS7VzaC/kb6LSytGmNe4PGrdfmIGdk/bp3e2
	jR5uU5MY1WIq7LgbiGvrui5MR2rLafxoJsYDY4/LxNe9X7L+L3FviU/3xwKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794842677; x=1794929077; bh=87ouiL7EWR+3EX04xjXOHmie6yD0vBaHM/g
	Ba7PLluk=; b=vuR1ggG06/T+J5e8Pd+vrdasyng03ljezONn6nxvBKsIJ1z+/b4
	4c98RA7byItTP2YKXWYufiw9Yar0vm23KPPMNRlVXbTaz+Q/Un1Q+D9LBznjFM9I
	geZ9GqaHrKdX2xtL57IwbEWDcKQCoQZ//rsImsWXf5SoYFRSjsJox8DifmKPLV5/
	byhr+ib4dKSsk7SUFihaSfhMqLUDgp07IgiRSm9hyVLLiUFvnDGu/Yisehm2FnDH
	E83BQiNvxeM4zfEl1QNvCpj21bA/b5G//jwa0ROwUICz5pyIUNRNqIaAmy8mVXYm
	uIqBErzbZv34y0SKddN7Yg6pIxlgm4ZaPrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794842677; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aQ11DRCn7feoax7aSrDk3KZXaCsirz0nzPGfmLW3e/m4I07
	zF1V7dFEMSv/eDSLpGk8BdR0ACn9vKTYeo4cMxi6q3TQC2tOr5gQQkW2v3/HdWj9
	xQ6KgIkwwlrpWWv+y+eAPgDIylfCOEYGCNp12LxZc1fC2UFcmaZ4T2+XAxMRZva2
	yxgPwmk+jmlI9n+MBLbHMpbgZp8cqo4+deGAp40A40c7ue25yjeCxIqe8NNUkDPA
	gr0gHNUPcmBoWWcze+JasXTDSIHjBQO9UJWu3EdQ9s1FSdtCSlJMvyzdWprv2P2J
	z3pJfq2u2bNQgolGLYP7FajuoB9m0G6TsRHQG3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QWqswVfw2BNiIneew68wcps1ARpjUUj/6Qxcbi7AK9o=:HfnzhAcz1UUgCpPKB+EUJmfdo9QXSi8gRkvi7GfHXYY=;
X-ME-Sender: <xms:NSD7atZbwS-u5qOTl2KzK3V18SZM8Vhk0b4aEwshlGzeZE7c0AyDxQ>
    <xme:NSD7arRES2ZDQcufTzze5gG1UsO6zI4vLHljlZwEDz_S-0RMDQQTGY7OnT0wofkZ6
    OQ6V17JY-aeDU053T6vUzjoiHh3IZkw-maTtLnoG2dQ1RIIL3LFLw>
X-ME-Received: <xmr:NSD7aoSLyD664fG7J9qBjVUophUIKNrpRlg8CFo54_wRZU4_n8sOu5PQEsztlqQcMNHH8QP7dPmCD3hM-s5r9vp-mLN3aOxIB2qX>
X-ME-Proxy-Cause: dmFkZTErCk4tXKAcBVCMiTRaA0spcxU6TN6UEJE36hgGBZ7c58jceJVT7INNa6YlOxv6J7
    ZRWmk2sHI/FwE9YSXQC/aKqLDg5o2WlV7vp36+GaIGENaV9XkpmlESFojow/OzIh7H+xxk
    Atp8rGRdCe/sAIlMWpvaWg0012p2L2tKHvQOnUz05JL7AM7Ld/bfFqwY6UuzUwTccyppvY
    O9/McXItHK9PB5HFvvCBs8i06T9VJfRRtu1yOXSqwQztRvnjtD1jL0FdHzdlXK6cY+Nd34
    4aEx71162WiypGZv9QJYfh899M4Xj/6PFZQIvhJIWL+O4tUJclXz/t5dCCc97gwJ7OWgS4
    VDvSXmr+LF5UrostV86bRjymVnu3fGpJ2sjck8Z/Ur3MkIjwLYzcVaAj5Ep2w2JvZbMXxP
    UxPbj+k0X8b6rt3Fn1OfguwZcmARWadq2K3k5sMCyL3Z4CZEfwt0DRWMIRUlyEscjGq3QC
    1bmumwqK5Tw4EJAkYBk9XCrHVEWa8NCfs+X5N0fOtgZoxqF/kSFXDebk7licWYa2QRg378
    ilyJxIMtdqUzdJCCIBAviDd6IQVUNAy3k0A5Y1tB4UwbG16n16DgR/no0FB6zEBrW8iMss
    /sximUP6HQb7t/bUguBTj6zahWQtFbUbxUhLSdCU1mgMur0muuA1/wAAPCVg
X-ME-Proxy: <xmx:NSD7anQpDYSkNTAxQutdd40Zt7to05K7ZUDDJGcMKFGLm_274klBAg>
    <xmx:NSD7al6b3hBhxzfSSHBZVi70brlRJGU0O_L1wkwzpzjQ-sB12hoZqw>
    <xmx:NSD7ar30AvGncfZEBEdA46cq90Zj1G9Uo0PX-_A739cTL8t9ccdhdw>
    <xmx:NSD7aoBKmSAkMmUjmzR6YRLtrd__oEbO08Hn-sfH71Syl7tcy1vRzw>
    <xmx:NSD7avyWMmgtUvacer9xYTWtoYrV9AoiYguhWAI3UttJuTPpyDTPRG6o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 10:24:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: yusuke8h@gmail.com,  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http-backend: drop strbuf pre-sizing from
 get_info_packs()
In-Reply-To: <avqi2Jpd-QT5iNU9@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Nov 2026 07:29:44 +0100")
References: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
	<20261115-http-backend-drop-strbuf-presizing-v2-1-b7ffe1be4482@gmail.com>
	<avqi2Jpd-QT5iNU9@pks.im>
Date: Mon, 16 Nov 2026 07:24:35 -0800
Message-ID: <xmqqy0asn6j0.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> This pre-sizing dates back to 2f4038ab33 (Git-aware CGI to provide dumb
>> HTTP transport, 2009-10-30): `53` assumes the length of a SHA-1
>> "P pack-<hex>.pack\n" line (under-counting the 77-byte lines in SHA-256
>> repositories), and `cnt * 53 + 2` uses unchecked arithmetic.
>>  ...
> Yeah, that's a much more convincing message. The other angle that this
> is missing a bit is that giving a size hint ensures that we allocate
> exactly as many bytes as we need. But that shouldn't matter in the
> general case, and if you have to allocate gigabytes of memory to store
> the list of packfiles... well, then you really have bigger problems to
> worry about.

Yeah, miscounting the preallocation is not a bug and just doing
pointless work.  I agree with you that for the purpose of sizing
strbuf, you have a larger issue if you have to worry about
overflowing arithmetic.

> So I think this version is good enough, thanks!

Thanks.
