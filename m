Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453449;
	b=qMoy3VurwikAzA7dRRS4O6YKuauWUeCv3ELWZJdOgZw+URr/C0Pu+e+1JyQ12GeovAx0
	 AAXVtYdKfExY99HxLeVutW1fq+jHmxCT27jo2YMVK7Co2PJfrWQ3OQAu5KWPYFdHbKVXo
	 gDXrLDS7aQcVXUwqIEUdXI69gY/LjYgWIIdP42lLkVz+hn6ub/tjKNoOOmE/yPkQ52omG
	 NguN+sQjInNzIf7vyfCXmdpa7amdcWHo8z0zKWiRbQgy6BYGOVgOot5uu00vCLMyFxdkT
	 3uwq4ZCRISVGvgafts9sL6aVNI+7h9VJgbviGxvnK2AHGvUL6mq4+AN/ZxntVAtD/qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453449;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Mr6IhPqsDliTOVYYTmFIahoN4adFA+VVN12YGPetyZM=;
	b=pvgeAY9VzZvRc6Z+1COiQTPCiWq27uo/2J6HhRhpIDV37xEv6IFjb+/aWA29L487J2ut
	 nxP3c7UjuejtIdtZCbdaeukmR1oCKMNyrJJdAj+QVP176ViyY6d0LaJGwcpKEEJJxD+I7
	 ICK6TCdW/PCVcrMiuGh8iX79ZcQAmGcLVBK8b1Q6VjWs6Eguvs0oqYcksPn7UgpN8kBP2
	 ElyPQnvKvI0s9qc+4LlTYhg5nnn4Sn7iLMpKk9pyJARDRQhB2rFPTXVQvs3XT8QtXbvQB
	 2Tex2ys4PJ0608UrYSGjn/rs2TtWenvl5RQj5ps8sSQd3ZoeMcqB0DKKQeJBGyVFBAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aJA6yicu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4Tfl+N4n;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09F606A33D
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E09F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aJA6yicu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4Tfl+N4n
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E53314001E8
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 12:04:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 12:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795453448; x=1795539848; bh=Mr6IhPqsDl
	iTOVYYTmFIahoN4adFA+VVN12YGPetyZM=; b=aJA6yicu/YJ72ILoNZpfY5bEyE
	mcJzi4zULJUm8k5G+5DXs8rbdzzSL6FfY5gCea9qAesDTN1usQIm5TlZXv8KfVz0
	wSNi6ckzjWuvyeCVYoucsqmfEtXNrVKsSWcCDxT3K9vnSRnbRwkAintldzigiyv+
	2K2eTyBsvI4tfb3V6ODiAfCsLMSUsrkR2Vu3gHAzhTRTZqn8BXnDFpW70A+c3BCD
	gm9LVUnnNzLwVse2oVIxTK4O1mwXWKX/B8aIbLUh+QgkeW0u7vqXJ7Na4cCAd02k
	lTbNG0W6aa5FWGHhLZgmpXPT+GhjtKhMjsQJISp5JZsJUugxl4He0pTV9VpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795453448; x=1795539848; bh=Mr6IhPqsDliTOVYYTmFIahoN4adFA+VVN12
	YGPetyZM=; b=4Tfl+N4nZhYPBHQE9rtyVnIwDdeLUiQ2FaOM5XHAeLC/FquGGPN
	hxyYHHkDRZ09BMAabDcY8NXrkX+sqtjL59KSiiP1KsqLptagHdKLGozERhNKPpdS
	RwvR6ewafB1qeG+E9MH9ldh/xCW+9uK01SThEZDyo4/uS7kJGTM6BpEB2BLmFf6K
	4nfQTg2uhuLqyaDC2gojARGEu3NOvNndFZ6mtGqCZfsDqas/7rtNLEl/imxiATLH
	gozLJDnpp5Qk4yVAH4daK5WIk/KHr0h0xXtfYHlD6qymKm/+ur08oXbkJNMRohHn
	WS2W6XYLLKH58MSAxAc24VTckjD13ZJ4l2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795453448; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ju5tkPeyQ5Wxu0tassvSB6pvs7eE9Q+zRKuM7ItcOcHwWse
	RKOBd9rZTf63GMQ5ISzt75+LntZKhV4i15jEbQCk8o2NVFvwnO8SypejwRituiwq
	yUhc61WYQ8Amp5QNeFs5nB/J2uPiC/4NLpERWsMojvzbynnFjudMPVig1/BG6XMX
	suOBCsq4x9RAfMfHuypTtGUq2rD1GxKxQBioYHsQ0BTAF1UaNYy1yh7NPJiPG6IX
	s8XgkK1w3fpwC4vXw9Gvi7hYiE34bKQXrCGA7Sj469DdbinsovrGTV6BBMjU3DRu
	c6XHTO5yE8nnqexz+lKWRuxx5P/cF9SGSknCoQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fKeyNzdBnEzrQ5fy7ANCCo2c2/laX5Npe0DqF7HJ+5E=:SSqDzARvcGuRFUBGV4tU/xyMkM903JxNhdn5HFbjZ24=;
X-ME-Sender: <xms:CHIEa6cjIVtyS-D8bvGz5w_YVO3BXNcz6ojRhAYP-fPsoDCHsIxMgA>
    <xme:CHIEa7P4Rqa3orWA8b4KooIuSOdv6HEzn5Qbbqjx-3E-VhdGQoBD11JSEO3qpC-tO
    9oJXPzQhm3qWWPWbZwJn65J5u8_pvwaWcMmt6w2bPkIrOD6QFIn4Q>
