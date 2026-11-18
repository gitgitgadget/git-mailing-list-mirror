Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008835;
	b=koqLfpIYDdkk8VUGFFWad45iszLoM80NyllMXfVraERT60biOipY89r9Jj3Mng+pFqQi
	 6pZFmGHNCEyvJogLp0ZwxyxPkAm2MSau1lu0OC3FzHKX7FUmsU8ytVCgWBS1cAuihcoau
	 RwXUF5hS9n1tg5a+paPWn4C3TKIDzEsSy8NYEyd06I9OKYdpMgpsJXxDWlLrkUK0o6kf2
	 7H6ZbBPEgkuSix+SqaiVevwCrbbB7LePfS7TyT0OIr0B+cBD6mc3TaqLavk2SzBTrwqOI
	 Rw3Eog2EG2R+BrHPkW6ON7ZcpzVWjQviedwYtqGyzRdExS/FxA6ODzvBUA3GS1u3fkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008835;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xKZSqEZclzNlPiTMTqmVtUzv4864R2lQTJKpBPcvn78=;
	b=NJzgTJFjXUFfwMlXZLrhoWBKvF/Fm75w5EAbV3yC7wmz7cBYftSNNdwMKm2+02t/y4J7
	 sXe2YZwGAuJByTeBC9O/Y6ZUSyNYKBo1mxpiwGJnsMjVtxQiaN3cs2yIrwL/BOJrJmqbj
	 Y/kqtVAtEJz/hwFZq0UExODcSf7qGM15geYq5+ZfM1nsobFggZJFpZxTRbyQLOdf2+62L
	 p8Y3zeLdIJSnTt8AEEJ+Lr5m08ssGJbw0L8lXijRWOeKB6B2f67XDXWB4S07FpK/oHVts
	 BbwQGVTFek8p6GJ7iKcbpxwjx674cwO3ti/HgeOIIMePE/GDzNkLK8K0UU8OuGgyRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=oxJ+iy9b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gMGY90RQ;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502E606A330
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0502E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=oxJ+iy9b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gMGY90RQ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DC3DEC0AF2
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 08:33:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 08:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795008834; x=1795095234; bh=xKZSqEZclz
	NlPiTMTqmVtUzv4864R2lQTJKpBPcvn78=; b=oxJ+iy9bbPkRJH5/nomyZkJ6+W
	tW/EnFxtxE6xWgm1QBm091v/dhvcLzpqOrDwbu6QQ/HcSO8j7iLC56cd7GYhZmmg
	B64LQ9pC9udca9vj7HoTdt4XQ2KzmG0qhoTEdyeiHn+H8oD1IE7iYd/G6tRAbnT1
	xyiLdhA7RSmdfT3CYhcWg19oSUvKr2LDwgoH3Di7PcDme3A2Ju8mwu2e3CWjjWdC
	Brb7sDNfkGUZDl07W7Sx/ZOLU5lQLOGslCRDPb7M+swL9vHsgX3lkC9udBCrjXDV
	/e+YpZy346xSm+e76bDASvChBAQudtribic1FmplGm9vQcW0diagCvsJ9osA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795008834; x=1795095234; bh=xKZSqEZclzNlPiTMTqmVtUzv4864R2lQTJK
	pBPcvn78=; b=gMGY90RQCB/WJJ1V/ScPZHyeRlP9TMItSr0fhbAw4ox1J5CUWh6
	LnvzX/36NcLA2yUcPzRlw/hk86tx+wnuCnI/iE/ht+7wix9ajOjxAq9PfipmeuwK
	ocklHalmUxmx8quS98AP8+oqtaXpSvohktbvbAWDb6d/tUUzZlx/HloC2UVj/Mog
	DUIfflgadgoOQOcYPyHxpca7skectTjk7n4FiWVqu0IeVdMGOacwKJo1GJMzE0EZ
	68pKCeDokCk5+kz94TNKkp9DD39UK4Gftal155jZUsQSxQjGxUXdpGm+CDXbhMe2
	BbFb00VfHbOpVYqANuU3ucu2BW1RexsABmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795008834; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:q0VjgwJiQYXR2qAmvgV8Yk+ZtPbiFsF9sjia7IG3cfD8Y9J
	C9RX4wNNQAIPfkdhy4erEPjmSh0Z5CWt9zCsl/3MyCK8bRek0A3GFfMGmKXN26iw
	Aps0HSOFfUnDgc2Xec7nlYeZkDbunbE4GzBoqffQp64FG1oMZvGLil2sHXPFHP1i
	7KtPEOM8ZQUl5K+pEXvPXg63zYKopQfQeqhAPpiO8ncXOge+vf80JjToHUWUCgAW
	5+doFhnJvf9HZCwAlcX0egjmyoZKr6QiRnDKqOJBrim0oyHadQoF6yktJBhjz3fl
	v+xj4ATTN5mMsmyNRnzI+v69tlPagxWPHaR28jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JWi2Nx3M4ELvfcEUh1tG60ZxSnWSBBLM7PbtnJXf5Kw=:SPZltqPO7WOC/Z91UYVe4zqj2i/efB4L8TzH7w7QBzk=;
