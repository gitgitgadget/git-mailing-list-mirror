Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690504;
	b=L41UiNfujVE0e9qpWBmeke1SG5zZbadhdg0LMdeKyPm4XPy05xt5Ze1uRQDIa65EbIrF
	 0OIy0spmlsSJ1VpeU0sj7fIpTl7pvH+oy2x5SohhSl9XPfaJ7haNTr4PpS0wCfrZskf2Q
	 rqiLIKTfpvzH2Zj9JojyyetDGf4H8vjfMIsqsQr81fY7lfYAZdS+D/QzMsUQhR/maVS9c
	 v6GGFJJg78WMnUEWj1P+T2XVIv9GLH6jKyMaOq9HYATt3qTyiiqdv7CP0rrEqKgVt8d3a
	 ta3pko04T82Jv/FC0LvJtqrzR6UZpkTjvAbI7iZXtdejck1njhjEq+qLbCx1+LNQZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eWiTGATAPNC/Qi3Y+bUjTOlQafXK47Sey2o50dEPmBA=;
	b=WpH6+07bTypNwKVqNd/+Eo5K74SRWDY0YEktuoEGltBSIgz+lHNc7U7YN/i1mJ4zu8FK
	 ZqR0+rM8dWoAqw0KKkt6cQ4Rp6jPOh+8Bb6XdZ7o1n/ZmQqrhAzIlMTnHJPYEEqT3lENQ
	 Qdsedl/OqRxgv1JjRSgP0KSOhvHtnwXQzwok4Q+u+IHYApsAjXV9rnCyayGuvKwKt0DjC
	 drYBB18Dzby3O5mvUFM0IjjFx7BmWILZSEORGuCqEQJ/p0WyedUunJ3BfkYoDchK6Josf
	 qBHGf6aq9E+OSbSangYk/aJBgRmKNPr4jZT6CLsxfiuqnXLQfePeH05lsFPj+NNellA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=o4nDik4T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="evu/UOXO";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21253606B78A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21253606B78A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=o4nDik4T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=evu/UOXO
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76EB17A01CD
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:35:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 22 Oct 2026 13:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792690503; x=1792776903; bh=eWiTGATAPN
	C/Qi3Y+bUjTOlQafXK47Sey2o50dEPmBA=; b=o4nDik4T2SOMHwsyMO5zQEzzo0
	nb6E4FDd6Iba00myLr+0rHk2lHS/J1AQ50kMQkx4vnAEMQ63/mnH1Gd72Rcw8GJw
	KVXiCdkfoOGJrrT9DpSkvDTnCUU0fTRRw6MKQuR8v8SfU7343nF64tlNAE3a7o+A
	1oT8Ebn4lGhwSy/dLbmo8FLcN0Djeq6SXFFScXc8YGyRV1h2bothiYLxt34+DEQo
	NGJ/wjkg7iJXzj9UMWCqUR/vHlrPN1RnePASXDGGGcsUAXZszaRk45h+jCdGguPF
	WshbBgbudz379zsYDdaASP+qo9N/1xEyaS9OqXrFwfP1KSTdyqe51yHegOFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792690503; x=1792776903; bh=eWiTGATAPNC/Qi3Y+bUjTOlQafXK47Sey2o
	50dEPmBA=; b=evu/UOXO9KxXhJN34L9ji1dw5EruITnYxAwMA89k6L9B4Tt8vxy
	Dgw1tRVcUBgXJ1yoRQ4g4xUzwxnRwUreWu9X2H7M1sjqc3c25w7c1X+brOOa+XKa
	CNDVQNfpuF8y0BLS1wIqg3B81SvV952M1PgNpXcf/8hEViZ6yEcQfuKmH8gXHLKu
	9Qa/Mbt0r0dYHtjRKf6WgsjSZR+mwpYZ783KgdECL8HixS3lcnYQruWyGTZp7dVy
	pZRsgg3tX3fjeJsXCv2fv7fuSW/IciejbU6ZgUeQ3xa9qnxDb77JcSEh1BissGTQ
	cEBJWqRFzgydCfmWcGjARZhkEKpeE0JF9QQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792690503; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dEjb+GreCmnXRcvW6ja3hKLLkub0x0a74YAv7an5S0Q384+
	PEtDdU6O398WwtEt31lNlCqh/f775Wvqr3w7HBpCDYXB/2+EF4ZeY6hf4ewDwfJs
	BASItWjcwH0sajB4tCi+fLyvivhIfo4TJsqAR0/ZDUu2hC3VLtNjCMMdbLZUoXfM
	k88yx0Tc1BvdbADiykVC+5rcBK+rk8UXyEiJkm5TUsy5hxiQwYsWZsTDclzvupG6
	SCC3dLn9N6HJo884stZ96oxmaUJ0Q488sIuCSRdG/H8B8J8SY/CISoF4vYO4h8G1
	WvrO2xGuCoPnDtAGmvCkgsoYqTOJreCMdccjhmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BtUWKCh39dYLJzrYsYtBV6AmS5nqVHPI5s0td/qHjNU=:5P+l6yxjAbsfbqYH93bmbYY61wpNRRzvfc6wIBp8Afc=;
X-ME-Sender: <xms:R0naakw3HVyUzUiDsEf20-BNHhmpptXE_HmUj9SAerjLFu190wUs1w>
    <xme:R0naavSTXb3fw-lFCF2t9G7wHz-IUE4z1vEiJVpv1nsOSdlhkXkRtoUL2VbfQzRFc
    niya7EolYfKl2wRSQfUPCxuPbP0fs1aYykRI_I-wEeFreghRAivM4U>
