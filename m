Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778987;
	b=OR02xXqHB0fB713y0au4wcuJVmYuPBIm1qxolIqRvXuI4lOBd3Y4vV2/558nBIptkUct
	 tRomwUx+5WKTjxDQOcNcExio5EVgbdzl2MMwCOSOdr/KvCpw2hRzKqd7DgjoOcIZqHgBT
	 d1nncEZfYsrjhr7J1Z/vwWatwSBEXJ95t24+ty7blfo1+rySnDI4mkUTIAaEdNawkvAhJ
	 yA+ikAUJjC9BGTZ5ARwzCmdmsO+JWrRaZcnrYcRRz5wYZMk+Sbj9P3BmGfA4KYnCOsav9
	 QczqUHaTrbqyGKtLe936uMGEbKuAi1q6YTNDIjq/vmhbFi8cFqBW89rMUrkXlqMImoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778987;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=g4iAnJLmRSyhBNNYYsxMXtbnzCKHkt6BU47IeSMYJsM=;
	b=Ve0E4nVO4cJb4qvvgQeGDG42ZQvJ69r1lcolLTdYfkC8cPvYAiiVpN762GdAT6IiCSZn
	 ixPIl5u5Jlvi4NuNk60cW2eF0vnrtTumbBouaUNBy7fNmAC4lIa+rT2wZ/yGOoZifjOIG
	 T/tJcipaQxbgJa05k0jR321z4tlRwi/E1UfSa5Z3Tmi4iOHsDVdAeySl8Qf6N2d1EaYMH
	 QT+65AVEgUFhEGIF/qeMykaDzOJJpDcSxYXn3xedAaLIsiyqviIb3jqH9PWShCs/Pv3Ay
	 zjn/A4EOsiUIunJwidArHFgf0QkdMKce7wjfazNoZpOTg4t5m2gtYKyE4mGj/XXxECA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=sfrnRh0H;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wjMNnOVo;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A65606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=sfrnRh0H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wjMNnOVo
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ED697A00C0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:09:46 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 23 Oct 2026 14:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792778982;
	 x=1792865382; bh=g4iAnJLmRSyhBNNYYsxMXtbnzCKHkt6BU47IeSMYJsM=; b=
	sfrnRh0HkOkRXdV+PB8lMvqnmPZD3i2DKRpUujQ3/rfp97YhN3m8OnFZTUVyJlRl
	cTfOq4sl0oC32i9TCdCvT4RQLjmNlIRCFItseu+3dUZ96d/fmsredbvDc37o7tde
	7hHVBK/pvKaWZIkcrtaHN76A9LXJxaAgXsPCYe7QO8wu2yogsHjcHIo8fkWZxxEI
	Va2qAnUWPZa/Ox8Hd/DJhH9I2lWxhr1QWAlwO5YpXYehS9eqqPU09zJddUi88wBs
	au7o3r2QNXjBlAeLKL1PgXVTfiAVOi98P22NCZ5GzXKOS6gHIYJUiDUeMNfb2v2U
	FgnC+AvxjRVgdbzsRUI5hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792778982; x=
	1792865382; bh=g4iAnJLmRSyhBNNYYsxMXtbnzCKHkt6BU47IeSMYJsM=; b=w
	jMNnOVohz7tiD4WR5f5UkquZdWd98Ggl/RhDw0tNVj5J+Yx3WZr0LvSuhD+04r0V
	4P/waat/hr9dRu4kIpjMiT34gvmPaV17WdB4IMDrRpBIPjVMEtjyYO0e1x7AP8hV
	tk8EOdl2e4tTtQ79/lKYlVzKGRWTdwBT7sMx9fsOevm5f8VbBG2STcPHKY/ABE+i
	ArvJe3mlIM37R5erUdbxaiLNYYa/mef+JWtg6Ah7gjp/hoKUTXe5N2SGMPSBikiS
	AC0qHMC3gJqE2eC8xpObZ00WaVnAV5+qqYkhymNGQb475NtMGf6WBL30y1sqfRrK
	/b6baSef4Uc3+zAPkrnyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792778982; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:S3S4BrYWpBAvI96k6MZEbbT6fllYiNdS2WWihlLXEMM1nUB
	ASH2VBdXIKTra9ttiQ4JQHCTl2aZQjtRzE74uKDpL7UNmqNjO11FrWOlSntHhrwV
	koonQEp2TdoZxwiaDMj17ifbIwaJoy5GKuGFg7MQsWbZ5z33Ee60gJfaxf1liILS
	bjUlXQXUANYPlKx951bhoh5L8LyLsfEs+xWUP6ni6SOst0XI3YtxyvSxZekOQzQc
	N/hclIc3nHJe5GFJuO3oymIooljF4ji1txCMMPAcT9ME/lAxlc7pyKxyDDx1Q175
	G+pV1X75qHJt9o7No3IIuKLnpbXnYvqsvAg2yFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:U1tiMjBNAreIpTCHMk332kDLJUOe775e1vZm2mngXcI=:g4iAnJLmRSyhBNNYYsxMXtbnzCKHkt6BU47IeSMYJsM=;
