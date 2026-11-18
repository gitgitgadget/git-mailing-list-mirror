Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004503;
	b=j/uOY8Q5BLVOXlEwBgRPPe8VXwx2WH59bj8mxk04rMS/w0Y1CFCo4K2gKI32Daxyy1wK
	 6/7UtmH7h0C7/xrVg/FPlWUgYktnVlUWQkzRKrOAwwIAoGIHcZ9XJyc1nsAdkqxPBZG6v
	 PRJ8wlHPHOuP0d9qfFt5k7xwKJyl7TWyqkCtRKg9UvkgU5vacTAFCj8aSrhwqohCU5fGW
	 kjOFgau0PALTHssjpLKwEcaGpcxLjN4D1J0W/sUnlAdtiZVuaHDvz2hth9+StHExcAa1n
	 5eWQcTODRoOHK/k0eAlhz541R/GPhI3sBs2GpWLwMxOLPFxi32pkKz7gdsc6haHcYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004503;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cLP7FgZdcENk5ZE6AtzjmWW7aT+CT07LbZmkgIn3WJI=;
	b=Ao2zN4mYGLQ+ShaixkpPzr7EiOkd1dygPLL5H4Vb/39TeUueiNq14aovmuYejcIIISYM
	 f0MJWGd1aA7plGBhJd5midFuzzGdmYZiu/1oCzaIcQYCoscLsp2RUFczbH0zfagNUK0QQ
	 Dea98cKf/LAAseMDGH5McS8D5REaU79B8ou9rixd1lPyvVYya+zqm0w0TKXDfZQzNpjNe
	 D+wW4jQNRxHE1Wl0IGDfMq+0ULdxewfwXAMfVTSHx8lmEHTRRA8eNyFEgVo5dTPeTfURv
	 2+CkO61iRl2I0s4MYKXTQLpHCVFe2JNxb5yegMDaqMqTPZeFN6aUBChGdRGsZz3O6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wbaIzwXg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jtHLVWAI;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D2606A32A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wbaIzwXg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jtHLVWAI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E276EC0ABB
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:21:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 07:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795004501; x=1795090901; bh=cLP7FgZdcE
	Nk5ZE6AtzjmWW7aT+CT07LbZmkgIn3WJI=; b=wbaIzwXgqXnagCzZhc9rex9y8o
	O1iN78L43hycNUfaCxAIjU5Oijcc5lIsjfWD6SPTttCWxFEfUe32KlWRpM70cgcA
	HS4b2bkuDFmY+G17iIJlrw8wITblASdR730Kya8VxVpn/X95PLBctr6H7I+ifyKd
	ejS7P6om6NkXPtHbHRaMjDWTs66kHnbZAPgSTxHO0wTwdpJDe9fK8EYgp3wWmw6L
	8AVOXoip+Y5r+IwqQxYSoHyiWVKHb3SgSLPacX8CoVgHSr5hUijOenN5z7RlUA48
	H3/zo3mU9DzofsqIJwZbL62+h7nn9/3fNmKK02RrLQd7abJL+B9h3exT4hLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795004501; x=1795090901; bh=cLP7FgZdcENk5ZE6AtzjmWW7aT+CT07LbZm
	kgIn3WJI=; b=jtHLVWAINoh7SZsfAT/vb5XaU8i+3lRxu1HcUbZScspxBJHH6Kw
	NjTNsz6H0IJJYzjavCItGrDDwrX6MWez1TB6AhCJgOju8V4Zn9U0227ACvrvDUD8
	YjMDuAWcpVaXObF7umy0Yzh2i70rRFvD8nJnVmxhiGDHRMB+pN26bHaVfuVws3ML
	WlhcRMAub8Yv3WcSR45ban4wtaMHFn0riKngvEmdMXtjH81dKuKZvXyh9kY3Y28A
	2Mc7LqhXHAx7Ujgg4tlGjOTOCapMYc8IUWNP3eDA9x7o3d+Dr/dkZeDtl+DtJVO+
	Y4HUpIKoFzeu7a1KlOjUN0tXnHhyOAKV8rw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795004501; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:S/vKW+GeYXYYf13iNTUu9jCsN3EiJl/ke5MX8+rA8Pl5z88
	I/muF1uEM0b67++qx9oghAqYHCIvKHVs1uCFQVMNHEdUjs9ehaGzIEq0qFtDIXHF
	UrwfgN4XatFttF75fopGlgp5ishEPA2drNTa154nK9X5tCVeL5OmC9YIm7JvmznP
	6XOU/weIoyK06XYwdOUifBbxqPxDOOGBi5stc2xGAN/bodL8tA9Nqf4OOWDj5OvB
	VNOgTc+u7Rit49R815eFBbs3cUhWEQAi3qQwuiTFwN0ldJWB3jZFHRQhIqlBK9hS
	H+Dg0up7FFNjbRdhj03kvV+zJZIf8Y8UGfiOQqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Gg05qigJbc7SlTvprScx+9wa5Ql0rm0jzkdoizLEVzc=:rZDomnkO7xorUK32HMYqd8azS1WRPZ9RN93PBQgtdQk=;
