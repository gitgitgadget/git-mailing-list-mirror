Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615481;
	b=ec3uvD1AaH8UurMyZ+6CIhxw005Pf65rcEYij2wMxurfTDA5wmRXN3x/x4OKnL2zG/FS
	 vzIhxtY8nzQTwgtaWx/kkOVvdPsUD2xA+KZ+w7QON23vv7kADgIh5khcUdOfK9EIbiTyY
	 SK3VuedH8t7IX1pqKhssh4Wlp98AjjyA7wVOq8uF+QYTWVWCQ+BkB8BPJ5dWqCTDU+QfO
	 CwUEoITq3Go2y4eFwLxnqQXDtOZ9VEYB2u9EY+C2Uay3nHOUz4n+Gp+Eb3uqYC/SBv7yG
	 1nKYhXTPEtPlv3uzC7uSIlF1QiV8DtcwvslgaR8pxS/Xxp3PiRTvT1pwh2Rip8NadjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615481;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UEp+Kg2nWzmPF4lNi/TPVGLq/yVSBo2DBI1bKVz51Iw=;
	b=Fg+Nbtqf/Wpvrvubjad78qgdO+NztiKHg++j703SMf+lmGZQpLjdHhW4gvTjLKcWFssd
	 Ribrdqatx9npEi55VJnjyQARfaljBRN/Aq8pvx4lGk8/0GowDv4v40lvfFbwplpLaltud
	 BHTfA7cjHTKcea2z40YCtrm+5sfNXz9IFgC6tSMm3WaUOhO22cFbHaIwxB58Nzw+9kusB
	 ziMtpuNtKU99QOC/1V6begx8QZendrUaSyC9NCdQmQ+JwrwluQK7HtLiHemEvbnw5ORAq
	 igvudTZtInEAUrBnc5jyAbEee79H4Z3Qi+BVE/k1vw3K2aBknz9D8kRpOn6i45HXh6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ye85DngG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XMrnYqSm;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031B606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2031B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ye85DngG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XMrnYqSm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F4DE7A0079
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:44:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 16:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792615480; x=1792701880; bh=UEp+Kg2nWz
	mPF4lNi/TPVGLq/yVSBo2DBI1bKVz51Iw=; b=Ye85DngGYlmprWnsYr4NfOF9sG
	EGJth9HOXvLNrcAmhSPn5njItrdkxjhdUqHcnEDKB1U53n/8lkgpDvSA/z7NmLUr
	xagDcMU+it4IzOFnug/SyDukN/gzERwgpXMOSWvzMyyMtFtfDO9lYmUDR4N5tOZB
	zCHcy+EvKMyi1jRCUdKZ0kgFvNaQCxdUVJXLlLKhx1G2ITIDJfzg7AvDZhlPlRx4
	jpGUuqGGVTSWGCN9PzKdtpeO6QZYGGLcF4Nw0roG4VScWezs2M26DaA2JH/pKAjU
	CgRRuFUIaNhKw8l1pUv6fP4RzOhYADCZ+RyIxR3JHtaU4K+2L1ZpbXdE7R7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792615480; x=1792701880; bh=UEp+Kg2nWzmPF4lNi/TPVGLq/yVSBo2DBI1
	bKVz51Iw=; b=XMrnYqSmyLVvrDJ7VKqFAMbuX/wE7g24QZNf8iWqBYJudbYLJ/b
	Q3zfyh1NnwRz0AQ8K+bQGXST55mPbPW1G3ZX8eEn1Hqj+ux/RJ3RU6A979zCE2cn
	HgTF3gnZAkJ9m7UF0Pp4dah6HaLVdOIsLFqwp90I8HdPGmT/51hV8P5miLFx2eYN
	lY7+Cl3dbq+Al0oxV9bt2Vr443irVdzAOBrDWreNXZTElLegd/50xzHJcH7rWei0
	ITg9DCfvN8ReD/xFJUniTCzXHXoQKp1VRHeh4wsqWOf9O4efWlipCfgrUzgXspBM
	yy9wPicTm6tV8PIGefwt5OUXtPYrOFVEfsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792615480; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TqwxOtbSw/cNh8gayiMOXbsnChSIzUNa9diHj6jfw+oh44D
	iBACoY7g+CS2QZAJQ8MP2x4Cak2w5lTZ21K/9Sx446Hc3PiKD7KtRP6vZ1GgKUwq
	xdmTqxJe/eNXJYidb71xCdclL12G6kXS9SkbCKnIIMTo9H+4AoAC4HIUUAbuqUrP
	dlxExE/KB8770mBChZnU76RclPkVb3sqM6+zMyhiuX/WLZyNmJtz02le4/60BEtD
	HHP906cS0AbQC7Fyx/qEZKH7UNVWik4qzibE/9PWaQpOgKt/FmSogal4SwbeBzP4
	8vzqN46Ru7XqUbZX2xzjBcEWpPcwG9aTNJ7Dsdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:AQuUov4u0nT0XQBtrCjxsy7ORdJ7BBiis4HbRqqhEao=:wZfDGRXMNPz9bVdRtC0fIggIfxLtOFCw/xVFxv/zdQE=;
