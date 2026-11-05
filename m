Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904312;
	b=y0TyJggUPTcdM9njtABx38CGQFDud7n3882pw7Xy6k4BEv+PW6hx68tg4xi0wS2FzU/t
	 4ztr94nCV9AT2jFCtvxENQeeDajHDiqI/ybpk4SmZ9pGXdZxmTGALnkOWMCgVa+7pbd1U
	 R99pxOtLCKI0gq0Yuq16sk8pIIE9srz/A9c5heomR4FTbKUKDsSRb9M2hSsqNoil6xZFO
	 4THOvIaQumZMbX9Y26oGsX740zN6vNbTxUrdC+tkHnzstHkEQSGFYLcRv6FOy3Ob6w5im
	 42u3SquyGHr3c/JDrI/WnnBVo/DdQs3SE71b6jXyf11o65aHhOGyV1tPalEl+gUMI0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CjQY2yg27292zw8/OVkrBkI8/Q4ylBBn+UVZ7YeGOho=;
	b=2seaXO2EjQ2n7Ijfo2r8QYInen4nRT//0Ka/zdMKDxuap/LCzpFCFWBot+2jjy3H1FsA
	 9E0vMEzWJFtm3LiJUKRuyrPfyfMOfWaQ1sbCixa8lmJOanLmGEKUCK7BiOpAH2nNQCqii
	 FwlKpptoGelTMaSPE134NfKtHphhrZ6Ppd7Nsp2ks9m4pkSH8/u3JCUJ/UzF2k0N8HnC2
	 V1XRrE36UL6paHYb7e98mbkTz2ZyADb/LJCIlWUN6ysO4Xrhs6LiJNZsPKELFcGgiNhXK
	 Zbr5+sri4zsxTKvvpkpQ/BvltHMJqGBvCdI+LcN30WKh52/FTGjYv6J+yuAHfQTmhRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Rx0gROP9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="dV/fmWD/";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F44606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3F44606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Rx0gROP9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dV/fmWD/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E606214000ED
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:45:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Nov 2026 13:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793904310; x=1793990710; bh=CjQY2yg272
	92zw8/OVkrBkI8/Q4ylBBn+UVZ7YeGOho=; b=Rx0gROP9LcFxg27uy2LqDvfgTA
	lylchZ4Usa4qVUOyfKnuujYOXMarn/MjgXoZ+VhbqztUDJ8o9LOpIjhUzIpUTWFz
	WBL+L0wHxI2iPBNx7Y3FQZJQqkg1ZQCEXQZSfJdZPKVz6lCbtlgqz1Nd40eEGRFe
	Dkoq4+pXH7arJIiixhbF1y9LFioc9ueNvep/ycrko52HMdS2Wy12u3np1l94tPcJ
	aCw4y+M/XtfhFk6USjL4RLU6SXGo/z0ju1PkpkAn4hXTDntMhYYXuD9HqKn5mnmO
	lmP3/WeEG8/jbbWG1MIia6WwO/h5Qx+ks9H5BHT4yO1hLtay0OpVo+ATNEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793904310; x=1793990710; bh=CjQY2yg27292zw8/OVkrBkI8/Q4ylBBn+UV
	Z7YeGOho=; b=dV/fmWD/gyNCFLfNGipjlAAao6+5zzSkHh8AYSBipOTSkSQaMmF
	Z24VF2pBGr6Y1oW3RICy8uGaGxLwDYRxXCYU+uL6uXzZyeqZ5S6IzQxPmGURfc0Y
	yPJlFdLI8W2Efef/A5D8NwM04+zOpX8SslkC7k/7yOSMo59n4KQtkcsQaO+LWL+N
	Wh/BhWfEGToW6UynrbBO10Qh/bssF+uwT0m90sSd4kp0HrTycAMTNtZ2AMLx8sB/
	4tvSTjRbnS3IdSSyrITkepATb00FucOy5tY+GjH12XaOdH5ueWIqhpyttjlXRho0
	dVgL5rADlgJks01LfIDJyswWz7SlmVWCVJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793904310; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:I6hurvtRlVqXLu4G10D7JnHqnmVLiBoya95XCbFfcyqnzXS
	LLAah9CY/oJRCueT5VkPI7gjLZAw5S4MqsUnFq4LSqVLRmCg8qVEo8J+GMpezKj6
	9HejTedfBkuXd5yQxsmj9KaFD81H8FocG037U3YjJNZ9c5FuJQkyUJKd9TtjrmkZ
	ua+Avmfq2G5PafHzbL7kMQX+H7XFcjqVJ0uwl+JvR/DpD9Tb7gCgzUS6ApyFdivM
	IiLmqcfHkkLjvQWiLQoSzRvI4JbdzDPzxLG7acPSs/0UKpQHHQ2rYtsui7L9cuKb
	szEmjGCKHcjJakTy4SwLyHXwVHeHB1uEI60FveA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lWeeYQPX9Zu9lDdy4OxJuTY3QTf7XvlcQL680CHNkhk=:2FPXegcp/dNlahlDn/iiGxvGmzsCpeFQ9VQKWhHBaHE=;
