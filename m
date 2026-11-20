Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213305;
	b=PPtAJWOS/mqC7zPMj2meLv/MKnHKClV1799XD6gq3eXe65otUPBHg3/U1utFDyRXMBVB
	 ZjS57kJx91YtRDf/X5NpWS0n7hPfqVEcUvCqXVKqJE1GO8HPxOsH+OUFRPpK8gHY0qQbu
	 mBve/Sc9B47KQkER/AynL+3+0rbKyEOWJN6g4H7m4xn1m8dRNQqHlLT9XUIERaeRoQfA4
	 Tc848P6eGv+s1R4kgIALInKoJKaKsqWIg6nEk2YgfVcYo32xcZ8TZTLyZn/tnhAk3D1Ra
	 T2AvYaLM4yt+ci8IBIKusFixaMYkW+D3Lef/yTH7HqI/if4KNRtHS6K9OHCwdrIYOBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213305;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CfEEXOc/8FbYPNQAKAd1EBtXKBYfkQbkyPNpxCXTysE=;
	b=fYkRYppbqdmc+ZkMl+B1EHTIelB05TWUy3xdks6bQxpR56QyC+Bz5qT5G3pRAH5fWH7K
	 azubm8LcxoHPpJWQyvIpD7uUQ1X4fZWFQ3eVFHrJRZARGN/2yynr05A5rLOx2qcyZrm8w
	 L3MWy0H8RfSva4n9COujG7LKD/9m+NPGvcMhByxGPc/QFDsjcUNN5UCNrgTFPdTHx/XC9
	 hkeUI882e4fCb8Gm5p2uonnnWG0iRm5SBzHDuIv4I+wnqa6h/KZoLXXBpCeKZpYtQCeJz
	 GQ66S3QYsf8l4xzR4xBMEPaEk1KXQmhxzSmvGd7787/o1nW71QMViPA1XPVHTs1cDuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AnOac7VW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fNnLjDdU;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9F606A68E
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C9F606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AnOac7VW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fNnLjDdU
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DA0E3EC008B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:21:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 20 Nov 2026 17:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795213296; x=1795299696; bh=CfEEXOc/8F
	bYPNQAKAd1EBtXKBYfkQbkyPNpxCXTysE=; b=AnOac7VWWunUR8G7hrKkhRy9eh
	U3O/hNjjy8S29rRyEAKL7tNwCDMSUgItgsizlRpomM1NfXPTlWKmst2msZfHT17J
	7aF/5dCEkPn9zF+/PUwGr9c6crbIt8dzhp5FmfFTM/sVhAPzifc4FDEuUVmWyt0w
	35UktbaoBVoQvD+8bfV3VgvJe3kt7BZSMn17Oby0fehw8WowYmpM1//xH5P0c2Wy
	BQYXAMCGskheRIFIfwUsmzb8Gt3MKmXfJag0q/3PgXZidO2lCZV5mgYNX45OHsT/
	sTqbe8o1yOi4UIsujK7RbHKqSwYuOxEnPcvtulc3w0yvwNjWlnvZXZVpV/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795213296; x=1795299696; bh=CfEEXOc/8FbYPNQAKAd1EBtXKBYfkQbkyPN
	pxCXTysE=; b=fNnLjDdUTcUtPXPGLLVauTHxCcUESVFwqjwU2EeQQxc5hO+5XBJ
	JhjjIxXaOLMiIU9hpk+RJeFVk3O27iJCce+/Y20JNoX8R0Vr3LeKg2fX9ItQETGB
	KYD6rZg9UvkWdYohkH6C/PMqIsjIN0DkVOUz711HkDrYoUwMC/3HIjourToUcYZl
	ENu+TWlBvnriHq6zoVjf3Xy/zGOYxkjHMfhRKEwfyK7Uhtx3hBcXDWx8mmB1qiGq
	Haq1D7xydCIwO15RYgi5i0KlNClkcJy08u81Z+Kokhtmt9VILrheznKo1WCkpQjk
	/QcmQIfAt8g9As/bR4UiAkGPcUbP7auj8lA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795213296; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RNaly7dZW98XfeFzfhW5aftrvKRdsmCZo20eu3NpOV0xkNz
	4qdVY5qWsxGluZBW/GVH9U7yguV562yFeDpC8XgI4VaMifLoFtjPMihAyZ1b5fMv
	TP+BvJ3n9XurwjQQWPYmTqrchfJMh+aHUxqNPWyvZjj5wzHgBYhKw0sACg1ItCUJ
	F7xtYQw3hoaWxowMwSL+bAb0hiYCbKYyG7sv7t3orWm4sQaIfwLGr/br25WTtvZR
	LsrZp4/B5Oqgfc4vZeHzeNxA/GaePzKUa5Rl4nbenVFlvwDFWu9ZVN7ueXhdsk+j
	XyWhY4F+5HXdpRsJWxMMqnc0FSQ0Gzy2rkSRAvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KXGXQ4TE55UZLr3M+tJG5XgvVBliGM8nPrR79kaWIMk=:aIcE18Hx3xnQ1bPVLBpnWBzE+tc2+Yb5xB9vX92PybU=;
X-ME-Sender: <xms:8McAa6kizNXIRN3-NeHDJ9vcP5Vi508FKlObdvnNYBhLKdsr5VgFmg>
    <xme:8McAa1jZS-g-owT7_We5yyRDW10Vc8PXw3RRe5Sxg5D1GD8yzjSKIiRG-rk-Y1_sU
    o-qG8TQnUjdhmZ-aaqu60rhUW7PMwzmZ0Cz4hxrkqdfb8cHDGpjgA>