X-ME-Sender: <xms:Qan9aqzp6bCf84M6Du9nKV8_iY_RjaxDsCABE4x4KNlxRPxCx2E2QQ>
    <xme:Qan9atTGR3Et_GV0UoAv5Kb6_dgbQcYIHogzNgrgXl9jT9-sadUYKT37AyKSrBRGI
    Oru8aw0iWR31aMW9uwfwSnO_yJrXhWJfccwURvcMByZ4arwqeCveVg>
X-ME-Received: <xmr:Qan9ahUujEnMZ23Nuvx7lIyOSgBS1kz0YRRigS4ft1Sh9V3LZHglaw>
X-ME-Proxy-Cause: dmFkZTE5hpt/0lKaPYt3wgrVmDHJy9MtLzaNdgCDDDu8VNO5JWG98Y6uJeO64TW6bD14qp
    kIya8hrPq+r7pfB98N7R+gLpBtOlQ6JoJI4gumdjL0hyn4OrXXxB2LXGeHBM+jzDBfq0T1
    SvZCfDviqO2ZHenGzqEL5mqWD1CJkS0gH2dhtlchYnwbnD/7fmow+XaYJokg8B1zlYHIC8
    zTG/sVTolfYE2ya6LhIqzDa+H0+a9U7fDrYE5gbT0aG8u+kb945fgjOnRAE6AqswgtSrem
    9V7cv7WR5Gesk0LH7PdlJ4zKS+C48i+gLXlPpaVC3PzBgJ1sYeKsQSF5dlLbMkynCFCpom
    Hxrn2/m450ad5VDuwq2MZBJtYgDC/7VOoLM1hwkV3oZvIX1Lp+ZCAzbtLQ2o+JajHImYli
    wadU/79cW5XtwuZiCqIVpGntM517JcLNgcQrhWbyg5hSIxTVQ8WmhIMSqglIx+UamBxOXK
    KHN5waL2L2sjCM3cx81UcGlOddAg8uJ9WMZnfKPBfVa/gzcML0h1PjHt714/+1hZwCJJQH
    egMKy+rd2YBBLvJOp60G7PiY5oMQCRYvWcBAumTWEUGn5HbjBmtm6jUW1n4l9a2yJvhsG0
    lO9eSqIneFkal5I76ZBvoI/8cPC7S1pjU77FPgAQF+qY1UT0sTNeWL1MwahA
X-ME-Proxy: <xmx:Qan9avaKkswr_E2ZBiFzeH0trAqS08K324BVwkeRkfi0me1tQ32JHw>
    <xmx:Qan9an1kR99HAGz6KI9HTzJOM1KDmj3f7jnHNkwfZp2pTlI4-5mZeA>
    <xmx:Qan9ahhlgI0trJ5wcOAwxFmtFRD3nOV9EyIb8JIAUeQilFGJmLYMcQ>
    <xmx:Qan9arauiSQSN5YGAJSEHaMf650ZNrClPuJ5XsUcTgOkNboPlHmiwg>
    <xmx:Qqn9amu4XkIltfbycffMTv7BX9YOge1r-YtLL5HnKVVOTQLG-xSYo2Aq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 08:33:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4014bf36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 13:33:51 +0000 (UTC)
Date: Wed, 18 Nov 2026 14:33:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] index-pack: use size_t in write_compressed()
Message-ID: <av2pOWbYxNDYvS9p@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
 <cover.1794984184.git.gitter.spiros@gmail.com>
 <9952f0fb104450461661b3f8b5f646760198744c.1794984184.git.gitter.spiros@gmail.com>
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
In-Reply-To: <9952f0fb104450461661b3f8b5f646760198744c.1794984184.git.gitter.spiros@gmail.com>

On Wed, Nov 18, 2026 at 07:56:36AM +0100, Elia Pinto wrote:
> write_compressed() in builtin/index-pack.c takes the object size as an
> "unsigned int" and returns an "int", which are 32 bits wide on all
> platforms. It is used by append_obj_to_pack() when resolving thin packs
> with --fix-thin.
> 
> With a local base of 4GiB or more, write_compressed() compresses only
> the first "size mod 2^32" bytes, while the pack header written by
> append_obj_to_pack() records the full size. Later, when resolving deltas
> against that base, unpack_data() encounters an early end of stream and
> dies with "serious inflate inconsistency". Shrinking the parameter to 16
> bits and using a 100KiB base makes "git index-pack --fix-thin" die the
> same way.
> 
> Use size_t for both the size parameter and the return value.

Hmm. It's probably an improvement, but the only caller does this:

	obj[1].idx.offset += write_compressed(f, buf, size);

That's a `struct pack_idx_entry`, but its `offset` field is of type
`off_t`, which is signed. It feels sufficiently unlikely to ever
overflow, but should we verify regardless that we don't?

> Triggering this requires processing a local base of 4GiB or more, so
> no test is added.

Not even an EXPENSIVE one?

Patrick
