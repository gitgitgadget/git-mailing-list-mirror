Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803123;
	b=hRNFfzBALryeBkrLssviNDsYzrQLa9OGqlO7v67cTp5Dhe/RCZ0HdTpafl5hhHnqARMx
	 8a3l24/x8hIGm7IUzl8vB9fjtpOM4POlZEN94HC0LAJmVWY+E7QIBsg952j/oHEo3JVC3
	 ow6a/ezMqbMvuyRosBCdvNVVNHPXxWZI6bSYuQ5KMqVGKR48o0rkNMdVcokQt0uXY5sb5
	 ubz2BBzslU3Rwn94O7yIBJs/vqW6z1aDc9fIEDdP3vIMPaN3vt583RBRg0Z5T1WPf1Yzl
	 cNV2lTdRjVh3KBxCgCD4y7QbcYUhzAlbLEHQC+zXA+t6SBLayKVQ4fp+Wsw+6LjeKHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803123;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oNMFKKIIyphQBofn7wJUOYrJvLb7BuR7zhK6nubd80o=;
	b=iZBnBszPGt+0lj64RRi6++pFhMQT5vjB7J3jvoM3be3QQzjlkKwQ5ypOdNiaGMZ23b0D
	 1oZOLJjXcF5JWzXbSTWizt32ZKS22E0fWwRcCrfjXLe2+hDKrq/jddBi8qe7FS/CEbJnB
	 jndWjywhx3hjpVI+xe23/7Po+HsAhBdeiz1Lnma/1m4wCKu1pf4Xn+DSV3+NinjYXn33+
	 pBn8rjMuc7M0mP9xNl6kv0zgjzvQkYM7MY/jGNB1QHQRu4/cnKrBi1pgAu4M9Yas9SKrB
	 z9iXMuRHBCIrzr4mIhPIrH6qfZC11rp4I9nkoZIo6utzn3cn8neSbqiYcOwY3a7h2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EvlhR5Hb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Abnmw0qV;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D1606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B58D1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EvlhR5Hb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Abnmw0qV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10C117A0149
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:38:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 09:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793803121; x=1793889521; bh=oNMFKKIIyp
	hQBofn7wJUOYrJvLb7BuR7zhK6nubd80o=; b=EvlhR5Hb5qkkJXSauMsfi3l7UH
	26S8XezeNh71txMrkFxAViWOBrNlRCbn7s7Na/5ARCLsAnYamMUVBAt/g/xVRoQv
	w2J0N+DWIJxTBu+1U8d7nV6IQv3UMGC4mxfiKw9YnA1p+f9xQ44Gkma3TesGdqZs
	WeEb3ZaBrMSdXfr4TgITzOCGd7vdwkt1c8Nuc192iRi0E3CAWGPp3U42Sf5lVnPO
	dyRTBubghpFcYAliVAqfJsnUP9PVRjitkiO5k3Dbfs2s+o33uY+RerHk9tDmwZZ7
	WxUQ/vn6wACaWM/gre1Vy4UwasL0wIZa1ymULTAV5GJYuE/C+6iBnC2VCgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793803121; x=1793889521; bh=oNMFKKIIyphQBofn7wJUOYrJvLb7BuR7zhK
	6nubd80o=; b=Abnmw0qVAX7A+B20OgUMlvuLtx0+KxGdpFe3/TlFTj3w65CAiw7
	Eta+kCKch71IHr1a49Xnwm8iUnJ+EYgkHF31osRY51A216VXpzs72ZSPOlscQ2u/
	iNUu0O2CZDNguZn6UXpTd+sqt7Gkly/ZFWSY0vf4aqLMUAr8zURih7HrosTi+ZXt
	QVfBIkb0QgOFzKqe7r9XTFJaDT68QeeKMuPITfTXPlGU3ApgSMM3mSRmK1FlumK1
	XbGi0cIwaJudd7dVCmiRn4z9F7YXEjRMexXmkul+sYi/e8eQg4DitOeUiCynhgr3
	DDsPSQIKFjNG1CzBABo+89ClycZk+01f41g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793803121; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Kof96Pw0gHLH5fQlUQKYkTG6gc0gqAEMEekjBUUyEo6k5J2
	F6i81rOjz7HScrvAerhIbw/3k0QUbJbp/sQjGiPhawBiOX6iovWjVbcvTHdQRv8k
	+u7MwhWfI7wMKM8eKBco0ytpmR+9CaZFmlAul5OCbWG/A0nQDTlknPF4hBUN2SkQ
	pTr6ipdXlZpsKUKcP+Yq+vtGy6uZMo+EIAVfMxoLZc6dCW+4MwIM6uAP/k8J1T1k
	u9t8P63d429Jzaq8gpfevQXj1aK4cf80IDOT1Sc9CFX7y+iLKQ6VNbAurPeHnjic
	mydROSvilEQpg8bs1MnWCE52Bu/S+ha1mPsBedw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CI+wVuFpOjb/Xbqmd9WKICgxSK4k9PPWuXJ5Q79thwQ=:E7Cb+Tfda9qcvPKLX8LyV2zTnh4IH20aoUv1VfUGRNQ=;
