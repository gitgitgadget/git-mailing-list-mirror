Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187070;
	b=YvlSAAEkn3NJPpfOBTfdhGL8aozd9QfW+/huivNwl1mYjjT0vjY+8+aaAG2lPrvQjI0P
	 LOnswfiXKrYkRBljWBJKkZNbWUcYaEb3knZQttcVHugW3PCvCwk39Gn7rY+rdFfDZHw7U
	 yMfmGmRwYc0+coW0ThCcn27dE7GxjKOt6R59HI9wnGTzVwC0jsUvG0ABIB206vafrseHz
	 1oLRx5Xd08DBroqvohnMJUou2aDk2cNV6fkG9FnEUonAlqXXoHoB5bpNwhnBcccvWUy+j
	 BG+jkNaeAq2PC92ztMQhRbaNTZo45J1nX5FVov6CDJ9q53SoF2yQt4RvszfMOzsjbBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187070;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fOZVlUDZOKRwjJyptL+b4Uo/qea24uDevselHcH3IYs=;
	b=IXADTT3gp571Eds0ris9Gc5eVPkblv51sqxcyzPNKJ5VsWMflBfJDMie9iAlESBxHGr9
	 K7FcoHs3kM07RcfNpcBf5/fV87z0DYabR/QNuCBkUFNcjpXQ/BXLcjW62U2on2+ItEIuL
	 9A1IlsetrdqQRSog56AgxtcAox3LpSpEsyx49wi1kIl2e0pklLsiDmMQeQVz4zm3iYPWV
	 ynsV0f8howgPeJJ/Z2tiTnOvMCKEmG/qTnd9vn7qVyiS6IVMx+8/JI+g1+7lS5EITDZJN
	 7zbQJwAqkuj7WBwbxZsvxQfdrZxkK6joqFQ8uZmmizJ/oMuA9SWBJI6au/4obJYDfCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="RTc/Q1eN";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="iTc/pIlB";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB1606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BDB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=RTc/Q1eN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iTc/pIlB
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C7661D00211
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:31:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 07:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793187068; x=1793273468; bh=fOZVlUDZOK
	RwjJyptL+b4Uo/qea24uDevselHcH3IYs=; b=RTc/Q1eN+OLiGsIjf0PY1teNsi
	z+Q6KkabTO79LOVTXnTxaf0WJ/HSWlI5sItGJ0wMv3vvh/JjMxrH+IYvZ7qe5AiX
	CnnCpNmFdgLgGEDYn5tIUj2w2c7ZRv9Eib5431J5WaU43LpmPf/2+qHwvgRvvkRm
	O4DqOsFXNBqcHZVdKwJEeDxpyq3e4r+MBSAFEjyextjzn+8v6/vli+Dn8Z9pKZ9e
	kAqPfbHprXGRKiAyj4QZVAmIsNfimpdmGT7itTgG0lNmYgyK3C2R1BOVMb8XDJRg
	3wDJMVj0kY/zu5Hp2scD2/CTRdIolQ4AidRxuxgLgD7KhU2m9tlWC7JFAGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793187068; x=1793273468; bh=fOZVlUDZOKRwjJyptL+b4Uo/qea24uDevse
	lHcH3IYs=; b=iTc/pIlBGrOboFr60/FnB3/vbZyKhxLzJcFj432XIKpaBRhbC0i
	5fq/DK6hHyoeonwAJJILQqS82UdgP/xrxjSM9m9aie9SFxk4ER/CE3A4/i2qy7sa
	GhjNUH38sd0QD2YwqrUOZRvNjpBsIzf1ojqsu+5h6UsmnhNFsd0EoPvGydAE7iwT
	JVwQKWu7hJs7P+aKzYMKW8ZPLhaKs9U8/mXu4VvZsPdcckIaQJV9VlymcKMslUEn
	sVTUs1Z4APNKJHKOOMZaoIwgXdijJ0ciOo2BHizgUSnL7ew447TefUgCiu2h9aoX
	tKjjvlL/GlyePcVsiG2zmDo/p7qD4DoD5OQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793187068; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b5LhxaCJFHL21kno/gJEuQU7q0sRaE7XfYnZZ1AspzQQEP+
	Upqi2s4EG2hOcs+4IWYvSLQny6a9rAuBLRM3sb+xj3gizU5JVNruhKaS4ERVFtit
	P3ur/hTRy4x0avNJ6vZNtkLvVRAQwMlYzK+pl8C0tTLejhDp3BgH4P3gC3B+gaJS
	FYERx/FxiQREBt4eDpkF036zVG2Ng+z+LdqBGz/73WYKJQ1zsK5eef+Xzy+rvtP0
	4m3ZZZOFZRrfsBMT6WaiWCzFscIIGhY9+I8b46EyYn9NmM2mCy1rpgYvXqFpNOvI
	wm+Hcu7uBGC5/vZpjJT7ivX3k4nI3aFddkZPmjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ljG3q7XJdxviraO5o0ylxsEFPoma3NkTiZMStIhL8V0=:shNL4AVKxYDZbsrBbXtQjVY38W4J/1LNgt2Sus+9x50=;
