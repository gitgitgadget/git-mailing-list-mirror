Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177917;
	b=ie5YmaLgkUcu/yjhLZm/LNfOwYCkaJMV2okWIN/4X8fpFogySL08Evq9ZhbqbSVf1oD4
	 A1KtWYdDU6c+pHxQS3BDRK8AHDVKlK3bVF2Kc7lTgJSl77N6vVAUaHDo9Y3vl7Xqz+9IJ
	 fL1rAWDHidNgajTPCzix8ePCgL/tDwrh/FpTwjtUnbt9npiF+34ZPG6Lji30kK/zvkOuh
	 7iK1osMcbaAme+a4LWh3Th0zq/3xHjr1pyyUoPCofuXF4zQtAPniFgRJ3OG++twH4camD
	 sgZLHiUWMhxM8MinlBnJ6mcTMqyw4lVS1pD3KqbtaujN+lHKEqTgCX+1nAL1DTsO8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177917;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uO//xcu2di31LjxqcooRKTknPrkQxdfiNEuqgYxKGxs=;
	b=icWnI348wf3jUt0iUogftyYdktHnU1/8BI6e7hzbQ37aryv5/YRu/8zu9KLuqr+uEoEs
	 aekiZTIyp83kkbyJ0RH0KpN/kgQHfjuS/54Q9BuRhQkVL4ORazE5TASfTyXJax6po/Vtu
	 7XzRM5eKNHhp1xXfURfuS7Bev/iS8bskB/X5ph6+BSb5MU6al4frbiK6JXKh6fRyHTem9
	 hcNWnIWkd3H1YgVOWUeEJ3MESoMHHrS+sLz8DdVnCu65NTK4JR/zP8UlbPdk7aCxro26O
	 xBRbVhZQk/jk/ZPL1X95Lf03cPHZAITazsnZpeSBpEN1ml6Jd78iWA1p1RQF3E9iGvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vGJx8TnL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vKsjWDrW;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4C606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vGJx8TnL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vKsjWDrW
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 46E261D001EA
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:58:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 04:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793177914; x=1793264314; bh=uO//xcu2di
	31LjxqcooRKTknPrkQxdfiNEuqgYxKGxs=; b=vGJx8TnL4a/wqrHBL64/98BZWd
	HaXSDTaEfF4MeuPOkyE05pNW6Qq1qPUOsFrdQ5352bKqk4MpWzHDChRnurVApIOn
	C0vFCz1DDgEfqfAz7ZRCM/L43JBvqSeMFlb+HuShp5e4vyN4RSJ15MacLEgWKUSS
	DQt/rplstD+FCSTKR+U8YXmPuiW5CKRRKjgzXKi/0nWKC6N+2kQdeDa2atkoBPmc
	+RgdLjffsfGu4hpSkHbRPzyKF2ZTshokNVjOWgaKSOFptsqWRfEYvManiaz04BfZ
	hYo4PnwknisJWmlZnaDe9NnVJPVyIe9cywoj9vLc2x9I/apDI0jJptSssH8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793177914; x=1793264314; bh=uO//xcu2di31LjxqcooRKTknPrkQxdfiNEu
	qgYxKGxs=; b=vKsjWDrW+OOKj5JqlVyYSQzXgPTNXmlDMPL+JoJJ+bN6C1vsoj+
	aDhpsFfu1dOvVFRgXxjr+UXtk/l2cIMmt0e7YeJZczOV3LXly3Mo5jxo23fR8C1C
	J2VQlI6pIJ4lXYqujNCkvf/k/SaqpIZXV7B+xv93GQUKaO4Sx9m965kw5iTcwQ7v
	TnQiILYa9CsZ5/mFdEO0DhvtjIbucOHiLCaYoxcBxkdjecKD1ylA/QXuuKYRSk4v
	w2L9BcG413CUhfrBfiQTmTWsK1XYC6mRI8a4zPkNJthKjltWUSon2k3D2Fooxtda
	0Ku5oCtd36MKCE7UF5ZAmpyY5DBpZv8ubaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793177914; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q3DvEfbKlPzpoHBSlXGvv3v8Bk1NIGRAwR6/Bg8rPJ4UNQA
	UDWLGn0bnrDVATrFcoqieZPdOvyHgInA/e5SCF1CJGQdAgmEMVfQAeJ/vG9v/I3m
	qEnEQO9NfGpdRblEhP7U7OWQn2KfjBaKCP10RsOML4XgH8ESwFezwSZVxW+vd1FY
	cieOQtgA5mc0aFHFh1dP9nFdF3qMiacrGMsh2iWGOapDpMgQFe/5IDm+XgKb6OEs
	+d3PDlzFNVSTTwd8pbkZqw4Uxl6LKR43DB06w5vQeweWUubxotDZkY+cERuTTFZE
	REmG1913j6zsc7dFIK0kfIEvkDkJselzxEsisZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/kyaCdpHhgrfEE2SH9L/MUHfkRzquLFGIYPncu6MVsI=:j5JFyCdvqSEBtG1WLFv1mDIVFFqEDKSHzESXfu9qoyU=;
