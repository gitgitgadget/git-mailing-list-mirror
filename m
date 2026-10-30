Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352821;
	b=VkpRGfGGx+I1hSe35WnKLHj5z81uvHsvyrUEwmkTbAvmgveb/nQclKqIkFVOiWLPmBx8
	 nazs1AGp+x2kowq33u1W27bSHJEJhwSWlDylQv7yFE8vA7Bvrdgq05b2PVK599N25h6kl
	 eKzPttKaL8GcutWFSUdxmIYEIUZ6OnR1AMko57jpTOylf1OgfObMmQtfDCdhCrfXMyD9j
	 GfH62nDQ2dXQMCYQ45eDKezeWvSon2WoQsV7NDC5XPdfpy+YZ27tk3imGHNglL62EgucO
	 dma4IRWX8XJUCMYpJuaPerMNe0x7yOxCQY1jJSkGX0YG4RXDqsUBly4Oil/cX5yO+NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NrpIrqGmnjziLqWSzHTnEXaoB5izcLK2rhcn6zCNVtY=;
	b=L46dgY1ztY9HCmc72evjIaIZwBFnU368MA2A/deirN/g4qOx4UPXRvbsDoBOlqFkkpL/
	 0P+lh98x4FZ74wsrpYDCUAp/wlwUY5kLeLQherJ7vADlmjxlxuiNr/VcoJhCbmxt/6ZK7
	 NRh036LrP2NT3VfAT0011PekRagNvPdSd0S94YHQGv8FfIixOuZfpVduazDacnijpjHGN
	 UPXvUbcPa6+v3wjhErqTcUL49X9lsCFRwFG5FI6iGhxfT4m2BCgAdftL6qYRG1gOcZLVc
	 ALN7AWMWOfbefhe07a0Su22uNwdzrabyV3xQzMD9QWE5TiE4tpop2GKb//MLhAPm7XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bpZuc2Ob;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M5FKsllm;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF00606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bpZuc2Ob;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M5FKsllm
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E30311D000F4
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:33:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 05:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793352819; x=1793439219; bh=NrpIrqGmnj
	ziLqWSzHTnEXaoB5izcLK2rhcn6zCNVtY=; b=bpZuc2ObGwQcQrlrL76Zv67vQp
	J6XBBAAxwLGbqU+N4DH67VBl/2DW4fAkk1K4i+U5/fe9fBC3S0vb7Icv+p0HJ296
	I2Vk0qOi/Efy3bV/Gutc+y4xdhhcATpBeAoKgcm1RZAoseyGQKO29SXNzp+sg8q9
	RFy1AJR/4lV4hcnhay8jPbO4qhgmLj3mKJOw9G3b50PYsPXjC7eQEOBwzY8Bh05v
	MHuk8mjTJA+QsENWkB5AS5Vz15Dg82ogfdZEiiTOhrOB6jF+QKP+P8Y/LPPbLEiD
	lSpCQxX45cn1EFqk5KUlXf5XZ6YQ4bXGacC+7gPXpkgwzHc7VqBh3uIF1+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793352819; x=1793439219; bh=NrpIrqGmnjziLqWSzHTnEXaoB5izcLK2rhc
	n6zCNVtY=; b=M5FKsllmLiy+zyDoZvd1+cZpx99zxqVt9K/lBpy232PpC/pGP5Z
	KUBz64KIFzwyooExjDvNg3t+xivcrg8uzO783xhyLhh9G1abjOhVQ6DftO0QMHQm
	runom/3Sgw1nrZiyGuEfke8n5FjDkoqrJ6Sil6dx0FWzu+clInS0f0l+U8D6+NhO
	kYn8lArj2N6vN8XE8NYq7aIK/WYSUP1PZ/DgUndFVNoqMWNq32a5skxDkWSWQBvy
	ujL4IDMH3Uqkgri/iekKNI1TFNdkceMY5lFuBBEFlUnzcrtcrO+8L/cDmQ6hVLm+
	8hNx3Ywb9siDRpeqFCXwUD2+6FcwwTrPlUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793352819; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YGS94M1oN7ye5wcMlZowDYuWbqinD9LVivc/6E2csAZnZGR
	TWWO+V2d6/Qu5+wpKRgbiN3IoAZHsvKU/CNZaPGx+G9KTUgVRy8d7b3ZqJu3cPjW
	hgpkdoe151qDJUTYjyCP5lBHQWHVrtZyF9A4a/fFlTxXz80Ubh5Rc9d84ku4hp/K
	PnfWfWLUpqDnWmYBzLhkA8ULOmXhZRB8S2mu96MoRD6FfvY4zO0sAsJ1RpN4sXG4
	lppSmJsEF+UMntPj7snSNGiWNRk3fSKnhmXBJJ5pmfVkrhH5Eo3Wx0lp4fAKe9PL
	/Nng1Nx3AnDj1G0JNEPLDGtcaf4taj5ImJuGCow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AcHuRYlulTIGfT1/VfT/wZcUvYg1qPC0TPMPTY9QGaQ=:TeNGnodOKsM/9cZkGvHkNuN8CoTic3t16rhTS4NepFI=;
