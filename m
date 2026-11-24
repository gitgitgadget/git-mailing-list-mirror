Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543950;
	b=1KI/43bBWpuGCJowrYAK0v5y6r471eWR+qBqswZMFGWk4v1lTt6TD9Gs8jPJKgqNjPtk
	 PGqoh5mAIXQm9rBF1Kw8sNhGYpJ2cEDAzivMNcA9tqK3HiYkn9r3YA4NA/ZvEGJYPkdja
	 aq8j6Qxnvn6JLWLOtFgUkpTX77naBiFnwmG3O+awOkQ5hqdBdoetvFhVvG5ShyVlwK7fi
	 XO3UabJnWGEU/aD+wr5LyrSnGNnLC45ImpfiUIg897da7v1B3YTPXqctZsFsTtxPRIeJr
	 A1Ro1VhBREgiNN8aA4maKaufbupcq9NOeb1SN7oNR01rm3V25Ietb8jrB3zUej8AVwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543950;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6eDz6dN3Qc/NPHdJFdFuw4YMjFHCgAafAUbHYTL8cLY=;
	b=q6qUlB1nJ3TKC7+JrhZW2PORl+iK/kpjnOrkGjG+mQu164yfvNTLzZh1Xv3fyV1K66pJ
	 nBSW1B4Ed2bY5PhfV0xwYEO+FBt/fIiaYN0H1LclQnnz6Z1t6wPPf+tZCg5q2aBkk+B7w
	 ZaiHyYmgR1lIMcoyrnxGNqc1B3Ch7wdyIy+Wj+RbrxHPv9/laTA2q6WtOKB3eq5zNGsKH
	 JtGDyjmrgn9e1+h6+zcP8AF6aykSzWjQ+8CZdYcNOJKb41ZMQPi+IUFB5ZhoxxfYbmn9W
	 pOTHNtziADOvScw1Y+JddNyvRL33bU9zs44xTD7XBTpmBjdTQJimaXpqHUdDlgSgQEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aWw1Zl0H;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hHv36HEc;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20929606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20929606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aWw1Zl0H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hHv36HEc
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E2A0EC0C2B
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:12:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 13:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795543949; x=1795630349; bh=6eDz6dN3Qc
	/NPHdJFdFuw4YMjFHCgAafAUbHYTL8cLY=; b=aWw1Zl0HzMFU5V1qG8c5Fc41bT
	NbG+LSJVil3t8vvYgNm7U93rm94T8bcJOAWGpVWLMyfi3rfPJN0OHNYVkBLVMqGD
	bEg6oFumel9TmT6CJ1ZT3ZchdXBZKubM7tSto1/tnCiHTRMeBVols3XauI8gm1/u
	+fzlm4NtIpnrzShQ7QrXaw4lxyj+wjjaroqL5RyvWJwkyFz7WR8Bjbz8QTkCnzD0
	rGpxGY8MBRBbRmYU8KKj+FpTpT2B3MoNualOZ+MnZKFGkKyT9hBLfR1YGu9o8f94
	6OnuO/rcrIh+KKJZcomKogSzydqaahEUoL9PblDllOw5hPCkJZz3eNPqUIUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795543949; x=1795630349; bh=6eDz6dN3Qc/NPHdJFdFuw4YMjFHCgAafAUb
	HYTL8cLY=; b=hHv36HEcALb+Tks8l03JYtELUUXHyXfZWn2FqeYmh3zdNUjrnfI
	uGbm1ty/BGDw2jdmCJEt7AXXXE161snHzAcUz/3IQpN50cfI/x1gTXC1fWOX2+Nm
	3vla5fjxtzeSqW42WSndyR95k0hUhj7sbuw4ef5DmodwUzRF529aLy4hHP/9neVU
	5IpsGzfIwTWrWSGERIIaLcDKiqzuXKMZlQmFuLTZLBTev9+Zh7u/Uz4d7Sib8U0q
	iGAEIQTXaG3iXR4kfGm0ZqUicukAXi4C2xOKhRsfpq7OR62BvRYaJLKLm63atIUA
	rB+sJan0yyqC0t4ET7IKqe+cVxivImJpKGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795543949; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YG5F1fMk9cIOs4mrnq/38XExcDujj/1D4ElhiFSpRS8QjGt
	3djrUMuWgf3GhEtcewFeA2A/T/K/31KeRv9pVAuVOAtQYHa1ogd3HcrGIhOUga+P
	Q9sL9pz2ApRXgV9ohs+qyWbbuh91WtlfTD+X+SUNEuy1CWT1m8wY3FlB3+Gn89IP
	Y8xzXVOJVXZRjHI2jqOqdBFex90IV6r+60K81nC7AeigP5P0GXDkBDy3NKAN7/Z1
	yLCCyzwqaKzDUxyJqi3xPgC4RIgXLSFeR8xemC2zeVedHGykh0k8Xt0y/y5TRP7o
	c/x1ck5vS0ZGqMnFv9t/QLlR5PKdxwasnJrXDJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ispE9cm5A1JdcsgNGkVvaS12EwIR3L4DGATmmjEA/28=:6eDz6dN3Qc/NPHdJFdFuw4YMjFHCgAafAUbHYTL8cLY=;
