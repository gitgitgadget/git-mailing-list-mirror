Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6882361F0
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855874; cv=none; b=lzyri1o2/EqmRx1zZGpoagPApcPcgvwwUqcxPYzf9zSDTELtTe1u9fCOsrY7qRG/2ezzfMQqDiQ0gzsK02NuqO33UZL9EfcQA4MNHhpxmuHWrTByXmZIT9Vac6KZogd1OitTU+jR3peLmPRhE6Sq0iotPWTsynxlYIiGZokrysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855874; c=relaxed/simple;
	bh=aqFHJXMkjlrM8Twj/OTcQSu5Yt/IoRdTlVwzdUtEZes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drGzoUWMiidM93S7OfvYwBEGi3IHOLcyIz431qdKDOodYrgM/y8kA2XyAErg1mF+JvrEGYs+VYuw3JRZph2/oCCHGm1XiKzYga095ygt8Dh4+AK5m0lgTx/SPcBEMP+itygArmbIMFHWkNwjUmC+o7Q5wrZ3Z2b8iGpR9yZjt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OuXXxqsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xko78L2H; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OuXXxqsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xko78L2H"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3661114015B;
	Tue, 14 Jan 2025 06:57:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Jan 2025 06:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855871;
	 x=1736942271; bh=C1W54oH/p25izrks45XyLJln+GrQXmp+BITNVC9/j2c=; b=
	OuXXxqszFWsBtEKJ0sdK94qbB0s9aHDCRgGGX9bcbpOPybykFbKRFSEO3cjo7zUt
	tyPAJy8Tfk24v0KYneG8Ax/JaEItrhNi14t/DcMBR3wbuuKulQaDSxEUkvbbS4as
	69u4Y2dHG8K2txezBfy8DlyNuee6kFGkptgJgzJG7i9FMs1cPjGtBxYmrzyuIZ9t
	9keBK1d10wKPtC57ub6KmNwqjF+FRR2uCUlnj/H3jrla4Af8luNHLSCXtoXh2j5n
	c5qQh+/BSsXZzvg8dIaKBBr7hrHLRBMySo9wEM2Uook2ZxDCFVVIB6NmRH/+V9Wv
	YYV2HyO+dEbaOrz1TsMQkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855871; x=
	1736942271; bh=C1W54oH/p25izrks45XyLJln+GrQXmp+BITNVC9/j2c=; b=x
	ko78L2HaE7hijZUoENAlZsVU5dAyhhYH0NdUsN0Ob2VJgYZ06FmpmNdvL3zZyYeJ
	9X/51qtkxZBiPpuck++F8PCT3Q4g1vfQPe+Kpl2Xj1o3m5NBTxy2YP7FpBlDmrlU
	Cz1HMzZHMxDLzdMwmZySYSLflJAOpTeTKBn+B6op1nHIM4BGXmMjkKl3YFRNpp18
	lX6JZ5lTzJjQNRHTh0BYxvB3FLrh4OIvkuQ4CySngtlHMkV6H2cZxIbzvem1rFhs
	f0Tm2yd9OcNSehsB737YXYoN7eCKfyzBNuIuM3Z0BELlkSbhRj2p4bNLKcTwiU8x
	OJ2HadKVzIUMdBMrDqV6w==
X-ME-Sender: <xms:P1GGZzqDPviTDG5zki7edTCvoaf8v6k1DRrJqNRDe7n_qnIHMAivXg>
    <xme:P1GGZ9oX8mkkUdcN26udLZlTj6-aN9Yyt_NXt9liqQfshdUtdXU3pTs7BHf4y3rL0
    XD1wIfVuu-EQcmeuA>
X-ME-Received: <xmr:P1GGZwNc2p1eAU_pJtB9Zf_m6yw_rrsk-ITyl-bVYFRSoWRbBgZL3Ms1bGVFzAMwXVRqW5nAZkLHe-5VBf0V64sT7zitKziFpRHqDpSYZGtsUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:P1GGZ25LSxYV1mCS9WFbgbLcDgmtdJkivZmKIDCdfeLGhtKo56A9Aw>
    <xmx:P1GGZy62f03aqDw0c0y2UtAuH8TdHmDuq0tiIFMn1Vl2iVOqSepSfA>
    <xmx:P1GGZ-iBXBTgoXIgzqJjgv03jUN5SgzgqRUx6xG01IBbnGX-zAyZpw>
    <xmx:P1GGZ05RlyyAskcoFVbFVXLGZkwg5XF4aMKGDWlTuDPHjdy-sPNdnA>
    <xmx:P1GGZyEbDvMCkz6ABnYrE15hcP-0q4tpbJyAIA_lWtBlUJuso5tPEPKg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5777c9e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:47 +0100
Subject: [PATCH v2 06/10] compat/zlib: provide stubs for
 `deflateSetHeader()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-6-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The function `deflateSetHeader()` has been introduce with zlib v1.2.2.1,
so we don't use it when linking against an older version of it. Refactor
the code to instead provide a central stub via "compat/zlib.h" so that
we can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c        |  4 ----
 compat/zlib-compat.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e7b3489e1e6c826d8128cddb0c5be04042a65cec..0edf13fba7568b3950978a05a2f50299bb9b2f18 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -473,9 +473,7 @@ static const char internal_gzip_command[] = "git archive gzip";
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
-#if ZLIB_VERNUM >= 0x1221
 	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
-#endif
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
 	int r;
@@ -486,10 +484,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block = tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >= 0x1221
 		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
 			BUG("deflateSetHeader() called too late");
-#endif
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 96a08811a98ff7fa057f5682a5303a06cef40cd1..2690bfce41caab2e9af7a09663d620f0ee5136a0 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,4 +7,17 @@
 # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+#if ZLIB_VERNUM < 0x1221
+struct gz_header_s {
+	int os;
+};
+
+static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
+{
+	(void)(strm);
+	(void)(head);
+	return Z_OK;
+}
+#endif
+
 #endif /* COMPAT_ZLIB_H */

-- 
2.48.0.257.gd3603152ad.dirty

