Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082041;
	b=ZqIiF8APfVRIK1BmL1oEMpNMBZFMUmw0lb0XI731ynt8fGKvoPQvseL9SpcPTi/EjIr3
	 xS0nolYkF1Q1YLlrG2MySns2NFtk31xMI+ziwTNq0Rqo5MZ3xexuwcxcRbsqA5n8+2xWx
	 GtGbnQooKAw6IccKuzL5qm/zSLyFSggBVm3Hz6TELmfgpywfGbncmRw79WiEWLRuq5JN1
	 KX4LukyFq9Jjbitx+YcziBDTjqILWjC2hM4sGMkyvtHFY1VE+GcTOz9UFkftneay5H64c
	 kahXtNTa4o53PDee0jwjD6sM9YAjjPnUY1WEds2Tl0YJsphw1A4pTfWGpdq3lvuDdag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tW7QyonDxDudslUM2NzyrAzPAtZbkl3HwwobWX1J9QU=;
	b=C0kAHNosl3LHn8xPE/Gk+GTcDz2exOjwUOsnWLbIPD+YKLlCf3yb++iGEGW0/LwDQ5cT
	 mwIRzlLLesf1h6Tx2Wd9PyfU6hsLZYI239bejrbMdn21jGpryVbd7rsqpcSG+rE/o3yt0
	 sjvGW4/3urmhJx3LAW+xWN0IrdP8/fo/Nj9/3A/vqzjowN/uA1YOOLQf2LKHInDNbhY0R
	 lUk+yVw1uvDRry4Ig1lnClEbV5wY3atzkALPwGeUaIdTE5GRDYCwZflDZmypzAWtfG49z
	 aWl73YkpxRBndfUmTl/hGtJA0iDPwBC6CfgRKWZv24h4nyxZwYOfHuaNuz9e5t7fayQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Yg3UvWWD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hHzOHODz;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5E606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE5E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Yg3UvWWD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hHzOHODz
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B9B414001CB
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 04:54:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 04:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795082040; x=1795168440; bh=tW7QyonDxD
	udslUM2NzyrAzPAtZbkl3HwwobWX1J9QU=; b=Yg3UvWWDg7YXqeb0/ISSEZVTUl
	przuIzFNTDWTevo3rTk+TwOVw6WsH8ReIS/nA+hVenRyKXpG4YG7GLiELdE960b0
	NSRbaLRg2OkbHd0tzUIQEXxOK60TXINgLyHAottnQvpK+plt0/tfQtAWh5vJnRBx
	I510O7oEOuzX1E7unT5rDN2mcgs2eLGhd/C8sCcS39GmdWmihoNnlKTflfUvZeWD
	D1AoU5pEvTJ2OZi1fCEsIoxGU6hOvYSFYUnqM9KkGPQRmwxuBG6cyOr377eR/UPY
	/8bC5h8tUuRG3GJZNpiBZruDqhNrGw16OiMsKWJ3mS8ZYyPE+20RUEJhcgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795082040; x=1795168440; bh=tW7QyonDxDudslUM2NzyrAzPAtZbkl3Hwwo
	bWX1J9QU=; b=hHzOHODzzM3BXWpffV9p5SzCZZBTWvn3CbFANK3Srv4F4z0Egb7
	75czidUqk70iD4Ni6EC9hN9vuoNSL3TwZ2ekI477ECMtlcP1OnpdqsZyfO3jPNhy
	e/Edqc0zFKqAJ/ZKySIuVrqiaSHcFOYAXuUM+Hdsf2nM8Ca8Qo/o1f+8lz6T9ZN/
	kY9yn0YGo3wmFAOQUL+m8jRVq80aleqBaboXrvXoen78DF0Jx7AxgiuNX4wIFAAd
	8hDs9fJ+Z4qG21wg+spXv0TAYdo7ZJqTVIsDe5gvO6JwPxJUKphQAC56wsBw01cE
	bRDuFVWTt5XWEWZe4aFEzElJlQbx1Raun5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795082040; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LBwBOFS00sFNwxVAatCktRVLN4FJDHksWnfmCHgVH63/D/2
	F+by2kA0/6xxaMiM/BLqHIoZee9mu9coDxouxdomu1rXU6MyV580+O08q3sevhXC
	sed26W9pGMwWwCZpsJLhbhecMZuDe+uJ5p1D9TMizmzok3eKnrweNSW7M3ALw349
	E1QXIDCE5iQOQd18HJWbl43bCElhTqTTpIUWBlWlk83rWc3VAUyGAqjLQKDxopYN
	hDe9gxD+kanTFJUXc3t6xtTjjZWskcdytMSvP3yNzrIwGS6Vzy/5bEQ/gsET2GtL
	Wc/OcXG/titDwzG7LrMkExEgv0LdFU/3UVjavyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5WAy9Cgaytk/N4mvCr6Lmya/hewHyTsZAru056C9zgo=:B1kZLmCz6k7mb7aEeVvaUlOG3KmN4XvPhraMUxBdbrU=;
