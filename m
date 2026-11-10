Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294553;
	b=ucc1qzQtcm516SrJHQCqvv/AJlnmtIb+qr10ObOQSGBVATR9tJzn645ZRkDtHS3POe6x
	 tPMn9nqzpKxip9f+8AoOXOH5EBtMS/0XQEX5fCO16xIxeDcd0ulIjK0z57gLjpyZZ1CRu
	 t1MPEbU8FF8FLMzsdk2abss5eb5+oHXE+4vetC0+m0hRUR+bb7d1gXgmtfzr0uqt3T8tk
	 xpUxJuO1GnSKpA41VpYlH9u0TbZzAKCuLGluf/936wrX/tzmq9p+P4Yg3DwJEntDryHb6
	 vbOj6LD6L6UMbs0FSs82O02QIH12JMMI0SNJLGneiYI1Emr+IzxK8zYNM8u2pcn4Z5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zuxzg6RrTq0M3D5xLdZZ6o2VCzN/Y1M+StMuJujb1AY=;
	b=MVxB/KCLp1yx97Xri/YmWRyYSDmIE+upVKD/PC8Ym4e2X5f6VQKvDPks2h+3FLWFYzud
	 496/Re16fIMRmV1+eiHWXxguk3jmS++n+slh6lfye3AiEytZX7Gl7I7IVI9MkgFmu4Jmz
	 a3vqz2lANtG09G9hk7mIZIx8UYoGQdNynfdNwqDMjHq1XgRp2dHyY2zUwwiMStcp6loa0
	 7bK3v8E90rF+dSwbgDsZv5EvIcdS6dfd0pPEzJF432r5x9wflhu3AA1wkKlF6lQuJfl2u
	 9ueStaYrCDYjWULzCQeB+PbCwxraj0CVGJEj98S7nSk/iVTwwlL+fuz5eq2sX1OoqCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=B6y2CKFa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2O98cLYy;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22462606A325
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22462606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=B6y2CKFa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2O98cLYy
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 66BA0EC0972
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 02:09:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 02:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794294552; x=1794380952; bh=Zuxzg6RrTq
	0M3D5xLdZZ6o2VCzN/Y1M+StMuJujb1AY=; b=B6y2CKFa8Kd8lZigMqHN2d4jps
	kRG2CdV5pmwwPJ+4X2poMhar1xXU1oFEKRwG1d0AYkOG9h32iG6dryyxQFghheUx
	O+7zE31HRq3LwaDpT8y0qSMvO8jdEy6AExJlChYcJ3k9LpDZa4aQU7ZmgwXzHc1L
	jmYzd1I/XE1UFobZS/u0ddhKida0q5ub4J5cr0vHp3uSyMwQl9jCBO9Qizu7qNnt
	wtYDJca60/19wAxyyh3gbgdBErZHpj8So2bEw+tZeXhMxPgwEX6EeB4w7Sk55967
	GlaiJqfzu7TNYyaCtUgqUWfl4D+2a24pUdK2wi3IfVUW00ANch0wCn1nAOMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794294552; x=1794380952; bh=Zuxzg6RrTq0M3D5xLdZZ6o2VCzN/Y1M+StM
	uJujb1AY=; b=2O98cLYy/mr/Sx3fo2yTi9c8rYlE63C1dansBtklAuDNudRSQjS
	avLXswEJupKXwp4BI0oB9NRI2tNMvrdhPVDvnL3MusTx1iYSbz2RsyN8D0Gq42Kk
	FYnmZKAhZltf0owic1LwPs31wdHisR/5qQTb0XWEBOPcx7/FO8R0ZLoOtgosrX9G
	YApFvPKFHG2nbUqWrxC2kdK1bwdSNoyGAxp7ad3skUFCwatkohxGBsqYoYE1fQx8
	SEy6n4Q/IAL+51+N88IlFm9EGHGKpEPepIUTLS7RlfA/ihDZtzDDKdeHL0iPLDxh
	LUxK+mpreemJuzVx7GBSXtFZ8Ow9riWyqfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794294552; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ipJCSWAAjXrZuOuoUuJcxWyly2L7mSgGXUAcogmSxInyejf
	bkYM0W2sUPFX8D5fRX0Wo3tv3L2zSkMMXYeQ4uuiLALw8kTX3c9q3O84AcIcnfc4
	JzEovv4PNJySh73v8XygpBeTUHzshz2uV5IVJ1yFoV8d1rmSSXCfMzZTb9rf14HO
	QZgOtK+an+1zwRO7JFZj6yLOc1CXKVt+p9SmF6/ddCOkHAuft2vFupcbptXvh0+u
	5u0/otxT17uw1uISKL0KDqAc0Fl/+442Zxo6dv1mZCj1DXTqmFm+GA8xAWa9gXPm
	XOzktfym805lI8uni8ziSsijGQtqR3wo5jhadkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6W0zBskrtQHZ+P+M03LUiBwQqh9NlmWu16nXQE84KNA=:E6pp3eO0k3eKIf22+5zuJR/NbfojRjfrpnGHDjSw6+U=;