X-ME-Sender: <xms:jNMFa54Irtbeou65vwDhyLtTZwzAL9qnCt4GZZsDUtxSNKnApNFu8w>
    <xme:jNMFa4bJID8oi6kWwQh8FwV1zxSnoD0ryr2LE9Dhw6Eqmc5BUuFn9hyq9wuIztv7Y
    7DtZNH48bj7007ZIRKgXwcUjbQCzaQOHHmnlDJrwshIh0vaD4g_QNzO>
X-ME-Received: <xmr:jNMFawjvoYYEifsHoEKdAh-d2HmxLcRDpA6VAOhMdy4IxLuUoyB1iwQN_cLd0heP0YnJHpP21xI1rgUEBP0MMuZuUgLsjTVmfVkDr5c>
X-ME-Proxy-Cause: dmFkZTE0oVZ7rz801sQIM8rSKbGOuW447iqXX8jV7YYvNFqybFDUAQjGSUag61UKz1/rzd
    Ndx7OoItidB5hWRNJ24eYitOCyKa6CvjjeARUA/VKJLNysneDGKAyjc+8HCXZ3HuOpo/AF
    gQeGq3ej0LYMEJMB644siOwxNlW+gMgFviKnecVSIeuQx7osrTPkr5G4IQnatOtM3VhCmf
    NjTLapXfpzv87WW62IDeI9r2jf/nnPQSTxMLXmhDr3vBPkLNl5DL//bZK5UEkBWwsGG5rn
    YwkPdM8uvccgQViKrah+YD/F2tmLy9SwfXQbM87lsaVJbwEn5AdWLvw/7lJ6ykMxXmjnjt
    mah3qxt1ps6uG2iGoBvtdVKNnyrsgZ1UbMO58hTbA0Vjxyu8OLz/UfF2T5iATzJl6DxdWE
    W3pn7VdB20qAfMrVjD2Uwsp94KHnOUqhWEhMuwlAB3ysy6VeJEUZxtE8H6DomtAezYGYd4
    7dy2syAuEA4s88PYu34BrAc5nEwoG+kmspq4ZHm02AUT8/5AzCOI9hZgF43LSo0M6ZE6Qu
    c4pTl6GB/8XHZKTV6Ixj1RLSkKFJdbLEpK0pPePEqht7cdvv+PxV7F9Oy68Ptgd1NtAhds
    IeXr1qQUBCWJ+zDufQ59peUfrSOUnfKsN3XMpYhTTQYCI1ZRsadi7OX2THxQ
X-ME-Proxy: <xmx:jNMFax9QEB_VbBrL5VD4UYF1IFV_nP1saPf9euey6OYsmxYW-U7DBQ>
    <xmx:jNMFazo_u_Z82WzIgDzNA-rJjvEcZzkSFh_PKGa9ZSrTKSwN6sDpnA>
    <xmx:jNMFaxVJcdWBihfwCLXkEunEgsCub_2fUopCkASvjOACtKS0pUCZcg>
    <xmx:jNMFa6BWBIc2YE3sDwOqVrl1tft3aTNSMFudDQSGeIBSPw6rxHXYyQ>
    <xmx:jdMFa0Fdv4nqTMjGvbTPwLaTDAKPIMmGUUY8AtoiVQ6wBbTj2WEdSAdK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 13:12:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wonseok Oh <wonseok_oh@korea.ac.kr>,  Wonseok Oh
 <marinelay7@gmail.com>
Subject: Re: [PATCH v2] fast-import: die on EOF after an inline M command
In-Reply-To: <pull.2323.v2.git.1795497145494.gitgitgadget@gmail.com> (Wonseok
	Oh via GitGitGadget's message of "Tue, 24 Nov 2026 05:12:25 +0000")
References: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
	<pull.2323.v2.git.1795497145494.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 10:12:27 -0800
Message-ID: <xmqq33sqt7xw.fsf@gitster.g>
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

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wonseok Oh <marinelay7@gmail.com>
>
> After "M <mode> inline <path>", fast-import expects a "data" command.
> If the input ends there, file_change_m() leaves its read loop without
> reading any data and writes an uninitialized object ID into the tree.
> fast-import then exits 0, and "git fsck" reports a missing blob.

This describes the problem accurately, but wouldn't the series at
https://lore.kernel.org/git/20261122140347.41990-1-gitster@pobox.com/
solve this infinite loop, together with a few others?

Thanks.
