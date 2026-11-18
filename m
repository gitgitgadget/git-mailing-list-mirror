Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026929;
	b=I08pNdHMyEz75QjtvsgZBKt77ioF3w2QqS4eK+ayXDwnwjvUvh/xdJCJa/g64BagcD5C
	 tt8bKyTLzHk44aUhiRxzNI3LZOho5RXPSAmWwX6W0yqDQgBtu/AvY2lhZUQ4iTC/44360
	 0Lqu2cM1c8QytWo5oOvn6QoY8JOWoz0S/WMBnqtw+ia3LrBM0dPtXErFnVKM1y7/OIVBv
	 a+o3q0ugrnSoMHP9TCwsO34XZGqwM+5mIYPoz7TaRTPApvvmsMyBgwvzjllK5Uf95vYvg
	 ZaOdrPvphBpLbkDfYizYpYRk/M/bKphHXtGp9utjURmlctKBwTvLcKKk+Y5S2sZiHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026929;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=fFUZ9ZYkOKDALaPukwewHxp2jdqzBGE76MIQ01WrJO4=;
	b=SEPYf7s5hb8Bp6qHR512mp02P0gUJyuWohd1IiY2KtFn0Oo/fJCMs9qHpVkex0z7ARJF
	 428fzmZHsSsJulMXtKEtN5VCD5B/5ASdgIfOy9Gh0YizX/lEg0zhYUOmK4zRbN46d8kH8
	 YdA37LYLJgUp4NqwwclCmrxFjgZpKNU+6dZgM+fGZU6OT9EHDvcc96gO6sz63dDd0O8dW
	 ukYoyIjqlwqKflNyKxUNIlPYag5aP9sxl5b6T/CpiTmFSZXfmaq+iw6DptJ4e3IIs+06o
	 RLVz6riKSVFLlCr6r9GCSyK1oJgiOfVzUh4NPidyeC0Ha0Isau/KYJyI9FZ6bOsHhHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TA7dvEKX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ORMm08sT;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63C606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C63C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TA7dvEKX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ORMm08sT
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F78CEC0581
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:35:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 13:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795026927; x=1795113327; bh=fFUZ9ZYkOK
	DALaPukwewHxp2jdqzBGE76MIQ01WrJO4=; b=TA7dvEKXAYPUB2PT/DTwCbZYC4
	+FD1e+karp8rNJ7gczpncxHSridfsoIUEwactn/pbWQrvzhWpt5mv85nrmgTvjIo
	qDG9DrJvbab2DQecuOCrD48UylLBrzYmGtim5PRCxJguRO5184CVBZVShBXAt0Jh
	VIOseoFJb9fAht8B2USQGxZjtydu3+g5TcxFXsTwlaBZXgoVr1fcajAyNBhvQMhv
	OR9+HXE0BCopKxJ/+aE/o9gnzAP9tgoJDUpMPm6OlmuslJFDnheEDnjekzNKNmI9
	6UX/trSj9N11t6SQCQYmXeykz4cXO38OhVl1U1l2J2SAXPnroYPeos6NJZXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795026927; x=1795113327; bh=fFUZ9ZYkOKDALaPukwewHxp2jdqzBGE76MI
	Q01WrJO4=; b=ORMm08sTr0Iz5twJvFbh4vCOf4dUFlh2QH5nyMKeSOxKCMIETkG
	FvLfvyDqPjy0DsR8EhGW7PH/1PBrQxwASx1umHaDl2PNlsqy1zx6OeT6gaibV/w5
	T3Cmeb+KoqozQ2d/2Lq6C3UNq5DiTDYwF6WaJazm+CzL2ejS6911NSmwAguSn8GF
	MmvspxtpHasrAPTntI/trtgAp/+ngGtU2Z7/33n/7hqMlydc7BVzWAv3tu6VKQPh
	8fiIyn2/fiXdXhMjWLiaDIffTe4SqCWqhpBrcUFnk1AoDl1ugXoisgdefoRz5W2F
	DFe/H7XLYJ4XZ0lQRY5UyL3l5TrSvQXaLHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795026927; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CU2M76bx6H5D45ioM0ls3mZcbKJ7sIYFmhK0+VrRVuAv2yK
	jq0xDxjw3ibn5CE8qLAC01PsbBijMt1nvigdFx0P0hBLgx0Y42O8mD2/h0h0l9tD
	MjkH21EXGcBuQj/Pm37I2RpVvYGNVyY2KwpyJD8noPrnUAc2GMyLfR/GnK2Bo/Of
	/YMSL/zaqZ7fq0YZ/UraBJn7hna9pdVPMHKMNJQWy090Clv0Lf7q+chYF7DExq7G
	kPvZEx97FbvpVHUlmXMoEnsPy6ydz6FYehRfFEEPTqeG58ZRlueIdEmXKKaYqlgS
	X6ruNGjTqbnyivKLQGXNKSG9TPLoOgbLrPeERIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FhdeyEYhvl1z6xyABN1I83pQY6pPBe9cKYKHbP7LCzc=:vc3FtQsGfg/wxJ5f+e/I+CxZD5fisHin5zaVQ7Wn2bA=;