X-ME-Sender: <xms:GMPyajruylbAttnqtn7HJh0UCZ4Lsk3N2WcQcshe9b0KOnRJ8xyqww>
    <xme:GMPyapId-tIdMD2Lf77P-GbD2YnveGHt3zvZ_8J1Z2hjcgpOwpUzYZzjTrO5HOpkP
    U33DXNwqbvGDFO4eGFXvGpE5V_vaNYhmh_GwfTlNUgvStlLasRoTg>
X-ME-Received: <xmr:GMPyamrtSO8WZz3akHq2ffPRJadBc36nB8EUUficI8ONjAD8h0I6VOfdc0cJ_7Cdwupq_w>
X-ME-Proxy-Cause: dmFkZTFdpF7Mlue99ndxfHKbDlQCD1UURtylILeJdHyYWyCz6c36BqC7r+TyLwNDh2SFcz
    5GR5HW28yu+6OkoD/Zm1+B77BI4PO1y+iqDFbCGmcz8RQx+t6/0N8iOeeIq4GXtL1OKBPj
    Z/7aPEvOEAdFd4I4u1ztNiqoUtGe5qBVVLz6GLm9qu9aVlhfUpxAZFAQynU6xQsNLkg8xF
    OUMKN99VHPI41R2Yw7zcZ4/C+u/52fEAdLQa94V6eJzjEHmyK91zDcjxkBezvSxufQjc6w
    arxddNKoAJBTl3eXuWx6w0tmJlPrhMD12I+BNQf8sdVdc03YL0/qBKMLbblNiVgF9P5Yh/
    aD1OYTOy2hJ8aOU2cSz+H95ZZLGdM8zeGGqL0VYlv4lPcbrJg2wJ2R+/dD3rc1097MlhXT
    7uA3AdNJBCQx+lKY1GuDTFZuxbuBBCJGtga2Z9v1BKHMkIk+2VH5zArBRt/JR251fafw3w
    pw8miNHgnXfBz5YYZBH7k/Wr923zEeQsg/kaMl2Wwvg2xtF94cvdWCNRlpGGDiBIZC27P/
    oKm5qqFD8afSgSknL+cjwJCYyCMwYzKB+t4abHOhyVFXPxi4WGnWJ/0dczKvd4dYL80Mi7
    fQPln5+85b5OR/8Sot6XmxbxP5KhTo9KQXtunl65VF7hVkLwdzz0xT1FqMNw
X-ME-Proxy: <xmx:GMPyahwPKGaCh-uKjOABXsPpdCpG8mZYlHK5oNgkwQvao0EEPR3Uzw>
    <xmx:GMPyaqPwbbak3MNl90L5UjKxnwtAo4vX76NenHcSmtTC_tLgjKEnlg>
    <xmx:GMPyam4vf_mMJxUwyXYjXbNj9oood2iBDQvJ5ZXtC5ji31Wh_xgW4g>
    <xmx:GMPyajlHnZQVMO6kjqsqQ3i-RhunTjNorcw0RjkouXaz_Ft-OvirxQ>
    <xmx:GMPyav-vZXANaY3cF1gUBv7te6u1x9uuEBoWWK48OLvUQXMbzOBasDEV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 02:09:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 411c876f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 07:09:10 +0000 (UTC)
Date: Tue, 10 Nov 2026 08:09:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] builtin/reflog: expire --all and named refs in one loop
Message-ID: <avLDE1gGsjjy2ryd@pks.im>
References: <avGU-Wjkd821PLc0@pks.im>
 <20261109161313.54630-1-laveeshb@laveeshbansal.com>
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
In-Reply-To: <20261109161313.54630-1-laveeshb@laveeshbansal.com>

On Mon, Nov 09, 2026 at 08:13:13AM -0800, Laveesh Bansal wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One thing I wonder though: now that we first gather reflog names, can't
> > we also easily deduplicate them? For example if the same reflog name was
> > given multiple times on the command line, or in case the reflog is
> > included both via a command line argument and via "--all".
> 
> I want this patch to change no behavior, and deduplicating would change
> the output: with "--verbose", a name given twice lists its entries
> twice today, and sorting would reorder them.  It could be done in the
> loop, by skipping a name already seen, but that is a separate change.

You could add it as a second commit to this patch series. Like that, the
refactoring and the change in behaviour would still be separate from one
another. And that second commit would be a good point in case vouching
for why the refactoring is a good idea.

> > Okay, we only apply per-reflog options in the case where the reflog name
> > was explicitly specified by the user, becaues only in that case do we
> > call `repo_dwim_log()`.
> 
> reflog_expire_options_set_refname() is called for every entry in the
> loop, as it was in both loops before, so the per-reflog options apply
> to the --all entries too.  Only repo_dwim_log() is conditional: the
> names from --all come straight from the ref store and need no lookup.
> 
> I'll reword the commit message as you suggest and send a v2 once others
> have had a chance to comment.

Thanks!

Patrick
