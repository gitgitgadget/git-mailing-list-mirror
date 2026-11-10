Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327222;
	b=MhbHWFgjIKgnzcvMWZhUXpDgT1RP2WzxsGf+0/Z1Fej4K4p7FKk+onR7cp2XbuP9ps/w
	 0nUHPqFkwlP/2SxS3dXy7bo5s+8kdMXDVrNXRDsDZo61VRK0O9n1k/bX8hNsf7tiq8+cI
	 tTNVNshigPDqLaONKxY7u53unYFV3wvwpsVY7sf+Rvz0XG5Ns7j6XAovNZLnEHPZr5rZn
	 2nBCLgT0E4XSB+bhXGxD/qTzttJwhsdgrd2xJYlmvQ3hj3RVOP6wMNOexncr6H+tWe84J
	 kxPTgVkzkJx3SG1vyB4sZ6gYwCazu6XzDur5KL05tXCJGnkmDMuMcvpI3MhOX2CvLxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327222;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=M0oqiEr6/Z9G6rEBEINHlINdHKCJ9crNmVUYBeaMKyM=;
	b=sPWVr3qBzE+4W7WM0UXfZONj77OFfr2XvUsGB1bFO8v7iJOyU04jrV+YqyBbRAZ+0odd
	 h+5prRf/tRelJQzDlrFLaskSXhszriTA8NEh7zETk13Ut5vyqlhkKcuahkXKQ0i/awuzI
	 dT5GbmWmkrE0LH1fu29cC9RfnsCVo7d40LX6hM+fv0u7GnB0ybBorztndQsQpe3m5gNuY
	 MeShaNnVnecc3Czv2ccrRNSTfzbfQtzOE0gFGsT/wKSizWdg9sORsShbwkJR9O15jRsFi
	 0yhPF+4SdZMRyZgaK62WvrqXFo0ip54BG3zUIUjG6gVYFp3rtvj4p3ObvGtlgOdPG2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="VcuF/dh+";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="r/q2xFFr";
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E2606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VcuF/dh+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=r/q2xFFr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D5CD7A0135
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:13:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 11:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794327221; x=1794413621; bh=M0oqiEr6/Z
	9G6rEBEINHlINdHKCJ9crNmVUYBeaMKyM=; b=VcuF/dh+7wwaIVB+zrE1OYemO9
	3h363Ly/ogCBXmdINXL52FIoEm+BHngym/vO2MyCfSwOSkF1M3zWzzAFFa3+FqkU
	la4ntY3vSe5wyPEGQsx5s4Sibl3yDzr+kLFcmO10vR8BbuKnxND49IN5/0avR8QE
	ufV9KOTPkdHiZN+lUzt8WSdpv1GFnWUtc+W8r1fgCNdHQRZVYLWdsLxCQttkXvNI
	ceTC1gX/RiO6pzTVfAKxByfErfqSIORVXC5vDoPVbBqGkHt0rwWcPZEBB1iEwky4
	Uej9R2TZEN7nMEiJGSErGhPTDBrycTz8zjmzt/6X/eFBa6iPsVnmP79R57Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794327221; x=1794413621; bh=M0oqiEr6/Z9G6rEBEINHlINdHKCJ9crNmVU
	YBeaMKyM=; b=r/q2xFFr4oJctdOj02957Zpr54Ql4GrozddVcmdnRMcRcJMM/zp
	cidoyWVpV5Rqg5kXEOkUbJujuYfAys7uDC7yrZZgGT7We8F5zjgpbyQtdr+hdh1F
	f64mEvN+TnkAGDlUnXI3gQ3lOQd4UV5W+93GFVA/DnWga2tzo3xi+P6Wh2bB8DL9
	MN5Yb1dTuvOoDx3ecd2wuRoFkiO7oNyChtwIDjPRG2YGjJHejtlEUAUnj9wwosQD
	cbelcGtrChrUyH78e0MneYWNpDhjVGQ4beY/jFQU3HLW/lcPAwQQdokCR2Oghy4P
	x9B7ay2aQdjCxDEJG8VZQahz80HgmFU+T0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794327221; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LBkde/ktk5v6OicDQ1au4d94c6FMsu2yliuEfj750lc4BZW
	NyJVO5pi3YDInugcOqSl0bCTKzO/cVOwzW6Tal6Bwe9hqInHuVQbzQ0yIMqnZXgG
	LnmEbduKECNeMNfRGAGn+4DaFwROqp10jRfCA2+bDNju3V7zKKJKVeoNKGduRBR1
	bpmRjknNVvJJJjQrb+xPurHh4bB5hX8LY7MrantIJtlaB+9Tbm7ord8Knd+hyCbj
	WQSaibqlzDb353qSp0EVWLsQGU6B3sSQwhCVqrlom2MXee80DYq4EJcL7GRDKtur
	PNNpUAGMxA5XhTeX1e6rGOTPJGPYdTUv987r3jg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:X/r8HNQna7kQ2puyBMt/FewA2rZB8LX/o/WAQ7Z4PA0=:fOZY/hK1OkPyoL0O16Wno+PTtiTvV41tcETpc/1eky4=;
