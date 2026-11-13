Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607833;
	b=OKjejF5dTvl1NEEcl4TCBbNKKcSZu/b3H8tGqBJ5e0CH75XaqFZrrVGpiY6eVE9sUttd
	 /DmAHMSG6V6lybfZNyDsLmYK8cOsga2eiPOh7cjobs4rqalQ6Q0cRLWVMJiyOxWSi6+GD
	 L2qIGAOHgk6m8iOjv4TmSgS6DyN2GWaQtIBj/jcfMmI+g/+6QVnlfuQzzygznNQUeKqlN
	 D21xI5Y/e1oE9GQr+bv6cNr+/vihbS4l78CTnpG8wXuCHa94hIIhsuvoHi+ynbx76W4TB
	 FJoMIyghA7b2rnS6JcQWi1yXpzftD+g1tNzj5YdQKdytOZiRagwKPmC22AZQcBYLxsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607833;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gVQGzQe/+t2Xf+qyLG267hUsr9HHj/8D46OZrCxpJDI=;
	b=Ll2PsOBt88zlEfcDashn8LCiybuisPZd3GBNmGoLrOzXzTlnqXcwG6XFAQyZoU7S1cD8
	 ptJNpGKyfq9R3z5EoSPvGYRhOmA96+5zt+4wQqOE0S7bYRdFJ7QsBUzJaUnlBAi+YNkHZ
	 V7gAKp7wmJLn7lilMbdokLai2Yz1v3i4XuacCEIMakJ+EmOjV4yimI8F3BdWt9JlvYyz3
	 dcPuVL4u0KplRrF/sWkUwDkPeOr0/A631/XBEkrQfv5cVeWwDW0maoc5Vh98qwJN94Zb5
	 pkVYtAzdf1GXji09qZTe9d6vFEwS/p4G3ttngOqB2FtTisdsipk1sgbaNf5RSznH7lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M0Cbvw4J;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2dwSv2d6;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1582606A335
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1582606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M0Cbvw4J;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2dwSv2d6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 434411D00154
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:10:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 17:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794607830; x=1794694230; bh=gVQGzQe/+t
	2Xf+qyLG267hUsr9HHj/8D46OZrCxpJDI=; b=M0Cbvw4JYd2x3Vqh0VwflIMxSF
	6XDsHVlJg9sCfpuLDpI8oe2K5tjKuMBipKCV4RnVescxAMNlmGUnawve+RybUW27
	QCj3wB7bTTHP2oofXp2/NbNY5RZA/yXhIO/PJ4wMekHh6wMn1ceRdBCuKjAm+Wx3
	6mj8udUgIQMWLPR5nHsSh4T/6dofvdRivkzm3p1YUEw9WGS1N9YVBnq3dEuEJAHA
	wdRJLJWsFsCsxpLJrtMRmK3cuHvrlsRGVQ/1QbyfVCXR+4eb38xfSmvMIaap+MDD
	ToRYDsFlO+5AAWfhmfGPTVan3nG6C8nnTqpZaU1qXXNyEcBBR+NiL97BXWMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794607830; x=1794694230; bh=gVQGzQe/+t2Xf+qyLG267hUsr9HHj/8D46O
	ZrCxpJDI=; b=2dwSv2d6DVSPGLzRr0aSLEmBtRAWe9e936o4jcSu14+mAVI2Fnr
	wnd3XEvMECxp+dcT8dDXPYP/+sa4dyLfD0OdoIEcehaOQ1Q6Rm05J2QgS0TU2THh
	tPFD5X3H7TmXV6pwRDmg7qif4K4xMf/BVVHGhb+0JCKfl3Jd8IHbi+9QmYG+NSGs
	lOUK5hoqX6MXTjb3VP6kiSUBlbB6YjhHg7dulBr7coFe2MfBoAcvBXRHKzA4PaFD
	ek3vOnHgjnCcwXlY41OKYK4HuS4PaMNvL0qXZ7HLgALGjBW8wxeh3vgPsBX/tSlk
	rSTvBvV3bnrs0NE+FbE8j2TlO7zeb/rMHGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794607830; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZNjvjfTJI0H9B3sVZi5M2phhzu31VaPoIiQ7SQMTUYy0A35
	ubJi/ICuVjjrHuWu+AOGjM/uSQDH9TQ1J7d7P8UPr7athX3Cb7oBjaHiCiBjakFx
	Lykt6W9tIpw2hoRCBgjqAO/EZA20NfeOStkzlS5Fm4Gy+iYla1TrRYME/HL1Q+mE
	PSvo4CHoDH+rWkqjx0JQ1K8YpFtP5jXKkn3Bgw+7JvaKSxcUUZeydzN8nn6NcQLR
	mkjDDiO/iN1noEIO53ttsqkNBvv1y8oTqMeFZc+7Fh8Oxe/zEEioTTMQUz2mos3S
	Nxyr7kR4nLMLcYdNxZtJAlSnlZiABZUc1s2dL7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:27TgmnE/ZIvnICvswTgyXiWGVe6UZ/frY+wSiUqKVgw=:46ItXkT9KM9nqZN+SDcZNc2U+6s5MtnlHSGYxTj/LpA=;
