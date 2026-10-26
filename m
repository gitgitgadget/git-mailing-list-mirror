Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015633;
	b=T96AeF4NWUIdpjUNCvj4Pvky2s9rVEgdYzUuwqg1qja2IrKkFzNo2LYrwSpzOH1OJO8m
	 qPbEeuUHChOHJHPutGTj9+3vuizzxYgzTtdlfqDa+Igmq3KsWTIpfqxdsvkcEdo5huyWq
	 vfkK+Yt9wZcD+Msoz+wH8Ds1h+An0C0e79WjXB+MABoIgExiNz2Oq866NoPGeh/2+W/Gs
	 kc8vsiSBxU9Aq9pVo3nV3cLBsTCxADqYEXQ3uFxCPvn/shYDOQfjamJFifgVqnHBk3cE6
	 9xv8+TDiZmMqHdITrtxJwD7FKe/9IKT5V6YHMxiPJE94NeFHxJHJXbi2RTuVDib2yTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015633;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5iiZyXtu1OnJMbAZUG9pdTCur2Kt0V7dlFyDMEiW9OA=;
	b=cYxORFNvFvfc878U8m72R9t0hw19UHMWlUqYelQCfmoD6Wb1E9br8az8F0cTnIvTFaxU
	 oH/usNvllF9Lr4RCz5qu7BqoJGc0Tj/hVNgiIxumByUxCz+082EA44n14+VZfiqe/TYs6
	 LSQHc1g92n7KHB6x2PVlT1JZuauDBZAYP0lQ5GtdUurXJXqevq5+MmOqWxFazu/TYG8Rc
	 Yi+xKRrseR4DFRiNITPwH35r7F+Wft/phiplRt0buWKCylYdFM8IIfh1candzJzbIzSIG
	 ALZl3h5CYswnAiaZxN+zB/LAqSByqfn8eTT8eSL93clLonGFoQzbiTLROzT6+T+PYaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bqbe+XMa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O0en5OLI;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393D606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2393D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bqbe+XMa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O0en5OLI
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D7B51D00244
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:53:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 07:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793015632; x=1793102032; bh=5iiZyXtu1O
	nJMbAZUG9pdTCur2Kt0V7dlFyDMEiW9OA=; b=bqbe+XMavkzefvifcjmZbTa4Qb
	4cYR7SRADTGdShsyVqFPVvdiOuf+Vro9YXaR6pHBMlOTBEe7IdZaOu3P/XwZH95i
	aVdJhpMhgDdVfHOBCo7Q16SWlHxbULSnhE5lOPtqfvPhpMAImxmsfBvLzSoE4bU7
	aXGMuDQErSIaKz+15X08zUF97h81ihs7EAYPALZKmkYGfV+rOBHmcsMBRVZjxmL7
	eDxkS8vGrtZLoKW0z3laJXo/hdBaG80F1DwnsNVbsYgXyeYgmwPu9XV1QYF2w3qV
	fwVtnouhdfbZV0nj5oillRfnA8LMEvkM2LlIlHraspzjGg1/Up6EGqihGm0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793015632; x=1793102032; bh=5iiZyXtu1OnJMbAZUG9pdTCur2Kt0V7dlFy
	DMEiW9OA=; b=O0en5OLICY8MgCe7PwN/q0G2So4mF9UJjpSmtgn13vRESnb/AxX
	uqWDUH1X3CnkOEQw8USUgA1iBmdPLgV1NQONRqH1OtKyVBua3qQ7rKcY9alN001T
	NzMLf+w45SQVHUtSWxkmddW7OnwaY1uU+dkZp2omsENFrQahYeZ2k7XchSGaxytu
	ULg16v0092I5l039KxUWFSMe2TxI7GL7fWQzTQ3UFAxtKrb6fjXwB3BhsOXPscev
	Iz1mKTOvJv2gjZmrVG36agIWUgttgCAEhIi+7HlDazv+T+XvkvWGq/ZuJLfq/BKh
	CsdMlY5rW0cJzsqe7C2jBYJOHG76to5/4tg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793015632; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ij2KUSlkHbIDIgnf2fPWWtcZysIV7m1xffwnzI0Ssskkoib
	8pqmZdtBSW0oZUAbUGzBivp/u1lnnmZ4BYDwWahIHrH64ayNAY9XTxewk5+rleFK
	1Z/+X+YEcIh5AGsTrNqCV7kjjdsWGJ5ka6UPABalUdOBbwa21Rnn7Jy6abm5rqfx
	/tiQpevHrSKrKn67GD+zOMFlccZKYa0BQwZPm9M69hBcW4pX924vEqN4fW4oU4v6
	zA5YdflMfZ3cBjuRPHZSqQNKNVl1rDPPPq1mlHFj1CceIdFvjYLiJ1lOxzIjw86T
	83iarOc6uRKconMxew0oPWWX08V3DgqBt/YBq7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KKwIrhZcSVezzdpijqaTMrFXGVDGeuoaDzUGQbgYovQ=:XmeRsCJ5dJ/MDzZNQEPUPsOXYYjsvjo3XwHm2uN5XHs=;
