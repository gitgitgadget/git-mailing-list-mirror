Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629461;
	b=gMGnPUN9gM1rRsrYVcYMRr2D1YjRrkhgQDsbPg+O1RPOJ5nFnKcSuROwRbYnxshj3uEB
	 2GcTygkmnRpGwhP/RDLiK1SMYxzX7ae40hoirSSoNvJ832wAy+MiZUPBFEHOeo+g7LdNu
	 a9ZR2lttpC0r5VflhcG5KpnT0vBg7QU935wJOBvOsPt/hXxR51yIP5LWVFYHMihHimLVO
	 yoXNdNKQZELfaZfB22n50OLyGIdwpus6+ZnGRHY7A9ByJtFm66Pmq/ezyK8xEyeb3soYI
	 E8IuNeFcEAgiOIlvyQS2hTj0KSAvFbSIKUFyqrqWhFEpwVKsaUklp30bnjPh/ehZn6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eIM22DkMZd/3+Xc+Cfaod6yN1hI11eBwd6XjVIAQpYA=;
	b=0j7Wzh00EQ/7Ja5a7wwd5mkyp4lioUyWtG1u71piVDvd0HMffpgiMVaOvdLkjpOT82da
	 YVcoarF3j4NhkfvmtEqTh2OnMBRkc92Qw7KW4/Ga/hAp9ON88Xgn4Tfw1i/zD6ETql1Gm
	 UrUIwzNH2beTjNmBm2mZW5PqBrilGpO8GWVaZhDA+9pWcFsGGPgvyN/qffwGzYquFSXus
	 uDvUhtDPgDKnL6YcjgfECiCACKOugId+6mz3XVgVBxw2u9ypG0zp3Q15smTFSskCdtIkp
	 QZC5mbvJCCTMFDNRBpXytn1ce1yM/YaDriI8UOlJO67dxF46uKbcF0t8WUJuz9Q4H7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="ONF/+NPo";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A7Z7BjVQ;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEE606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FEE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ONF/+NPo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A7Z7BjVQ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2E2A1400346
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:57:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 12:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795629459; x=1795715859; bh=eIM22DkMZd
	/3+Xc+Cfaod6yN1hI11eBwd6XjVIAQpYA=; b=ONF/+NPo4oaroau5t83RWeYWSb
	4pUWsj58GgvhG4fSSKezqu8cQTBlti2MmGE3UWcX99JUWm07f8L5G9T2yIWFOyBP
	DxX2DHnGFidmcqDiE2DW7xtO8hNMDL0qs/yl/nEViKX+RKcKDeRH/jzzenwEp8ww
	MLGlFg+zuqBTGGQEgk5YJRYfIMrsds6l+QnEsZaClT4VSUMTX8PaHr/PO29oT26w
	aiP+nr20GiBW6+hc9w73qhyQOKz+LMjlNCOsgtu9yvRL7FK62ZlnPTEc5FVG8cnT
	V9mxSXDCVVRnq5h5kwTA88odLuthpTT37xqA8NSeHRgW5xzU3nuYvOF+2Jew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795629459; x=1795715859; bh=eIM22DkMZd/3+Xc+Cfaod6yN1hI11eBwd6X
	jVIAQpYA=; b=A7Z7BjVQ37lxcDnvE/BndrVojpDLZ7/zjxx8zM1R3usMQswkqd5
	rDaJWzH0iAvFMzURGopmlh0Zcv7CT9cKuuMZxwqROKlTa5+LGDfpW50siBy9Al1Y
	0kfjHwHTnUEkrv7vSj5OKB0cXqrD0tik43iGSQSZe3babidvOxBnMy+QtcSTHH7d
	K8ZPwaeBYuEQxTbNPH5yNV6u/mGDTRdAc6OMyhEcH1g+hf3n+KlqaKJ9OY6zK46C
	CFjwCvWBpaiMJvbmsvj088TMT+r/UKp6KHq7q3Nuj+pC9EmOtvvHf9+g2lRbhVDn
	Rsgm6HZWMHb2YqEr6zsrEGvmw4+oJoqgPIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795629459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mbZHsl78IWsPKhem+X9VwrCpX8IzskEUcvl0RBWVdrCpw9U
	HX57NxtQMGu8KZwrvAnUw7g007LmQnkF3vA7WPqLBFeb00CnkM6/3pDUpKYUjKq0
	V8FZdxoEUOvsExM356bzFETKQQ93tIJVJdGySkCVXK1FpdqTS++Qu0bWs099bh5k
	shK54fD/TW0LtyIMp8qBfis7LQPRVJ9uhwvqdQpFYCTmticrViVh4tzkXZSYVkg6
	dkPQF0R+okoEYwlnqe47YA8QflvpfCdzyUBMOGBBqaV8lvvJMgNziIGNIDHnMjAm
	ruEu3wMDnAFIMfYMr4ItM9vD2UQDBoCF3haAy6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XWihvUkKx3EdhdW7bnp5qd6ltyn7xwg0vrx4RQGLSZs=:GE8pvnh6IcEDVaeLVmxdtDcZH9OjyV0++3Yz0buoAfY=;
