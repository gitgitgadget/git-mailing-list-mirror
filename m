Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978054;
	b=jSLUX6/GpHdXh9YwNDOl/1xG2TbKXNM2toZDol+SrHRMmJfd6p0HxaeKbzYdf7uf7cV2
	 8E7ZaM0oaS6lzafIhMLys2kQDEbr328ksnDnguI4prRyRuHg9PfTzhGW3UKHDoeDWxOLK
	 E+QakrudlXYfngLNJ1O8p5PbPNLtRCuhaIiFkS9FIuG7VVXKJsE7q5t9ikiLEkDLHD6ab
	 +rLNB1dDGT7FaNW7GyDo1S0ZXEXvJ9k+1JYHCngqfvuKOvCIKkm05IqknPPnQJVx/lToj
	 SMWfi2FdnC813vk7g6g6XxSKtaIJH5kMeU7mew05/QfiPKyozrFg+ETg/EFdJ8dUhXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978054;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=iIc5RzlGsWlfvC7eWS4jCRea0hz3YN+jqI+fXhmdqbU=;
	b=GosdNju6GsbOBw9+ExMnhhlw7wyMhXAiKHpDNsLmWDF/Z7fxbgAOEMKmRlQCH6dpKSGW
	 pgmRe+nEtHeBCg16U28zT04qHeJT40UEqchq2t3KtuK/pKShmODTGKGixEcNOgJhTACtR
	 KgFtfPFCDoLn82CGXqiHgvmwXZv2ulUV62thcLOxq0lHHt+qLXHpDPEWPbev9wYD54aNc
	 zurnicdmWHmJ+Ly3a0kLlleSAzOn80sHSwc/zug07YUsUE/qEJnJKIdm9XhdVHOfV7/aT
	 YAKscsQxf2mRFqAY05lVDP3DAKnCypOzUPw4uzZ1RKOtOHlfMDdqGzlvG8ryE+Fc0/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NxoP5jKX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="ssU/FewC";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7658606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7658606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NxoP5jKX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ssU/FewC
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E36481D000DB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 10:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978052;
	 x=1794064452; bh=iIc5RzlGsWlfvC7eWS4jCRea0hz3YN+jqI+fXhmdqbU=; b=
	NxoP5jKXzFxdOZ2EtFmGRYNLbgBiwva4oeiABl63F2YDYbjX04tSVZ+E4dxgGpBj
	570SkU057htnuBLijVKRZHkeObMY1wFr05d4X3KwVWxanec0fGXmn4o85fOKh1qw
	BzrAQPcquc+3u5vKmiGPcGF7k8D7/nqFYeM89gVybQIXDaBwczCkHoQegqbB+MDi
	/btJoYPFXuJrOBtCFGr+De1JVxMZFr7DoRrQEz6iRMY1zkJ8O+jJFbAunalGNuIA
	/s2teUPFp3ie0LyRKEFBRmIrFdbhk7zGfEact7aGwym+NV+Ai1QQHpm6Z+Hsjc4+
	VCRmDuqR8zAC78G31y7tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978052; x=
	1794064452; bh=iIc5RzlGsWlfvC7eWS4jCRea0hz3YN+jqI+fXhmdqbU=; b=s
	sU/FewCVwbQH05pMjoCqLxYitBsg1oen4sakyZno/ISNVFMecnk3COMFdfYM9Oet
	06+wxEUMKhqfVBo4SMLDVrSDRRWXlJz9Ssg+8yg8+/zr5bq0o4PkWw58kFqhMW0f
	KtYbyZWMxeB9b1U7iA7bCxFZ29VluKLj1VOQFVBs3SCDglifbzWz8NUqjcFFlkre
	LpKVxCR0LUVQSjD4FJJdULX+UC8m8/bdxBAOQqvQYg9ykeIX6fwbh8lCaghPsR+R
	3IdjDCUPp0onxCbkWoL9TICHsWjPBktq8bUnlJ5G/ou5WmQF7Sxm/TLwT2Z+geCE
	0yjawFRCtMw4jbsCInESA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978052; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nartcL3HMm+XvdYjKYiqYnTfM/3o67R3uA4sXZuXq5VM+B7
	1u9fOe7+MyH6ftzY6DU6elrAYdWgKiILoFP/PvMMI+1dUx4rFPabq/ttgHsKDeDA
	2e6DTeB07Ne+fBu+d/7PWvMPiFo8QxyfkRxAD64V6bMKjOnOOq2etZJ+44UPlWwG
	syocVapL1L9t/2S04GJb34tvxX9w7AqgdZ6nyyOr2NbhZISFadYH/MOBBc8WHeDa
	kBRZNqNqYoaND0hxGL/N9YOE0q++6pfJEe6aNUW3rGnbsyMq/PyAyO6sEY4MZWFk
	WJK6IKNxBskzs4p2ViXNlXgmpIHOZyq+7NsxigQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:njCwx556Pgw7WRPRjlB2hrAC7YyLw0mtPufP1A/zUtI=:RUylHbGHW9T7T55BAdQzo/bjo5a56l5oNqZkU9/ipBI=;
