Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619861;
	b=dvomSFs1bzQGiWsvw1fYcfrkv615sU4vOsOGGDNfAlybVUoob//Dbn5IRegI4gyUkAcJ
	 c/XYwHeAC4VVxkWzQvrZEzzfRnJ7bha0bH3J86KZvGphzFLQfrfebyABjaRM7DUpSGEa7
	 NS8G/emVf7lZWOdLmbI30a0TD9JL8f5Jx05/28F4AoqYh4Pmd38gjgM7XlXjgLffF6B3q
	 s9VyOIdbIwDoeI+3ZbqkJsqrIs0P5UV1kHdxBUVA6PYjC283Y07YvdraT+xJtZwvp/sVz
	 ZyCq4NlddLHaiTRn9TNjWjfosDS4JcJ9+CFFQ9Iap2JTMjGpqlAxqUSjzR3eo4U80OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qyyP7EB64oYqqdFnARrLs3drDIgk/JcVr7FEqU+Vvjo=;
	b=jwndQfly+zyshGJEYFy5WpPekpEvV/DqKN0QWLDWCPSX0WBGhckUVRrk78HEks8tAnIp
	 2OtedxnC19ZqqGvrDBaY5EuTr1H84mxXW2atBRz9TZJpVL9rrBBc7llOew4uDy+d0FF1S
	 d/pwyWq4afi3HjQWhGvIDW41xUxYqghou5oxQTYN/8fPg2AobOIXeRMZ+8yyLTCVcr5OB
	 TLu6w99Cf6vMhEYcBY+RP/I2YPcy4HnUdXgy2EX0Lf0HIV+R+H+QLLOUcbk7BVltATARJ
	 GcQz/8o+QD9n3fgcUWt6+NVx7mICXN8EuBzZuSx9a3aDc63XGrLaa6aUz3vpO7CmYUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WdIvg84P;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oMtZ3KYw;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18F606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E18F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WdIvg84P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oMtZ3KYw
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DE0C14003B5
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:17:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 10:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795619859;
	 x=1795706259; bh=qyyP7EB64oYqqdFnARrLs3drDIgk/JcVr7FEqU+Vvjo=; b=
	WdIvg84P57zZol/SjSTgMVcInc/cJrEKE0Hr2FFv5sMqF5zT209kzDyPHYAnoCD8
	SGvjKrnNACKx9vuHtBRpoUl0iUlTBh6yTIX5HdiZeFHd6tYxebvazZRUmxb/Ftkj
	nrJ6lfg7N7LMyIsg11+lm3MT6DpLDVX9T8nxHw4V3Dg3JDqezQ+L7M3GFUJ3Whhq
	/7KcTwvIXNOvXSXdKdsNEyxdrKvtIvE3LXoV15IkJ02w5zGUOl7PS8+rxavoOkOX
	cLn6ycPZ6gWunQ+Lo6/fBrFNgiRwsPzeH6ef6G5BhAFhKw8K+03WGDHYFnmuQjtS
	1Vn8xkeUjfOFpAXIrtTnEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795619859; x=
	1795706259; bh=qyyP7EB64oYqqdFnARrLs3drDIgk/JcVr7FEqU+Vvjo=; b=o
	MtZ3KYw1EiEcvZDk/ZBvF5TPQNG6K6KM6Ui8RL2tnmrpmrcj8e/Sa8/fYu7x8yJP
	20ueRxIvRIG6Sodkq0j5XanYUtV6p/0J2c6KaOBdXUhSFCKue+nUt92aXBbsf/vR
	lxBxlToDkYidplgE+ZbvHL/0F3uw75e2/XqppAE8voRc7F4NS0u8W1ilwvdTBB1a
	2Qx7s4pwTZiVJmnngZkmyF48Lps9ERoI7qlyCTgj1YJ9iM9TDNrSN5r4HKEx2lpX
	1RijRN5nxrD1i8XGj7ZgWv7nc5FeNFqZCmKi3gIUh8ApjwGkjOGbv5LTplEuAlgE
	lgc6or3xOKcNL3/bOJx+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795619859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PSJwhTwdSblzgBdsA2qiS/pNi7rq6T0LxylU0xnECq7mVpN
	DlfTA27b4zjl1++heSGCNzwOeLJt0Q2n4EVDT7nyDuCbHiqOxt/DktHDGhgYPgR8
	hHXZRy1dhxvAPSu5dMvQGqqVyf854kxc040SRMOhvCD1qr1jhzxnTAEjBKGb8pPU
	nRTRWEPwFHDMQDmNBCo99WHxp8cysrS09T0viEYbzSV9lKpEuWPx1lMjd74OY/wl
	gfYupqXMG41HB2ZCuM8nc1Ox67CVmSpFvk1ljd4wb+W5/Xvp/eXh5pIhO1EiSPk8
	rs4puOVgZLbE2ZRbeuhkPYWCwTr1WEUfl4Soqtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:fn95RGXRBTlsisUnjQFDfS0oEHjNuI4wYMoUnsrq5As=:d6K5wPPjtuVs2Btx18SvF5T5UrpZle+2YXuARGwuwDM=;
X-ME-Sender: <xms:E_wGaz7T5MpJpnfwy9-MsC03bZ8wCBGbVV4qkZxJeEYivX2l9Umodw>
    <xme:E_wGa_5ljt16zfTMT_jciRhgi3YIcatl5x_-qMAR7vMdLmD9m6On3SIu2haz7qV0P
    tCH8qE2C1BLm6KL-gXsGwo74OaiSUrauDcSfdW-gPQorEDhZkPzPQ>
