Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701047;
	b=vUvSfURTjclM4dSJWCUNbWE+xm3NCwHRNCDUvS+daDxcT/cD4TQuL5HInKxs0TlK30Xd
	 Hn4paiocAeNCXhSuO7kXM03+5NBbTP4EoZzpkddPUoO9QE81ETiFvxp54zmGfgua523UJ
	 qnu+bNRg+aoA8B3oQl8XDIYmMSNVz0BmEGflcJBVi49SdLwhR0SVCFu9QDNR6BirK6F8W
	 C3o3v20uVPc5pwPuKAsSIbBdpEWhmO84M9bVqTFll9K+nlabkUPZlfK7/Ki6LD/U4S1Zi
	 rd9J9FMozgk0hTTF/IGG5AKMLhZHz1iwfb1NU+olhts8mJuCyzdyZg1UiqLdGumFW2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pxZrGCc58mERlIQrGudkICS0AufmrUO9ZXTQzNeADGU=;
	b=wXf/+oUvdr07odBvWMrXMqACqCwnhApFs7LpswZbHUHZC1d9u5zfwrvP8p4qqPRR/YVQ
	 B+/50AQRL8nhoyMg3wuFqUGOd2ft65+YXWF3zZL27TiJGXdi6bEPwAeR6z5FSxp6PxwSU
	 qXNB1a1FLMICrVv1cKMuRktEi8WpP8T4nVgCNbLNA3ectIBZfSmgRJokIlBDGU/b9AeOz
	 VOrFOAkiAfdybdjCkgqsTfovqkgbgpGwQiMSPyxn2GRCHHMC9CshHaC1yJ0DY792nlysM
	 hbjWsYALwPjaSF6AvUP/FettEWIffBhhLF1iKi82b3K+rr5+6oXd0ysjQv/hGlZs8AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="QRE/1xiB";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wploVx68;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3113606EEB9
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3113606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QRE/1xiB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wploVx68
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 211FB1D000D0
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:17:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Nov 2026 05:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701045; x=1793787445; bh=pxZrGCc58m
	ERlIQrGudkICS0AufmrUO9ZXTQzNeADGU=; b=QRE/1xiBvIrOSdMxb7wAeGXCFZ
	4JOP0MJPRt2JyO785XxX2at7KMRhpK+t/50oWNkScDNwqD5vn/F1Rien+bE1sS3Q
	+BlGM5VfBCn5moAlYxO2WhGG/RhdF1Hbgk4q0Aq59BEhHG2GXu5Hsj00T3MkJ6ac
	x9mJjVlzZOu8FX4/uH39YXc2xJcdpn1Jmb8VEkj4ygtmlxpvbtNcwKydFXr+jS6Q
	xJLK1kFI6rk9/4GN+/hNeUzsmF+FN02pbTa3Gb+moDzqh6gtNXIe0nIzFJ+GsyEP
	/u5ec1+GPKZIkU/Z6Uo5nZUk6tDEz8HUPhMICg1GRTAd/FTb2Xr+TJZXfurw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701045; x=1793787445; bh=pxZrGCc58mERlIQrGudkICS0AufmrUO9ZXT
	QzNeADGU=; b=wploVx68Y5eGErknzgiD00NOM3QgYoM2Y/l0DICN2CNX0ZZEBn2
	Zcd67dDwXeJ3qtxm8//6tElrY/nXI4sThiR8DCgLG4KZs6zYlPxYLGRUyB2MyK8l
	EAyzjSSboAFfFlFLNp2h6hd2DEXld7x7EjhAucqgJAobl3GKtiOb7IlqFQ0lfCeK
	V6VMJlwZrT2XgzJfwxIfklFuf237fWqM1HZh7rrmQa6awUgeDcHTWoS0LlDypvmK
	aD4IPp6KJZNWf26orpOIPRxjPWRhiJ6QJdqf3JIHUbU9F+gsGbMOfjwjRbyTV/+W
	HqlfcS2ApNYF8m/+k5wH4HaF5mg5UusZVWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701045; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bz2klyqSaLHvHfXz4r4jvmp7QSi3ToSBg4cxhvOyosC92QL
	sPPzmp+Y8oiktEwZqPy0eaC4qcJHSIiBefjXT9j07nB68Mxyy1cQkHRl2SvtftcN
	5LQvhmZXpaMkX7oq1pdjKN0k/+mjtXvC5bPKfCdXuWSNemZ4sumH/Db/r8ba2f1y
	jjZEuM0cM4IHjIfKjaO70uXRhfwG1AJ/sEUfDqGUMZ7Z9/3z5BDyr7ni5jsPBjFa
	V3VCUJ9GMUdvSmDKSzpA5bwym3d4lCgto/4axpG4AA6x08ootY4UZU/bbmu1oz3Q
	M/hlelwD4HeVr9Tsm/7O4gOVsi8DjCg8porb7zw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QR9ALufnioEQqRIEbb1Dhv9cFrALOR7WB4Oh32AIxdI=:ZFoxNWTxOx3tDwGGVki+Ri1vrSz+BFy3OHnkwFXEqQY=;
