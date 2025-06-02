Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DA1FBE83
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860048; cv=none; b=ro2GOO2prmxP/Rer0RPiBmtuyotY9Vx9CeuwrlDUo+CJ4/D7F2tDSHy/CSt9w553NALu21sHnbUj7nP7zUQvlt2fTiFPVOOuhy+UAni46pihsxXZW1AwgfbxXm4YhDhKeSE5pCCHn62lcPGJo3Um/IoAw0Qle1180MfQLei4SH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860048; c=relaxed/simple;
	bh=2CV3jQOagXVsyk8V1yPRwDrOtNoqyFDvqkUN6m8KldE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLu0+RlZJwAVoj+hE8UTRsqy0mUEwkUHzbxQWXLk3WITN3hXX+Dcc2nFeXFYIwuVqtqsDF6PQMpG7iMZ+Pw+TDHYC0rtikfswia6byvHKfacTBia9alqSunyLBxyUoTZVMcFs+sGYFPehEn6Weg7eOcFKdyDQa74KCNB9ammc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hhJizJ/S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmINkTwp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hhJizJ/S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmINkTwp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED5DB2540130;
	Mon,  2 Jun 2025 06:27:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 06:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860045;
	 x=1748946445; bh=5bJaJHoVikWurR1vF3KFJGeIVcZWuWF9VNmJShRN0ik=; b=
	hhJizJ/S4aOJP8OKGQUE7EMQ8gfv3dhNGUSewLUpM0p2zC93dJVdHK32MrEujVTp
	8GWkumiPK/WZKNH6DwxfDB3SrqDZavU8CSMkXx5FKfFPQEyBD0Y/3PVE8nHNK/jp
	tL/Zg/MjbpK4WsER4S1uJIxRtqA05dLKGKlT3DElrQ9kO6yKYWP9Bh6a1i0jc0TA
	E4zC9/2o8g9qaVRZwTs0jDtV8L8BZ4L+MrB3AfFebF+KinBVcrAHsaAiOMwo16px
	k0mxJ2Q78eQeOK2M2jbLVcbT4uo/ODpXTEab66VSpaPPdYCUldRX1/u/F2/I/jRX
	DyDmhZ5w3ZzfB0epFeYnrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860045; x=
	1748946445; bh=5bJaJHoVikWurR1vF3KFJGeIVcZWuWF9VNmJShRN0ik=; b=n
	mINkTwpX5B2MVoif8Sj6mlgeEUP4jf02ewn6BDcal9G9t5dqu0/lO9pDpujktaT3
	Z8zWfcdgvJaK6A7951tIfHIM/0FmcQgZrSbiEJXrrbG2/BnO+aqoluRsila+z/Fn
	ywsOI9SfnhogDPeLV04U6NDcSLZn/jaju6xlEHxR8iE3+BSTHwvZUvSlOvLqU8aV
	D8Wio/l5FfJTAsv9IAflHdHZ0miySXOAsYUKFJTlVu7bypLaRv0eDoIqhm6hLwr5
	wH3ZjN6ixdu2kkVuQ6dY7jjcVQfV+iEAhExYrJl1gGqYz/nlr/kqSQoQ6AaKFH8R
	v0bMprVMDVZT0eukCEG2w==
X-ME-Sender: <xms:jXw9aKPtL29T8-e3l4FFkNVooNSgsN3W2qvF0pQzldB1L9kyi2qtbg>
    <xme:jXw9aI-8IhssoKBEYNokNHnR1ApliZ3Seleul_FCFAbZpccSkXCEvTsW1l3bSMawu
    Vpo_hANjdkLlM2b1g>
X-ME-Received: <xmr:jXw9aBQbZ5AjtAAk90Y7CGmZn5gCXVGl98OzJjzLrTYHVRmqOFLF3UoRgiT-t6zLiKt27P1gXDohkZviya0mAHyk4ABzK35iNfnsG8UE8X_vog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:jXw9aKvrjbGkeCSe1FnlnND3YfU1yL2_CWXTPR2G3xv21LQeDhKZ3g>
    <xmx:jXw9aCe-EOPRDTylse_s8Ojd_6NxNwCqrPbfHxemXKn4HaTDY7vT2A>
    <xmx:jXw9aO2c0le3xQCxrg36-Vmz3nzY91x4A0oDgmEWug-FAhX6PSHKyA>
    <xmx:jXw9aG9Qw0C4pqDmPTMAo-_ULB825JHdTJhIZwmJwQBrzZjOO24BRg>
    <xmx:jXw9aEA4KBNPvRXIrpdTBWoosEAcFV7pzNWSH1MeElwNS4tcK_sBCGpW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1572be8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:07 +0200
Subject: [PATCH v4 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-6-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `assert_oid_type()` by
passing in the object database as a parameter and adjusting all callers.

Rename the function to `odb_assert_oid_type()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-tree.c | 2 +-
 commit.c              | 2 +-
 odb.c                 | 5 +++--
 odb.h                 | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 546069f8682..31cfd9bd15d 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -48,7 +48,7 @@ static int parse_parent_arg_callback(const struct option *opt,
 	if (repo_get_oid_commit(the_repository, arg, &oid))
 		die(_("not a valid object name %s"), arg);
 
-	assert_oid_type(&oid, OBJ_COMMIT);
+	odb_assert_oid_type(the_repository->objects, &oid, OBJ_COMMIT);
 	new_parent(lookup_commit(the_repository, &oid), parents);
 	return 0;
 }
diff --git a/commit.c b/commit.c
index 1d30f8ce15a..aa65183d8b6 100644
--- a/commit.c
+++ b/commit.c
@@ -1706,7 +1706,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	assert_oid_type(tree, OBJ_TREE);
+	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
 	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
diff --git a/odb.c b/odb.c
index 483b9b38414..3a3ceed5508 100644
--- a/odb.c
+++ b/odb.c
@@ -946,9 +946,10 @@ int has_object(struct repository *r, const struct object_id *oid,
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect)
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	enum object_type type = oid_object_info(odb->repo, oid, NULL);
 	if (type < 0)
 		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
diff --git a/odb.h b/odb.h
index a9e802f5831..7b64358d678 100644
--- a/odb.h
+++ b/odb.h
@@ -302,7 +302,8 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

