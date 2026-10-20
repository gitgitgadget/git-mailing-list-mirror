Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486201;
	b=a4nRxF91p1zVf0bnAmtSHLqsuWrnTsKyhg95/1fDPaO+bkXz1bzCpp7kXG54jiwkO2MK
	 Q9rRjV7Ysw55RKS03+fH0BJ3RwbFfO3csnNSlmgXv7ZWTJxJEoyjFU4AFOFyzHzBHnY+C
	 B2ipxfolxcT9Buyp2g0Tb93hyPYS/sD0L3qwJcEJKXzDRBH/ONwLF5T+T6nxlKDBKxyQZ
	 8juQ/Mgdb1oR1q67foLUCaUvH1hpXGyZgb3H1neXRfIxbKWs7PeHGMWM/+iKOsAZ9is1W
	 ltaPsJxO74ChfvTPCqR9YvDTjghYaQWaeZDpXcfepLoitcjA7EgiQLJCITkKm90PTLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486201;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l15Plogus5xaEAzwFh8UIVmW5NVQmI1vWNe76SmBqOs=;
	b=H2/r0GhpQuw0TgI7M0kWfUjmPI/V7ZVG8bK66kH58gAl0opLd8zoWkQ9Q/V5OjxoKbpa
	 BCsX2PVuh61anVbHG2se8rJBTyNLbIL2ZnSwM7kwGs+yNTZU0GuvvVD80R34RpicbXDkx
	 2e/uykHbvJvktvJQIbIDFKbqm12+PAdSJd4vp02gsEJMLJ8Qgxv1h5opQS3xJtGgYwYqA
	 //1cdDKqQNvwwsTgWIM0il8rCm+FIX/hoA9g+tFbO0FZ6wtdE/2IIK/pvHsVxkjYWuxbP
	 /M1PXV8IYqCBDWOHhPPrUWjUQzA+Fm/RSBpqvMJzcYekitLf4NEVjrqdDIUUkmP6Cig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=T5wsqdD0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YGig3SDa;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F5606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182F5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=T5wsqdD0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YGig3SDa
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 444E1EC00C3
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:50:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 04:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792486200; x=1792572600; bh=l15Plogus5
	xaEAzwFh8UIVmW5NVQmI1vWNe76SmBqOs=; b=T5wsqdD0XgtyYKIay9VHUDxEfk
	XAI8lnmoaVVEAHG15vjziaBOhe8Z4mjK3aajR/CFuGTAzURIphF6I6YzNFKw2qKH
	sypt6P25sH8f+QtoYTZ4JTH82DHxUO/L2xyrur7CLhdpPrh6BXmqlj21W4DJO6EM
	xLU8ePVs+xtt9NWB4GGPXCuIHDzf+nSX+yyw2oCqscxbLt3lbWHg9n28vJc8TlfC
	4DIbU69Np3OhPDSQ7zyey8WeRmHKK11rT/sjg/jgdkLeUUeNALDpPqkXwFNVTseH
	D1vqq/a4zUjQV0zbh+3BAHstYTX1dU4yv+WVsT38oIO66cVFjHaH2TUMExXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792486200; x=1792572600; bh=l15Plogus5xaEAzwFh8UIVmW5NVQmI1vWNe
	76SmBqOs=; b=YGig3SDaeSWxVbCGRlEhy8Dk6FeoW7qYBNqdGKU+HMq5l3mIjTB
	x/BVRQPQt+2QZGW2x3o6CQ3iEp2nhg4Ub9Ik30jEhYFNyjlGGBLxA0ye+IxZnLJc
	3HymJvbUkbOHyn52r22ELEC9c7ZddKKHSnAJHHnsfNjipv93ZibP7RNMnyPgSf1a
	dD6fI38rIVd7PSpG/oU6wk7JBzvGBEeDGXKP7IxJ808VGuKjIHL9rjNQMbP86dpF
	Dbj2Oig8oZ8laZ+vlc9NmWgRLpEI8NDZCgyohuJB/xBtzfTYgCXIVL5hXjp+Nc25
	NrS7UdYg9++DEZGd8sNnk/m/wPBSX7xoBoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486200; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OD0MDjVU3maES+YLckemquWONr9tMRJuxcs0UGSn6mUP03w
	NC9iEJQlU4H/8g4GPY8/mMAPSa+59a2lUvDtzvOd1KEWQWKrmyJtzV0kbeawrxEZ
	EcDiFPsYnGy476ntF7D/H0uRJIvnABI57G7As63/brNhTtCNocee6w2PHepZnh+t
	/eM9w9tbYuwiHazJamb/y/wsxMuOkpYuMAP1tkOVXv//tbaZsqhCJCvGROgcQ/wW
	uH0TCKq+GLuOysQRBi8n8xS/8Hw6imkHiAnct7YG59B9SFUydhgFEv+bycKcUzdz
	n+BYBSMkjOrWQ9MU8kzBntQnHBcaQE2+wtrU4Kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:T4qkaqvyzc90PymHjQS0p4U2D6sG6UI98Y7D+CjJFM8=:r4WhOBjvWCy6zZO6XvWgZc+/g3C2MMlWE2/QyQV/X28=;