X-ME-Sender: <xms:ts7sair9YtQPzY9lCcohP2tzLU72OnF0kA0aRRXLsy1AfuD5BfGziQ>
    <xme:ts7sanpHgI9ur_iwbFSAfaYlzhM2jkICLdQEXf6ml78vBu2J4GTwsc75jpDKgwa5u
    z4JsLLBCbJEfbgMfysdTNFP4ZSYJavRKghYzPmzywB3hy-1KidHoQ>
X-ME-Received: <xmr:ts7sasMYOHiyJOB8Ho1GnRevubUL9blqWHDajCpSsyCJKS_i0mFk8eP3PGWJHnP2-z_oRxzmLL1L_m0BGwl0yy-cv1lw4rAgJ4kU>
X-ME-Proxy-Cause: dmFkZTGnthigfU53DDvbVEwIlrgBs/akIKYBrUFzDIKkUB6zxRxG2HPwwdfcdeXrb8nzYO
    lJJ3wC/N9MPLaisN4CU6Ia8DTa1ykMbWadJR0ltUq2Sbn4Ciz/5vmqzhLmwZ4uysIWM9T+
    3ufTkdEDSZ6IFDTsOXCw4GjehOE5qlbQ7J70CGn/2rRUbM9Go/kx4XA0jF+rU4K7UQdJLp
    JUjLz32bOhsWBfhL0B05LS/DWdl5yJwGDfmdiICiJcUycmj1zEF4J50t0ZFKj2HNwgaGl5
    yOFp3YqabSJw1AautU7H7f2z23YaK0HXKy/X6q99B2sUBfnZBDK8Vj0XbEamu0prVUEMjx
    sAH/Td4HqELIASS+Lnb0KKgiXCP9XGwNKCT+KxQjDmjq5Nmwy9x6VL+eNsOER8IxcMsSGd
    CSiZUDzHNG8SVokYhxCAOBZjwJUx3QsewSYhM9FLiZ5CjOt4F/lVAnUSw2ulFT78bFaOf+
    lC8o0BbE7kJ28WDEvCLYvXKJE42syOXebSjan54fIIvuoK9KtJc1be1MN7yXCvpElLloCK
    uEc/0RwAGCx1/KseNnZ5RXSrJbaacBq6zKNUyFb0jDv5+Y2dkYl5gycPNnWo4ZXRnvZQMP
    Yi/GSZnI4VZW3xXqnlpu3rldmkmJQzDphnYLbYE/vjV/U/02AE08hHSSEtTQ
X-ME-Proxy: <xmx:ts7sagzLBV2hXSm4Wvi9rpvUbytjfMI0idB-aMU7CiYlKC_URnS33Q>
    <xmx:ts7sattxNRQT44wcK9xbZtN1Mj7J4YttI4FFka3MdHl_6n-ke3l-Jg>
    <xmx:ts7sah6Khs0i395010vSxHAsaDsLDSEy9BVwSnkqdTuEKaNBfED8LA>
    <xmx:ts7sakTW8kEl7lBpkKjOZ05mVpYHOnFWt-EBxn8OYHXhVU4ss727iw>
    <xmx:ts7saiJ916rba7mJ8YHo1O-DfuwAf_BzmWjk6wP7CKBV-s4Qcll93OJP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 13:45:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] CodingGuidelines: update the required Perl version
In-Reply-To: <20261105183900.28597-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 5 Nov 2026 20:39:00 +0200")
References: <20261101185846.24208-1-taahol@utu.fi>
	<20261105183900.28597-1-taahol@utu.fi>
Date: Thu, 05 Nov 2026 10:45:08 -0800
Message-ID: <xmqqcxsjungr.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
> requirement and migrated the codebase to use "require vx.y.z" in lieu
> of "use x.y_z".  Update CodingGuidelines accordingly.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c06f5d3071..bc0470c154 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -703,7 +703,7 @@ For Perl programs:
>  
>   - Most of the C guidelines above apply.
>  
> - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
> + - We try to support Perl 5.26.0 and later ("require v5.26").

Looks good.  Will queue.

Thanks.

