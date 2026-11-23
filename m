Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451045;
	b=IFo22D3q5nBvGB+2y8eppqXb5Mla+Q7QwvFnPtjgiphQ2ty+5f/D5RDA27Sz1qZAuD+t
	 dfjMP8wMkXvIgLE/SsUW0A+/bZLnpc4p44kpMRrqE96h9kIaH3K2f5osD7o1BdNBfRdiT
	 B3MMaZxcWhi/3ESo94QDhG9WG6C8UrlbqcP7HfQXuibonPZYCA+IcfOcmfvpUY36Ud+Lp
	 X79PG+pmdY/asJ6omFpOQx5cf4WzGT1RLtxa7voUkZMIlZc5OPP6o7gtcWa3MnCAbMder
	 Z6IsvhrmKeuI8Wpng3RHKE/M+T1aH1rfgxqqUj+ts+vFX80Lr68NLSZNzFpKTXOGh+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451045;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6zdIjedGUK17wEpJQw+G+HrUvXUboiwC4v3+iR8mzog=;
	b=n+B4Usq54W+xgRWqnOkikiADac/mIRK3zyC/BSabOZwLjUStF1c6h6laxyLl11qwRxio
	 mOSq0ICLtT/OntrCS7Y0fwi97m15cZeNQJbV7geuoqy4+PNuDvkrPIjuJHEpDrHiktEf5
	 Md3dnHe6HcYB7CuOoo0nnwAR0+JvU9+ESJ2kFNWjRBMCF20TkhelrtKIF3uvIwMUMZHs3
	 fDZrzvluvzN2hV5Zwz28MgQFhqxWpbSHBzlDgaNVyx1A4yv4BysOIFQBIL/kejk34NqCN
	 zyUG8zu7y9PbYoXXOzkqsBws3Q3aweGKdqYxwjHDdXFRLv3Vo9hFq79A/mwsuUP4umw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MB4K3bED;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tRfBpDKA;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59688606A338
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59688606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MB4K3bED;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tRfBpDKA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CC36EC0C61
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:24:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 11:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795451044; x=1795537444; bh=6zdIjedGUK
	17wEpJQw+G+HrUvXUboiwC4v3+iR8mzog=; b=MB4K3bEDLVnHqVeUy8ZxGdjbFA
	aZECtDwrL6k/4SjA+RIiRFalaMyuz5h0oNGVqhHKWfCSLr3BNyYBnN+Y6tX2TlPt
	cAKK2tUmvnz04jtMO2wT8yrN3GrjeLeNoDokkkvP11xWKXKNvQhpBHNzP0wrptap
	7c7F3sH7TZLuiT/j5xyydglMuAyZtcYUPDnknr2kmbCUVhCNU+jxblH1Nhzwo+HQ
	PL0JjXhmW7TmuxRDXA1mZh3z5FNQtw1kKkyRgmN4RXUfXnottR2pePXJHSdFI5i8
	BRZTOeR89WW7enzq4SRw7OmGtFcxfpXhAb1KWtJZn1AYSn8drnq5KvukGgwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795451044; x=1795537444; bh=6zdIjedGUK17wEpJQw+G+HrUvXUboiwC4v3
	+iR8mzog=; b=tRfBpDKAVTcZrCHoKiHTFHW+pOIs3uKHLbSPN+vEfOAazUgx3C4
	4uvaULf+wSUzBzO1fQBzMacjUJEPLb+s3d4jpSWuCfCoKNz7vQW7qKj/tqXz2OYr
	NqqFLStB3kf6raBy8Ig5e9N7JdcR6dzE/sh3yrXLPP98/Wgdl0vl+ZLk9dwmYleO
	2x7WeZk5BnVKkQYlwzovhBzC1aZRfgDN4+zyNyKTUrhFYyd/x03cn7QF8KL3xyda
	+xNBStLP1MRuMTIzQAA5+p46+YKaET8m6tOTW5ze7q3ATGWK28JKawryR4LYujDZ
	YKM2L8IHnFZHdPaPnOLOc0K7U3Mc0+tssDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795451044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:P907ZvSSbG9tIwMhXtYXjnHwba1oCQqqoQ4xHWAyTINXROW
	kzV+MqZZMBpep2s+p1AzHFudnjAQOPoTKE4U4ONiZwwMi7ffWAaaM74aiLC/Mhkj
	n1xIgwLqlNexeeJKu3OHJXcPgJ/YHmMsN+3rIEpX+6sGuhELmzMapdz6Yc4+QVw3
	v4GP9ZIAeCRkJw/pgkxkcdVGffHfXImRpNujQtdzMzpI+YLV9Urae+xpuy+rlUoB
	ANHUHgFBjRoZ93vhKvm/ipqXjXIC5A314O67kkdFTowvv1zuaWyDTyz5M1+r1wzf
	QF6oWrA6AEm9Qr/bRZm2PHMYa69Qmx86KYPrxVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:z1Qn8dn1//78po25d6RKI73bUJ84HYpWgBvh6vTvNtQ=:9LeRECkDE6t2Mn9MxWCUdmxmSMyni1qNgsrGWOke7tc=;
X-ME-Sender: <xms:pGgEa3PrvN8uy8opVv3bc5kmKNM0xDGC-cWgkJA1kma_NfsKHG2kBw>
    <xme:pGgEa5aJz3jspc4Hs2bXoC5s65acxjbu-Wtj_Z-4lXsHyvfa4p--5Rky5-fI7vTG0
    P4e2tZ94WQpalZLJdmPALVPCKpHcPW0ELDHEYExAOL61vDBRmBK-xo>
