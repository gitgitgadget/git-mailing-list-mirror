Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105586;
	b=W2WIBEHvGg5tyJCvKFxSQ8G4wWjb7Stbz1+5OYgI1L9Qa/79uaG8EByb0pk9pIkKo/kY
	 jWsqaRZyS+Ly56YxPhjFVOpz3GA/kJhbQKtElktZwpHlVTyaZ3r71OFz6KLttqTpl2SUN
	 U2zEwLIjeotaTiErOnQw3i2MIobI/kEjgjsn/c//ZiDOBKEp35xCSWIGlo9g0ohn0jZrs
	 rnSHcFg+2sU2/NS99oAUuecEVLvliDijNTXCZpT1iqqxTrETU2DPv6f1QpiPIqXBKe+vH
	 5AdkW6VGY+bIsb62WO3y2UYv6n8A6r+KlbHQ8OK7NfRNtu8KBZYEpGTZj1RCOgNYNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105586;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mZGuQ7g1ZGI9oQ8vZl98lnlOWCe7DKVs1K4xXAb4dBA=;
	b=RomA9sLv+vagKhonXn9GK5rTzKoAUi7RNPHXbPdmvpfM5567gzhsJUjX70rWNg1zaLUt
	 BmFk6rzi0Uk/v6O2YzfRwpSO2H5tedTEIPm11DSvFVsGIABpuy03A3WKgUmLFokMpmya2
	 5873ylAqMECNb2+ez3gzwYoBmFiG+rZ/TthQae22+yJljqGijt+VdVYcZUTF3GrTuo3xT
	 CG42GiO14gtR5HGUPidqORvhtpJ4vScWEE5kRFm4pdeeMEia70DBcJWO1NY69G/aC2UX3
	 s6ncbv6dVNrsmiqATHnByxA6ICrdE/OP7EARmTHIySKt1O5skZzcUyCaUrgldq1jPRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IbrG+xOT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dx9E357J;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFD606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 16:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABFD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IbrG+xOT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dx9E357J
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78F8F7A0317
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:26:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 19 Nov 2026 11:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795105585; x=1795191985; bh=mZGuQ7g1ZG
	I9oQ8vZl98lnlOWCe7DKVs1K4xXAb4dBA=; b=IbrG+xOTPo3NZLRsZ9dSJssPDp
	D2PqbGB2xMTbNH/FJffWpDmNRO9CeSWIUT10WfEkGIuSUeBEWPBUppEr172BfIBA
	ytCNnQHgh+zSOjHFIur8HdhHETrCGURrzbIgyV7GcMIJoQTK6OZevL5PQbK64cEP
	YAmzcDla0FbWzslQNvvuJYRpgfm7icbfqM65iieur3qjxWijIijkI/jFovBkefWg
	UBpPBBRTIL2YxKqZKGkZKVBKDR2JkGI6rGysfS/8IQOoWZ5gZ27t6tNM6lGxT033
	IdO3Vj4aCTxhaDzrSk8VwJUclMl9JUTMYJeLvs3z68Fiijpib19USHV8wV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795105585; x=1795191985; bh=mZGuQ7g1ZGI9oQ8vZl98lnlOWCe7DKVs1K4
	xXAb4dBA=; b=Dx9E357JJeIn4IoFiIUWJejBSHeSovocJDli52v+Nc+4L/xcLNr
	lHIeeG5aTLwJbKQFosjhyq4mpsaU1ihpE8hf0CEM3zBMsJOcrASZ/azHC5siX914
	hIZO4j951Aa5lGz9PkVduI6pPvqKfV4wa/P5lgIUORn2lwH97ZFVPRkm1Vnu58ee
	a3z/J5yy/bGxFdh6vyg480Xzp/hlsHafh63hMKhNdfW2mjvEFfLboUOrydaBAhUe
	y1nto2skGXkXg4QamPMXIFrdnjOz9oP8t8VPOV2x36baBzgIowVQOVZ48KJP76h5
	KFCumtvItQSB3elR7bPK8gOUqrRuzH6f98w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795105585; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DJcLrJw5JxojGs4kpE8biVlgHU6eVbRMWud4QozdN+ivZ1Z
	t2MwMWOO6MCvMAyiHvrFPx8Xq3ypyqvw0nKoXKUnkmgOHwnZlM9PC2v7DyIMs8dG
	rpM6/Oda9hmkkh5HamDmiX1PAGdDIgaQrloDRIOuaOZNoMwMWMRyQJYnVhXgDNcd
	RT6OWpTs9qRGJGfQZTJQKJkV0H6Kgcl7kxmvRumPQVhBHoo8iycIISIuTRjUVVFC
	jHjg4PQEUX/RjJxnon9ztIAkEIpMKHzTRUfgBG/GuReXMJHWl/hCjUKvwen9fnMR
	tnipq6tYM7vEg7g5mr8RBFFSTjiwHk5d+OR5X9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cXbel/I2hRBvqbqpjg3eoULc97qQO9DI5vOHNDoKUo8=:mFQIb8vgzRTa4Qv3qSvZk2NCY0Ie6Kg1qPIO6uC/hng=;
