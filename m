Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310169;
	b=YOGCjqCt3UTDpBlj0KOCKASNZ2Tlt7xClk6taH4AtTKQQMyeVHHeXstDgJ2+SxSCPssM
	 ZRrwCCpzY+YobCeIy9a7wtaDnkyhkjeRwj2vsV+MOF0txs94Fe6QFp308SXXh2EYoH2Lq
	 bzdLPqzbzKnWzWK2zK60ISCfTJlocMqs+PcO5eXmHBxII3eMnu713BfTmSjthR7qPwU7x
	 ZlTEZ+tOpGpykRJ1l5P6rpCok16zPkSlrGvM4oMD7220Pk41DVIudd70fi4qDHV6NPe2s
	 neWN57n3q3w2nGFfHe0GSfDdH1I3d3841Kt2KWiCLhDedOpaUqno1J63HqcxyBGlCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310169;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=V1yVUoj0bZPZum99rDp/WGdrou6I8YXOL6+Swcww+Xo=;
	b=smvF3XSOC5n9Myy383ogC1z6quZZXpGPycY/8DcACVX4QMyAj0bdybiuvRBnYQ67tgF8
	 utupQSMA+cQXOHC7pvF/OxbieFoTpGnE1nTuARRGrDHGmglmbW3ZHe0m2PQoaar+mJSN+
	 wqB3RxNjr6czSUmrY1z700yRwRl8KL6tionBzPwc2fuP7KTM364ZiEE/UIroA1vNKY0Lv
	 qr/T1jndNrjnYM+EOKJvBx85QCu9mp0vLsrYWQMpagXP54xthRSV4v6oQqCbjXqISltZl
	 ws5z/pf8R5qKClsxckRIeZoRnM9q8/vFS3jq8H/2DynEJoqQLpZ6gqCScza+1czhywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MykMcCqP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eBmvONcX;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8800606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 21:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8800606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MykMcCqP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eBmvONcX
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EBE2C1D000BC
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:42:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 29 Oct 2026 17:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793310167; x=1793396567; bh=V1yVUoj0bZ
	PZum99rDp/WGdrou6I8YXOL6+Swcww+Xo=; b=MykMcCqP33roXbYI6sE0alcFSC
	Ye8Z2C6zBpV80o1xL2SMufWIHAGk1V76BBNcUJdgQ9sbCyEvy3mvbyimSStvOOiL
	SdJu0BzWmWg0sbFF6nV9OWPQRPhuGJJzbX8zpCkC1okhBzi3UuQ/LmYlQ2Wc7slg
	itoLWjEcPhqf08M3ah4bsR/qcsacfuhnG8rv9pgQc5umHNAYUj24IV0seJQLQJ5P
	DeSoJqHmkll85qGu8/UF6qMvhiO++2bHqhk9AOBExUGxV+aXhpZCEv+n0EaShnvO
	DZ6r/oDfkuEG48Rrzejeb8Cm1Rn5CToIYbnIBsob8Vm38OHy0zs6ztHs0nJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793310167; x=1793396567; bh=V1yVUoj0bZPZum99rDp/WGdrou6I8YXOL6+
	Swcww+Xo=; b=eBmvONcXngrZPm82vlDAjARfepgFy5s9sBBQSnQPDjae/5QHS6v
	ibFNpXPpyiwGP5RrKR3WRoZ4auShi8tLqxrrQ46X9eGWR2wWj/VptEdZQ1bFbbxM
	od4tNjdR2GiDng2eYyFSDiKM6Nlm81SbEKS7McjO74yb6mlQZm//RbocRNX02jaw
	u1Kx8VOQI1bhFG1WxYbeKpFoH5LYZVjKx6czdbRI/s9oE3AvPFolN0E59ST9ODuv
	x+8O7w69Xcoenxa/oA1LncSo0Y9ODT4eQYWAtOvSGzyOGJHtKFAPm7fWEJamEEbq
	SgP5uwaU1aFjCEMznLogoPC5NrQRQhj0sPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793310167; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QjPh4mJSiR1wgGXSjXUEEcGbF88SWqEQReilEw/Su0PvzHN
	4XZ+79fZJsLS1+y3kHalPKxkJHsnQvulCVPk0FZ2VfjVSGyYvtCnbYIoePncs77G
	FQrRw1WYapYNu1hYzULBde2qbic/9SROWPb3vhIiiBJYcAwlVX965L/8HtkHTNBg
	rkNFekoFehVVBSOc7vffciaIX0D4ucnEA4cnX+a9EbyQvcbqDAuSAvwcnFJBlG5d
	p0fKT+f0/ddEuDkrTo9+HeP8c4zRGxN8756O7sWhur0tIVNA8SLLwl6HCaSGZ6Oa
	kBnxFhe9J4GY1+cZ/WN6i1t0Qo5ZYAXEykt45QQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cfh+Bibktnh4h0mLWPCPq9hTdyG8nBNBIjshERLR3Q0=:V1yVUoj0bZPZum99rDp/WGdrou6I8YXOL6+Swcww+Xo=;
