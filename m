Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493818;
	b=wtwpeedcnW6TrvVHTWx2sobrP/9MqS2a27l/JcCrSvU0WCebnFvOk0/4E1g7rX2acEVp
	 ffKqhKisQrcoFMgvw40YbwrGQLq0wpaeuQwUupexYXOBc+u6Clmwoaodq2Jj7pl/EtzW1
	 nYj86Bad4D+tGR4sH2Wh0SyDBLIz5dy+AyUHXryZKpa7DiST+tPcW/WZuoCbNT+foS7Ht
	 XmQdW+AZ4XOEu76CJPxbQ117qXfkW1yjSay7Cr1KrCU2R8ug3sA2ktSXcJenWNf4OFdZU
	 g03jiQ4KNA+NDhPYt7bk6RXG5Skioy+4J1v8KkVOkUU/j+KKgNtZWdcBc0dyIwuOAGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493818;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=wFiSTRCn/4Qz9tskczlv4Xpq4jT01FLHTnkdzib8cr8=;
	b=I4nkBKZm4MyTOwgYM9q+SQXQGZeQ8+UZoCsb1WhMu6i+Se2Ba1WF05vErTzNKIWpMWLP
	 ionoYsXN2hZvAG5/z4QcgnsdGxkFfZvrZbhhuEyX8Qommy+1RqIlWqgt/tXhUiX/jTN/f
	 D/dMyo23h3Ke7LrW6PtFdEWd7vWaRWkidqPK+f3sxbrQY7Ix1UOoqPTRrtP8VMwBvIIHm
	 yvg7iwo5M7lGeNSeI7trSvQXq2TQTw0936F0jAFf51mpMpcHu+CRrvLkeLvOO6youmbqj
	 GCD27Fzp4sMz4Dwgd/vmfzBTk0CBhxNXIwLSacXqz2aXUxULOy8B4rRHOnRbgiIwFew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=q2mEr1o6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BlaWzaBO;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4A606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B4A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=q2mEr1o6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BlaWzaBO
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E7627A0146
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:56:56 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 20 Oct 2026 06:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792493813;
	 x=1792580213; bh=wFiSTRCn/4Qz9tskczlv4Xpq4jT01FLHTnkdzib8cr8=; b=
	q2mEr1o6vYZGBWnvM04ek+wdytiLrCbjqXn8P8rpcUeWC9QfT/oa6SPHhFHNy2+1
	5nRQdK9FZhcxNO4tcUf83SBnDq0+KjNrqBl0WePWJkHKR9/FQplCxl8GILtkY4qS
	lElVUApM03efkcAsr9P6Or9OFT4EhBP57sYTyGP3+7ssi22yawMxcbNnj4S8NKwC
	Kw+x0z5sxFwHg0iYlCHvuEg0uI9bemyaXLJ8r8eyKbWBLd9xV/G6uvXbO8Zs6Z64
	U1bq2HXBdC7wERoEe6+xQFxXFFTv0JsPURAf6jPCaYVfSH4oBM/y57az67nCn39b
	dUiyUKoJOjiGrvaIB6JZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792493813; x=
	1792580213; bh=wFiSTRCn/4Qz9tskczlv4Xpq4jT01FLHTnkdzib8cr8=; b=B
	laWzaBOq4QVLQcssG1JcwAGEK1g6LBAG2/X2taIy/Sh7U0GrTaB50dMykxF5RhnI
	G1s6LzDLeq7s+sSdzj2x+plPfxCwgIp/KTRfb3Fx88fgfirZtY+lwwgu3Tj+FSvm
	ePsgNOoSKwVdRZ7lc8iEUke3r+4TIo9tmH/c/f8pPTll4bnDhZ0MFV64ZNaLQtgm
	Xd0DFOIPs5c3GQJY+O4isZ/zQBbn4JzCXz2geja7s0k0tjly2DAEs/JPVcjQWCtJ
	qzYmnfh3s4wF/QXqsH+5Ezd15Eeuo0cNBDPND0qTzOQn9XOvRoDkoKjkPuj/xic8
	QmYnyieatM/1CXEalVvFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792493813; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aKCuOGgHcINku4IF0iia89GcnhL5t23GrL/FNcbCu2eck8U
	TVuW07+BLtnv2tQmnryXI6/EVdDLZrsmKiPxj9nqteXe4KthKetF0nPAdDv8d5NN
	DRNKfZt6heceHxWbLPM4Dg1X1HOL9+t4uSJ4RCubvh0LVE+zWCj0aDx0lg/0fzJX
	EFHiOEHcqGp5jrdySWBz1onVXRGO8DzojviUnwq3JhugLlzW2gvWrlMFlnywkqmQ
	7KNgGsMYY1hFP5bgXEw/HmGdNjiFfLtbgdd4CCg3OULnK6CsEkqspwpnVJrw3WEi
	/u8B04WkMGfm0cd6jL+IDtlLPcOH9DC4pKlh1rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9BsLg/hXTdlwDGEDRISBeceLwWVr8gUogT1mSoKMiC8=:wFiSTRCn/4Qz9tskczlv4Xpq4jT01FLHTnkdzib8cr8=;
