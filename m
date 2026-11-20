Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185546;
	b=k1c4YoAZTm1OpTpjmg9Yv9VSK7Dr3svoinNEdOjRmaSQJlTs6y5wK/lYUC1pWtfpFYxg
	 XC2bFtekcdVwiIfc7vbcqhXvYDsiR0uOlu5FTF4El+pPePdPyeNR7SuaRCWDJxFUgQCyA
	 ++RKf+LVCclOBmT0Slxe0agteJlhdlshj/my5P49YWuB+kcg+DgTbHYaghLLnYAbdUVw2
	 x0rI6c8Fl94M1inFMmqu9NsyAlS82QpLz4FllVQS+nTxFsyKRQVMN0OKNt9TCpEpsCZ3a
	 dk1GXTzsa4wr3J0D9Hv6w3/dT0K2aP9BLt1o7Mag6+H1ZxnZ5VVZpWicI+jYudOaJLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185546;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Q1BSe0LW5gYxcRFKD30N3/YW/WfA3QybZFiudWx8fVI=;
	b=Wo4IXGwpESZ5PyaIE6x6x6xS/IPp2udd2UklA0NZvQZpTmb2kch5nKIEy7KdClOEc0dL
	 /Nu75J61J+havAVysRf1h3AUfSrOBQi91sYc8e7mt346IcNMyeiM9+dmc6nT+2UuN9omj
	 ebzVv/5muDP0d6J+CO2o6ieDJihxYGahBdxdeZy8Vj0bdu9Fhym1rSxdUamZFOx1Vlj/f
	 f6bP4qMQGF4Gb0DQ2SN9s6rgbjDkfse/PGQ31h96Nc/VqmjJmq9AaJAEP6X6lrcnwOcSp
	 3CKFtZvBm+XpSzutFaEjKKWnp2flQCxDQqWYVmMBnSphovURbsWooCPXk1dTKJ2RSPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=OnVPtW3W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mIQOcSH0;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACA606A333
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53ACA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=OnVPtW3W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mIQOcSH0
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 29065EC09B1
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:39:05 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 20 Nov 2026 09:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795185543;
	 x=1795271943; bh=Q1BSe0LW5gYxcRFKD30N3/YW/WfA3QybZFiudWx8fVI=; b=
	OnVPtW3WEbEZqe/gYK61wljlLlDxnR+XZDeSamzmBvwH8rysM3hlQeQqnmKcXgLs
	nOvuFAbPMYRQ7QUVYrcxozwHhQrE97rIrDRynd6HsoDKq84idyKPse986tAl8RCf
	flRLZHxk/2pxZDreJydJG+wnwIs0h94TkoeeKH3HHO/Yb3FxKiGjvyOZCSqGGkY2
	zvM48rUleEC9K0LGuskAkCboUkeDB1edjeGnnb7KZ1sEW42feVFVueHYe+K5W8tP
	fwgTVHyRbkrU6Ew7M9UY6dXXyOVouBt5JTDGhZKXynVLZfzE3BgjPXIvDdETZyOD
	12M+Y2k3P0vaNmI0KCz5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795185543; x=
	1795271943; bh=Q1BSe0LW5gYxcRFKD30N3/YW/WfA3QybZFiudWx8fVI=; b=m
	IQOcSH0JGdMeKz3Amx67FYFzkcEVv7xB5SAkuQKLg9CGd+jgEBI99rhbQs57kMwv
	pj57fg08rgHqzX7LEuhulUB67U+Uj7hKXZqpIMkMHxe5v2g2y53s/6PLFYwx9r2t
	rIsBgySEIrA3m/4Kd1P/JVk0QyGSMWzzyCKSszQ8zd80E4sik1XN0UYWpfKjVUMG
	BxY6ENCpPPFPX2Lmmi64HaBISn9WWCJJhJGpri3gGoH1AWZcGXGCBgNMl4flZ9ek
	aXBqxp/vLpKHc0lbHFcjl7K9eBJ530e708RTl2t+pSaT2oWtNNYDncRd8EEECRw4
	zVcQ4BycbW5lCBYOgSblQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795185543; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FnoNmdI95ubin5zGENHfseEksq5dhVSoa0Rf0ZUeYEsUeGU
	1MEKii0nF1lcVBTCbTykp0X4kzfTvzAPUe0sCEaf65rAOUPNcoaoUz1vflmWBT6H
	GfPDtFJ2ZecxmIse36M62DHcwnw+0a3P58OseztCjLxAahQ5T6Xnm1n/Q3/XK6kk
	YXd8MFYQt9TfQr34+vh3C/kO0LwcvzcjhDLubaxVDZLr7cWtgUUIZNj4iPtLNY0j
	V31KpJfiQzRLHn0kIaez7wbhJ4d6bnMXY+kyb+EH6xhQNXis2Nk0MZyIa8nRVaIg
	dLIgicSzI/fbgKFdl7/Ynf9m97lx2QfDlxwRNpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vIV3tLgaT5p7ZWdS8S5YCTf2NOfx+cXD/tFy0QQPeMI=:C29C+smbug2nRLQj96Uk78gtKmeh4nBsfzmdV3RN+0c=;