X-ME-Sender: <xms:UD_faqMptWzmd4_zGn-hJ0Lv6IGBdT5C5A0Tg6M0tK3MRxGMZYTgFQ>
    <xme:UD_fau_LYqFuN6Qn6bWS9tLRDP43HwXdpNfTeXvAMrgrsstOQamXd3PIuavS8wlWG
    mF2hrzu2bLm1OOTYciw_gRxb26m7DpTt49j7df4Gou4HotbRgDtVXE>
X-ME-Received: <xmr:UD_fau6E5vB0VSl7Wth02ng6OZ0e1hhCbJquJwpgvvDw2kF0IQCW9w>
X-ME-Proxy-Cause: dmFkZTEufUa/TyhImE6jR26nYnOm+4g4gykACn7J0BQtN5zWo7aBKkiJy4YjHem1akYAoc
    DzMccBlvjU02bj15qIjMj+cjZbwXqhh2Tgv+DadZ5+mRvRZTd+yj34b398rVOaIqIY5xls
    3H/yewN1ueDeuTHsHSEmo7WtwYIhyVarW4lDirfznZNUv95L8ZbeSFLO0qrn4KAXKyjBRV
    M4/JslmvxX0kAZWUOa/w22Mr9zcUEC2qct28p8xI9dsD3DLe/bRHITvpXpxsQWRmogHhYv
    2+Px2MiInJNaDsKGiWCMY1bSHBUyouq73dV8zh2FIIDu0u78oukqWCXl6dLP7QGGVA3YB6
    neyHfSh8qKvWwJec5wgHn/HRXlMDb7hyusHiTKssckV7uLudH9QOWho9pSz+Wt9Mfz9d6e
    BPgoM283U2SFODwIBOHWJBGK75tMRsYCUG8CDCb3Nu0YjtJ92HcOcNs0BzHKihq1RjXTQN
    eH0nVn0Ha+x1M36LgGRzpAyKzKqG81GCJhte7VaJAR6BsvQGsLou4zLM8xfjIZ+FPGBE7J
    YJvfko99SLB7Fqc/Zc9PdZJtoKGkRmJeOUVVD6XWahpbb2bUgY2Q63vasLmQZ4IoAcrRPU
    9TnZh9igeWMDEhhx1g9wFw221/4r6lkDdPwYWX/RQJHiLlE5EhbYpmGtV0aw
X-ME-Proxy: <xmx:UD_fal221sSGbjJYNNPKeQCxzqyboKtJOcgBaOye92-rYB5oh0xJbA>
    <xmx:UD_falCxxWTZtlQ43ioA95KZGHrkRl00tER8XbFumjTQLtue5kc5WA>
    <xmx:UD_fan1K0vhJQ19FPtDTGpf9Dy2Zh5w545gSa5r0m9MxDFoj5vUL0Q>
    <xmx:UD_favu3Rs3ymnESSpSZzJiKvnMJzNRkDcn8bhPsn0jAlPKQOZlccw>
    <xmx:UD_fas_GBuhdUl4ej4-XVw3tTnljqDAdLO5GEjJAeOcstWf8dIJD3uFP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:53:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7d3c20f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:53:51 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:53:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/7] setup: allow overriding object storage format via
 environment
Message-ID: <at8_TFBej0ZITu4D@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
 <20261023-b4-pks-odb-extension-v3-3-b1bb30a006db@pks.im>
 <CAOLa=ZTrYBtLOPMh04-J8AkH0797aeKsnXB61H-V8vb1x0r2Jg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTrYBtLOPMh04-J8AkH0797aeKsnXB61H-V8vb1x0r2Jg@mail.gmail.com>

On Mon, Oct 26, 2026 at 04:25:11AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index 249bd67876..70aa90a9cb 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2097,6 +2098,21 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
> >  					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
> >  			}
> >
> > +			/*
> > +			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment
> 
> Really nitpicking today: I would drop the 'Likewise' here as this binds
> this section of the code to the previous, which may not stay the same
> over time.

Fair, can do.

Patrick
