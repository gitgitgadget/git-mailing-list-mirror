Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254018;
	b=gK/L7QpCOPSCt/3nIZFcjVyIDTWFBy1fr1FKiZ0b49VZjI6cR6nuKoqLkq+H8lT+QUpt
	 Svo64X4jf1n7J0hBbeLY3Jl5hEriRicUY4Ez4gngd5LfHet3tJGmkTeoctW42LNGaNwix
	 376Xjsf4lLoD/trxpRruInhOnSGaQHcCMRUZmKa8yX6YJCEK/ucGKEfqVvI5nFYaX6ZLB
	 g3g10KXCMm3Hc6qoR1XSnaWUHuMaGab2BT11AX46jbVT9+jkuM1cWRPHU+2HLOJqeSx5P
	 FElTFWEr2YgqHYcuofpmvqofOHQQI/urCLPcCPPJVv2UvgV6km4pP6/wUq/AJI7c35g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v4hEOZP29trP9cf+qOH8JoeOn34fP9uWOUqO9Nrcs0Q=;
	b=R4x40ZFI95voeJJdWq8guWo+ixp4OtNwLYSIFwDdYtpMrLyOqo6tmNmpijNkcXui2WcW
	 GK4H0An9JMhEWqxfvcXWuwuyEePvw9/RSt6tf/a7ayuqNF5ccMCvhCxzV1GHMs/jIUpfu
	 45G/bN5rMhRMPE8Y7USF2FHI2rJMBxnjpIP86dfIJml+2xcIYdyuCwcrnqw2ki5FxEghV
	 PzjTFnbMKjydyaSUDP6oVXXALxbMdkdSXJH1anZMqisHwZXmrnbzxtC9XLM9VMrmOUR1z
	 9hpN6NhwqrqQVjHt82bTwZKO5z2sWtWSv9aKCGoc827O+sZGPalBnCHvFa1rUuVOvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=E6G66F74;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TwBM6jRe;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3D606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE3D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=E6G66F74;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TwBM6jRe
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 04419EC00BE
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:53:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Nov 2026 14:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794254006; x=1794340406; bh=v4hEOZP29t
	rP9cf+qOH8JoeOn34fP9uWOUqO9Nrcs0Q=; b=E6G66F74pyHbla6HZhfljth+l/
	mQ485pKskRnroXi1la/pFL5yqC/ouxV0qMKCI5R4SBmH2M5HOt5lLv3ikKEOLzz6
	0KeRSdLbzUl0Fqn5SmXWambALUMGaSdUDPPQfzPHorCtjH/anBtGFdvYbsvP/9RO
	6WC5OpKEMerlCA2s0tnZSbhSTBs2CXm6qUiHC+uleNo/811TcqIo10FZuCoYDtvf
	1f+zSSGfBHu6Pw8JvQ/IbKfokZ19dfTM0nUidjtLl5Yo/8VyypBWw68vc0QCvsbV
	ss2aHLduxpJ/U/+MZmn185eSPw4AjWoAJPuFBnR8HE3+4CueFu9SdfNFhxWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794254006; x=1794340406; bh=v4hEOZP29trP9cf+qOH8JoeOn34fP9uWOUq
	O9Nrcs0Q=; b=TwBM6jRe9FLdtsISIb0JYJUr4L1iNFPm0HkC2ZN1ZT6CS48jGw4
	s9ppxil9BVB2ma5RczHpixQ0s2nS65Mwr39ufd6J60nIAopImgJ3k8nlnEbzeYzq
	M3OZDCoqwFLY3VTjxcMya08w7yhHOOiUXIbASc/LtzFDmIIkGRZnCYeG6i66HkJP
	+c4GBAK5An2kMWdYlbPKGgzfiiyFjTG6r329hCcFJ9oxrv6ZVk2Pt7PgE68TtExG
	6uSi14YE3UfgGyl+xgFcd+6Rd0RSZBvYmrvGzfSEnItintFVg2aXJVhPpMF/Jbx7
	MxQl2sxfxGIYBF+AsmFbHMbPMonTeZ105qQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794254006; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ct9vjBFbYBfxGYHn99kUFhL+lFVjELKsx4xM/WgLtb5tbEa
	f1CXnmbMcw9ZG2+xcZsmBGhexm4ttPM1IhQjMo8kT1ZpcRhoeqyl10m6KV/FUH0w
	kIsfbDfVIC2NKJyoULsQN8oQL91tg3xIu1xNnb2fW9Ny+0aTXgaWE/lZnO4Csig2
	NsxKYLZ+72rg8v2Qly4fVQoVhoW8ympoEW0+qEBAdkVLuo6y/fwKhrxUN5eW3DXo
	yaGKlCR2IlZytHDXXLrkiIp0piwc0hKz2qnzvOVAKQAhG4KwO40RnU4uEtbGA7Nc
	iFd1N/FUGj1V7rpu7lVAiPO0mmaFCvoq8Vcon0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ArA9VowV/sRFIdABfECEFZyeUGq08SBan3wkrTC93Fo=:iivQyxZ+XxEV1qcEaLvo0lQS/uGdZxqoFtR6/jbJUvU=;