X-ME-Received: <xmr:E_wGa_euVf1rw8Xlg7npQQXunhF5u1NL_WL2tIdT48xZpiDnRJibPgLkDLmzx9jLmc415M3Ur_GF71PM-6vPTtKAOdAybybEgkf5ITU>
X-ME-Proxy-Cause: dmFkZTFZX6WmOnoT82XpoAvdVqzNuNEvhjhrE6ZNtSxfSoTmHBUieHJrSEeuPFreUSatNF
    +/kjJSveflgcgf448DSmHTKAJWCdGxKGGyPKUYUnDaBi9M31vUjH5m2tDXgGJG2juv/gmN
    7naSnq0owHd8Y197h6kEOnjff7tc/A6HZ6o1HF/vhRZ+g30B1dOnSLKyJWNJyPrgcchIhS
    fGDkWB7LizDtpNRNIvN7weSN6+qAAILxb5rzUgDxXUbFT7pvtnGikbfaA0CaqBPHzMkX6B
    nD2tCL9ePRzePedTyGaQWLFCTRF4Rf7QhzzAV+8A8RbR0xmvwQ0YdN19ehvIG2IFVyQsnv
    UM48WOtD3tdTVNqsVLFow3QZrMG3CdVZ/tRXnibtxdwuZlKwy2lTWLEe2gUX39oZdHIxGa
    Ha3GWN4gfse67jyNHaD4jWePUNpvse2inRCJWb4GEkD8gmuHaU96Rx+YsUVaG0A4TEy4ik
    f7Nu6GcbGauozALhqNvoMGmZfET/fSQ7WO5aeR2xh2BnTpv9KsX3GAihsoQj13rSTCkmZI
    /e2JIIguJFbCJOBe/e2mE3gE9leWlchd/TzY8K0fibliO4UpL86yBa5YZwkddNYba4GEuB
    hAwaXTG5rWuicroIwnHRjpGaxKv51GMBJDKC4r1CGz+szQt0/pvuruqsNaSA
X-ME-Proxy: <xmx:E_wGazB3gS-BEoOKOhYe1OvSPCeH2YWo-aDTWvf3zCRxmVOM_PxO1Q>
    <xmx:E_wGay8Vtrj3cd4QYBngEklfOQYOTZjHlrE_zeb6HVYiasm02fMm-g>
    <xmx:E_wGa-KMedTKJ38pJ9tQPE0hHbMCqYQY31m0qmTxXMdLj6amj6lLBA>
    <xmx:E_wGa7gblxBqrGbpesLyfVDr8CzKhFqIlodX9ieZsWrJ-RiGVooVag>
    <xmx:E_wGa8eSisJXe3rEQ9EACUfB0jhoQkcA9UBJ-zgqRlZScj604fp9OlsT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 10:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 3/4] doc: convert git-fast-import.adoc to synopsis style
In-Reply-To: <a50bc32d0bebc7d5f7a8969e412ebd9d197370b6.1795556940.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 24 Nov 2026
	21:48:59 +0000")
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
	<a50bc32d0bebc7d5f7a8969e412ebd9d197370b6.1795556940.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 07:17:38 -0800
Message-ID: <xmqqh5h5aqjx.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
>  * convert synopsis section
>  * convert options to `` style
>  * convert _<placeholder>_ style
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---

The intentions are stated very clearly, which is good.


> ---import-marks-if-exists=<file>::
> -	Like --import-marks but instead of erroring out, silently
> +`--import-marks-if-exists=<file>`::
> +	Load marks like `--import-marks` but, instead of erroring out, silently
>  	skips the file if it does not exist.

Similar to the "Fetch ... rebases" we saw earlier in [1/4], "Load
... but ... skips" mixes the imperative mood with the third-person
singular; "silently skip" would match "Load".

> -where `<count>` is the exact number of bytes appearing within
> -`<raw>`.  The value of `<count>` is expressed as an ASCII decimal
> -integer.  The `LF` on either side of `<raw>` is not
> +where _<count>_ is the exact number of bytes appearing within
> +_<raw>_.  The value of _<count>_ is expressed as an ASCII decimal
> +integer.  The `LF` on either side of _<raw>_ is not
>  included in `<count>` and will not be included in the imported data.

Shouldn't the last `<count>` also be _<count>_?  Similarly, don't
placeholders like `<idnum>`, `<object-identifier>`, `<time>`,
`<offutc>`, and `<tz>` elsewhere in this file want to use the
_<placeholder>_ form, instead of the `<placeholder>` form?


> -import-marks::
> -import-marks-if-exists::
> -	Like --import-marks except in two respects: first, only one
> -	"feature import-marks" or "feature import-marks-if-exists"
> +
> +`import-marks`::
> +`import-marks-if-exists`::
> +	Use the corresponding marks option with two differences: first, only one
> +  `feature import-marks` or `feature import-marks-if-exists`
>  	command is allowed per stream; second, an --import-marks=

Here --import-marks= missed backticks, and a few lines in this
description switched from a leading tab to two spaces.

> -	or --import-marks-if-exists command-line option overrides
> -	any of these "feature" commands in the stream; third,
> -	"feature import-marks-if-exists" like a corresponding
> +  or the `--import-marks-if-exists` command-line option overrides
> +  any of these `feature` commands in the stream; third,
> +  `feature import-marks-if-exists` like a corresponding
>  	command-line option silently skips a nonexistent file.

Thanks.
