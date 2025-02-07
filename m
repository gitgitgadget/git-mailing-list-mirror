Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CB1E04AE
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929139; cv=none; b=Msrid6cX9jNaKXDK6qvzbKot8wxYefJmnnUDbD2GNa+z28EVI0nNaxg/+2Bjut5I9T9bi3RizzH31ojDcXyP9trCAsaE0Cur4aRqRSPlha+/WqT/MhRXot1uSY9jFemOCUaxeqR6ASV23ouSkgzQoxrZrPbkrDtXYu/ZUcYG+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929139; c=relaxed/simple;
	bh=U2Vhsoxu1LFLXCm8YsuXM7KkoMNbAV29TjYndfPvVAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txMQ4U3Pe2fJjmpUqlqrUAg5adKfjEHR42COBN76oV2GgmivoDtF8HwkaplXBogHCizk7UsQmpWRkfIvDHfoqwZJa5zk2LqR4EAJU42J3msmDrcBLTpLiB8wce/Q0MNIsLd0IIzSjXsMip9Js89meKvmxM3tVdFd4HIzStlYvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GikCAkq6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8nKzJmn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GikCAkq6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8nKzJmn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23FE711400F8;
	Fri,  7 Feb 2025 06:52:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929137;
	 x=1739015537; bh=xKjvrxGaBaDgi1/zS8y2h9vrnaEd4qCZUC/EGlL5EBc=; b=
	GikCAkq6KwHMxCaVoWL75M2IucjCQ18LHK0gHF+LxxycF8uw6xwiradCPEl+wMt6
	Bn09kqmG6U+PHFtECLltPjr67etFeDJjPSjYiENb3UaGyfRLGn3hEvmYODjTgfbk
	fnMmBnDNb6P2FI3GWurxTZgk6K049WsFTS3fuOo0uKXHoDU8/jMsmpyidtJSOVd7
	yqdSprmPS/hHxPWaNt2EmD/TOiL3nVx2EbeXLncR1NQAAJPwSuhI4+hqhZalZKUJ
	TJwuyg7KvCjktun9Dvg3wA66X3p33c75MeW0KpXfxSie3nxLXX9lzoMqQBp/rx1d
	ZI9+b5rdMzc26FRzUEzIgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929137; x=
	1739015537; bh=xKjvrxGaBaDgi1/zS8y2h9vrnaEd4qCZUC/EGlL5EBc=; b=a
	8nKzJmnUvfQ1sKMYp6Wq67pyxt825Xqtm0sJeTnTsv80mq+p9ybzNEc3IfepWnNs
	uJBGrnBQBLY2M82xd829MxBOFLaN+ogPAN4owYP5gZn7ejvP7TaEmIjH3NmcDybt
	HsNxdZ+vOhz2p4tDabdRLaErDjUWi7BrnpyruHRmjXP37B7p+PRR7h29SCTLlAeJ
	bCFPNAv0LMkDGI2509g5A6X49FfzjtX9ab43JPctuh0f22W6+Pkeu/uIkiywQB/8
	5kCby4+xxLeBc5zIcuV8F6FCnQKWzdcuojlsJm5JHpEIKKAv3kYKzsaQ6gzjmMpB
	Q4g1QcWDqzwox+r4Wslyw==
X-ME-Sender: <xms:8POlZyhZdg6MInUbYRWyyU3GO39LiDrlPCroVvu6ys1LJBWliOVwAQ>
    <xme:8POlZzACVKXAzKMm2eA0fYF6P6RieRMw1wJKNZbEPiMzPh6maiwVOy0vzaQiQfd6y
    2cgUGmyDe7pdOQeKA>
X-ME-Received: <xmr:8POlZ6FmXHrnG2AZgTQTqHdEsNAqmoZuBsz_SX10R6eDcOJMdK4PXocNNVlop0c4iLIeF79YUPRAf_fzfZSMkjH3pDjLo-vv3M_SFIphuUSaOBJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:8POlZ7TE25w_c6-JTZg9sqYr-NDVoNwiouiKOE9X5wxZst_iQ65fMg>
    <xmx:8fOlZ_w8gOb2zd9UChFwOPtFUVPi9zUP2CRCwyS_flaiZKGhsCrhJA>
    <xmx:8fOlZ577mpwH-8VW2FpOha-IoyaBMgwAyKhfUeu-qUWdmfcsZNiWQA>
    <xmx:8fOlZ8ynUlh6bWopIGCtcrvdURK9FBWKE1YSc1DkcK2-L-frwR204Q>
    <xmx:8fOlZ2lYTKrAA0k2wsA3fLHVaIbLhvugoQey_OryDdajOrmOeKgsYhRJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0689193d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:09 +0100
Subject: [PATCH v5 14/18] reftable/basics: introduce `REFTABLE_UNUSED`
 annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-14-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Introduce the `REFTABLE_UNUSED` annotation and replace all existing
users of `UNUSED` in the reftable library to use the new macro instead.

Note that we unconditionally define `MAYBE_UNUSED` in the exact same
way, so doing so unconditionally for `REFTABLE_UNUSED` should be fine,
too.

