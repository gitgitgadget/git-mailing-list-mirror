Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426053;
	b=FfgyvcRtQSNRlRgtZi2wAz3J82zbarZBs4WqNOjyU6mTSU/VHBbhjqtZF/7ug5jMj4sy
	 sAdXXw03VNxUQlla9L43L/oaKNRo7KMEPo3kO16JpW4NP0gYLIOpZ3Y6VZzjaaxx+5Rgz
	 mt7YpnIpEYo+DzJjcv0BPO2zjtlKu3WRwkzl4vIumCTzSR0HH9jqaQgmzzc9dkRQN0IY4
	 V2W4NOl8LrmnybgvCYzxyszuLqUzHQAxOxOPArV6O4KnyeqV7n3iCNLkuh6T+4CS/r1BR
	 9XZ+jTX7ywj3bqMMazPK+VwtWTSNU29klo4BXnrjf4j4K/90N7Gf+7p1QqyTseYb2LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426053;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=gQQWaeRxs9IbEq9RUIyYM332Oow7dwp/XrDmWSHc86w=;
	b=2+iS82LT5WoH69R19YArh7H+nPkr3S0sItFanooX7ax1eSxf7bVNqJ+1rxq0ANLIRj3O
	 8/F/vrbmXRiQ+S3XUdC3hz2IB8EWPChkcyAzoP70wNg3+tnU2du2A4S390TBwoZZfW2+w
	 axlxgU62db5JTFsPowgjzA3snSP43OnsWwVo5J6Ezhnbly1MrlE3DJFJVhdEb/t3bytme
	 Yuv3lMHBarIq+7dZfSYCCZSU/qUlICH32ZgYYsW6I1i/HdJq9edHlkYr8tJwuTRARZwz8
	 qUj96WlngnNiAjX86eJYFgriDLeD7f9g/7fBevfj5PvMHh02KILIuhgWZkcq4HjBP9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ob17RvoF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YAJFqHNV;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7B607AF1C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D7B607AF1C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ob17RvoF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YAJFqHNV
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D5E2EC00E0
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:07:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792426052; x=1792512452; bh=gQQWaeRxs9
	IbEq9RUIyYM332Oow7dwp/XrDmWSHc86w=; b=Ob17RvoFHCC9vUuu79uRUEsJzZ
	hD1HPsRV6IvLTt1KrOyHIOuEcVCkmiThFdPC+ciEfuBHFtUaYGmnmiIL25REUKW7
	b7gNo8n701oXsF5IA68CWyw5X0q3qK9UyWrE89G8LdUWdEHbSXbMbKhn2rnjbSki
	JfxAsKC09jx/IJ9nTdii9bUZGO1Mgv3O9bTtkflIrZvlf4nq7HosS/SGlnFt07ab
	usSc492kiTeiD36+A5iMI/8ak80yzZMRVOcmB1u1lnYwiYnVQtnNqvvwq6+grWK7
	VZqkYgmO6TDMvqKH2lV8veFwKX7H2R0ZncjXlpOsa8kPdl0r0E9KTzkhw5FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792426052; x=1792512452; bh=gQQWaeRxs9IbEq9RUIyYM332Oow7dwp/XrD
	mWSHc86w=; b=YAJFqHNV3RnGrViWS2Z0Ie3Dj/ZcI6vZReXqg6ZOkgQFvfWxlHL
	B49+0txCMPSr9aDwRxCGWn9n72ir/KN3w54MXgnM21hUEKnnFCfi7XCb1Xw0CR8o
	56LTueajAdrtpbVYjwNPiBcYPyuuFQBWz9WFg3jN+1paMT6G+ZEHmYiKtFnlTZcq
	oAfRnr/Cc0IaoDPjRz773cncgrPHrOx15lEKJaDS3TBQJnnORPr1dgi0QqmXaNYW
	qS9sfYo1wLl25OJeGARNqv1BE9d5DCDAX81h2zPV45Qz4gNsEULwIdaCQz/8oOps
	4hXq7pVQrWuuveIO6CssFHaxLpfWdios1gQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792426052; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kZKtMsnP5ZaiRaOIr1tPqEsDzr/mt9Pf2NNTiOiCTkOjU3S
	R7xRIlAXd109RvwIitqj+KAt0WfxeLG75CMS9GHnioSb6rx7goHz2DgwigEgewJQ
	CGPAKBXxLP9ffpRFIcO9p+t/gFmCJvUozpcaJ1h37O2zjZtfO/nKvTiEK6TOdzvG
	2HOF3gzSNx+DCLA1hy2q7yWaKLkTu+mIpZS3Q6vjH2iDpSW4xKyboYXNgfivlpPt
	PgAOGBqFhjAQymtlJOqKGVT1g8F65IOPXR71VCSGK1Z2VHjwrMYwixhQRKKElZ3L
	tS8qmPIPJveOXmixIB0/tCYIEQa30GQRj8uDqhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mQ0IOPiI7w8fz/uYvSM3AEphoYA1frnZOYaWCqD5a6M=:QQuQvoTEo6DOPP9eQLFcp+tViJb5h6FNM6RpXfB8JTE=;
