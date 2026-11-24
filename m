Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534911;
	b=vvRs46CDPKEcVxpXOo/CginBxRxqgIDJs7M6I+uCAiJckhPpd4r8aUGtP824Xo1MYtZB
	 K6hHBWVmExlfGtnDeZuFZWFr5YDO1l1TwqyM7KbANHpLPzP5DLLw0Apx7F3ueY7E2dlgx
	 Hm+qph4+j8sU+UzYKTAqLnSA+6UwB+1rk5e2tbEk2C+ivUV3Z4BeJ4hCi91svMJtysVCh
	 EvjZZ939jm3O16rF6Phq7d5N+GOLkUuL33iP+JSBk/GabauHwsNA4k24dpNaJpvGVlItQ
	 B9qiLD36cjx2kJhOqKpmRWpVqXhDgDnPAEtPdm3Jp3/IRLJh8PjqSy3+TXz7ukByHBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534911;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rhPUs0LuLEchpfmKtf1hvlCM2EtGEMAtW0LJKBaFoZE=;
	b=1IGtzW2O25WYmwglY/eIr+W2p2k8+1JAgf1eBiEgyNjQyXPjzlvAuxA0/MMQhu/NJdxs
	 gvaKnLex5Jw6MlGUW4jZAPKGSc1wJEzlOKvrS2ZQN7Gfw/83tXSMgHx0+DThLqhpJWCIc
	 MCd1Wl+nnwqvChB9KtnWB4PmYAl43WeEzA6xt1rQIzkzU+/S2CwpEouCf4LylGs40aQxM
	 Ravs9XSuTQhqnzs0cXKo9JsDxnGCjLQ/rgS1kW1A6p3xRrnBQoRtqBxwG8HgT9gfi6LhP
	 sv1hxvdXbWJG85ILfBjsZsEBW0KPKsPAQkQddyTNP1MDlC61XB22O7A0P+Fu7LkT0aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kI9Nn3cE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="xsTbt/NK";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FB606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112FB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kI9Nn3cE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xsTbt/NK
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3607EEC097D
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:41:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 10:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795534910; x=1795621310; bh=rhPUs0LuLE
	chpfmKtf1hvlCM2EtGEMAtW0LJKBaFoZE=; b=kI9Nn3cEvDLif3phR/P+ZzR6IM
	MYaNM9oI+BAsXLiTovoF+uuiI0bGLTH0LSuniHWbQrcqom3OD51CxwyOU9JlhAQj
	C6Ol0wOjUOp3BbwG3mAmnvIZjwBQ5pe2ULlYo5KdCaRghqFYr8CWm9maimXA5eQQ
	XWjp9Yu+lMqxtWlduBWvrMLzVuKzdjtjvlsq76XLe4mV0H2nbFu2qEtcBwhOSG6d
	crNc9ov+5MUJRufzRZYWWjdhBxP966AISw9/XkF4ILAaFBxnKykJ7+BDCru/xE19
	aBEol/4xtW1Tl1Xq5DVfrmzKQM42roNntaZPT0AR2nQo8nNddSvldSYXuSfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795534910; x=1795621310; bh=rhPUs0LuLEchpfmKtf1hvlCM2EtGEMAtW0L
	JKBaFoZE=; b=xsTbt/NKvBlW3deDGob3kr2Rp75MxxvTPaZF6d5/QTCGeqiF+Bh
	7bFhof8hzc0Zahd+epIaSp7137NlyYE7Zm4mULKgaZJUZqBk8tNs/9Ky8tZ2nWO1
	eZx0rqjOxcDC/2dTdv7svmIHw4NJfA07pN8SR2u+aG3RbZOIVzHMHWxPh19ypndi
	cjk5O8+zW2YKep9q9+pA6s6DruBU6TCR9iYpvCYiR+XRd6yhd9EftB5kkOWEDCij
	T5OjS1kT1swky6JoeDUwocfnuvEXr7haR4bzCc51wMcVVUrT7DqpZpo/oZDk+fuw
	oEa+BV88GteJMlMlG+h9DzkhqLkwOUjJoCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795534910; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UcowLXqJUCdgz6tPK0fvFjehxCzCCxRdWtbSaEexR+1P6ri
	3Qgt5eCzWMrrdRRZSJVAcHi59WtzwYp/XbM46GCICy5ObY6nyYiRuJjUQeIOydgc
	MvHKRRWFppVCWxi1qU6HKRGwUB78aMiOyPj2AatNPrvbmVXvRK2fs5ORZdXMSOH/
	xeH3afCBtzMaD7EW0yIdaH7VPi8xhTXZ6Z6DKpqXfJpcCw2ncS+9o6GTA+/gRar+
	QQj2yav5txEhliV0rShnz+pu/Odo4HZznmqUdtPvGmeaKSo6mJsi/42Jscj9QO9B
	GB1POir01HWmqDcAq1Qi8brvJFbKJ9cOBFzxYYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pvjrWX0X51R2udUkxRlYGK+rvrs2PAQz1xdjgWPc9tw=:ABSZwqrUGsN0fu5yOgCSnJzLf+04Gmag5v6v7ZYndsQ=;
