Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792730917;
	b=vnlLJkIJQ926GquWQ4qgRA3q/7RtZDrAA2gVbIBefbr6bGzbNjFHQEyZhZBJIaVmPvmY
	 2tnywsJdGzUu8ERZLO6YmlH9I2BVjuAEwYf9z417CAEmPhjFNijtyIqR+Y6c1C/jOEH2O
	 nv2GVb2GdJoSaQMGVM0gcjNu2q3lPfyOuLKwh4zEDRDiwLOr2RMtPJOCOOMhM/VY66UpN
	 5uhlXT8Qt1BuJ2n50ko+CAjHdBLSCYIKkYltf3a/9GO+PW+P7Vr83alLC3bQCZmhbjMNr
	 usk/+zo06sRI0n8ASNT31jbFSoTqOgW0ZU2+s5mG0CfneHK74h7box2dkHM4sPoNrkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792730917;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zykoJlDGgYV+QINqqjNpHhBfUL4V0+vsu7KJZRiZwvo=;
	b=nmOTnWXJ/J/Kwzcacqti4NKeND0O9lCQVCCSA4mN7Z4Ad3RopIkY+PpqDXrYAFh5fu+1
	 oXjQ6eMYttv7bFsn25+fNLnpmztU63wTW0fIOWPQqjMHds/A3Vk2j/xAahPAXIBg2ze34
	 VZCrGVkayJowENzyx3siSlt4K26RZlKPfYOKqydr0L3oA1hfTVa8UJy99Grh7mgKR38NR
	 B4kMjELrG2LLmsw3hlSDhgBA1fj1X1rILmjPgAMIMsYT3YZBpplSbsYeUsqEsHSJUjC6c
	 jYBH0vXY0sTnL6PWyG9A9mZGaxNjzIjLXLU4uJRFAn4Upc144jS8IJ/MI/tsBnnldCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NuG6q0NY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hZ7ZM+TU;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBF606A319
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CBBF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NuG6q0NY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hZ7ZM+TU
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B24AEC0173
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:48:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 00:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792730915; x=1792817315; bh=zykoJlDGgY
	V+QINqqjNpHhBfUL4V0+vsu7KJZRiZwvo=; b=NuG6q0NYCcrycVAcvq6b62Td0c
	EJ2WuNo4V0iuzOzL4l6wcZA352hLdoK2BBCUTnRKOJUEBxo+OzBt3NLn7Y8rmzTo
	L/O+P6lalNSIDzde3wPm1VoFzHeAsgXJDTVlT8j0AlG9fEYPdIfMtTqoR22mghe/
	P2qdPLdm/qv9op/pB+JSRyQKZOTWU68IpJupsXANFdEcnLqcBvUWX7l6rhYLbfo/
	U3q/hvYzCP2Dncdp/fTXz0hXq6DDO2n0OQTvw25YDNnPcRU/Y+5G3Icbv0kMozt0
	EsxC0NZjjrhmG1HIg+ENH6FII83JU6TM5AHczXNNYsKizKtteO+WjJrLgq0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792730915; x=1792817315; bh=zykoJlDGgYV+QINqqjNpHhBfUL4V0+vsu7K
	JZRiZwvo=; b=hZ7ZM+TUHxA7G2X2/NONw0rk+NhRQPy18NDC4mqDb9dx1ydBMaq
	Zc8Za1qW0o8oQa+p5/hAKskQpx1Ci14xOFURGu1kskqITV9Osdd4fJcX3iY8onEV
	qOOi8pOUmOX24tc9u8QnqiUiqkUvj9SK1QqAN1v76Ioib/yqL1MccNoOqBND0DAS
	ySVrBjxGZIy7hhHVufH6lYWT4trlMl3xRPSyFV5pNstN9czazGw6jC+4zg2ln4fg
	NS9DCqBg30vDLYHgRgT4ot3Znr+ZEdN/e8yZuDE2UrDqBieb6rF5Tj/LNFFDnp1w
	G+6xFFNvQEK2Ai3575Ht2Nq8puravE3EeHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792730915; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F93QaAlfzRiRyj9hbUUPGM0+waOOu5nPNwGKMzkx99UyD6S
	as34F668Ct0WIrMbYYvwa4HUVTkYeWuauIY+MUj2Hut7RpAMHIXMvY7E73ksOX1J
	0h1nznufPbZgUO4TsP3SUF24VpR3vDDGduiJURar07Dv+WV0/kNhwsnT1fiUEWj/
	ndftrHH2FuLtReclIXiQYKLhTtTe16cO+MFqisPhe/T2Xy5XuSvoTtQeWySYjXHH
	cqLJMQJ893GA8UtP/83gLaonCCa1kBOpDt/tEFmCsHgrzpzQ0tNtCGTUEeQ5xTnp
	7Cn8QnQhcA65T5KD8nVUDh6V/r07kcsRAL4q/Zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7FnRR5EmaWiZ3kMGrsrSYnIiJgNY3VfoUm4cdn3DwV8=:QC3BJCGDuCy7SKiW8bV1Ktl/fuf3j6Su8szfzd1FY90=;