X-ME-Sender: <xms:REDWarj9Kzab8NE603e1EN545IZi3J4QohSfRqIw9hkbTFbOwMkD6Q>
    <xme:REDWaruYvwMbEbIdmNXxXPS8CEliMCyO7OjeWZN3s8RCzuRY71gZmAcJiQcfO2dTF
    kKbzMT5IxRMBiMmsgeyVRQPssi14LSsfjKbYRRJJGTUmzVscO_Phg>
X-ME-Received: <xmr:REDWak5k8_p5T972HCLY-HEa_eGOKO0oYM3pWzplDBlGFdkJiDvRzsiiBbXxs0cPJjP1hnVVXvUarcXj2GOBjINBg1e10ecKYuoD>
X-ME-Proxy-Cause: dmFkZTFnyAaeeCWI0UE87zH+ztui2+l4vBX1BTazkBjyXM7Vn4Z92OjXed8XkuKxbIBtMV
    dbW9Q4LbMvJkaliaRVJ9i1nSuSDKSlJ03K1P4Udroj1QbjboDeyvqac/BzIaD3/qKcvbGA
    tujOz7OxdKrsDZF25GR0grvZvPsclPQQAeJ8X4QzmkvRzYjHdw7d1xBeB7GoFlwvH1YGvT
    pc7DDOU23U+AJ0yHlTj9GWStWxGAmYC5KRoztp8xdVR1AKbQ9NrohNhQz3St2hxFzEQ48w
    DFhm8pdt+EX7VF+Mrjiec36Q7sMVfzHagctinbTcE8cN14Iv6M2Hc+wRu29sMACXrYm5Eg
    m+EK0IwuZ5oOEhx4vT1kqEsgSN/vVzq5PB6NhxPqZ1jGEz48jrG849SQdTF+PpMnWzJjIk
    3IgV7kLxoLPD4U96ojDcIt2FSoXqVSAeAlW2cabZAtWIPxlnoVj0IAecCTevLVyRJv/3/1
    M7QAY4KIsNld8gqJ/gWQyses+WuyoAsCgbR+p/5TEd1HCJOoVzcRyu75rywDYEt1ArjITA
    jJYdjaD9TUaQzGO6kIUQMqwxJUvox0UaRFP9dmbMVOMUxkMI0S36QCoX6g4Id/bvwdrDnT
    p7fGFHh7ZOgqTCNDkQRxFlSMA1xKea4y/E/a69OxMOe+xJI4ja5K8ddVMWdQ
X-ME-Proxy: <xmx:REDWavM4lYXx1Iy6ARuCHwsE9_GvcBV9plKErlKxjAzCM28euKmp9A>
    <xmx:REDWaqtgLZLRjwEK_eeMhchc7JW9cts66AbSCfjGc5MK8THR78Y-eg>
    <xmx:REDWaqbp__gAKLg5lOXwGKmfYg8epCFFYhDjI8Z26S_F6C1wn6xsLg>
    <xmx:REDWakwW8ld0-HMm6wYmVFw6LhSJC5oTcj5vy2C6uYXuAo-an31JpQ>
    <xmx:REDWaknFVkDG7sUBbWxEd27FHSQpDN_k-SfPAGoUkd_qsuhQGjS3kDH5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 12:07:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt =?utf-8?Q?=C2=A0?= <ps@pks.im>,
  brian m .
 carlson =?utf-8?Q?=C2=A0?= <sandals@crustytoothpaste.net>,  Shardul Natu
 =?utf-8?Q?=C2=A0?=
 <snatu@google.com>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
In-Reply-To: <20261018205305.2634339-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Sun, 18 Oct 2026 21:53:05 +0100")
References: <20261018205305.2634339-1-andy.koppe@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 19 Oct 2026 09:07:30 -0700
Message-ID: <xmqq33u165dp.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> The Makefile assumes that cargo places build artifacts under ./target.
> That assumption breaks if the user has a custom target dir setting, e.g.
> in their ~/.cargo/config.toml file or in the CARGO_TARGET_DIR env var.
> This results in a link error due to failing to find the gitcore library
> built with cargo.
>
> To fix this, pass '--target-dir target' to the cargo commands that build
> gitcore. Add it directly to the recipes rather than to CARGO_ARGS, so
> that it isn't lost if CARGO_ARGS is overridden.
>
> Leave the contrib/libgit-{sys,rs} targets alone, as nothing depends on
> the location of their build output.
>
> The Meson build of gitcore already passes --target-dir explicitly.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The change might make sense, but these areas are touched by other
topics in flight.

Given that they both appear on the same line as $(CARGO_ARGS)
appears, I have to wonder if we want to instead just add a single

    CARGO_ARGS += --target-dir target

somewhere early that are unreleated to these individual rules?

> diff --git a/Makefile b/Makefile
> index c649c93c51..aea99a3639 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3039,7 +3039,7 @@ $(LIB_FILE): $(LIB_OBJS)
>  ifndef NO_RUST
>  ifeq ($(RUST_TARGETS),)
>  $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target
>  else
>  ifneq ($(words $(RUST_TARGETS)),1)
>  ifneq ($(uname_S),Darwin)
> @@ -3049,7 +3049,7 @@ endif
>  
>  RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
>  $(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> -	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target --target $*
>  
>  $(RUST_LIB): $(RUST_MEMBER_LIBS)
>  	$(call mkdir_p_parent_template)