X-ME-Sender: <xms:MCP_apfCbQkh6l0cz2Zi-JszIp95gmdo2F8aTInl1VSpZnjat3Rbig>
    <xme:MCP_auFq8BD7VztHgXrT6ezRDyN5G2tQocMg2wjXFJ5wk9ZLzWHRepv6TjFgpPEaA
    IBUcfTgukRnmG4opfkKwnSIGJxnKmCUb1ABKtmo6_yQPLfyNGRR6Hc>
X-ME-Received: <xmr:MCP_aq064n6QDEligPPBSZHCThl5OREB3z9UIflpkrfpQTxM-GesXnoLcuLgnDET2fdVAXaQp-BdFFXq9J9uMFDFAkBV28m0mq-8>
X-ME-Proxy-Cause: dmFkZTEob6F9XTlLt6muxOgbEY2mm9e3L2M1ZLpTgvLFngauY9lxaTNcvjZdTQbw2M8U35
    WXDapB+0JgVJ7DKWaXYYD7NPUh3qoCpz0qcXegv6Zk+OblnUW8kh+slFjq25/S7vKfyf3L
    5EdNVbH3YL2u6Qr8cJ8WNefipmtsf/cQeCgFm/LM4no/mzbgw8QhGQU/JRjY/BP0XmITlg
    +Y54a/quC029jhMlU7TPzyV6xpANer9nQns6UKl5qaKF5i071LNKeRa4z88e9URngybxBj
    E1EPXFT2j92tRAgE3JEvWsMNCGaDA+Uh09/TugAljcoEOxYcnY5UDD4YgJRo6PoUbNAwjK
    j7TsR6smmbXwrU3QOg1zDqLCgb8ta/ezFIEriOlLwfzQofe6lJVOc2PlB9MWisUJk1AtDa
    knDYQ4pB0Kxt7hSvBXCECvCQe88YNUkSgXks0oA+v+5Zu7UDaYdkVFiyRfxTzHr7iHWgtU
    Mk2+F+DnfIm6TC0lti0eIt5gBgx3mc+P6ldIUna/bFVzKoDKv3Qm7+KC8y2Dp3YMe7NQNa
    AG5YUhQ60ftCvtXS/O7SLLPbntOUA7gnG+YX3C8r0vpvv8YcMrcj7L/IfnJfndq4lp/b4d
    YhumkXYUw2IS4VuoX7F+I1owAfoEEEk0mq5s/DFNjc2aCg4H8jRKPZb1a4tg
