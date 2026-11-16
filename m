Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834476;
	b=qtWnJb+SjqgGeE4QA3GxSYc18zkXTltZAi18zf5fKNK9eHSdhpPsO70pwkDHD83BVi4h
	 IK1lf5tPx6XxOZu2lrlgvXuDJ/Zvjwg9PEPqGIn0o5/8gaePgsfNGO3LWRAXRoA6iuQXA
	 OiPWp7rENVp7IJbg0S6qgZ6blZGRIYki3grewoA8qidL9hzKEsK84N7Ft9y31j53+3FRt
	 GKMJHHnIFpL4aVCsT915k/CraJF34AWohgPmqDz+ljdcNdvuLvLMGh17147q69TIh/ObS
	 FDKM9wx4EH9Zb6C4B+XmMJDbAW1V8P++QCDemNur4eWXENNl64FvrKQDAb6bh0UCKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834476;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=FsoiWjaADmfzAKQZmYU2gs3LcIdo5ieMXuKd6odq/+0=;
	b=OCvTN9jB5Jh87+kHOSehSbzx4tjkXkZO9m1CpdaRwKL56fvtGjtvU+PzeRXi5oqE7nxN
	 jzHnjo1y0KkWeq0Mjf4wqsKJB/u8lyXx2/eagzJiOyHr7zBBb+PuelPXKoEO8TXmLISSy
	 Q2FqFKtdFYMv8q8+tyHhBBiDtNfAi4OBhvmbnYtipmO1Xdla+P6XRsRzl5TD6zW9K/gmi
	 kGt5d94BhWN/M5cARsFkhL1CSMylItqjabUGkXwGrSO6x9Ntqz2mN/SHCUFr56Na6aGhP
	 axrb8HFdMhxyiaUbpJQPtuMHHANl70AW92+qojomG9R7xFTs2b4JbUROOz1egfkUz7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=V1qfZVpD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2gmsMS+;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E578606A890
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E578606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=V1qfZVpD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2gmsMS+
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 54B76EC004E
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 08:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1794834475; x=1794920875; bh=FsoiWjaADm
	fzAKQZmYU2gs3LcIdo5ieMXuKd6odq/+0=; b=V1qfZVpDRFGI5m0aiD3qd9mxyb
	mUq5Nw9NSzzIwH/GYOKMoeTKZ5UP/Iydjin5w2aEigytGOq4QZ8S4XzGfe8bWVO3
	eQ4WQCACyvLi4E2oXZsXH6SsVUBgogYklUQo1nGeW2QG0ZuxWKbn23ZPwDYqDxrd
	iXxUiwJU1cBu9mogi/mCJxfkT6kQhJsYQwjRRGO1wm5uesHsb6il3YhrRH+MWxZU
	dcu7zo2WhEdQxq+lk/NhHjjBeyakflneat3FjpSjJ/skqf2kOXKCZgJyXITUzylu
	MmbAYgvEEetmvLba4Vurmvu/2laKQVV/YJx3k9ZgM+oD/4fke4pl5Q1+WFUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794834475; x=1794920875; bh=FsoiWjaADmfzAKQZmYU2gs3LcIdo
	5ieMXuKd6odq/+0=; b=s2gmsMS+G2w3GTGTdpf7p2k2BWfwkp11wzT8i76PXtCo
	gkleIDvF0v3BTU4s1EiWv99mBzFHdq3ATSrbrCy+O7NKfIYNP1plePGnEjnZl2aB
	dLpdFX73GIsmYXlI7iTtGlg4MGxIBn9L3wMy0ovAFemHYcndcG2qUDjc9PLneaO6
	9KCpZyOJR4UMi2FxX91F/L14t3oZskdkoEYx5b7DsexZbQxbJMJrnAW9SlhVAyuO
	+TNK0aS9sdhWzJzQr7VHXoHgWGL0fiCvUkIGSHM4DrW7Bdfdvge1LMnziC2dG713
	tpvOYD4RZkEDiI2WrpdVkXwwtTTV2Jht4mhZhA0g1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834475; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TXYQRmaorb2SVyFzl8LYH/ngagf6ktWh4NMjkQQEAHb4/ho
	ubSdAT2laKZAZNUHQoEXoq9I1CQBb/4hzbr8tXNVcRKIhbnTR8YghQMHt9Bc+0wa
	3i73YQdiygGCZPZqTpoeVIl9X2X4UZGfcb3/30cNw1depyUJvmqN367MGDFuizLH
	uKxxeJ9gfkNzesxV0ks9oFMaRLs7J6Lov3h7przJ3nbNnq7/F6Y7sDxLSw86Ej0p
	KKiix5+NxnLn1IU7ohUpUcZUhY8NaAOpFZfNYSc4D2W4C4wzNVJGxu/dtp7CHnv3
	+e2OuK7TrYqDVbATKqGVBMoN26P6IQgul4o3oZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:AlfF/0VbkdcKTM8UKxDiR8jJA5y5plnZXYzaFHocFKc=:NKKj37ja+ijSwYh0yThHhAV+nz8eGdGt+FbPAFlYHAQ=;
X-ME-Sender: <xms:KwD7ajhx023K6eZyaTt7WZVTuHJXM6eq1tJydSu9cBc6ZMHvcPrGUw>
    <xme:KwD7am-Z_1D0Y3ENKkQ9CWVA8sLdNzoNQ74AomNf8AQ4n9Mfq18lDyEsPkr_mP9jP
    S4MDRlqmIQYGJZgj4wCgBD3ylWl9iJx1Wbpa6QJSHaiTDRB1YvpjC4>
