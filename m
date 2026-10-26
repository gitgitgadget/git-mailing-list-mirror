Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004009;
	b=wVxywVxV64l5ZNmhltf0EXz/8aVLAzrhgY3N1gxAjxp95JCpgcLXrJeYmgeGNQhV8x+C
	 bjqsPBMkomLWwTFBKieP9AQoCHXfDFvFImrjIhFIDCYXVjyTDgsli2sdwHw6LSb8Dz3fg
	 KOJc4OpZ2GCTeY086oJqUeJPlII28ttDUkNCUxGLcCNLtkeK/G+6gUUAKFMzMgkOXccRO
	 ZdL0jWysIGGQzy3kphD+MmFMmJYGAkbd5PtabJM3dB14mg5j7+bQgTu8Lt/IoPVILC7BN
	 baFll4iUMZLpGJ8SBzKofv48nuXCs+1ZEjzVKNAb/6tUF7zdjDAhl6Ic45IQQi1a28w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004009;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=yUMWhipPZ0Ss6HBgUTJlnQ0siH8Ujck3UM88DCNawo0=;
	b=rxMQA2LdpSNI4+SE7QHwneVmx60K9gR7AVwEBcM6el60JHqLqy9z57lYhb3aA+j+Hw6G
	 vlUPLwSinRMfd1BCgFDfrbKgLajbhqQ+osq2HARNR9AeasyceXTRvltCJHQM0FM+eMjPo
	 Z0dHwf4cy1fRwBb9Ukgm42gMf07k+PPQw+jBJF+7Xk35Hg45Pv7vGiWGIFfWHcoP+VsxX
	 NvKDR9EkVa03+O5sxImamCNy+xTjqsDbPTRQ4jm/Cp4zpiVSWeKygBKssPKWT3G2nbeTk
	 ZGC6Q91822AuuXbGojWv7zYL56mh031NMFRGXoivQ5H3F66ISVpig0+zSQZi4gujrwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=fCV1u6su;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jdwDJZFj;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47429606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47429606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=fCV1u6su;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jdwDJZFj
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 675AB7A01FA
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:40:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 26 Oct 2026 04:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793004005;
	 x=1793090405; bh=yUMWhipPZ0Ss6HBgUTJlnQ0siH8Ujck3UM88DCNawo0=; b=
	fCV1u6suCT8oJUNLYufK8d/pLk31xFMvGZT1UyEFEQBd+o1KVRdoAwJREt0Opebq
	neHrHv5QWZsFoxqalQ/dJlOXiA5Bm/Iz9w6qIuXi5diHAH4nR6CciaZ/vsIfZsX9
	KTQ+n2ZbwZ3W3XYFv+praOxxfvlEGYE3k9Vo7YBCSYXBSKwJ8vIh8JRUcnqlIWKP
	/EwfiYFaan77AaVLtfSNuC1zMho6tedIgdIQMZ8KzPs+aXHRyV2J5xn5D6lhhGEj
	H8Oq6uQHdJlsjJZE9w8Cnvm9qMGIJIBE0BXyVMxAXiKZD326f7e4qOwLyp6LNLbC
	xhCBr5y98Qe6qy5aiUspew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793004005; x=
	1793090405; bh=yUMWhipPZ0Ss6HBgUTJlnQ0siH8Ujck3UM88DCNawo0=; b=j
	dwDJZFjfSgu+7YFQQjPw8gFSSes3fOxgV7KRt5QqMEuSN1uGMo5Y59vfDKqswwDY
	8XG6pGEEhYWeHTgfhqlY3L3OPh6grewxmzoW8thNF5nrI4jGR6ZIol3ujtGO/7ds
	pa3Yr5vvHHMeYb2j7BBMtUHYPfbzXYLexkCzj6XtYLEsw0b9p+FdUt/xSxi4hTbg
	rBmuIQk0O6Xsf6Rw45H7+fqrdEqfb9zF3mSnsPAJTaa8MDE9giZukti4wrzkqzah
	sdBXmyuboVBhF+Eb88yG/jDoEZhyA6RZkpY2Rl4CZfr6WcqBxXWrAc3DkKLyWe0b
	l6xu83VSRkNkZ5kdAolZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793004005; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pb8NGC6BI/e9QFfplv+4i6L5z4k9C8EkqVDJ+XGwAHT7VOp
	nTMcHnL52q+dZvynYLMyKQUq9pkHGVsKiBykt6gjOHB/BzKh3FM3GM9G86lyzC2G
	54hbEZkliADv2FhgoEDbI3W9QhrdPfbZriEwk8A2N2cMf/sIomAZ2hy7vMXVwzRE
	ZeHeMaUGU5HafqcsHbCYBmz8EElkHtlN5IiKrd49lVTEC91geR6oMmbVOhDGbl7e
	LklA/vX5CFT6HFNLn1RxPi2ss3SFgsylQbKNYgRPX4XEoilHgOu9Jj2nUO5KlJd3
	BvJO5ah2Pjg6Pw4Vu+E0zAvPFpQLQgbiLf3518Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uXOpvALJ3VSJ/GbA2+xi0PO3HufVwL/PJvJjfHLtKxI=:yUMWhipPZ0Ss6HBgUTJlnQ0siH8Ujck3UM88DCNawo0=;