X-ME-Sender: <xms:VZj9ag82SU-iinmSkWVD8s4rDUy7YA5-Gubv19bt8yL4gu8xbhM36A>
    <xme:VZj9asa_AlgEFcDaA1YIzNqMFxut3Yl3rUCvlqDAGvLEO_cmCJHmLdJub45RVg9_L
    mi5Oer0czfCByBZwv66dcKNF9sFmfakLou4P5vxobw09ps87xk9uuY>
X-ME-Received: <xmr:VZj9av3lwrhCPEixxCnyYRhi-6rAdXLFf22lpTr3pkwMircX7Mkksw>
X-ME-Proxy-Cause: dmFkZTGrc60UnGdE1Rw9EiVCJnmWUqchBkoGqh3qMHwMqcN+srJRSvjOusFDqotNL+cFii
    sRun+LuOLZVlT2Jm0/7OkqeVO70jzg7pH7DlXJHmJuV/QvBbMJu4wxWsKYsXe8Ftcl9TtV
    bQWd5u2Hfgs79v4nRxgkMuphoEGGNEatygU8pBtUIYmgLNnzpBbAf3cWn8z7I40vXDdyqb
    Gw3+7knv4pTrxGYwBCUHFhsIlEUnrlU10sErLkpxy6gWSgA3wkWxLj1Fx0/TRLxJ8Lw+bL
    TnAfc4P/J1egBN8eeV5O8y/569XPf0jPFLCiEQqSR1aclI1wHMnKr/yOqHZEX99JOKzeO/
    qNGlvabRjo/EY4g2L3cSOKhAqKY0KyU4ILr88axAmUOtIj/k5gI9ZVJnMFq/97AWQuh44X
    nSlnW+HYRMXg+iz+OSBOCPm8K6JPm7IHgkVbmpl2UP1isvC2vlUs25nT3uuvQ7q8K8QFgj
    VTH6XOYuSqx6NCsmURuKZkdTIsCHVJcEBaaZmOzgavpUaiUVJKO50+HO9QsvukU73jXIEU
    TqV8qYwGZ45+borAIHvuOMKeq7JybZT2BNbfGQZAdItInWTJ0TWdVZPyb2zTOY2oiWWVa2
    rorBlYxbMATSytOEpUFD8lm/zuvY5KID/9BxiGM6R0TO0XeLEeYDd1hwf0Rg
