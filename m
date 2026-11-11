Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428264;
	b=XgNxljwa7eW+SHDnL2TS0N5mysx9PPI2rQje6FRloJ5nD5lEqrWGIeEIWZRZFax1voLD
	 6iDhH7uvRjKQ8/sawboa6lhqtmG8X71F7AesQ9w6qYK+JfRt8RdjdvEmQY95eL/rX7yJ/
	 /FKluyOLZTts9Yw7QMzzCjhlT4WMIHoLgje+Uw8zQydUA0BLc75l+CnEoG9gijG4pQRGz
	 q6UOz2+KHmAgeKyXkvhIUGVRlcNs3A6G7qHAB8cqutBhW/rRA+xm3tRKJMLSXEb2RcOi7
	 OBX2iRYKEzHhs+/330iGSLsI6DIg647WChMozFigZCJ/hfOFPeu7avp39RW06/VyMWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428264;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=d7MQuLBNILSAusH/MtYzvbuis72re8KiOZ5uX8UJp6Q=;
	b=qUxPK8JNn90G+PcWR+BpmL5M3WQhK23wd46BPR63yE2+y1B5Xsr1a75pfrDKnUjk1U7P
	 cpBU4tSFnwOD4SdlK1WjYJNQyK/E9MgQq280g/3K8HAhIh0CM+5hc87t7n5lA9EfQFCJe
	 NQG1OgYjxEdr/Twbwz+VRCCiPMPkrxB55eK7qwzrAIaY681Inm2i3GxXClP6yb40xfmu9
	 nTDb8ENuMbMx8xpxmgEdwZ2kCEiWfkZ3fZGBh1a5kfNsfo21exuHDe2U+gXcPfd/XxIBh
	 YSCoymAhRJiQSrWKBvfpm8VQFPzzTtRduHH5AgIWegSO8vFawycyVpri5rbidaOL9qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b="pnYqXFy/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L63Qq8dt;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1A606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 20:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=pnYqXFy/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L63Qq8dt
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 609D5EC0639
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:17:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 15:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794428262;
	 x=1794514662; bh=d7MQuLBNILSAusH/MtYzvbuis72re8KiOZ5uX8UJp6Q=; b=
	pnYqXFy/P/coU0F7nWqXIF/RwnMfZtCfSqGra62ZwQc1G4bscHfvQwDHYIJi5mAf
	M8flo3k9MNEHsF13dnIrjsls27zofZb3bYcmCqirdCCT9rG4xaMgmkTlEFIXz7Um
	tf8rNJdXrPJfPV3x+ETK4/2m32C+AUnKut63B2JRmbPXb3q219GfhJa4S7FiJxhU
	It606P0S0XuzD7K1ctRFeZn4i5aKjqql0aMqWnU4YBEuDQ1CUibt0B5189tTljXF
	UvG3Jsq2zQ+y6x/n6C+o7Vr99ORmfYRqGJvT3WMBxoHKBtId4TpS/Sn9sLip+JUz
	OnxjU0EonzMu8oe8Iul6Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794428262; x=
	1794514662; bh=d7MQuLBNILSAusH/MtYzvbuis72re8KiOZ5uX8UJp6Q=; b=L
	63Qq8dtSfJJpzXeYW2B6tMk2b8nsHg/WauJmXX5M4G9Pj/fUf+aoahgxBnIAPQZX
	dfVi2cBBBw7yvYFZ23QgBsixvfbyW71vLlfJdkNfaey0D8UwL0N08SlYNZrT1C+b
	Ax9Z15mwbXHq0QhfPT57uajel4Ttf9pDVA6ynU/SE/yzkCvO83QvNiF24diAdqb5
	19H4DuyX2WdrCNbwv2sXn9HGdLzCAT61IO7SUoVtoGDYnbfz1qMrls8CVF3sIH8D
	9zj5cCy2m6/e0MiB0ijZ0qV5SBh5RIeygOf05vel/BGMXxMRYz2re6lzn9BMK+d/
	ZtsGvHrEpRqryuPtSOx4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794428262; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JOSpuYcJkFdOlecmv0EYNu6+W5Z5iB3F76KqRLSV7aNwo0n
	FRxyJPVn4PPq6omoaUb1pqCUu7jYjqSpsinelKIo7S0ys4Nzaj/bsUwks5dqG6Uy
	UCvqPEmHzq2d759ws6BTlMu+r6o0pBMKpg+OcqlPJHGtJQLBco/WHjvAfS1ApcSS
	XpuSzMkrp4ycR/rFGO4g7mXjNYAuzRNqJVFX3R3meQjhZXe3KYpOq7w4CphVmyVz
	ipNv3G0M3OdZC/VQB7XBTnxDa2EwepcrlmgyxDKXMnlIULigGLRB3sASP88lZn/n
	dTiJtfhvDDSXX2yG6CpsvgS9UZ9FxX8k/zihNrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ft/U6L6X2CZsHUwscvWw6k1BOzW9yp83G/EeCrvlJ7Q=:bwr2SI2YuDODIlt2A8jRh0rHsl/ELT/ukF/472NgYT0=;