X-ME-Received: <xmr:CHIEawjElnyLN9uYHPebaQD-MjqoGB-1nWdzLedkIM6kC5Cn12j8Xw2ygB_C2Oq7qXZBv51JC6VXgxqsYDmVZtNLSlkpNmz98aP84B4>
X-ME-Proxy-Cause: dmFkZTEDj3Dpj4ud3csgc1wWrJQaYhYscaVVYTXQPKEmyO7P6YxbIqz75XWqVIG5goYrLG
    9nowrO56dEnqxEQ50W/NEwgIgu5tfztg3F6sr2nzCZU5kouTdXOLS5r2PgVvRk58LF4GDi
    MfZzkb6YDYerWTA5O+XwUk7DttCQVPuQCH2ZaiC+gHn8FdopwoXXOCc2CLfqZeJXyyu94k
    alfhLY2jgnhcmVGalLM5H51vJSTP1ExFjBY6BKGVHjx9Tljfu8tChU5C5f3JULSSMT15XN
    yWeLA6J0UwUWjeG2q50cc/kcstTR8DWHJNaxb1i0VvL2xypt2TOuN/9i0Q0hErG/NfNUNi
    FWdMtUle4J1H4MSuukgCQtH6c+hsUbMVKeQ97+RitRhDw5VMXVjbGHvi5bvtDN5IhadiVT
    nVagVqvLKbFDQrwjWavH5KdzdRbGS6XEI9WfWnnH6AiE6687WwDTuEuCDi7o5kLzNd0Ucu
    tD70GpcK8OfopfTupbknlE8sGptuvo6lulTonu7mfl9VykC4nqu0pSW0ikvCaFHR/4axo6
    dBRgdI3aW3mzzVTroooqRYCFCX/l8IzA7f2EDw7HgavWDCncgCYEj9DQEGsBOVPDp9ZIx3
    lQWRLN3xgTgX05BQZ2TX3FcIEou1W05lgqfZRAZay0Mip/rUVwgZ31kU2gYw
X-ME-Proxy: <xmx:CHIEa2210AAAQd2xW77Plz6iWo7v5yOYCLljXzzF5QIHa4BQhADegw>
    <xmx:CHIEayhjmk81ZWsbUl-f4mz9zQNhe5vj0iX5JwV18jEpNrOXQrPZwg>
    <xmx:CHIEa-d1SAGkM8zZUGV39Crl-rTu5flY-uLV6y2O_-8Y3g3lh9wS7Q>
    <xmx:CHIEa9nQpjCXNnhMFMvus4FEfIzwbyYeOhzU8RuS2xiV3Q1v8NufDQ>
    <xmx:CHIEa0jm3KgcYvV69SxNImy68_1iVnbLt30jdogJ-0dSSjG6kfJc5a9d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 12:04:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 3/4] utf8: respect string boundaries after skipping
 ANSI escape sequences
In-Reply-To: <20261122-master-v5-3-313bd1bb3c45@gouders.net> (Dirk Gouders's
	message of "Sun, 22 Nov 2026 15:51:26 +0100")
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-3-313bd1bb3c45@gouders.net>
Date: Mon, 23 Nov 2026 09:04:06 -0800
Message-ID: <xmqq1p8ba395.fsf@gitster.g>
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

Dirk Gouders <dirk@gouders.net> writes:

> utf8_strnwidth() can skip ANSI escape sequences and it is possible
> that such sequences end the string within the given boundary.
>
> Check for such situations before proceeding and calling utf8_width().
>
> Add tests that test such corner cases.

It would become clearer if the above described externally observable
symptom and the condition to trigger it.

"such sequences end the string within the given boundary" is slightly
imprecise, isn't it?  IIUC, the problem is that an escape sequence
reaching orig + len would cause utf8_width() to read past len, which
leads it to count extra columns or reading out-of-bounds memory.

The code change looks correct, though ;-)

> diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
> index 86e09c3574..5e2b636db9 100644
> --- a/t/unit-tests/u-utf8-width.c
> +++ b/t/unit-tests/u-utf8-width.c
> @@ -2,6 +2,17 @@
>  #include "utf8.h"
>  #include "strbuf.h"
>  
> +/*
> + * Test utf8_strnwidth for strings with SGR sequences and corner case length
> + * arguments.
> + */
> +void test_utf8_width__strnwidth_ansi(void)
> +{
> +	cl_assert_equal_i(3, utf8_strnwidth("\033[31mhello", 4, 1));
> +	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
> +	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
> +}

These are OK to be equal_i() for now, but I notice a TODO at the bottom
of utf8_strnwidth().  It might be helpful to leave a comment to warn
that this test needs to be updated when it happens?

> diff --git a/utf8.c b/utf8.c
> index 009e8fee39..dfc5261619 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -230,10 +230,14 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  		int glyph_width;
>  		size_t skip;
>  
> -		while (skip_ansi &&
> -		       (skip = display_mode_esc_sequence_len_counted(string,
> -							orig + len - string)) != 0)
> -			string += skip;
> +		if (skip_ansi) {
> +			while ((skip = display_mode_esc_sequence_len_counted(string,
> +					                orig + len - string)))
> +				string += skip;
> +
> +			if (string >= orig + len)
> +				break;
> +		}

Thanks.
