Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759839;
	b=xS6uszN/7PPcOSidfvwFUNNAq6tLEJciJ7J/i62xWOjyzOFb2sVmte8kIBbdhDubd/Os
	 dOk6QS+o2kDiqAczWCFbFeI8WEPpU3gI5T9GLd+vbIASMhmV2twadLD/EH9CrInJ5eNGm
	 GgaMwd0u8zAEF4WRxLXz0CDVNF7JatIb8E+LynQshMZ2wXRGR+qKdJDsUz4AHtpPW0JLO
	 DOT/NWvCCFwtVL/r8v9NT/D48XeLEkViaTxHg7mq2WdOygahzKBpj7b6yfTy0U35eYUrg
	 3D9jGHRHODGdsXVWPTZU5eZYAS9zt+Y4ObI4dLM6hvaix2kFQxWnu3YWz9QDvNyufRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759839;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=Sgg6MhCG2VmTObaFjRzmivYppZQM/zBk0Qx9G2oC+lI=;
	b=JE3Z7R9zBE2WInx/a2VoLn4cpKmYdZaHh/3Mm9mBJIBKAAPtopkkzoQNa/eXiLaX0Ugf
	 SRPfoXVsbz7iIRFcYg0gk0meJAvOZOkUqeiNP3q930DxVMZerzunEx0looY9HbhAolqnL
	 Wu28Jj9+yFSolUMnWaGxk0XlPP1S2A7uEr7D1KrCcQVNz8EwudHr1ZE6RFvqQdYtN7jn5
	 e4YwcJWQAOTuDETAyZ9x/a0/5zPKFV/LRpM1t91kjLua3PmSMwJmickJb7ct9+qBNNacN
	 UbUuqk3KY49xqTGEB+sTxq2iHuIMxglc4N6sumb1SEDHvgIoYE5G6e4vc5hnuyU0Ouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="bR5F/Ea1";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MAPPWhzA;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE0606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27DE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bR5F/Ea1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MAPPWhzA
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84E517A024E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 08:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1792759838; x=1792846238; bh=Sgg6MhCG2V
	mTObaFjRzmivYppZQM/zBk0Qx9G2oC+lI=; b=bR5F/Ea1KxXJfN5ya8QdyUMroz
	HrGjn0FYvDwb/+yyEoYwr5rG2d8xvzWtEuR4PMoXzcV8346mOFsLss6xXKo1PDhT
	gzIiwfEfO3Fe3UqIeq582bUcjuEDts+bfUwXKAgtAnOHHcvA5xoWREgixkACX5pc
	1V5fCSfiyFgcMcE30PWAXGx36YbBOAl/rmGs56ThzI92ZuDML5thFT4tQNqlNxqs
	/VWgV2SgI0lEXOy7Ew2ciVQqdgE3Gt+Qse4pvm2njdXCqftgyXzd2b5TveScEu68
	1xoeD2lejSBj3GvLJB4h+4qT2FVSIUJugZuspFEbnQn7kKF8wm746RaBmW8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792759838; x=1792846238; bh=Sgg6MhCG2VmTObaFjRzmivYppZQM
	/zBk0Qx9G2oC+lI=; b=MAPPWhzAf+guxJkNIrdfJMDucxgPAEpQoaLypbHc8MO6
	QztB8Mdjze6jbcal2+kDM708Tob9kEk+MbOZxYJk7HliaXMHT6VwcfuoqNHbogSg
	GGBtznj907+Eq0wtmdTgGlCXvavI9nC4zoqjeRxMg+ivFD2n3fkQrNReiVZ8IJGq
	2x5Y7Ydlow2i5xWR2ERAzYKkgwU8rcWnHfXSLRdtExvNGY1Eqjv3ijDSp3pxxz6g
	ARcN5vXy0KmDQzCqQlzDn/rIRXU7JQBQnH2AbcOO5kDs0fQkIvVFJbDsOCQ2fjb9
	SRo+T198afa4aGGPsUleZiB4BekSE6puUGoDak0CLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759838; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OVs2yjQWvKvRKePcPmEvNE19lJF2f3DjGAR6YEXEYdCQbg2
	N5owGHdRybx4HoASmvKhxmkzf4nj3eFQUBFJ54wnHHfWY+GRd0YtkWQ3xotAevgA
	aJEmf63x75FihGzzhgKL4s0PT3GXwFBePsIGjWv6CwhL4ElCWkVD42KiWsXhFE9h
	1O4Z7TVIhLiDUVkPxDI4THFEB2gd1lc0qmqKjh4yphJoSa8eqebpaiincmBC0D+a
	h847OopcZJHgoe9R9Pa98tzZ6+rIfi3VOmn3Vx8sM/q9gvPoj1wyf99xfqVOhdtL
	OpQzdm1NmhjMnpSXYqPs1Q3ISGpLo84mTZKnzpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:FZYVGf4NSG3v5rRVJGP8lHLJfGj+LXDnPTrzCklAXuU=:BI6Ux1P/tDiXO22RpcURq1UYIBuoHKj0BRC9DnzuWXA=;
