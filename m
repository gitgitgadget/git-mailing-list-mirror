Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469049;
	b=DNKG/7D63ezDW4YELkOtMhA3g/Vdr5qGl1kLrMd/aqumCFoVkAeNtvp8c0mT5Y13aG5w
	 gRJLeAm4m7z8RRg3vA6q1pggpdnldTT/BptCb8eqbbjzr69YAQ9U/7+v9FdYX36DRye0A
	 jStHqf0JYF+Hf9QPno3CV3O+kK6OKBfT23Ir348rSsxjeh7jfjhDU23KCfwFkjQ/29aOb
	 Z6d8rqErChsUdqGk018+KPPSO92TQPPgFAblvT0cUbzyUnvwRRbEa8/TT1ARvkMrmDdaP
	 ZJoNG4FnAoy0HkjR16KrrZFZincJfiE3rN0bGvhT4Yy35S9M75Hq5o6rh1bFAcQ/L/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469049;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XYXIVVwz3TrH+jN+BQAP1pw4QgaaN8NwzrqqRSczpg0=;
	b=FO9PiZHykKLka4qcRPruAMfhRAAYrRAEwYStAdGW1dHfLI0k5+3Z0e6DhaoAuiuMblMh
	 ausQYYA8se//VToBGokPwWqHI4X23EIM6A3QO3aIsZKWLSDRHEQWBgEMxnQx7hFxIfgWS
	 voejzmigszDLQMhjX1cY0Zffm4m1Ox1b1Xqq1+t5f1dXPt4alxOUrwQ8PVZJzgh0DCSWC
	 b9a59TiSEmsE9vB+ZGGVnHAsmHLtofcqrMRX7EHZSaVAhKPAjQ4OILfpUKxILs+bRbbAU
	 gxBARRLBZ2HEEmXMKE4KKBDuOz3aSyMH33pYQIRWQhYAWTwp5qOEmjswb7GKND9BvEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z7zWvHhQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lj4cRCaq;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3C606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z7zWvHhQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lj4cRCaq
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 810251D00652
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:24:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 16:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795469047; x=1795555447; bh=XYXIVVwz3T
	rH+jN+BQAP1pw4QgaaN8NwzrqqRSczpg0=; b=Z7zWvHhQz18EuM+OC6JhklPWBu
	qOrLCrbFTlC3giwaTzltYiXyk2CLUI9brG8D73fz3CqPtbEpVBNkpDY11Ee9K21Q
	duIxg4x02EIOQUpb3yw+XNh49jqpJ+GELmFuherSmAmTaCgwoWDMmNkwHNQwAzM4
	4iMVuP3AiHavlhnTZXYrGCwxKBd6J9RaOmzgWdrvbnb7yCTWImJ2p5BrW6ELOCUh
	akqv41I7JFqJY8Bu9EpvCdU0SZ5ey9ngwVB5op9Iz9I65N2hNqpX6eHDDp+wNDIs
	SfB/pGZPumMK+/zaHtXlojekBzO7KrS5xgdt1gVkyLXtSgPgYpAKVIRd5Bfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795469047; x=1795555447; bh=XYXIVVwz3TrH+jN+BQAP1pw4QgaaN8Nwzrq
	qRSczpg0=; b=Lj4cRCaqgx8k0N5bPFnC2vJqP1jWfrOeHgwEAFZoIla2plXZWj3
	sEPVRUunU5GgL1tQ7QRtIAuXCsYZNVvnWhAq+Mok0WYN8/Smu75gMTY+hfc9MXSO
	bqzAWmJvPmAgclygaeYbD7JHS8+i16HBZLX4rTNfSp/lcAcG4SKPSYXDbyL7/fbz
	80Yf2TdqWyFZ5nMlylfM4LTxEDWsE5g8kpX0bQpQTGSL7GRS5SQSD6CuIExtJQgB
	/it9cSSHgLS6KQjtIZ5zgav6xY52dqbiGcQjLUGqoqQgLDLtTKfW3+VJk7dqdixg
	k+zuLxYivVY8ITHbDTrYfWEcBI+gwm5pTYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795469047; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SLz/WYObobeLE2Ivi3Z0QCnPEWCp809X3E+7UtH/CBS2RPl
	URf4QFBYzkJP3krXi45XatTlIYmYknI7J8zQ2OWQTjyHwp9RNUsYZ1eyDNmbjILB
	ket+wzBLhW9geFk1ND+2O8BAMZioXTMWzmSBaCPBBkJMawTbugh4gHVSo/GlnwHC
	kJ/O2N059wFZfjZQu5J6Sf39d4B5ewg/KIN/JUT6tbW+i0+WcLQmvc8HpukafpIy
	kxTws1n7svImMPlYkw6Mcjm/7EY20L0FIWPtrr1VigXJOqS2XJ9W/SDewBFCjSpP
	g47WHUAS2fD8WA/+/gxm8lxd7obkaE3do6C+jNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Yr7aiIn9iNiXvN+WfhTPalbMfzP+mhYKacZB/awLMXs=:eioxwSUh5Ge5P221Ke7nI7lvYknFKoV7rePTUipkf+4=;