X-ME-Sender: <xms:cUPranG3IGaPtAELg592dt7U8WCqPAIIphphl79SjSGZr52tNot1QQ>
    <xme:cUPrarOHFhbMQsedcir_EAs0yhs8Vih1-kRmezdiIA1m2eCbHQ_fI1Ul8h8WP7Yq_
    QsFjFLZ-7kWYcFXKgC27YdJh21QaMgb1FmXdepnuj1-qpMh9aAcaA>
X-ME-Received: <xmr:cUPrahcsmZuWvsZzsIQnMtewVywGDKOISAYj-lIbTe2W_mRs7UG9PYxpCAaTxMcnJ0VkPCxVO_awR7fcjGKfFXIg1wiulxw2gRoG>
X-ME-Proxy-Cause: dmFkZTEXE0ZutMAZ+y9R0Sq9Vt1+EiVSSiCzb5rjWBS+i4W5VIbLENf/HkaVMTspc0ICCO
    jv57pRFg89yn38X0do8v4MqCoRdUWEVmYhJP4+HuMzN6pkY9Od+ZmRgDyulFehTKVzH9Sz
    eNTbxM9I1Em3PQIAWZUE9NvN+StCYtjRDi/I8Me2QvdAJ2v9jqIuXRLakxzXlMzakCr5Uq
    3Hhm7JVCJx8KmRAJBePjHXK+LmYBim4EkGkhs+gAnPubOe2QzbVnrSFbLgGgOEvTXdDJHT
    vwJ+o3rwTS+GSbErBdd1O+hl0KnGDSq5yaM903JPryKznWJ2j+prXuFhoJA5XJz9gXlwcG
    /ULbAQzmOq5QsTBMEmvAaOQhA+EzKeXTTqk6EvtXYIM14YvXN9Nj2HOTsINwU1d+mu3jSD
    W4qlJaVnD6xc4GpuUuRdTZPPdRRACp4Eni9iwgkh1lgLlyqI0EILSnAKiM5rD9ns99wIP1
    AqzWzoo0q1sNrg0lisyiDz425bhcX2Y4cvWHOV7bZIrcGiTwWq/0ndVtNw1yN2io2sH8/I
    Pij0faKyT5KM0Kr+rCQCAZ8p9Hu9ePRYN4lUUWtfKeGRKDHK+zplEZxHLy4gA5DSTxN8vR
    kLtUHjMMNEaGmx9cnvIjA64kYULXoliq3niyLeaBo2cwkTkanyqMobb62rIw
X-ME-Proxy: <xmx:cUPraguaqfpZDGVgMcQaMhWRKjEljuAc6pEXtKyzWaGvqiO4tq_cSQ>
    <xmx:cUPraqk11tszAKujHG66s6VSvxhfDDnQGkjXQpGbwDOKoUs2PMuy0w>
    <xmx:cUPraqwIMxie9VAFijNsv-CkY5CtVpzeZncwkzycvoghoQ9ZJYgRLw>
    <xmx:cUPrakOBTqTpH1CgW0aH8rz8Zx48ExBeHPrIQNPix2B0XXaNW8rx8w>
    <xmx:cUPrav_XHfn63ay1SOzysQKFVP4QnoYbp91WV7r9VS3HHGdEAu65rOr4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 09:38:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v5] submodule: use the submodule repository to
 abbreviate commits
In-Reply-To: <pull.2288.v5.git.1793763781129.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Wed, 04 Nov 2026 03:43:01
	+0000")
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v5.git.1793763781129.gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 06:38:40 -0800
Message-ID: <xmqqwlqs3bm7.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> The commit IDs shown in a submodule diff header belong to the
> submodule's object database. However, strbuf_add_unique_abbrev()
> uses the_repository, so it checks the superproject's object
> database when abbreviating those IDs.
>
> Use the submodule repository when it is available, and fall back
> to the repository from the diff options when it is not.
>
> The expected abbreviation for a submodule commit depends on the
> repository's hash algorithm. Use test_oid_cache to provide the
> expected value for each algorithm and remove the SHA1 prerequisite
> so this test runs with both SHA-1 and SHA-256.

"remove"?  What are you talking about???

Above the three-dash line, decribe the change to those who read
_ONLY_ this iteration, not any earlier ones, because that is what
"git log" readers will see.  Perhaps write it more like

    As the expected abbreviation depends on the hash algorithm used,
    the test uses the test_oid mechanism to switch the expectation
    between SHA-1 and SHA-256 repositories.

or something, if you want to help readers who are not as familiar
with our system and its test infrastructure as you are understand
what you did.

> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---

Here below the three-dash line is a place for you to describe what
changed since the earlier rounds in your own words.  Range-diff is
added to aid it, but not as a replacement.

Changes since v4 is to squash two pieces into a single patch, as far
as I can tell.  Such a change is not visible in range-diff as #2
goes away, readers cannot tell where the additional material in #1
came from.

Overall it is looking good.  Thanks.
