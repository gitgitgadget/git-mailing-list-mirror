Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440373;
	b=nCDSANi50ZrXJngYsLSydJIOq7+yAgtTzDi8yXM9LQY+tHZeRoC+vbqnx+J+9Un7+77F
	 Lr+75vI+5OIsCsKp+AvzEaLI2dZSBQJxRHzKhRLU0qOX2EwF8PQ60q55F3GEkwVKf1jxk
	 6ADVdd2gY3T85O2/tX/2bGDeRhyonDIGzEQYo7pSGlZLKrsC+aW9/R4WYFtj7wSvVEAgL
	 r2OZY5j+k03vwy0TgYD0gN1X8zcc6ydCFMMAHKWzRoNmJh5QVvtUTwdW01qk+g54ExEeL
	 ubk/aUrjNWoQJ4kOP7+F+3aKoKUGIPkenlg6bLEDyBvkvysITIIQVCaiUdKG2FkmJ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440373;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DhJg1ABD5/k0r3wjPCvhAJwe6rwEYti79g7wJVhEBAc=;
	b=zIVOwNZpxnDS97fRt/zdLx4UAMa59dOY5PzHqO6iXZlVLUjpe+pTPdaG6N64uhxL1J8o
	 aOuZ2Kx51cMrTIZw9/hNM5+H8REY3Wq6Rml3JhjIsxMnKwmIFjUCa4ooTBG5PZQdn/KTA
	 ZNmcdH+GZcbVRrMmZyrNjzljllOQhUPLa/m6Urq8YxpiyNXUUVKIbRUBR7g3Q8GYRh+tL
	 fN+vGerLkFiO8ksmYMn9G7GHKnU2JT6JpJVO2RsOgs8qLHPIyIlA8Vit2/uz9W3KV7uVw
	 hbpJ7Yz7ZADjiTD2jXsCT6U0VP+laODVfBgjfjFVF3zr5TAHpJn+tfSOi9uW7/GBZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=J1IQ4WKf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wTApTOL8;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E204606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E204606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=J1IQ4WKf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wTApTOL8
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 513A714000E6
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:06:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 16:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792440372; x=1792526772; bh=DhJg1ABD5/
	k0r3wjPCvhAJwe6rwEYti79g7wJVhEBAc=; b=J1IQ4WKfuqEITwcBNsMjbzek/w
	2LqyyzDMOeqDO/GqmaReZXxCa1Wiu5KBccPpa/IaBygO55IQXFFhmNx8Tovxf1NV
	8VDT5osMIq7BkgVX9O5eenQ6aWns0OrHBIhfoj20j8jVqeEtl+MUx5ZixfxIFRmV
	j0sA08xBMV+kTmJrB+jMorezWn/wnaEurdwxHu1iiJZ2B+gxJ6j2KeJCdRjPa3j8
	/fTj4L+31NbpSaDOwf4Es6JDQOXVlMJTpIGT7Pw4M14QTmSb5amTqM31XhbOL4fP
	SP1ux3YzQoOhZ+w529Wo4G7NE8F28giQv0DBheqAnAYiDXIP3NiH34Tq02aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792440372; x=1792526772; bh=DhJg1ABD5/k0r3wjPCvhAJwe6rwEYti79g7
	wJVhEBAc=; b=wTApTOL8GvCagNOIT81IC5M9qBAfjKHsLS9fsyU6ner0ppMKhua
	0aV99iJg6LiMyTx8td+YkjF6k46hXgEG/2VdCuzIqAkjnb7I6cNvewyn2dPhR5GS
	PIs/MH02vGaWBwzoDr1vK6Hq+H9Tdzh2A2OP/R1ZihFvYYvbeNrfUdaR8JlHiJ3/
	8A3F9QZsDd9kvx6bwqd2+DwQKasc2e4B3LZhzPRB2CjCtTuFmbSOc9OhGwTMbv7P
	3GalG7Z7p2G/4GD+D1xc/wsTlrSoH7iQ4hK4O/LkH/1NJDgjtwJ64FZu3Xr1t9iD
	Dlqcl4JgGOS4h3/ItFxSltjZscr8oBuEAvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792440372; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pcyiqp17qHJHYr+D1fr9uLdRYB0E/M/xvZiOFVdVb9HOPsC
	jkIBqKnp7kieuH5wwvhMseGwOElv8DPuJTvUWOAu4Nw/t7LL7ZpstzBqUUpt8Z9A
	33A2X4KwX2pruxsku7Y/D74iE0orkS4G5YXBfq2eRudLVmNOIJc5CZWfOiKnZcvy
	/ieDetijCcBuIpaF9gTqqqv5mtNGiTEj193ZEtYNsZjXZyoAnFOUjXiinSqvZmkp
	AmlZ6YyLOT1REQ4I9nIbu+lWoddDLDBr1nWlAS8MvGWWIJ5ZFoci3NNTPd0IAp6j
	6T4WPKAQmN2zxIQvyO4YhLzpFFGTd52JsyZ5TEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qyD6b0nmNeXvGkP7deDzNBd0yub24UPW1tUZubINlp4=:QyoGZ8n7LyefqOxQgHmVtDyUGz9plr1NVp71XzqmBlY=;