X-ME-Sender: <xms:PbAFa3FEIayR2J1ByIVMpjAVBHbfQFvuJAv1LkaAmyLi-TQZltym5g>
    <xme:PbAFa7VqAqdryc3ZLlel60F8wqiV9umdqORqUbnIf2GyqvCiQGU4jOEPEoYbcsxAo
    8e4Do4m4iQsLVxZi8kJIxhwHEuw9yR-nXOrjZ7CtYeOAcuDP-m2-g>
X-ME-Received: <xmr:PbAFa-IarAq8YfWbOKZlYyXheAK3mkCZRIEXp326KtAdvWxdGvJFp-0JkurNU4u8eS9zmt9snsTuummIrQHVD5bLLNDu3JR5srwVa6A>
X-ME-Proxy-Cause: dmFkZTFRNaop6xGMpBR0j0xJOCdC/7+i0alDQ3SsUVyDYdD+e8tNrBuyssa2Dq3uF0F9pF
    8ZlrHxgDDYxX7R24bBwCbKsXZPbdTo5V1ZZt03hI8sc7uBEN2ER/Bd8ANbmjsg7ML1ewwP
    akoQa5MpHZX23U8Ax7vIcPyMsIXqF50WWmeWRux178/2/sl4Uvfwv8CUk5DIGvfIRq7PzM
    9miD+ltPkDKoPLIrI/TMrwFM/bBMAyJ761BBjjBpbFWnRr1qm6cZCt7wyQNTxGE261MAIP
    gS+RYBv37EIUhaVVSsbDEZrCdEogoDVI8cIIWDI9ferB29cj/B796gVYFl+G/mMvl04cn1
    Y4i+ERyY7fTNEZfDsDVcEKVNKfMrVHQvNwz7aMBWdAK2azYLnlXNKoVTmu+X2BtEwkCQBY
    Ws/2Rcp9WeeOdBg9nOfGRoUm9kNmbL/Srs3GHJohdKUbFO/Qx5pQWwP4TIptES6bNYm9Jz
    KRrYathcfNnOCGg8H2N13yCfFyE+CnUYJqYZ/ZUQPtYF2l90Si+Cj8v68OGljtBVfXnUV5
    p/2E81NrJMs1QerSKV+Up60Stnf9l4pNVCM7G6EtG66SQ70CBYgckRsW8lKWOILViZ+TdD
    eF+6hKq/gS3W+qcslBGNwjJu99MRzQnANeMDBkfHA5WzX3mHsfb4ms9IH5vw
X-ME-Proxy: <xmx:PbAFaz-M5sjNQj4_pw_SQHH6edHSrNBduCTi_RXo36upM4faSKI8dw>
    <xmx:PbAFa5KGf0XKbXCfjAqWwf_NUwZjokVeWabAinyExiyTYc-fA_Yaeg>
    <xmx:PbAFawnGYSPT6eAiAniKP8cV1UWC33u7ogz1_bCpHvPQMRSMff44qQ>
    <xmx:PbAFa1N7xM7YRAER7IQRn0ctrrkBMgC0OnNWcbhyKxd-RV69Ie3nLQ>
    <xmx:PrAFa4LSQGG3uF--wwWrQUGifHZ7__JaeVy07a0HF8twQJjeIniaTEc5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 10:41:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5] doc/gitcli: minor fixes
In-Reply-To: <20261124-b4-gitcli-v5-1-450d50655781@gouders.net> (Dirk
	Gouders's message of "Tue, 24 Nov 2026 09:31:55 +0100")
References: <20261123-b4-gitcli-v4-1-de130d0e07e6@gouders.net>
	<20261124-b4-gitcli-v5-1-450d50655781@gouders.net>
Date: Tue, 24 Nov 2026 07:41:48 -0800
Message-ID: <xmqq4id6w81v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> Fix some grammar issues in the gitcli documentation:
>
> - use plural/singular where appropriate
> - use imperative form when rules are listed
> - fix a typo in the first rule regarding flags
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---

Looking very good.  I have nothing more to add.

Unless I hear objections soonish, let me mark the topic as ready for
'next'.

Thanks.