X-ME-Proxy: <xmx:MCP_aumTJ-p3McJCN__z0CX37vNvoiotIsbgaIUU4jlPBqFWl0G11w>
    <xmx:MCP_ai8Nn9_oqH4pOr1nM8wcLvQrSogaUNxcR7YBLBJ6onQidlqu1g>
    <xmx:MCP_arow4QkrPrg52Zt5Py6WANPV3g2h9_6_FMGJyi7JTEKCDp9Zcw>
    <xmx:MCP_ajkjWhS1YF6S-dzRKY4smBa_hq1LKMS5FrUKh811q1V3IPghNA>
    <xmx:MSP_anU3kIb-aeFm0GHhz40aBRfptK0wwsBikkf8Ja5QWkLHDfn6Mtpy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:26:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v3] setup: fix hash algorithm detection
In-Reply-To: <20261119010612.687733-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 19 Nov 2026 01:06:12 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261119010612.687733-1-sandals@crustytoothpaste.net>
Date: Thu, 19 Nov 2026 08:26:22 -0800
Message-ID: <xmqqse0wzt1t.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 9e57a06cea..d89f60bab9 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -516,6 +516,17 @@ test_expect_success 're-init from a linked worktree' '
>  	)
>  '
>  
> +test_expect_success 'git init uses default object format' '
> +	test_when_finished "rm -rf repo" &&
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init repo &&

In this subshell, we discard GIT_DEFAULT_HASH that was set up by
t/test-lib.sh (either from the GIT_TEST_DEFAULT_HASH exported by
the CI framework or from the GIT_TEST_BUILTIN_HASH to match the
running binary).  "git init repo" will create a repository using
the binary built-in default.

> +		echo "$GIT_TEST_BUILTIN_HASH" >expect &&
> +		git -C repo rev-parse --show-object-format >actual &&

And we have to see the same TEST_BUILTIN_HASH as the result.

> +		test_cmp expect actual
> +	)
> +'

Very good.

> +test_expect_success 'init refuses to reinitialize with different hash' '
> +	test_when_finished "rm -rf repo" &&
> +	sane_unset GIT_DEFAULT_HASH &&

Here, we permanently discard GIT_DEFAULT_HASH from t/test-lib.sh
without saving what it was.  Would it cause issues to later tests
that we do not see in post context of this patch?

> +	for algo in sha1 sha256
> +	do
> +		if test "$algo" = sha1
> +		then
> +			other=sha256
> +		else
> +			other=sha1
> +		fi &&
> +		git init --object-format="$algo" repo &&

We create in one format and then ...

> +		cat >expect <<-EOF &&
> +		fatal: attempt to reinitialize repository with different hash
> +		EOF
> +		test_must_fail git init --object-format="$other" repo 2>err &&

... try reinitializing to the other format.  Expected is a failure
with a message.

> +		test_cmp expect err &&
> +		rm -fr repo || return 1
> +	done
> +'

OK.

> +test_expect_success 're-init does not modify hash from config' '
> +	test_when_finished "rm -rf repo" &&
> +	sane_unset GIT_DEFAULT_HASH &&

Here, we discard GIT_DEFAULT_HASH again, correctly assumig that the
previous one can be skipped.

> +	for algo in sha1 sha256
> +	do
> +		if test "$algo" = sha1
> +		then
> +			other=sha256
> +		else
> +			other=sha1
> +		fi &&
> +		git init --object-format="$algo" repo &&

Again, we create in one format and then ...

> +		test_config_global init.defaultObjectFormat "$other" &&
> +		git init repo &&
> +		echo "$algo" >expect &&

... we do not want the configuration to cause reinitialization to
touch the format.

> +		git -C repo rev-parse --show-object-format >actual &&
> +		test_cmp expect actual &&
> +		rm -fr repo || return 1
> +	done
> +'

Looks good.

>  test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
>  	test_when_finished "rm -rf explicit-v0" &&
>  	git init --object-format=sha256 explicit-v0 &&

My earlier question was about this one.  A format is explicitly
given to this one, so the environment variables would not affect
this particular one, but if we have "git init" in later tests that
used to rely on the GIT_DEFAULT_HASH setting left by t/test-lib.sh
may we get in a trobule?
