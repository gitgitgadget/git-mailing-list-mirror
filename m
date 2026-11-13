Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607013;
	b=cCImKMJy1Spt8tBn3OLv56P1MBK98fHjPSaHRnQX9uMbww3LOEik1lHL0Ln44Zu4VHVk
	 VSV9HbVz271JG4WlKY2Wdo7D3GqzPOiBEa2u9LemFBhY8nBExIKz9ZEpojMnIj3qdn2Sb
	 YFcx9uiMuIMYzl9iuk4bUwfLp5KzaMOhGk81QyJD9z3pomygTjmMks7wRqA0kZONI6vR3
	 zGPVW/eZK9j+x0rWVT/2kS1o/t6DHu2fiNeIgVMjp5exg4mQWmLzHRqfXhT8MOpKUa+BC
	 OnE0jaC9b3aQo+qtj4t+G7loI8kr0REAeymNpzYZ2rXU18yj6ulfTKIOSejQmOvcczg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607013;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TPsy2Exgu0UfFuYl9cXNPG8tX6At0i2W10yvkP3yFRI=;
	b=rQagXEdfn/nOqTEhV04X4+h1xMPcl4MVM/U9pj28yq2IXh/KGEcB2XJLMZ+h07givhYO
	 MyylhCpMThDepnBDGfB9RQ0OTw60tSM5eQHMHD+nMvsrHiI9VREsOSfHHvj0NKxiLin78
	 6UXnCA7CkrG8IfdK2T8O2EsJyPwDATSMVByrJmz04VAcN2mgJLdSd962fd27apqPs1Pm9
	 uU+6pQPrqIB8H2R1OS/RlS/tqQrQ3Of9KSJFmeehdYkfVjB6jjdeXsOTdPVZ2rTXCmt9L
	 0nCAr3G012/y7wdDqaDZbs3AN3NQB7B7HZazbNMEWmkRiTwn1soO3eS/YMLKTpd95hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MzJmv8FR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Leqqk+52;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0878606A33A
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 21:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0878606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MzJmv8FR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Leqqk+52
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 217F61D000DA
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 16:56:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 16:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794607011; x=1794693411; bh=TPsy2Exgu0
	UfFuYl9cXNPG8tX6At0i2W10yvkP3yFRI=; b=MzJmv8FRNDjAjsxDvQcC/xfUd7
	LKF3HhabkAeO/0O021/Dbqv+b/GpKD76bEQCTvdrvWY5uVUYflpv355W3eQ95gM6
	H8jQPx9Qpmj1+EdoniaWnQnqSlMHPiGLXIj2irRR5Rrh4YPsRDWDNyi0wSqs27Qa
	eTzeQL4x+vqoOeiU5BCYB80qJKJDpBgrzQPfXk+0lTP4FYS/iUY77YlAeTvcbX1f
	DY4hRpm90lNuiZwzg7AN3yYYYzIRLtC1UVBgXLVAUhDxrO905LEtLrMMgSntbMiA
	1oo+rcwb6UWP8YKrzXzTLdLabXldfG206nDLQtjMQi9N8Kux+AhodmnQrWEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794607011; x=1794693411; bh=TPsy2Exgu0UfFuYl9cXNPG8tX6At0i2W10y
	vkP3yFRI=; b=Leqqk+521Cz+6JAi/Xl22SY4eBDMBWRTGBjAq8VZl6nm+T30UkW
	NJ2MbSNJuL9MCYdA2640+imEobT2+MQbpOfQU9VDoKBZfrlsX4FBpyMODPwdOUr9
	i14QoSZX1y9aWhasbFzlUbzJc8htaqhCPTypefYIo7epsIV7bdX1QH+Ktn0TyjlT
	M46bJowiGtz17+MnkW8RGXvgupjdBVXW+PEP6UaDx5ijKn4cxIoaCcfzTKTOG0GE
	0Mcx2H3Lr355/mWuop2z3Yqzf5o8K6wx/6pg905G2dsHV1Y7n4SgCdrcwnLI2GsI
	pUIY+ScmJiwRS+EiYkAaBbqb4Tb4QV0fTsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794607011; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:It25IXms2k+kSqwdw52FoHUJEsaacU7AavqPEL5C5Bnk6H1
	shNSfS5wR7nt3SDMzaZM01Efh7OSGl24HhbxTszvn054fH9PYR8/+NFwK1PAVrAi
	dujTaSLik533rozj3H9LkBq69xzCPH8kXZ3WUKXnOJJrCM6HndWZtXdv3klPwO1u
	PhgfqUOgqlwE+YkWCI+9DFUW2x3clFDmtQ2UNg0iQXSk4jkb8QyPEsk3VVGjfA8Z
	X1Bj0d82Y9KL9KOo42waNc5M1ia/MEc24OtHr4EfhA4uAUrucqtpGpCEesfbwWAJ
	Q8rNOhK2YBrXkZ2rcInwbwWMUG1bHoz+nbXYoZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Dt5sshz+Du+F2IzmKeJACX05pqx43vjoaFkaQqNZYy4=:d8mbDlUYlylvT/xC6IcWf8hs/KmZ7H0695/BTI2doyk=;