X-ME-Sender: <xms:-9zhagqTDkNVsZXxj3k8A5blWrvTEKSU4SLCd-r0W9iUmmG43yZrQQ>
    <xme:-9zhauGOWZACxg4JkLu8jVaMpsnctDL1hGTtaWPc7P2EQ2mlLYZdb3RAo3UAVVuxk
    wkMKXOg1uKkCw-c28Oe-UiKE6ASBRoy_Wn-FHCXEMeNaAkxguG0aUc>
X-ME-Received: <xmr:-9zhaikEavacebm_b5AiFF0PW0t7Ms7D_BES_fhTvKTuwQVRyoLfjw>
X-ME-Proxy-Cause: dmFkZTFLVcA/QaoKEIHC1tGSDikxbBwi0aN6Eb5eqV9Jwj22cxwi/FHtAMtRXjYj2yvrld
    LHyo6Fu3RFQdGAlJVFUet+1avFv3Ft3jWDDt+lQ4sIvUuqNmLEhAH/SSYZFBCMzIYMXn3a
    k1vVlTR47ze03hRHse0+VPSGibZVLWVmYKjIi2iVsddf/7zr6T8wQ7OahETnAq8Sh9PN2q
    3GaQmYQ/HCoN7hMXhYFHBub22xTtIi+2Ztca1tG8KkKPCu8gpWCqMC84M0fSN5KViYrsq4
    uNKcbfmmX/utOHc3KOfbOlWq2frmKAkRvZcqhpF+dJQok8y8w02eD8y8CdRzq6T1Gy3SsS
    heL9M2yTork8P9fJv28vc25nQ96P79HE+iU1oYgLHz+gyemTGFNf5Zy1Ht+O9kBJQZrYR5
    zBHbPnX7et/+gzxxdIYaZkiYI0+EU0B33XZgHF0Hd9V9bihQqANGLoYi2XeweML4Z8vZ0w
    iDY5BiEanTomRRSctbaxqXFz4oO71gXwH7AeRxWXQ6+TCO0Ev+GgokKevyyFTMfgPSGjyZ
    95RWAaJLKmdoalAFebOyiI4nMXNfHT3IhuGjlHcomvz1gckfcO6H4z9CsbklnSilGBBopw
    SIOhy6xbdzuyBkB/AqZkdCEKIaugHQ870yvKjsgtmLzs+NA+vBGOSimDkcig
X-ME-Proxy: <xmx:-9zhahkfd3eNOPSQlYPnKYrnjOCDsniCs7KiBv1WjcQtU-CfkzCO_w>
    <xmx:-9zhajsvFqekQPcztIxBstRz2N-VxzAVzV5T57GASlp99iFssQIhsw>
    <xmx:-9zhakmf1tG2zgHPBs6wHjokOqdDt9TO63-5R_tq4rYiBeVBKNV8Rg>
    <xmx:-9zhautxnL7FC2pEDmAqVOF-zz9I2lyZ8ZAWRqIaYx-9_C3d-tp5iQ>
    <xmx:_Nzhajitp22U6FAYC-m4aiewATVLiERcZSfOIDJdDwVI0AyBDJMvOu8p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 07:31:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe037ec8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 11:31:04 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:31:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 0/7] odb: introduce object storage extension
Message-ID: <auHc9TeCfrCurKTM@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
 <CAOLa=ZRWktyBmeeiMbPqnX_OkizqPA2mmGrnTABW7Pkk7DcKpA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZRWktyBmeeiMbPqnX_OkizqPA2mmGrnTABW7Pkk7DcKpA@mail.gmail.com>

On Wed, Oct 28, 2026 at 06:53:18AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Range-diff versus v3:
> >
> > 1:  906c3d3e3c3 = 1:  f09fc3200f9 loose: drop unused `repo_write_loose_object_map()`
> > 2:  3d3bcf0f825 ! 2:  655e1de3b9d setup: introduce object storage extension
> >     @@ Commit message
> >              allows you to configure a different location for the ".git/objects"
> >              directory.
> >
> >     +    Making the location of the "files" backend configurable is not he most
> 
> s/he/the

Fixed locally, but I'll refrain from sending out a new version just to
fix this one typo.

> [snip]
> 
> The rest looks good. Overall I'm happy with this version!

Thanks for your review!

Patrick