X-ME-Sender: <xms:kyEHaz35fB4nPnBVpFrZaM7YwOi77wTLRxsBa_83AVZJnWpXumaUAQ>
    <xme:kyEHaxLox3tlJvECgN2UT8W5S5L6OR2lA3_LgxrbRJhN9xfUC66vSVOg8c42SODS3
    qwuimT3sqRaECBDngYuw5JKlfCCb4-NqwNO5kTF7Jn9G44ZgC_Tgzo>
X-ME-Received: <xmr:kyEHa6G5wm4M_2GX8YUIyfhVEEhnP9S6JToYFmpkbJ5Tti_pYS1FZnTnjzeNy_KUFJf4VRfW5gG0bYdjB525gyA9bImtxCqBX1gem_o>
X-ME-Proxy-Cause: dmFkZTFIjNfeurg4LXioFJarOVkXuxvdJ0/wLRiL6IFILeSU5KpfmX/J1ReSO+yTRf4H53
    AkEeDvNGLBthefpbrCos/eA4K2B2mGFRyw6CEwpv0yuW0dwKpbQV5ce9Ugg1hbidzJ60R5
    JxqeU/CezNsQ79moHLfZYEuo/n+Z+8/6h075zX9RRUD070eBUzr4h9L+9k9Ku9cVnDRsjk
    pYeeyrmwEcgKoqK6LKHwINZgKIJG1xizY/hoDjLU4uQntCzYrRTmQVVPnQinK1fGEbaZ6u
    FbmQayPKq/fr+B1J9xC8vMTJv8fTj32WMSUemmBP3BP0r0Id6lN1QXs/WHjWATdOE06HCv
    3H08heeIrSjuYxaBgMktDt2r0zDAa1q+iWYiVVC5CP1YA/KioPXZ1HL3wYwAkAWHRaQvQq
    mWdh7f2WzxiK8FsUxfdrmc6VUsChsE5FkA4Mqz6m7NJdn34KIU67VFmXqWGnXXg+mvOS+g
    PTCARkHiQINsVUhmu//AcwRyORTEOFPQNAspji8na4D3JOGQIsCjLl//edREK545mXTHgn
    uRnZZ/E/9qwybslweQC9f2r95T0+8szuP9YPP6cE79tOKIxDrqxiOLuPlmlGXatiLyWbDf
    jAzP3NvWZmnpJInjzneLtg5C3umlY7S6CsUjYvluh1TmUGhHTtjH0iZ8tTZQ
X-ME-Proxy: <xmx:kyEHa1XNBE9PYJJVGtmrV_lt8jwXmHLuWpDX9dbRQ3WPj6WoWzevqw>
    <xmx:kyEHa6xZIB6A70Nyw0_yTQ2EaLM8s8_spp3Rt-aTVs0PblBa8_5Jzw>
    <xmx:kyEHayS0npdgAkYfVvwRN2PjF69AUwXqg46jNu1pgoqP8OekCXFbvQ>
    <xmx:kyEHa-hbXvBcIV-gHpqcx5ZBeJtp2bxN_sXst65OdI5RarYIgSEojg>
    <xmx:kyEHa3Gr-F86h5CcMzXCOFIdBs53y6c2iqoLUAhyZx7wKXZ1iuMCmGpj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:57:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Julian
 Maurin <julian.maurin.dev+github@proton.me>,  Julian Maurin
 <julian.maurin.dev@proton.me>