X-ME-Sender: <xms:c2TkaoIII-IbmJvF9JwoZnxxBm0w3VIW7gQtDwq_GE34YPrxsyz-Fg>
    <xme:c2TkauIK-y5McsjNP0_wfwHqepoRrfrgYpk-4ixyzLklNFaaGACaxeuNdNKbqjr-D
    5sgA6tEzHN6N7ejyV_d09Wo5iH9n7LsOE4jcLtBpHjCKVqdk2Gmng>
X-ME-Received: <xmr:c2TkamWkS8V8fXq6u6VG_KTzFz7dB1WGzSnV6sw9v-E3h283_7iHaDL7ECS-foXfLs2ALA>
X-ME-Proxy-Cause: dmFkZTGRZY4YCBZrvUrHvDlE/jjv03hzDxaVpt9lb+sc/iK/resYoQxhwT/URiv5sE6kDx
    i0UHay7yxwkcvnQKH4L/eLIng8VEmy9bsMRKVSaj8NUHP/ARtlUOp4i8QBMZmdY6i7hOj1
    SGkzKN6tch/HfaFKiP9U8xgJf74SVaTK5d+CdHz+/3/HEopQVaz+yINReMPk4vK8+Azy3r
    sC6gXHMzBoRgtWfeJdhzdzVhhNEm8wXRnzinjsFWohByRFZ4CKD3NpkNKrBqV4b9OlPsYO
    tKkch12GoJR3Mnm1Q9ni3ej6U78v2Nve7qeO0EiEYwvJhd5PsevKdNbl8WxUwIrdMh1QCf
    RZ6VPcHAokYl7RlDvR3AcCjYiEahRuYEwilz1kZ6+sjBnhWh5AcX+Hplem19YzPdHoooF7
    mZMo4VDbMUbZ95Ie2vFozNZq0CWJ0KxTKcFZTPfZ9IrQI/e0QglRKLo9ERJaypYE0+os9u
    lNFZxq2RZ0o9UX7dpCiVEaMP/EfQY1YBOMN6bWOXSdsyJpFNAmhG0G5OL5gca9wjg9/+NU
    A/ZVSVZuvBZ4jWk+6VprYL27PbzRpUg8DBZwNhCxmCXLYTJK5UsuRUXHDGStFfggnM8cmd
    nD64JLR9H4ld9dHsczJnnpsvdNdG+8XP7xwX+57PmhXdsUSBpNWc/dhmpx5A
X-ME-Proxy: <xmx:c2TkaggG3kFEMv8baktfeUwHGMbhjJzpGzs94Lt60j07xv8o7DckGQ>
    <xmx:c2Tkah8_Gu5z_stgu_RNPh8U4K6PgvAWCsbO8Zj3fr755vncLPBE7Q>
    <xmx:c2TkaqClDqZIdUhPkKa8PuBm6gBF4LRqgQKReHyEBSWMHt-LysMc6g>
    <xmx:c2TkauL3HigQ5s4bbY4032jgs8J6uAh7XQx1rX4gSSmeUQghae6G_g>
    <xmx:c2Tkap47Zx-ja_jSbkUrXk0hLQJLua-Fu2ikOU5kQX9K1DuVwpsiMC-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 05:33:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25506481 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 09:33:36 +0000 (UTC)
Date: Fri, 30 Oct 2026 10:33:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: config/log: fix typo in git config docs
Message-ID: <auRkba74Y5LD0Ubc@pks.im>
References: <20261030-config-typo-v1-1-f9797f518c43@gmail.com>
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
In-Reply-To: <20261030-config-typo-v1-1-f9797f518c43@gmail.com>

On Fri, Oct 30, 2026 at 10:47:20AM +0530, Hardik Kumar wrote:
> Fix an obvious spelling error in `Documentation/config/log.adoc`
> "overriden" -> "overridden"

Tiny nit, not worth a reroll: we tend to finish sentences with
punctuation.

> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
> index f7dfce69b5..cb82f521ab 100644
> --- a/Documentation/config/log.adoc
> +++ b/Documentation/config/log.adoc
> @@ -61,7 +61,7 @@ This is the same as the `--decorate` option of the `git log`.
>  
>  `log.graphIndent`::
>  	If `true`, indent visual roots when rendering the graphs with `--graph`.
> -	Set true by default. It can be overriden with `--[no-]graph-indent`.
> +	Set true by default. It can be overridden with `--[no-]graph-indent`.

Yup, an obvious typo with an obvious fix. Thanks, this looks good to me.

Patrick
