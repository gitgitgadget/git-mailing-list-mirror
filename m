Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741314;
	b=LjkyzbLyUAwsWx+d/0h3osjEtyqiAmHOYRQoD8GgHK8uQpsbI573qI12G6odHsntTRfv
	 gChfTCgici2tOwR2rR5OUyOV9eLTSL6u6J0LkcjrsgHt3m2ot5iANjINogasz8visNFwG
	 W8Dim2Zpra2LxfAZC1MJHKVYNLK8qI28IgwTzP+AcTIV8+ihK2q0wTyAlMizoKRRAGQ6w
	 4CBqT7XAXpRH3d9oH00XWHzbg2w/yH0PDHXrIUSkTkdRgkWJoc9bWLJY8dUjvlKhUJ3uC
	 qUIDkjZtfkmaSWr7bGjMUKMq330w6i/Vq4On0BbtG50Eskw8psOTPJRBMxY7Lc4vkhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741314;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8LVRR7ofycXl7tTFoPNuto4VRXvwi5LiDUue7tacVVI=;
	b=DLqS8+2SQrGDyZOn/LFXyP2a+rNEoiFhxYipcOXSISMs87Xo/p8MgnszwGu1cfeJU7VY
	 1D0LI0BNYpkfWfUEqUNs4askdzcYoxZAuiUHExHsZ05EAQ+ZnZ8azX9FQgFzZD8egIQp2
	 bbuVL9PiVsdTveKcFGOCh8ZcL0hVhuOfrpDar6hW+xrfTmuRIARG9HXtXT3D2xw26Khxa
	 tkqEorQVKqoSG25KCwvwso2KvZeF8O6A9BnZ3nw1HzGbtpWKrv9rhqIOQ1wwKHA6Aw7t6
	 6lNpKpboUdSokfHRI5W9e9yemY3KBKM9aYSEO/DnD4f8iE+Mm5+qa+5uWw6FeG6WTXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BieTmqDV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UE0dpSYk;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA4606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BieTmqDV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UE0dpSYk
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2896DEC01CC
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:41:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 03:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792741313; x=1792827713; bh=8LVRR7ofyc
	Xl7tTFoPNuto4VRXvwi5LiDUue7tacVVI=; b=BieTmqDV57LwiZOgx1HfoYVaSP
	bct2kyFvrwBoD6e13jnnJtLCTwCNBOLqrwyTgs80V+5X5ymNRhj7EM30MUlmrIAy
	iDo6FFL4MdMpPoGGwO4OeJcjcV0plsv8TPBf/6jJ+vy0jnW2ZrnLcmGe996Hx7BS
	nsAjCNX70R7sNvayJ7zf8ocGgNoqzXBxh+rMRDp9GiY1xtYH/KeotxLrAGlxMPv9
	ZR/fMcSCQyRrdykDDDIoeVju6uHJvBe+McUjeaiSgq53ejgoGqp78R5gsnPNJpJS
	5T+hHDU3q44Uv6BdyNlJUNUQgJhmfm2Ibqalf7hoZ4/X1RB8JTF3FD0eRZIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792741313; x=1792827713; bh=8LVRR7ofycXl7tTFoPNuto4VRXvwi5LiDUu
	e7tacVVI=; b=UE0dpSYkCPZmbVRoMr0PRlrxabPKMS6eC5hwAi5svoxf64T4Wie
	Sq6Nx91BfbmgGJ9lzSodK7D1P3Tax/rLtvXR1lp20bMO9HMu2cCMKmb72rG6Fn/y
	8kYoUWvRzNbOvKzVLzX12FIchiEb+8v6Qk/j+BAP82y7m0GUAHNh6UJNiBHu/IvQ
	VXCnnMX6SmdUY42nQoRthhdAS9FOI6JHtBZMe13fof8u+eFbd8xKsFvI/8xDWzcl
	iQIgSQu2fb3xFod9CjU6LN56Uao/cy7hhIyF8UcW/F3a/TyFMzFnINpxMmQRMiet
	D7kO1CWDBjA9Ac0NGsM5HYWXc81vmyCHYsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792741313; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ShwMC7N6yjzL1+xFX9ikbi4yswCaDewibFpSCUYb7QHcKIi
	FydGGq5I0uDzaECuNUdG8qkRy6Gvt3DhZ+9bluzozfo1oTZ30bf6DOrW82YT8Aa+
	Z4S8Nd9YcUHuD8aDDxO0yG3dpfaittp1t/AxKWMdhgaFeXZC2+XVEU8xsUqKqS1I
	1e68z5hJoSXfOeCUeyiQoR0GXRXQg3PAzOHGkn/mueCt/2nkuTHf2JeZRV1Q6/5G
	L3pFFp12nbNKN8W+KTO0qMjZhs4kv4S4JyADTfBAPSae//xiK3Bm1A1AwllIqNW8
	qtAQZF56gTfWXnnA8UPUvjZh0J67CObVXmogjIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fDYMPflBu20zqmjZ3zDgybtKjwCjIVTRyOwrIzpQIlo=:tjyTXXz90Iy5WHyQGNhVsEUguho0U7cuhyk+gDPiubw=;