X-ME-Sender: <xms:o4f3agmFhj4UU2I02u7cBJQFeTLfRnOSuvUc0ml1VQvw6Dm-puP4yQ>
    <xme:o4f3ajj8ieRpPRZML-t9_rN5S4OQ2kIvDYtugUGmRewoYVlZCbMrvKwUGO6eNGaOo
    2zu6jAwOsqR7cdcJFCOL7clapSS3cdMhGzfANIKadOEH3sO9prq9JA>
X-ME-Received: <xmr:o4f3aocOvqMSnDS_i0mq3JKt6YwHISFs7jQ0Nkt6l2_Y5ug1P6w8Wt3ZIFKKhQBgYpF5XL0pXzWwRQjJfImJlmmp2UKuebUtLAoC>
X-ME-Proxy-Cause: dmFkZTFwOj9ja2UciwBixCa8Hm79F/p9WMOYrP7BYt2pxQaLke0PzhOxiWd4+NFiBrWCPe
    CFNikSGUdXIwqXmHuU877YJ6c9VUiqPIhTTxK0dfWfnbx6Exi/oqUtH3C5YuNfD0AbTKZk
    x7t3vCeEqucw//17qiR8WX8fxnll7FLfGfC4fiFWAlWRimYMs5nPTxW95SODFUvvPFc8gB
    oX8bsKsqski03JpWmjcsUSNdbn0MptQBSW8/GkD4FxZYReAyhrs0h7KfQl4wRMW0NM4TUK
    Lp9abR/uMU3iBGo9/HWGZlurhOSBhemW/7ItCJaKSrRvvBIY+452WZY5Zv9HbkVFPeU2o8
    Uhy1bsES0jb5NHJIXYd3CbKM/NUh8c0NQjuMr2UEQNZ5Mdu7pguczjAH6/J9ZmSX/xXJU4
    SS6ND3rmyWrtUkvG1BBJAnwfHuy2SEYF+hyHpCLkG5Qdxq1EDKOc8eMDlFfWHoBdjNTsrj
    /+Ad62KkJNQs8fXf7q86KMu9FT9Vk4Ur3I8zaGVy3v2v6aPR9mYnxU9hrMGWLiJ8RWn9xt
    hoWsDa01yCwCh5TMBJ5uOzAlA/JnsEOYUeBYweI/kR2Lu4YS69+pNdhYg2RGExHI38/T9L
    4/5zD8fQDXXimq/hJjVqV+LsvjEa1JdocesGPQmKVqNNOMPmyBMIy6G8mj1w
X-ME-Proxy: <xmx:o4f3ajjpWtMpgpxvfB3uknVsyTT4AB2G89Li0xGBq3pueKNTgOAfoA>
    <xmx:o4f3agxsU6HNqiRL-sp4J_LGsjeRm8g17x8FZoLesMBnt-vY4YywCA>
    <xmx:o4f3avPn1zWL-g8S9qIu80adyLyTqvFezIwvdMNFzhrtxvC9DME_BQ>
    <xmx:o4f3ahWLXoMQvl69zF4xT41rWgPSg-9M01LP8CP9_4sjeSGbzHsYaA>
    <xmx:o4f3ajIXjGwdtndDnSMwfBqrjFhY7qIcxWplGLj_lpFcFkOy71l2uApe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 16:56:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <c12bf331-0d11-497b-b5ae-874534a42385@jvns.ca> (Julia Evans's
	message of "Fri, 13 Nov 2026 14:49:10 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
	<xmqqik21j1ie.fsf@gitster.g>
	<4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
	<xmqqfqx5foxd.fsf@gitster.g>
	<36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca>
	<xmqq33t4fxx7.fsf@gitster.g>
	<c12bf331-0d11-497b-b5ae-874534a42385@jvns.ca>
Date: Fri, 13 Nov 2026 13:56:49 -0800
Message-ID: <xmqqpkw89yzi.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

> Of course these are both important audiences, but it's always hard to 
> write a document for two very different audience at the same time. For 
> example, one thing that came up in this thread is that creating commits 
> while not on a branch is a problem for the first person and a good thing 
> for the second person.

This is a manual page, which means it has to cater to both audiences.
Unlike a tutorial or guide, we cannot say we target this audience
primarily and expect the other audience to figure things out
themselves.

To cover the "oops, I got myself into a problem?  I do not even know
if I am in trouble, or if Git is behaving as expected, and I am
totally lost.  I do not even know which commands I typed in the last
5 minutes got me into this state" situation, manual pages that are
organized along commands to help quick look-up are a bad match.

Perhaps a FAQ or "survival guide" that targets these inexperienced
users would help?  Unlike manual pages, guides have more freedom in
choosing the material covered and the order in which they are
presented.  I dunno.