X-ME-Sender: <xms:Hljbak4-U_KlpDgTygq6KXVjRLmPjF9r0jZm04bIzvRNngZ2wrsGuA>
    <xme:Hljbas2v87HQ1CgZn1bqEADqhzRJZSjrDKiJa-9Sxuk38-aHwd5dmiX7g6Vr51wSo
    hN2n7oTW3Lni5Dn4sMLpfm0QEsoTFrLNpyDAW8n3yGp8tDO17I3qCQ>
X-ME-Received: <xmr:HljbapFz0gegOGldxQr6iTNJndTXO1vKbIjd_s1T9nc9nYVz96J9gbOTw8C4DOaX3vgS9g>
X-ME-Proxy-Cause: dmFkZTGWdaFLZuwCheoLGkB/VvTS5OJazLwFlnbsdeDPyHydtOT3v2QjJqEG6n2ZMhK0Qz
    k4p63HXYW2Bqc1F5lHRmfdxoXxsrZKOAPwKlUiLX6plqU6dcmDTKaaJfgRuDjCLlD11p/K
    xPchS1hNLtGWS/Ka10bpkuHiwiC/3UR7F+/9c4tdNcIhD5qt45tsmQqP5EmTyGyKbC6CE7
    rj3QUDoF2HLmkxfL3psEUlpQWT6kV/pwhFIJV6gX3o1s10mUQZl+8HYfSlIlbxdyedeAU6
    YmbZ5FYF22DFTehDC8lELAFCQbFbdGkW6Ziyz5VnL1R6qpShQkfiZ+A7BJ8jitneqwC7SE
    m4e3eHqqg6yG/6VLKTYyz1dhi7wIJKNsd1cHZ/hbVQUz1/cdeHNMTNPKRYyxjXIYvj30sL
    CGUG/wwAgXAfXR6S4V2eLY3CifOOTFuECJAX1XU4ftoRROTby9kzCi/070ZV9SRZPD8D7C
    3VRJTjkXCXO/AkA4d/ZIbzd2giF5bQXwXyhm8PyfVroHr4rsGVNVeQtaG0d89etGvgWlsn
    ikadUwbl/2EvffqfaheqxLosTvQde4vt0koVlTWcHV/TpfDzegiPx8OSo/z2ddMNVyzGEi
    QFqexfFdrpCgUxYkrQMlvs0YDVJ6gPAkdVjfGS33l++sKjiinW5+UDSjjKCA
X-ME-Proxy: <xmx:HljbauT7kBiKjbjWVimjj0M0-bKkpdpbRgyZ2Woz8ys0CTWdG0Rp_g>
    <xmx:HljbaoANX0fbF1QEpkW_zMO_3EUQg5hfjZ_LAP_91PXbGDM7qc4Llw>
    <xmx:Hljbam2sRP2yu0GBvTiawTXcgdQxLnkFDmu3rID0-Y6qS7KIlKtwzQ>
    <xmx:HljbauVhohJ4t1IGAtSqXcLsxFXpGELybuc6eYbEnAuM8-FplHkiog>
    <xmx:HljbalYMDGSV5A7pzjVcddK0MhciLAHSSRupvQng-G2md2e9EAW2t_82>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 172667b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] rerere: remove global state
Date: Fri, 23 Oct 2026 14:50:17 +0200
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBG4Vcps3YgHUoWvoq4qPGPHYUmZOKN0
 ndvqpzVtzkLGYrC6NgtVPBS0zQ39IeOwjTON7Bem0mc+N6JcH4YF+zxO3Gd0JSTaU3ly9F7cWM
 IcQCoLXJB1M9vfzr/bc/LHaHuT1rXDYZaMC2AAAAA
X-Change-ID: 20261022-pks-rerere-wo-the-repository-f6620accf4ee
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

I got sucked down a rabbit hole once again while reviewing
tb/rerere-wait-for-merge-rr-lock. I originally wanted to refactor the
rerere subsystem to use subcommands, and I did. But while doing those
refactorings I also started getting rid of global state, and that has
expanded in scope more than I was originally expecting.

So I split out this refactoring into its separate patch series, which is
this one here. On the one hand it gets rid of `the_repository`. On the
other hand it also refactors "rerere.c" to not track state via global
variables anymore so that it can be used multiple times for different
repositories.

This series is based on 7e34d8174d (The 8th batch, 2026-10-22) with
tb/rerere-wait-for-merge-rr-lock at 5f6b6aa3ab (rerere: add "gc
--skip-locked" for auto maintenance, 2026-10-13) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      rerere: stop using `the_repository` in `rerere_path()`
      rerere: stop using `the_repository` in internal helpers
      rerere: remove redundant calls to `repo_config()`
      rerere: cache result of `is_rerere_enabled()`
      rerere: stop using `the_repository`
      rerere: bundle global state into a struct
      rerere: get rid of global rerere cache state

 builtin/rerere.c |  21 ++--
 hex.c            |   4 +-
 hex.h            |   3 +
 repository.c     |   1 +
 repository.h     |   6 ++
 rerere.c         | 309 ++++++++++++++++++++++++++++++-------------------------
 rerere.h         |  23 ++++-
 7 files changed, 216 insertions(+), 151 deletions(-)


---
base-commit: 13ef06d9d38088a2d97f612dca15fcd472f7b8ed
change-id: 20261022-pks-rerere-wo-the-repository-f6620accf4ee