X-ME-Sender: <xms:NHjWahjIuaZnmhPzo0oWFqkFgRdEecDpb4QgpIGqODPgjFciL17heg>
    <xme:NHjWauccw3X7CjSSZgVVRfw3up1W4Qv_tP0rxQ8GOM2yNz-V8EgloOd_2JUCO1ZNI
    Iv9IK1TjpyeEoF-Hhk-TvQ8VQ0ybhHnaz9m3QnjEIMMliHI_0g1zDI>
X-ME-Received: <xmr:NHjWahhI7Eok4xpuM1-n6j_r6Un3-Di4wPWxnm3zeWVlsSX8WMwzDXS9rda7aiqmmhotDHbpExz0uXsr93xBv938dk0vt7lc5q-R>
X-ME-Proxy-Cause: dmFkZTFNW4WTk8juohknP+XtV0JcgC4eDsAg+svKEghPWOEaGy56vUpWUxCGAIvUwucgds
    hxdgLvQANX91TihUVSjUO4W9/w7xlVT+c5kOZpwR1ehb/A0CwItA6SPhX2qAVWCExlGOrI
    guEoXTz7zYW3pbzOHl389CfVe8TWM7tPoKWyLc2MS4ZPO3qgEjTcbdZ7CuDtW2PdBY4eTw
    CKY6FcUIitIPJiPIqJLxrchZbsp2M39yJooIbi3+9r3jYauk8TnG3XJw5IdUc7cGjCX0fn
    sZkkSL/PtFrbeCJ+/t/SIoO8YDmafAcbNnbTeRZypYvutWU94+oxMnIzbDvEVSwBS39tN7
    TSqbldE0YllBpL4x8PkxEv2G79MECCxbQY1Zjlx+rPS3NdgTTVEgoEkZ1daZYa4GaaHnrK
    XKe2CfBrRj5ylmlt/8UnxsiKeIS4cIrozrZ3XCWW/ciVZ4CrpIZkUokC3U0D7XpXz9aXnQ
    JwCqqG3TrcWV/HfjZW0d4k6SV8A8xU26SxMAnzFcNTB0jVhyQWpB6+pj3XcfywVB+SJwbM
    s308EwjqMLBzPLgz4ly6G4UFbErcPW65xanucQ/8CgKI+UQJkua4Eu5UQSmrJRm8cbzQ61
    QSmfBAy/Eqo6IcqM1oZYo5hWTMV1v1ChgS6WNo829RDofcS4P3TjCFKrCM7Q
X-ME-Proxy: <xmx:NHjWamwR9tu1wDqmtft3YCfte4lLrvznYgDDWNDykN9bP6Ow1MLn_Q>
    <xmx:NHjWatORLAII2A5GLvZXawilqHUEUmwq0pMlY3mKt531Fc1kgX-n0w>
    <xmx:NHjWanUfim5syORxSPd02e4U6mmvIil3eLE8Z646LNdvNkh_tNZvGQ>
    <xmx:NHjWah2HvJ1NMILZsJWmQypfKiNJiws6tjYaXG4DB4RiU5Xc4lNaag>
    <xmx:NHjWaloxztFun6emoT1ubvkYT5eL_xOjPfRvppmhaDs6HYciU5AS2O37>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 16:06:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Josh
 Steadmon <steadmon@google.com>
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
In-Reply-To: <BCD8B077-5A67-4A56-9DEB-9B482D580226@gmail.com> (Ben Knoble's
	message of "Mon, 19 Oct 2026 10:25:15 -0400")
References: <CAHwyqnVwnMi+DzQDvS6mgUzg-CWACUviVkYv-UiYJT+Yq83QLg@mail.gmail.com>
	<BCD8B077-5A67-4A56-9DEB-9B482D580226@gmail.com>
Date: Mon, 19 Oct 2026 13:06:10 -0700
Message-ID: <xmqqqzhl4frh.fsf@gitster.g>
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

Ben Knoble <ben.knoble@gmail.com> writes:

> Overkill, possibly, but easier to expand in a compatible way over time
> (other than piling new modifier --options on top, which makes the CLI confusing IMO).

Yes, exactly.  A myopic initial design can easily paint us into
a UI corner from which we cannot easily escape without awkward
options.  That is why I care.

Thanks.