X-ME-Sender: <xms:xO7takGNEfB4-mDFzfDhRu26nuLE0gXvGzqGVHIDwD4ZJAkxkopnXA>
    <xme:xO7tan6YNwAh6xmPYdtFF6oB8k_Ybt7X6aq0Z8kOPVC4m3dZorz4j5M1LkafP3OEF
    xzOxyb0cmnSMVFhllQOvYtA_h-rTJ2puRbRWFWkJALGEOEpol_Tsw>
X-ME-Received: <xmr:xO7taqsv9bvgf68LHTcTJSKd__-KqsMAtP_sv4f5ZsGYry02KcSavhvKWJS72HDtESCQlg>
X-ME-Proxy-Cause: dmFkZTEjez4CL3ZkFbKp0HHnpvrHfhmitOWwDBNPlTN6TYHKW7AeUTpiR9BNybUn7zm1cZ
    z4nNLevspyW9USJJewzYKKmsoEqDlo/XM7FjdocgQkRJsF+Zw1NmXi9DHVLVv877aIfMmx
    E6O+SwImixjNZihbw7yG3cT+WY63GdFto2vhOXoNzbGH3qOJPQarM/jUpEPa53J3Js5U3V
    bMDNth61wW09IItGN48gVqavyxEVDkEtMnTfXd8ZeaAVLpMbHBaRND+B0/W3JTqgNUMezZ
    dxtRE14f7+ZSTyh28upzAh+E6DB1zib4Ceqmn1vKHCv1cCg76Aweumz7fE89DMYR9AwTtc
    F5/W+5up5+bLqSXJqf5q7bmV8vkwHc4hoOxw2QOxq4+E805f8DDc8X/NLkeMHO/g0rQo1p
    rarrw+jSJb1kSmwo8m6zEdbr2GdxCI4m1iVPGod0opcigArNIj1GxsPtYpSGJEKmaDdBS2
    61vJeQyjmZ8SLgT98u8gkGCOlGA7Ctlx4UsTfnYhk9Zxoo5PWeUXNM1WUqFSwS/+R9fyBt
    sCsX2uesC51Rq1W0gvh0J0PyE9oyfpbyzJBGzB7afaR6dnhhilwFV0YTPvlh7O6PtMIQLV
    0eSrXAZQ8+IHU37kkWzZdFgq43Y3RVV3OMWbX5IF8jaIJ4qsI/tygX+RM4Ng
X-ME-Proxy: <xmx:xO7tao4jHjnwTJ5V_MPcgGAu2kyLO3TLO6pZIrHpYlSXORkaNuY6tw>
    <xmx:xO7talUFRZ8X43OC6ixDqOGEFEjczloHNQwcVH-3cXSDMA93IxDEDw>
    <xmx:xO7taq-2dPvhSiqYLQ5CE8-jswNY7yfP4oCNR7B3OAYpTS5cLdmoKA>
    <xmx:xO7tahnpUzNSkOY2PVRMLIJ5nO0h0Tct8QpeoDvec-CgtOc7aK4JTA>
    <xmx:xO7tajWBMVJSarCpNXGQYSRnVWPLTDpyYNpXHgRaOvheWr7jgpMCdUbB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3403c30c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/12] builtin/rerere: convert to use subcommands