X-ME-Sender: <xms:tULzarxE2P4O8Vl9uL1IIuPeEd1WN6OFyhPa_HZs7MxPWb85H8v0HQ>
    <xme:tULzaqsj-OY8R8j8Rh4ONe1kuHamuMeTfhQ910groPDKolW84s_AloCXkgotFyYbB
    YSuKCo0YuRv5WE13QhaBFBIOcIrkI3TdaR20QpOpECZ0yuOgLSS2lQ>
X-ME-Received: <xmr:tULzaiva1Kdq5VTL6oh1ri2iMMOX9npIz0ycyyWNfzy0t0vwQsB5Nn0wHijjixo9tXXaEXomq62csNBGoHlgxr8LS1Khvz7D3FTz>
X-ME-Proxy-Cause: dmFkZTEa0KVUkcw92Mh4jo3cVWiySlXyDoad/NUazXUAtYc/0vAA4vRD/6x61GBZ7ZweZk
    OpsaSPIaMyIWqJOHr7x3iD8rbJxTP+kLRECrB/NvzM2n//00a9Aa4jHt6VVYUmlJ18/5fB
    +Fjfh6hPD9+yw51/c8pJHQZfTDLWKEzNJom/MtKmRPWQFm08pyPk/VPkJS86KFEFJzILOr
    zxOg0/5dZW/MKwMz+iCXqGVIqaJfuM7bfrEZlMcWNuBQJaslPXzC0NlnG4RMAEjMw1Pncv
    V6a3Q7QMEvxCpGj9bwJ+PIDGplPceaMGyFxga+Rn8tVYa8JeRIDgbQV6Oz97eaCMVlysBD
    Man+rU6hYdojMdi0URYbzPfdNPRMXbwDLeQntSkOEsthLhbHo+5DqifQLT+owFz73gpjPb
    XF0Vs1OHb3h3DMDzEuhlDlN+ZPKJMN/yvlKFsmHg9OvZzWiSYVZJB7QRCXWw3Y7irEYd07
    GRKMHCWy1q96ieVzIh6mA1AKASzWY+/EZoOKZio0sFhBpawTCRWERpcn+gxF3sYyUa3M3o
    uem0u5GIh2J6Y5UV8aKq/mQgHsyOiABWQD3QEKbkLpZAq5xAWcf9c35j5ufnGq7ffEOah3
    G62Myze5TjVMrQfMI+kXh9KvjRu7vyvBI3YEqyjbVR0CgTcEjrxiTX0UyzHw
X-ME-Proxy: <xmx:tULzavMJEgSjFkokwqvazOc8qeSnWdiDe4WZ839VCZs3CiDrKEKbOA>
    <xmx:tULzag0KBEHIIE8V3il87pb7u-s-NAcit-c-OuvENe4Gap_LGU8o5A>
    <xmx:tULzarN2TeQMKZVdeZVI55pneiYHfaMoMbbqexZgxpacUTGhbNo1yQ>
    <xmx:tULzag1md-IQ74WGaswRAaonHOpZB6cjzmzVw7FG9St-fJ3NiD1Z8g>
    <xmx:tULzai3DXV3f0rdKI_tK_mkgXKQQdVTE_7pEwo1gPm_wk9Urub_hmXhS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:13:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
In-Reply-To: <avLCDTHuScp4iLyj@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Nov 2026 08:04:45 +0100")
References: <xmqqtsltbfdv.fsf@gitster.g> <avHNf-aaxdsyim7g@pks.im>
	<xmqqecctzttt.fsf@gitster.g> <avLCDTHuScp4iLyj@pks.im>
Date: Tue, 10 Nov 2026 08:13:39 -0800
Message-ID: <xmqqse18u0jw.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> All I'm pointing out is that there are cases where we could be as
> defensive as everywhere else if we started passing down the options to
> calling contexts that don't have it yet.

OK, that does make sense, but I suspect the current helper functions
that do not get unpack_opt do not because they do not have a reason
to access anything in it.  We could throw "struct repository *" into
that struct and use that one (ignoring the one in the istates).

I however think that would be a separate clean-up.

Thanks.