X-ME-Sender: <xms:hVsAa7pQr39N2ZfG3nCyNLAjeZUqhW5V1iqJN-JO1KyY5Gy0Q1XLx4U>
    <xme:hVsAawdPM3M6HAXAYc3t_74-XgbQ0GLuWjakoN1Vm-mHECM2j7TIVZxu-XRkCr2X9
    pGAmpsDwuJO3zjFSFQ2MDBGQrITKkokH9uSrUpr-IH17Y1WW_0xxw>
X-ME-Proxy-Cause: dmFkZTF7Pb47nvNyK13WC5ejKCYX36JlsmDNGkSXBxGeg6qY/yyp47+FAw0rotxreqhRFF
    jzzFbzke46n667SwDr92aJAG+v+fu6jDTgOIo92jIz3SVcr8TnNHkz7Iog/cusz6gLSWAz
    Uc0MdGhRR2w6CqEnrEXBlpC3uDW1LQJXX1Bjk/GvAP1/nZAJxnohewg7lIO2g9yzIPhUsI
    h+VyGAu+U35QQX2jgFyp/Z99DBc4oKM7gjrqSGbcpbePafOz98gCHwBOLrBWb/zJftIak5
    Jw7tFqGxTvkHutIWuhy8FxVkvJzk2cGCTPHIS/+n+LK12wSMpzTk997Wo73jA56RKM7LtE
    BGw8DKSiV8I1cEizvicuyLjslLFGb2q4f2lRoRWvSYs5MqrjlslFhM8RlSJLNuOKfHIaiX
    vHV9I0C2NQdUlAuGIprXN7sDqae7inlNXyyP/LlOLcxbpWmLzBRTLiM5j2KCe/1IdIf/TR
    h5I9RexnpCBDzVe9f9qXad7qoAP/8v/SalZbR7px7YA0VLTfQ4VMM8B48uF9C7gVV6Lavb
    Jp+rIX6YHHHZoHjEwAt13xXW1pWxtImErsm22QnloSf0+y4yN2BkhO///2wmAMvXRIXT6S
    bpMSQp6sIjcoGp32iz6bRgUg4KdI68ajGZIlZc6DvCqJ3fb1yyhhqm6Vsi4Q
X-ME-Proxy: <xmx:hlsAa8SDLTLw6cjqt9yy4kpGfh6tn9zFSylpK9YX_Ahrmb8xWOvgPA>
    <xmx:hlsAa3lAk4tYerQMXZjzO7-7xHGTcEE1DnBg_ggdIapLDE72HiISiQ>
    <xmx:hlsAa0RfbMRjitoFviq_G4pLG0TwCB7cyjERbs9PT2Mt0Lx5OFJP4Q>
    <xmx:hlsAa9P1ARkBA10BT8mKd1s5Q1-iciseH6LHg_9nzws-kR2mNDpbIw>
    <xmx:h1sAawVN23Kh4JZYcOcWy1M4HyCNYj9gQzM9gceQ6QXJG04zBdFAZsgw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5733D22C00A2; Fri, 20 Nov 2026 09:39:01 -0500 (EST)
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
X-ThreadId: AB9N__B7nd93
Date: Fri, 20 Nov 2026 15:38:40 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <babe9844-2dc7-4fa4-8678-beb4de802858@app.fastmail.com>
In-Reply-To: <xmqq5wytitcj.fsf@gitster.g>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
 <xmqq5wyvq9p8.fsf@gitster.g>
 <ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
 <xmqqy0bqlqez.fsf@gitster.g>
 <a219a76c-faf5-4c50-9560-bf48f65167e4@app.fastmail.com>
 <xmqq5wytitcj.fsf@gitster.g>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026, at 18:38, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>[snip]
>>
>> As an alternative you could keep just the previous breaking change
>> discussion like mentioned in <ar0cjf3rdrp6NAba@pks.im>. Like, when
>> you=E2=80=99re approaching Git 5.0 there will just be Git 5.0 and Git=
 4.0
>> discussions left in the doc.
>
> OK.  I was merely expressing my worry that it might be awkward post
> the transition, but if the manpages (where? in section 7 perhaps) is
> the easiest to arrange and will not be awkward to have after the
> transition, then let's do that.

Back to my question of =E2=80=9CIs there any interest in continuing this
series?=E2=80=9D This topic never got included in `seen`/What=E2=80=99s =
Cooking and
there isn=E2=80=99t any actionable feedback on my latest round. What=E2=80=
=99s next?