Date: Fri, 06 Nov 2026 16:13:54 +0100
Message-Id: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNywrCMBBFf6XM2kgeTRtd+R/iok1GG6VpSWpQS
 v/dpIK4EZnZXDj33BkCeosB9sUMHqMNdnApiE0BumvcBYk1KQOnvGKU12S8BeIxHwn3Vg993zg
 TiGDKlExKUQoFqTx6PNvHKj6e3jnhV9RTtmWis2Ea/HNdjixzf0ciI5QYJSqdHqmWhwRubQ95I
 fJvx+6ngycHrY1sG6ZQKf5xLMvyAqtRvpIPAQAA
X-Change-ID: 20261027-pks-rerere-subcommands-318d41553438
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

while reviewing some patch series around git-rerere(1) recently I was a
bit appalled by our custom subcommand parsing that we do here. This
patch series here thus cleans up and modernizes that part a bit so that
git-rerere(1) behaves like every other Git command that happens to have
subcommands.

This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
rerere cache state, 2026-10-23) merged into it.

Changes in v3:
  - Clarify what `RERERE_NOAUTOUPDATE` does.
  - Link to v2: https://patch.msgid.link/20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im

Changes in v2:
  - Document rerere flags.
  - Rename `rerere_record()` to just `rerere()`.
  - Link to v1: https://patch.msgid.link/20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      rerere: rename `repo_rerere()`
      rerere: convert flags into an enum
      builtin/rerere: drop `the_repository`
      builtin/rerere: stop passing flags to subcommands that ignore them
      builtin/rerere: turn "forget" into a proper subcommand
      builtin/rerere: turn "clear" into a proper subcommand
      builtin/rerere: turn "status" into a proper subcommand
      builtin/rerere: turn "remaining" into a proper subcommand
      builtin/rerere: turn "diff" into a proper subcommand
      builtin/rerere: turn "gc" into a proper subcommand
      builtin/rerere: use `OPT_SUBCOMMAND()`
      builtin/rerere: introduce proper usage strings for subcommands

 Documentation/git-rerere.adoc |   8 +-
 apply.c                       |   2 +-
 builtin/am.c                  |   4 +-
 builtin/commit.c              |   2 +-
 builtin/merge.c               |   2 +-
 builtin/rerere.c              | 319 ++++++++++++++++++++++++++++++++----------
 builtin/stash.c               |   2 +-
 rerere.c                      |  12 +-
 rerere.h                      |  40 ++++--
 sequencer.c                   |   4 +-
 t/t4200-rerere.sh             |   5 -
 11 files changed, 294 insertions(+), 106 deletions(-)

Range-diff versus v2:

 1:  8d6b21c1ea2 =  1:  022fe75450a rerere: rename `repo_rerere()`
 2:  3dd2a9cc7e0 !  2:  1cb50bf5937 rerere: convert flags into an enum
    @@ rerere.h: struct rerere_id {
     +	 */
     +	RERERE_AUTOUPDATE = (1 << 0),
     +
    -+	/* Reverse of RERERE_AUTOUPDATE. */
    ++	/*
    ++	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
    ++	 * working tree but don't touch the index.
    ++	 */
     +	RERERE_NOAUTOUPDATE = (1 << 1),
     +
     +	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
 3:  a69e7f43d2b =  3:  d18adf008c9 builtin/rerere: drop `the_repository`
 4:  86654ba3606 =  4:  bc2eea0ba84 builtin/rerere: stop passing flags to subcommands that ignore them
 5:  f532910d986 =  5:  2b45e209b08 builtin/rerere: turn "forget" into a proper subcommand
 6:  6340e1db614 =  6:  8e1a5cf4239 builtin/rerere: turn "clear" into a proper subcommand
 7:  1c623efc48e =  7:  aede0d76e54 builtin/rerere: turn "status" into a proper subcommand
 8:  debe0999ecb =  8:  114e40d5a51 builtin/rerere: turn "remaining" into a proper subcommand
 9:  00bcc60a186 =  9:  7c523f60339 builtin/rerere: turn "diff" into a proper subcommand
10:  9cc14c726eb = 10:  6962d3ae764 builtin/rerere: turn "gc" into a proper subcommand
11:  8c90e572751 = 11:  d9021a91b8e builtin/rerere: use `OPT_SUBCOMMAND()`
12:  11baa9ee058 = 12:  3b59da3d583 builtin/rerere: introduce proper usage strings for subcommands

---
base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
change-id: 20261027-pks-rerere-subcommands-318d41553438