X-ME-Sender: <xms:Zs30asUAG8pkSO7UEnFu23vtq1y9gNpVgiUX8M9gAVFLypa4iXngBg>
    <xme:Zs30akSTPdPmXySEMQWN9WvxarM_M7B3xqr2hyJ9o8IPVvTFgEfx-JJDf8Y_vgYWc
    3CYWrIWzif2osf6CG1upN4PX2U9qmcKqyIhwP8R5OqLBI7VHLzQbnzGxQ>
X-ME-Received: <xmr:Zs30aqMm-kbYDtK8gNBp88nnV51EJgnR0Le2GWJfcJPF_u_EeHLyDjnYORE9jvzT>
X-ME-Proxy-Cause: dmFkZTEye/0MJrdbF+RElih0Z/zafkguGmMAycXcsB4hN0OIHKPpHrCdHoSR7fD7naK3/D
    8i+Zw8zHCRL3mpI0BJDKQ+bSwPpf9dUxGWiYOvf/Plb/h/my3Y9fg/UrA0wVWeuYyMrOdS
    WsQVydYcgcKnzACUMfifcPemZ/ZfdkrH3a2jdTvyK+TmRqJHXArWrC8QpGOiJCdTxvr0bs
    Y12cdYCi5mtZLcRCSoIfe5T2BF3102OiG0L3uS3bhcDqGQvin898CT8Ap5XSag23kjz7q1
    CLeTCpNAMTiT8kfEaRhm3veINSG7jwtk30dEClovjQcvOETvMxAWpZuJuOVmS/ODxZQZhW
    T8imU9pJoY1UTY3FV/PRwKczTGBywQdm+wgrZlwmxvvbCpT0S1zP9CgqDIkeP45F3kZiQH
    78IuLttFr6ioZ3JU13kmowGpCvczeK1cOa6ESlKCsMniAldGV5YGstzxslcWKOYHz6nM1Z
    11NizfUCtNm59qxVFQo23El/ep1Xafof/Ntt4u6xfDKd2Hd5lQOd7FZkIe83le3MEY2XZZ
    djgKS8ABl6B1WneeiS/STcjywk7JVhaMU7gcYcX+As/PyobPiGVNRH4/XqgN4qPzwKFlxY
    AiA0Y7MsuK+jzQifANIu8IDwcONKzDKzDIaiDUAyLAUhWE3JPt8GQWlUwe4A
X-ME-Proxy: <xmx:Zs30aiRVatPcXKOI5MwbuOXgj1tsKNxL8XAcraE2h2XVN_hlMkGZMA>
    <xmx:Zs30aohnaqgNOSurBRINqSAA5KiL8B3h8tgRGY1qTpPkmC9VXZwPFw>
    <xmx:Zs30ar9j4j7jSx2dOBBPAy4WfDPuApGh6MQQP5eiK_ynlUx769y2Xg>
    <xmx:Zs30avGIHtCDBz608nWB4Buu2cCdoXb3Aj-Nqb7CH0Gmf9CKqG7VVg>
    <xmx:Zs30avHegt7-JTST3eXW3y48D2x2IZAMRa6wW3w9gtEXx9qyWTriiQ9s>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 15:17:40 -0500 (EST)
Message-ID: <543df224-2385-4a89-a25b-41cb0cd46f30@jvns.ca>
Date: Wed, 11 Nov 2026 15:17:39 -0500
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
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <20261108023730.GA1242909@coredump.intra.peff.net>
 <xmqqa4nhwstl.fsf@gitster.g> <xmqqo6bxvdbf.fsf@gitster.g>
 <10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com>
 <df9ed9b6-978e-413e-b001-b4f10c84a114@gmail.com>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <df9ed9b6-978e-413e-b001-b4f10c84a114@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-10 10:25 a.m., Kaartic Sivaraam wrote:
> On 11/10/26 19:16, Julia Evans wrote:
>>
>> On Mon, Nov 9, 2026, at 5:40 PM, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>
>>>> In any case, I'll queue another SQUASH??? commit on top of the topic
>>>> until v3 materiazlies to fix these issues we have accumulated so
>>>> far.
>>
>> Thanks for this, I don't know how to apply a patch from an email but
>> I'll ask in the Discord to try to learn how. Same for the other changes.
>
> As mentioned in Discord, when Junio mentions something along the lines 
> of "I'll queue another SQUASH??? commit" , it means he would've 
> already queued the SQUASH commit in the topic branch in his tree. You 
> can view the same using something like:
>
>   $ git remote add jch https://github.com/gitster/git
>   $ git fetch jch je/doc-git-diff-examples
>   $ git log FETCH_HEAD
>
> Then on your local topic branch, you can do:
>
>   $ git cherry-pick --no-commit <List_of_SQUASH_commit_ID...>
>
> Hope this helps. 

Thanks, that was exactly what I needed.

