Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461846;
	b=QQ1CYm2Oiyi2c7gK7PxOgl2LhVTQ+wWcuh7JrbUOjEP0o8HhE6xYPdzZ9+dqo+GJTx/I
	 YSTq0C2B2sKyJIaseMdUObYZOxRUsogEkxfHdw9DYL69MZy/JaRHRdkgSL0ZCCigFFGAd
	 3QQ/M8lY1eY7Ouw7vvi6T2PpvRcLuLudEt58aGO7HEkDVcBlZQgUXfRmZzxZlb2PSJASd
	 3AYXc9JCis+H3Yn6NNmGFokPA+U0fmZrpmKWuZ0iW+Z0lJ61QlEZPWXekU9lZi+tlI4Lu
	 qdtzIa5vPpTTryd3Bl3LqHh73aZhs0+W5ZOOU9FT5ntrJJRRJJzRsgb+OLvLdHs983Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sJQOm5o3ZDLdR/qtR3uHkVQd2GcXzYB+PdNwivtn1X4=;
	b=TXnUzCbWICyDrPw1WTLbQxXwWZC+fSQL1UJ4MY+5EGn3bwKQZ2eePSRUmld/NqqLDCUw
	 ZDG4TtCxUu5xx+EQlnvkBMyVcUota3Fpz6XkBYAzRGf31k4VJAQzSJOTnOU7ho0h7+gqe
	 XKI0eqvsiY0iYJyO1OrkD54+eORXw7Ri3jsGEvoPE3912mbAmQbMlc9Ck65/Z8c6wmovj
	 0LIpCmLWtjLxVe5KtTlTut9JtIoAWWZTlcF26nlqI4y2ZfIs1tThMPXVrUpOSZ0n1/eHs
	 mYGoNbIOz6IYBPNMptj7CbYknX28MS7KynZ9x+WRo/45O+bHu86crczLWXxn4AShmEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=d6hM0xVx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5vXZt9sb;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E67606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=d6hM0xVx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5vXZt9sb
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3BDA7A05C9
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:24:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 23 Nov 2026 14:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795461844; x=1795548244; bh=sJQOm5o3ZD
	LdR/qtR3uHkVQd2GcXzYB+PdNwivtn1X4=; b=d6hM0xVxfMtp4ep0Zey6DY4kPw
	MSlNzjpDtKUAIAqgJCgrzfzjatftQbQ8mKUYmTWBI1pIrM7/wxZAir/7hdun3cfR
	uttbfJmzMN729P0J27py78Mlpq6erMl8++jLXAgrG3BNmRhPRSv+QbbreAEUOrQm
	ScdafYLs9WoNLXc7Qi7U/kzoWBFj8fZow+WSdmp88VoSg84AqInMs+egNWqwO4ec
	3s6zaV621PXq7bQxztIzrQpK3K64GU4GnOiv4EtjXrMnwp6l8KYW3e5rJROteK7q
	/7gpyxB5k89oGHSHJEr/w4vBtnGPwbQJ5DYZ+g3lWvFN1oEVJM2TilPgOIVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795461844; x=1795548244; bh=sJQOm5o3ZDLdR/qtR3uHkVQd2GcXzYB+PdN
	wivtn1X4=; b=5vXZt9sb6CXZgLAy30zKC8Dvr7bLaTp8LkoTHbl+v/eI6Zf52gc
	6gM1aWl+AQBPwWP5PWwEkHk+KCML4cbgg9oGG9dt+997T7S7FVjAHOs2h4u1dOet
	6UOgQ3pjfabo11m88kN/iR8DT3OUZ3DQ51GP1+hDBbWoncheYro1NfYsnfybACFu
	yiRUpzpPofmPz+GcJpY8KdR5skzKfnjGdeyAMzCzpKs/1EdLgER2AnQ7NJk9non3
	xSRSrugj5VVm2D16fODU/idm8dHL5or/Kayd5X6YtYB/IggvFLvAbvbahfK6axzZ
	OEIs1DMebiEY+PqiqA+A9WUm0RbvTtj5e7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795461844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qc5KtOg6cmLKptdzzLjPXgJeUeScF+U9w3yuRyZbL/dFprC
	QcoXL/8b+TZ5ycbxaDg+7JJEPNl8SxZzeBj0YJ7U/fmcBQwoncNv7SYvf5/MS2Vw
	L6co0AIffZZH9zSkCiALMvoIHsFAfrLYItq1SD6fQCeUzw1/W/7BmyEv3wmIblOw
	u69N3iFGFuETDukmzxQ8QSVDjGDRlu1/sQzBOhydBGZu6RJFOeoiqyiKMcDxVxDU
	9wpyvVOyk5GT3Ih6xgSksaIN+/6n1Jvk2TumbnvZPPwE0ntdUgiAsygKaDqv+K+G
	xcSN6T4Gis2s6MyIGneRwYmWMNExwMbumc6ODIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IjrcLSQITkziefYyqAE8/fRy/nTei4ajVE04M6KXBrA=:zCFQWUZJvqSJwCgMZ1JJkeJ37CKFd7T7mEpL/L+P5LY=;
X-ME-Sender: <xms:1JIEawO4BqWylPVoJhXQveaUeD0rbV2w3FsxePUtJhSp1UjaLRb-cA>
    <xme:1JIEa9_LIe0zA5zBArWViYGGCEPAMAKXNdHnU4hvjYvpb7UxU1yGVTW_7gdLyw-cM
    4a9_yXbUm-rjNBObm9ZDN_VA1HN8yES_6tbuXXNuee8JEDtwnsVISs>
