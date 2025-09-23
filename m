Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8E320CBA
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622641; cv=none; b=K2GZbo1D974+AtRQgTI2oIru676T5/WQsGJNHn04rORJwMgqI5P6OLP/ihl/IxfRZoDfAJ54KGmsg4wi4RUO9Czqv8i21fXA9+AQKQDU/PV+RKaox7NvX4S/3L00lfPTRO81C0oL4Zq9VA0Bn+absjsd42klvyNzlCu6i1z/G8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622641; c=relaxed/simple;
	bh=b1Xn31Rv/M5Ne8i2lEFQV59UKjdn3ujFHue869HTdKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGKbpR7FTeRNsTheA58ezZgMMSFmA5kv1zQuEbvlhZ1SxJQDRKJEdfyQ6bxlTdAJosFyKe9RIBllsYmOuuqJcU2l2rEnMqvKvN/61ktzfJEdQKDzkrEtycklidZvKdoLCZ0HnEppnZHNcJumDn+hZjkUMZ96/OiY0CZb+yKKt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RjEnPc+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKApynKG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RjEnPc+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKApynKG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 944031D002D0;
	Tue, 23 Sep 2025 06:17:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 06:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622638;
	 x=1758709038; bh=ANDNMfc+zHdqW2U8oWez1X3PzA0xFXB9h/DdVW5Alj0=; b=
	RjEnPc+SL9GEJJcezn+wpO7QDtOJaYiS1P1HgpZEVZlDgNKGyyiEUbhmuQJZCZ8J
	pfEc7YbMiX1o9jpcB4n8Yv/umxb81bUCodoylglK5GlG00RJj/DLCMU6mL8TxbVt
	4Kyi8sYN3d/QXL+uA+6PiDAtQwoZLvau6BL4roAbqJK3p1qjfvWVCSg/OiMahMXP
	Ay5PaC5LUVCyfhR6G9pNtrSMiYcQlkxR1jzDXxXTpDBtsGEsgR+6HtXClhh0xn1U
	YP+b7/nsusRrk2gV3251lJrPz9gOuedDbLpDR3dkicImhwBtc0OPo2qBTwZ4i2wK
	PfOcjhPgmFnpN9r7BG1+lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622638; x=
	1758709038; bh=ANDNMfc+zHdqW2U8oWez1X3PzA0xFXB9h/DdVW5Alj0=; b=K
	KApynKGOFwmctjH1WrO9JKalTbpEKTkwUx9YqKF2og4/u88kWno3yixHus9EPCYi
	ihyGn2eY2LrWPcD7XB55rSdSvh80sDrKddC84eibv2e5MIWN5ZEHaXih4c854bC6
	bAwP9q4xB1lsRujrv7yc1eyvi/R5Mnvc8YgsVd6jx8JzXyYyz1hM5qraxrRFStoA
	itc/wKydXPyTBGiY3A84ZTt4QhEzfh8IWAU3Ft9Hl8YvhslH+jKLua2b1zibFu1g
	1ycPj97X+GuibTolrHXTx/BGe+srSzYt4CG4D+tOjMm71j92eXyhObsZrdd/m3t8
	lj0RRCjjT6XRg1L9m2/kA==
X-ME-Sender: <xms:rnPSaOwqBTpnPtIA551Ra0PCVVqcy30bT6JmM0JiIk7xaO1emriPXA>
    <xme:rnPSaN-PxIlDwOcFtNTbnqHXbXjQxR0NgIUm-K9uzfGIKVaOtUvT8YV1a5gmAg--l
    R84EWtQDsIqGK0dHXI2KjMLjpDT-jtPcCEKNyhtOAQk4ef-2T8l>
X-ME-Received: <xmr:rnPSaKL2So7sGK8heMD39mK84Cm4uXRbW-Hhm4Wt_WH4L_sejKLUPCvuHALoh9F7zvlqh7ZMnGFEVJLPZsZes32jtFpQ66Ftmkoqjho-zJAR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:rnPSaLf-xaxtv_am_TR7dqCVJTUHIEW2qz0JjjmkdA3t4tDgWMvMAA>
    <xmx:rnPSaB-tT1yPER_FSsVtW2SlgkIPh0Nmfxd6FU5QEbMYBk7y-DtGLA>
    <xmx:rnPSaAqvOu1d5pKTM0iU7_a86mDheJD7Gs71EDD3DSX1JNjy9eSjzw>
    <xmx:rnPSaOD5f9JPhZr0jGRs5HoqIMJp-XAQTwsybZoj-VQm7LaIKste-A>
    <xmx:rnPSaAPlRuejXOgjNIl78vEYluPRU78qNy1v9igpDEL2bhRknm9o3qc5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3cebce4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:02 +0200
Subject: [PATCH v6 03/15] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-3-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly. While at it, convert the field into a boolean now
that we're allowed to use them in our code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 22a170b434..bf1b4d4677 100644
--- a/odb.h
+++ b/odb.h
@@ -169,12 +169,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index 36bc240107..f37557eac5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1038,7 +1038,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1060,7 +1060,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = false;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index d7ac8d24b4..cf81091175 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,12 @@ struct packfile_store {
 	 * the store.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
 };
 
 /*

-- 
2.51.0.536.g15c5d4f767.dirty