X-ME-Sender: <xms:5KLbasBmv53RYtiO6SWjOv4Qt0vriWJtsvAV1CPTz-ZCBrVw857BctE>
    <xme:5KLbapUTXjV0qvAM_B-6P0VU4ryjxzUojSvxIsAuO_V6611qRCLJWhdbs6piRLm4Q
    ZjQZIliLlDvLfH_eQ3277npM2YmQ12CrizxMz4EH-9MCUANvrJ7b5A>
X-ME-Proxy-Cause: dmFkZTFTDc/WpekJqVRqypsIiZEyZEwg86sI2oNwgpIac7oOrcll8fo21DK2B2bDScvh6E
    yYAo9e17fHohEWm58P4JuIO/vREWExNUtAeQw9bdC+l+ppuu1O16G98tpiwhjQeqGKqbkm
    ZcoOviI605B4o2LC5kKB0CQqxaHntg79QCFgJo8Gwd4906/Sq+IZOeJiYAsRqs5KA460oX
    kYow/2G6UN7xcFERGXUmPzYoWu7rHEXrppQwMk8agmYOv/nHkDZQwVOQ9wO9dF/dfk5DJ4
    NlndFrpSzitf3/C3fF8Kh619E44TSnMlxzfBBTIEjPD4jwi/CXJ+cKIGiJwYZiA1bvySYi
    lI3s2rfbYQwYIHrfKMH9tm1Hjlb9k34mZGltcyglOzbJn2hpixU6BaLqN47rA9jK288m6C
    eYYnNdW9ekhpvHbQwHXXdbzqzmV+Ak430uD+htK6KkNqluUlmO8KGXG48aAVgYS5NxUAL8
    1kwWbqBkeATrOjzdrXbOoE/F6mkP5dStu5BlZJ279KUGdPVLYGB9i0NxTjWiPxgL+23EIV
    un5/BDjSGDroQ4S3qV9gYU+rajr8tp1mvr9iSw0UKuL1gLQQaP5qTonARZnAKsuBt9OWiI
    8XCt7uaEkjYUs6/MWIabgrMh5M8rTajYHx01WgWlxS2U7uVI45PZARxpuUfg
X-ME-Proxy: <xmx:5aLbajPUDzXZn3DmImYRD4kDude_PxRipY7Onpp5jTFNgo0qvLykEQ>
    <xmx:5aLbam6FY62XtVVHdNz6tU7AwhYesJwoxBW6lDJuNoCdMSjNnBR2hg>
    <xmx:5aLbat3r4fiRZEAGGfBGul6sVH5i9NdLDa5n911s3XJN21EGUW-hsw>
    <xmx:5aLbanw8R_8RbX1YzBn0cYtJ-ti_K0Ppeqa7mrLBSur_L2NhY3gL2g>
    <xmx:5qLbaiyF8j5h8l0BluvMwy5nuAuhsM1L7EVQIbWWkMiZJT-eC5GSYTGF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 005C822C009D; Fri, 23 Oct 2026 14:09:39 -0400 (EDT)
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
Date: Fri, 23 Oct 2026 20:09:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Emily Shaffer" <nasamuffin@google.com>, git@vger.kernel.org,
 "Justin Tobler" <jltobler@gmail.com>
Message-Id: <38958af2-98aa-4145-813f-da6d601ce9fb@app.fastmail.com>
In-Reply-To: <xmqq8q3o9ycy.fsf@gitster.g>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
 <f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
 <037a97bb-af3e-4e20-9845-c2d92ed3a2c4@app.fastmail.com>
 <xmqq8q3o9ycy.fsf@gitster.g>
Subject: Re: [PATCH] Documentation: propose community voting process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, at 18:26, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> Some people care whether software projects that they use but don=E2=80=
=99t
>> contribute to use GenAI.
>
> Sorry, but I cannot quite parse this to guess what you want to say.

There are people who actively dislike software projects over the fact
that they use GenAI.