X-ME-Sender: <xms:OCvXasLvEgSAizqSZZRri9kO4yP8vaLFdOVGZH2YVObwM_4I7IT0nQ>
    <xme:OCvXaiIB5NpDsjGOJDkrn9OQEJWHrHaD6Br0ZTj9lyXNYaS1I586ZN0wXqN0mrRGf
    mvronrqX5XVomAcE0LH2QLxFtiNkczyyn5JmZOxuR1LlUfi91LqfSs>
X-ME-Received: <xmr:OCvXaqX9ucfaE3V0yJJNVf5wr_SXQ0y5ylylQUXt9fEFtZfp2ng16ov8jkqRHBUVbPZvTg>
X-ME-Proxy-Cause: dmFkZTER+0MjEXmfms2vG1VheQlfhryGfOqLlK0Z1rnmKXvNzNENW+VwhhH2LvHNz2CsXG
    wU+ydYLDq/0EQI18HuRnq7OUkVt2auyeVJFtZQHFZKnw3Dx6SC2i8V1h59B0zJgaqiQaBX
    pI31w9WKzpYQ8GvWc9dgn4zROkVNk2zcnjU/ScToJwDmEEz7I+/M3Q8ZZarbl23zJeC9hh
    hNKszJwZFHdrnH4NSaGRPyDDPCKvdfXCy8h20Vkm2kb7o6awOp7VudnzNlN9dbfx+QEsvW
    goOqMR8yXpJt6//M81nnXF8aWj3qpRRMYjJqtqH96NJUybws9nVqUBKQXpZWlc+rSKB9ne
    4s6hLRR6Dhu9tPthAgetqTYpt/p8icO9kqonusYphfq7mezLCLxglRonTsTomcbMletRM/
    NhiXzsRRkUnkXVK9k2sxZnC8tFzT0y3Lr36DMzASp15tyXDftfNyEMoM2f25HyoLdT91TE
    uEF4BnZsGtdtXsreEwydaNf3QuLhYLJtCdesg1adsAHRi3mSZbkYGnMNWmgK8858yFQAGJ
    wO8Gks3ba34EG7jtsFAelxO21AjlltO42PqcV2GwNsbDj8N1zAXv5h0lg+EQrviZJNXb3T
    rMeH7n6CC3qEHBirsg97xna4tkcB8q4WX/ns8xZMMRFxix19D+xWpySo9Wuw
X-ME-Proxy: <xmx:OCvXakiGCTb89DXyD78kyPvElNsWAP7zUQZUm8NO_5uNLkkPJ3u7Vw>
    <xmx:OCvXal9a2bQ_6Oznc0l_Un_wY9e9MgWnW9islIrDqGZytOejKMVmDA>
    <xmx:OCvXauC_6JbETjGlJ8QI9_IfvD7l9-wEuis2NWOd4HWLVh8wQWAajQ>
    <xmx:OCvXaiKlkVviqYlqlu2p4FO6F7tLq-ehmYYu5zyxm0dUSiAgbpA-9g>
    <xmx:OCvXat6W07H4mM_xSOkjhV9vgBVf-sWgCSfn998I5D23qbv4Jh9yMU6X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 04:49:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6619f67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 08:49:57 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:49:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] loose: drop unused `repo_write_loose_object_map()`
Message-ID: <atcrJ2u9F_9M9wTl@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-1-143a5963b77f@pks.im>
 <CAOLa=ZT91C0OZE=h7B0j6mgPhfrGjkRN4bCT9gVEXdXx+bSi1A@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZT91C0OZE=h7B0j6mgPhfrGjkRN4bCT9gVEXdXx+bSi1A@mail.gmail.com>

On Mon, Oct 19, 2026 at 01:21:08PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `repo_write_loose_object_map()` was introduced in
> > 23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
> > objects, 2023-10-01), but it never had any callers as loose object maps
> > are instead written incrementally via `repo_add_loose_object_map()`
> > whenever a new loose object is created.
> >
> > Besides being dead code, the function also hardcodes the location of the
> > "loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
> > reader and `repo_add_loose_object_map()` derive the location from the
> > loose source's path. The function would thus disagree with everyone else
> > where the loose object map is supposed to be located when the object
> > directory is using a non-default location.
> >
> > Remove the function.
> >
> 
> It's like the function being unused is an insufficient argument by
> itself, so we also talk about why its incorrect. Made me chuckle.

Yeah. The only reason that I even stumbled over this function is that
it'll break with the object storage format extension, because it would
put files into the wrong location. I only realized later on that the
function isn't even used at all. But that probably explains why this
message is a bit on the excessive side.

Should I trim it?

Patrick