X-ME-Sender: <xms:NyTZapSMq8UfAyBzd2J6bjntsigq_9v289NEwft3PmcCae110o3KMA>
    <xme:NyTZalDXlTmPAckeCtSsSI7quoIcoCrwIzHNtAdQOODA-EF5Miehe_AWIEW4wcs6O
    Igv-6fW0BmCASFnKn1svmVNQYfCmDxOmeOmTJvyGH2Z8dvnqIFnyDY>
X-ME-Received: <xmr:NyTZahFpQu2jcWzfWPU-FTHZMZdGEI7lPxChxEWOsDqlIAK2LYUWC_Kzv41h7kIoDlNu2MiTgQpAqOkUiXFuUb_io2Co6P6PhW0M>
X-ME-Proxy-Cause: dmFkZTEpFmzSq554njX9zmuh+JN1XsOQQBrtJwm65QGsUYKFWYllKoo2DtJUJRxBUhCGNm
    p7CFxi65Z6rXFDstfDccogh2/S/S9ZalQCtPcA/OKcMSa6wZ5zr/ifJhIi4ArSbQTKN510
    nVPnZxYug5iqIqhXEjLC3iRED8IN/um/dagVNM9wjXdrDU84KO9kZwktey4gJ5A4igREi7
    m/+ouqxYW2diZH9lofFcNkoLydHW0zAT+/IMkfZajSibndeHh4QzX4FrbNZsAdp2WTW5A2
    byo8Mkn1oGf3yHWm3dyiatctGy+pFrtFts3UVfgGJPcrZ6I1lj3BMCi8ikn9YaUZVoPZT2
    t2GgVNhRkiMRgb9ZzLWkksZ8nJIyiaNtRpCKYgGPHcDMwSHsRRA9rf9DQI549WZm6hMWT8
    fdMJQTiefIrcGHfH4U2wSTkhfsBuKL4s3+r8d22wTri3WP2FQMByl6YYNe7KYyzwCM8XKX
    UNNAYXjZbjVXToXSDL3rQKx77BYvEqIP5njSckUeh+QtFUft6eLdQGH0GN5IzyMOiNqugQ
    gYbeCzS283PIO3MMjMHmsI4CSRs0O1hHhsfJMcyL/3f5BJccicgq9p5PRdIVLI0yCff31r
    3NJ/uiQg7jUi+WLCJWjoEJyNNSKSJudLZhvF1rB9ghB75GzyBgHev9chKf3g
X-ME-Proxy: <xmx:NyTZanBwB9haeYQbSghwD067e7RElrooMMOyoCHvMSxGZGksekQAUw>
    <xmx:NyTZahVUJLmQszVQTexK-T8XeaKk6gj8kOMQIt6aVfpdT-Fdb0AP5w>
    <xmx:NyTZaroKrIOlyuj5_GWRxZ0Nxm4hB0TvjSfNaJ-WoSzrBFvtLrRY9A>
    <xmx:NyTZatQINkUGEfl0IY035njmZazWPtRMI7yQeqQgM3R_SqOjxdeOrw>
    <xmx:OCTZan2rb3jLrRRoAiaXgRBW52FeHvECJJFNIKs2b_4qBOxW6P0OuCnH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 16:44:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] environment: move commit_encoding into
 repo_config_values
In-Reply-To: <20261021155608.58509-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 21 Oct 2026 16:56:08 +0100")
References: <20261021155608.58509-1-okhuomonajayi54@gmail.com>
Date: Wed, 21 Oct 2026 13:44:37 -0700
Message-ID: <xmqq33tyn5qi.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Move i18n.commitEncoding from the global git_commit_encoding variable
> into struct repo_config_values.
>
> Initialize and release the value with the other repository config
> values.
>
> Pass the repository to write_commit_tree().
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  commit.c      | 16 ++++++++++------
>  environment.c | 15 +++++++++++----
>  environment.h |  4 +++-
>  3 files changed, 24 insertions(+), 11 deletions(-)

I am not sure if this change makes sense.  The 'git_commit_encoding'
variable is declared in 'environment.h' to be globally available and
defined in 'environment.c', but its only user is the 'commit.c' file.

I do not think it is worth contaminating the repository configuration
with it.  Instead, shouldn't we allow the functions that use this
global to take a "const char *git_commit_encoding" parameter (instead
of a 'repository_config' or a 'repository' structure) and pass it
through?  The callers may need to query the config subsystem to learn
the appropriate encoding for the repository they are working with
before calling these functions, but there is no need to pass the
entire repository structure down the call graph.

Thanks.