X-ME-Sender: <xms:173jang7iPyK4LouUa8UXqlCqLFznrBrva7_yI2oVSYRMMYWF_Iq8g>
    <xme:173jaq4IPOk2HXpIP_mzYaNLaaZr393wwOFm60XUDDZGWPKa6_hzyEooHX6KXf6tO
    4RbMUr78DRxxFJLc_gU7KF7S8-G2OkiN3SjjUoVKjCgyc8ocPxWn1M>
X-ME-Received: <xmr:173javaY1sXyebPFK08bTZa41Uve8ErOwBvhbUxp_rIRzX01JYPxvhuNlRLDjNgOuJEDHGJhq_TLsNFyh132OJLEvj5M9nbgy4Qg>
X-ME-Proxy-Cause: dmFkZTEkLLB6QmuK5yMbt5wFnDenIc2iDaYz9y7CXA1378kldpfW05rogklK+Ov2h8gVLJ
    D0+X3RsigbHicf4o9pfn9222CU5HI3QMuWPFSviYg0b5a7uLHediN3lfi5F9E5R74b86hh
    1/pRgiUd4VLJnuDLoC3iAvhBw4qnC4YdhocB5pQQVvhFYWkd5WzG2pg76tVWSpBHEnPtJx
    TrHXq+op38v8uZ6s03MU9a79iKoirKtTti5qMNkKb1e1R9DYNVF00zVF7kbpST05GLJpVl
    YHp/mldZwwheK56cefWyPpm16IsM5Blm3LobrhPck+855dnP/i0hSYDzZnVmezNeiT8dGD
    y5t+85rOrrs5QSBS9wLiX53UBw0dZR3lXQuLfXSBusFONyradY1DaNS+agQQkKF6HYEDQb
    v92fDxdWwprItC1bMnnaxg06ovi6/IdGiu/dO1MsEMWfBi2fbKs/M4+jZm/EsSL62XFoer
    qNo1j3JZ7NGyL6VsTMGiwb0c26giDRlzebZ0h540B9IC5OhuuJLYeRAcIi08inVdUYDlve
    oS3hB4dCnxgnkjqH5SFKVZBLxdhJn78/1ldqW7urvs6BYdraR8U6jCFVcSyPsVTuFD+4ph
    B1i6MPyi0+5nfpZIpIlU8YWIwYOOuijebvnUDI6q+f7yiBg9l1PiOy/ZsfSw
X-ME-Proxy: <xmx:173jav5ONeYBeSsDxrdpLM2R1bWlt7rqN3QkzUKV11ebW17XtRbtNw>
    <xmx:173jaiCT6DSjxskjXRbF8ihRro-Rxp2at_GZubvono4dW17eIx01Gw>
    <xmx:173jale-seA-f7l8LuZuZXL8an2cG23vpmG1Kro-ohm6eneMITQXtA>
    <xmx:173jahJ9HZ09I51xpjpeky9XyzqjDkggcYojp2NXJBQS7-kWuDHBmQ>
    <xmx:173jarIar5GjG1HV2VrrtDq3pIqDAy8w_3_PezN69AGKJ1tjHMJrXPvB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 17:42:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  <git@vger.kernel.org>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent process
In-Reply-To: <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com> (Farid Zakaria's message of
	"Thu, 29 Oct 2026 13:56:10 -0700")
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
	<3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
	<xmqqbj8c2wk8.fsf@gitster.g> <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
Date: Thu, 29 Oct 2026 14:42:46 -0700
Message-ID: <xmqqzevwyyi1.fsf@gitster.g>
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

"Farid Zakaria" <farid.m.zakaria@gmail.com> writes:

> I felt confident reviewing the current patch at it's current state
> (AI-assisted) and I do concur that it's a net-positive change in the
> interim.

Sorry, but I find the above very confusing, and I cannot figure out
who is reviewing whose patch, and who is concuring whose statement
that said what.


