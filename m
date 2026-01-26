Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6C32D438
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421104; cv=none; b=uz01mczdaz+h+Lss1VxR+oxZTve7JpdRva2mxvt47vIIy05HS/qrOa2gUIiGAsvlgPPXFb87hrkzdDTgU3CC7zjO5Mw2kvCdTJZskIN1y1f7bVRKwZqVLoCrA09YEocux+Y4T5OEhQL6r6iE2NtsLCDTKOpcp0XgOwIT7SHujf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421104; c=relaxed/simple;
	bh=+UQNlxx6q4xi539DO2oNcEX3NpAzc4mx+TS7b7/F1qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W09NABZCMY8t7V8/0ewAmhqCy20Qy+sQFN82gzey83ukS3CLDGSEWSha5EQRsBKx9j01raUawaCik3VQo+G7UmHO4VbcjPaEaCSTfRKOMvcAsgn4knRmldhbGNc1/bKj+EHTrKmMqbiEG7MCJxiOvbmK6/4uh78QzROdNj5Pl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jIZ4zuEZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=if9/DMpK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jIZ4zuEZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="if9/DMpK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D5991D00090;
	Mon, 26 Jan 2026 04:51:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 04:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421102;
	 x=1769507502; bh=92xtQ06N7NbORXdCcAZZN+Zhuj0iDNyQJDrxBdWPpqY=; b=
	jIZ4zuEZHxCh+N76g+8SM3+PkQlW0INcBXtR42NScbkishrOSkuDXjwU1lbQfnrO
	2EZQvNSxXU+G75r1ug+jdFeecVBIsT28mOvu28iTJC81wLPPWD5bWGB8yirIrNlJ
	cuS2nE0FHmgamndSkURlIWukTfdBKJhIbxQ/NpijgrKOsWmjwnc0NyVYyhgjBO5x
	bGZYpfA4sRl7QY0Q+Es0CjAJ/yaFS0bz4LmbhhwNoWwHW95amMeJecQ4ljOUWmCi
	A49iQ+ZvYtLsqgRRhJoDZOR0pjsTKAB4PrGBOF5osIcKAnF8GDrcdAjbWFJtnmB+
	kI6dnAFQbfDfoLXFiT/sgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421102; x=
	1769507502; bh=92xtQ06N7NbORXdCcAZZN+Zhuj0iDNyQJDrxBdWPpqY=; b=i
	f9/DMpK60eXSch5EI8Og1uhEulOmHQ0DWPWNXPQzaBsV6L2Lxcj5xiKzd+NiX5+J
	ksTn+jPUHrWG6xdKnu5wQ6/VEI3oKXspHLPnhqt6ID4oRTrZAxe5ac0y9ve4wVUt
	ljLBO3pp/AEr5z8llYgvHEaoRqZCac5hLoxAZFKryBbg7d17uwbxWMBQl+oACrK2
	rJPuRC+wVbs6Oi7kiSMVlc8mrq3/ENnNs7csXZw8NiW7HedljkhEKXm4YLpjU7C7
	CRKjdSutPa9vCpzehVcU9/3/GkoShpb4AbHEW/VOu07Gq+Lk/GX/ygNX/bDX0eXt
	4BS4PcE6CGWj5QXkwF2GQ==
X-ME-Sender: <xms:Ljl3aT_PLLwVM5P6DzbYpzN7rUiaMDhX85b2X8pPdCODs67cHLVnOw>
    <xme:Ljl3aWuYiXTCORTejE4St1EoE8PXM1mPJLka9txgJ2uhSZspcv9kF6GQR9bIPSpG6
    2bpm7H0B5SiTPKDwHpnjlMkLYdbRghK4ErrZiLaxQ6PlLmFCi4frg>
X-ME-Received: <xmr:Ljl3aWAVFPih_y_N-V9XEaTVb-yKcEc9ctTHAucAUtmmnUauSt9KuEfJoAf6Q8hJkGcgYnepXEfumt80YtCK0mkKRRM9uniUYDyFKs8iS7S_1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ljl3aeVnYXm0mc3FYUqIJoKOztKJSMH8f6B2y2NQ6hiHmdjWaMlmmg>
    <xmx:Ljl3aUAwLjywS5NsalqqQXoNN3h3f4FyzHg2CM7htZSEPgDHk6cZXg>
    <xmx:Ljl3aR9ZmmhlusHNFIaZ8fu6tQNS8qfzS9ZXECJt0SnzYSI7qfhDOA>
    <xmx:Ljl3abHfSMjD9du_PdOYBJ-ggpXwCt9N6LMGdII8-y4AG0QgoEDOUg>
    <xmx:Ljl3aZizQ3s-vgPxOt8LOSzKAwlCeL7b_q-yUcr_ad-wVV084yl_nCD1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60f97151 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:23 +0100
Subject: [PATCH v4 07/14] odb: introduce `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-7-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce a new function `odb_for_each_object()` that knows to iterate
through all objects part of a given object database. This function is
essentially a simple wrapper around the object database sources.

Subsequent commits will adapt callers to use this new function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h |  7 ++++---
 odb.c         | 29 +++++++++++++++++++++++++++++
 odb.h         | 20 ++++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/object-file.h b/object-file.h
index 5b9641cd89..b5eac0349e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -139,9 +139,10 @@ int for_each_loose_object(struct object_database *odb,
 
 /*
  * Iterate through all loose objects in the given object database source and
- * invoke the callback function for each of them. If given, the object info
- * will be populated with the object's data as if you had called
- * `odb_source_loose_read_object_info()` on the object.
+ * invoke the callback function for each of them. If an object info request is
+ * given, then the object info will be read for every individual object and
+ * passed to the callback as if `odb_source_loose_read_object_info()` was
+ * called for the object.
  */
 int odb_source_loose_for_each_object(struct odb_source *source,
 				     const struct object_info *request,
diff --git a/odb.c b/odb.c
index ac70b6a099..13a415c2c3 100644
--- a/odb.c
+++ b/odb.c
@@ -995,6 +995,35 @@ int odb_freshen_object(struct object_database *odb,
 	return 0;
 }
 
+int odb_for_each_object(struct object_database *odb,
+			const struct object_info *request,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags)
+{
+	int ret;
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
+			continue;
+
+		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+			ret = odb_source_loose_for_each_object(source, request,
+							       cb, cb_data, flags);
+			if (ret)
+				return ret;
+		}
+
+		ret = packfile_store_for_each_object(source->packfiles, request,
+						     cb, cb_data, flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index f97f249580..b5d28bc188 100644
--- a/odb.h
+++ b/odb.h
@@ -475,6 +475,26 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 				      struct object_info *oi,
 				      void *cb_data);
 
+/*
+ * Iterate through all objects contained in the object database. Note that
+ * objects may be iterated over multiple times in case they are either stored
+ * in different backends or in case they are stored in multiple sources.
+ * If an object info request is given, then the object info will be read and
+ * passed to the callback as if `odb_read_object_info()` was called for the
+ * object.
+ *
+ * Returning a non-zero error code from the callback function will cause
+ * iteration to abort. The error code will be propagated.
+ *
+ * Returns 0 on success, a negative error code in case a failure occurred, or
+ * an arbitrary non-zero error code returned by the callback itself.
+ */
+int odb_for_each_object(struct object_database *odb,
+			const struct object_info *request,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags);
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