X-ME-Received: <xmr:R0naarVEnx5VvxRUfk_CMqYinRW73sMR6s8Fxq0SM42ScDyZClh_2SHf4GTXFEnlGrfjHk_38uil8idLmYeVPi8Ep0U5IM0X3kNt>
X-ME-Proxy-Cause: dmFkZTGyKiKLkuIk8fxXofd3qDEBXwmSdJXrGT5pZyi6J6xb2/DhzjPh0uVaa6qVd/xI7F
    pZAYxdUvdzYNgiaSGiBPRUN3Wu2V64lUKbuX8p/BQCsG3zdX0RO0ZoUUwnN1l4EOtv69fX
    hPT2l5CB0vvBVN6m50ze4tWT2gm5L/7KN+FZKaDuSffnJ+q1mbbjDqgliLC+cFkpiGSOVx
    rSPEBsXNMSSIZRqju8oZOFpgjzkWaK+X6hbd0PLbnm0wc+8LVaKpNfMOFaqgEvu4wf26ob
    MieGfDOUq+EIe/+uBZf82uFrnaTnep2shCJzqt2SW6httgN8w5QwO/LuGYIfRE5DaCr/YN
    Su4Imgz8qTDQZkn/dwILvDPtnUz3KSA0iS1f4ydZTSXMqaE5T49yzr2fRTq6VXlD4HCjad
    6ApDA1i0spT4dvhH/Rh5uV6piHrOG3kt23eRZlWA2EgAIfB8y2FOuMdQAr5yPqNnO+ZA1n
    0OFC3Vz0QgE2dheTVHFCSBz8JjGVvzb0/icSyoJHpHAvJtWe1SRZsqAH3/NzZQainbXjNG
    uM90Ye0chhLfVz5jxTwRzrzWVO4oQVQXqFeur5DG1psAXF/G+36HIuqXMQPqcD7NJH35TL
    SkwUrOFUyYxCFofwL+5klxoH4b17zmA6EpKdlUyI5ATfqWR2CGzOKYfioz8Q
X-ME-Proxy: <xmx:R0naahbthkfTTz7HcmQL6agNlLKPIdacXZPGIlTNvtjUJOlokeNqxg>
    <xmx:R0naah3s_f6uowy4WpZCmw7yYl1qMpD2x1j0A6S6BcqJ4XiMPGVzbA>
    <xmx:R0naajjkkdPTCtQ4owH0QuIF_H7215uYiYp0BhjdEK9IA2qUA64wBA>
    <xmx:R0naalaPs6Oth0qY8kKicM1krJvbb47tXu51poP3dn4d_NuvqOXPvA>
    <xmx:R0naai1_br9p3F-a0wT1wfT8nqgB0eSjDSeZMtK1UNYhoQxNGfU-SlLv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 13:35:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy PATCH] doc: clarify promisor remote fetch ordering
In-Reply-To: <CA+ew3JtPJuVNC0PR_wY=8Wxp4-JpJ0wCPvm+a=BdJ33QaMpJMQ@mail.gmail.com>
	(Wasswa Edson's message of "Thu, 22 Oct 2026 14:02:04 +0300")
References: <CA+ew3JtPJuVNC0PR_wY=8Wxp4-JpJ0wCPvm+a=BdJ33QaMpJMQ@mail.gmail.com>
Date: Thu, 22 Oct 2026 10:35:00 -0700
Message-ID: <xmqq5wythc57.fsf@gitster.g>
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

Wasswa Edson <edsonwasswa54@gmail.com> writes:

> From fe5f35b00eafa1eb2756178445d3e88c4e9d6787 Mon Sep 17 00:00:00 2001
> From: Edson <edsonwasswa54@gmail.com>
> Date: Thu, 22 Oct 2026 13:09:21 +0300
> Subject: [PATCH] doc: clarify promisor remote fetch ordering

None of the above should be included in the e-mailed patch.  Your
MUA would record your name in the "From:" header, the commit title
in the "Subject:" header, and the date when the public first saw
this contribution from you in the "Date:" header, which should
become the author date recorded in the project history.

On the other hand, there needs to be an explanation to convince
the project that it should want this change before your sign-off.

> Signed-off-by: Edson <edsonwasswa54@gmail.com>

See Documentation/SubmittingPatches [[dco]] and [[real-name]].

> diff --git a/Documentation/technical/partial-clone.adoc
> b/Documentation/technical/partial-clone.adoc
> index 18718a3840..a1104930fb 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -196,6 +196,11 @@ filtered `git-fetch` commands from the central server.
>
>  When fetching objects, promisor remotes are tried one after the other
>  until all the objects have been fetched.
> +When a server advertises promisor remotes via the protocol v2
> +"promisor-remote" capability and the client accepts them (see
> +linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
> +After trying the accepted remotes, Git then tries the other configured
> +promisor remotes as described below.

Just fact checking.

I thought that a remote Git server cannot arbitrarily inject,
advertise, or force a brand-new, untrusted promisor remote config
onto a client during a protocol exchange (such as a standard git
fetch or git clone) if the client doesn't already have it configured
locally.  But the above description makes it sound as if the server
can advertise a remote repository that the client does not know or
care about and direct the client to go there first.  Is that true
(yes, I am wondering if there is a security implication around
here)?

Thanks.

