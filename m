Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715A1FF1D7
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124062; cv=none; b=LJggFqRB5lhRlEh5etXYPY06OxFXpVjpXLlxPg62nfQ/2so3QdVYrBRHxK/zLUmWtMRoPJKpMN7YFfZXxFSFLX8kb2GzRmb9N16PDJ7i6PUDiuYoR1/8806zEDSkQ0gyCmuTOy3BEz/+i5GVFqUquCEToQtYbWklptl2xCf8Yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124062; c=relaxed/simple;
	bh=+ysoJuvy9q8CZkmQXm5EfxfuSdl3DTYbGmu8sJs1QFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kon09qy2BHP7YeZMS2bl3ux1QZlfoS5WJd9Lwqk0DlzAFbJ8SEKS4JUKS9PLr1iUv9xl27bef+5v7O9p+4VW9M/Rf9IvrDxGWFp3acmDK8eMNsfHbD3wgN28wfSAvyGR02HZgXTg2wtqbmvFHRkz8Yx+8qwvRLrJqnd7R7NHcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o1LLpQ7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ib6OCh/g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o1LLpQ7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ib6OCh/g"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1198D254021B
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 21 Feb 2025 02:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124059;
	 x=1740210459; bh=I3omu+fjqtWij6RHYRNB4lOSpNC80UBe0SG4OXpPo4o=; b=
	o1LLpQ7MoP8rmmi0UqhDuAxGLd7xT4nnxH0lCchfq9WtU/gwSHDb0X4j2Q3D4oou
	QS2EhYumcgkSmAB+F4DiowrCb0i+sHnPOCbogyuUq+vNiXmws3ZtxkiF0DkINQ34
	ypzl/Ix24f7X1qMgX07H174zwVYoNpUtnASkqP6O07qUGCtD/0R1tyMZRRMZqwEr
	8VYV7JwKy7NwFhN0rQq+KmtjuTfhlwUn9VcVUOn8jYAjVm5qwxIKUz+4Z1AkqFbM
	fvK/JH0Vetpm+25DnuwJ8OJ9nPb0UQMsH9S+Sntfmjw1NSGzLIqEEPt1HVaTOr4L
	sHg4FOKiGNEbLzuKQxjmhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124059; x=
	1740210459; bh=I3omu+fjqtWij6RHYRNB4lOSpNC80UBe0SG4OXpPo4o=; b=I
	b6OCh/gZ0PwOhVIchcywI3zjvYRXUDTkcPMh/w8ldPAD6K+uuHBIG4P6WEsrUS2/
	K0knW/f//lIllxFe5Rixbhnpyx1UD7JlE/Fv6T0Ho5nqN1DzZbISmxvWcFFF0RNT
	OXCvgz86ngxxZS2ICu2gFRTLT19LcJSiyIPMWai26jnIi1U7MD/qsk955prYUjq5
	JDpCGxsfqDYu9lmeCTSTn3fgt4LwesyBrp384Mt3KdsaizVEi3llgiGFa+I7TAhK
	i7j2AQhxWRGxX0Y5M3yURxefNooTRNPxAxW/6h8zMOyIhhtVkHxU8dmX3PYzwrae
	PAEc+PO4It2Lbfc+AXmMg==
X-ME-Sender: <xms:my-4Z6SMyem11ot7jBuDVgpSV8nX1Viyi_UEkL6_Lrk8RYyZoO8n-g>
    <xme:my-4Z_xVUsauxf7qXY8RXE7g6oiegphhyzytZQ2rIEf8yhA1PfEmEzE9C72lYr_yc
    WmuitzR5dczxY0uqw>
X-ME-Received: <xmr:my-4Z31c_y1AJ0Pqkc_h7dFE2jeeqeDZQfTVdDZAV2rkJx0AqbgOG2tpaX6P7Dk1nmcBwuKkpbSqZAiLmjxBPuD6RYIaHbPvGYRx2khbyMZskA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:my-4Z2Ab8vDRn_wFufGvkNoBEADzSobcBemrayTFBaitg3fk0RgpmA>
    <xmx:my-4ZziscdQDZJlIxAn8eK0rG2ojJos7-k-5CKdRhnre0WofeegWQQ>
    <xmx:my-4ZypAp2lek9fKXd8RtwPU4TDjI5vEKTQOk5NumDDXtQfOn3zC5w>
    <xmx:my-4Z2ifMUXXwlOm5K3f-xwfhrbxdi6Yqum4CuT5OR_o5LuR_3r9ug>
    <xmx:my-4Z7YybR4EenTA8UKDJDqDlD6vXENQMF7vT1Lu5Cj6Y44WsTy-vdc3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45436f77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:33 +0100
