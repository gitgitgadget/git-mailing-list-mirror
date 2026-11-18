Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008827;
	b=H0jIk0vbRNoxYw0d0hM3F7EEQ44YtlQWuCjjHF+UIVbS/1Wz6HoaPkfVf+niqJtZxDFX
	 w9EsUUnx3B51glQxQG9lkrnBu6MzjZ5RnHVYwl+X2Fqc7zqX84pvhmOrvm2Y0vpKiZKp5
	 VktM85tceT7OwQcNlE2NxqZHet6dXo9/7srpA8owDn15ylyPDESUMWEZ0Uutw/+FZdnqI
	 D3qe02kN+KJW4kjMHgWDsjO46V86dLFvn2wJp1q5bGRl2n43uY6MckZBMuOTwIl4jti0g
	 uv3A8NJaXQnPb40hjLUgc59Cd7nXzJHMnQ3jCMxhLNEj7WLXth9rUD1yFGk9LNh74lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008827;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n5hOpUDfqseimxz8J36nlZ0eakMP5HCr+i6alKdc5fw=;
	b=CSrYxO4XoHYzKIPuowfMMjtsCwb1L94Fn4WEIX6pq85jEZbgn+5THTXNQNYDyy8pxhpf
	 Sb5FV1HAOxL2NTuaYYPHpbDmMb9004wPI66+2c4v8pTGHcOsBI9Y0lqa+lDDrt+35LvPp
	 RfEbAvTMsr0Unm5oOQv3pL7ScLhiH7sd24gw+faRPUosFVbIJ5EtkjzaRKrGp9fXBkksV
	 AwXTASXZP3eI3wjFB2u1M8fx+x3L6Laz2i51Ga0hFr1GfBJd7J2SlBjD+YIEJEL8lADUs
	 7cOFBDgASLOPSuhreaujFEc1/ooEmfKeeWz9+r6Z2GuRyIMHxCkY5MhNpjjglYhlRvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=j0mMsTuf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RStg7i9p;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E2606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9E2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=j0mMsTuf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RStg7i9p
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC32014000FE
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 08:33:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 18 Nov 2026 08:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795008825; x=1795095225; bh=n5hOpUDfqs
	eimxz8J36nlZ0eakMP5HCr+i6alKdc5fw=; b=j0mMsTufZI7MzJoDYelh3cnfPs
	ZKQRKL+oOkY+myCqV85PPyM5nza7upGubi0to4G40aW5kN5p7l+vgqacua/nPOG9
	vlpRzwODVLaSAZagBpLBaNss4Us+w4muzmyKYUeMRaUiVObdpQfvmVqbeJ6XYh4F
	msmz/O+pfep/PDZyp/gdIcKxd6fOKI8F7sY8N9zf03LF7Nzw/6CsoUeTGf1+Ijcf
	fpTO4KEbKn84J1naDSefjSj7ABjXBTlDSqkKa7lahFnMFguZfLuMSAouoaL0562Z
	Vg8lK6NHVcTe3cwVAsYo149h2Al8o0Ojef3iJUQBzK+gkf4c+kzX7KzXqYfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795008825; x=1795095225; bh=n5hOpUDfqseimxz8J36nlZ0eakMP5HCr+i6
	alKdc5fw=; b=RStg7i9psRRT3C2AuckDJAzsRHwiBrfcfCnZh3gdSUEkVvTl19Q
	vCSJBA9XBH6WsmL6aUvBLjEx2DhwC7pY5ey6vHIGn7ZKxJxUgT/scwApvRNqSIiY
	7g5oMQ0ade0QaCNDiVA+BJqDqajx1xHCFJKyVYRoS8RPgVPjIpr7sQGAHfaSAIu/
	L3xrcOMyZMHitT2N4RuIa/myHrp1nwMnB/4YZCclv/QSxJsOVUrugs37O0mm2qzT
	wQnGFpjAhXRll2+xamxUlNcJCTxzXnJKxh9EpZv4o1AC/CeZlMav4O64AyJED3uQ
	2JHdyw+PmCCaxP0oWAVLLL+6qDhXho+veSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795008825; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:WXxFYZCtVtcJOHFCsKI+xugHcVJb6DVPilTg5K6Um3FX/bw
	tS43Kpy/jpgQDfycU8og62iJt0y5xNvKoCxlxe6EkUd0x080EVZf47k2E6Pvyns/
	mdJyPJgShJw3VM/dTAJLwyU+4a4y9C62eazxz81mbVGXk8CrXdue9rg5YtEYwL/0
	PWek1MPg6Ihvd0YUwg4Nvjgfm7sSU+GRPgDHh1JoqxnL6upS3Z/4yrZMoXycJm1r
	yjj06qXW1253j6HFbAV+7rkMtzkMxDPsn8i1Qb22O9+b1jClsH8m+JORmF+E+k7a
	oPXXlHtGfQR4fakjS7UOjiefgNQTwSH/EnIEmMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZSQ1NfGl+PgQKYrI7E4zMkc42/D8JwtdBvz7QFQlCbc=:WlBt/1iHvE7lAbWSIMcQcJniF6maRXm/mdSvFO92uw0=;
