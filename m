Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890928;
	b=qYw0Y1Fvtfv7tha/tsTcUB/l3PJvPRG8CkxBra1vXcHSI4vbNRnVXaQWUmWkZGrh3XvT
	 gUo7nZ3II5KTLmxDsZl4rw6mi+dNDz8LqbRfc/bZe6eE7JYlosbL+euKoCWXLvtNNOHio
	 g1ZoFL/bP9HyD41Dkbo5G/ZyU230tzXj2rXSA7ioPse42UD3Nqa0HkmjL6L4rIJUOsyVQ
	 UpvtYC8SoF3KITat2i53kU/CO3YlEBJ5o0pNw8IP0lvOh/z++bjNCxN337wcKGqsNFX2A
	 kl9fuxgEM/PLfVI5LQgbXOBZBcYruBTcB4F73OM7mGyDUx039WWLYIgGzv5sU2oHrJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890928;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=F4a0AyV1RZy5Iljcp9Dm1rL8DHQcTT0ZlXPobuOyXjU=;
	b=RiWBT376YJHBT90Ug9hb38B7t6lqpfU7nkYDnGm+igt3yxYV7MzRxFfj+QEJKpVNtIsc
	 IEiERM7QD7xRk3GcQedddlOiFSylwe0tKsekI2/5ydPc30cBkEhRPEDwU2hEmXKflVP+6
	 Q7APECkbPMweHnj8Q8BpB9g08ZTI5H2+k1KMPilEfuaOQXZAsnf5hv20rqGc4VWrtDhLS
	 2urWZERhUgTugL1OBFE309m3UNN9A01s4B8J3XerITxKUQWk1SXjseEq8cJn7WpC/9IMS
	 RgYoTdiUh0Yd9tH9MdDQe40E9zr33i96G766Hj/MK1PPZSXdM2wZMI8zkNWTEQe1/7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="CrP4R0y/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=go7B0fCr;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7E606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D7E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CrP4R0y/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=go7B0fCr
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6219E14000D8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 10:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1793890927; x=1793977327; bh=F4a0AyV1RZ
	y5Iljcp9Dm1rL8DHQcTT0ZlXPobuOyXjU=; b=CrP4R0y/OKyKvDmnr85DABDYAj
	MdSCxsOfsLZKfPj3MydQsdhhBUs9RnK8ZcQb3dO4Mo7++p7WDT0U5/6TVTm4NXZE
	auy6WFRA7w2sbl0GU9BY1bb77q0EecfBV/yOP4W0xqfTy+RNq1n+Hrmf9WHdfsAW
	qYkCM2UTlgtc59eII7sTZBtElRMzjDLCNUquozr1A5KzWSLDQa1OURHw6j7tXIwZ
	HzIJGeTzzQNmfD8bduPVlb6iO4yGn60R7Q1kZhQ61eqZbyY/U1bpt0AbAxN5e2U8
	Otm4s2RsMUZ5YvTAqobdFWKJAGBSX9vgLd+3C6ZYBGkk/NS6VqAY0wl1bd9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1793890927; x=1793977327; bh=F4a0AyV1RZy5Iljcp9Dm1rL8DHQc
	TT0ZlXPobuOyXjU=; b=go7B0fCrTUInE2rMDmbcQWXt3ZURUwPlOLPfMx1O0FAu
	LUoqLMkqZAx2g/AVqIh3KwhoEkBZB3t0sIbv2DGDwGSnKyLyNzf4oGLveC6/FI3Q
	FsB6OqYfTJCE9WX1MJzhu4fc5HXRTfe7cA3FkiOmJIh8fJ8jOXDbBnXcZFu7UR1+
	uXBPTeJKBzw+7nRxsY9hJI4H+4zCipDHLwH/nDTi4CSpiBomQFtij81ApXRGINmz
	cOqZeHZogzytGyURDNMOoG5i6JrHPE6y7ofEQr3ts4DQf2EoVjpxeT/wgNQ0mr+u
	kUXmElHYT1s7c4mFy1oxKv1457WByqJs85f1krjX8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890927; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:imK/FhMatdEczdKimETgcZKwSh56Oro6CMe/Ex/yrcPHVC/
	z+AcN7ZtwaegVlfR4Fnzw5ZEyWvx0Ggew68SJhrdqTLYEJI01mwq0zQBjoJHpkv7
	qubxf80L5i3fppepekKLLEqYQK/yNMOfocJkfkLPwxWktRgn0tIk/39Ot9hHUOAK
	psMV4/fa2m90BucamD48s9dopM4oLhV3QoZ0uqdSe86jchRxlByJqIZLYtoT2dti
	yV+zjNbYoBxKbRs/L3rwtrDDWJA7kahf5jXsOTWKjaXEO2WGaQb+MXmoObAtTAsF
	S7kryS0WcDCclG+boNAD6KcYdj442uGBWZWG4nA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:xwLb2Wb0bxTpGcoAhcRVmguGamqNyKsxmfrJeQRdBkA=:wfDMC6aHtdyLx3TAOqJjMkfMgOz+ETD3yFDLywpMjG4=;
X-ME-Sender: <xms:b5rsarrAxiZXdpwVczBH23NlVqhoSPUR6G7A9UM98XUNZCn2NMS84Q>
    <xme:b5rsask_37FGM1PvTX9OOiNb-_6e-KvEInbG_PcxNASCoqHqfAGyoYQLWH9s8qAxx
    gE59R78zx0HAl9mub3y5BhWlPpT4NzuwtoBKhAL79zBYsii33CljVg>