X-ME-Received: <xmr:KwD7aot5JFEaO1TG-VFx3t4y_s8hEF_TQSPus9PBuR4qQBTFQcCN3Xg4sxHDYsEoh1pPJpM>
X-ME-Proxy-Cause: dmFkZTGOMkV3rGjcK4M1quuJE+4/nblb/KBRgZEvuIJQDAPJuNAG5zClA3YO/x/iE7nr5a
    SBuvq89tuXKr/HYM87QE/X2f/xp7D5iihS4DfbXpG1NDbSFEFfH4UtATf16/JP4a8pmTDp
    9OuzGd+yG1d3BSRwZrA1WuOWIyLWku5gj4c3/nu+XVHcroapFJcY6lo31IMydeZPlzTcue
    C8xKhIeHDdgNdvRzdFicSmZaPRr36gLoACXAEkR6CHhSymTEr2MdOTR4QHJVzb7soGh0VG
    +kVh8quJJI8koZ6I/OEhdkLRUIrhynTKpdatV2mc1b1qmVF8H6Ukz/qqnBnj3l3Ees3WJP
    nwvswc3YyyR8bjhJN3eXokpv5OfDU2lcs+dDrm4EOE8SFUFa1yEPjqMFJyFa5VLXPVEQFR
    1tSs9dtN/vH4sVBrkuUPkSBkQoB7wB2WnOP5JV9oH83rleJR0NzTdTUNB1RIqfG29pSoW1
    Casd7WCq/DsNDyuFXcK0PSkHvgPPqNc2y8Q7dyBBFhHgfxdPXNEJUCx5TDl0ZWNhnNJkax
    LvmYw7eufm/vezpqQvpY8EEOKqsKZq9K2fY5tgsnHUyqxuPZ3P5JkY/xeALVIHY1K0leHf
    QVoBi5rfqb5Q3F/e2bdzYB3Pfld3wJyImVE0whK/HI3T38Nc4eYsk2REaMLA
X-ME-Proxy: <xmx:KwD7alYjVFCktJRnsrTxaczG_66a9r8GnNYpWGsDeLCoVDL0wA_q9w>
    <xmx:KwD7agpF_5NVeiK4SHYupnCch31Kuj-hELU4SS6WMS3meAr-fjjaog>
    <xmx:KwD7ai9Omm7s6dbAt9c9umJ8-r1RrWOCoEWAv_sXngVX5sRAtpz-lQ>
    <xmx:KwD7an-NRJ5qBvGkmtD3tZIHNLInCtLVkvN7qdB_26tM5Zo5-pb19A>
    <xmx:KwD7akj0j7K_jPOHTzolsM9S8XEW_zcPh4q6oUWxFYh3xqfW1TXrPulT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:07:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 444468fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:07:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] Introduce pluggable commit graphs
Date: Mon, 16 Nov 2026 14:07:36 +0100
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNywqDMBBA0V+RWXcgkaLYXyld5DHG8ZWQ0VIQ/
 71pXZ7NvQcIZSaBR3VApjcLx7VA3ypwg1kDIftiqFXdaK0Vpkkweotp3kMwdiZ0cVl4w5BNGgS
 p865r2nuvDEGppEw9f/6H5+uy7HYkt/2ycJ5fP4DxmoMAAAA=
X-Change-ID: 20261110-pks-odb-pluggable-commit-graphs-e9dc9674f0ae
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series introduces pluggable commit graphs such that an object
database backend is in full control over where exactly the commit graph
is being read from or written to.

An alternative form of this would have been to abstract the overall
functionality of a commit graph and instead expose its functionality.
But that would have been a much larger undertaking, so for now I decided
to go the easier step and retain the data structure itself. But that
does not preclude a subsequent step eventually to abstract the data
structure even further if we ever wanted to.

Meanwhile, with this change all logic to derive storage paths for commit
graphs moves into the "files" backend.

This series is built on fbd2d1e765d (The 18th batch, 2026-11-09) with
ps/commit-graph-write-refactor at a9993c1000d (commit-graph: modernize
function names, 2026-11-04) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (12):
      commit-graph: simplify linking commit graph chains
      commit-graph: simplify reading a single commit graph
      commit-graph: expose function to validate a commit graph chain
      commit-graph: decide mergeable and chainable layers by depth
      commit-graph: introduce common exit for `write_commit_graph_file()`
      commit-graph: derive layer infos from the passed-in chain
      commit-graph: split out check whether writing commit graphs is allowed
      commit-graph: split out logic to write a new commit graph layer
      commit-graph: mark incomplete commit graph chains
      odb/source: make commit graphs pluggable
      odb/source-files: move logic to derive commit graph paths
      odb/source-files: internalize logic to derive commit graph paths

 builtin/commit-graph.c     |  87 ++++---
 builtin/fetch.c            |   4 +-
 builtin/gc.c               |   3 +-
 commit-graph.c             | 585 +++++++--------------------------------------
 commit-graph.h             |  74 +++---
 odb.c                      |   6 +
 odb.h                      |  10 +
 odb/source-files.c         | 478 ++++++++++++++++++++++++++++++++++++
 odb/source-files.h         |  12 +
 odb/source.h               |  52 ++++
 t/helper/test-read-graph.c |   3 +-
 11 files changed, 740 insertions(+), 574 deletions(-)


---
base-commit: 0c2ef2cc2023eab2fe8bc54d542fe4f93314f186
change-id: 20261110-pks-odb-pluggable-commit-graphs-e9dc9674f0ae