X-ME-Sender: <xms:7-_9arLoki6MG8OSgvKT8x0efdKQDwi89xASmTQKyTfM-Bw3e5Kb1Q>
    <xme:7-_9amn3hmPTmg8j47wcd72g3VueYAszvJrEC4hehZ9G3DjPPu1Bq-oosytGRiosm
    fXWCpO6nZwElnas34AkQiSEFoH_dypZcMLCQfoPzwMxF1PKFgVtcCw>
X-ME-Received: <xmr:7-_9ahG2CfooZyZORZQUX708DqAHCzCZs7yTD3GztApj-Ns5NAm4uT6lk_AEjZqHlWiAnWGU956Z9UiuIyYAe8s0gV7gB6J3eRqG>
X-ME-Proxy-Cause: dmFkZTEWo+EOaOE5Eck/u7GpUvm8IL2OoMcMuYMZOjy/EuT4EEIUuWg85P/WTPuzI6agEH
    Pj5DQ5mqbE5MBR3WjkDA1smYkJhwMyHyQxIH4jhy6jGIGnHIpHdQZMM4iLNG+wn37sZEfb
    DNR1y2vCRNazBT6N7qVfN2W/Sn58uzxefgvqmUbAnr0cWdt3p0PkoJu2wFBAD7QuTOZKVs
    8n/VXAlP8Yweut49MgrhBytQ3u+sl6WKv6CbOtWTZoTmdLjjyiA3rMQ3AA/YeFFZouPFVY
    mIIKpfyU94PyepSrq7BpE2/VSfHvmU0guYEqP9J0JT15ujK/j8S5oA/cREqTsXrtmN/5Tz
    7lTM0TSD+fhZwixPM0Xxlm+czcw3nR0zgCAfhXVUQEaoDwfI5m4fqSwIUe7P8VVKxU+EfG
    MCDjybu3UGM40bJoOPzTeZyoks+/s89JLC45JjkXvm5xIJazpefwcmGbCcyp8j1ttSoSDy
    AIbYF/TfjuxvRpBhKSnmiite8U+EGGfrUvy4r/NzBVWDIgq0nFTjZ4L9+13DvIKxkB5qZL
    4Oo33mBIhAcCXTWMUdBeY+DRvwSE0elGj2BrHC8teuFbU07lU2ht+Tps2rlzwLtmKloX/4
    qPFKbDQ5vmI9OtPFhJ1/7EowAxSaopMImKViSFTgIxO0CyWQ1NAoBhMBlEBw
X-ME-Proxy: <xmx:7-_9auFOLK6yimQoCcXoYMVcZWw04twc7iqL1B88Kr_VLsUdStpyBg>
    <xmx:7-_9amM3iTeR7QTeikJqJOoLMK_w6Yrfk5PnVh-46Jh8309FDPXmyw>
    <xmx:7-_9alEIBeGQjZQY8MxdCZ_3329kOeD1WoFazsCIpo1dNZn0vBJM1A>
    <xmx:7-_9alNaHKtNTUEfUbei8Kec1qykqPkU66mfjQjG32pHPFcSeSNEUg>
    <xmx:7-_9aumeQ3xa3hub1dFtMMo3axExN5ScfLebgfkBQDguYe4cN18mk38c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 13:35:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: leave a blank line between
 mailing-list paragraphs
In-Reply-To: <20261118105227.50447-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 18 Nov 2026 11:52:27 +0100")
References: <20261118105227.50447-1-okhuomonajayi54@gmail.com>
Date: Wed, 18 Nov 2026 10:35:24 -0800
Message-ID: <xmqqy0aq56oj.fsf@gitster.g>
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

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index c58253fd54..9c189b6c9e 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1357,6 +1357,9 @@ relevant to your response. It is usually helpful to trim away unrelated context,
>  such as large portions of the patch that are not being discussed, while keeping
>  enough quoted text for readers to understand what you are responding to.
>  
> +Leave a blank line between paragraphs. A block of quoted text counts
> +as a paragraph, so leave a blank line before and after it.
> +
>  Make sure your email client has a plaintext email mode and it is turned on; the
>  Git list rejects HTML email. Please also follow the mailing list etiquette
>  outlined in the

Sounds like a good way to help readability.  I didn't expect this
patch to extend MyFirstContribution, as the first chance for anybody
has to deal with "quoted text" is when writing a response to other's
patch during a review, not when responding to a review, but it seems
that CodingGuidelines, Submittingpatches, and ReviewingGuidelines do
not even talk about line length limit for e-mailed communications
(which is a bit surprising).

Will queue.  Thanks.
