Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EC34F48B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840250; cv=none; b=VP8M3k+zfWsJ4y4chvlkFYgWh26ZvMGNbZ1n778yIhmUS+cBW439SdtFgxHpaEV4JprkqRO65OPT+VeI3JrTsM45eFPgvro/98hPfMEUqHXHPIDsuuNQwAu/yJBv6bNoVfNwsZC5FXgRJTg0eBGyHOU6SMrzbWlE0LTu7mm82wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840250; c=relaxed/simple;
	bh=nECM4Uh7WU8HzWhiXe0RglkP5xogLMILjeBZ4bz1PLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AvZ167NhqIMax7JgchJCf7qICDqjOASXRiRKj8mhbHVe4c79prcoavF9qTZhHUZookh+QPEFfI/BUYgrHBhBf+oNo2At2jdNHm6th1t+JwHzchpegLV7SPimNGNqAz+icmdDs8CCXKADZophiRA0nSceTg3ZMZTEa1n8DiYYe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y5tSRlDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KFMsg6WX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y5tSRlDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KFMsg6WX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 150B914001B8;
	Mon, 23 Feb 2026 04:50:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 04:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1771840248; x=1771926648; bh=g5htN14CjO
	zvLLT2H0u/yqycuGnCC4XfDgU9+zP4j9A=; b=Y5tSRlDzfKesaFYWP6gVys666q
	uQohwlhGaOdiKYAKohbUqrPNPnu1wt4+oqqFNDV9W5fRgqFH+4peI/YTvyDCyn46
	VbCvj47T5/encrC9CXYwDtqt6QFASr0db9JDysvMhgxPIFHKs3Qk52NvbSfTyoET
	H1nQKRlcf3hpQML4qJE3WyBMictscHbvYGktBFxnyvVpcRyzNrIghYrYahGk17EM
	P9JurXzPoUwrv4ZccJEJ0NkiWsiL5gPD73Zna5zO3LIwYrjiWxCfiUXfcv8YjgFi
	O1sjOo1/GK9yrBYiDhwitFuuTpVnvQHqXRHYfxh9VhJWkYnVWgR/jOWaanXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771840248; x=1771926648; bh=g5htN14CjOzvLLT2H0u/yqycuGnC
	C4XfDgU9+zP4j9A=; b=KFMsg6WXBm2N/OgEc2IA/LtTSCz1eFD9g/A82WFlDXh1
	HPETG85SfirWXHSsmNPdWi1hFV0F3nnIbsyGiHaNMWgGMfDgKLbYas3STYEhdZJe
	rLeEuE7K8potissVXLc2nsdcH1kBk1L0r0YXOid6brpddMzw5t3l3dRytF6z/nbP
	kFca2TMYEFBHsj4wd77oldVl39QhM9erpUMHunWAgx54kFhR3Elg9GUjqoXupVsz
	Juur3nREvgHulqnzCjF1ZkYce3H3scucQyBUcRoj+WHuVDREWZkW5dxap7vR+WW6
	eo26GE0Il+E/S2FZDUnn9cBvE6WGX9QKSpmHjDIH5w==
X-ME-Sender: <xms:9yKcaR5maFtz0FAzwazS9djtG9OZEtcjC47Zpw5FSfoM8q4_lU99zw>
    <xme:9yKcaV4vCUJyLLZSuoRjhqRfG5xJ_GLMYBdnZ_DA5ZIgsuR02IIM6iOhzFHJTnA99
    I2GGdzwTVp2W386RwMylXDxjsIncV95qyCAUsi55x63a-lmWeBlW9E>
X-ME-Received: <xmr:9yKcadesCfuq5Igp2oKjnyO_cirAaw9ldO3COe7hEYO9fBEYAb42a32ahku0gxvnT7F-_dK2kAXiAjIzfjfCsc2M-hv8zag9lwgGZpX31A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9yKcaZDPuzVMfm91Ql7mFMmR9OeoMD7sb1y6KWWWN2itEtDPWTomwQ>
    <xmx:9yKcaQ_2c4MDZF8pgnRuxnFo0NpsFG5Lo9TmBJeUr0_-EF39RgFM_A>
    <xmx:9yKcaUKM203ITwIs8uisYi4OIvEttkSmVTZS8LIigT3NlnO0z00WqQ>
    <xmx:9yKcaZgXQXf5EOfWg4Jza34LNU-4InWTsKk6Sx9Q1_HyehwZrbboSQ>
    <xmx:-CKcae_JRAvw5SVyOgG8wEjq8XGvn8sknCNnUTJX3dJcWO54xNx31ATX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:50:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa814cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:50:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] pack-check: fix verification of large objects
Date: Mon, 23 Feb 2026 10:50:39 +0100
Message-Id: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAinGkC/x2MQQqAMAzAvjJ6trBNkOFXxEOZnRZBxwoiiH+3e
 EwgeUC5CSuM7oHGl6ich0HoHOSNjpVRFmOIPg4+xh7rrlg071jkRqJEIZH5nMCS2tj0v5vm9/0
 A0aOlEl4AAAA=
X-Change-ID: 20260223-pks-fsck-fix-aa8a18a223c8
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series addresses the bug reported by brian in [1].
Thanks!

Patrick

[1]: <20260222183710.2963424-1-sandals@crustytoothpaste.net>

---
Patrick Steinhardt (4):
      t/helper: improve "genrandom" test helper
      object-file: adapt `stream_object_signature()` to take a stream
      packfile: expose function to read object stream for an offset
      pack-check: fix verification of large objects

 object-file.c                         | 10 +++-------
 object-file.h                         |  4 +++-
 object.c                              | 15 ++++++++++++---
 pack-check.c                          | 12 +++++++++---
 packfile.c                            | 36 +++++++++++++++++++----------------
 packfile.h                            |  4 ++++
 t/helper/test-genrandom.c             |  5 ++++-
 t/t1006-cat-file.sh                   |  2 +-
 t/t1050-large.sh                      |  6 +++---
 t/t1450-fsck.sh                       | 17 ++++++++++++++++-
 t/t5301-sliding-window.sh             |  2 +-
 t/t5310-pack-bitmaps.sh               |  2 +-
 t/t5710-promisor-remote-capability.sh |  4 ++--
 t/t7700-repack.sh                     |  6 +++---
 14 files changed, 82 insertions(+), 43 deletions(-)


---
base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
change-id: 20260223-pks-fsck-fix-aa8a18a223c8