X-ME-Received: <xmr:b5rsat0py-Zcruw_2flLGernsJYAYBLu4edbD6Gr-9zSNeA1-3EYTQ>
X-ME-Proxy-Cause: dmFkZTEJrXoC1xzKa16Cf9tWyLztelA3JU5vEC5fu8YhmoFT/I2T7Xu4md9P8mi3vdaRSe
    FCgefi1sL8ISY0s+bjG9W9zZ7a+4VE7B23U07CAMCw2yqHvW2JpQeuDQ4u9GauA9+l7Km2
    P7HxcJl2eBpF2VIG5nKoaQ1ANaG3MwVmNurNl9lUCJL6UfSCKiSv/5oOGCkhaInIYfLXHg
    9y7E89tOe1sOg4f4WkJH4ZC1gXmL2Y85XM3zkVhhHCq3zFA9t/4ArGi5jN6aHkC8SuIV0Z
    0srvSjYXU5l6nd7ErWngQ+O5oLluHp8HNYeRFIl21LQf+XO1yk/6FHstxpAgiZ4NNYNsFk
    kgFJK0+9KilzGNmkV/GItmF5l2h3+b4s93EaMQ+WUCjy1cTB9iGHaMuGGklYkqi3/J2sUW
    83H4bYRL03mSAPVsgevw+Yj+xsc1CBirpbSfMFEro8rCaejljPBm25yd8uTptAm/V4/6G/
    UopzyXv+embCGOeZiZBkAS8XpL0CEsLXIJt6r1arUkCEPrdKsiKZO8fO6hbpSd9QKTAuC5
    1CH3w7upmuNZYYC82N6uY2aC36RkzGo3A1aWTIQkiDnqeMBYMFfgzz7YtSQM+hjMKUHpIk
    2ohAJlSHVRnfGHXJ5xd45vOp2JQyTRGFPLIqJshmvPIb2gVCP7l9giU6UXbg
X-ME-Proxy: <xmx:b5rsakDiTnIVI9MEUYEPzFSrGBhwzPr0c9bYsWt5xOLEZ0CKPpMXcg>
    <xmx:b5rsaqzKAD8VhU1QtZRKu3WNPOmHSP-ASKzxXeOtSKsOO4LBUe-e3g>
    <xmx:b5rsainAp0kOys_yum6QIP7XkDpAPDFDoBAjzIAepvICs-GcKkogwQ>
    <xmx:b5rsavGw3NUkfwCFXhcr1izlfrbIMQ4mlLpcrkgmk_gjGh7jSN8uXQ>
    <xmx:b5rsarJBwIr2FhPpZNzEoXQ_0E3y11FfZJdKDkNQ1q_M4A1c0BvpqtA1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f18a0791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] Improvements for storage format handling
Date: Thu, 05 Nov 2026 16:02:01 +0100
Message-Id: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNywrCQAyF4VcpWRvoFNpSX0VcZNpUo8yFZCxC6
 bs76vLjwH92MFZhg3Ozg/ImJilWuFMD853ijVGWaujabnCu7TE/Da0kpTqtSQMVlJA1bRw4FsP
 Rj27op8nTQlArWXmV9+/hcv3bXv7Bc/lm4Tg+MLTd3oMAAAA=
X-Change-ID: 20261105-pks-storage-format-improvements-7b716599bada
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series includes a couple of improvements for how we handle
ref and object storage formats.

Most importantly, this series allows us to run tests with a different
object storage backend via `GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT=`. As
we don't have an alternative backend, I also introduce the ability to
specify a default object (and ref) storage format that carries a payload
so that you can run all tests with "files://objdir", for example. That
surfaces a bunch of tests that assume objects exist in ".git/objects".

Overall it's a surprisingly small number of test failures, only 1105 out
of 35000 tests fail. Fixing those is not part of this patch series, but
we'll start upstreaming fixes once this lands. Such tests will either
have to be adapted to use plumbing commands, or they'll need to be
tagged with a prerequisite. It's going to be a bunch of work, but it's
basically preparing for the introduction of alternative backends
already.

The series is built on top of 0ffa3e35c7c (The 15th batch, 2026-11-04)
with ps/odb-object-storage-extension at 87a55d790ca (builtin/submodule:
propagate "--object-storage-format=", 2026-10-27) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      refs: create leading directories
      odb/files: create leading directories
      setup: allow speciyfing payloads with default storage formats
      builtin/rev-parse: print payload for the ref storage format
      t: allow testing with a non-default object storage foramt

 builtin/rev-parse.c     |  6 +++++-
 odb/source-files.c      |  1 +
 refs/files-backend.c    |  1 +
 refs/reftable-backend.c |  1 +
 setup.c                 | 24 ++++++++++++++++-----
 t/t0001-init.sh         | 57 ++++++++++++++++++++++++++++++++++++++++++++++---
 t/t1423-ref-backend.sh  | 24 +++++++++++++++++++++
 t/t1500-rev-parse.sh    |  9 ++++++++
 t/test-lib.sh           |  4 ++++
 9 files changed, 118 insertions(+), 9 deletions(-)


---
base-commit: df904e7114cda6ca4ebf514115835a2dcd2f2b64
change-id: 20261105-pks-storage-format-improvements-7b716599bada