Subject: Re: [PATCH] remote-curl: honor --no-thin when pushing
In-Reply-To: <pull.2328.git.1795595886592.gitgitgadget@gmail.com> (Julian
	Maurin via GitGitGadget's message of "Wed, 25 Nov 2026 08:38:06
	+0000")
References: <pull.2328.git.1795595886592.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 09:57:38 -0800
Message-ID: <xmqqbj7c6bfx.fsf@gitster.g>
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

"Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julian Maurin <julian.maurin.dev@proton.me>
>
> "git push --no-thin" to a smart HTTP remote still sends a thin pack.
> transport-helper.c does not forward the "thin" option to remote
> helpers, and remote-curl always runs send-pack with --thin.
>
> "thin" was left out of the forwarded options of ef08ef9ea0
> (remote-helpers: Support custom transport options, 2009-10-30) after
> review noted that --no-thin did nothing on any transport at the time.
> f7c815c3ee (push: respect --no-thin, 2013-08-12) made it work again,
> but only for the native transports.
>
> Forward "thin" to helpers and teach remote-curl to honor it. A helper
> that does not know the option answers "unsupported", which push
> ignores, so it keeps working as before.
>
> Signed-off-by: Julian Maurin <julian.maurin.dev@proton.me>
> ---

Sounds like a clean fix.

>    I ran into this in production, pushing from a shallow, treeless partial
>    clone (--filter=tree:0) to an HTTPS remote. In a shallow repository a
>    thin push reads the tree of every advertised tip it has locally, and
>    each missing tree is lazily fetched from the promisor remote, one fetch
>    per tree. --no-thin avoids that work, but has no effect over HTTP.

Some of the supporting materials under the three-dash line, like the use
case that benefits from avoiding lazy tree fetches from a shallow,
treeless partial clone, make the motivation very clear, and may want to
be included in the commit log message, perhaps in a bit more condensed
form?  Here is my attempt.

    If one pushes from a shallow, treeless partial clone
    (--filter=tree:0) to an HTTPS remote, a thin push lazily fetches
    every advertised tip's missing tree from the promisor one by one,
    and --no-thin has no effect over HTTP to avoid it.

> diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
> index 39cdece16e..8203ef497c 100644
> --- a/Documentation/gitremote-helpers.adoc
> +++ b/Documentation/gitremote-helpers.adoc
> @@ -542,6 +542,10 @@ set by Git if the remote helper has the 'option' capability.
>  	transaction.  If successful, all refs will be updated, or none will.  If the
>  	remote side does not support this capability, the push will fail.
>  
> +'option thin' {'true'|'false'}::
> +	When pushing, request the helper to send a thin pack (see
> +	`--thin` in linkgit:git-pack-objects[1]).
> +
>  'option object-format true'::
>  	Indicate that the caller wants hash algorithm information
>  	to be passed back from the remote.  This mode is used when fetching
> diff --git a/remote-curl.c b/remote-curl.c
> index 2c35dd5240..8309d9d2a4 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -184,6 +184,14 @@ static int set_option(const char *name, size_t namelen, const char *value)
>  		else
>  			return -1;
>  		return 0;
> +	} else if (!strncmp(name, TRANS_OPT_THIN, namelen)) {
> +		if (!strcmp(value, "true"))
> +			options.thin = 1;
> +		else if (!strcmp(value, "false"))
> +			options.thin = 0;
> +		else
> +			return -1;
> +		return 0;

The above two hunks match with each other, naturally.

In remote-curl.c:cmd_main(), '.thin' of 'options' defaults to 1 (side
note: I didn't know that ;-)), and push_git() passes "--thin" to send-pack
only when '.thin' is set.  Honoring 'true' and 'false' here while
returning -1 for invalid values matches the surrounding boolean options
in set_option().

It is an unrelated tangent, but the use of strncmp() with namelen means
set_option("t", 1, "true") would allow setting 'thin' to 'true'.  Git
internally always sends the full option name, so it does not cause any
problem in practice, and it certainly is the right thing for this patch
to do to imitate the surrounding code.  But we may want to take another
look at these uses of strncmp() when the dust settles (#leftoverbits).

> diff --git a/transport-helper.c b/transport-helper.c
> index d5a064d386..6052407b9a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -275,7 +275,6 @@ static int disconnect_helper(struct transport *transport)
>  static const char *unsupported_options[] = {
>  	TRANS_OPT_UPLOADPACK,
>  	TRANS_OPT_RECEIVEPACK,
> -	TRANS_OPT_THIN,
>  	TRANS_OPT_KEEP
>  	};

Running 'git grep TRANS_OPT_THIN' tells me that builtin/push.c is the
only thing that sets TRANS_OPT_THIN via transport_set_option().  We used
to claim that this was unsupported, but when push asks to use it, we now
pass it through.

set_helper_option() notices that the boolean_options[] array still has
this token, and sets 'option thin true' or 'option thin false' depending
on the value and calls strbuf_set_helper_option() to send it out.

It is a bit surprising that there is absolutely nothing else that needs
to be added to support the option, but given that this was about
resurrecting a feature that already exists but was left castrated due to
a historical mistake, it is an understandable confusion on the reader's
side ;-)

Looking good.

Thanks.