Suggested-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h      |  2 ++
 reftable/blocksource.c |  6 +++---
 reftable/iter.c        | 10 +++++-----
 reftable/record.c      | 26 +++++++++++++-------------
 reftable/writer.c      |  2 +-
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 59000798f0..fd59cbb772 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,6 +16,8 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-basics.h"
 
+#define REFTABLE_UNUSED __attribute__((__unused__))
+
 struct reftable_buf {
 	size_t alloc;
 	size_t len;
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 02972c46f4..78c1be2337 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,14 +13,14 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void reftable_buf_return_block(void *b UNUSED, struct reftable_block *dest)
+static void reftable_buf_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void reftable_buf_close(void *b UNUSED)
+static void reftable_buf_close(void *b REFTABLE_UNUSED)
 {
 }
 
@@ -67,7 +67,7 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b UNUSED, struct reftable_block *dest UNUSED)
+static void file_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest REFTABLE_UNUSED)
 {
 }
 
diff --git a/reftable/iter.c b/reftable/iter.c
index b2ffb09c16..f520382e70 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -25,17 +25,17 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
 	return it->ops->next(it->iter_arg, rec);
 }
 
-static int empty_iterator_seek(void *arg UNUSED, struct reftable_record *want UNUSED)
+static int empty_iterator_seek(void *arg REFTABLE_UNUSED, struct reftable_record *want REFTABLE_UNUSED)
 {
 	return 0;
 }
 
-static int empty_iterator_next(void *arg UNUSED, struct reftable_record *rec UNUSED)
+static int empty_iterator_next(void *arg REFTABLE_UNUSED, struct reftable_record *rec REFTABLE_UNUSED)
 {
 	return 1;
 }
 
-static void empty_iterator_close(void *arg UNUSED)
+static void empty_iterator_close(void *arg REFTABLE_UNUSED)
 {
 }
 
@@ -143,8 +143,8 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	return 0;
 }
 
-static int indexed_table_ref_iter_seek(void *p UNUSED,
-				       struct reftable_record *want UNUSED)
+static int indexed_table_ref_iter_seek(void *p REFTABLE_UNUSED,
+				       struct reftable_record *want REFTABLE_UNUSED)
 {
 	return REFTABLE_API_ERROR;
 }
diff --git a/reftable/record.c b/reftable/record.c
index 9a1edf39a0..142853d507 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -490,7 +490,7 @@ static void reftable_obj_record_release(void *rec)
 }
 
 static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					 uint32_t hash_size UNUSED)
+					 uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
 	const struct reftable_obj_record *src = src_rec;
@@ -528,7 +528,7 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
 }
 
 static int reftable_obj_record_encode(const void *rec, struct string_view s,
-				      uint32_t hash_size UNUSED)
+				      uint32_t hash_size REFTABLE_UNUSED)
 {
 	const struct reftable_obj_record *r = rec;
 	struct string_view start = s;
@@ -563,8 +563,8 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      uint32_t hash_size UNUSED,
-				      struct reftable_buf *scratch UNUSED)
+				      uint32_t hash_size REFTABLE_UNUSED,
+				      struct reftable_buf *scratch REFTABLE_UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -618,13 +618,13 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	return start.len - in.len;
 }
 
-static int not_a_deletion(const void *p UNUSED)
+static int not_a_deletion(const void *p REFTABLE_UNUSED)
 {
 	return 0;
 }
 
 static int reftable_obj_record_equal_void(const void *a, const void *b,
-					  uint32_t hash_size UNUSED)
+					  uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
 	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
@@ -1054,7 +1054,7 @@ static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
-					   uint32_t hash_size UNUSED)
+					   uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -1075,13 +1075,13 @@ static void reftable_index_record_release(void *rec)
 	reftable_buf_release(&idx->last_key);
 }
 
-static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
+static uint8_t reftable_index_record_val_type(const void *rec REFTABLE_UNUSED)
 {
 	return 0;
 }
 
 static int reftable_index_record_encode(const void *rec, struct string_view out,
-					uint32_t hash_size UNUSED)
+					uint32_t hash_size REFTABLE_UNUSED)
 {
 	const struct reftable_index_record *r =
 		(const struct reftable_index_record *)rec;
@@ -1097,10 +1097,10 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 }
 
 static int reftable_index_record_decode(void *rec, struct reftable_buf key,
-					uint8_t val_type UNUSED,
+					uint8_t val_type REFTABLE_UNUSED,
 					struct string_view in,
-					uint32_t hash_size UNUSED,
-					struct reftable_buf *scratch UNUSED)
+					uint32_t hash_size REFTABLE_UNUSED,
+					struct reftable_buf *scratch REFTABLE_UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
@@ -1120,7 +1120,7 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 }
 
 static int reftable_index_record_equal(const void *a, const void *b,
-				       uint32_t hash_size UNUSED)
+				       uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
diff --git a/reftable/writer.c b/reftable/writer.c
index 5961698311..bb00e89f53 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -636,7 +636,7 @@ static void write_object_record(void *void_arg, void *key)
 done:;
 }
 
-static void object_record_free(void *void_arg UNUSED, void *key)
+static void object_record_free(void *void_arg REFTABLE_UNUSED, void *key)
 {
 	struct obj_index_tree_node *entry = key;
 

-- 
2.48.1.538.gc4cfc42d60.dirty