X-ME-Sender: <xms:wQ_bavBIRsV2cC-XL-_wyB2Sw2_uhrFqNdMwcxxJWsmw7yNewT4jVA>
    <xme:wQ_bashu4-SU_xNpzT2DuWV-9bghTVOGHswCreVVqs0E0OhGBynKXtzJypLrU1G1z
    3sRCmozcpAZRL4ftd_B8gBPbpEC7hnQmu0ZmrUSw7G8aScPqFR5SXtt>
X-ME-Received: <xmr:wQ_bavnop8jTbC-GzjSJ71up9R6rL_TiUQBYVcLcy1MzaJJf48pKePH8Q-VQojk9vFoWLQ>
X-ME-Proxy-Cause: dmFkZTE1BSYelhgU3HIyXY+Ly9zzI2tfFjF5tZnozO3qDiuRhEopl2OCa4Ch79Zn7ybboY
    rAfkrO+FFhYMlFpVnukXNn8LF2sw7nR378kGHezxxPPEBfNRw50nYn/BMk1zefM3kkLTje
    nEJjFXilggA+bnvYl4eH7fyxjDZRGeVRKL46Z65bpHcLmRs6h2fdEwRSb+kOk3gCVrdlQ2
    hbCl5FT5Y3hSf1QHVCv4Y6PA+pXd3qsRDE4ELMp3sQ/Af8TIkOdsvjQn6ttWEAHsGM1/kK
    y9jkLDjTpDwkzVncLCURIA3B5EnYO1wdZQCNUb/qjT8MfjzsNQIgvTd8nThNd+u3UWA5P0
    A7kGaS+zSoxNOeZZ2oxTqyMGeSnf0GU7LgoiKoIB22P/dt7L7Ya3MR4EZXg36CGjjM8P7B
    rhBdOMdN4K8RIITWsbW42sq5MsSgnH1Sxgr2eXj6zxXzRNKP6krtrS5FHidvhVjfc0MUAc
    8hX/PNZKqoId2Iomc+j7/O9yqc5WSvhD0cV/WsdQLs8KethcNeQbbW6whVOe2JLgdOpnCy
    yciT1HSjkZKpdtnmVjRzlRc0B5TAdK1OkeidD59p57ZLRDx+21UvxrL3Re8tHyZQbV73Hh
    /NH3ZblPq04yF1LjViRFUtxLTUVGUN7RO4YXiFRcvK/Wy0k3ppLD3GzbW91w
X-ME-Proxy: <xmx:wQ_bagr2ede20M9SGC50a9tjG4RNYSopOFvafs3ogg3_uDk6LJe0XQ>
    <xmx:wQ_bagH0c3xCowjN77uxefV7-hoQNem4rQPONzGF-bKCHcYG-75xzw>
    <xmx:wQ_bakwYGkhN-SNzlcdxjldaHy4Quu4M33jksU4bihXUaI-DIFMYEw>
    <xmx:wQ_batqz6_rgXeJlTFShdESthb0wYvW9ao-_7vxnnjd9KuoB8HNc_g>
    <xmx:wQ_banGgUbYl-esJvfZYYJc36GllI89-fU7OJCjkiQ46i3KfTXEXuENa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 03:41:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffec1fda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 07:41:51 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:41:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/5] doc: glossary: update per-worktree refs
Message-ID: <atsPvF6wVdugtwrH@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261022212903.177261-3-andy.koppe@gmail.com>
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
In-Reply-To: <20261022212903.177261-3-andy.koppe@gmail.com>

On Thu, Oct 22, 2026 at 10:28:50PM +0100, Andy Koppe wrote:
> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index b2c582254b..eff6d23215 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -494,10 +494,16 @@ exclude;;
>  	interface than the <<def_plumbing,plumbing>>.
>  
>  [[def_per_worktree_ref]]per-worktree ref::
> -	Refs that are per-<<def_worktree,worktree>>, rather than
> -	global.  This is presently only <<def_HEAD,HEAD>> and any refs
> -	that start with `refs/bisect/`, but might later include other
> -	unusual refs.
> +	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
> +	rather than shared between all worktrees. All
> +	<<def_root_ref,root refs>>, such as <<def_HEAD,HEAD>>, are
> +	per-worktree, as are refs that start with `refs/bisect/`,
> +	`refs/worktree/` or `refs/rewritten/`.
> ++
> +<<def_pseudoref,Pseudorefs>> are also specific to each worktree.

Should we maybe also turn this into an itemized list? Makes it easier to
see at a glance which rrefs are per-worktree, and it becomes easier to
extend going forward.

> +See "REFS" in linkgit:git-worktree[1] for how to access the
> +per-worktree refs of other worktrees.
>  
>  [[def_pseudoref]]pseudoref::
>  	A name that can be used like a <<def_ref,ref>> to refer to
> @@ -788,5 +794,5 @@ and pseudorefs.
>  	"working tree" and repository metadata, most of which are
>  	shared among other worktrees of a single repository, and
>  	some of which are maintained separately per worktree
> -	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
> -	per-worktree refs and per-worktree configuration file).
> +	(e.g. the index, per-worktree refs such as HEAD, pseudorefs
> +	such as MERGE_HEAD, and the per-worktree configuration file).

This is a bit curious as you distinguish between per-worktree refs and
pseudorefs, even though you mention both of them as part of the
per-worktree ref section. I wonder whether we should simply refer to
that section without naming any examples.

Patrick