X-ME-Sender: <xms:N8f-aucuWl1u3CTwAWIQnsOHzhuzlugNLc1N9IPqyVFVpOXl3SxNlg>
    <xme:N8f-ar7D7ks56bMsZbxbpas9xuUsfQLWMsxRqk2k19RRMzPao2Oi5la3Rc1HqKIpm
    bib0bVb5KXoDguTX2UtqvZgqnHRINwxT742PVbdxv3n1PQjR7UM3wg>
X-ME-Received: <xmr:N8f-apVmcVg_IISwrxTIGpHSSLBw_zfpuR_wo0yXSbXG4-5gQH3JifNAf2T_qF9dZeoMlN8>
X-ME-Proxy-Cause: dmFkZTFrnfmw4gJlWku8vZnvcpWTXDGiF7Jqm2WtEe2oWMqR8dMxBc4kiH3pwLCbuC3Dfk
    kF+odFSGuMf+DLeWDP1FZ/EXTSB91NapBrsAIw7FX38ywANIDArucl8C1SZz2PaY96uRl1
    E+QobHDNzYFfjkIU2yFJ8hsnWPX+WO4o9AUP1FslGRCM6DU6/hv4iKKBOz7ZW4xZWRCFDj
    5f4HtuDyB6b7/Fey77jbnUCkIUE4B0dIeE1SQmfP1WoOY4ayj/An/uj2zxZam4OuPa9oDk
    SHZcLKK3wYdYx9E6SIzRvQ607e+yJFeDB+g+tROQ6018wT2VzIjvgBvlcgvq54OjH5BnJ2
    VanafEQD2BfeFIe5sjkYVX2Jy3vB17MPC8byd94zOlOhYFaurU+VqU9eh9AWnYbcNm3lR9
    GUXjABTvoAidURcNmweRKefKPh/7zAXNJGglYrfxvxLHLnv7LW+96w8LR/TEDx1E1IlLVJ
    NkeeOQCxnib1dOLJhMjPhX8td5IWCk3NHgZN5zV5yYKxaUOeysqs3J/qfCHWclNTO/G/7C
    P4zkDGubCfSwQzBu1BUYY3ase9cLaL/124DS+ZZw26QXAjCTgvcIII0owVvBo0h1gUJ+ft
    W+Y/DMoSJk9RcVSJ8XgEbEaaR1s7TbQTcA6eKXNfo7XbThf3LvjhiJlAwYEA
X-ME-Proxy: <xmx:N8f-ai77uzUsWDNbBBHYRBqMv9Jt7AMkexI_NREl3SFaIHT5Klq9Yg>
    <xmx:N8f-asoVk53u-sZ4JndV0R5IWpNiee5hggK8W76wVlEh9DYG4Z93gA>
    <xmx:N8f-atnhmw6gDgSbt39lPO-l-QI8PFZ-KAZNXtJJaPv89kr9PhXgMA>
    <xmx:N8f-agOWXLVqn8tthD7CKeHcemCCwVZMWb8AD33WuI_C23Bv6pkfJQ>
    <xmx:OMf-anxg5r3rBFD7pIiKkwvsR2EvHWni7TQaw6GE5urr5Xl-Khrjn01N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 04:53:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1c82a3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 09:53:57 +0000 (UTC)
Date: Thu, 19 Nov 2026 10:53:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Matthew E. Luallen" <m@sph3r3.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] archive, apply: do not truncate files of 4GiB or more
Message-ID: <av7HMbnylHiz_MVz@pks.im>
References: <cover.1793524457.git.gitter.spiros@gmail.com>
 <20261119065711.827536-1-gitter.spiros@gmail.com>
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
In-Reply-To: <20261119065711.827536-1-gitter.spiros@gmail.com>

On Thu, Nov 19, 2026 at 07:57:11AM +0100, Elia Pinto wrote:
> Hi,
> 
> A gentle ping on this two-patch series, which has had no comments so
> far. It still applies cleanly to current master (e1ec09b23c) and
> merges cleanly with 'seen'.
> 
> 1/2 (archive) stands on its own. 2/2 (apply) has a question I should
> have raised in the cover letter. It fixes the file written to the
> working tree, but with --index, and so with "git am", the result still
> goes through odb_write_object(), whose length is an "unsigned long"
> until "use size_t for a few more object and buffer sizes" [1] lands.
> Where "long" has 32 bits while size_t has 64, the blob written to the
> index is then still truncated, while the working tree file is now
> complete.
> 
> I see two ways to handle that:
> 
>  - pass the size through cast_size_t_to_ulong() in add_index_file(),
>    so that "git apply --index" dies instead, as 5/5 of the loose object
>    series [2] does for notes, and drop the cast once [1] is in;
> 
>  - hold back 2/2 until [1] lands, as Patrick suggested for a similar
>    case in the pack-receive series [3].
> 
> Which one would you prefer?

I'd prefer the latter. So how about you send a new, rebased version of
this series once it has landed?

Patrick
