Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811482;
	b=Jbkq8l+TtzryjMHxUpZI/Ow5Tg4I4L2GSFDDsJ1xWP/GwmX6RYDEz7jpufBxGiAQbgsm
	 JTIT7hclvHXcKYdYsYpxMotNdeh3DZRVx7nB+8NTQSZlWFc512PhFKvzoldtjE5V5rMJM
	 sboumclTrPdEyyEdHeFW8WBA0a7UwatHPN8X+rSkjlOWjnq612LRMt1tK0NKyytRXnqxe
	 BN/tGHNVw3Ol6/mn7INYFWyeKlLKQjocv3rEPscF14akLXcEuDztMRKakf3JrcpdeltWP
	 MWlRRH8G88ijkYtcyJQY6mEJt11YF3cIYCdkym3hdqGqeJDBau9EDah+zjO4kR8srvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811482;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1KQCHeftpQlIZ/8ymJ2fcypbCVgErcHW688qocNWfLs=;
	b=hLppdSqgmY9+fFtwUlvJilH5oxnqU1rbF6cpO19kbURQZaOqFDEFq28X3Swz2yU8Jcfh
	 dmbT9cswFMzBUxlKglh+iU8tKypO52igCKZo+qbf4pxd9LCezAJDlmadmz91/HWaUoGD1
	 +9mZuPMVNBh9QBJDoaSdAVcpszLBeR2BPR0V26gGg7C/8gqxwCbaOskG2KdmApMRIvcIL
	 sSECxfu1FKMjvAMZqSTF4YuwEGpAh5VVIvSSTFOSuuOr97Ll+kgBZusHeM3qz+bKVeDO1
	 FF7eu8S7cpZnVnYoAueVO87gMZp9FsQOIwjX3hb+hdSEDg/NreUhiLp2JRsNQBjHd2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f69uRr+C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bPtMbwCQ;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B409606A31F
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 20:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B409606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f69uRr+C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bPtMbwCQ
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 278C4EC0AF5
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 15:31:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 27 Nov 2026 15:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795811480; x=1795897880; bh=1KQCHeftpQ
	lIZ/8ymJ2fcypbCVgErcHW688qocNWfLs=; b=f69uRr+CDoE/uGdsqGAXo2B/PE
	JG/LEjI5oy3AhzYYG47OO3H5GXTwuXGPEiAxvWhOoQgppVSbCEV8m7RQhYg6cmtq
	6tNvBalvt+cgKaDN2qKhvY+iSssUCWzk4fQcT/swXEaOXe5LcUO0MO1erJgpWkFP
	iEBZQwWeMEphAeNiJk1uPwdJfrOHXI0jw3My/hWeaYvxtLbt6zmG8WiaEFSkJ9d0
	A9MwpGipY86IS6l5IkdygTJMANUukmYaC5htylJYwsLtJzINsuHR4aJ8N6WxCzvN
	vOxkbkzQU7gvPta/olTjw9MqF8WwjjCoFOMjJfFSi6bSJ24L5rwG0eHBB+qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795811480; x=1795897880; bh=1KQCHeftpQlIZ/8ymJ2fcypbCVgErcHW688
	qocNWfLs=; b=bPtMbwCQdA6xccPZokVyISyrg8DDYJtUWrCIBmiG+YBGi0m0ug/
	SnWXt5GUXdVdlxkwP7EjtqJ9CXAf5cyM6e9SeMT3g1NFFowTux5V6OCQ9qZFrwsE
	fG/9UovPVVuXS6kvl18A/dsFWr3UgxQ+jGC2ji+LmeyWqN79kxuBQ7t5tJ3ctR8R
	OiGNENwuLHHwErucacFbHe1D6gvW8RVlnAPwTohOywx/mrQBTP8UHGGF58d8cOp3
	By1Bj0OJGJ+hrtit1ynGlUKAfbqX/eBkE7E7cik7IVrWqMqc1+EB/sfNNj57msHT
	NIVapp592Ar13jF+0ZR+0Nb0vUQ9uEnnomg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795811480; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IxfJJc6XoymEpwX4EZJqWPsSOKSoCxe04CUYCq2bwvKRsFk
	gnwwe0R64V2tS0f7DlnLp/8t36LgIgFe1ZQ/TszS5D7CbRbIbcDCG5J5LTHK6c7V
	vQsYiBSCqUJVIMwYOorFK1SVqE3fnB1S1zl3YXL1pijgmWNpifAnWQ3mRQ9v3vUx
	86kbyzOWTbOqryvoeEYtKa9PRwNM3o4if/vsK5FX/K3vklKRIfANSqnCut8tMvL/
	QDc0UhU79Z7MV/83oM1yYmEAp0C/LvOurfsYzk+n4h5hor+Fr0cpy7c78IIFsHhF
	xrWHGeKeB+Tk5TTg3vatrskXePsMPP5jcVryIWg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nfe/zryJXehCvtgSluEWEhQzZ3iXebh+qj7xHUOPuWc=:1TrPR8iafVKXwNhtUzqs3XlD07MUD6WezjTExab/mUw=;
