Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564750;
	b=Wv4LOB/FnazsKI7QcCBCrCzl0uHJwQk1Jpn62RqHEs4WowOy9mpRZ2AID1nMyB8pIkJA
	 p5Ef/tBI6BAVvAUX7joYbprW02xxLeAvbHJumikeoO7n4mEywLHYOcXmM9tHQO1PYe8Om
	 ODo0u0JYR3ukpMKk9/pMJYAP1A9v64ex5FYqf3OwqoGyr7SrcQV9mWA2u2744KrHVkKXU
	 hxuwAlTuaP6P6X02g0KxxH37dRvXwcUWJduLacBGyPetYYv7dgddtqhwQKQbbPKWoWiar
	 LJ5SgNL1a6DDdftbXfvWdghN2DVDR7OgBY0Mpuqkg3MidTKbYqe8VvL9Xk96CO2PRUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564750;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S3nmzjwAtBo3by4nHFx4l/GJ0OQeR7mcJBCARHN9nPk=;
	b=zpEWz6VGEX58Z7h44qeioBc8kZ9MPRwH5YsoRRC9pb5sikU+5xAKrjMS6Rdb8ODoTkmZ
	 6VYvRY4Zy6LzvjpoXtHE+G1EVW5JaxUixLeNKkCEkCbXVgebJGuKVQ7k/8ySEmPfD/gfH
	 cfHHHE51ggCXI5zWLS5bCPtR85Bp4os+456L5MQ0DTEpGBXAwElKxBBo6jhsM7/RP9fsn
	 2M+l6sjTG21eotbpjvPK4O7JNeRe4htX+4I8SH0luS2bi7xQinbCwI0Gcax1a3S3ReUhQ
	 nubaM7WFclbGynG7u42wEukE/GQZSDowCRp9yzljj+2Qzy0NY5hIXHDqoD6rX+iqGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=avBPr695;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RdOS7azE;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CD606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A8CD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=avBPr695;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RdOS7azE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E12C01D00125
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:39:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 02:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792564748; x=1792651148; bh=S3nmzjwAtB
	o3by4nHFx4l/GJ0OQeR7mcJBCARHN9nPk=; b=avBPr6951W5rpM4qWyX6djI4Xt
	N8Zg9571ah0WRxCytkui8ZQD+XvJHrfmkcgd9OMEMYMMvsA1qH354vewL+oi3jQz
	74K86bB/xY5HBXf7/KjKiWqBGmw0vSTWEoQr7/9e8Gi8X7TqYCnwX1OoBx8qzDp0
	uAEt36yUWLQzXDqoRDB6NR2PI+NsnV2yKJkciLH6iwCLIKjbJfTE2enFxfFk+sGs
	RZtnY7bixN5scGpL6ugYl6nJpElP3iz99K2FCMzkjzIvhAyOoHqGfmEPLeDAV6EN
	je57i1vnl7E1BcqDwchQe5f1kPNmvQFW88fV6UIosqCr2gdIM7Zx9je7zZjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792564748; x=1792651148; bh=S3nmzjwAtBo3by4nHFx4l/GJ0OQeR7mcJBC
	ARHN9nPk=; b=RdOS7azEF81uLuSg6Fe7qXNPWKnU7shk/Vh1BPwWpPAgbkeiIM5
	lTge6UVCW/sJStaghyvelBU5QIkVg8XplCNta1EzbhlKq+WWf3O8PDotnDoPr1Jr
	o0RYgliJqzOD9RE/gaqCsfeIzb/tM80DRfyvFjCMXzNMeIP7dPEvKVc0dZj5Vbl3
	Kpqr3rskuxMSyG3elHbp8gscOWf/0D/Yxtu0FJNNNWI1PuzzTorXepmXOLvoKNhU
	aroZZx8Db29O/qFbyY3SDc3/5m9eSmTMFVocwcUNyFL/+rUreMtWG9PZO5GQRVeZ
	dX/Axj0H+aFsiTl69eipCmiXfVyIVeOiRHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792564748; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UnKQ+g12r0LngVKIBwBMBMCk4AZAsGXXhwnhKh0dPOz9cdC
	3Eh8ChOQwgiZuc+tXOENaJM0KQ8PJTa8vb48b3NZxt2yOUr0p+d/A/D1v/DPX5+Y
	zhdJ/r22KB84t3xyzh1ySPLA/u/F34se9x+343qLwHJ7sDTh88JIy3t9qw2rkkpt
	9T7P0CTKJ+B64Hai2SpfG/dsdlmBX1K0QvnMGswptbjpTgOIGjk7WgZ0pZNvgUOT
	e1bFzprd03PK+mZYuAuu4VjVlYQqzIZe26xRa+qyO0ugxZ+Y2v2VSo+2xUE4YGlA
	Rjqmb139ivUOwu+0ccbIklE1HtmN76+mXCzSXYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MYS6Co3LbQtmc/5Ys1tMrpEgTSFDbI7eaouWwxmdUkw=:7S83azq2G0N/rW3bTsU+CbZLWMdQsX5UAUuEO4gPEao=;