X-ME-Sender: <xms:Oan9aqqcY9mu0XhufTovpjKhQvOzBbzZFydJo2xUajSqlls8dUcE1w>
    <xme:Oan9antrS3UQGFB0nWXcydA0xe8OgKHhtvSmbnkuevbTifSZu-ZJw8fAfrV8HZxnd
    nziHXub4Z0yNUZkZs-Px2HP529es6s2w44ljZiSeFuJGmWKhvr9ag>
X-ME-Received: <xmr:Oan9alYDngb1Udam_V3vlhYTU--jS4yDxoNEPgd2j-HxhusRO07OBQ>
X-ME-Proxy-Cause: dmFkZTE5hpt/0lKaPYt3wgrVmDHJy9MtLzaNdgCDDDu8VNO5JWG98Y6uJeO64TW6bD14qp
    kIya8hrPq+r7pfB98N7R+gLpBtOlQ6JoJI4gumdjL0hyn4OrXXxB2LXGeHBM+jzDBfq0T1
    SvZCfDviqO2ZHenGzqEL5mqWD1CJkS0gH2dhtlchYnwbnD/7fmow+XaYJokg8B1zlYHIC8
    zTG/sVTolfYE2ya6LhIqzDa+H0+a9U7fDrYE5gbT0aG8u+kb945fgjOnRAE6AqswgtSrem
    9V7cv7WR5Gesk0LH7PdlJ4zKS+C48i+gLXlPpaVC3PzBgJ1sYeKsQSF5dlLbMkynCFCpl7
    +lMkL1O5Si64VL1/r5oa4vH8M3fDS1OqBmBywlvuhrRI5BLL/81S+OJ6IqaHT33sgTvnIE
    h554FsjFndTlUsOADshQCSYHXPttsMS+3V5/T3M34Jl7XRNX5ITH8XtSjsjDAkoG5JO8Hw
    kiQoxVshQAqoCx1l6kf5lLksuDW1UpkqdlWTKrpBfAfBAJsJiTzhwBChGysjPYQhjfjdBb
    +QphKqIlzE/AfSRrB8ZLWTOmhH0hfmBvWMErNcPq8sCAToGplv5dSDiBejQrClz+8Cn9lK
    LxI/jFrYJA7b3Pr7j4TCEqBBVpCqCFj7Q5xC7N4wohTT/ndtdhBozBV6finA
X-ME-Proxy: <xmx:Oan9ambNd-TJOMmpBAIlIIySIsyksapeYP6wUWy2iwNqvyuFNVrGgQ>
    <xmx:Oan9aumm0t_jtwBlqDxONOO1UfyGgvTCGPWq374_ChalZhMuxKGz3A>
    <xmx:Oan9ah1lKlyXk4eNbSKgpBCKfpXJAsFDkO7IiMylY2v73VoVxNT4IA>
    <xmx:Oan9au1rZDQYR79RmjD9YLUu1qRui3bGGo9KauKWn06LCFGzbZtpVQ>
    <xmx:Oan9asKEq91UPD7UaaYvUR3gsi7EdLZI8UOjXOtUcHy8YJ66bfbWsqQC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 08:33:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45cdc52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 13:33:40 +0000 (UTC)
Date: Wed, 18 Nov 2026 14:33:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Message-ID: <av2pBh7vLj5DVDha@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
 <cover.1794984184.git.gitter.spiros@gmail.com>
 <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>
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
In-Reply-To: <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>