X-ME-Sender: <xms:mOgJazs8OpgDnOGAKZhS35_40DVyhMAUxZGnz0tt7DjB07IT9xeU9Q>
    <xme:mOgJa4LovcpYm7rIDBEY9FcBxj6ovSq4Yf_-lk1cng__VJ7DxlAqLxya44lBOKxvK
    WM-_FerHLIbkVFRN_9P99-pf4F0qh-c0gwQ0fdFqYLThm0Z2xldY8M>
X-ME-Received: <xmr:mOgJawkmXE7-8gn4DYJGbMKMGk8Ct5Rupx_Eh8RrzvWMDEHFdZQB_TP0KCju6enG1ZvwKbjCqpivyqp8mS6qqJ3v7tGZ7qDEv7QDUU0>
X-ME-Proxy-Cause: dmFkZTFrgDTeeeniZxsrciEm+oCjy3ejHO5+ERLkvDBvATFZJFpKpLSZKh+VQPrwpJ62IG
    J7yLPp4hK44q5CiQdj6ySEP2190SRhkA+I7s8t4cZKG1mJSqHbxuUruOulreB3MHdYcgFt
    wKxQB671LG0IPMH/yE32NZ+o6bKV/Qgd+5p+XF7jDIDWwjyPWMJOWEUMbWupVUkz8IdfNU
    d1YY/nUSRS0zcGpTkoSFjArTwJOqlDnpeOQAiFV8wRJXFlBWGbX5s5yKrwG+RHK18jBer3
    on+Ip7dAN5zC569ZrOsmfPtj/jBMPWZA4wc0blJfBoJ5sCuqSYHg0kHyRGKrJC6wrdr4kI
    ej7Gd59z/q91+CBslZ1uRxtxUC93MggvnXEhNZtDUeKzlMP8UEEoiAKaSHCKN8WPbTQbHT
    fGODueRHLsrv0E0f0TWFIj+nLT87I279DczSNcDbonOQAUR38pA8396qxX2izLveiZZFvK
    UNvIAGDItuRVhKdL3JhwEUsjLyR/lN1rt6SsSsO6FMPkNhtksFpBqEPQqj7+Ybk8KHgTUo
    9fhXqYYq7n1LK5KnXzHCj/TYocOU9a7u8nv0AtsAETLxrw/eAys+YHynf9oPoYObmNKwea
    dSJ1dQrUAFI04EqQlpO23m4tNf/yhHPm/mHlUd2u/eDgrBHoksazytgmUNTg
X-ME-Proxy: <xmx:mOgJa5K3oemyp_i-MFjAUdqMmN5LoAn9jORt8O4uQ7AydUNyRSBEAQ>
    <xmx:mOgJa14k1gH1LTx8YqAv0I1quSNsqCxy9iHlQv68IS3sCLR38BG4Xw>
    <xmx:mOgJa90OssZMyaZK31YzNHePXQcPVgKzZPDrNEMhOVoPY1eqg-aqBg>
    <xmx:mOgJa7dY7_rdNnGK0tncIiF9fs2t9qiMj2rf8W4yFXNYYKgthCvWlw>
    <xmx:mOgJawSq9zZDGUQvmS6OMjBFqwlcETNlfM1umv37vqA8GdPv6v2uwZeY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 15:31:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>,  MD Nahid Hasan Sagor
 <nahidhasan141400@gmail.com>
Subject: Re: [RFC PATCH] quote: make sq_quote_buf_pretty() prettier
In-Reply-To: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 27 Nov 2026 16:54:27 +0000")
References: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
Date: Fri, 27 Nov 2026 12:31:18 -0800
Message-ID: <xmqq7bhy819l.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> +static bool needs_sq_quote(char c, unsigned brace)
> +{
> +	if (isalnum(c) || (unsigned char)c > 0x7f)
> +		return false;
> +
> +	switch (c) {
> +	case ',':
> +		return brace > 0; /* Prevent brace expansion */

Web search tells me that bash, zsh, and ksh93 expands sequence
expressions such as "{1..5}" or "{a..z}" without any comma in the pair
of braces.  Because '.' returns false unconditionally here and no other
check triggers quoting for "..", sq_quote_buf_pretty() leaves "{1..5}"
unquoted, which expands to five arguments if pasted into those shells.

>  void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>  {
> -	static const char ok_punct[] = "+,-./:=@_^";
> -	const char *p;
> +	const char *p = src, *q;
> +	bool quote_it = false;
> +	unsigned brace = 0;
>  
>  	/* Avoid losing a zero-length string by adding '' */
> -	if (!*src) {
> +	if (!*p) {
>  		strbuf_addstr(dst, "''");
>  		return;
>  	}
>  
> -	for (p = src; *p; p++) {
> -		if (!isalnum(*p) && !strchr(ok_punct, *p)) {
> -			sq_quote_buf(dst, src);
> -			return;
> -		}
> +	/* '~' is only special if it is the first character */
> +	if (*p == '~') {
> +		quote_it = true;
> +		p++;
>  	}

As noticed by Nahid already, this loses the leading '~'.  Also, do we
want to do something to this corner case?

    $ echo P=A:~/B:C
    P=A:/home/gitster/B:C

i.e., bash and friends seem to expand ~ that is not at the beginning of
value when the whole thing looks like a variable assignment.  Without
"P=" at front, this does not seem to expand.

Thanks.