X-ME-Sender: <xms:1or3arHozHr9QpL4qw1E2Ndj02-Do4zZlt-1PN0u3tj25FpKfz6SdA>
    <xme:1or3agx0Payu9l33GlfQNER1_d6mVvLpeTFeTW5nrKopGJJmApOUELz5iJN2XTm0d
    wnP944LQnWbLHh3kN-5THhzIMpwkCkbKEeR8DuvUlQkN7TDdJ6HQA>
X-ME-Received: <xmr:1or3atmgatM3f4inAaX2cOYjMFWCfGcdYjkoqkzPN_nf2DZhJ3QMBygOl_YUbIRwWOeNzXs3QuFQeTiDBFnn97sUl9iJP0mQ51F5>
X-ME-Proxy-Cause: dmFkZTEOAMQwsmCYK1ZN+KdMe1CExqoQb0eQbL87nGLEwyMkF3qp5KShzZ6BAiBPRoBpQT
    mhnQrjr8EDlEeREIlsrQeYUeUn6gFRfjRi6IVYym5uX4Yq4MyKGmDxBKlXr6y/QW94f/oT
    x34HGTqMbQ42sebW6sny31q5XaDpD63/0Pki+QIRJ5f8ramfFvYC2UYq2ryCbbEw/L5YIp
    rH6LEcmPEfbTkuIYJuwTWQRMOCUipQnDfCkWPbaMdXnx1VejX+2HKuO3qf4wEij1ybfr1S
    8gjuM43b0FiTAqbshijVJBOPUKX8aZ4M4FiGGV1f88SoGNGTlHGjZ+/5l7Q+FYHsp6JVHc
    nVmbXbDgH7ZgqWgPt3klFtMFKrZbfmlLGQNEbKWpPedVdtHEwMHSygjbCKe2iG1o3PlU6n
    U4ZZ7ZJFJ65XyCTa8q5g4ZVZ1I9B5yrZ+IwRK88OgDiBEH55lllVsvWaKO75yxRogKQ2lI
    vM1LH1TAdftV7tUE6RpBIUnLl4elnDZUXe6NknAOasuKcmPQLI3LDf3WYHHYe9FVXszpBA
    kqc9mQbBZZcV8u7DJjEjbWL86zO9G/irlId9b9jLUFjNxn0Bjr74jlzzWSasLpd9uBaKsM
    zJn8VRQafgQiNd4LOfsruLKKv7hEDBez6BiOd7GbC4xcBzU18NsJhMvCG6qg
X-ME-Proxy: <xmx:1or3aplBa61TJS8NJC9vrSDgJU6R5YwChN1CLnvFx_QLfpcdb97SkA>
    <xmx:1or3avyC1uk0Lej9sbdZxTyOyCbnHVu-dmzJ1RTGeynE9bgIzFLmOQ>
    <xmx:1or3auqjXKCk3Kbf2HxwNypCMIGVhjia8EH_QWwt5EAvBZ81BrMOyg>
    <xmx:1or3au4KPInxYbx8UNfMmvjstA4p9ZsWWmR3inqb_rwRZJS2lAwePA>
    <xmx:1or3aujsHl--Slnvx8qPAkvn8i1bdLz22B1i5eth6VgA7JhEPePMj-K1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 17:10:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: aeron-gh <agab0323@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Victoria Dye <vdye@github.com>,  Meet Soni <meetsoni3017@gmail.com>
Subject: Re: [PATCH] for-each-ref: avoid segfault on --no-format
In-Reply-To: <20261113161413.15688-1-agab0323@gmail.com> (aeron-gh's message
	of "Fri, 13 Nov 2026 21:44:10 +0530")
References: <20261113161413.15688-1-agab0323@gmail.com>
Date: Fri, 13 Nov 2026 14:10:29 -0800
Message-ID: <xmqqjymg9ycq.fsf@gitster.g>
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

aeron-gh <agab0323@gmail.com> writes:

> The "--format" option is declared with OPT_STRING(), so the
> parse-options machinery also accepts "--no-format" and sets the
> format string to NULL. The default format is assigned before the
> command line is parsed, so nothing puts it back, and the NULL is
> dereferenced in verify_ref_format():
>
>     $ git for-each-ref --no-format
>     Segmentation fault

That is bad.  PARSE_OPT_NONEG is necessary, I guess?  Another
plausible interpretation may be to exit without showing anything,
but that does not sound like a very useful behaviour.

> Marking the option with PARSE_OPT_NONEG would also stop the crash,
> but then "--no-format" would work for "git branch" and "git tag"
> and be an error here.

Shouldn't "git branch --no-format" also error out?

> Signed-off-by: aeron-gh <agab0323@gmail.com>

Please check [[dco]] and [[real-name]] A few sections in
Documentation/SubmittingPatches.

Thanks.