X-ME-Sender: <xms:tiTyalb0iEGkyu6N5njvJFVhVDDjw7K2NDxxLbr_8700wEdCgtUReQ>
    <xme:tiTyalu8Cqr8m1szkUKHnMlu89spmgHDcI8o0JZMR6fYVPEtzbQx8wIzqJnkDjIH0
    TMqKdrNQGMnQF669GmVlSgkXumfiG379UDmX5TsVhnAWYBs1a3dHiwr>
X-ME-Received: <xmr:tiTyavPDJQDxUINsUylkpFXhAHkkhgNiD2YfVdx0s8flCOXB08AxTQGbqeeeoSkKDthNA6M44e7w7v33VItuZPNRTwWQlArY3zcc>
X-ME-Proxy-Cause: dmFkZTFbYG6yccWGpjqRIc7SkBmv1ay9LmoUiPtmL8pZzfOEUc19cQBZZoLtiTJ9Jdy/9V
    hXfIC1YVfozdbBWyh6Al0UWEMZ5nYP/Xss5HyI+Uj4MROoaOLDsr0pj8Q2L13GWE/8gvAH
    WToaqE7B39BHPPyrDRD6Fhj3s5gbuJlz1ACfKaJMaE9HoMuZTMpGSyLCxL1EH72flTCvkB
    a/IgB+0M8EZwYloqzjbAUIXbnzD7uVknKl5fpQuSXhtUhhNGkXTNKelHmMk1+w3WYsdLyP
    2HGrQSXdVOHnQ0Xni4JNaLXfKjCju7gPyX/ybtneHWosAVtLqYvK4mCl0PSpPOqS6vVtbe
    i+pBmt/wnQwzQ57/KnowJWhtrzigF3H43qbOA58YTY1m2DJrAa2ptTdCyJ9vm5m1HAevU6
    s5Et09fA/57k3EDijUfCb/MYsmPiqj0eRJMlHGf4PKzZxCD0CfH5jBHrKBkPU33ktqJuuY
    XJ9zAQpUwywtPo956JyCw8z4S07r5eNrmMJbgkq++9bJBtpuyYW9WVsAnlINAnSySBHW+O
    PapyCq2lyNtg5jIfq5FCsK19q7bYF7GW6oolJE6XGKhBsFE96nGzoPxC4YbtwOgyj/g4Ym
    yfDjdgN4Nh91TPNS9Q1UGiVg3s929oCf8kzMO2erRy8PwhA5viiGmO/66o0g
X-ME-Proxy: <xmx:tiTyak7fVOvuHea4pZFbDwaCQtjOuJXpjjAoicZN1DGCpa9RLV4TxQ>
    <xmx:tiTyatSeswFNBHX1n_Ccg_k0Wc82Cz5nl81e7mJWPesXCwTvAYG09A>
    <xmx:tiTyapAca1wfE-FZeg-knd3c4R0DXzfRpNBtsz5IeUBcaj66oQZeeg>
    <xmx:tiTyalFlSLXySNXSxMyGlTvA6LsjhVxSDLKTRrJXgRE_I7FJ58v8DQ>
    <xmx:tiTyakjYkX1ZqpOgxuLM69VSLTFZPfJ4xxt4U0JQzllbKpH9fbi2peAv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:53:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  jltobler@gmail.com,
  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
In-Reply-To: <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
	(K. Jayatheerth's message of "Mon, 9 Nov 2026 22:22:33 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
	<9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
	<CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
Date: Mon, 09 Nov 2026 11:53:25 -0800
Message-ID: <xmqq5wy5zsqy.fsf@gitster.g>
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

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

>> >    - `path.superproject-root.absolute` / `path.superproject-root.relative`:
>> >      The root of the superproject when inside a submodule.
>>
>> Personally, I'd prefer "path.superproject-working-tree.*" here, though I
>> see Justin thought that was a bit of a mouthful. As this command is for
>> use in scripts I'd rather have a descriptive name.
>
> I don't have an opinion on the name itself, but, that said:
> I think superproject-working-tree is a more suiting name.

Syntactically you could put anything at the second level of
three-level configuration variable names, but I thought we avoid '-'
in configuration variable names in general.

We can see that we made many mistakes in the 'maintenance.'
hierarchy ...

$ git grep -h -E '^`?[^ ]*::$' Documentation/config/ | grep -e -

... but nowhere else.