X-ME-Sender: <xms:OrnhagkEHnLIHhZQwsOLmwMIXyDzqHwFKdHezKp0quD6WiLoi0AJew>
    <xme:OrnhaiHSgRMskY61azLwx_Grh_5WBoBuc2M_0Jlum0jfkHekSKgbOt6d1KFbzWIbL
    wrCxxvZ9-YyWx5hwHXLET1Ti6c7C_gPm02s2qUSUSqMsMVJrD-gGI0>
X-ME-Received: <xmr:Ornhag76vzC4R6Q4XwnzcWEFEIERcfV7QgGE1lGI9oJ_xYFymQNQZA>
X-ME-Proxy-Cause: dmFkZTEzqNGwKlS7ZzjhOPo1OA6WeZtVdh7bt++/MAnCPSLvr/Ws8Cd4QHCCSqT7ALQVnK
    K7i32iZ3CRcs7pcsvLdFAP9XqgfPVTKAQlb51Zivz1LXQba9IDm6FyNURFgn0CCppNTu7J
    p5RL8c/tGQEHhp+eXtlTFA9JQE0Y5aVxJDZP6os/6zDnBCbUr4HXO9nzMKJy23HdGSk058
    Rpzvxfn4jigTYGJak11GwCVNrtfpOQqYWznifarzRySdpd2cfiTjxtgpyEmbGVl+DvmAFC
    DtvwZD3S1CXSUpnMESfU8/qEElRlO02z9MTduA2/TRu5xx8DBpFRHu1ahCE5RaP7A6CIU8
    /pY/dkNzuFyI2+YFiUu7RRjsI8etGH1JBqH7JjrBW8/pleTBJAIX+GJ94Bq6GxbczEdhRo
    PU58cl9TBHStZ0o5Idt4cZOYngwjEYAsX50muaBt50Qejv1/TlFznz5XmjxQOKHKFHqjSN
    Jxlg5zVo5P4zzG6TAeUUXCFCSsRvmrnIYhBRlWLA6ajb6j1No9QEuE2Yzstk/UmfUwhMpu
    INojLv9R6VGq0ssLqa479enWgAvEvGTTPc7J2QMpLUTv45kP87BZaD0wtjdUsHSP+pn76Z
    U7YvRyq6LBhjj1ebwO8n8LJKp/qSQT0tAT0dlaH3NdlrqGXGXvzGLKz5XvTg
X-ME-Proxy: <xmx:Ornhail6_XOKWT1NB7zp3on0R8G89j6o2YjzxA3IrdnAxCYfzqawYw>
    <xmx:OrnhatqtLpInB5pzxK-cQ6_QcxQlnADzRAGb8X9cfImLuzouadnOlw>
    <xmx:OrnhaptBV9F9jWq8O5JqUpkZEuYFe_0_XomGQQs4XxfpOlKu30rEJw>
    <xmx:OrnhaqGM1t9gxR0GJNuOPoAXs3D6uKzGK1c_0mrYi1vhPXVz3QpKog>
    <xmx:Ornhakmf_7ovk3KJDxZQc62LemkFXssSkHwXdv9OP4Ptms1YVQnENRfL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 04:58:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a1c60c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 08:58:32 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:58:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Venkat Ragavan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Venkat Ragavan <mail2venkat21@gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
Message-ID: <auG5NTowgVZG9L2Q@pks.im>
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
 <xmqqzevyg4w7.fsf@gitster.g>
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
In-Reply-To: <xmqqzevyg4w7.fsf@gitster.g>

On Tue, Oct 27, 2026 at 03:22:48PM -0700, Junio C Hamano wrote:
> "Venkat Ragavan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Venkat Ragavan S <mail2venkat21@gmail.com>
> >
> > When seeking through loose refs, cache_ref_iterator_seek() compares
> > each directory component without its trailing slash. This can confuse
> > a directory with a similarly named ref that sorts before it.
> > ...
> > Add regression tests for shared-prefix names, missing nested markers,
> > and markers beyond the end of the ref listing, using loose, packed,
> > and mixed refs.
> >
> > Signed-off-by: Venkat Ragavan S <mail2venkat21@gmail.com>
> > ---
> >     refs: fix loose-ref seeking across directory boundaries
> 
> I overlooked this topic, but re-reading the discussion, aside from a
> test that confused a reader, it seems the topic was already ready to
> go?
> 
> Any objections to the idea of making the topic ready for 'next'?

Sorry, I lost track of this patch series, but I've reviewed it now.
Overall this looks good, but I wonder whether this really should be
split up into three patches because as far as I understand, this single
patch solves three separate bugs at once.

Patrick