X-ME-Received: <xmr:pGgEazphwASJEit95W1bfxj3dH-z3Qes8EE2f6QKYG57UvVPEl1laL-oemmtTwjJkN4EbfS1t0qdi6gGNTDPUZDWsmxmi9rym3ThS0I>
X-ME-Proxy-Cause: dmFkZTGmk7esZFh5/z65ebAU/5Mgl4e7cBlddPKKj/3NUUkFZqjPQGlqzQcQuBgFLHJKYG
    695kWe23BuX7TjGoa7ImtWGNmiCrT305ySuhGmuo8wNK+N3qq/A2btz1+Z2ZQbv09a2oT/
    uFNr5gxUqAMRwjiuBtZaxPAwdSNcy2kuqJW8pU0eqjkp59UGmXdJkelFYOR/4/URdoZLJP
    3yyKZOcfr8mdopzTybjnnusCmOR8i2VCCWyoUWAutRzHVqTz78P0TKyd6VS5IlWmWCp8Po
    TEHg/sTGJb5rAyaCclA4pAVsJfvQlaS0PMwbzrzyMsMcG9ymq7rBLbpia5hPkLlT8pUyRk
    VvYkY27gXmLMfLtr8BmQ0MAN0okO4tFOIwKYysvQDvgohKJkocbwSfii92Rv+76QDKJMnj
    bz5Aczr5VJgVuL4/kXmYeg9pHdMWz9283NwOiH34vW5261ud0X7NKptyUP0FUfPkZsXDW5
    ivgqSMROicElDd5DMdMIFnBdP9vbRN/bAbHIfHHJbbN5vIuF9fiCzkp+yqtf+2f3ukdAKK
    EwCa9BXIcU+ivzC0vHXvVFvaQt2eeje2Kmnx/IaQePI+lgLZ2uCUT4BJ5hOYwWTSESghqu
    J6Xd5/fCHKspCS1MMOZjxaEnXsGJEf/t+qigg9Z7Zps2mnuZDtVRJXxaxBwA
X-ME-Proxy: <xmx:pGgEa1YFhrOrWYrfn1R1mGyW_PUW_JU-jwOVVqqDzZxQSvITWP1sZg>
    <xmx:pGgEazQFhcIzm6dCfTFUKvFgFj2v0HQilDVoqybp9Rsj3UCPRJVhUA>
    <xmx:pGgEa05w0UPn3ABl-o2PllKaHLE3xuFFvp0FeKGgw37JAhqF6gBizg>
    <xmx:pGgEawzvzaTP3dAlndyDUlF8CMF1pkgstwzb9IaKRkvOVGP-9EpJBA>
    <xmx:pGgEa6FnXmK6-SZfl49nKPbM08kuPDpo2kX939NaIbcH9-I0SFXkr2or>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 11:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] docs: indicate clearly that http.extraheader is not
 for creds
In-Reply-To: <20261123011744.723147-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 23 Nov 2026 01:17:44 +0000")
References: <20261121222723.23714-1-sandals@crustytoothpaste.net>
	<20261123011744.723147-1-sandals@crustytoothpaste.net>
Date: Mon, 23 Nov 2026 08:24:02 -0800
Message-ID: <xmqq5wxnbjod.fsf@gitster.g>
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

> People frequently use http.extraheader for credentials, but it is not

Use camelCase `http.extraHeader` here, to match config/http.adoc and
what git.adoc used to say before you removed its mention.

> intended for that and is easy to misuse.  People using it for
> credentials often do not use the URL-qualified option, exposing their
> credentials to every server Git connects to, or they specify it on the
> command line or in the config file, potentially exposing it to other
> users or to anyone who accesses the repo, respectively.
>
> It's also known that using http.extraheader for the Authorization header

Ditto.

> breaks some uses of Git LFS, where some parts of the protocol can
> include their own Authorization header.  This is because that tool does
> as Git does and always adds the header, leaving two Authorization
> headers which breaks authentication.  However, using a credential helper
> works fine, since Git LFS only calls the credential helper if it doesn't
> have credentials.
>
> Indicate clearly that http.extraheader should not be used for

Ditto.

> credentials now that we have more robust credential helper support.
> Remove text that suggests it might have sensitive information in it,
> since it should not.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> ...
> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 792a71b413..d61180c909 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -111,6 +111,14 @@ http.extraHeader::
>  	more than one such entry exists, all of them are added as extra
>  	headers.  To allow overriding the settings inherited from the system
>  	config, an empty value will reset the extra headers to the empty list.
> ++
> +Note that this option should not be used to pass credentials and using it for
> +that purpose may cause security issues.  Using this option for the
> +Authorization header can also break some external tools.

Do we want the word in monospaced backquotes `Authorization`?

> ++
> +A credential helper is almost always more secure and does not impact external
> +tools negatively; note that modern credential helpers can implement any
> +reasonable method of authentication, including Bearer.

Do we want to linkgit:gitcredentials[7] somewhere, like the entry for
http.proxy does?

> diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
> index b26e4e3a09..5bc33f7e26 100644
> --- a/Documentation/gitfaq.adoc
> +++ b/Documentation/gitfaq.adoc
> @@ -120,7 +120,8 @@ them for a certain period of time.
>  You can also just enter your password when prompted.  While it is possible to
>  place the password (which must be percent-encoded) in the URL, this is not
>  particularly secure and can lead to accidental exposure of credentials, so it is
> -not recommended.
> +not recommended.  For similar reasons, we don't recommend using the
> +`http.extraheader` option for credentials, either.

Ditto on camelCase `http.extraHeader`.