X-ME-Sender: <xms:I-faalSElx9ai6h6YcJ33PF7OnqtPy_VB6qdJTP3IE1I-4DVfQkjyg>
    <xme:I-faalyQBc2Bpy5wd0POqVftHVCi883ChTmBUPVnGzrlAgNYhzTXzkgmXvCa77BuA
    Zc_PMRIRCog4s67vC9IAd-1S9g0ZLm5QqeB_AIrcqCwD8Moe5j0e-g>
X-ME-Received: <xmr:I-faav0sy5Xsy_GGPRLGDsVPRYwyTTJ5awTfHVgNvoJyLSE02aWp0S3r2rSQKI8-bWN9AcS-h0Zco2LOERsx8zifa2Gvo6Qxw4iH>
X-ME-Proxy-Cause: dmFkZTGnKP6ONRByA57FErC8NqX+Cd0GPXxIjR5XdWg/aM8NSRu3menVRWM2JTDrwraZ8Q
    6zKcSRx8BbkJeSNBWrjQ0wobCZdPXAK7/czONyc5lKWjsMK1jY4xGgKMb8UPw6QFaetwiq
    mE+FQhj5b1TvgBjafoQpnLmkvLGeEjttmy5Dspy16p3kqc3LttdvqRDYbBql45PyrYldZ4
    Xc0Ek7gfTB/oan961aGdvPHjtHpj4TQhpPUFoQ1h2OqXzWDu4KCop4XpJXAZ2qZf6Q+M1g
    IrXoiB6wvYe0zu94Wu1/UhVrgWQ7/NjVtqLC5OpjulyoGb09+2PAoUvMm3rRJsXwZF4eCa
    c1qS+UkAHTiFtGUGMM0ZnFDv0XAEJ3MwR/z4Kqwydl4+QQ0tMyOYk6PCipWRPTvRTkdRSh
    p5vgkMdxiuuzvc+zkl/7Z2J/otlEDmMWiFjNtLqSq4ZdYF0ESmOqsORzoQp30KYl8Vxm4V
    aUMqR3YEtz+WbsLi4mGlQ4NPgWzbnyHth2YcZfHZG2gcBQBK88zWAhm3d/8K6zB/mAigU4
    RMdsgPNP5F5knTdpl3+d4hoWB7jyQV3gxoPxtx3/yE2Pl5/zqqZqPmac2JDwwNwCpwneQ6
    PVveQ++NBHLQBQtJGa2F8K2wpvW/b/suVTZuVY6Q+uNjS0ItU+zpg/I97Y4w
X-ME-Proxy: <xmx:I-faar6DSQq3DtuZCpBAnykpfVLnsWwxNGByexjg2lTPxPB7JwTfjA>
    <xmx:I-faaqUBE1ISZT9LF-qabvClSdWAwJ3IuQYcaHZzifuFp6Im4CPY0w>
    <xmx:I-faaiA_RO5bxKIL6O6Qlj-ZXSxGhyIbnmwbKa_RUDnXuyeig9YM9g>
    <xmx:I-faah60MD2bcg8zWAmAgO5W5zcLE2XABUixbO7hQ2oR26RMA8R8TQ>
    <xmx:I-faapE5OFRtZxEu__rghgZyYc8DlmlULA1A06JVZooLZCJ-LArNth4D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 00:48:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> (Phillip Wood's
	message of "Thu, 22 Oct 2026 11:01:44 +0100")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
Date: Thu, 22 Oct 2026 21:48:33 -0700
Message-ID: <xmqq4iedc99a.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> I agree we want to include those who contribute more widely, but I think 
> restricting the criteria to contributions on the mailing list where the 
> development of git takes place and the impact of any decision will be 
> felt the most is a reasonable place to draw the line. I'm not sure how 
> easy it is going to be to count reviews - does posting "LGTM" count or 
> do we want a more substantial contribution? Should verified bug reports 
> count? - that's also a useful contribution to the project.

We have patches focusing on documentation as well.  I do not think
commit count necessarily gives undue advantage to code contributors.

> I also think it would be sensible to restrict eligibility to the current 
> set of active contributors, who will have to live with the consequences 
> of the decision, by requiring eligible contributions to have been made 
> in the previous two years. I have historic contributions in a couple of 
> projects that I'm not active in anymore and I would not expect to be 
> able to influence an decisions those projects make now.

But do you care about these past projects enough to (1) notice that
they are having a policy discussion, (2) bother visiting them again
to learn their current voting procedures, and (3) actually cast a
vote to help improve them?  You may not have been active recently,
but if you care enough, and if your past knowledge of how the
project works still applies, wouldn't the project participants
appreciate your input?

I would recommend reducing the number and complexity of conditions.
Immediately after you say "last two years", I can hear someone else
arguing "too short -- why not three?" or "too long -- why not one?".
I previously mentioned "topic count", but commits are far easier to
count.  So instead of requiring two topics in released versions,
perhaps requiring five commits would be easier to implement and
explain.