X-ME-Received: <xmr:1JIEa8Q1DBagldUcrk9wMYWOHlbG-v0B7w_WFn7zCCAwcmc4d6IkDQmahGmExL8TadKgd7QGW6wE-qWz-qc0w9POmGXUDAmX4IYkU-4>
X-ME-Proxy-Cause: dmFkZTGgaoWXo0RTn0wEMQ68lVMEyQ6ocLRI1+545eX36teqCw+HoioiVoQOqbSZmtU8aT
    U8cTs6SDtx4sjRFirZM9VF1NMH//klFWE6xgDlxvgRMeAvotNNqIB+2F4fK12mjxbXfsTj
    L9WKauZ7tssSkD92zovzgY/MZBWWorqB5DfMX3k1HAKCAjpeYKxxXOhKOyy3btSGg2mBWQ
    tSJZwjC0cPOgKI+Z28k3KZE5VflnjnU32v8Ut4w5O04EzVFIuqkcKzZgUTpJBUl6e2v7Cc
    ZZ4LVajIpftpqKM96fkk4LHZEJ9MLakdQz4hW78E7Qf5iKKiHEQNp1a1ffqsK9N0k9yMsR
    0jKi4Pg4Lt0AroQ74rtgsD7YFso5szXJkKxi47AkjxTcDDejtFA86blp5JRJC38H4RKLJF
    gPnhYdqnsmlJMiM3uoZEj28fh5nSs9VRHPm7DYX2jlfjPiOLLVvi1w60sIoXB62Ev5gpFv
    eEfKPvfVktNJQY8BS36EBR1u38/ymRdXN65i0mJZPQDFahiGYzbRZ23MrilcvNWsF7Geq8
    k76z8TWLrR6umaUjO2firv5VqV1gc0Pe6s4UfenToWEqrRb+MipFbJggVTrO1qxgJbXJzF
    okgJyikXASnJ97lZlxp44CYHdJu3Q9zH8DAre6IQOlq9tMLQNxTBQBU46CTg
X-ME-Proxy: <xmx:1JIEa3kKUb38mzp97jcCQQtfqw9w1oIehWzdo5uqMNnTZQJjOXrarQ>
    <xmx:1JIEa0Rht60BYSFhU3z6nWVBnYdLDIW20pq7h-z-bOJ8Wg9gzjFBTA>
    <xmx:1JIEa9PPvalFsZB9DPlHbL0OGi3o1dNC4aO1PGIlDhZB0c6b5Eps6A>
    <xmx:1JIEa1Ui-Ob1MLei8VGwbHOFd2uaZI74LqjV6EywkAZTkF-2rwXl7Q>
    <xmx:1JIEa_y4ng1M6D6aGpLd74B51U1c96sx65AV3qKSrEzRXmisUOskn-F5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 14:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Gontu Sujith Reddy <gontusujith2009@gmail.com>
Subject: Re: [PATCH] git-commit: document --date=now for amended commits
In-Reply-To: <pull.2502.git.git.1795426497536.gitgitgadget@gmail.com> (Gontu
	Sujith Reddy via GitGitGadget's message of "Mon, 23 Nov 2026 09:34:57
	+0000")
References: <pull.2502.git.git.1795426497536.gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 11:24:03 -0800
Message-ID: <xmqqik1n5p2k.fsf@gitster.g>
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

"Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: GontuSujithReddy <gontusujith2009@gmail.com>
>
> Amending a commit normally preserves its original author date. Mention
> that --date=now sets the author date to the current time when amending.
>
> Signed-off-by: GontuSujithReddy <gontusujith2009@gmail.com>
> ---

Your message identifies you as "Gontu Sujith Reddy" (before the "via
GitGitGadget" comment) on the mail envelope Sender: header, and if that
is how your name is usually spelled, we would prefer to have the name
with the same spelling on the in-body "From:" line and also on your
sign-off, not squashed into a single long word.

>     git-commit: document --date=now for amended commits

You do not have to write what you wrote elsewhere here.  The space under
the three dashes is to communicate what should not be recorded in the
commit log message for "git log" readers in the longer term but is
relevant and helpful for reviewers to know while reviewing the patch.

I am mildly against this update.

Whether you are creating a new commit or amending an existing commit,
the option overrides the author date.  Singling out "When amending a
commit" in the description of the --date option gives an impression
that it is the primary purpose of the option, which is not the case.

Preserving the author date is what the description of --amend should
mention, and if it does not already, there is a patch opportunity for
you to improve the documentation ;-).  And in the context of that
description, it may be a good idea to mention that the user could
override it with --date when they have a good reason to do so.

But the author date is not the only thing that "git commit --amend"
preserves (the author identity is also preserved when you are amending
somebody else's commit).  For that reason, it would be a good idea to
mention the --reset-author option as well when you bring up the --date
option there.



> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2502%2FGontuSujithReddy%2Fdoc-commit-date-now-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2502/GontuSujithReddy/doc-commit-date-now-v1
> Pull-Request: https://github.com/git/git/pull/2502
>
>  Documentation/git-commit.adoc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
> index 8329c1034b..ba0d5aeb8f 100644
> --- a/Documentation/git-commit.adoc
> +++ b/Documentation/git-commit.adoc
> @@ -182,6 +182,8 @@ See linkgit:git-rebase[1] for details.
>  
>  `--date=<date>`::
>  	Override the author date used in the commit.
> +	When amending a commit, use `--date=now` to set the author date
> +	to the current time.
>  
>  `-m <msg>`::
>  `--message=<msg>`::
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