X-ME-Sender: <xms:5BHfakFAP0HxYEEzvkVXefsuuAPviUJ3jwX36L42gcMvzNP1HDd_lGs>
    <xme:5BHfaoKVIxEkOIIAf4JMVtOYSJfCbIQ8AWO2dIqcNauNeQfc1g_tKhyuGA9JgFN3l
    Bqj2dBZsmOw1sXvC0azyggz8_2jVtGhpjPEKBR4bd47v1rx9dm2jw>
X-ME-Proxy-Cause: dmFkZTFpgSRKzY5Dw6/gPW9IZjHUejooYMWSoghoBtKF3Z0A5covLzLQ6mW2DbvnXVqIDB
    9oqXeZ+RU2nm2GmyBVqGzxxGmB18k/lEZd4kx5Wl14zLHlHki43GhUf+QAoR0zY6IaX4pT
    D2+ds8KJHYFE46yda1ZHgHhuplDg4qMODxW6/4ohhMPjIMd0wms8J1x2Tqpywt4BxRZNRS
    jlwCCpxIyWHwscgJVEUayNbgcC+yEJ3u81Hzo3G9zkycyEO+ZtW+9Gq2orv5yFP4RugsXA
    BlAbDVaG/rLjJxivA0EeHtJYfxSHLMK6eimEuSdOj4ZiA7DhYswG0E333tPx/519aYvBCO
    YyXRJ7cbMBe2CG9pnWnpjnrmYF8euSBka2QSgYeJFNuAHuNoC5WKq45crGS4JWKgOEjEr9
    u5XA9nBA/f3deteFQ/Oys+MODK5ZJCvtI7rQBsFDewU6AMuajxS4fvhehFQDxVwcXAC3dh
    8k0wyCyG1yhKQ/Zyjdm3jRiayf0VU+Av/xnDXhrolIsXvXAFHPfMmFo7p2WYg9RBHP0dWr
    7SG1oR4HCy4+0TiXqeCJayanTj3S+P8cKXiGrtjxgfi04AVF6Y69HlzklenFysTWHQxIM9
    02a4TJxHy7dlLN1B7E89rhz+ww4WVAHfwpodnpJg66lQOYW59PVgawoC9viQ
X-ME-Proxy: <xmx:5RHfalvw_1GUO_xcTYyqEWTbGBLxZJby_KXUmbXtO-ixN4KMhF31lA>
    <xmx:5RHfasQm7zK2g4xwCG3lHz24iHljD4mzPq8aF58ekxzmawFH_49bPw>
    <xmx:5RHfajPPmO4lbjHqlz3QVfigFKM6-jEbW0Ot7erxnRIm4mM0BYBppg>
    <xmx:5RHfapZY0mzR80C0tcgTZ-dHaO99XeGNkLboFCDkI6mO7uGn9T9E_A>
    <xmx:5RHfaie2B7YUFSOaMaoHzX-O49cUExRp6MGg6bzJU8G8FhgXLmtAVw9u>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4809022C009C; Mon, 26 Oct 2026 04:40:04 -0400 (EDT)
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
X-ThreadId: A8mddxQTrPbZ
Date: Mon, 26 Oct 2026 09:39:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 GiGiGa <gitgitgadget@gmail.com>
Message-Id: <6568dd11-ea74-4e50-912f-a589356cf6b6@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnVs3+ebj25fkTmeRjDTJsJQh9ECNYMy1xU_yJLDdDeAaQ@mail.gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
 <aa5a98b80d2682cc0fa321c091c76e483fb6810f.1792348037.git.gitgitgadget@gmail.com>
 <8ffe4cb4-fd89-4086-945b-735316e6d501@app.fastmail.com>
 <CAHwyqnVs3+ebj25fkTmeRjDTJsJQh9ECNYMy1xU_yJLDdDeAaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] reflog: add --historical-branch to name the branch of each
 entry
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026, at 21:22, Harald Nordgren wrote:
> On Sun, Oct 25, 2026 at 9:18=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>> >
>> >[snip]
>
> Thanks! But maybe not worth reviewing this code now considering that
> we don't know if we will even do any of this now?

I think reviewing can be about the author and the other person
learning something.

In this case I remembered that part of the code from
skimming previously.
