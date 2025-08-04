Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4623F41F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295445; cv=none; b=o+ESpKwUDOzYMM3ub/+KbK29twlAmQ6BT84VoK/eYXvQUxnecjNVEZgXBtVRbtfpdTiyX+GK/wthjYfQo+PjXfGfY24Cs6AFDRWfHqdsAAI64DlBgDzKBrZrwDhYgTU4Cm7XiTTW+joWwfnEZqjxRY1+1A3F6rWiDGl3L63OUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295445; c=relaxed/simple;
	bh=bUWN/2rTKYBNO8WAMSgmskRpDw+GhUg12mJbqw+ijug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rYY0e48Qpa8ENoAixKaTA1RTcj/iEIy+jyRku3wZkWI34hIBESUdIfEaim90pPeE1RvQQYBgZCt6JDyqZgBtgDR4X7JgNUzhWQJSZhs/unFEEV4PUNEJInUAnMZpi938Sg9g9QrzAgW3f65S8SX2LxOqVcCX1p7BlI7psYmmE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFPa1+wq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOaAY6Fn; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFPa1+wq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOaAY6Fn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97C3A7A00C1
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754295442; x=1754381842; bh=KR6EPHi+Fx
	D1HkIXpRjTyZ8PIaLaTTyAx8B0zizWqVk=; b=EFPa1+wqjtMCeTEcFO8ZK5plda
	mOGvUMKW6TN4tX33j8kzYkAQMxA96kLYYTbO5f7pIY5HhEeoZDvOgnStIm0lWs5N
	SSO+1w3TTHy6p4Wzhw6Pijg6R+xuoDRld2nbDMNG4ClZwoTL07+wSMJfhizHxeUc
	Rt1qZ3d1XfPMjlalWxJaJPT5ALA6GsOLqL91aP88J7fGUUo5J0wkEOuIawoFIB7h
	VBy4HHTQ7G/XR71CAQK27sxZX/vt1DU4iLImUJU5Bf0cdmjPD5hmLAqOA7qJGtaG
	c/mfwMzqYrciIedOUY2tmjI1cC0Ua2ZrR83u9xJCKksOb9G5UzlhTgtOc55A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754295442; x=1754381842; bh=KR6EPHi+FxD1HkIXpRjTyZ8PIaLa
	TTyAx8B0zizWqVk=; b=iOaAY6FncUnS69DsSLrzfuvVI/0Rf3DpmRKYx2Tpz2Ye
	mWU82XyWKdHyBuHLpqKUT57CQxtbLy09gtg5dE5V3evi7+5yriY71U7+rIiDDPMC
	LuDpVu4yB7txNWuuCWtc9xO6HWuOrEC839/jDZPIFIMaBpWRkIs8gVzPShQUCiXe
	RApdHX5y5J0HcdozM0EjH5dgbQpCc0xE2Yctg/+NQA65/J/txli3L99uPIakDYud
	V8EAfpSq/2j1GKyzBM+Zs/vn+FnOpIgSFle271OzGYT7tc51qUEzrCL3ppTHhflX
	Nez26rw2+SYLxxL8Of98/oROXzW5+k48P/XrVWuDUA==
X-ME-Sender: <xms:kmyQaNBEmkbOaIE3FVveCTLAFtjMTC8sf3SGoxwQ-yJSEtvg78IiCQ>
    <xme:kmyQaNiXZPU1atQj3t6jYGRnqMu7e-2iQfw0LhEM8zfVo-yaQG6q54270MjTfd6RK
    KlbAneFlD8hhIJn1w>
X-ME-Received: <xmr:kmyQaB841o8iFU9mEmvzUpLObNkWXLcTocoihz-Y5nTyvljy3qEAcFvidh7kGNv26uCCDjQNBxeBrHzDpvm4Xlcr-mugX9iMGt9yYM9JPOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:kmyQaJ-0WvT6JmoFJuvqCBAq0EsxKZoVhG7YmVYgdXwiTQ_zG2_1KA>
    <xmx:kmyQaKCuJK_G9uxCAPPkvH-YBPJtLdMeGBbnMbaWul7MjGSobGfz_A>
    <xmx:kmyQaJwjAVIaw4QL6Weza6PCi7zPNcWWqO05zXowWo1QVPiDBBm1Cw>
    <xmx:kmyQaPTw3eQUiUBAkPWvgr_wKaUh2TOGAEdrp-Sg0niCrEzBUjEgaw>
    <xmx:kmyQaE4_qAo-2P5gltgfRHhHAjh3qiYmo_WVFuwPXWILhlNih61JtgFu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37f8b6e2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] commit-graph: remove reliance on global state
Date: Mon, 04 Aug 2025 10:17:16 +0200
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxskGgC/x3NTQrCQAxA4auUrA10RqXiVcTFNI2dIG2GZPCH0
 rs7uPw2723gbMIO124D45e46NoQDh1QTuvMKFMzxD6e+yEMOJ6wPB1Jl0UqzpZKxrdizYzGRV2
 q2hfDRJESjXThI7RWMX7I5/+53ff9B213XX13AAAA
X-Change-ID: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series is another step on our long road towards not having
global state. In addition to that, as commit-graphs are part of the
object database layer, this is also another step towards pluggable
object databases.

Thanks!

Patrick

---
Patrick Steinhardt (9):
      trace2: introduce function to trace unsigned integers
      commit-graph: stop using signed integers to count bloom filters
      commit-graph: fix type for some write options
      commit-graph: fix sign comparison warnings
      commit-graph: stop using `the_hash_algo` via macros
      commit-graph: store the hash algorithm instead of its length
      commit-graph: stop using `the_hash_algo`
      commit-graph: stop using `the_repository`
      commit-graph: stop passing in redundant repository

 builtin/commit-graph.c       |  13 +-
 builtin/commit.c             |   2 +-
 builtin/merge.c              |   2 +-
 commit-graph.c               | 366 +++++++++++++++++++++----------------------
 commit-graph.h               |  24 +--
 oss-fuzz/fuzz-commit-graph.c |   4 +-
 t/helper/test-read-graph.c   |   2 +-
 trace2.c                     |  14 ++
 trace2.h                     |   9 ++
 9 files changed, 226 insertions(+), 210 deletions(-)


---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3