X-ME-Proxy: <xmx:VZj9anaqxhSInI5TalCpc9LUfrsx2-ay30uShj6Cz3jtj8-tvhXXmg>
    <xmx:VZj9anJn-jQiTC2rdUMuK_Dd9_q6-BwxvgDBvJI0XH4fGarMCLzwAg>
    <xmx:VZj9amGW1k_rbd8LvXRG2Bn_lSFwVljq1qRTHYKIJVAFB8t6EZgo1A>
    <xmx:VZj9auuj7ZZaOhPykqkJQnc2JLdceGZSSa1LBTJXOJVVXP5dQFILeg>
    <xmx:VZj9auHUFBTGptiy_wuj9cn61k9UQdKhzy499TOtpiZid_M3UX2IgDZi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:21:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 402be7a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:21:37 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:21:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] object-file: check size of inflated loose object
 against its header
Message-ID: <av2YSgkd2fUNRlNM@pks.im>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
 <cover.1794914210.git.gitter.spiros@gmail.com>
 <edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>

On Tue, Nov 17, 2026 at 12:38:54PM +0100, Elia Pinto wrote:
> unpack_loose_rest() allocates a buffer of the size given in the object
> header and inflates the rest of the stream into it, but it never checks
> that the stream actually produced that many bytes. If the compressed
> data ends early we return success with the tail of the buffer never
> written, and callers like odb_read_object() hand it out as object
> content. For example, "git cat-file commit" on a loose object whose
> header says "commit 200" but which contains only 44 bytes prints 156
> bytes of uninitialized heap memory.

That's certainly fishy.

> The opposite case slips through, too: when the whole object fits into
> the buffer filled by unpack_loose_header(), we copy only "size" bytes
> out of it, the stream has already ended, and the extra data is silently
> dropped.

Hum, this part I don't quite understand. Do you mean to say that the
header declares "commit 200", but it actually carries 400 bytes, so we
only copy the first 200 and ignore the remainder? If so, why would the
stream have already ended in that case?

> The packfile reader in unpack_compressed_entry() and index-pack already
> compare total_out with the expected size. Do the same here and report
> the object as corrupt if they differ. Today fsck notices the first case
> only by accident, because it hashes the uninitialized bytes and gets a
> mismatch.

Makes sense -- the object should yield exactly as many bytes as its
header declares, and everything else is a corrupted object. We could of
course try to paper over such corruption, but I very much doubt that
anything good comes out of that.

> diff --git a/object-file.c b/object-file.c
> index e04ce0bc11..5d03ae94c7 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -212,14 +212,14 @@ void *unpack_loose_rest(git_zstream *stream,
>  			void *buffer, unsigned long size,
>  			const struct object_id *oid)
>  {
> -	size_t bytes = strlen(buffer) + 1, n;
> +	size_t hdrlen = strlen(buffer) + 1, bytes, n;

Not a problem that you introduce, but it's quite fishy that we use
strlen(3p) here, as the input buffer is known-bounded. I assume that
doesn't really matter as we've probably already verified the header
before we call this function. But regardless of that I think we should
use `memchr(buffer, '\0', size)` instead.

Maybe that could be done in a separate patch.

>  	unsigned char *buf = xmallocz(size);
>  	int status = Z_OK;
>  
> -	n = stream->total_out - bytes;
> +	n = stream->total_out - hdrlen;
>  	if (n > size)
>  		n = size;
> -	memcpy(buf, (char *) buffer + bytes, n);
> +	memcpy(buf, (char *) buffer + hdrlen, n);
>  	bytes = n;
>  	if (bytes <= size) {
>  		/*
> @@ -244,7 +244,14 @@ void *unpack_loose_rest(git_zstream *stream,
>  		}
>  	}
>  
> -	if (status != Z_STREAM_END) {
> +	/*
> +	 * Make sure that the stream produced exactly as many bytes as the
> +	 * header claims. Otherwise we would hand back a buffer whose tail
> +	 * was never written (if the stream is short), or silently drop data
> +	 * (if the stream is long but ended before we noticed).
> +	 */
> +	if (status != Z_STREAM_END ||
> +	    stream->total_out - hdrlen != size) {
>  		error(_("corrupt loose object '%s'"), oid_to_hex(oid));

Would it make sense to be more specific here in the case where the
expected size doesn't match the actual size and print an error message
saying exactly that?

Patrick