X-ME-Sender: <xms:964Ea7lfGNG7QAvjqSTlOgnBWSW57IqbvhXAZSPLa6LuddO0psfU6w>
    <xme:964EaxbYoMzdnT-hEt0_CKUvf5yhjwAHFr4TAmh0FgBuBRY-w0LP5lev3A-fubdQW
    932aZ625ObD-jXRjvmky3undg45gKZGVx2ZrT_LUsqKiZroeEiLebk>
X-ME-Received: <xmr:964Ea1SaBXJT9YVyjCuw8ow7sTQAkItTQhHo6AcYbbQzsw-ye3VDKO5FcQh0pCVHVlWPVjiykqTMFeST5Tio9zsgxu-XS_pw_nE0j_I>
X-ME-Proxy-Cause: dmFkZTFA65ZLZumXIrnQ2QTsRXHWBTlPTL2TO/qPUaAnVAcZEdjDYhYiI+jmyDohOgBTCv
    qtsysL3HjTb9svYQylZg9AYfbMja/XJUDXsFzRxgtIXhOsD0iOmMihS3PJGG6PLZ8MCxp2
    jntLxYT/QO/7NXQzrCP5qvi+L5gQZafE5tow0jZCq3Hi8ascMa92PNa+8XjWlG01RU1hr9
    eUBh/4OPKbCbXt/y+RJd8lONa4eyLp8OWeNlOgPRofKixf8Pw+SmSAETKLvEVbSzatN/eQ
    cLIulXE6RG9FKqc6/veV7t0vo8X6bHvKwM293fVYtRjLW7H6eGIc9fcp9/EOA7b8Z/9HK0
    MSZ23Oj4Wp8yAZd1+VNt1bKJuFPcSJOv1REEfu0bcbXjR2BoPtGCo2t8S5yWV+vq10+41b
    9nbXspdKVF9wuC3iFVoQEwTHAIGhLZP1oKtxqenrNoFIgAaLmxkAsNqmmjCv37PcfPNGuK
    DC9FQ5j8t2Xfkp8LLue5M6uc/pP8uxFPUyWmSPtfMXD5rro47rFGZrangmEopFEmUU4KTd
    9ITy7u3spGc2p/kg2UBqT7e/wMe3utX4N07qmtT7h0HPXYz10VW4b5SvH9levGEeKA18L9
    gHPVNiniIBSE1Ib3DdYK1mIKAq95rPRAW3j4nvQ8nJQF9bYdc4XhSwxTBFBw
X-ME-Proxy: <xmx:964EazvjBsAR-_4MQdnu_SWO5RWGHb8mB-gx-qws2T5-7VsupOoqkg>
    <xmx:964Ea_Hx-RhN7aMHa90UTw82OksEkKC0LlMk2WRKr3BJAby4wLjQtw>
    <xmx:964Ea8w_mEvJNM65exnp0PBPPS13EVrrVZ39a52RnQyISgAX5Ho8yQ>
    <xmx:964Eax1uO3qd0wiK_LQfVWgT5BXH8MUpGmcDbVb-b6OHIpIPl-E25A>
    <xmx:964Ea-5PHuTHnGKH-IUAb_dzPudxT8EO3oc9h5KzKwntYspQlWE0wN-v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 16:24:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 21 Nov 2026 20:41:57
	+0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 13:24:05 -0800
Message-ID: <xmqqse0r44y2.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * New commit: --dry-run also works with -d and -D. It is still rejected
>    with options that do not delete branches.

Much better than before, but we still have a few operations to go, I
guess.  Users may legitimately wish to try (with assurance not to
cause harm) renaming and creating.  It may be OK to leave these as
gaps to be filled for now.

What is important is to wean us from the "The dry-run option is
incompatible with anything but the delete-merged option" mindset to "As
long as we add dry-run to the command it ought to be supported by all
the operation modes, but some do not support it yet".  So, perhaps in
the ideal future, we may want to see

    $ git branch --dry-run test v1.5.0
    fatal: would avoid clobbering existing branch 'test' by creating
    $ git branch --dry-run -m foo bar
    fatal: would fail to rename a non-existent branch 'foo'
    $ git branch --dry-run -m foo bar
    fatal: would avoid clobbering existing branch 'bar' by renaming

but for now we would see

    $ git branch --dry-run test v1.5.0
    fatal: --dry-run is not supported yet for branch creation
    $ git branch --dry-run -m foo bar
    fatal: --dry-run is not supported yet for branch renaming

or something.

Thanks.