X-ME-Sender: <xms:80jXaiok5ANnCYwUxYDBhrIcRzJt-H74TztBJysnVvKqWv72YqW1H5Y>
    <xme:80jXarf15z7PFPQ03ioCtoimwR51xjuFnvZXfji7sXFQUlXnanBpB0kO0DkN6pXJ1
    -uo895yMxGoHpRGAWTaEcjxpT4yBFC971AvzujvNMejrAInaw3z3ck>
X-ME-Proxy-Cause: dmFkZTFOuoIXkz9RKa9MgrTDKsfuKsICw1CAQ8ZDuFOgeK6tKHw5E/ZbWbDr+21ax3g1Jk
    skltiLKC3DFHnY+YUPV3wLRAEWmzGzEfyTLTevnZdPjCe7hYedPafcg30pqG/PmxRztyOP
    f6RCZNf3Sw6B2N8dH6hxHjLZ6LQLjm6mzjp7AxG5Ps3B1cBNYehkX8ma9PNoJ8kg/uACSF
    7eVNnSPDuMv4P5AvTIs/X9QgpVMCVKCKLVPySrINhOxT6ROf8lsjGA+Q9SDavjXvUhoXVp
    S3xwfmb1tRWM7+c307mkxAyVO6SGmmhEB+qWwCXWahT39faI0z5JfVAAwjnT7e+LQALEKz
    IwWAA0Qv6zKtDn/wiopuL1wEDN9Q/r+wjLllobndKh5+P4caD46Qf+w9ApRmCfZIkorlES
    C2eOWkgtdYqug7uPBnf/c1mC3TZrDws8ubqEl3vz9YNtrd6Y5u0sm7As9yQ14yUoYRWgoq
    zS5NeAGfdH8oel/kAALfI5gtdZQ3KveR6bFhljqwL9/fn00UHEFhLteTtuDl92+05siTmy
    DjW0bvS9S2eDFXkySfKDdo1aE4AwLgrLPTtBR+OrySzJ/7tk78qiGanN5MDzk9lC0GQp0O
    AniFK2/BdA0lrxuYPgGYJ/8EVsm970YD/HAvCqqAvjSvsJvvscWliPIY4RKw
X-ME-Proxy: <xmx:9EjXagMJyO2uDYl_UUQYBSlBGb6DO-czse_W2zTWwlSe3G-RLBz1Eg>
    <xmx:9EjXasWb82bwWNxlcmbkZWDhWSBauIHj_dKquxzxNq9mr7ksSSxP9g>
    <xmx:9EjXanc3dT6-u2-i1bpVJzg7TGVMLZ3vWAjplYD4qlGu77xiawD7dQ>
    <xmx:9EjXaosahN5bgjgilSd5D8kIeE7E_9m7GnjYkOlTCwBVtT-stq9AQQ>
    <xmx:9UjXas_u4pu1i8rONZanGJeLnbD_L_QTzh0K7uRsgIGosbglENicZmRZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1F5C822C00A3; Tue, 20 Oct 2026 06:56:51 -0400 (EDT)
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
X-ThreadId: AUJkYdbIH3sV
Date: Tue, 20 Oct 2026 12:56:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Message-Id: <d8ac05cc-54e8-4dca-8757-ca48acd600b9@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnU1NPp3N7Qv3ChEPCo-mL=gASeG334YFg2tczzLomsm6A@mail.gmail.com>
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
 <5030377b-58c8-4193-8d72-79955082269f@gmail.com>
 <CAHwyqnU1NPp3N7Qv3ChEPCo-mL=gASeG334YFg2tczzLomsm6A@mail.gmail.com>
Subject: Re: [PATCH] status: compare against both upstream and push branch by default
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026, at 12:19, Harald Nordgren wrote:
>> >[snip]
>
> As a side note:
>
> I see that you include the whole message in replies, leaving
> responders to clean it, so more work for multiple people instead of
> more work for a single person. Isn't the convention to only include
> the parts that you are responding to?

That=E2=80=99s generally recommended yes.

e.g. https://lore.kernel.org/git/arz7CNEhQSoDwJ77@pks.im/#t