Subject: [PATCH 8/9] builtin/cat-file: deduplicate logic to iterate over
 all objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-8-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Pull out a common function that allows us to iterate over all objects in
a repository. Right now the logic is trivial and would only require two
function calls, making this refactoring a bit pointless. But in the next
commit we will iterate on this logic to make use of bitmaps, so this is
about to become a bit more complex.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 85 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b374c2bb104..25d5429e391 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -622,25 +622,18 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 	return 0;
 }
 
-static int collect_loose_object(const struct object_id *oid,
-				const char *path UNUSED,
-				void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
-static int collect_packed_object(const struct object_id *oid,
-				 struct packed_git *pack UNUSED,
-				 uint32_t pos UNUSED,
-				 void *data)
+static int collect_object(const struct object_id *oid,
+			  struct packed_git *pack UNUSED,
+			  off_t offset UNUSED,
+			  void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
 }
 
 static int batch_unordered_object(const struct object_id *oid,
-				  struct packed_git *pack, off_t offset,
+				  struct packed_git *pack,
+				  off_t offset,
 				  void *vdata)
 {
 	struct object_cb_data *data = vdata;
@@ -654,23 +647,6 @@ static int batch_unordered_object(const struct object_id *oid,
 	return 0;
 }
 
-static int batch_unordered_loose(const struct object_id *oid,
-				 const char *path UNUSED,
-				 void *data)
-{
-	return batch_unordered_object(oid, NULL, 0, data);
-}
-
-static int batch_unordered_packed(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data)
-{
-	return batch_unordered_object(oid, pack,
-				      nth_packed_object_offset(pack, pos),
-				      data);
-}
-
 typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
 			       struct strbuf *, struct expand_data *);
 
@@ -803,6 +779,45 @@ static void batch_objects_command(struct batch_options *opt,
 
 #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
 
+typedef int (*for_each_object_fn)(const struct object_id *oid, struct packed_git *pack,
+				  off_t offset, void *data);
+
+struct for_each_object_payload {
+	for_each_object_fn callback;
+	void *payload;
+};
+
+static int batch_one_object_loose(const struct object_id *oid,
+				  const char *path UNUSED,
+				  void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, NULL, 0, payload->payload);
+}
+
+static int batch_one_object_packed(const struct object_id *oid,
+				   struct packed_git *pack,
+				   uint32_t pos,
+				   void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
+				 payload->payload);
+}
+
+static void batch_each_object(for_each_object_fn callback,
+			      unsigned flags,
+			      void *_payload)
+{
+	struct for_each_object_payload payload = {
+		.callback = callback,
+		.payload = _payload,
+	};
+	for_each_loose_object(batch_one_object_loose, &payload, 0);
+	for_each_packed_object(the_repository, batch_one_object_packed,
+			       &payload, flags);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -857,18 +872,14 @@ static int batch_objects(struct batch_options *opt)
 
 			cb.seen = &seen;
 
-			for_each_loose_object(batch_unordered_loose, &cb, 0);
-			for_each_packed_object(the_repository, batch_unordered_packed,
-					       &cb, FOR_EACH_OBJECT_PACK_ORDER);
+			batch_each_object(batch_unordered_object,
+					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
 
 			oidset_clear(&seen);
 		} else {
 			struct oid_array sa = OID_ARRAY_INIT;
 
-			for_each_loose_object(collect_loose_object, &sa, 0);
-			for_each_packed_object(the_repository, collect_packed_object,
-					       &sa, 0);
-
+			batch_each_object(collect_object, 0, &sa);
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
 			oid_array_clear(&sa);

-- 
2.48.1.683.gf705b3209c.dirty