X-ME-Received: <xmr:8McAayf1cwPloBDjPcG26xO0kYjj11puDEnQCmRTY51kZTucuMnXHZTzFyk8y8dHqCvj-L0_ziWf6bbGqtt17MIbCM9sIgrfw2CZ>
X-ME-Proxy-Cause: dmFkZTFfguRevL6Sn8TUfPMHsvmDyJKjzVm5LxUKfW4TwFiVUYYkDxqkx8Vgte6rH1x83e
    uVIirf5Qhu/MTG73DjId34TNSABjsF1rvLLPhe2VDtT/sPpzGggwCdgXYQaoN1P6ayYmV4
    HHzKJgcgMMjGz+NQwRkUTee5hBIRGxqcUyV9HbI4tYtopJZ9qoVNHFytWmkL8d7BEhMv2W
    m1X67nwgQVZTHgv24NZDErEYfA2h9lBe5a8jI9jvB1dpTFJnkDIvWNZA6khy7Dyhmif9ag
    b5lZtVWP62rQlo+gacJGmov+ZGpZWEJ80USydS36gXu17L82lfikG6jyqfzKxddi4N1VQa
    qBfC9tdC/3qmlrXgnoUaXivtbsB2j4CEKt4+P4K9YxkM538VGuw83yEm59hn9DX+9+DqbT
    OyE1qACWZajItcb9GAemvUAotMbEU/XG33zbJB9Z64JxEBpCJmtkyjYLPR0dVi7Eca2XTN
    tUYMVrPE4PpmjYZZrTPraLqiqyeprv1xgbEaEYmzFBpJ/lTJfzaVLFS1RIcKtDIe9a1xGX
    44x+qE2axH+/GBASpT/2os/ltoBATWJVhYTZT3+dYQBrbLgTEARK2m8rfR9rHCumeQ2rgD
    3q5B/kFt6+B/2Ws+/p+mmAT2nvxslqSVZLb+3mPPSQApts95z2jZc0afsRyw
X-ME-Proxy: <xmx:8McAa1jbgVx0IbzmxgateP3Zl0a3il1WUwaEBtcKB9uc141EO0LZkQ>
    <xmx:8McAa6xD8fnXeAZpaGXWMXyYuKuMgXRkeWyd4PFt44OuVe78M-pjBg>
    <xmx:8McAaxN3RkgmvPNnd464W4i74f6fsORAa-hymh_XoLZdT8XY04Bvrw>
    <xmx:8McAa7U7iGLaBJUdGasFgun6bQ-Zcr68GzF1j5L9Oh5o3cI1b5w_kA>
    <xmx:8McAa0e0_-d9e6ZUWGqtiiRcW6Rb4RXV5ojASBxcWvflkdOMFC1zMMLo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 17:21:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/3] setup: reject compatObjectFormat == objectFormat
In-Reply-To: <f74a0fd67af600f45bdb7560253c747aab073c65.1794932695.git.adrian.ratiu@collabora.com>
	(Adrian Ratiu's message of "Thu, 19 Nov 2026 16:18:20 +0200")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
	<f74a0fd67af600f45bdb7560253c747aab073c65.1794932695.git.adrian.ratiu@collabora.com>
Date: Fri, 20 Nov 2026 14:21:34 -0800
Message-ID: <xmqqmrr3nnyp.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> When extensions.compatObjectFormat sets the same hash as the repo
> object format, every command in a build with Rust aborts with:
>
>   BUG: repository.c:204: hash_algo and compat_hash_algo match
>
> This includes "git config", so the bad value can't be removed with
> Git. It also happens with no extensions.objectFormat at all, when
> compatObjectFormat is set to the default object format.
>
> Check for this in verify_repository_format(), next to the other
> repo format checks, and return an error instead.
>
> The check runs before any of the Rust-only code. Builds without
> Rust, which so far died because compatObjectFormat requires Rust,
> now get the same error, so the test needs no RUST prereq.

And the condition that triggers this response is not a BUG() but a
repository that is incorrectly configured, so an error message is
much more appropriate.  Makes sense.

> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  setup.c                 |  7 +++++++
>  t/t1302-repo-version.sh | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/setup.c b/setup.c
> index 186815c780..a97280cafe 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -918,6 +918,13 @@ int verify_repository_format(const struct repository_format *format,
>  		return -1;
>  	}
>  
> +	if (format->compat_hash_algo == format->hash_algo) {
> +		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
> +			    "extensions.compatObjectFormat",
> +			    hash_algos[format->hash_algo].name);
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> index 69723b88ff..718dafc95c 100755
> --- a/t/t1302-repo-version.sh
> +++ b/t/t1302-repo-version.sh
> @@ -98,6 +98,20 @@ abort 0 noop-v1
>  allow 1 noop-v1
>  EOF
>  
> +for hash in sha1 sha256
> +do
> +	test_expect_success "compatObjectFormat equal to objectFormat $hash" "
> +		test_when_finished 'rm -rf same' &&
> +		git init --object-format=$hash same &&
> +		git -C same config set core.repositoryformatversion 1 &&
> +		git -C same config set extensions.compatObjectFormat $hash &&
> +		test_must_fail git -C same rev-parse --git-dir 2>err &&
> +		test_grep \"'extensions.compatObjectFormat' is '$hash', the same as the object format\" err &&
> +		git config unset --file=same/.git/config extensions.compatObjectFormat &&
> +		git -C same rev-parse --git-dir
> +	"
> +done
> +
>  test_expect_success 'precious-objects allowed' '
>  	git config core.repositoryFormatVersion 1 &&
>  	git config extensions.preciousObjects 1 &&