X-ME-Sender: <xms:tbTpanNMeBVZlZggynSzcy6VL9Oio8g0hUTD345YO7qikScvOhcl8g>
    <xme:tbTpao-fGtC62xIDp_2_urZ6g1g2xmL-lsyNJxgcAtiSy4pIGiM8bR_HsjWmK4l1t
    HImPa7ehAaj8J1KVEfFUqytKdwMXW1zfAuS48BF4irIfGQHAOIrcw>
X-ME-Received: <xmr:tbTparR3bg7o0I4OBzozAdNMUlHyjm9gw3mylDo2yJEQB5EW4SV3dA>
X-ME-Proxy-Cause: dmFkZTErF9kKBUv6Loq9o4X/AF/Uh28bOqZDJb4zVatY+USv59LDODSHeJt4BMPW7PnNfE
    S+7fSY9HcZxyf0HmwBkAwKTYkxoktCUfD6FxkDy4Ek/6f5czWlk1hvUVeVJdKBpyLyOEcw
    kGg+SDP4CdRjr58EqRasJZWGSOXrnTuO9JaBJow35bH+rm7eejfym09pbseZdq+bTne19/
    HiYa7lyDaDRLHqfDE535aqoEIPKJDbaVS8IrBbO3efrgl9ZQaEvXKRiTXC5uy27L4jTpjB
    jy7m481W6GcNm6V1Tkzo6fnby1ZAPBGT+xFoDoBeLeVigI6CeFU+LN6BzFh9rVr/O2jvjh
    ks8QiSxETPItNYf/CVLIj4rgha1EN/mL3wBLpgX7z/awgP5HFuW2yPpNrccBxU7rQ+uLFI
    kNjpeXxQmmV46rdcVHR2mM2HcfV/MiVwQTeuMzRWiawm2ZBVGE8kc/NfMcYeXBti2Xhx44
    9KxH92OcFnWobV26JIpdl1z1zCyv8OhQ5h8iAKT1/IhNZqfI2Spu51cMCNCUWb6Q8sA2gt
    6aANe4tTBVDArfTtyBnylwcEph/io2qz+eRl5ePMzyikG1AkYxI7auXmrzm5YtLbhVLEre
    IfhhWtuQAJRM4GYm43jom43XJ4XL9fgJPJYzzBxR7HRjIr8PNs/6wWgvZGsA
X-ME-Proxy: <xmx:tbTpaqm9pK-I_k3_WOkAoOMDpjURwMbalq3m1FLEBS3DuQ668UBAlg>
    <xmx:tbTparTMl95xYPKTZtPjdC-6VSQPILpSP1uMc5d_rO_yTmDkwjJ0Dw>
    <xmx:tbTpaoMuEkVaQqhmYhAbN4Lno6U1-2e5XDudC97JV3-SsKz9zx_aLA>
    <xmx:tbTpakWTNsGdleq89XicQ786n9wjDfIieU19bxm0XnCa240mwQoQPw>
    <xmx:tbTpaqpoXBdY2ysAgRWB5x8Rzi2SuiXcqzGvxUXi8Oq0eUP5QGmLPJQz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:17:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39306697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:17:24 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:17:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
Message-ID: <aum0sTUAqc27DU_W@pks.im>
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>

On Mon, Nov 02, 2026 at 03:47:09PM +0000, Kristofer Karlsson via GitGitGadget wrote:
[snip]
> The t5413 test that expected the check to accept a commit whose
> original tree is incomplete because a replacement is complete now
> expects a rejection, and the test that disabled replacements
> explicitly to get one is redundant.

This here makes me pause a bit. Do we know whether this specific test
was introduced intentionally to make a specific edge case work?

> diff --git a/tree-verify.c b/tree-verify.c
> index 25db76d30b..c228235150 100644
> --- a/tree-verify.c
> +++ b/tree-verify.c
> @@ -133,7 +133,6 @@ static int verify_blob(struct repository *repo,
>  	vs->blobs_checked++;
>  	oi.typep = &type;
>  	if (odb_read_object_info_extended(repo->objects, oid, &oi,
> -					  OBJECT_INFO_LOOKUP_REPLACE |
>  					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>  		if (vs->exclude_promisor_objects &&
>  		    is_promisor_object(repo, oid))
> @@ -163,7 +162,6 @@ static int read_tree_object(struct object_database *odb,
>  	oi.sizep = sizep;
>  	oi.contentp = bufp;
>  	if (odb_read_object_info_extended(odb, oid, &oi,
> -					  OBJECT_INFO_LOOKUP_REPLACE |
>  					  OBJECT_INFO_SKIP_FETCH_OBJECT))
>  		*bufp = NULL;
>  	if (*bufp && type != OBJ_TREE) {

Nit: this might have warranted a separate commit as it isn't even
related to the connectivity check, is it? Did you also vet all the other
sites that that verify objects?

Patrick