On Wed, Nov 18, 2026 at 07:56:35AM +0100, Elia Pinto wrote:
> Since f2063855fb (index-pack, unpack-objects: use size_t for object
> size, 2026-05-08), unpack_one() decodes the size of an object into a
> size_t, and e07ac16d1c (unpack-objects: pass the size of a streamed
> blob as size_t, 2026-11-06) passes it on as such to stream_blob(),
> which handles blobs larger than core.bigFileThreshold. The rest of
> builtin/unpack-objects.c still takes the size as an "unsigned long":
> 
>  - unpack_non_delta_entry() and get_data(), used for commits, trees,
>    tags and blobs below core.bigFileThreshold, and for all blobs with
>    "git unpack-objects -n", which never streams;
> 
>  - unpack_delta_entry() and the functions that keep and resolve
>    deltas;
> 
>  - struct obj_buffer, which keeps objects around for --strict.
> 
> On platforms where "long" is 32 bits while size_t is 64, such as 64-bit
> Windows, the size of an object of 4GiB or more is therefore truncated:
> 
>  - For an object that is not streamed, get_data() allocates a buffer
>    of the truncated size, inflate runs out of room in it, and
>    unpack-objects fails with "inflate returned -5". Truncating the
>    size to 16 bits in get_data() and unpack_non_delta_entry()
>    reproduces this with a pack holding a 70000-byte blob, both with
>    and without -n.
> 
>  - unpack_delta_entry() reads the base of a delta through
>    cast_size_t_to_ulong(), so a base of 4GiB or more makes it die even
>    when the result would be smaller.
> 
>  - The result of a delta reaches write_object() as a size_t, but
>    write_object() takes it as an "unsigned long". A result of 4GiB or
>    more is silently truncated there, and an object with the wrong
>    contents, hence the wrong name, is written.
> 
> Use size_t across builtin/unpack-objects.c. The functions that
> write_object() hands objects to, odb_write_object() and
> parse_object_buffer(), still take an "unsigned long", as does
> fsck_object(); they are updated separately. Until then, move the size
> cast from unpack_delta_entry() to write_object(), where the size is
> passed to them. fsck_object() only sees objects that went through
> parse_object_buffer() first, and so does write_cached_object(), which
> writes them out later; neither needs a cast of its own.
> 
> As a result, on those platforms:
> 
>  - "git unpack-objects -n" handles objects of any size;
> 
>  - a delta with a base of 4GiB or more and a smaller result is
>    resolved;
> 
>  - an object of 4GiB or more that is not streamed and has to be
>    written, including the result of a delta, makes unpack-objects die
>    with "object too large to read on this platform" instead of failing
>    with "inflate returned -5" or being written truncated.
> 
> Truncating the size to 16 bits where write_object() passes it on
> confirms the last point for a 70000-byte blob: with the cast,
> unpack-objects dies with "object too large to read on this platform:
> 70000 is cut off to 4464"; without it, it exits with 0 and writes a
> truncated blob under another name.
> 
> Triggering this requires processing an object of 4GiB or more on a
> platform where "long" is 32 bits while size_t is 64, so no test is
> added.

Phew, this commit message really is extremely verbose, and I eventually
lost steam reading through it halfways. It's good to document what
you're doing, but this here might have gone off the rails a bit with
that.

What's worth documenting is the unexpected parts in your patch, and
things that may not be immediately obvious to a reviewer. But you also
document what specifically you are doing to what function, and that's
quite obvious from the diff itself. So overall I bet that this message
could be condensed to half or even a third of its size without losing
much information.

> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index d2f25bed49..9bd355b2c4 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -269,10 +269,11 @@ static void added_object(unsigned nr, enum object_type type,
>   * to be checked at the end.
>   */
>  static void write_object(unsigned nr, enum object_type type,
> -			 void *buf, unsigned long size)
> +			 void *buf, size_t size)
>  {
>  	if (!strict) {
> -		if (odb_write_object(the_repository->objects, buf, size, type,
> +		if (odb_write_object(the_repository->objects, buf,
> +				     cast_size_t_to_ulong(size), type,
>  				     &obj_list[nr].oid) < 0)
>  			die("failed to write object");
>  		added_object(nr, type, buf, size);

These casts here make me a bit unhappy, as you also have a patch series
in flight that fix `odb_write_object()`. So you'll have to send another
patch series after both have landed to remove those again.

Would it make more sense to defer this series here until the other one
lands?

> @@ -299,7 +301,7 @@ static void write_object(unsigned nr, enum object_type type,
>  				 &obj_list[nr].oid);
>  		added_object(nr, type, buf, size);
>  		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
> -					  type, size, buf,
> +					  type, cast_size_t_to_ulong(size), buf,
>  					  &eaten);
>  		if (!obj)
>  			die("invalid %s", type_name(type));

Likewise, even though I don't know whether you also have a patch series
in flight fixing this one from the top of my head.

Patrick