X-ME-Sender: <xms:DF7YaiMIzoPUKAcZU3dj_zJCF68XSpX3hQ9FzSwzVxballz1hJSW8Q>
    <xme:DF7Yan3PeS-J-mTi9Tb6mP-zbnetEEticKLb4kFonY8Yq5y2WZ3t07FidI46-tI8E
    je_4CwlBdh-9SAm0PbE2dbStSu7diwSbITkquAaw02tzZDExMelYgA>
X-ME-Received: <xmr:DF7Yahk5lvdsY3TD2Sn79S4snvg576C0kaM9umnQUWYO1w6HC6ckPQ>
X-ME-Proxy-Cause: dmFkZTEXwLDv4YyPs8fpM/58Wi9N4AM/n3m/bBdvkJ7qQU7xV0Vy+SmZxLs9FG2SERGaOK
    RH1dfRB5KjXdzwQIy8aUqpwbwAWn31PypwL8cDADZDt5vPqmDfpWWtYoAFiQrJ8uXXzVfC
    7zE+Cy59XJ2Ofhkwssr4U+ujWDgafkQrMj6wxls8WRUY7K9mLuGkctj+LzpwcMbw6eFJGG
    UU2P06GzOfhUe7VGzns+3NcU2M9nKd1dWSDNm7i6MrANTjkA4JNJntwaseJYS7ecwi3o20
    Qavu0AzCb3lMV3agCbYdLmOweFo+dveE0cOFFqvHVFg7FiShyoQWIhGZwA1CPUTqBz0zCD
    FZvl+iIHvIGwyoXxgMTvDZDSLwHoudDgT77JMt2jADuxWSMWJ0QgPXJzfq/HSg3l0Nz79T
    mdJGqJR8DEWCK6966nVBp6QK4gVBcYqt9wuxTLlnLx3SGzAIg3iKjznyeFw5nrn1Is3Ft8
    7tTdJECRZOpmACzDaoB1d/fXEHixs9U+0KVtjUMiAkFfyrTw1yAf3iPueHrYjCiWPXK5xP
    YsYnjgEA50rph0fBvOg4ARZPoEZPQLNEjH9ZpmAQi7CfKpEwpsf5YwltyS8HfBhLSyEme/
    N2ZKh/bEHM9dW872gR6OZf+Ykvz74PXNd3HOqkKowqMBw+nnBFkYaQ2vw0Uw
X-ME-Proxy: <xmx:DF7YauXv7zjKYHSyD33LVstJBLKBnLbXJlWH0KS1l4QIb_hkSkxD9A>
    <xmx:DF7Yanuf4sFYK55ozcxnd_G-nnL5YLAeq49jIF8s5dhVK6r0jLq5WA>
    <xmx:DF7YahbDJtzxWhBw5tWeom-pO62pP5hz_8DLeJGDMuoggNWVkl6t2g>
    <xmx:DF7YamUcSNINvdmjJsSsWpCEe1S87L8YGFBUBHMp8bhPzCAECGYupQ>
    <xmx:DF7Yaq0fc3Bpg7DIbah3w3K0ScQtAn0H9eQS0ZGl9xoqtRFMbDUuYKF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 02:39:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e528032 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 06:39:04 +0000 (UTC)
Date: Wed, 21 Oct 2026 08:39:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling
 tags
Message-ID: <athd_dTKZYOv01UZ@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
 <atftdOihoUHTdvfu@denethor>
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
In-Reply-To: <atftdOihoUHTdvfu@denethor>

On Tue, Oct 20, 2026 at 06:05:22PM -0500, Justin Tobler wrote:
> On 26/10/15 11:24PM, Karthik Nayak wrote:
[snip]
> > Fix this by committing the previous batched update and initiating a new
> > one for backfilling tags. Use a separate error variable for tracking the
> > reference updates: One, it ensures that errors from the regular ref
> > updates don't cause a total failure. Two, if starting the transaction
> > for backfilling tags fails, only those updates are not made to disk. The
> > initial error is now printed straight away to clear the buffer for
> > further errors.
> 
> Naively, I think it would be nice if it were possible supplement the
> backfill fetch "haves" with the non-committed references in the pending
> transaction directly. That would avoid having to commit the references
> in the middle and probably also fix it for atomic fetches too, but I'm
> uncertain if that would be a simple or reasonable thing to do.

Hmm, I think that's a sensible idea. We should know about the ref
updates we have already scheduled into the transaction, so in theory we
could use their new object IDs in the negotiation. If that's possible it
would definitely be a much better fix.

> Committing the intermediate state here does in part fix the issue, so it
> may be a good first step regardless.

Well, if the above suggestions works we'd want to revert this step here,
so we'd first have to go back a step again.

If the above is infeasible then that's fine. But if it is feasible
without too much effort I'd go for it directly.

Patrick
